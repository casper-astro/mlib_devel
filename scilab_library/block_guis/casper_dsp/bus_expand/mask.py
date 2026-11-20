import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from bus_expand_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in bus_expand_ui.py.
# The keys must match scilab_blocks/casper_dsp/bus_expand.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
BUS_EXPAND_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'ndivision':
    {
        'get': 'get_ndivision',
        'set': 'set_ndivision'
    },
    'bit_division':
    {
        'get': 'get_bit_division',
        'set': 'set_bit_division'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class BusExpandOperations(object):
    def __init__(self, winobj, template_config='bus_expand.json', target_config='bus_expand.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('bus_expand.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('bus_expand.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Bus Expand Mask started.')
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
    def get_ndivision(self):
        val = self.ui.ndivision.value()
        self.logger.debug(f'ndivision is {val}')
        return str(val)

    def set_ndivision(self, val):
        self.logger.debug(f'Set ndivision to {val}')
        self.ui.ndivision.setValue(int(val))

    def get_bit_division(self):
        val = self.ui.bit_division.text()
        self.logger.debug(f'bit_division is {val}')
        return val

    def set_bit_division(self, val):
        self.logger.debug(f'Set bit_division to {val}')
        self.ui.bit_division.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Ports bus_expand_init.m's checks (outputNum a positive integer, one
        bit width per output) onto the simplified ndivision/bit_division
        pair this GUI uses -- Xcos has no Simulink-style automatic port-width
        propagation, so bit_division must stay a vector whose length matches
        ndivision for bus_expand.sci to size the output ports correctly.
        """
        errors = []
        ndivision = self.ui.ndivision.value()
        if ndivision < 1:
            errors.append('Number of Division: must be a positive integer.')

        raw = str(self.get_bit_division()).strip()
        if raw == '':
            errors.append('Bit width of each output (vector, length = Number of Division): must not be empty.')
        else:
            try:
                widths = json.loads(raw.replace('{', '[').replace('}', ']'))
                if not isinstance(widths, list):
                    raise ValueError('not a vector')
                if len(widths) != ndivision:
                    errors.append(
                        f'Bit width of each output: expected {ndivision} value(s) '
                        f'(matching Number of Division), got {len(widths)}.')
                if not all(isinstance(w, int) and w > 0 for w in widths):
                    errors.append('Bit width of each output: every value must be a positive integer.')
                elif len(set(widths)) > 1:
                    # casper_dsp's bus_expand.sv splits the bus into
                    # OUTPUT_NUM slices of one width OUTPUT_WIDTH
                    # (dsp_blocks/bus_expand.py)
                    errors.append('Bit width of each output: all outputs must have the same width.')
            except (ValueError, TypeError):
                errors.append(
                    'Bit width of each output: must be a bracketed vector of positive '
                    'integers, e.g. [8,8,8,8].')
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
            if k in BUS_EXPAND_CONFIG:
                setfunc = BUS_EXPAND_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Bus Expand parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:bus_expand'
        for k, v in BUS_EXPAND_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Bus Expand Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='bus_expand.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = BusExpandOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
