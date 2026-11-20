import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from gpio_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in gpio_ui.py.
# The keys must match scilab_blocks/casper_xps/gpio.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
GPIO_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'io_group':
    {
        'get': 'get_io_group',
        'set': 'set_io_group'
    },
    'io_group_real':
    {
        'get': 'get_io_group_real',
        'set': 'set_io_group_real'
    },
    'io_group_custom':
    {
        'get': 'get_io_group_custom',
        'set': 'set_io_group_custom'
    },
    'io_dir':
    {
        'get': 'get_io_dir',
        'set': 'set_io_dir'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
    },
    'bitwidth':
    {
        'get': 'get_bitwidth',
        'set': 'set_bitwidth'
    },
    'bin_pt':
    {
        'get': 'get_bin_pt',
        'set': 'set_bin_pt'
    },
    'bit_index':
    {
        'get': 'get_bit_index',
        'set': 'set_bit_index'
    },
    'sample_period':
    {
        'get': 'get_sample_period',
        'set': 'set_sample_period'
    },
    'use_single_ended':
    {
        'get': 'get_use_single_ended',
        'set': 'set_use_single_ended'
    },
    'use_ddr':
    {
        'get': 'get_use_ddr',
        'set': 'set_use_ddr'
    },
    'reg_iob':
    {
        'get': 'get_reg_iob',
        'set': 'set_reg_iob'
    },
    'reg_clk_phase':
    {
        'get': 'get_reg_clk_phase',
        'set': 'set_reg_clk_phase'
    },
    'termination':
    {
        'get': 'get_termination',
        'set': 'set_termination'
    },
    'use_iodelay':
    {
        'get': 'get_use_iodelay',
        'set': 'set_use_iodelay'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class GpioOperations(object):
    def __init__(self, winobj, template_config='gpio.json', target_config='gpio.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('gpio.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('gpio.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('GPIO Mask started.')
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

    def get_io_group(self):
        text = self.ui.io_group.currentText()
        self.logger.debug(f'io_group is {text}')
        return text

    def set_io_group(self, text):
        self.logger.debug(f'Set io_group to {text}')
        self.ui.io_group.setCurrentText(str(text))

    def get_io_group_real(self):
        text = self.ui.io_group_real.currentText()
        self.logger.debug(f'io_group_real is {text}')
        return text

    def set_io_group_real(self, text):
        self.logger.debug(f'Set io_group_real to {text}')
        self.ui.io_group_real.setCurrentText(str(text))

    def get_io_group_custom(self):
        val = self.ui.io_group_custom.text()
        self.logger.debug(f'io_group_custom is {val}')
        return val

    def set_io_group_custom(self, val):
        self.logger.debug(f'Set io_group_custom to {val}')
        self.ui.io_group_custom.setText(str(val))

    def get_io_dir(self):
        text = self.ui.io_dir.currentText()
        self.logger.debug(f'io_dir is {text}')
        return text

    def set_io_dir(self, text):
        self.logger.debug(f'Set io_dir to {text}')
        self.ui.io_dir.setCurrentText(str(text))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        self.ui.arith_type.setCurrentText(str(text))

    def get_bitwidth(self):
        val = self.ui.bitwidth.value()
        self.logger.debug(f'bitwidth is {val}')
        return str(val)

    def set_bitwidth(self, val):
        self.logger.debug(f'Set bitwidth to {val}')
        self.ui.bitwidth.setValue(int(val))

    def get_bin_pt(self):
        val = self.ui.bin_pt.value()
        self.logger.debug(f'bin_pt is {val}')
        return str(val)

    def set_bin_pt(self, val):
        self.logger.debug(f'Set bin_pt to {val}')
        self.ui.bin_pt.setValue(int(val))

    def get_bit_index(self):
        val = self.ui.bit_index.text()
        self.logger.debug(f'bit_index is {val}')
        return val

    def set_bit_index(self, val):
        self.logger.debug(f'Set bit_index to {val}')
        self.ui.bit_index.setText(str(val))

    def get_sample_period(self):
        val = self.ui.sample_period.value()
        self.logger.debug(f'sample_period is {val}')
        return str(val)

    def set_sample_period(self, val):
        self.logger.debug(f'Set sample_period to {val}')
        self.ui.sample_period.setValue(int(val))

    def get_use_single_ended(self):
        status = self.ui.use_single_ended.isChecked()
        self.logger.debug(f'use_single_ended status is {status}')
        return self._convert_status(status)

    def set_use_single_ended(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set use_single_ended status to {status}')
        self.ui.use_single_ended.setChecked(status)

    def get_use_ddr(self):
        status = self.ui.use_ddr.isChecked()
        self.logger.debug(f'use_ddr status is {status}')
        return self._convert_status(status)

    def set_use_ddr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set use_ddr status to {status}')
        self.ui.use_ddr.setChecked(status)

    def get_reg_iob(self):
        status = self.ui.reg_iob.isChecked()
        self.logger.debug(f'reg_iob status is {status}')
        return self._convert_status(status)

    def set_reg_iob(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set reg_iob status to {status}')
        self.ui.reg_iob.setChecked(status)

    def get_reg_clk_phase(self):
        text = self.ui.reg_clk_phase.currentText()
        self.logger.debug(f'reg_clk_phase is {text}')
        return text

    def set_reg_clk_phase(self, text):
        self.logger.debug(f'Set reg_clk_phase to {text}')
        self.ui.reg_clk_phase.setCurrentText(str(text))

    def get_termination(self):
        text = self.ui.termination.currentText()
        self.logger.debug(f'termination is {text}')
        return text

    def set_termination(self, text):
        self.logger.debug(f'Set termination to {text}')
        self.ui.termination.setCurrentText(str(text))

    def get_use_iodelay(self):
        status = self.ui.use_iodelay.isChecked()
        self.logger.debug(f'use_iodelay status is {status}')
        return self._convert_status(status)

    def set_use_iodelay(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set use_iodelay status to {status}')
        self.ui.use_iodelay.setChecked(status)


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        Rules ported from xps_library/gpio_mask.m. bit_index is a MATLAB
        vector-expression string (e.g. "0" or "[0, 1, 2, 3]"); its element
        count must match the real (arith_type-adjusted) I/O bitwidth, or
        half of it in DDR mode -- but gpio_mask.m skips this whole check
        for io_group_real == 'custom'.
        """
        errors = []
        if str(self.get_io_group_custom()).strip() == '':
            errors.append('Custom I/O group must not be empty.')
        bit_index_str = str(self.get_bit_index()).strip()
        if bit_index_str == '':
            errors.append('GPIO bit index must not be empty.')
            return errors
        if self.get_io_group_real() != 'custom':
            bit_index_len = len(bit_index_str.strip('[]').split(','))
            bitwidth = int(self.get_bitwidth())
            real_bitwidth = 1 if self.get_arith_type() == 'Boolean' else bitwidth
            if self.get_use_ddr() == 'on':
                if self.get_reg_iob() != 'on':
                    errors.append('When using DDR signaling mode, "Pack register in the pad" '
                                  'option must be on.')
                if bit_index_len != real_bitwidth / 2:
                    errors.append('GPIO bit index does not have half the number of elements '
                                  'as the I/O bitwidth (required in DDR mode).')
            else:
                if bit_index_len != real_bitwidth:
                    errors.append('GPIO bit index does not have the same number of elements as '
                                  'the I/O bitwidth. When using bitwidths greater than one, '
                                  'specify a vector of bit indices (e.g. "[0, 1, 2, 3]").')
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

    def set_io_group_custom_status(self, is_custom):
        """
        io_group_custom (a raw numeric I/O group index) only means anything
        when io_group_real == 'custom' -- ported from gpio_mask.m's
        io_group_real Callback, which is the only piece of that callback's
        MaskEnables/MaskVisibilities cascade this port re-implements (the
        rest also toggles io_dir/arith_type/etc. visibility for the
        zdok0/zdok1/sync_in/sync_out groups specifically, which needs more
        archaeology of gpio_mask.m's hardware behavior per group to port
        faithfully -- left as a TODO, see the port report).
        """
        self.ui.io_group_custom.setEnabled(is_custom)

    def IOGroupReal_Changed(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('I/O group changed.')
        self.logger.info('---------------------------------------------')
        self.set_io_group_custom_status(self.get_io_group_real() == 'custom')

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.io_group_real.currentIndexChanged.connect(self.IOGroupReal_Changed)

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
            if k in GPIO_CONFIG:
                setfunc = GPIO_CONFIG[k]['set']
                getattr(self, setfunc)(v)
        # apply the dynamic enable/disable rules once the config is loaded
        self.IOGroupReal_Changed()

    def collect_config(self):
        """
        Write the config to the target file.
        Return False without writing anything if the config is invalid.
        """
        errors = self.validate_config()
        if errors:
            for e in errors:
                self.logger.error(e)
            QMessageBox.critical(self.winobj, 'Invalid GPIO parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:gpio'
        for k, v in GPIO_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for GPIO Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='gpio.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = GpioOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
