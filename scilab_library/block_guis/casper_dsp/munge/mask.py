import sys
import re
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from munge_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig
# the vector parser and the width rules are shared with dsp_blocks/munge.py;
# they live in scilab_library/utils (not block_guis/utils, the "utils"
# package above), so import them from that directory directly
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))), 'utils'))
from matlab_vec import parse_vector
from munge_widths import munge_widths

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in munge_ui.py.
# The keys must match scilab_blocks/casper_dsp/munge.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
MUNGE_CONFIG = {key: {'get': 'get_' + key, 'set': 'set_' + key} for key in [
    'name',
    'divisions',
    'div_size',
    'order',
    'arith_type_out',
    'bin_pt_out',
]}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class MungeOperations(object):
    def __init__(self, winobj, template_config='munge.json', target_config='munge.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('munge.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('munge.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Munge Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        self.setup_signal_functions()
        self.update_status()

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def _get_text(self, key):
        val = getattr(self.ui, key).text()
        self.logger.debug(f'{key} is {val}')
        return val

    def _set_text(self, key, val):
        self.logger.debug(f'Set {key} to {val}')
        getattr(self.ui, key).setText(str(val))

    def get_name(self):
        return self._get_text('name')

    def set_name(self, val):
        self._set_text('name', val)

    def get_divisions(self):
        return self._get_text('divisions')

    def set_divisions(self, val):
        self._set_text('divisions', val)

    def get_div_size(self):
        return self._get_text('div_size')

    def set_div_size(self, val):
        self._set_text('div_size', val)

    def get_order(self):
        return self._get_text('order')

    def set_order(self, val):
        self._set_text('order', val)

    def get_arith_type_out(self):
        text = self.ui.arith_type_out.currentText()
        self.logger.debug(f'arith_type_out is {text}')
        return text

    def set_arith_type_out(self, text):
        self.logger.debug(f'Set arith_type_out to {text}')
        if self.ui.arith_type_out.findText(str(text)) < 0:
            self.logger.error(f'arith_type_out: value {text} not supported')
            return
        self.ui.arith_type_out.setCurrentText(str(text))

    def get_bin_pt_out(self):
        return self._get_text('bin_pt_out')

    def set_bin_pt_out(self, val):
        self._set_text('bin_pt_out', val)

    # *******************************************************************
    # Validation
    # *******************************************************************
    def _widths(self):
        """(din width, dout width) of the current values, or a list of error
        messages. The rules are munge.sv's $fatal checks (munge_widths)."""
        errors = []
        val = self.get_divisions().strip()
        divisions = None
        if not re.fullmatch(r'\+?[0-9]+', val) or int(val) < 1:
            errors.append('Number of divisions must be an integer >= 1.')
        else:
            divisions = int(val)
        vectors = {}
        for key, label in (('div_size', 'Division size (bits)'), ('order', 'Division packing order')):
            try:
                vectors[key] = parse_vector(getattr(self, 'get_' + key)())
            except ValueError as e:
                errors.append(f'{label}: {e} (use e.g. 16, [8 0 9 1], 16*ones(1,16) or 0:15).')
        if errors:
            return errors
        try:
            return munge_widths(divisions, vectors['div_size'], vectors['order'])
        except ValueError as e:
            # munge_widths names the parameters by key; show the prompts
            msg = str(e)
            for key, label in ((r'\bdivisions(?= =)', 'Number of divisions'),
                               (r'\bdiv_size\b', 'Division size (bits)'),
                               (r'^order\b', 'Division packing order')):
                msg = re.sub(key, label, msg)
            return [msg[0].upper() + msg[1:] + '.']

    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        widths = self._widths()
        if isinstance(widths, list):
            return widths
        errors = []
        # the output binary point lies within the output word (munge_init.m);
        # it only sets the output type
        val = self.get_bin_pt_out().strip()
        if not re.fullmatch(r'\+?[0-9]+', val):
            errors.append('Output binary point must be an integer >= 0.')
        elif int(val) > widths[1]:
            errors.append(f'Output binary point must be at most the output width {widths[1]}.')
        return errors

    def update_status(self):
        """Show the port widths the current values give (or why they are invalid)."""
        widths = self._widths()
        if isinstance(widths, list):
            self.ui.widths.setText('invalid: ' + ' '.join(widths))
        else:
            self.ui.widths.setText(f'{widths[0]} / {widths[1]} bits')

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
        for key in ('divisions', 'div_size', 'order'):
            getattr(self.ui, key).textChanged.connect(self.update_status)

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
            if k in MUNGE_CONFIG:
                setfunc = MUNGE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Munge parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:munge'
        for k, v in MUNGE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        # drop the keys of the old template (total_bits, size_bits, packing_order)
        for k in ('total_bits', 'size_bits', 'packing_order'):
            config['parameters'].pop(k, None)
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Munge Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='munge.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = MungeOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
