import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from raw_axi_register_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in raw_axi_register_ui.py.
# The keys must match scilab_blocks/casper_xps/raw_axi_register.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
RAW_AXI_REGISTER_CONFIG = {
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
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class RawAxiRegisterOperations(object):
    def __init__(self, winobj, template_config='raw_axi_register.json', target_config='raw_axi_register.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('raw_axi_register.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('raw_axi_register.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Raw AXI Register Mask started.')
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

    def get_io_dir(self):
        text = self.ui.io_dir.currentText()
        self.logger.debug(f'io_dir is {text}')
        return text

    def set_io_dir(self, text):
        self.logger.debug(f'Set io_dir to {text}')
        self.ui.io_dir.setCurrentText(str(text))

    def get_io_delay(self):
        val = self.ui.io_delay.text()
        self.logger.debug(f'io_delay is {val}')
        return val

    def set_io_delay(self, val):
        self.logger.debug(f'Set io_delay to {val}')
        self.ui.io_delay.setText(str(val))

    def get_init_val(self):
        val = self.ui.init_val.text()
        self.logger.debug(f'init_val is {val}')
        return val

    def set_init_val(self, val):
        self.logger.debug(f'Set init_val to {val}')
        self.ui.init_val.setText(str(val))

    def get_sample_period(self):
        val = self.ui.sample_period.text()
        self.logger.debug(f'sample_period is {val}')
        return val

    def set_sample_period(self, val):
        self.logger.debug(f'Set sample_period to {val}')
        self.ui.sample_period.setText(str(val))

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
        if str(self.get_io_delay()).strip() == '':
            errors.append('I/O delay must not be empty.')
        if str(self.get_init_val()).strip() == '':
            errors.append('Initial Value must not be empty.')
        if str(self.get_sample_period()).strip() == '':
            errors.append('Sample period must not be empty.')
        if str(self.get_names()).strip() == '':
            errors.append('Bitfield names [msb...lsb] must not be empty.')
        if str(self.get_bitwidths()).strip() == '':
            errors.append('Bitfield widths must not be empty.')
        if str(self.get_bin_pts()).strip() == '':
            errors.append('Bitfield binary pts must not be empty.')
        if str(self.get_arith_types()).strip() == '':
            errors.append('Bitfield types, ufix=0, fix=1, bool=2 must not be empty.')
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
            if k in RAW_AXI_REGISTER_CONFIG:
                setfunc = RAW_AXI_REGISTER_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Raw AXI Register parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:raxi'
        for k, v in RAW_AXI_REGISTER_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Raw AXI Register Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='raw_axi_register.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = RawAxiRegisterOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
