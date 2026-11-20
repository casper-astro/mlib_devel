import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon, QRegularExpressionValidator
from PyQt6.QtCore import QRegularExpression
from sw_reg_ui import Ui_MainWindow
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in sw_reg_ui.py.
# The keys must match scilab_blocks/casper_xps/swreg.json, as the Scilab side
# (update_exprs) only reads back the keys listed in that template.
# The legacy 'mode' parameter is not used here, because it is deprecated in
# the xps_library swreg block (see swreg_cb.m): the number of fields is given
# by the number of names, as in bitfield_maskcheck.m.
SWREG_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'io_dir':
    {
        'get': 'get_io_dir',
        'set': 'set_io_dir'
    },
    'io_delay':
    {
        'get': 'get_io_delay',
        'set': 'set_io_delay'
    },
    'init_val':
    {
        'get': 'get_init_val',
        'set': 'set_init_val'
    },
    'sample_period':
    {
        'get': 'get_sample_period',
        'set': 'set_sample_period'
    },
    'names':
    {
        'get': 'get_names',
        'set': 'set_names'
    },
    'bitwidths':
    {
        'get': 'get_bitwidths',
        'set': 'set_bitwidths'
    },
    'bin_pts':
    {
        'get': 'get_bin_pts',
        'set': 'set_bin_pts'
    },
    'arith_types':
    {
        'get': 'get_arith_types',
        'set': 'set_arith_types'
    },
    'sim_port':
    {
        'get': 'get_sim_port',
        'set': 'set_sim_port'
    },
    'show_format':
    {
        'get': 'get_show_format',
        'set': 'set_show_format'
    }
}

# the software register is always 32 bits wide
SWREG_WIDTH = 32


