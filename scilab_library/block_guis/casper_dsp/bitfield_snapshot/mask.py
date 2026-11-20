import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox, QCheckBox, QComboBox
from PyQt6.QtGui import QIcon
import os
from bitfield_snapshot_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig
# the parameter rules are shared with dsp_blocks/bitfield_snapshot.py; they
# live in scilab_library/utils (not block_guis/utils, the "utils" package
# above), so import them from that directory directly
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))))), 'utils'))
from snapshot_check import check_bitsnap

# The JSON parameter keys (scilab_blocks/casper_dsp/bitfield_snapshot.json),
# in the Simulink mask order. The Scilab side (update_exprs) only reads back
# the keys listed in that template.
KEYS = ['name', 'io_names', 'io_widths', 'io_bps', 'io_types', 'show_format', 'snap_storage',
        'snap_dram_dimm', 'snap_dram_clock', 'snap_nsamples', 'snap_data_width', 'snap_offset',
        'snap_circap', 'snap_value', 'snap_ext_arm', 'snap_ext_circ', 'snap_provide_outputs',
        'snap_use_dsp48', 'snap_delay', 'extra_names', 'extra_widths', 'extra_bps', 'extra_types']
# hidden in the Simulink mask (Visible off): kept as loaded, no widget
HIDDEN = ['snap_provide_outputs']
EXTRA = ['extra_names', 'extra_widths', 'extra_bps', 'extra_types']
DRAM_ONLY = ['snap_dram_dimm', 'snap_dram_clock']


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class BitfieldSnapshotOperations(object):
    def __init__(self, winobj, template_config='bitfield_snapshot.json', target_config='bitfield_snapshot.json',
                 logdir='.', debug=False):
        level = logging.DEBUG if debug else logging.ERROR
        self.logger = make_rich_logger('bitfield_snapshot.log', level, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('bitfield_snapshot Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.hidden = {'snap_provide_outputs': 'on'}
        self.load_config()
        self.setup_signal_functions()
        self.update_enables()

    # *******************************************************************
    # Low-level APIs: one get / set for every key, by widget kind
    # *******************************************************************
    def get(self, key):
        if key in HIDDEN:
            return self.hidden[key]
        w = getattr(self.ui, key)
        if isinstance(w, QCheckBox):
            return 'on' if w.isChecked() else 'off'
        if isinstance(w, QComboBox):
            return w.currentText()
        return w.text().strip()

    def set(self, key, val):
        self.logger.debug(f'Set {key} to {val}')
        if key in HIDDEN:
            self.hidden[key] = str(val)
            return
        w = getattr(self.ui, key)
        if isinstance(w, QCheckBox):
            w.setChecked(str(val) == 'on')
        elif isinstance(w, QComboBox):
            if w.findText(str(val)) < 0:
                self.logger.error(f'{key}: value {val} not supported')
                return
            w.setCurrentText(str(val))
        else:
            w.setText(str(val))

    def values(self):
        return {k: self.get(k) for k in KEYS}

    # *******************************************************************
    # Validation (utils/snapshot_check.py, also used by the dsp block)
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        """
        errors = []
        if not self.get('name'):
            errors.append('Block name must not be empty.')
        errors += check_bitsnap(self.values())[0]
        return errors

    # *******************************************************************
    # Enables (bitsnap_callback.m)
    # *******************************************************************
    def update_enables(self):
        dram = self.get('snap_storage') == 'dram'
        for key in DRAM_ONLY:
            getattr(self.ui, key).setVisible(dram)
            getattr(self.ui, 'label_' + key).setVisible(dram)
        if dram:
            # DRAM storage forces a 64-bit data width
            self.ui.snap_data_width.setCurrentText('64')
        self.ui.snap_data_width.setEnabled(not dram)
        value = self.get('snap_value') == 'on'
        for key in EXTRA:
            getattr(self.ui, key).setEnabled(value)
            getattr(self.ui, 'label_' + key).setEnabled(value)

    # *******************************************************************
    # Signal functions
    # *******************************************************************
    def ButtonOK_Clicked(self):
        self.logger.info('Button OK clicked, collecting info...')
        if self.collect_config():
            self.winobj.close()

    def ButtonCancel_Clicked(self):
        self.logger.info('Button Cancel clicked...')
        self.winobj.close()

    def ButtonApply_Clicked(self):
        self.logger.info('Button Apply clicked, collecting info...')
        self.collect_config()

    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.snap_storage.currentIndexChanged.connect(self.update_enables)
        self.ui.snap_value.toggled.connect(self.update_enables)

    # *******************************************************************
    # load/collect config functions
    # *******************************************************************
    def load_config(self):
        self.logger.info(f'Loading config from {self.target_config}...')
        with open(self.target_config, 'r', encoding='utf-8') as f:
            config = json.load(f)
        for k, v in config['parameters'].items():
            if k in KEYS:
                self.set(k, v)

    def collect_config(self):
        """
        Write the config to the target file.
        Return False without writing anything if the config is invalid.
        """
        errors = self.validate_config()
        if errors:
            for e in errors:
                self.logger.error(e)
            QMessageBox.critical(self.winobj, 'Invalid bitfield_snapshot parameters', chr(10).join(errors))
            return False
        self.logger.info(f'Writing config data to {self.target_config}...')
        try:
            with open(self.target_config, 'r', encoding='utf-8') as f:
                config = json.load(f)
        except Exception:
            config = {'parameters': {'name': '', 'fullpath': '', 'tag': 'dsp:bitfield_snapshot'}}
        for k in KEYS:
            config['parameters'][k] = str(self.get(k))
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for bitfield_snapshot Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='bitfield_snapshot.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = BitfieldSnapshotOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
