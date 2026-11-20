import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from cross_multiplier_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in cross_multiplier_ui.py.
# The keys must match scilab_blocks/casper_dsp/cross_multiplier.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
CROSS_MULTIPLIER_CONFIG = {
    'streams':
    {
        'get': 'get_streams',
        'set': 'set_streams'
    },
    'aggregation':
    {
        'get': 'get_aggregation',
        'set': 'set_aggregation'
    },
    'bit_width_in':
    {
        'get': 'get_bit_width_in',
        'set': 'set_bit_width_in'
    },
    'binary_point_in':
    {
        'get': 'get_binary_point_in',
        'set': 'set_binary_point_in'
    },
    'bit_width_out':
    {
        'get': 'get_bit_width_out',
        'set': 'set_bit_width_out'
    },
    'binary_point_out':
    {
        'get': 'get_binary_point_out',
        'set': 'set_binary_point_out'
    },
    'mult_latency':
    {
        'get': 'get_mult_latency',
        'set': 'set_mult_latency'
    },
    'add_latency':
    {
        'get': 'get_add_latency',
        'set': 'set_add_latency'
    },
    'overflow':
    {
        'get': 'get_overflow',
        'set': 'set_overflow'
    },
    'quantisation':
    {
        'get': 'get_quantisation',
        'set': 'set_quantisation'
    },
    'conv_latency':
    {
        'get': 'get_conv_latency',
        'set': 'set_conv_latency'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class CrossMultiplierOperations(object):
    def __init__(self, winobj, template_config='cross_multiplier.json', target_config='cross_multiplier.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('cross_multiplier.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('cross_multiplier.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('cross_multiplier Mask started.')
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
    def get_streams(self):
        val = self.ui.streams.text()
        self.logger.debug(f'streams is {val}')
        return val

    def set_streams(self, val):
        self.logger.debug(f'Set streams to {val}')
        self.ui.streams.setText(str(val))

    def get_aggregation(self):
        val = self.ui.aggregation.text()
        self.logger.debug(f'aggregation is {val}')
        return val

    def set_aggregation(self, val):
        self.logger.debug(f'Set aggregation to {val}')
        self.ui.aggregation.setText(str(val))

    def get_bit_width_in(self):
        val = self.ui.bit_width_in.text()
        self.logger.debug(f'bit_width_in is {val}')
        return val

    def set_bit_width_in(self, val):
        self.logger.debug(f'Set bit_width_in to {val}')
        self.ui.bit_width_in.setText(str(val))

    def get_binary_point_in(self):
        val = self.ui.binary_point_in.text()
        self.logger.debug(f'binary_point_in is {val}')
        return val

    def set_binary_point_in(self, val):
        self.logger.debug(f'Set binary_point_in to {val}')
        self.ui.binary_point_in.setText(str(val))

    def get_bit_width_out(self):
        val = self.ui.bit_width_out.text()
        self.logger.debug(f'bit_width_out is {val}')
        return val

    def set_bit_width_out(self, val):
        self.logger.debug(f'Set bit_width_out to {val}')
        self.ui.bit_width_out.setText(str(val))

    def get_binary_point_out(self):
        val = self.ui.binary_point_out.text()
        self.logger.debug(f'binary_point_out is {val}')
        return val

    def set_binary_point_out(self, val):
        self.logger.debug(f'Set binary_point_out to {val}')
        self.ui.binary_point_out.setText(str(val))

    def get_mult_latency(self):
        val = self.ui.mult_latency.text()
        self.logger.debug(f'mult_latency is {val}')
        return val

    def set_mult_latency(self, val):
        self.logger.debug(f'Set mult_latency to {val}')
        self.ui.mult_latency.setText(str(val))

    def get_add_latency(self):
        val = self.ui.add_latency.text()
        self.logger.debug(f'add_latency is {val}')
        return val

    def set_add_latency(self, val):
        self.logger.debug(f'Set add_latency to {val}')
        self.ui.add_latency.setText(str(val))

    def get_overflow(self):
        text = self.ui.overflow.currentText()
        self.logger.debug(f'overflow is {text}')
        return text

    def set_overflow(self, text):
        self.logger.debug(f'Set overflow to {text}')
        self.ui.overflow.setCurrentText(str(text))

    def get_quantisation(self):
        text = self.ui.quantisation.currentText()
        self.logger.debug(f'quantisation is {text}')
        return text

    def set_quantisation(self, text):
        self.logger.debug(f'Set quantisation to {text}')
        self.ui.quantisation.setCurrentText(str(text))

    def get_conv_latency(self):
        val = self.ui.conv_latency.text()
        self.logger.debug(f'conv_latency is {val}')
        return val

    def set_conv_latency(self, val):
        self.logger.debug(f'Set conv_latency to {val}')
        self.ui.conv_latency.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Rules: every 'edit' field must be non-empty and an integer (all of
        them map to SystemVerilog `int` parameters of
        casper_dsp/rtl/Correlator/cross_multiplier.sv), plus every $fatal
        reachable from the mask parameters in the HDL backend:
          - cross_multiplier.sv: STREAMS >= 1, AGGREGATION >= 1
            (QUANTIZATION/OVERFLOW range is guaranteed by the popups;
            NOUT is derived, not a mask parameter)
          - cmult.sv (instantiated with N_BITS_A = N_BITS_B = bit_width_in,
            BIN_PT_A = BIN_PT_B = binary_point_in, N_BITS_AB = 2W+1,
            BIN_PT_AB = 2P): N_BITS_A >= 1 and N_BITS_A >= BIN_PT_A
            (N_BITS_AB >= BIN_PT_AB then follows).
        """
        errors = []
        fields = [
            ('streams', 'Number input streams'),
            ('aggregation', 'Aggregation per stream'),
            ('bit_width_in', 'Bit width in'),
            ('binary_point_in', 'Binary point in'),
            ('bit_width_out', 'Bit width out'),
            ('binary_point_out', 'Binary point out'),
            ('mult_latency', 'Multiplier latency'),
            ('add_latency', 'Adder latency'),
            ('conv_latency', 'Bit width conversion latency'),
        ]
        vals = {}
        for key, prompt in fields:
            text = str(getattr(self, 'get_' + key)()).strip()
            if text == '':
                errors.append(f'{prompt} must not be empty.')
                continue
            try:
                f = float(text)
                ok = (f == int(f))
            except (ValueError, OverflowError):
                ok = False
            if not ok:
                errors.append(f'{prompt} must be an integer.')
                continue
            vals[key] = int(f)

        if 'streams' in vals and vals['streams'] < 1:
            errors.append(
                'Number input streams must be >= 1 (the library\'s stored 0 '
                'builds no multipliers; the HDL backend $fatal-s on STREAMS < 1).')
        if 'aggregation' in vals and vals['aggregation'] < 1:
            errors.append('Aggregation per stream must be >= 1.')
        if 'bit_width_in' in vals and vals['bit_width_in'] < 1:
            errors.append('Bit width in must be >= 1.')
        if ('bit_width_in' in vals and 'binary_point_in' in vals
                and vals['bit_width_in'] < vals['binary_point_in']):
            errors.append('Bit width in must be >= Binary point in.')
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
            if k in CROSS_MULTIPLIER_CONFIG:
                setfunc = CROSS_MULTIPLIER_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid cross_multiplier parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:cross_multiplier'
        for k, v in CROSS_MULTIPLIER_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for cross_multiplier Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='cross_multiplier.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = CrossMultiplierOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
