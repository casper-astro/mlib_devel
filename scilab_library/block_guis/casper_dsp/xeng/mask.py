import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from xeng_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in xeng_ui.py.
# The keys must match scilab_blocks/casper_dsp/xeng.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
XENG_CONFIG = {
    'n_ants':
    {
        'get': 'get_n_ants',
        'set': 'set_n_ants'
    },
    'n_bits':
    {
        'get': 'get_n_bits',
        'set': 'set_n_bits'
    },
    'acc_len':
    {
        'get': 'get_acc_len',
        'set': 'set_acc_len'
    },
    'demux_factor':
    {
        'get': 'get_demux_factor',
        'set': 'set_demux_factor'
    },
    'add_latency':
    {
        'get': 'get_add_latency',
        'set': 'set_add_latency'
    },
    'mult_latency':
    {
        'get': 'get_mult_latency',
        'set': 'set_mult_latency'
    },
    'bram_latency':
    {
        'get': 'get_bram_latency',
        'set': 'set_bram_latency'
    },
    'use_ded_mult':
    {
        'get': 'get_use_ded_mult',
        'set': 'set_use_ded_mult'
    },
    'use_bram_delay':
    {
        'get': 'get_use_bram_delay',
        'set': 'set_use_bram_delay'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class XengOperations(object):
    def __init__(self, winobj, template_config='xeng.json', target_config='xeng.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('xeng.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('xeng.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('xeng Mask started.')
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
    def get_n_ants(self):
        val = self.ui.n_ants.text()
        self.logger.debug(f'n_ants is {val}')
        return val

    def set_n_ants(self, val):
        self.logger.debug(f'Set n_ants to {val}')
        self.ui.n_ants.setText(str(val))

    def get_n_bits(self):
        val = self.ui.n_bits.text()
        self.logger.debug(f'n_bits is {val}')
        return val

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        self.ui.n_bits.setText(str(val))

    def get_acc_len(self):
        val = self.ui.acc_len.text()
        self.logger.debug(f'acc_len is {val}')
        return val

    def set_acc_len(self, val):
        self.logger.debug(f'Set acc_len to {val}')
        self.ui.acc_len.setText(str(val))

    def get_demux_factor(self):
        text = self.ui.demux_factor.currentText()
        self.logger.debug(f'demux_factor is {text}')
        return text

    def set_demux_factor(self, text):
        self.logger.debug(f'Set demux_factor to {text}')
        self.ui.demux_factor.setCurrentText(str(text))

    def get_add_latency(self):
        val = self.ui.add_latency.text()
        self.logger.debug(f'add_latency is {val}')
        return val

    def set_add_latency(self, val):
        self.logger.debug(f'Set add_latency to {val}')
        self.ui.add_latency.setText(str(val))

    def get_mult_latency(self):
        val = self.ui.mult_latency.text()
        self.logger.debug(f'mult_latency is {val}')
        return val

    def set_mult_latency(self, val):
        self.logger.debug(f'Set mult_latency to {val}')
        self.ui.mult_latency.setText(str(val))

    def get_bram_latency(self):
        val = self.ui.bram_latency.text()
        self.logger.debug(f'bram_latency is {val}')
        return val

    def set_bram_latency(self, val):
        self.logger.debug(f'Set bram_latency to {val}')
        self.ui.bram_latency.setText(str(val))

    def get_use_ded_mult(self):
        val = self.ui.use_ded_mult.text()
        self.logger.debug(f'use_ded_mult is {val}')
        return val

    def set_use_ded_mult(self, val):
        self.logger.debug(f'Set use_ded_mult to {val}')
        self.ui.use_ded_mult.setText(str(val))

    def get_use_bram_delay(self):
        val = self.ui.use_bram_delay.text()
        self.logger.debug(f'use_bram_delay is {val}')
        return val

    def set_use_bram_delay(self, val):
        self.logger.debug(f'Set use_bram_delay to {val}')
        self.ui.use_bram_delay.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def _parse_int(self, getter, prompt, errors):
        """Parse an 'edit' field as an integer (the HDL parameters are all
        `parameter int`); append an error and return None if it isn't."""
        text = str(getattr(self, getter)()).strip()
        if text == '':
            errors.append(f'{prompt} must not be empty.')
            return None
        try:
            val = float(text)
        except ValueError:
            errors.append(f'{prompt} must be an integer (got {text!r}).')
            return None
        if val != int(val):
            errors.append(f'{prompt} must be an integer (got {text!r}).')
            return None
        return int(val)

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Every rule below is a $fatal of the HDL backend that the xeng mask
        parameters can reach (casper_dsp/rtl/Correlator/xeng.sv and the
        sub-modules it instantiates with these parameters); nothing else is
        checked besides "the field is a non-empty integer".
          xeng.sv:          N_ANTS < 4, N_ANTS == 5, odd N_ANTS,
                            ACC_LEN <= floor(N_ANTS/2 + 1)
          cmult.sv:         N_BITS = 0 (empty block) is not supported
          cmac.sv:          MULT_LATENCY + ADD_LATENCY >= 1
          baseline_tap.sv:  USE_BRAM_DELAY != 0 needs ACC_LEN > BRAM_LATENCY + 1
          auto_tap.sv:      USE_BRAM_DELAY != 0 needs its loop delay
                            D = (ACC_LEN-1)*ceil(N_ANTS/2) + N_ANTS%2 > BRAM_LATENCY + 1
                            (or D == 0)
        The non-power-of-2 ACC_LEN $warning of xeng.sv is a warning
        (validate_warnings), not an error.
        """
        errors = []
        n_ants = self._parse_int('get_n_ants', 'Number of antennas', errors)
        n_bits = self._parse_int('get_n_bits', 'Bit-width of samples in', errors)
        acc_len = self._parse_int('get_acc_len', 'Accumulation length', errors)
        add_latency = self._parse_int('get_add_latency', 'Adder latency', errors)
        mult_latency = self._parse_int('get_mult_latency', 'Multiplier latency', errors)
        bram_latency = self._parse_int('get_bram_latency', 'BRAM latency', errors)
        self._parse_int('get_use_ded_mult', 'Implementation: Multiplier type (0=slices 1=embedded 2=bram)', errors)
        use_bram_delay = self._parse_int('get_use_bram_delay', 'Implementation: Delay type (0=SLR, 1=BRAM)', errors)

        if n_ants is not None:
            if n_ants < 4:
                errors.append(f'Number of antennas must be >= 4 (got {n_ants}).')
            elif n_ants == 5:
                errors.append('Number of antennas: 5 antennas are not supported.')
            elif n_ants % 2 != 0:
                errors.append(f'Number of antennas must be even (the descramble needs it; got {n_ants}).')
        if n_ants is not None and acc_len is not None and acc_len <= n_ants // 2 + 1:
            errors.append(f'Accumulation length ({acc_len}) must be > floor(Number of antennas/2 + 1) = {n_ants // 2 + 1}.')
        if n_bits is not None and n_bits < 1:
            errors.append(f'Bit-width of samples in must be >= 1 (got {n_bits}).')
        if add_latency is not None and mult_latency is not None and add_latency + mult_latency < 1:
            errors.append('Adder latency + Multiplier latency must be >= 1 (cmac sync delay = sum - 1).')
        if use_bram_delay is not None and use_bram_delay != 0 and bram_latency is not None:
            if acc_len is not None and acc_len <= bram_latency + 1:
                errors.append(f'With Delay type BRAM, Accumulation length ({acc_len}) must be > BRAM latency + 1 ({bram_latency + 1}) (baseline_tap delay_bram).')
            elif acc_len is not None and n_ants is not None:
                d = (acc_len - 1) * ((n_ants + 1) // 2) + (n_ants % 2)
                if d != 0 and d <= bram_latency + 1:
                    errors.append(f'With Delay type BRAM, the auto_tap loop delay ({d}) must be > BRAM latency + 1 ({bram_latency + 1}).')
        return errors

    def validate_warnings(self):
        """
        Non-fatal issues, shown as a warning; the config is still written.
        Ported from xeng.sv's $warning: for a non-power-of-2 ACC_LEN the
        descramble slices W-bit fields out of the N_BITS_OUT-bit tap outputs
        (W = N_BITS_OUT - 1), so its output fields are misaligned, exactly as
        in the casper_library block.
        """
        warnings = []
        try:
            acc_len = int(float(str(self.get_acc_len()).strip()))
        except ValueError:
            return warnings
        if acc_len >= 1 and (acc_len & (acc_len - 1)) != 0:
            warnings.append(
                f'Accumulation length {acc_len} is not a power of 2: the descramble '
                'slices fields one bit narrower than the tap outputs, so the acc '
                'output fields are misaligned (same behaviour as the Simulink library).')
        return warnings

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
            if k in XENG_CONFIG:
                setfunc = XENG_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid xeng parameters', chr(10).join(errors))
            return False
        warnings = self.validate_warnings()
        if warnings:
            for w in warnings:
                self.logger.warning(w)
            QMessageBox.warning(self.winobj, 'xeng warning', chr(10).join(warnings))
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
            config['parameters']['tag'] = 'dsp:xeng'
        for k, v in XENG_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for xeng Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='xeng.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = XengOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
