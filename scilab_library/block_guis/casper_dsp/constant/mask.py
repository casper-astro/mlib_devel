import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
import math
from constant_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in constant_ui.py.
# The keys must match scilab_blocks/casper_dsp/constant.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
CONSTANT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'const':
    {
        'get': 'get_const',
        'set': 'set_const'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
    },
    'n_bits':
    {
        'get': 'get_n_bits',
        'set': 'set_n_bits'
    },
    'bin_pt':
    {
        'get': 'get_bin_pt',
        'set': 'set_bin_pt'
    },
}

# constant.sv takes VAL as a 32-bit int, so NBITS > 32 is not supported
MAX_N_BITS = 32


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class ConstantOperations(object):
    def __init__(self, winobj, template_config='constant.json', target_config='constant.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('constant.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('constant.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Constant Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        # a stored n_bits the spin box cannot show (outside 1..MAX_N_BITS) is
        # remembered here and reported by validate_config() until it's changed,
        # instead of being silently clamped by the spin box
        self.bad_n_bits = None
        # same for a stored arith_type the combo box doesn't offer
        self.bad_arith_type = None
        self.load_config()
        self.setup_signal_functions()

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
    def get_const(self):
        val = self.ui.const.text()
        self.logger.debug(f'const is {val}')
        return val

    def set_const(self, val):
        self.logger.debug(f'Set const to {val}')
        self.ui.const.setText(str(val))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        if self.ui.arith_type.findText(str(text)) < 0:
            self.bad_arith_type = text
            self.logger.error(f'arith_type {text} not supported')
            return
        self.bad_arith_type = None
        self.ui.arith_type.setCurrentText(str(text))

    def get_n_bits(self):
        val = self.ui.n_bits.value()
        self.logger.debug(f'n_bits is {val}')
        return str(val)

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        try:
            n = int(float(val))
        except (TypeError, ValueError):
            n = None
        if n is None or n != float(val) or not 1 <= n <= MAX_N_BITS:
            self.bad_n_bits = val
            self.logger.error(f'n_bits {val} not supported (1..{MAX_N_BITS})')
            return
        self.bad_n_bits = None
        self.ui.n_bits.setValue(n)

    def get_bin_pt(self):
        val = self.ui.bin_pt.text()
        self.logger.debug(f'bin_pt is {val}')
        return val

    def set_bin_pt(self, val):
        self.logger.debug(f'Set bin_pt to {val}')
        self.ui.bin_pt.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        errors = []
        const = self.get_const().strip()
        if const == '':
            errors.append('Constant value must not be empty.')
        else:
            try:
                if not math.isfinite(float(const)):
                    errors.append('Constant value must be a finite real number.')
            except ValueError:
                errors.append('Constant value must be a real number (e.g. 1, -0.375, 1.5e-3).')
        if self.bad_arith_type is not None:
            errors.append(f'Arithmetic type {self.bad_arith_type} is not supported (Signed (2\'s comp) or Unsigned only).')
        if self.bad_n_bits is not None:
            errors.append(f'Number of bits ({self.bad_n_bits}) must be an integer from 1 to {MAX_N_BITS}.')
        n_bits = int(self.get_n_bits())
        if not 1 <= n_bits <= MAX_N_BITS:
            errors.append(f'Number of bits must be from 1 to {MAX_N_BITS}.')
        bin_pt = self.get_bin_pt().strip()
        if bin_pt == '':
            errors.append('Binary point must not be empty.')
        else:
            try:
                b = int(bin_pt)
            except ValueError:
                errors.append('Binary point must be an integer.')
            else:
                # (against the shown n_bits only once a stored bad one is replaced)
                if b < 0 or (self.bad_n_bits is None and b > n_bits):
                    errors.append(f'Binary point must be from 0 to the number of bits ({n_bits}).')
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

    def NBits_Changed(self):
        # the user picked a (valid) width, so a bad stored one is replaced
        self.bad_n_bits = None

    def ArithType_Changed(self):
        # the user picked a (valid) type, so a bad stored one is replaced
        self.bad_arith_type = None

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.n_bits.valueChanged.connect(self.NBits_Changed)
        self.ui.arith_type.currentIndexChanged.connect(self.ArithType_Changed)
        # activated also fires when the user re-picks the shown item
        self.ui.arith_type.activated.connect(self.ArithType_Changed)

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
            if k in CONSTANT_CONFIG:
                setfunc = CONSTANT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Constant parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:constant'
        for k, v in CONSTANT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)()).strip()
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Constant Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='constant.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = ConstantOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
