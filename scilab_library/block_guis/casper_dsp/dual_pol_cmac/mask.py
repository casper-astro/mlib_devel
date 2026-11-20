import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from dual_pol_cmac_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in dual_pol_cmac_ui.py.
# The keys must match scilab_blocks/casper_dsp/dual_pol_cmac.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
DUAL_POL_CMAC_CONFIG = {
    'acc_len':
    {
        'get': 'get_acc_len',
        'set': 'set_acc_len'
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
    'mult_latency':
    {
        'get': 'get_mult_latency',
        'set': 'set_mult_latency'
    },
    'add_latency':
    {
        'get': 'get_add_latency',
        'set': 'set_add_latency'
    },
    'multiplier_implementation':
    {
        'get': 'get_multiplier_implementation',
        'set': 'set_multiplier_implementation'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class DualPolCmacOperations(object):
    def __init__(self, winobj, template_config='dual_pol_cmac.json', target_config='dual_pol_cmac.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('dual_pol_cmac.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('dual_pol_cmac.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('dual_pol_cmac Mask started.')
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
    def get_acc_len(self):
        val = self.ui.acc_len.text()
        self.logger.debug(f'acc_len is {val}')
        return val

    def set_acc_len(self, val):
        self.logger.debug(f'Set acc_len to {val}')
        self.ui.acc_len.setText(str(val))

    def get_n_bits_in(self):
        val = self.ui.n_bits_in.text()
        self.logger.debug(f'n_bits_in is {val}')
        return val

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self.ui.n_bits_in.setText(str(val))

    def get_bin_pt_in(self):
        val = self.ui.bin_pt_in.text()
        self.logger.debug(f'bin_pt_in is {val}')
        return val

    def set_bin_pt_in(self, val):
        self.logger.debug(f'Set bin_pt_in to {val}')
        self.ui.bin_pt_in.setText(str(val))

    def get_mult_latency(self):
        val = self.ui.mult_latency.text()
        self.logger.debug(f'mult_latency is {val}')
        return val

    def set_mult_latency(self, val):
        self.logger.debug(f'Set mult_latency to {val}')
        self.ui.mult_latency.setText(str(val))

    def get_add_latency(self):
        val = self.ui.add_latency.text()
        self.logger.debug(f'add_latency is {val}')
        return val

    def set_add_latency(self, val):
        self.logger.debug(f'Set add_latency to {val}')
        self.ui.add_latency.setText(str(val))

    def get_multiplier_implementation(self):
        text = self.ui.multiplier_implementation.currentText()
        self.logger.debug(f'multiplier_implementation is {text}')
        return text

    def set_multiplier_implementation(self, text):
        self.logger.debug(f'Set multiplier_implementation to {text}')
        self.ui.multiplier_implementation.setCurrentText(str(text))


    # *******************************************************************
    # Validation
    # *******************************************************************
    @staticmethod
    def _parse_int(text, prompt, errors):
        """Parse an integer-valued edit field; append an error and return
        None if it is empty or not an integer (the HDL parameters are int)."""
        s = str(text).strip()
        if s == '':
            errors.append('%s must not be empty.' % prompt)
            return None
        try:
            f = float(s)
        except ValueError:
            errors.append('%s must be an integer (got %r).' % (prompt, s))
            return None
        if f != int(f):
            errors.append('%s must be an integer (got %r).' % (prompt, s))
            return None
        return int(f)

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Rules are the $fatal checks of the HDL backend
        (casper_dsp/rtl/Correlator/dual_pol_cmac.sv and the four cmac.sv /
        cmult.sv it instantiates), plus non-empty / integer checks on the
        edit fields. dual_pol_cmac has no _init.m/_maskcheck.m in
        casper_library. Every inner cmac gets n_bits_a = n_bits_b = n_bits_in
        and bin_pt_a = bin_pt_b = n_bits_in - 1, so cmac's constraint A and
        cmult's n_bits >= bin_pt always hold; bin_pt_in is not passed on
        (unused) and is only checked for being an integer.
        """
        errors = []
        acc_len = self._parse_int(self.get_acc_len(), "Number of accumulations", errors)
        n_bits_in = self._parse_int(self.get_n_bits_in(), "Number of bits in", errors)
        self._parse_int(self.get_bin_pt_in(), "Binary point in", errors)
        mult_latency = self._parse_int(self.get_mult_latency(), "Multiplier latency", errors)
        add_latency = self._parse_int(self.get_add_latency(), "Adder latency", errors)

        # cmac.sv: ACC_LEN >= 2
        if acc_len is not None and acc_len < 2:
            errors.append('Number of accumulations must be >= 2 '
                          '(ceil(log2(acc_len)) = 0 would give a 0-bit counter).')
        # cmac.sv: MULT_LATENCY + ADD_LATENCY >= 1
        if mult_latency is not None and add_latency is not None and mult_latency + add_latency < 1:
            errors.append('Multiplier latency + Adder latency must be >= 1 '
                          '(the sync delay is their sum - 1).')
        # cmult.sv: n_bits >= 1
        if n_bits_in is not None and n_bits_in < 1:
            errors.append('Number of bits in must be >= 1.')
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
            if k in DUAL_POL_CMAC_CONFIG:
                setfunc = DUAL_POL_CMAC_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid dual_pol_cmac parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:dual_pol_cmac'
        for k, v in DUAL_POL_CMAC_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for dual_pol_cmac Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='dual_pol_cmac.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = DualPolCmacOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
