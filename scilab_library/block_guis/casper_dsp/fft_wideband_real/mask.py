import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from fft_wideband_real_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in fft_wideband_real_ui.py.
# The keys must match scilab_blocks/casper_dsp/fft_wideband_real.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
FFT_WIDEBAND_REAL_CONFIG = {
    'n_streams':
    {
        'get': 'get_n_streams',
        'set': 'set_n_streams'
    },
    'FFTSize':
    {
        'get': 'get_FFTSize',
        'set': 'set_FFTSize'
    },
    'n_inputs':
    {
        'get': 'get_n_inputs',
        'set': 'set_n_inputs'
    },
    'input_bit_width':
    {
        'get': 'get_input_bit_width',
        'set': 'set_input_bit_width'
    },
    'bin_pt_in':
    {
        'get': 'get_bin_pt_in',
        'set': 'set_bin_pt_in'
    },
    'coeff_bit_width':
    {
        'get': 'get_coeff_bit_width',
        'set': 'set_coeff_bit_width'
    },
    'unscramble':
    {
        'get': 'get_unscramble',
        'set': 'set_unscramble'
    },
    'async':
    {
        'get': 'get_async',
        'set': 'set_async'
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
    'exp_width':
    {
        'get': 'get_exp_width',
        'set': 'set_exp_width'
    },
    'frac_width':
    {
        'get': 'get_frac_width',
        'set': 'set_frac_width'
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
    'conv_latency':
    {
        'get': 'get_conv_latency',
        'set': 'set_conv_latency'
    },
    'input_latency':
    {
        'get': 'get_input_latency',
        'set': 'set_input_latency'
    },
    'biplex_direct_latency':
    {
        'get': 'get_biplex_direct_latency',
        'set': 'set_biplex_direct_latency'
    },
    'add_pipe_latency':
    {
        'get': 'get_add_pipe_latency',
        'set': 'set_add_pipe_latency'
    },
    'mult_pipe_latency':
    {
        'get': 'get_mult_pipe_latency',
        'set': 'set_mult_pipe_latency'
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
    'delays_bit_limit':
    {
        'get': 'get_delays_bit_limit',
        'set': 'set_delays_bit_limit'
    },
    'coeffs_bit_limit':
    {
        'get': 'get_coeffs_bit_limit',
        'set': 'set_coeffs_bit_limit'
    },
    'coeff_sharing':
    {
        'get': 'get_coeff_sharing',
        'set': 'set_coeff_sharing'
    },
    'coeff_decimation':
    {
        'get': 'get_coeff_decimation',
        'set': 'set_coeff_decimation'
    },
    'coeff_generation':
    {
        'get': 'get_coeff_generation',
        'set': 'set_coeff_generation'
    },
    'cal_bits':
    {
        'get': 'get_cal_bits',
        'set': 'set_cal_bits'
    },
    'n_bits_rotation':
    {
        'get': 'get_n_bits_rotation',
        'set': 'set_n_bits_rotation'
    },
    'mult_spec':
    {
        'get': 'get_mult_spec',
        'set': 'set_mult_spec'
    },
    'max_fanout':
    {
        'get': 'get_max_fanout',
        'set': 'set_max_fanout'
    },
    'bitgrowth':
    {
        'get': 'get_bitgrowth',
        'set': 'set_bitgrowth'
    },
    'max_bits':
    {
        'get': 'get_max_bits',
        'set': 'set_max_bits'
    },
    'hardcode_shifts':
    {
        'get': 'get_hardcode_shifts',
        'set': 'set_hardcode_shifts'
    },
    'shift_schedule':
    {
        'get': 'get_shift_schedule',
        'set': 'set_shift_schedule'
    },
    'dsp48_adders':
    {
        'get': 'get_dsp48_adders',
        'set': 'set_dsp48_adders'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class FftWidebandRealOperations(object):
    def __init__(self, winobj, template_config='fft_wideband_real.json', target_config='fft_wideband_real.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('fft_wideband_real.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('fft_wideband_real.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('fft_wideband_real Configuration Mask started.')
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
    def get_n_streams(self):
        val = self.ui.n_streams.value()
        self.logger.debug(f'n_streams is {val}')
        return str(val)

    def set_n_streams(self, val):
        self.logger.debug(f'Set n_streams to {val}')
        self.ui.n_streams.setValue(int(val))

    def get_FFTSize(self):
        val = self.ui.FFTSize.text()
        self.logger.debug(f'FFTSize is {val}')
        return val

    def set_FFTSize(self, val):
        self.logger.debug(f'Set FFTSize to {val}')
        self.ui.FFTSize.setText(str(val))

    def get_n_inputs(self):
        val = self.ui.n_inputs.value()
        self.logger.debug(f'n_inputs is {val}')
        return str(val)

    def set_n_inputs(self, val):
        self.logger.debug(f'Set n_inputs to {val}')
        self.ui.n_inputs.setValue(int(val))

    def get_input_bit_width(self):
        val = self.ui.input_bit_width.value()
        self.logger.debug(f'input_bit_width is {val}')
        return str(val)

    def set_input_bit_width(self, val):
        self.logger.debug(f'Set input_bit_width to {val}')
        self.ui.input_bit_width.setValue(int(val))

    def get_bin_pt_in(self):
        val = self.ui.bin_pt_in.text()
        self.logger.debug(f'bin_pt_in is {val}')
        return val

    def set_bin_pt_in(self, val):
        self.logger.debug(f'Set bin_pt_in to {val}')
        self.ui.bin_pt_in.setText(str(val))

    def get_coeff_bit_width(self):
        val = self.ui.coeff_bit_width.value()
        self.logger.debug(f'coeff_bit_width is {val}')
        return str(val)

    def set_coeff_bit_width(self, val):
        self.logger.debug(f'Set coeff_bit_width to {val}')
        self.ui.coeff_bit_width.setValue(int(val))

    def get_unscramble(self):
        status = self.ui.unscramble.isChecked()
        self.logger.debug(f'unscramble status is {status}')
        return self._convert_status(status)

    def set_unscramble(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set unscramble status to {status}')
        self.ui.unscramble.setChecked(status)

    def get_async(self):
        # 'async' is a Python reserved keyword -- getattr(), not .async
        status = getattr(self.ui, 'async').isChecked()
        self.logger.debug(f'async status is {status}')
        return self._convert_status(status)

    def set_async(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set async status to {status}')
        getattr(self.ui, 'async').setChecked(status)

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

    def get_exp_width(self):
        val = self.ui.exp_width.text()
        self.logger.debug(f'exp_width is {val}')
        return val

    def set_exp_width(self, val):
        self.logger.debug(f'Set exp_width to {val}')
        self.ui.exp_width.setText(str(val))

    def get_frac_width(self):
        val = self.ui.frac_width.text()
        self.logger.debug(f'frac_width is {val}')
        return val

    def set_frac_width(self, val):
        self.logger.debug(f'Set frac_width to {val}')
        self.ui.frac_width.setText(str(val))

    def get_add_latency(self):
        val = self.ui.add_latency.value()
        self.logger.debug(f'add_latency is {val}')
        return str(val)

    def set_add_latency(self, val):
        self.logger.debug(f'Set add_latency to {val}')
        self.ui.add_latency.setValue(int(val))

    def get_mult_latency(self):
        val = self.ui.mult_latency.value()
        self.logger.debug(f'mult_latency is {val}')
        return str(val)

    def set_mult_latency(self, val):
        self.logger.debug(f'Set mult_latency to {val}')
        self.ui.mult_latency.setValue(int(val))

    def get_bram_latency(self):
        val = self.ui.bram_latency.value()
        self.logger.debug(f'bram_latency is {val}')
        return str(val)

    def set_bram_latency(self, val):
        self.logger.debug(f'Set bram_latency to {val}')
        self.ui.bram_latency.setValue(int(val))

    def get_conv_latency(self):
        val = self.ui.conv_latency.value()
        self.logger.debug(f'conv_latency is {val}')
        return str(val)

    def set_conv_latency(self, val):
        self.logger.debug(f'Set conv_latency to {val}')
        self.ui.conv_latency.setValue(int(val))

    def get_input_latency(self):
        val = self.ui.input_latency.value()
        self.logger.debug(f'input_latency is {val}')
        return str(val)

    def set_input_latency(self, val):
        self.logger.debug(f'Set input_latency to {val}')
        self.ui.input_latency.setValue(int(val))

    def get_biplex_direct_latency(self):
        val = self.ui.biplex_direct_latency.value()
        self.logger.debug(f'biplex_direct_latency is {val}')
        return str(val)

    def set_biplex_direct_latency(self, val):
        self.logger.debug(f'Set biplex_direct_latency to {val}')
        self.ui.biplex_direct_latency.setValue(int(val))

    def get_add_pipe_latency(self):
        val = self.ui.add_pipe_latency.text()
        self.logger.debug(f'add_pipe_latency is {val}')
        return val

    def set_add_pipe_latency(self, val):
        self.logger.debug(f'Set add_pipe_latency to {val}')
        self.ui.add_pipe_latency.setText(str(val))

    def get_mult_pipe_latency(self):
        val = self.ui.mult_pipe_latency.text()
        self.logger.debug(f'mult_pipe_latency is {val}')
        return val

    def set_mult_pipe_latency(self, val):
        self.logger.debug(f'Set mult_pipe_latency to {val}')
        self.ui.mult_pipe_latency.setText(str(val))

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

    def get_delays_bit_limit(self):
        val = self.ui.delays_bit_limit.value()
        self.logger.debug(f'delays_bit_limit is {val}')
        return str(val)

    def set_delays_bit_limit(self, val):
        self.logger.debug(f'Set delays_bit_limit to {val}')
        self.ui.delays_bit_limit.setValue(int(val))

    def get_coeffs_bit_limit(self):
        val = self.ui.coeffs_bit_limit.value()
        self.logger.debug(f'coeffs_bit_limit is {val}')
        return str(val)

    def set_coeffs_bit_limit(self, val):
        self.logger.debug(f'Set coeffs_bit_limit to {val}')
        self.ui.coeffs_bit_limit.setValue(int(val))

    def get_coeff_sharing(self):
        status = self.ui.coeff_sharing.isChecked()
        self.logger.debug(f'coeff_sharing status is {status}')
        return self._convert_status(status)

    def set_coeff_sharing(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set coeff_sharing status to {status}')
        self.ui.coeff_sharing.setChecked(status)

    def get_coeff_decimation(self):
        status = self.ui.coeff_decimation.isChecked()
        self.logger.debug(f'coeff_decimation status is {status}')
        return self._convert_status(status)

    def set_coeff_decimation(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set coeff_decimation status to {status}')
        self.ui.coeff_decimation.setChecked(status)

    def get_coeff_generation(self):
        status = self.ui.coeff_generation.isChecked()
        self.logger.debug(f'coeff_generation status is {status}')
        return self._convert_status(status)

    def set_coeff_generation(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set coeff_generation status to {status}')
        self.ui.coeff_generation.setChecked(status)

    def get_cal_bits(self):
        val = self.ui.cal_bits.text()
        self.logger.debug(f'cal_bits is {val}')
        return val

    def set_cal_bits(self, val):
        self.logger.debug(f'Set cal_bits to {val}')
        self.ui.cal_bits.setText(str(val))

    def get_n_bits_rotation(self):
        val = self.ui.n_bits_rotation.text()
        self.logger.debug(f'n_bits_rotation is {val}')
        return val

    def set_n_bits_rotation(self, val):
        self.logger.debug(f'Set n_bits_rotation to {val}')
        self.ui.n_bits_rotation.setText(str(val))

    def get_mult_spec(self):
        val = self.ui.mult_spec.text()
        self.logger.debug(f'mult_spec is {val}')
        return val

    def set_mult_spec(self, val):
        self.logger.debug(f'Set mult_spec to {val}')
        self.ui.mult_spec.setText(str(val))

    def get_max_fanout(self):
        val = self.ui.max_fanout.value()
        self.logger.debug(f'max_fanout is {val}')
        return str(val)

    def set_max_fanout(self, val):
        self.logger.debug(f'Set max_fanout to {val}')
        self.ui.max_fanout.setValue(int(val))

    def get_bitgrowth(self):
        status = self.ui.bitgrowth.isChecked()
        self.logger.debug(f'bitgrowth status is {status}')
        return self._convert_status(status)

    def set_bitgrowth(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set bitgrowth status to {status}')
        self.ui.bitgrowth.setChecked(status)

    def get_max_bits(self):
        val = self.ui.max_bits.value()
        self.logger.debug(f'max_bits is {val}')
        return str(val)

    def set_max_bits(self, val):
        self.logger.debug(f'Set max_bits to {val}')
        self.ui.max_bits.setValue(int(val))

    def get_hardcode_shifts(self):
        status = self.ui.hardcode_shifts.isChecked()
        self.logger.debug(f'hardcode_shifts status is {status}')
        return self._convert_status(status)

    def set_hardcode_shifts(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set hardcode_shifts status to {status}')
        self.ui.hardcode_shifts.setChecked(status)

    def get_shift_schedule(self):
        val = self.ui.shift_schedule.text()
        self.logger.debug(f'shift_schedule is {val}')
        return val

    def set_shift_schedule(self, val):
        self.logger.debug(f'Set shift_schedule to {val}')
        self.ui.shift_schedule.setText(str(val))

    def get_dsp48_adders(self):
        status = self.ui.dsp48_adders.isChecked()
        self.logger.debug(f'dsp48_adders status is {status}')
        return self._convert_status(status)

    def set_dsp48_adders(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dsp48_adders status to {status}')
        self.ui.dsp48_adders.setChecked(status)


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        Rules ported from fft_wideband_real_init.m / the HDL backend
        (casper_dsp/rtl/FFTs/fft_wideband_real.sv) rather than just checking
        for non-empty fields -- see mlib_devel_notes/fft_wideband_real_hdl_plan.md
        for the full rationale (design decision 3: async/floating_point are
        declared mask parameters but not yet implemented by the HDL, and
        $fatal at elaboration if set to anything other than their default
        'off').
        """
        errors = []
        try:
            n_streams = int(float(self.get_n_streams()))
        except ValueError:
            n_streams = None
            errors.append('Number simultaneous streams must be an integer.')
        try:
            n_inputs = int(float(self.get_n_inputs()))
        except ValueError:
            n_inputs = None
            errors.append('Number of Simultaneous Inputs must be an integer.')
        try:
            fft_size = int(float(self.get_FFTSize()))
        except ValueError:
            fft_size = None
            errors.append('Size of FFT must be an integer.')

        if n_inputs is not None and n_inputs < 1:
            errors.append('Number of Simultaneous Inputs must be >= 1.')
        if n_streams is not None and n_streams < 1:
            errors.append('Number simultaneous streams must be >= 1.')
        if fft_size is not None and n_inputs is not None:
            if fft_size - n_inputs < 3:
                errors.append(
                    'FFTSize - n_inputs must be >= 3 for a working FFT '
                    '(FFTSize - n_inputs == 2 reproduces a known upstream '
                    'casper_library bug in the real-FFT unscrambling stage, '
                    'bit-exactly, and does not compute a correct FFT -- see '
                    "Phase 5's findings in the HDL plan doc).")
        if n_streams is not None and n_inputs is not None:
            if (n_streams * (2 ** max(n_inputs, 0))) % 4 != 0:
                errors.append(
                    '(2^n_inputs) * n_streams must be a multiple of 4.')

        if str(self.get_async()).strip().lower() == 'on':
            errors.append(
                'Asynchronous operation is not supported by the HDL backend '
                'yet -- must stay off (elaboration would $fatal).')
        if str(self.get_floating_point()).strip().lower() == 'on':
            errors.append(
                'Floating point is not supported by the HDL backend yet -- '
                'must stay off (elaboration would $fatal).')

        if str(self.get_FFTSize()).strip() == '':
            errors.append('Size of FFT: (2^? pts) must not be empty.')
        if str(self.get_bin_pt_in()).strip() == '':
            errors.append('Input binary point must not be empty.')
        if str(self.get_exp_width()).strip() == '':
            errors.append('exponent width must not be empty.')
        if str(self.get_frac_width()).strip() == '':
            errors.append('fraction width must not be empty.')
        if str(self.get_add_pipe_latency()).strip() == '':
            errors.append('Add Interface Pipeline Latency (declared, not yet implemented by the HDL backend) must not be empty.')
        if str(self.get_mult_pipe_latency()).strip() == '':
            errors.append('CMult Pipeline Latency (declared, not yet implemented by the HDL backend) must not be empty.')
        if str(self.get_cal_bits()).strip() == '':
            errors.append('Number calibration locations when generating coeffs (2^?) (declared, not yet implemented by the HDL backend) must not be empty.')
        if str(self.get_n_bits_rotation()).strip() == '':
            errors.append('Feedback rotation vector resolution (declared, not yet implemented by the HDL backend) must not be empty.')
        if str(self.get_mult_spec()).strip() == '':
            errors.append('Multiplier impl. (0=core, 1=embedded, 2=behavioural) (left=1st stage, or just one value) (declared, not yet implemented by the HDL backend) must not be empty.')
        if str(self.get_shift_schedule()).strip() == '':
            errors.append('Shift schedule must not be empty.')
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
            if k in FFT_WIDEBAND_REAL_CONFIG:
                setfunc = FFT_WIDEBAND_REAL_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid fft_wideband_real Configuration parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:fft_wideband_real'
        for k, v in FFT_WIDEBAND_REAL_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for fft_wideband_real Configuration Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='fft_wideband_real.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = FftWidebandRealOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
