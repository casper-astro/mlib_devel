import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from bus_mult_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in bus_mult_ui.py.
# The keys must match scilab_blocks/casper_dsp/bus_mult.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
BUS_MULT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
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
    'cmplx_a':
    {
        'get': 'get_cmplx_a',
        'set': 'set_cmplx_a'
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
    'cmplx_b':
    {
        'get': 'get_cmplx_b',
        'set': 'set_cmplx_b'
    },
    'misc':
    {
        'get': 'get_misc',
        'set': 'set_misc'
    },
    'floating_point':
    {
        'get': 'get_floating_point',
        'set': 'set_floating_point'
    },
    'float_type':
    {
        'get': 'get_float_type',
        'set': 'set_float_type'
    },
    'input_vec_a':
    {
        'get': 'get_input_vec_a',
        'set': 'set_input_vec_a'
    },
    'input_vec_b':
    {
        'get': 'get_input_vec_b',
        'set': 'set_input_vec_b'
    },
    'frac_width':
    {
        'get': 'get_frac_width',
        'set': 'set_frac_width'
    },
    'exp_width':
    {
        'get': 'get_exp_width',
        'set': 'set_exp_width'
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
    'conv_latency':
    {
        'get': 'get_conv_latency',
        'set': 'set_conv_latency'
    },
    'max_fanout':
    {
        'get': 'get_max_fanout',
        'set': 'set_max_fanout'
    },
    'fan_latency':
    {
        'get': 'get_fan_latency',
        'set': 'set_fan_latency'
    },
    'multiplier_implementation':
    {
        'get': 'get_multiplier_implementation',
        'set': 'set_multiplier_implementation'
    },
    'pipeline_cmult_en':
    {
        'get': 'get_pipeline_cmult_en',
        'set': 'set_pipeline_cmult_en'
    },
    'pipeline_latency':
    {
        'get': 'get_pipeline_latency',
        'set': 'set_pipeline_latency'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class BusMultOperations(object):
    def __init__(self, winobj, template_config='bus_mult.json', target_config='bus_mult.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('bus_mult.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('bus_mult.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Bus Multiplier Mask started.')
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
    def get_n_bits_a(self):
        val = self.ui.n_bits_a.text()
        self.logger.debug(f'n_bits_a is {val}')
        return val

    def set_n_bits_a(self, val):
        self.logger.debug(f'Set n_bits_a to {val}')
        self.ui.n_bits_a.setText(str(val))

    def get_bin_pt_a(self):
        val = self.ui.bin_pt_a.text()
        self.logger.debug(f'bin_pt_a is {val}')
        return val

    def set_bin_pt_a(self, val):
        self.logger.debug(f'Set bin_pt_a to {val}')
        self.ui.bin_pt_a.setText(str(val))

    def get_type_a(self):
        val = self.ui.type_a.text()
        self.logger.debug(f'type_a is {val}')
        return val

    def set_type_a(self, val):
        self.logger.debug(f'Set type_a to {val}')
        self.ui.type_a.setText(str(val))

    def get_cmplx_a(self):
        status = self.ui.cmplx_a.isChecked()
        self.logger.debug(f'cmplx_a status is {status}')
        return self._convert_status(status)

    def set_cmplx_a(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cmplx_a status to {status}')
        self.ui.cmplx_a.setChecked(status)

    def get_n_bits_b(self):
        val = self.ui.n_bits_b.text()
        self.logger.debug(f'n_bits_b is {val}')
        return val

    def set_n_bits_b(self, val):
        self.logger.debug(f'Set n_bits_b to {val}')
        self.ui.n_bits_b.setText(str(val))

    def get_bin_pt_b(self):
        val = self.ui.bin_pt_b.text()
        self.logger.debug(f'bin_pt_b is {val}')
        return val

    def set_bin_pt_b(self, val):
        self.logger.debug(f'Set bin_pt_b to {val}')
        self.ui.bin_pt_b.setText(str(val))

    def get_type_b(self):
        val = self.ui.type_b.text()
        self.logger.debug(f'type_b is {val}')
        return val

    def set_type_b(self, val):
        self.logger.debug(f'Set type_b to {val}')
        self.ui.type_b.setText(str(val))

    def get_cmplx_b(self):
        status = self.ui.cmplx_b.isChecked()
        self.logger.debug(f'cmplx_b status is {status}')
        return self._convert_status(status)

    def set_cmplx_b(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cmplx_b status to {status}')
        self.ui.cmplx_b.setChecked(status)

    def get_misc(self):
        status = self.ui.misc.isChecked()
        self.logger.debug(f'misc status is {status}')
        return self._convert_status(status)

    def set_misc(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set misc status to {status}')
        self.ui.misc.setChecked(status)

    def get_floating_point(self):
        status = self.ui.floating_point.isChecked()
        self.logger.debug(f'floating_point status is {status}')
        return self._convert_status(status)

    def set_floating_point(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set floating_point status to {status}')
        self.ui.floating_point.setChecked(status)

    def get_float_type(self):
        text = self.ui.float_type.currentText()
        self.logger.debug(f'float_type is {text}')
        return text

    def set_float_type(self, text):
        self.logger.debug(f'Set float_type to {text}')
        self.ui.float_type.setCurrentText(str(text))

    def get_input_vec_a(self):
        val = self.ui.input_vec_a.text()
        self.logger.debug(f'input_vec_a is {val}')
        return val

    def set_input_vec_a(self, val):
        self.logger.debug(f'Set input_vec_a to {val}')
        self.ui.input_vec_a.setText(str(val))

    def get_input_vec_b(self):
        val = self.ui.input_vec_b.text()
        self.logger.debug(f'input_vec_b is {val}')
        return val

    def set_input_vec_b(self, val):
        self.logger.debug(f'Set input_vec_b to {val}')
        self.ui.input_vec_b.setText(str(val))

    def get_frac_width(self):
        val = self.ui.frac_width.text()
        self.logger.debug(f'frac_width is {val}')
        return val

    def set_frac_width(self, val):
        self.logger.debug(f'Set frac_width to {val}')
        self.ui.frac_width.setText(str(val))

    def get_exp_width(self):
        val = self.ui.exp_width.text()
        self.logger.debug(f'exp_width is {val}')
        return val

    def set_exp_width(self, val):
        self.logger.debug(f'Set exp_width to {val}')
        self.ui.exp_width.setText(str(val))

    def get_n_bits_out(self):
        val = self.ui.n_bits_out.text()
        self.logger.debug(f'n_bits_out is {val}')
        return val

    def set_n_bits_out(self, val):
        self.logger.debug(f'Set n_bits_out to {val}')
        self.ui.n_bits_out.setText(str(val))

    def get_bin_pt_out(self):
        val = self.ui.bin_pt_out.text()
        self.logger.debug(f'bin_pt_out is {val}')
        return val

    def set_bin_pt_out(self, val):
        self.logger.debug(f'Set bin_pt_out to {val}')
        self.ui.bin_pt_out.setText(str(val))

    def get_type_out(self):
        val = self.ui.type_out.text()
        self.logger.debug(f'type_out is {val}')
        return val

    def set_type_out(self, val):
        self.logger.debug(f'Set type_out to {val}')
        self.ui.type_out.setText(str(val))

    def get_quantization(self):
        val = self.ui.quantization.text()
        self.logger.debug(f'quantization is {val}')
        return val

    def set_quantization(self, val):
        self.logger.debug(f'Set quantization to {val}')
        self.ui.quantization.setText(str(val))

    def get_overflow(self):
        val = self.ui.overflow.text()
        self.logger.debug(f'overflow is {val}')
        return val

    def set_overflow(self, val):
        self.logger.debug(f'Set overflow to {val}')
        self.ui.overflow.setText(str(val))

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

    def get_conv_latency(self):
        val = self.ui.conv_latency.text()
        self.logger.debug(f'conv_latency is {val}')
        return val

    def set_conv_latency(self, val):
        self.logger.debug(f'Set conv_latency to {val}')
        self.ui.conv_latency.setText(str(val))

    def get_max_fanout(self):
        val = self.ui.max_fanout.text()
        self.logger.debug(f'max_fanout is {val}')
        return val

    def set_max_fanout(self, val):
        self.logger.debug(f'Set max_fanout to {val}')
        self.ui.max_fanout.setText(str(val))

    def get_fan_latency(self):
        val = self.ui.fan_latency.text()
        self.logger.debug(f'fan_latency is {val}')
        return val

    def set_fan_latency(self, val):
        self.logger.debug(f'Set fan_latency to {val}')
        self.ui.fan_latency.setText(str(val))

    def get_multiplier_implementation(self):
        text = self.ui.multiplier_implementation.currentText()
        self.logger.debug(f'multiplier_implementation is {text}')
        return text

    def set_multiplier_implementation(self, text):
        self.logger.debug(f'Set multiplier_implementation to {text}')
        self.ui.multiplier_implementation.setCurrentText(str(text))

    def get_pipeline_cmult_en(self):
        status = self.ui.pipeline_cmult_en.isChecked()
        self.logger.debug(f'pipeline_cmult_en status is {status}')
        return self._convert_status(status)

    def set_pipeline_cmult_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set pipeline_cmult_en status to {status}')
        self.ui.pipeline_cmult_en.setChecked(status)

    def get_pipeline_latency(self):
        val = self.ui.pipeline_latency.text()
        self.logger.debug(f'pipeline_latency is {val}')
        return val

    def set_pipeline_latency(self, val):
        self.logger.debug(f'Set pipeline_latency to {val}')
        self.ui.pipeline_latency.setText(str(val))


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
        if str(self.get_n_bits_a()).strip() == '':
            errors.append('a input bit widths must not be empty.')
        if str(self.get_bin_pt_a()).strip() == '':
            errors.append('a input binary points must not be empty.')
        if str(self.get_type_a()).strip() == '':
            errors.append('a input type (Unsigned=0, Signed=1) must not be empty.')
        if str(self.get_n_bits_b()).strip() == '':
            errors.append('b input bit widths must not be empty.')
        if str(self.get_bin_pt_b()).strip() == '':
            errors.append('b input binary points must not be empty.')
        if str(self.get_type_b()).strip() == '':
            errors.append('b input type (Unsigned=0, Signed=1) must not be empty.')
        if str(self.get_input_vec_a()).strip() == '':
            errors.append('a input vector in bus must not be empty.')
        if str(self.get_input_vec_b()).strip() == '':
            errors.append('b input vector in bus must not be empty.')
        if str(self.get_frac_width()).strip() == '':
            errors.append('fraction width must not be empty.')
        if str(self.get_exp_width()).strip() == '':
            errors.append('exponent width must not be empty.')
        if str(self.get_n_bits_out()).strip() == '':
            errors.append('output bit widths must not be empty.')
        if str(self.get_bin_pt_out()).strip() == '':
            errors.append('output binary points must not be empty.')
        if str(self.get_type_out()).strip() == '':
            errors.append('output type (Unsigned=0, Signed=1) must not be empty.')
        if str(self.get_quantization()).strip() == '':
            errors.append('quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1, , Round  (unbiased: Even Values)=2) must not be empty.')
        if str(self.get_overflow()).strip() == '':
            errors.append('overflow strategy (Wrap=0, Saturate=1, Flag as error=2) must not be empty.')
        if str(self.get_mult_latency()).strip() == '':
            errors.append('multiplier latency must not be empty.')
        if str(self.get_add_latency()).strip() == '':
            errors.append('adder latency must not be empty.')
        if str(self.get_conv_latency()).strip() == '':
            errors.append('convert latency must not be empty.')
        if str(self.get_max_fanout()).strip() == '':
            errors.append('limit fanout to ? must not be empty.')
        if str(self.get_fan_latency()).strip() == '':
            errors.append('fanout register latency must not be empty.')
        if str(self.get_pipeline_latency()).strip() == '':
            errors.append('pipeline latency must not be empty.')
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
            if k in BUS_MULT_CONFIG:
                setfunc = BUS_MULT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Bus Multiplier parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:bus_mult'
        for k, v in BUS_MULT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Bus Multiplier Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='bus_mult.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = BusMultOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
