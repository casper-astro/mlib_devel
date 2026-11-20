import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from generic_adc_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in generic_adc_ui.py.
# The keys must match scilab_blocks/casper_xps/generic_adc.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
GENERIC_ADC_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'n_inputs':
    {
        'get': 'get_n_inputs',
        'set': 'set_n_inputs'
    },
    'n_outputs':
    {
        'get': 'get_n_outputs',
        'set': 'set_n_outputs'
    },
    'bits':
    {
        'get': 'get_bits',
        'set': 'set_bits'
    },
    'interleaved':
    {
        'get': 'get_interleaved',
        'set': 'set_interleaved'
    },
    'or_support':
    {
        'get': 'get_or_support',
        'set': 'set_or_support'
    },
    'sync_support':
    {
        'get': 'get_sync_support',
        'set': 'set_sync_support'
    },
    'dv_support':
    {
        'get': 'get_dv_support',
        'set': 'set_dv_support'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class GenericAdcOperations(object):
    def __init__(self, winobj, template_config='generic_adc.json', target_config='generic_adc.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('generic_adc.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('generic_adc.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('generic_adc Mask started.')
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

    def get_n_inputs(self):
        val = self.ui.n_inputs.text()
        self.logger.debug(f'n_inputs is {val}')
        return val

    def set_n_inputs(self, val):
        self.logger.debug(f'Set n_inputs to {val}')
        self.ui.n_inputs.setText(str(val))

    def get_n_outputs(self):
        val = self.ui.n_outputs.text()
        self.logger.debug(f'n_outputs is {val}')
        return val

    def set_n_outputs(self, val):
        self.logger.debug(f'Set n_outputs to {val}')
        self.ui.n_outputs.setText(str(val))

    def get_bits(self):
        val = self.ui.bits.text()
        self.logger.debug(f'bits is {val}')
        return val

    def set_bits(self, val):
        self.logger.debug(f'Set bits to {val}')
        self.ui.bits.setText(str(val))

    def get_interleaved(self):
        status = self.ui.interleaved.isChecked()
        self.logger.debug(f'interleaved status is {status}')
        return self._convert_status(status)

    def set_interleaved(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set interleaved status to {status}')
        self.ui.interleaved.setChecked(status)

    def get_or_support(self):
        status = self.ui.or_support.isChecked()
        self.logger.debug(f'or_support status is {status}')
        return self._convert_status(status)

    def set_or_support(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set or_support status to {status}')
        self.ui.or_support.setChecked(status)

    def get_sync_support(self):
        status = self.ui.sync_support.isChecked()
        self.logger.debug(f'sync_support status is {status}')
        return self._convert_status(status)

    def set_sync_support(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set sync_support status to {status}')
        self.ui.sync_support.setChecked(status)

    def get_dv_support(self):
        status = self.ui.dv_support.isChecked()
        self.logger.debug(f'dv_support status is {status}')
        return self._convert_status(status)

    def set_dv_support(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dv_support status to {status}')
        self.ui.dv_support.setChecked(status)


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
        if str(self.get_n_inputs()).strip() == '':
            errors.append('inputs must not be empty.')
        if str(self.get_n_outputs()).strip() == '':
            errors.append('outputs per input must not be empty.')
        if str(self.get_bits()).strip() == '':
            errors.append('adc bit width must not be empty.')
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
            if k in GENERIC_ADC_CONFIG:
                setfunc = GENERIC_ADC_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid generic_adc parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:generic_adc'
        for k, v in GENERIC_ADC_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for generic_adc Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='generic_adc.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = GenericAdcOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
