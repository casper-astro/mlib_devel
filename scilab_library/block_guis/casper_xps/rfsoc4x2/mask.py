import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from rfsoc4x2_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in rfsoc4x2_ui.py.
# The keys must match scilab_blocks/casper_xps/rfsoc4x2.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
RFSOC4X2_CONFIG = {
    'hw_sys':
    {
        'get': 'get_hw_sys',
        'set': 'set_hw_sys'
    },
    'clk_src':
    {
        'get': 'get_clk_src',
        'set': 'set_clk_src'
    },
    'clk_rate':
    {
        'get': 'get_clk_rate',
        'set': 'set_clk_rate'
    },
    'pl_clk_rate':
    {
        'get': 'get_pl_clk_rate',
        'set': 'set_pl_clk_rate'
    },
    'sample_period':
    {
        'get': 'get_sample_period',
        'set': 'set_sample_period'
    },
    'synthesis_tool':
    {
        'get': 'get_synthesis_tool',
        'set': 'set_synthesis_tool'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class Rfsoc4x2Operations(object):
    def __init__(self, winobj, template_config='rfsoc4x2.json', target_config='rfsoc4x2.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('rfsoc4x2.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('rfsoc4x2.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('RFSoC4x2 Mask started.')
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
    def get_hw_sys(self):
        text = self.ui.hw_sys.currentText()
        self.logger.debug(f'hw_sys is {text}')
        return text

    def set_hw_sys(self, text):
        self.logger.debug(f'Set hw_sys to {text}')
        self.ui.hw_sys.setCurrentText(str(text))

    def get_clk_src(self):
        text = self.ui.clk_src.currentText()
        self.logger.debug(f'clk_src is {text}')
        return text

    def set_clk_src(self, text):
        self.logger.debug(f'Set clk_src to {text}')
        self.ui.clk_src.setCurrentText(str(text))

    def get_clk_rate(self):
        val = self.ui.clk_rate.text()
        self.logger.debug(f'clk_rate is {val}')
        return val

    def set_clk_rate(self, val):
        self.logger.debug(f'Set clk_rate to {val}')
        self.ui.clk_rate.setText(str(val))

    def get_pl_clk_rate(self):
        val = self.ui.pl_clk_rate.text()
        self.logger.debug(f'pl_clk_rate is {val}')
        return val

    def set_pl_clk_rate(self, val):
        self.logger.debug(f'Set pl_clk_rate to {val}')
        self.ui.pl_clk_rate.setText(str(val))

    def get_sample_period(self):
        val = self.ui.sample_period.text()
        self.logger.debug(f'sample_period is {val}')
        return val

    def set_sample_period(self, val):
        self.logger.debug(f'Set sample_period to {val}')
        self.ui.sample_period.setText(str(val))

    def get_synthesis_tool(self):
        text = self.ui.synthesis_tool.currentText()
        self.logger.debug(f'synthesis_tool is {text}')
        return text

    def set_synthesis_tool(self, text):
        self.logger.debug(f'Set synthesis_tool to {text}')
        self.ui.synthesis_tool.setCurrentText(str(text))


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
        if str(self.get_clk_rate()).strip() == '':
            errors.append('User IP Clock Rate (MHz) must not be empty.')
        if str(self.get_pl_clk_rate()).strip() == '':
            errors.append('RFPLL PL Clock Rate (MHz) must not be empty.')
        if str(self.get_sample_period()).strip() == '':
            errors.append('Sample Period must not be empty.')
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
            if k in RFSOC4X2_CONFIG:
                setfunc = RFSOC4X2_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid RFSoC4x2 parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:xsg'
        for k, v in RFSOC4X2_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for RFSoC4x2 Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='rfsoc4x2.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = Rfsoc4x2Operations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
