import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from convert_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in convert_ui.py.
# The keys must match scilab_blocks/casper_dsp/convert.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
CONVERT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'n_bits_in':
    {
        'get': 'get_n_bits_in',
        'set': 'set_n_bits_in'
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
    'bin_pt_out':
    {
        'get': 'get_bin_pt_out',
        'set': 'set_bin_pt_out'
    },
    'quantization':
    {
        'get': 'get_quantization',
        'set': 'set_quantization'
    },
    'overflow':
    {
        'get': 'get_overflow',
        'set': 'set_overflow'
    },
    'csp_latency':
    {
        'get': 'get_csp_latency',
        'set': 'set_csp_latency'
    },
    'implementation':
    {
        'get': 'get_implementation',
        'set': 'set_implementation'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class ConvertOperations(object):
    def __init__(self, winobj, template_config='convert.json', target_config='convert.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('convert.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('convert.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Convert Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()

    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

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
    def get_n_bits_in(self):
        val = self.ui.n_bits_in.value()
        self.logger.debug(f'n_bits_in is {val}')
        return str(val)

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self.ui.n_bits_in.setValue(int(val))

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

    def get_bin_pt_out(self):
        val = self.ui.bin_pt_out.value()
        self.logger.debug(f'bin_pt_out is {val}')
        return str(val)

    def set_bin_pt_out(self, val):
        self.logger.debug(f'Set bin_pt_out to {val}')
        self.ui.bin_pt_out.setValue(int(val))

    def get_quantization(self):
        text = self.ui.quantization.currentText()
        self.logger.debug(f'quantization is {text}')
        return text

    def set_quantization(self, text):
        self.logger.debug(f'Set quantization to {text}')
        self.ui.quantization.setCurrentText(str(text))

    def get_overflow(self):
        text = self.ui.overflow.currentText()
        self.logger.debug(f'overflow is {text}')
        return text

    def set_overflow(self, text):
        self.logger.debug(f'Set overflow to {text}')
        self.ui.overflow.setCurrentText(str(text))

    def get_csp_latency(self):
        val = self.ui.csp_latency.value()
        self.logger.debug(f'csp_latency is {val}')
        return str(val)

    def set_csp_latency(self, val):
        self.logger.debug(f'Set csp_latency to {val}')
        self.ui.csp_latency.setValue(int(val))

    def get_implementation(self):
        text = self.ui.implementation.currentText()
        self.logger.debug(f'implementation is {text}')
        return text

    def set_implementation(self, text):
        self.logger.debug(f'Set implementation to {text}')
        self.ui.implementation.setCurrentText(str(text))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rule ported from casper_library/convert_init.m: upscaling of
        fractional bits (bin_pt_out > bin_pt_in) is not supported.
        """
        errors = []
        if int(self.get_bin_pt_out()) > int(self.get_bin_pt_in()):
            errors.append('Does not support upscaling of fractional bits '
                          '(Binary Point Out must not exceed Binary Point In).')
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
            if k in CONVERT_CONFIG:
                setfunc = CONVERT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Convert parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:convert'
        for k, v in CONVERT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Convert Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='convert.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = ConvertOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
