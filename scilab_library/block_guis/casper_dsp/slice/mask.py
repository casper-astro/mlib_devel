import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from slice_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in slice_ui.py.
# The keys must match scilab_blocks/casper_dsp/slice.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
SLICE_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'n_bits_in':
    {
        'get': 'get_n_bits_in',
        'set': 'set_n_bits_in'
    },
    'nbits':
    {
        'get': 'get_nbits',
        'set': 'set_nbits'
    },
    'mode':
    {
        'get': 'get_mode',
        'set': 'set_mode'
    },
    'bit1':
    {
        'get': 'get_bit1',
        'set': 'set_bit1'
    },
    'base1':
    {
        'get': 'get_base1',
        'set': 'set_base1'
    },
    'bit0':
    {
        'get': 'get_bit0',
        'set': 'set_bit0'
    },
    'base0':
    {
        'get': 'get_base0',
        'set': 'set_base0'
    },
}

MODE_TWO = 'Two Bit Locations'
MODE_UPPER = 'Upper Bit Location + Width'
MODE_LOWER = 'Lower Bit Location + Width'


def bit_index(offset, base, n_bits_in):
    """Absolute bit index (0 = LSB) of an offset relative to 'MSB of Input'
    (offset 0 = the MSB, usually <= 0) or 'LSB of Input' (offset 0 = bit 0)."""
    if str(base).strip().lower() == 'msb of input':
        return n_bits_in - 1 + offset
    return offset


