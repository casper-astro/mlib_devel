import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from auto_tap_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in auto_tap_ui.py.
# The keys must match scilab_blocks/casper_dsp/auto_tap.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
AUTO_TAP_CONFIG = {
    'n_ants':
    {
        'get': 'get_n_ants',
        'set': 'set_n_ants'
    },
    'n_simultan':
    {
        'get': 'get_n_simultan',
        'set': 'set_n_simultan'
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
    'mult_type':
    {
        'get': 'get_mult_type',
        'set': 'set_mult_type'
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


class AutoTapOperations(object):
    def __init__(self, winobj, template_config='auto_tap.json', target_config='auto_tap.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('auto_tap.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('auto_tap.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('auto_tap Mask started.')
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

    def get_n_simultan(self):
        val = self.ui.n_simultan.text()
        self.logger.debug(f'n_simultan is {val}')
        return val

    def set_n_simultan(self, val):
        self.logger.debug(f'Set n_simultan to {val}')
        self.ui.n_simultan.setText(str(val))

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

    def get_mult_type(self):
        val = self.ui.mult_type.text()
        self.logger.debug(f'mult_type is {val}')
        return val

    def set_mult_type(self, val):
        self.logger.debug(f'Set mult_type to {val}')
        self.ui.mult_type.setText(str(val))

    def get_use_bram_delay(self):
        val = self.ui.use_bram_delay.text()
        self.logger.debug(f'use_bram_delay is {val}')
        return val

    def set_use_bram_delay(self, val):
        self.logger.debug(f'Set use_bram_delay to {val}')
        self.ui.use_bram_delay.setText(str(val))


    @staticmethod
    def _parse_int(text):
        """Parse an integer-valued mask field. Accepts '64' or '64.0';
        returns None for empty/non-integer text."""
        try:
            v = float(str(text).strip())
        except ValueError:
            return None
        if v != int(v):
            return None
        return int(v)

    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Every field is a Simulink 'edit' field holding one integer, passed
        straight to the matching casper_dsp/rtl/Correlator/auto_tap.sv
        parameter, so each must parse as an integer. Beyond that, the rules
        are exactly the $fatal conditions the HDL can hit with these
        parameters (auto_tap.sv itself plus dual_pol_cmac -> cmac -> cmult):
          - cmult:    n_bits >= 1
          - cmac:     acc_len >= 2
          - cmac:     mult_latency + add_latency >= 1
          - auto_tap: with use_bram_delay != 0, the delay_bram length
                      D = (acc_len-1)*ceil(n_ants/2) + n_ants%2 must be
                      0 or > bram_latency + 1 (delay_bram mask check)
        (The N_BITS_OUT "derived, do not override" $fatal can't be hit
        from the GUI: N_BITS_OUT is never passed.) mult_type and
        use_bram_delay are not range-checked: auto_tap_init.m treats any
        mult_type other than 1/2 as behavioural HDL and any non-zero
        use_bram_delay as BRAM, and so does the HDL.
        """
        errors = []
        labels = [
            ('n_ants', 'Number of antennas (total inputs = n_ants*n_simultan below)'),
            ('n_simultan', 'Number of inputs fed-in simultaneously'),
            ('n_bits', 'Number of input bits (per complex component)'),
            ('acc_len', 'Accumulation length'),
            ('add_latency', 'Adder latency'),
            ('mult_latency', 'Multiplier latency'),
            ('bram_latency', 'BRAM latency'),
            ('mult_type', 'Multiplier Type (0=behavioural HDL, 1=embedded, 2=core)'),
            ('use_bram_delay', 'Implementation: Delay type (0=SLR, 1=BRAM)'),
        ]
        v = {}
        for key, label in labels:
            text = str(getattr(self, 'get_' + key)()).strip()
            if text == '':
                errors.append(f'{label} must not be empty.')
                v[key] = None
                continue
            v[key] = self._parse_int(text)
            if v[key] is None:
                errors.append(f'{label} must be an integer (got {text!r}).')

        if v['n_bits'] is not None and v['n_bits'] < 1:
            errors.append('Number of input bits (per complex component) must be >= 1.')
        if v['acc_len'] is not None and v['acc_len'] < 2:
            errors.append('Accumulation length must be >= 2 (cmac: bit_growth = 0 gives a 0-bit counter).')
        if v['mult_latency'] is not None and v['add_latency'] is not None \
                and v['mult_latency'] + v['add_latency'] < 1:
            errors.append('Multiplier latency + Adder latency must be >= 1 (cmac sync delay = sum - 1).')
        if None not in (v['n_ants'], v['acc_len'], v['bram_latency'], v['use_bram_delay']) \
                and v['use_bram_delay'] != 0:
            n_ants = v['n_ants']
            d = (v['acc_len'] - 1) * ((n_ants + 1) // 2) + (n_ants % 2)
            if d != 0 and d <= v['bram_latency'] + 1:
                errors.append(
                    f'With a BRAM delay, the a_loop delay (acc_len-1)*ceil(n_ants/2) + mod(n_ants,2) '
                    f'= {d} must be greater than BRAM latency + 1 = {v["bram_latency"] + 1} '
                    f'(delay_bram mask check). Use the SLR delay type or a smaller BRAM latency.')
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
            if k in AUTO_TAP_CONFIG:
                setfunc = AUTO_TAP_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid auto_tap parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:auto_tap'
        for k, v in AUTO_TAP_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for auto_tap Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='auto_tap.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = AutoTapOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
