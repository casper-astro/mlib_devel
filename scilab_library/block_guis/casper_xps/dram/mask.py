import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from dram_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in dram_ui.py.
# The keys must match scilab_blocks/casper_xps/dram.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
DRAM_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'dimm':
    {
        'get': 'get_dimm',
        'set': 'set_dimm'
    },
    'arith_type':
    {
        'get': 'get_arith_type',
        'set': 'set_arith_type'
    },
    'bin_pt':
    {
        'get': 'get_bin_pt',
        'set': 'set_bin_pt'
    },
    'ip_clock':
    {
        'get': 'get_ip_clock',
        'set': 'set_ip_clock'
    },
    'sample_period':
    {
        'get': 'get_sample_period',
        'set': 'set_sample_period'
    },
    'bram_fifos':
    {
        'get': 'get_bram_fifos',
        'set': 'set_bram_fifos'
    },
    'disable_tag':
    {
        'get': 'get_disable_tag',
        'set': 'set_disable_tag'
    },
    'ram_depth':
    {
        'get': 'get_ram_depth',
        'set': 'set_ram_depth'
    },
    'bank_mgt':
    {
        'get': 'get_bank_mgt',
        'set': 'set_bank_mgt'
    },
    'wide_data':
    {
        'get': 'get_wide_data',
        'set': 'set_wide_data'
    },
    'half_burst':
    {
        'get': 'get_half_burst',
        'set': 'set_half_burst'
    },
    'use_sniffer':
    {
        'get': 'get_use_sniffer',
        'set': 'set_use_sniffer'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class DramOperations(object):
    def __init__(self, winobj, template_config='dram.json', target_config='dram.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('dram.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('dram.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('DRAM Mask started.')
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

    def get_dimm(self):
        text = self.ui.dimm.currentText()
        self.logger.debug(f'dimm is {text}')
        return text

    def set_dimm(self, text):
        self.logger.debug(f'Set dimm to {text}')
        self.ui.dimm.setCurrentText(str(text))

    def get_arith_type(self):
        text = self.ui.arith_type.currentText()
        self.logger.debug(f'arith_type is {text}')
        return text

    def set_arith_type(self, text):
        self.logger.debug(f'Set arith_type to {text}')
        self.ui.arith_type.setCurrentText(str(text))

    def get_bin_pt(self):
        val = self.ui.bin_pt.text()
        self.logger.debug(f'bin_pt is {val}')
        return val

    def set_bin_pt(self, val):
        self.logger.debug(f'Set bin_pt to {val}')
        self.ui.bin_pt.setText(str(val))

    def get_ip_clock(self):
        val = self.ui.ip_clock.text()
        self.logger.debug(f'ip_clock is {val}')
        return val

    def set_ip_clock(self, val):
        self.logger.debug(f'Set ip_clock to {val}')
        self.ui.ip_clock.setText(str(val))

    def get_sample_period(self):
        val = self.ui.sample_period.text()
        self.logger.debug(f'sample_period is {val}')
        return val

    def set_sample_period(self, val):
        self.logger.debug(f'Set sample_period to {val}')
        self.ui.sample_period.setText(str(val))

    def get_bram_fifos(self):
        status = self.ui.bram_fifos.isChecked()
        self.logger.debug(f'bram_fifos status is {status}')
        return self._convert_status(status)

    def set_bram_fifos(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set bram_fifos status to {status}')
        self.ui.bram_fifos.setChecked(status)

    def get_disable_tag(self):
        status = self.ui.disable_tag.isChecked()
        self.logger.debug(f'disable_tag status is {status}')
        return self._convert_status(status)

    def set_disable_tag(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set disable_tag status to {status}')
        self.ui.disable_tag.setChecked(status)

    def get_ram_depth(self):
        val = self.ui.ram_depth.value()
        self.logger.debug(f'ram_depth is {val}')
        return str(val)

    def set_ram_depth(self, val):
        self.logger.debug(f'Set ram_depth to {val}')
        self.ui.ram_depth.setValue(int(val))

    def get_bank_mgt(self):
        status = self.ui.bank_mgt.isChecked()
        self.logger.debug(f'bank_mgt status is {status}')
        return self._convert_status(status)

    def set_bank_mgt(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set bank_mgt status to {status}')
        self.ui.bank_mgt.setChecked(status)

    def get_wide_data(self):
        status = self.ui.wide_data.isChecked()
        self.logger.debug(f'wide_data status is {status}')
        return self._convert_status(status)

    def set_wide_data(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set wide_data status to {status}')
        self.ui.wide_data.setChecked(status)

    def get_half_burst(self):
        status = self.ui.half_burst.isChecked()
        self.logger.debug(f'half_burst status is {status}')
        return self._convert_status(status)

    def set_half_burst(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set half_burst status to {status}')
        self.ui.half_burst.setChecked(status)

    def get_use_sniffer(self):
        status = self.ui.use_sniffer.isChecked()
        self.logger.debug(f'use_sniffer status is {status}')
        return self._convert_status(status)

    def set_use_sniffer(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set use_sniffer status to {status}')
        self.ui.use_sniffer.setChecked(status)


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
        if str(self.get_bin_pt()).strip() == '':
            errors.append('Data binary point must not be empty.')
        if str(self.get_ip_clock()).strip() == '':
            errors.append('Datapath clock rate (MHz) must not be empty.')
        if str(self.get_sample_period()).strip() == '':
            errors.append('Sample period must not be empty.')
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
            if k in DRAM_CONFIG:
                setfunc = DRAM_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid DRAM parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:dram'
        for k, v in DRAM_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for DRAM Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='dram.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = DramOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
