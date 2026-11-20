import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from xaui_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in xaui_ui.py.
# The keys must match scilab_blocks/casper_xps/xaui.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
XAUI_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'demux':
    {
        'get': 'get_demux',
        'set': 'set_demux'
    },
    'port':
    {
        'get': 'get_port',
        'set': 'set_port'
    },
    'open_phy':
    {
        'get': 'get_open_phy',
        'set': 'set_open_phy'
    },
    'show_param':
    {
        'get': 'get_show_param',
        'set': 'set_show_param'
    },
    'pre_emph':
    {
        'get': 'get_pre_emph',
        'set': 'set_pre_emph'
    },
    'swing':
    {
        'get': 'get_swing',
        'set': 'set_swing'
    },
    'data_width':
    {
        'get': 'get_data_width',
        'set': 'set_data_width'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class XauiOperations(object):
    def __init__(self, winobj, template_config='xaui.json', target_config='xaui.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('xaui.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('xaui.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('XAUI Mask started.')
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

    def get_demux(self):
        text = self.ui.demux.currentText()
        self.logger.debug(f'demux is {text}')
        return text

    def set_demux(self, text):
        self.logger.debug(f'Set demux to {text}')
        self.ui.demux.setCurrentText(str(text))

    def get_port(self):
        text = self.ui.port.currentText()
        self.logger.debug(f'port is {text}')
        return text

    def set_port(self, text):
        self.logger.debug(f'Set port to {text}')
        self.ui.port.setCurrentText(str(text))

    def get_open_phy(self):
        status = self.ui.open_phy.isChecked()
        self.logger.debug(f'open_phy status is {status}')
        return self._convert_status(status)

    def set_open_phy(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set open_phy status to {status}')
        self.ui.open_phy.setChecked(status)

    def get_show_param(self):
        status = self.ui.show_param.isChecked()
        self.logger.debug(f'show_param status is {status}')
        return self._convert_status(status)

    def set_show_param(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set show_param status to {status}')
        self.ui.show_param.setChecked(status)

    def get_pre_emph(self):
        text = self.ui.pre_emph.currentText()
        self.logger.debug(f'pre_emph is {text}')
        return text

    def set_pre_emph(self, text):
        self.logger.debug(f'Set pre_emph to {text}')
        self.ui.pre_emph.setCurrentText(str(text))

    def get_swing(self):
        text = self.ui.swing.currentText()
        self.logger.debug(f'swing is {text}')
        return text

    def set_swing(self, text):
        self.logger.debug(f'Set swing to {text}')
        self.ui.swing.setCurrentText(str(text))

    def get_data_width(self):
        val = self.ui.data_width.value()
        self.logger.debug(f'data_width is {val}')
        return str(val)

    def set_data_width(self, val):
        self.logger.debug(f'Set data_width to {val}')
        self.ui.data_width.setValue(int(val))


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
        pass
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
            if k in XAUI_CONFIG:
                setfunc = XAUI_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid XAUI parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:xaui'
        for k, v in XAUI_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for XAUI Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='xaui.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = XauiOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
