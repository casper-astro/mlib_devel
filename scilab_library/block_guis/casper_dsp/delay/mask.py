import sys
import logging
import json
import re
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from delay_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in delay_ui.py.
# The keys must match scilab_blocks/casper_dsp/delay.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
DELAY_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'latency':
    {
        'get': 'get_latency',
        'set': 'set_latency'
    },
    'rst':
    {
        'get': 'get_rst',
        'set': 'set_rst'
    },
    'en':
    {
        'get': 'get_en',
        'set': 'set_en'
    },
    'n_bits':
    {
        'get': 'get_n_bits',
        'set': 'set_n_bits'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class DelayOperations(object):
    def __init__(self, winobj, template_config='delay.json', target_config='delay.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('delay.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('delay.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Delay Mask started.')
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
    def get_latency(self):
        val = self.ui.latency.text()
        self.logger.debug(f'latency is {val}')
        return val

    def set_latency(self, val):
        self.logger.debug(f'Set latency to {val}')
        self.ui.latency.setText(str(val))

    def get_rst(self):
        status = self.ui.rst.isChecked()
        self.logger.debug(f'rst status is {status}')
        return self._convert_status(status)

    def set_rst(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rst status to {status}')
        self.ui.rst.setChecked(status)

    def get_en(self):
        status = self.ui.en.isChecked()
        self.logger.debug(f'en status is {status}')
        return self._convert_status(status)

    def set_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set en status to {status}')
        self.ui.en.setChecked(status)

    def get_n_bits(self):
        val = self.ui.n_bits.value()
        self.logger.debug(f'n_bits is {val}')
        return str(val)

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        self.ui.n_bits.setValue(int(float(val)))

    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        errors = []
        # Latency: a non-negative integer (the Simulink mask's rule; delay.sv
        # builds a LATENCY-stage shift register, LATENCY = 0 is a wire)
        val = str(self.get_latency()).strip()
        if val == '':
            errors.append('Latency must not be empty.')
        elif not re.fullmatch(r'\+?[0-9]+', val):
            errors.append('Latency must be an integer >= 0.')
        # Data width: delay.sv's [BITWIDTH-1:0] ports need BITWIDTH >= 1 (the
        # spin box range already enforces it; checked again for safety)
        if int(self.get_n_bits()) < 1:
            errors.append('Data width must be at least 1 bit.')
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
        # no option depends on another one: rst / en are ignored by the
        # hardware when Latency is 0, but their ports exist as in Simulink
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
            if k in DELAY_CONFIG:
                setfunc = DELAY_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Delay parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:delay'
        for k, v in DELAY_CONFIG.items():
            getfunc = v['get']
            val = str(getattr(self, getfunc)())
            if k == 'latency':
                # store the canonical integer text ('+3' / '03' -> '3')
                val = str(int(val.strip()))
            config['parameters'][k] = val
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Delay Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='delay.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = DelayOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
