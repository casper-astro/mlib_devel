import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from adder_subtractor_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in adder_subtractor_ui.py.
# The keys must match scilab_blocks/casper_dsp/adder_subtractor.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
ADDER_SUBTRACTOR_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'opmode':
    {
        'get': 'get_opmode',
        'set': 'set_opmode'
    },
    'n_bits_a':
    {
        'get': 'get_n_bits_a',
        'set': 'set_n_bits_a'
    },
    'bin_pt_a':
    {
        'get': 'get_bin_pt_a',
        'set': 'set_bin_pt_a'
    },
    'type_a':
    {
        'get': 'get_type_a',
        'set': 'set_type_a'
    },
    'n_bits_b':
    {
        'get': 'get_n_bits_b',
        'set': 'set_n_bits_b'
    },
    'bin_pt_b':
    {
        'get': 'get_bin_pt_b',
        'set': 'set_bin_pt_b'
    },
    'type_b':
    {
        'get': 'get_type_b',
        'set': 'set_type_b'
    },
    'misc':
    {
        'get': 'get_misc',
        'set': 'set_misc'
    },
    'misc_width':
    {
        'get': 'get_misc_width',
        'set': 'set_misc_width'
    },
    'async_op':
    {
        'get': 'get_async_op',
        'set': 'set_async_op'
    },
    'n_bits_out':
    {
        'get': 'get_n_bits_out',
        'set': 'set_n_bits_out'
    },
    'bin_pt_out':
    {
        'get': 'get_bin_pt_out',
        'set': 'set_bin_pt_out'
    },
    'type_out':
    {
        'get': 'get_type_out',
        'set': 'set_type_out'
    },
    'quantization':
    {
        'get': 'get_quantization',
        'set': 'set_quantization'
    },
    'overflow':
    {
        'get': 'get_overflow',
        'set': 'set_overflow'
    },
    'csp_latency':
    {
        'get': 'get_csp_latency',
        'set': 'set_csp_latency'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class AdderSubtractorOperations(object):
    def __init__(self, winobj, template_config='adder_subtractor.json', target_config='adder_subtractor.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('adder_subtractor.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('adder_subtractor.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Adder Subtractor Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()
        # sync misc_width's enabled state to the loaded misc option --
        # setup_signal_functions() is connected after load_config() runs, so
        # the toggled signal fired (if at all) too late to do this on its own.
        self.set_misc_width_status(self.ui.misc.isChecked())

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

    def get_opmode(self):
        text = self.ui.opmode.currentText()
        self.logger.debug(f'opmode is {text}')
        return text

    def set_opmode(self, text):
        self.logger.debug(f'Set opmode to {text}')
        self.ui.opmode.setCurrentText(str(text))

    def get_n_bits_a(self):
        val = self.ui.n_bits_a.value()
        self.logger.debug(f'n_bits_a is {val}')
        return str(val)

    def set_n_bits_a(self, val):
        self.logger.debug(f'Set n_bits_a to {val}')
        self.ui.n_bits_a.setValue(int(val))

    def get_bin_pt_a(self):
        val = self.ui.bin_pt_a.value()
        self.logger.debug(f'bin_pt_a is {val}')
        return str(val)

    def set_bin_pt_a(self, val):
        self.logger.debug(f'Set bin_pt_a to {val}')
        self.ui.bin_pt_a.setValue(int(val))

    def get_type_a(self):
        text = self.ui.type_a.currentText()
        self.logger.debug(f'type_a is {text}')
        return text

    def set_type_a(self, text):
        self.logger.debug(f'Set type_a to {text}')
        self.ui.type_a.setCurrentText(str(text))

    def get_n_bits_b(self):
        val = self.ui.n_bits_b.value()
        self.logger.debug(f'n_bits_b is {val}')
        return str(val)

    def set_n_bits_b(self, val):
        self.logger.debug(f'Set n_bits_b to {val}')
        self.ui.n_bits_b.setValue(int(val))

    def get_bin_pt_b(self):
        val = self.ui.bin_pt_b.value()
        self.logger.debug(f'bin_pt_b is {val}')
        return str(val)

    def set_bin_pt_b(self, val):
        self.logger.debug(f'Set bin_pt_b to {val}')
        self.ui.bin_pt_b.setValue(int(val))

    def get_type_b(self):
        text = self.ui.type_b.currentText()
        self.logger.debug(f'type_b is {text}')
        return text

    def set_type_b(self, text):
        self.logger.debug(f'Set type_b to {text}')
        self.ui.type_b.setCurrentText(str(text))

    def get_misc(self):
        status = self.ui.misc.isChecked()
        self.logger.debug(f'misc status is {status}')
        return self._convert_status(status)

    def set_misc(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set misc status to {status}')
        self.ui.misc.setChecked(status)

    def get_misc_width(self):
        val = self.ui.misc_width.value()
        self.logger.debug(f'misc_width is {val}')
        return str(val)

    def set_misc_width(self, val):
        self.logger.debug(f'Set misc_width to {val}')
        self.ui.misc_width.setValue(int(val))

    def get_async_op(self):
        status = self.ui.async_op.isChecked()
        self.logger.debug(f'async_op status is {status}')
        return self._convert_status(status)

    def set_async_op(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set async_op status to {status}')
        self.ui.async_op.setChecked(status)

    def get_n_bits_out(self):
        val = self.ui.n_bits_out.value()
        self.logger.debug(f'n_bits_out is {val}')
        return str(val)

    def set_n_bits_out(self, val):
        self.logger.debug(f'Set n_bits_out to {val}')
        self.ui.n_bits_out.setValue(int(val))

    def get_bin_pt_out(self):
        val = self.ui.bin_pt_out.value()
        self.logger.debug(f'bin_pt_out is {val}')
        return str(val)

    def set_bin_pt_out(self, val):
        self.logger.debug(f'Set bin_pt_out to {val}')
        self.ui.bin_pt_out.setValue(int(val))

    def get_type_out(self):
        text = self.ui.type_out.currentText()
        self.logger.debug(f'type_out is {text}')
        return text

    def set_type_out(self, text):
        self.logger.debug(f'Set type_out to {text}')
        self.ui.type_out.setCurrentText(str(text))

    def get_quantization(self):
        text = self.ui.quantization.currentText()
        self.logger.debug(f'quantization is {text}')
        return text

    def set_quantization(self, text):
        self.logger.debug(f'Set quantization to {text}')
        self.ui.quantization.setCurrentText(str(text))

    def get_overflow(self):
        text = self.ui.overflow.currentText()
        self.logger.debug(f'overflow is {text}')
        return text

    def set_overflow(self, text):
        self.logger.debug(f'Set overflow to {text}')
        self.ui.overflow.setCurrentText(str(text))

    def get_csp_latency(self):
        val = self.ui.csp_latency.value()
        self.logger.debug(f'csp_latency is {val}')
        return str(val)

    def set_csp_latency(self, val):
        self.logger.debug(f'Set csp_latency to {val}')
        self.ui.csp_latency.setValue(int(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        adder_subtractor.sv has no $fatal checks of its own; the rules below
        keep the dialog to configurations with a Simulink counterpart:
        System Generator fixed-point types need 0 <= bin_pt <= n_bits (the
        lower bound is the spin box range, see convert.sv's [[unsupported]]
        note on negative binary points), the bit widths are >= 1, the latency
        >= 0 and the misc width >= 1 (spin box ranges). Quantization 2 (round
        half to even) and overflow 'Flag as error' are not offered at all
        (adder_subtractor.sv [[unsupported]] / deviations).
        """
        errors = []
        if str(self.get_name()).strip() == '':
            errors.append('Block name must not be empty.')
        for prefix, label in [('a', 'a input'), ('b', 'b input'), ('out', 'Output')]:
            n_bits = int(getattr(self, f'get_n_bits_{prefix}')())
            bin_pt = int(getattr(self, f'get_bin_pt_{prefix}')())
            if bin_pt < 0 or bin_pt > n_bits:
                errors.append(f'{label} binary point ({bin_pt}) must be between 0 and '
                              f'the {label.lower()} bit width ({n_bits}).')
        for key, label, options in [
            ('opmode', 'Mode', ['Addition', 'Subtraction']),
            ('type_a', 'a input type', ['Unsigned', 'Signed']),
            ('type_b', 'b input type', ['Unsigned', 'Signed']),
            ('type_out', 'Output type', ['Unsigned', 'Signed']),
            ('quantization', 'Quantization strategy', ['Truncate', 'Round  (unbiased: +/- Inf)']),
            ('overflow', 'Overflow strategy', ['Wrap', 'Saturate']),
        ]:
            val = getattr(self, ADDER_SUBTRACTOR_CONFIG[key]['get'])()
            if val not in options:
                errors.append(f'{label} must be one of {", ".join(options)}.')
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

    def set_misc_width_status(self, misc_on):
        """
        The misc width only sets the width of the misci / misco ports, which
        exist only with 'Misc support' on.
        """
        self.ui.misc_width.setEnabled(misc_on)

    def Misc_Changed(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('Misc support changed.')
        self.logger.info('---------------------------------------------')
        self.set_misc_width_status(self.ui.misc.isChecked())

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.misc.toggled.connect(self.Misc_Changed)

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
            if k in ADDER_SUBTRACTOR_CONFIG:
                setfunc = ADDER_SUBTRACTOR_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Adder Subtractor parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:adder_subtractor'
        for k, v in ADDER_SUBTRACTOR_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Adder Subtractor Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='adder_subtractor.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = AdderSubtractorOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