def slice_range(n_bits_in, nbits, mode, bit1, base1, bit0, base0):
    """(start, width) of the slice, i.e. dout = din[start+width-1:start].
    Same formulas as dsp_blocks/slice.py's bit_range() and slice.sci's
    slice_out_width()."""
    if mode == MODE_UPPER:
        top = bit_index(bit1, base1, n_bits_in)
        return top - nbits + 1, nbits
    if mode == MODE_LOWER:
        return bit_index(bit0, base0, n_bits_in), nbits
    top = bit_index(bit1, base1, n_bits_in)
    bot = bit_index(bit0, base0, n_bits_in)
    return bot, top - bot + 1


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class SliceOperations(object):
    def __init__(self, winobj, template_config='slice.json', target_config='slice.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('slice.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('slice.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Slice Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()
        # sync the enabled fields to the loaded mode -- setup_signal_functions()
        # is connected after load_config() runs, so the currentIndexChanged
        # signal fired (if at all) too late to do this on its own.
        self.set_mode_status(self.get_mode())
        self.update_selected_bits()

    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def get_n_bits_in(self):
        val = self.ui.n_bits_in.value()
        self.logger.debug(f'n_bits_in is {val}')
        return str(val)

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self.ui.n_bits_in.setValue(int(float(val)))

    def get_nbits(self):
        val = self.ui.nbits.value()
        self.logger.debug(f'nbits is {val}')
        return str(val)

    def set_nbits(self, val):
        self.logger.debug(f'Set nbits to {val}')
        self.ui.nbits.setValue(int(float(val)))

    def get_mode(self):
        text = self.ui.mode.currentText()
        self.logger.debug(f'mode is {text}')
        return text

    def set_mode(self, text):
        self.logger.debug(f'Set mode to {text}')
        self.ui.mode.setCurrentText(str(text))

    def get_bit1(self):
        val = self.ui.bit1.text()
        self.logger.debug(f'bit1 is {val}')
        return val

    def set_bit1(self, val):
        self.logger.debug(f'Set bit1 to {val}')
        self.ui.bit1.setText(str(val))

    def get_base1(self):
        text = self.ui.base1.currentText()
        self.logger.debug(f'base1 is {text}')
        return text

    def set_base1(self, text):
        self.logger.debug(f'Set base1 to {text}')
        self.ui.base1.setCurrentText(str(text))

    def get_bit0(self):
        val = self.ui.bit0.text()
        self.logger.debug(f'bit0 is {val}')
        return val

    def set_bit0(self, val):
        self.logger.debug(f'Set bit0 to {val}')
        self.ui.bit0.setText(str(val))

    def get_base0(self):
        text = self.ui.base0.currentText()
        self.logger.debug(f'base0 is {text}')
        return text

    def set_base0(self, text):
        self.logger.debug(f'Set base0 to {text}')
        self.ui.base0.setCurrentText(str(text))

    # *******************************************************************
    # Validation
    # *******************************************************************
    def _range(self):
        """Return (start, width, errors) for the current widgets; start and
        width are None when an offset field is not an integer."""
        errors = []
        mode = self.get_mode()
        offsets = {}
        used = {MODE_UPPER: ['bit1'], MODE_LOWER: ['bit0'], MODE_TWO: ['bit1', 'bit0']}[mode]
        for key, label in [('bit1', 'Offset of top bit'), ('bit0', 'Offset of bottom bit')]:
            if key not in used:
                continue
            val = str(getattr(self, SLICE_CONFIG[key]['get'])()).strip()
            if val == '':
                errors.append(f'{label} must not be empty.')
                continue
            try:
                offsets[key] = int(val)
            except ValueError:
                errors.append(f'{label} must be an integer.')
        if errors:
            return None, None, errors
        n_bits_in = int(self.get_n_bits_in())
        start, width = slice_range(n_bits_in, int(self.get_nbits()), mode,
                                   offsets.get('bit1', 0), self.get_base1(),
                                   offsets.get('bit0', 0), self.get_base0())
        return start, width, errors

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        slice.v has no range check (an out-of-range part select would give
        wrong hardware), so every slice outside [0, n_bits_in) is rejected,
        as Sysgen does.
        """
        start, width, errors = self._range()
        if errors:
            return errors
        n_bits_in = int(self.get_n_bits_in())
        if width < 1:
            errors.append(f'The top bit ({start + width - 1}) is below the bottom bit ({start}): '
                          'the slice must be at least 1 bit wide.')
        else:
            if start < 0:
                errors.append(f'The bottom bit of the slice ({start}) is below bit 0 of the input.')
            if start + width > n_bits_in:
                errors.append(f'The top bit of the slice ({start + width - 1}) is above the MSB '
                              f'of the {n_bits_in}-bit input (bit {n_bits_in - 1}).')
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

    def set_mode_status(self, mode):
        """
        Enable only the fields the selected range mode uses (as the Xilinx
        Slice mask does): nbits + bit1/base1 for 'Upper Bit Location + Width',
        nbits + bit0/base0 for 'Lower Bit Location + Width', and
        bit1/base1 + bit0/base0 (no nbits) for 'Two Bit Locations'.
        """
        upper = mode in (MODE_UPPER, MODE_TWO)
        lower = mode in (MODE_LOWER, MODE_TWO)
        self.ui.nbits.setEnabled(mode != MODE_TWO)
        self.ui.bit1.setEnabled(upper)
        self.ui.base1.setEnabled(upper)
        self.ui.bit0.setEnabled(lower)
        self.ui.base0.setEnabled(lower)

    def update_selected_bits(self):
        """Show the resulting din bit range (or why it is invalid)."""
        start, width, errors = self._range()
        if not errors:
            errors = self.validate_config()
        if errors:
            self.ui.selected_bits.setText('invalid: ' + errors[0])
        else:
            self.ui.selected_bits.setText(f'dout = din[{start + width - 1}:{start}] ({width} bit' + ('s)' if width > 1 else ')'))

    def Mode_Changed(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Mode changed.')
        self.logger.info('---------------------------------------------')
        self.set_mode_status(self.get_mode())
        self.update_selected_bits()

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.mode.currentIndexChanged.connect(self.Mode_Changed)
        for w in (self.ui.n_bits_in, self.ui.nbits):
            w.valueChanged.connect(self.update_selected_bits)
        for w in (self.ui.bit1, self.ui.bit0):
            w.textChanged.connect(self.update_selected_bits)
        for w in (self.ui.base1, self.ui.base0):
            w.currentIndexChanged.connect(self.update_selected_bits)

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
            if k in SLICE_CONFIG:
                setfunc = SLICE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Slice parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:slice'
        for k, v in SLICE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Slice Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='slice.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = SliceOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
