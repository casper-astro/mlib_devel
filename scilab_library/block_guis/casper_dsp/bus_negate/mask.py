import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from bus_negate_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in bus_negate_ui.py.
# The keys must match scilab_blocks/casper_dsp/bus_negate.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
BUS_NEGATE_CONFIG = {
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
    'bin_pt_in':
    {
        'get': 'get_bin_pt_in',
        'set': 'set_bin_pt_in'
    },
    'cmplx':
    {
        'get': 'get_cmplx',
        'set': 'set_cmplx'
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
    'n_vectors':
    {
        'get': 'get_n_vectors',
        'set': 'set_n_vectors'
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


class BusNegateOperations(object):
    def __init__(self, winobj, template_config='bus_negate.json', target_config='bus_negate.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('bus_negate.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('bus_negate.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Bus Negate Mask started.')
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
    def get_n_bits_in(self):
        val = self.ui.n_bits_in.text()
        self.logger.debug(f'n_bits_in is {val}')
        return val

    def set_n_bits_in(self, val):
        self.logger.debug(f'Set n_bits_in to {val}')
        self.ui.n_bits_in.setText(str(val))

    def get_bin_pt_in(self):
        val = self.ui.bin_pt_in.text()
        self.logger.debug(f'bin_pt_in is {val}')
        return val

    def set_bin_pt_in(self, val):
        self.logger.debug(f'Set bin_pt_in to {val}')
        self.ui.bin_pt_in.setText(str(val))

    def get_cmplx(self):
        status = self.ui.cmplx.isChecked()
        self.logger.debug(f'cmplx status is {status}')
        return self._convert_status(status)

    def set_cmplx(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cmplx status to {status}')
        self.ui.cmplx.setChecked(status)

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

    def get_n_vectors(self):
        val = self.ui.n_vectors.text()
        self.logger.debug(f'n_vectors is {val}')
        return val

    def set_n_vectors(self, val):
        self.logger.debug(f'Set n_vectors to {val}')
        self.ui.n_vectors.setText(str(val))

    def get_overflow(self):
        val = self.ui.overflow.text()
        self.logger.debug(f'overflow is {val}')
        return val

    def set_overflow(self, val):
        self.logger.debug(f'Set overflow to {val}')
        self.ui.overflow.setText(str(val))

    def get_csp_latency(self):
        val = self.ui.csp_latency.text()
        self.logger.debug(f'csp_latency is {val}')
        return val

    def set_csp_latency(self, val):
        self.logger.debug(f'Set csp_latency to {val}')
        self.ui.csp_latency.setText(str(val))


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
        if str(self.get_n_bits_in()).strip() == '':
            errors.append('input bit widths must not be empty.')
        if str(self.get_bin_pt_in()).strip() == '':
            errors.append('input binary points must not be empty.')
        if str(self.get_exp_width()).strip() == '':
            errors.append('exponent width must not be empty.')
        if str(self.get_frac_width()).strip() == '':
            errors.append('fraction width must not be empty.')
        if str(self.get_n_vectors()).strip() == '':
            errors.append('n_vectors must not be empty.')
        if str(self.get_overflow()).strip() == '':
            errors.append('overflow strategy (Wrap=0, Saturate=1, Flag as error=2) must not be empty.')
        if str(self.get_csp_latency()).strip() == '':
            errors.append('latency must not be empty.')
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
            if k in BUS_NEGATE_CONFIG:
                setfunc = BUS_NEGATE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Bus Negate parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:bus_negate'
        for k, v in BUS_NEGATE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Bus Negate Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='bus_negate.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = BusNegateOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
