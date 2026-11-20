import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from counter_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in counter_ui.py.
# The keys must match scilab_blocks/casper_dsp/counter.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
COUNTER_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'counter_type':
    {
        'get': 'get_counter_type',
        'set': 'set_counter_type'
    },
    'n_bits':
    {
        'get': 'get_n_bits',
        'set': 'set_n_bits'
    },
    'count_to_val':
    {
        'get': 'get_count_to_val',
        'set': 'set_count_to_val'
    },
    'count_dir':
    {
        'get': 'get_count_dir',
        'set': 'set_count_dir'
    },
    'init_val':
    {
        'get': 'get_init_val',
        'set': 'set_init_val'
    },
    'step':
    {
        'get': 'get_step',
        'set': 'set_step'
    },
    'bin_pt':
    {
        'get': 'get_bin_pt',
        'set': 'set_bin_pt'
    },
    'enable_load':
    {
        'get': 'get_enable_load',
        'set': 'set_enable_load'
    },
    'enable_sync_rst':
    {
        'get': 'get_enable_sync_rst',
        'set': 'set_enable_sync_rst'
    },
    'enable_enable':
    {
        'get': 'get_enable_enable',
        'set': 'set_enable_enable'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class CounterOperations(object):
    def __init__(self, winobj, template_config='counter.json', target_config='counter.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('counter.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('counter.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Counter Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()
        # sync count_to_val's enabled state to the loaded counter_type --
        # setup_signal_functions() is connected after load_config() runs, so
        # the currentIndexChanged signal fired (if at all) too late to do
        # this on its own.
        self.set_count_to_val_status(self.get_counter_type() == 'Count Limited')

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
    def get_counter_type(self):
        text = self.ui.counter_type.currentText()
        self.logger.debug(f'counter_type is {text}')
        return text

    def set_counter_type(self, text):
        self.logger.debug(f'Set counter_type to {text}')
        self.ui.counter_type.setCurrentText(str(text))

    def get_n_bits(self):
        val = self.ui.n_bits.value()
        self.logger.debug(f'n_bits is {val}')
        return str(val)

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        self.ui.n_bits.setValue(int(val))

    def get_count_to_val(self):
        val = self.ui.count_to_val.text()
        self.logger.debug(f'count_to_val is {val}')
        return val

    def set_count_to_val(self, val):
        self.logger.debug(f'Set count_to_val to {val}')
        self.ui.count_to_val.setText(str(val))

    def get_count_dir(self):
        text = self.ui.count_dir.currentText()
        self.logger.debug(f'count_dir is {text}')
        return text

    def set_count_dir(self, text):
        self.logger.debug(f'Set count_dir to {text}')
        self.ui.count_dir.setCurrentText(str(text))

    def get_init_val(self):
        val = self.ui.init_val.text()
        self.logger.debug(f'init_val is {val}')
        return val

    def set_init_val(self, val):
        self.logger.debug(f'Set init_val to {val}')
        self.ui.init_val.setText(str(val))

    def get_step(self):
        val = self.ui.step.text()
        self.logger.debug(f'step is {val}')
        return val

    def set_step(self, val):
        self.logger.debug(f'Set step to {val}')
        self.ui.step.setText(str(val))

    def get_bin_pt(self):
        val = self.ui.bin_pt.text()
        self.logger.debug(f'bin_pt is {val}')
        return val

    def set_bin_pt(self, val):
        self.logger.debug(f'Set bin_pt to {val}')
        self.ui.bin_pt.setText(str(val))

    def get_enable_load(self):
        status = self.ui.enable_load.isChecked()
        self.logger.debug(f'enable_load status is {status}')
        return self._convert_status(status)

    def set_enable_load(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set enable_load status to {status}')
        self.ui.enable_load.setChecked(status)

    def get_enable_sync_rst(self):
        status = self.ui.enable_sync_rst.isChecked()
        self.logger.debug(f'enable_sync_rst status is {status}')
        return self._convert_status(status)

    def set_enable_sync_rst(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set enable_sync_rst status to {status}')
        self.ui.enable_sync_rst.setChecked(status)

    def get_enable_enable(self):
        status = self.ui.enable_enable.isChecked()
        self.logger.debug(f'enable_enable status is {status}')
        return self._convert_status(status)

    def set_enable_enable(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set enable_enable status to {status}')
        self.ui.enable_enable.setChecked(status)


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        errors = []
        for key, label in [
            ('count_to_val', 'Count to value'),
            ('init_val', 'Initial value'),
            ('step', 'Step'),
            ('bin_pt', 'Binary point'),
        ]:
            val = str(getattr(self, COUNTER_CONFIG[key]['get'])()).strip()
            if val == '':
                errors.append(f'{label} must not be empty.')
                continue
            try:
                int(val)
            except ValueError:
                errors.append(f'{label} must be an integer.')
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

    def set_count_to_val_status(self, count_limited):
        """
        Count to value only has any effect when counter_type is Count
        Limited -- a free running counter always wraps at 2^n_bits instead.
        A Count Limited counter has no load port (as in Simulink, see
        counter.sv's [ports] note), so the option is cleared and disabled.
        """
        self.ui.count_to_val.setEnabled(count_limited)
        if count_limited:
            self.ui.enable_load.setChecked(False)
        self.ui.enable_load.setEnabled(not count_limited)

    def CounterType_Changed(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Counter type changed.')
        self.logger.info('---------------------------------------------')
        self.set_count_to_val_status(self.get_counter_type() == 'Count Limited')

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.counter_type.currentIndexChanged.connect(self.CounterType_Changed)

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
            if k in COUNTER_CONFIG:
                setfunc = COUNTER_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Counter parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:counter'
        for k, v in COUNTER_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Counter Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='counter.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = CounterOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
