import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from dsp48e_bram_vacc_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in dsp48e_bram_vacc_ui.py.
# The keys must match scilab_blocks/casper_dsp/dsp48e_bram_vacc.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
DSP48E_BRAM_VACC_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'vec_len':
    {
        'get': 'get_vec_len',
        'set': 'set_vec_len'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
    },
    'bin_pt_in':
    {
        'get': 'get_bin_pt_in',
        'set': 'set_bin_pt_in'
    },
    'n_bits_out':
    {
        'get': 'get_n_bits_out',
        'set': 'set_n_bits_out'
    },
    'n_bits_in':
    {
        'get': 'get_n_bits_in',
        'set': 'set_n_bits_in'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class Dsp48eBramVaccOperations(object):
    def __init__(self, winobj, template_config='dsp48e_bram_vacc.json', target_config='dsp48e_bram_vacc.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('dsp48e_bram_vacc.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('dsp48e_bram_vacc.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('DSP48E BRAM Vector Accumulator Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()

    def _convert_status(self, status):
        # checkbox status is saved as 'on'/'off', same convention as the
        # Simulink mask and the *.json templates (see val_format_conv)
        if status is True:
            return 'on'
        elif status is False:
            return 'off'
        elif status in ['on', 1, '1']:
            return True
        elif status in ['off', 0, '0']:
            return False
        else:
            self.logger.error(f' Value({status}) not supported')
            raise ValueError(f'Value({status}) not supported')

    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def get_vec_len(self):
        val = self.ui.vec_len.text()
        self.logger.debug(f'vec_len is {val}')
        return val

    def set_vec_len(self, val):
        self.logger.debug(f'Set vec_len to {val}')
        self.ui.vec_len.setText(str(val))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        self.ui.arith_type.setCurrentText(str(text))

    def get_bin_pt_in(self):
        val = self.ui.bin_pt_in.value()
        self.logger.debug(f'bin_pt_in is {val}')
        return str(val)

    def set_bin_pt_in(self, val):
        self.logger.debug(f'Set bin_pt_in to {val}')
        self.ui.bin_pt_in.setValue(int(val))

    def get_n_bits_out(self):
        val = self.ui.n_bits_out.value()
        self.logger.debug(f'n_bits_out is {val}')
        return str(val)

    def set_n_bits_out(self, val):
        self.logger.debug(f'Set n_bits_out to {val}')
        self.ui.n_bits_out.setValue(int(val))

    def get_n_bits_in(self):
        val = self.ui.n_bits_in.value()
        self.logger.debug(f'n_bits_in is {val}')
        return str(val)

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self.ui.n_bits_in.setValue(int(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rules ported from casper_library/dsp48e_bram_vacc_init.m.
        """
        errors = []
        vec_len_str = str(self.get_vec_len()).strip()
        if vec_len_str == '':
            errors.append('Vector length: must not be empty.')
        else:
            try:
                vec_len = int(vec_len_str)
            except ValueError:
                errors.append('Vector length: must be an integer.')
            else:
                if vec_len < 6:
                    errors.append('Vector length: must be greater than 5.')
        bin_pt_in = int(self.get_bin_pt_in())
        n_bits_out = int(self.get_n_bits_out())
        if bin_pt_in < 0:
            errors.append('Binary point (input): must be non-negative.')
        if bin_pt_in > n_bits_out:
            errors.append('Binary point (input): cannot exceed output bit width.')
        if n_bits_out < 1:
            errors.append('Bit width (output): must be greater than 0.')
        if n_bits_out > 32:
            errors.append('Bit width (output): cannot exceed 32.')
        return errors

    # *******************************************************************
    # Signal functions
    # *******************************************************************
    def ButtonOK_Clicked(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Button OK clicked, collecting info...')
        self.logger.info('---------------------------------------------')
        if self.collect_config():
            self.winobj.close()

    def ButtonCancel_Clicked(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Button Cancel clicked...')
        self.logger.info('---------------------------------------------')
        self.winobj.close()

    def ButtonApply_Clicked(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Button Apply clicked, collecting info...')
        self.logger.info('---------------------------------------------')
        self.collect_config()

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)

    # *******************************************************************
    # load/collect config functions
    # *******************************************************************
    def load_config(self):
        self.logger.info('-------------------------------------------------')
        self.logger.info(f'Loading config from {self.target_config}...')
        self.logger.info('-------------------------------------------------')
        with open(self.target_config, 'r', encoding='utf-8') as f:
            config = json.load(f)
        parameters = config['parameters']
        for k, v in parameters.items():
            if k in DSP48E_BRAM_VACC_CONFIG:
                setfunc = DSP48E_BRAM_VACC_CONFIG[k]['set']
                getattr(self, setfunc)(v)

    def collect_config(self):
        """
        Write the config to the target file.
        Return False without writing anything if the config is invalid.
        """
        errors = self.validate_config()
        if errors:
            for e in errors:
                self.logger.error(e)
            QMessageBox.critical(self.winobj, 'Invalid DSP48E BRAM Vector Accumulator parameters', chr(10).join(errors))
            return False
        self.logger.info('-------------------------------------------------')
        self.logger.info(f'Writing config data to {self.target_config}...')
        self.logger.info('-------------------------------------------------')
        try:
            with open(self.target_config, 'r', encoding='utf-8') as f:
                config = json.load(f)
        except Exception:
            config = {}
            config['parameters'] = {}
            config['parameters']['name'] = ''
            config['parameters']['fullpath'] = ''
            config['parameters']['tag'] = 'dsp:dsp48e_bram_vacc'
        for k, v in DSP48E_BRAM_VACC_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for DSP48E BRAM Vector Accumulator Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='dsp48e_bram_vacc.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = Dsp48eBramVaccOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
