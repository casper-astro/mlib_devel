import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from edge_detect_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in edge_detect_ui.py.
# The keys must match scilab_blocks/casper_dsp/edge_detect.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
EDGE_DETECT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'edge_type':
    {
        'get': 'get_edge_type',
        'set': 'set_edge_type'
    },
    'polarity':
    {
        'get': 'get_polarity',
        'set': 'set_polarity'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class EdgeDetectOperations(object):
    def __init__(self, winobj, template_config='edge_detect.json', target_config='edge_detect.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('edge_detect.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('edge_detect.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Edge Detect Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()

    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

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
    def get_edge_type(self):
        text = self.ui.edge_type.currentText()
        self.logger.debug(f'edge_type is {text}')
        return text

    def set_edge_type(self, text):
        self.logger.debug(f'Set edge_type to {text}')
        self.ui.edge_type.setCurrentText(str(text))

    def get_polarity(self):
        text = self.ui.polarity.currentText()
        self.logger.debug(f'polarity is {text}')
        return text

    def set_polarity(self, text):
        self.logger.debug(f'Set polarity to {text}')
        self.ui.polarity.setCurrentText(str(text))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.

        edge_type (rising/falling/both) and polarity (active high/active low)
        are both comboboxes restricted to casper_library's own 'edge' and
        'polarity' option lists, so there is no invalid state the widgets
        themselves can produce; nothing further to validate.
        """
        errors = []
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
            if k in EDGE_DETECT_CONFIG:
                setfunc = EDGE_DETECT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Edge Detect parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:edge_detect'
        for k, v in EDGE_DETECT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Edge Detect Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='edge_detect.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = EdgeDetectOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
