import sys
import math
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from sine_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in sine_ui.py.
# The keys must match scilab_blocks/casper_sim/sine.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
SINE_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'amplitude':
    {
        'get': 'get_amplitude',
        'set': 'set_amplitude'
    },
    'frequency':
    {
        'get': 'get_frequency',
        'set': 'set_frequency'
    },
    'phase':
    {
        'get': 'get_phase',
        'set': 'set_phase'
    },
    'sampling_rate':
    {
        'get': 'get_sampling_rate',
        'set': 'set_sampling_rate'
    },
    'output_bit_width':
    {
        'get': 'get_output_bit_width',
        'set': 'set_output_bit_width'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
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


class SineOperations(object):
    def __init__(self, winobj, template_config='sine.json', target_config='sine.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('sine.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('sine.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Sine Wave (simulation) Mask started.')
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

    def get_amplitude(self):
        val = self.ui.amplitude.text()
        self.logger.debug(f'amplitude is {val}')
        return val

    def set_amplitude(self, val):
        self.logger.debug(f'Set amplitude to {val}')
        self.ui.amplitude.setText(str(val))

    def get_frequency(self):
        val = self.ui.frequency.text()
        self.logger.debug(f'frequency is {val}')
        return val

    def set_frequency(self, val):
        self.logger.debug(f'Set frequency to {val}')
        self.ui.frequency.setText(str(val))

    def get_phase(self):
        val = self.ui.phase.text()
        self.logger.debug(f'phase is {val}')
        return val

    def set_phase(self, val):
        self.logger.debug(f'Set phase to {val}')
        self.ui.phase.setText(str(val))

    def get_sampling_rate(self):
        val = self.ui.sampling_rate.text()
        self.logger.debug(f'sampling_rate is {val}')
        return val

    def set_sampling_rate(self, val):
        self.logger.debug(f'Set sampling_rate to {val}')
        self.ui.sampling_rate.setText(str(val))

    def get_output_bit_width(self):
        val = self.ui.output_bit_width.value()
        self.logger.debug(f'output_bit_width is {val}')
        return str(val)

    def set_output_bit_width(self, val):
        self.logger.debug(f'Set output_bit_width to {val}')
        self.ui.output_bit_width.setValue(int(val))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        self.ui.arith_type.setCurrentText(str(text))

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
        Mirrors sim_blocks/sine.py: the amplitude is a real value, written
        as round(amplitude * 2^bin_pt), which must fit in the output bit
        width as a signed word (unsigned is the same around mid-scale).
        """
        errors = []
        if str(self.get_name()).strip() == '':
            errors.append('Block name must not be empty.')
        amp = self._number(self.get_amplitude())
        if amp is None or amp < 0:
            errors.append('Amplitude must be a non-negative number.')
        else:
            bits = int(self.get_output_bit_width())
            bin_pt = int(self.get_bin_pt())
            word = round(amp * 2**bin_pt)
            if word > 2**(bits-1) - 1:
                errors.append(f'Amplitude {self.get_amplitude()} with binary point {bin_pt} does not fit in '
                              f'{bits} {self.get_arith_type()} bits (at most {(2**(bits-1) - 1) / 2**bin_pt:g}).')
        for label, text in [('Frequency (Hz)', self.get_frequency()),
                            ('Phase (rad)', self.get_phase()),
                            ('Sampling rate (Hz)', self.get_sampling_rate())]:
            if self._number(text) is None:
                errors.append(f'{label} must be a number.')
        fs = self._number(self.get_sampling_rate())
        if fs is not None and fs <= 0:
            errors.append('Sampling rate (Hz) must be positive.')
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
            if k in SINE_CONFIG:
                setfunc = SINE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Sine Wave (simulation) parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'sim:sine'
        for k, v in SINE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Sine Wave (simulation) Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='sine.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = SineOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
