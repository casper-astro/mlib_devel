import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from xeng_descramble_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in xeng_descramble_ui.py.
# The keys must match scilab_blocks/casper_dsp/xeng_descramble.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
XENG_DESCRAMBLE_CONFIG = {
    'num_ants':
    {
        'get': 'get_num_ants',
        'set': 'set_num_ants'
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
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class XengDescrambleOperations(object):
    def __init__(self, winobj, template_config='xeng_descramble.json', target_config='xeng_descramble.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('xeng_descramble.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('xeng_descramble.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('xeng_descramble Mask started.')
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
    def get_num_ants(self):
        val = self.ui.num_ants.text()
        self.logger.debug(f'num_ants is {val}')
        return val

    def set_num_ants(self, val):
        self.logger.debug(f'Set num_ants to {val}')
        self.ui.num_ants.setText(str(val))

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
        val = self.ui.demux_factor.text()
        self.logger.debug(f'demux_factor is {val}')
        return val

    def set_demux_factor(self, val):
        self.logger.debug(f'Set demux_factor to {val}')
        self.ui.demux_factor.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    @staticmethod
    def _parse_int(text, prompt, errors):
        text = str(text).strip()
        if text == '':
            errors.append('%s must not be empty.' % prompt)
            return None
        try:
            val = float(text)
        except ValueError:
            errors.append('%s must be an integer (got %r).' % (prompt, text))
            return None
        if val != int(val):
            errors.append('%s must be an integer (got %r).' % (prompt, text))
            return None
        return int(val)

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Ports the $fatal checks of casper_dsp/rtl/Correlator/xeng_descramble.sv
        that depend on mask parameters (NUM_ANTS even and >= 4,
        DEMUX_FACTOR in {1,2,4,8}); the other $fatal-s (RAM_LATENCY >= 1,
        W/P/OW overridden) only concern non-mask parameters that the backend
        always sets correctly. Fields must also be non-empty integers, since
        they map to SystemVerilog int parameters.
        """
        errors = []
        num_ants = self._parse_int(self.get_num_ants(), 'Number of Antennas', errors)
        if num_ants is not None and (num_ants < 4 or num_ants % 2 != 0):
            errors.append('Number of Antennas must be even and >= 4 (got %d) -- '
                          'the HDL backend $fatal-s otherwise (PIVOT and the '
                          'tap map assume it).' % num_ants)
        n_bits = self._parse_int(self.get_n_bits(), 'Input Bitwidth', errors)
        acc_len = self._parse_int(self.get_acc_len(), 'X engine accumulation length', errors)
        demux_factor = self._parse_int(self.get_demux_factor(), 'Demux Factor', errors)
        if demux_factor is not None and demux_factor not in (1, 2, 4, 8):
            errors.append('Demux Factor must be 1, 2, 4 or 8 (got %d) -- the '
                          'HDL backend $fatal-s otherwise (x_cast bit_offsets '
                          'only exist for these).' % demux_factor)
        return errors

    def check_warnings(self):
        """
        Non-fatal checks, mirroring the mask initialization's errordlg (the
        Simulink mask shows it and continues with ship_el_del = 0; the HDL
        issues a $warning and does the same). Assumes validate_config() passed.
        """
        warnings = []
        num_ants = 4 if False else int(float(self.get_num_ants()))
        acc_len = int(float(self.get_acc_len()))
        demux_factor = int(float(self.get_demux_factor()))
        num_validins = num_ants * (num_ants // 2 + 1)
        ship_el_del = (acc_len * num_ants) // (num_validins * demux_factor) - 1
        if ship_el_del < 0:
            warnings.append('Insufficient output space for this configuration. '
                            'Try a lower demux setting. Else you need fewer '
                            'antennas or longer xeng acc time. '
                            '(ship_el_del < 0, 0 is used instead.)')
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
            if k in XENG_DESCRAMBLE_CONFIG:
                setfunc = XENG_DESCRAMBLE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid xeng_descramble parameters', chr(10).join(errors))
            return False
        warnings = self.check_warnings()
        if warnings:
            for w in warnings:
                self.logger.warning(w)
            QMessageBox.warning(self.winobj, '%s warning' % self.winobj.windowTitle(), chr(10).join(warnings))
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
            config['parameters']['tag'] = 'dsp:xeng_descramble'
        for k, v in XENG_DESCRAMBLE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for xeng_descramble Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='xeng_descramble.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = XengDescrambleOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