def str_to_list(s):
    """
    Convert a list string, e.g. "[a, b]" or "8 24", to a list of strings.
    Same as str_to_cell_list in casper_library/bitfield_maskcheck.m.
    """
    s = str(s)
    for c in ['[', ']', ',', ';', '\'', '"']:
        s = s.replace(c, ' ')
    return s.split()


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class SWREGOperations(object):
    def __init__(self, winobj, template_config='sw_reg.json', target_config='sw_reg.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('sw_reg.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('sw_reg.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Software Register Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        # init_val is a 32-bit unsigned value, which doesn't fit in a QSpinBox
        self.ui.init_val.setValidator(QRegularExpressionValidator(QRegularExpression(r'\d{1,10}'), self.ui.init_val))
        self.load_config()
        self.setup_signal_functions()

    def _convert_status(self, status):
        # the checkbox status is saved as 'on'/'off', which is the same as
        # the Simulink mask and swreg.json, and is handled by val_format_conv
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

    def get_io_dir(self):
        text = self.ui.io_dir.currentText()
        self.logger.debug(f'io_dir is {text}')
        return text

    def set_io_dir(self, text):
        self.logger.debug(f'Set io_dir to {text}')
        self.ui.io_dir.setCurrentText(str(text))

    def get_init_val(self):
        val = self.ui.init_val.text()
        self.logger.debug(f'init_val is {val}')
        return val

    def set_init_val(self, val):
        self.logger.debug(f'Set init_val to {val}')
        self.ui.init_val.setText(str(val))

    def get_names(self):
        val = self.ui.names.text()
        self.logger.debug(f'names is {val}')
        return val

    def set_names(self, val):
        self.logger.debug(f'Set names to {val}')
        self.ui.names.setText(str(val))

    def get_bitwidths(self):
        val = self.ui.bitwidths.text()
        self.logger.debug(f'bitwidths is {val}')
        return val

    def set_bitwidths(self, val):
        self.logger.debug(f'Set bitwidths to {val}')
        self.ui.bitwidths.setText(str(val))

    def get_bin_pts(self):
        val = self.ui.bin_pts.text()
        self.logger.debug(f'bin_pts is {val}')
        return val

    def set_bin_pts(self, val):
        self.logger.debug(f'Set bin_pts to {val}')
        self.ui.bin_pts.setText(str(val))

    def get_arith_types(self):
        val = self.ui.arith_types.text()
        self.logger.debug(f'arith_types is {val}')
        return val

    def set_arith_types(self, val):
        self.logger.debug(f'Set arith_types to {val}')
        self.ui.arith_types.setText(str(val))

    def get_io_delay(self):
        val = self.ui.io_delay.value()
        self.logger.debug(f'io_delay is {val}')
        return str(val)

    def set_io_delay(self, val):
        self.logger.debug(f'Set io_delay to {val}')
        self.ui.io_delay.setValue(int(val))

    def get_sample_period(self):
        val = self.ui.sample_period.value()
        self.logger.debug(f'sample_period is {val}')
        return str(val)

    def set_sample_period(self, val):
        self.logger.debug(f'Set sample_period to {val}')
        self.ui.sample_period.setValue(int(val))

    def get_sim_port(self):
        status = self.ui.sim_port.isChecked()
        self.logger.debug(f'sim_port status is {status}')
        return self._convert_status(status)

    def set_sim_port(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set sim_port status to {status}')
        self.ui.sim_port.setChecked(status)

    def get_show_format(self):
        status = self.ui.show_format.isChecked()
        self.logger.debug(f'show_format status is {status}')
        return self._convert_status(status)

    def set_show_format(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set show_format status to {status}')
        self.ui.show_format.setChecked(status)

    def set_io_dir_status(self, from_processor):
        """
        init_val and sample_period only make sense for registers written by
        the processor (From Processor).
        """
        self.ui.init_val.setEnabled(from_processor)
        self.ui.sample_period.setEnabled(from_processor)

    # *******************************************************************
    # Validation, same rules as casper_library/bitfield_maskcheck.m
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        errors = []
        names = str_to_list(self.get_names())
        numios = len(names)
        if numios == 0:
            errors.append('At least one field name is required.')
            return errors
        if len(set(names)) != numios:
            errors.append('Field names must be unique.')
        fields = {}
        for key, label in [('bitwidths', 'Bitwidth'), ('bin_pts', 'Binary point'), ('arith_types', 'Data type')]:
            vals = str_to_list(getattr(self, SWREG_CONFIG[key]['get'])())
            try:
                vals = [int(v) for v in vals]
            except ValueError:
                errors.append(f'{label} values must be integers.')
                continue
            if len(vals) == 1:
                vals = vals * numios
            elif len(vals) != numios:
                errors.append(f'{label} vector must be the same length as the number of names ({numios}), or one.')
                continue
            fields[key] = vals
        if 'arith_types' in fields and any(t not in [0, 1, 2] for t in fields['arith_types']):
            errors.append('Data type must be 0 (ufix), 1 (fix) or 2 (bool).')
        if 'bitwidths' in fields:
            widths = fields['bitwidths']
            if any(w < 1 for w in widths):
                errors.append('Bitwidths must be at least 1.')
            elif sum(widths) > SWREG_WIDTH:
                errors.append(f'Total bitwidth ({sum(widths)}) exceeds {SWREG_WIDTH} bits.')
            if 'arith_types' in fields:
                for n, w, t in zip(names, widths, fields['arith_types']):
                    if t == 2 and w != 1:
                        errors.append(f'Field {n} is bool, so its bitwidth must be 1.')
            if 'bin_pts' in fields:
                for n, w, b in zip(names, widths, fields['bin_pts']):
                    if b < 0 or b > w:
                        errors.append(f'Binary point of field {n} must be between 0 and its bitwidth ({w}).')
        init_val = self.get_init_val()
        if init_val == '' or int(init_val) >= 2**SWREG_WIDTH:
            errors.append(f'Initial value must be between 0 and {2**SWREG_WIDTH - 1}.')
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

    def IODir_Changed(self):
        self.logger.info('---------------------------------------------')
        self.logger.info('IO direction changed.')
        self.logger.info('---------------------------------------------')
        io_dir = self.get_io_dir()
        self.set_io_dir_status(io_dir == 'From Processor')

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.io_dir.currentIndexChanged.connect(self.IODir_Changed)

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
            if k in SWREG_CONFIG:
                setfunc = SWREG_CONFIG[k]['set']
                getattr(self, setfunc)(v)
        # apply the dynamic enable/disable rules once the config is loaded
        self.IODir_Changed()

    def collect_config(self):
        """
        Write the config to the target file.
        Return False without writing anything if the config is invalid.
        """
        errors = self.validate_config()
        if errors:
            for e in errors:
                self.logger.error(e)
            QMessageBox.critical(self.winobj, 'Invalid Software Register parameters', '\n'.join(errors))
            return False
        self.logger.info('-------------------------------------------------')
        self.logger.info(f'Writing config data to {self.target_config}...')
        self.logger.info('-------------------------------------------------')
        # try to open the config file if it exists
        try:
            with open(self.target_config, 'r', encoding='utf-8') as f:
                config = json.load(f)
        except:
            config = {}
            config['parameters'] = {}
            config['parameters']['name'] = ''
            config['parameters']['fullpath'] = ''
            config['parameters']['tag'] = 'xps:sw_reg'
        for k, v in SWREG_CONFIG.items():
            key = k
            getfunc = v['get']
            config['parameters'][f'{key}'] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Software Register Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='sw_reg.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    # generate the bconfig file
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = SWREGOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
