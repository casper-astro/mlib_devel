import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from exception_constraint_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in exception_constraint_ui.py.
# The keys must match scilab_blocks/casper_xps/exception_constraint.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
EXCEPTION_CONSTRAINT_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'constraint_type':
    {
        'get': 'get_constraint_type',
        'set': 'set_constraint_type'
    },
    'num_clock_cycles':
    {
        'get': 'get_num_clock_cycles',
        'set': 'set_num_clock_cycles'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class ExceptionConstraintOperations(object):
    def __init__(self, winobj, template_config='exception_constraint.json', target_config='exception_constraint.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('exception_constraint.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('exception_constraint.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Exception Constraint Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()
        self.ConstraintType_Changed()

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

    def get_constraint_type(self):
        text = self.ui.constraint_type.currentText()
        self.logger.debug(f'constraint_type is {text}')
        return text

    def set_constraint_type(self, text):
        self.logger.debug(f'Set constraint_type to {text}')
        self.ui.constraint_type.setCurrentText(str(text))

    def get_num_clock_cycles(self):
        val = self.ui.num_clock_cycles.text()
        self.logger.debug(f'num_clock_cycles is {val}')
        return val

    def set_num_clock_cycles(self, val):
        self.logger.debug(f'Set num_clock_cycles to {val}')
        self.ui.num_clock_cycles.setText(str(val))


    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Ported from exception_constr_mask.m's real MaskEnables callback:
        num_clock_cycles only applies to a Multicycle Constraint (it's
        disabled in the dialog for a False Path Constraint, which has no
        cycle count), and must be a positive integer when it does apply.
        """
        errors = []
        if self.get_constraint_type() == 'Multicycle Constraint':
            val = str(self.get_num_clock_cycles()).strip()
            if val == '':
                errors.append('Number of Clock Cycles must not be empty.')
            else:
                try:
                    if int(val) <= 0:
                        errors.append('Number of Clock Cycles must be a positive integer.')
                except ValueError:
                    errors.append('Number of Clock Cycles must be a positive integer.')
        return errors

    # *******************************************************************
    # Dynamic enable/disable (exception_constr_mask.m's MaskEnables callback)
    # *******************************************************************
    def ConstraintType_Changed(self):
        is_multicycle = self.get_constraint_type() == 'Multicycle Constraint'
        self.ui.num_clock_cycles.setEnabled(is_multicycle)

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
        self.ui.constraint_type.currentTextChanged.connect(self.ConstraintType_Changed)

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
            if k in EXCEPTION_CONSTRAINT_CONFIG:
                setfunc = EXCEPTION_CONSTRAINT_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Exception Constraint parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:exception_constr'
        for k, v in EXCEPTION_CONSTRAINT_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Exception Constraint Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='exception_constraint.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = ExceptionConstraintOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
