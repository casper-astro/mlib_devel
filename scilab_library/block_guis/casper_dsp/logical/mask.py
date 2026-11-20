import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from logical_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in logical_ui.py.
# The keys must match scilab_blocks/casper_dsp/logical.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
LOGICAL_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'logical_function':
    {
        'get': 'get_logical_function',
        'set': 'set_logical_function'
    },
    'inputs':
    {
        'get': 'get_inputs',
        'set': 'set_inputs'
    },
    'en':
    {
        'get': 'get_en',
        'set': 'set_en'
    },
    'latency':
    {
        'get': 'get_latency',
        'set': 'set_latency'
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


class LogicalOperations(object):
    def __init__(self, winobj, template_config='logical.json', target_config='logical.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('logical.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('logical.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Logical Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        # values found in the config file that the widgets cannot hold
        # (unknown function, out-of-range numbers); reported by validate_config
        self.load_errors = []
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

    def _set_spin(self, widget, val, label):
        # a QSpinBox silently clamps out-of-range values, so check first and
        # report anything it cannot hold instead of changing it unnoticed
        try:
            f = float(str(val).strip())
            ival = int(f)
            if ival != f:
                raise ValueError
        except ValueError:
            self.load_errors.append(f'{label} must be an integer (got {val!r}).')
            return
        if ival < widget.minimum() or ival > widget.maximum():
            self.load_errors.append(f'{label} must be between {widget.minimum()} and '
                                    f'{widget.maximum()} (got {ival}); it was set to the nearest '
                                    f'allowed value, please check it.')
        widget.setValue(ival)

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def get_logical_function(self):
        text = self.ui.logical_function.currentText()
        self.logger.debug(f'logical_function is {text}')
        return text

    def set_logical_function(self, text):
        self.logger.debug(f'Set logical_function to {text}')
        idx = self.ui.logical_function.findText(str(text).strip())
        if idx < 0:
            self.load_errors.append(f'Logical function {text!r} is not one of AND, NAND, OR, NOR, XOR, XNOR.')
            return
        self.ui.logical_function.setCurrentIndex(idx)

    def get_inputs(self):
        val = self.ui.inputs.value()
        self.logger.debug(f'inputs is {val}')
        return str(val)

    def set_inputs(self, val):
        self.logger.debug(f'Set inputs to {val}')
        self._set_spin(self.ui.inputs, val, 'Number of inputs')

    def get_en(self):
        status = self.ui.en.isChecked()
        self.logger.debug(f'en status is {status}')
        return self._convert_status(status)

    def set_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set en status to {status}')
        self.ui.en.setChecked(status)

    def get_latency(self):
        val = self.ui.latency.value()
        self.logger.debug(f'latency is {val}')
        return str(val)

    def set_latency(self, val):
        self.logger.debug(f'Set latency to {val}')
        self._set_spin(self.ui.latency, val, 'Latency')

    def get_n_bits_in(self):
        val = self.ui.n_bits_in.value()
        self.logger.debug(f'n_bits_in is {val}')
        return str(val)

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self._set_spin(self.ui.n_bits_in, val, 'Input/output width')

    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rules (logical.sv / Xilinx Logical): 2 <= inputs <= 1024 (logical.sv has
        no 1-input reduction), latency >= 0 and input width >= 1. As in
        Simulink the enable port may be used with latency 0, where it has no
        effect (logical.sv ignores en when LATENCY = 0).
        """
        errors = list(self.load_errors)
        if self.get_logical_function() not in ('AND', 'NAND', 'OR', 'NOR', 'XOR', 'XNOR'):
            errors.append('Logical function must be one of AND, NAND, OR, NOR, XOR, XNOR.')
        ninputs = self.ui.inputs.value()
        if ninputs < 2 or ninputs > 1024:
            errors.append('Number of inputs must be between 2 and 1024.')
        latency = self.ui.latency.value()
        if latency < 0:
            errors.append('Latency must be >= 0.')
        if self.ui.n_bits_in.value() < 1:
            errors.append('Input/output width must be >= 1.')
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
            if k in LOGICAL_CONFIG:
                setfunc = LOGICAL_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Logical parameters', chr(10).join(errors))
            # problems in the loaded file are reported once: the widgets now
            # hold allowed values the user has been asked to check
            self.load_errors = []
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
            config['parameters']['tag'] = 'dsp:logical'
        for k, v in LOGICAL_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Logical Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='logical.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = LogicalOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
