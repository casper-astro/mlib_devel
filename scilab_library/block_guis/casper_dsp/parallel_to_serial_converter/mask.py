import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from parallel_to_serial_converter_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in parallel_to_serial_converter_ui.py.
# The keys must match scilab_blocks/casper_dsp/parallel_to_serial_converter.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
PARALLEL_TO_SERIAL_CONVERTER_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'pin_width':
    {
        'get': 'get_pin_width',
        'set': 'set_pin_width'
    },
    'sout_width':
    {
        'get': 'get_sout_width',
        'set': 'set_sout_width'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class ParallelToSerialConverterOperations(object):
    def __init__(self, winobj, template_config='parallel_to_serial_converter.json', target_config='parallel_to_serial_converter.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('parallel_to_serial_converter.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('parallel_to_serial_converter.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Parallel to Serial Converter Mask started.')
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
    def get_pin_width(self):
        val = self.ui.pin_width.value()
        self.logger.debug(f'pin_width is {val}')
        return str(val)

    def set_pin_width(self, val):
        self.logger.debug(f'Set pin_width to {val}')
        self.ui.pin_width.setValue(int(val))

    def get_sout_width(self):
        val = self.ui.sout_width.value()
        self.logger.debug(f'sout_width is {val}')
        return str(val)

    def set_sout_width(self, val):
        self.logger.debug(f'Set sout_width to {val}')
        self.ui.sout_width.setValue(int(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rules ported from casper_library/parallel_to_serial_converter_init.m:
        pin_width must be an exact multiple of sout_width, with at least 2
        shifter units (pin_width / sout_width >= 2).
        """
        errors = []
        pin_width = int(self.get_pin_width())
        sout_width = int(self.get_sout_width())
        if sout_width == 0 or pin_width % sout_width != 0 or (pin_width // sout_width) < 2:
            errors.append('Incompatible data widths: Parallel Input Width must be a multiple '
                          'of Serial Output Width, at least twice as large.')
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
            if k in PARALLEL_TO_SERIAL_CONVERTER_CONFIG:
                setfunc = PARALLEL_TO_SERIAL_CONVERTER_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Parallel to Serial Converter parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:parallel_to_serial_converter'
        for k, v in PARALLEL_TO_SERIAL_CONVERTER_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Parallel to Serial Converter Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='parallel_to_serial_converter.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = ParallelToSerialConverterOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
