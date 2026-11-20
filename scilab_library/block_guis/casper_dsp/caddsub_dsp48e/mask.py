import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from caddsub_dsp48e_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in caddsub_dsp48e_ui.py.
# The keys must match scilab_blocks/casper_dsp/caddsub_dsp48e.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
CADDSUB_DSP48E_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'mode':
    {
        'get': 'get_mode',
        'set': 'set_mode'
    },
    'n_bits_a':
    {
        'get': 'get_n_bits_a',
        'set': 'set_n_bits_a'
    },
    'bin_pt_a':
    {
        'get': 'get_bin_pt_a',
        'set': 'set_bin_pt_a'
    },
    'n_bits_b':
    {
        'get': 'get_n_bits_b',
        'set': 'set_n_bits_b'
    },
    'bin_pt_b':
    {
        'get': 'get_bin_pt_b',
        'set': 'set_bin_pt_b'
    },
    'full_precision':
    {
        'get': 'get_full_precision',
        'set': 'set_full_precision'
    },
    'n_bits_c':
    {
        'get': 'get_n_bits_c',
        'set': 'set_n_bits_c'
    },
    'bin_pt_c':
    {
        'get': 'get_bin_pt_c',
        'set': 'set_bin_pt_c'
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
    'cast_latency':
    {
        'get': 'get_cast_latency',
        'set': 'set_cast_latency'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class CaddsubDsp48eOperations(object):
    def __init__(self, winobj, template_config='caddsub_dsp48e.json', target_config='caddsub_dsp48e.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('caddsub_dsp48e.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('caddsub_dsp48e.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Complex Add/Sub (DSP48E) Mask started.')
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
    def get_mode(self):
        text = self.ui.mode.currentText()
        self.logger.debug(f'mode is {text}')
        return text

    def set_mode(self, text):
        self.logger.debug(f'Set mode to {text}')
        self.ui.mode.setCurrentText(str(text))

    def get_n_bits_a(self):
        val = self.ui.n_bits_a.value()
        self.logger.debug(f'n_bits_a is {val}')
        return str(val)

    def set_n_bits_a(self, val):
        self.logger.debug(f'Set n_bits_a to {val}')
        self.ui.n_bits_a.setValue(int(val))

    def get_bin_pt_a(self):
        val = self.ui.bin_pt_a.value()
        self.logger.debug(f'bin_pt_a is {val}')
        return str(val)

    def set_bin_pt_a(self, val):
        self.logger.debug(f'Set bin_pt_a to {val}')
        self.ui.bin_pt_a.setValue(int(val))

    def get_n_bits_b(self):
        val = self.ui.n_bits_b.value()
        self.logger.debug(f'n_bits_b is {val}')
        return str(val)

    def set_n_bits_b(self, val):
        self.logger.debug(f'Set n_bits_b to {val}')
        self.ui.n_bits_b.setValue(int(val))

    def get_bin_pt_b(self):
        val = self.ui.bin_pt_b.value()
        self.logger.debug(f'bin_pt_b is {val}')
        return str(val)

    def set_bin_pt_b(self, val):
        self.logger.debug(f'Set bin_pt_b to {val}')
        self.ui.bin_pt_b.setValue(int(val))

    def get_full_precision(self):
        status = self.ui.full_precision.isChecked()
        self.logger.debug(f'full_precision status is {status}')
        return self._convert_status(status)

    def set_full_precision(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set full_precision status to {status}')
        self.ui.full_precision.setChecked(status)

    def get_n_bits_c(self):
        val = self.ui.n_bits_c.value()
        self.logger.debug(f'n_bits_c is {val}')
        return str(val)

    def set_n_bits_c(self, val):
        self.logger.debug(f'Set n_bits_c to {val}')
        self.ui.n_bits_c.setValue(int(val))

    def get_bin_pt_c(self):
        val = self.ui.bin_pt_c.value()
        self.logger.debug(f'bin_pt_c is {val}')
        return str(val)

    def set_bin_pt_c(self, val):
        self.logger.debug(f'Set bin_pt_c to {val}')
        self.ui.bin_pt_c.setValue(int(val))

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

    def get_cast_latency(self):
        val = self.ui.cast_latency.value()
        self.logger.debug(f'cast_latency is {val}')
        return str(val)

    def set_cast_latency(self, val):
        self.logger.debug(f'Set cast_latency to {val}')
        self.ui.cast_latency.setValue(int(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rules ported from casper_library/caddsub_dsp48e_init.m.
        """
        errors = []
        n_bits_a = int(self.get_n_bits_a())
        bin_pt_a = int(self.get_bin_pt_a())
        n_bits_b = int(self.get_n_bits_b())
        bin_pt_b = int(self.get_bin_pt_b())
        if bin_pt_a > n_bits_a:
            errors.append("Input 'a' binary point cannot exceed bit width.")
        if bin_pt_b > n_bits_b:
            errors.append("Input 'b' binary point cannot exceed bit width.")
        if self.get_full_precision() == 'on':
            max_non_frac = max(n_bits_a - bin_pt_a, n_bits_b - bin_pt_b)
            max_bin_pt = max(bin_pt_a, bin_pt_b)
            n_bits_out = max_non_frac + max_bin_pt + 1
            if n_bits_out > 24:
                errors.append(f'Output bit width cannot exceed 24 bits real/imag. '
                              f'Current settings require {n_bits_out} bits.')
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
            if k in CADDSUB_DSP48E_CONFIG:
                setfunc = CADDSUB_DSP48E_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Complex Add/Sub (DSP48E) parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:caddsub_dsp48e'
        for k, v in CADDSUB_DSP48E_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Complex Add/Sub (DSP48E) Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='caddsub_dsp48e.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = CaddsubDsp48eOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
