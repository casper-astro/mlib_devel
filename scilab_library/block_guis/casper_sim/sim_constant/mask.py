import sys
import math
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from sim_constant_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in sim_constant_ui.py.
# The keys must match scilab_blocks/casper_sim/sim_constant.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
SIM_CONSTANT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'val':
    {
        'get': 'get_val',
        'set': 'set_val'
    },
    'bitwidth':
    {
        'get': 'get_bitwidth',
        'set': 'set_bitwidth'
    },
    'bin_pt':
    {
        'get': 'get_bin_pt',
        'set': 'set_bin_pt'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class SimConstantOperations(object):
    def __init__(self, winobj, template_config='sim_constant.json', target_config='sim_constant.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('sim_constant.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('sim_constant.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Constant (simulation) Mask started.')
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

    def get_val(self):
        val = self.ui.val.text()
        self.logger.debug(f'val is {val}')
        return val

    def set_val(self, val):
        self.logger.debug(f'Set val to {val}')
        self.ui.val.setText(str(val))

    def get_bitwidth(self):
        val = self.ui.bitwidth.value()
        self.logger.debug(f'bitwidth is {val}')
        return str(val)

    def set_bitwidth(self, val):
        self.logger.debug(f'Set bitwidth to {val}')
        self.ui.bitwidth.setValue(int(val))

    def get_bin_pt(self):
        val = self.ui.bin_pt.value()
        self.logger.debug(f'bin_pt is {val}')
        return str(val)

    def set_bin_pt(self, val):
        self.logger.debug(f'Set bin_pt to {val}')
        self.ui.bin_pt.setValue(int(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    @staticmethod
    def _number(text):
        """float(text), or None if text is not a finite number."""
        try:
            val = float(str(text).strip())
        except ValueError:
            return None
        return val if math.isfinite(val) else None

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Mirrors sim_blocks/constant.py: the word written is
        round(value * 2^bin_pt), two's complement when negative, and must
        fit in the number of bits.
        """
        errors = []
        if str(self.get_name()).strip() == '':
            errors.append('Block name must not be empty.')
        value = self._number(self.get_val())
        if value is None:
            errors.append('Constant value must be a number.')
        else:
            bits = int(self.get_bitwidth())
            word = round(value * 2**int(self.get_bin_pt()))
            if word < -2**(bits-1) or word >= 2**bits:
                errors.append(f'Constant value {self.get_val()} does not fit in {bits} bits '
                              f'with binary point {self.get_bin_pt()}.')
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
            if k in SIM_CONSTANT_CONFIG:
                setfunc = SIM_CONSTANT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Constant (simulation) parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'sim:constant'
        for k, v in SIM_CONSTANT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Constant (simulation) Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='sim_constant.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = SimConstantOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
