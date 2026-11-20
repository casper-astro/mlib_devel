import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from sbram_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in sbram_ui.py.
# The keys must match scilab_blocks/casper_xps/sbram.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
SBRAM_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
    },
    'addr_width':
    {
        'get': 'get_addr_width',
        'set': 'set_addr_width'
    },
    'data_width':
    {
        'get': 'get_data_width',
        'set': 'set_data_width'
    },
    'reg_prim_output':
    {
        'get': 'get_reg_prim_output',
        'set': 'set_reg_prim_output'
    },
    'reg_core_output':
    {
        'get': 'get_reg_core_output',
        'set': 'set_reg_core_output'
    },
    'optimization':
    {
        'get': 'get_optimization',
        'set': 'set_optimization'
    },
    'data_bin_pt':
    {
        'get': 'get_data_bin_pt',
        'set': 'set_data_bin_pt'
    },
    'init_vals':
    {
        'get': 'get_init_vals',
        'set': 'set_init_vals'
    },
    'sample_rate':
    {
        'get': 'get_sample_rate',
        'set': 'set_sample_rate'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class SbramOperations(object):
    def __init__(self, winobj, template_config='sbram.json', target_config='sbram.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('sbram.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('sbram.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Shared BRAM Mask started.')
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

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        self.ui.arith_type.setCurrentText(str(text))

    def get_addr_width(self):
        val = self.ui.addr_width.value()
        self.logger.debug(f'addr_width is {val}')
        return str(val)

    def set_addr_width(self, val):
        self.logger.debug(f'Set addr_width to {val}')
        self.ui.addr_width.setValue(int(val))

    def get_data_width(self):
        text = self.ui.data_width.currentText()
        self.logger.debug(f'data_width is {text}')
        return text

    def set_data_width(self, text):
        self.logger.debug(f'Set data_width to {text}')
        self.ui.data_width.setCurrentText(str(text))

    def get_reg_prim_output(self):
        status = self.ui.reg_prim_output.isChecked()
        self.logger.debug(f'reg_prim_output status is {status}')
        return self._convert_status(status)

    def set_reg_prim_output(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set reg_prim_output status to {status}')
        self.ui.reg_prim_output.setChecked(status)

    def get_reg_core_output(self):
        status = self.ui.reg_core_output.isChecked()
        self.logger.debug(f'reg_core_output status is {status}')
        return self._convert_status(status)

    def set_reg_core_output(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set reg_core_output status to {status}')
        self.ui.reg_core_output.setChecked(status)

    def get_optimization(self):
        text = self.ui.optimization.currentText()
        self.logger.debug(f'optimization is {text}')
        return text

    def set_optimization(self, text):
        self.logger.debug(f'Set optimization to {text}')
        self.ui.optimization.setCurrentText(str(text))

    def get_data_bin_pt(self):
        val = self.ui.data_bin_pt.text()
        self.logger.debug(f'data_bin_pt is {val}')
        return val

    def set_data_bin_pt(self, val):
        self.logger.debug(f'Set data_bin_pt to {val}')
        self.ui.data_bin_pt.setText(str(val))

    def get_init_vals(self):
        val = self.ui.init_vals.text()
        self.logger.debug(f'init_vals is {val}')
        return val

    def set_init_vals(self, val):
        self.logger.debug(f'Set init_vals to {val}')
        self.ui.init_vals.setText(str(val))

    def get_sample_rate(self):
        val = self.ui.sample_rate.text()
        self.logger.debug(f'sample_rate is {val}')
        return val

    def set_sample_rate(self, val):
        self.logger.debug(f'Set sample_rate to {val}')
        self.ui.sample_rate.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        TODO: this only checks that 'edit' fields are non-empty -- port over
        the real validation rules from casper_library's *_init.m /
        *_maskcheck.m for this block (see the skill's extracted mask info).
        """
        errors = []
        if str(self.get_data_bin_pt()).strip() == '':
            errors.append('Data Binary Point must not be empty.')
        if str(self.get_init_vals()).strip() == '':
            errors.append('Initial values (simulation only) must not be empty.')
        if str(self.get_sample_rate()).strip() == '':
            errors.append('Sample rate must not be empty.')
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
            if k in SBRAM_CONFIG:
                setfunc = SBRAM_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Shared BRAM parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:bram'
        for k, v in SBRAM_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Shared BRAM Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='sbram.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = SbramOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
