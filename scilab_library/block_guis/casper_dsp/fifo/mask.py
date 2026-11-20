import sys
import re
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from fifo_ui import Ui_MainWindow, DEPTH_ITEMS

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in fifo_ui.py.
# The keys must match scilab_blocks/casper_dsp/fifo.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
FIFO_CONFIG = {key: {'get': 'get_' + key, 'set': 'set_' + key} for key in [
    'name',
    'n_bits',
    'mem_type',
    'performance_options',
    'embedded_registers',
    'depth',
    'percent_nbits',
    'rst',
    'rst_latency',
    'en',
    'use_dcount',
    'use_percent_full_port',
    'use_almost_empty',
    'almost_empty_thresh',
    'use_almost_full',
    'use_rd_rst_busy',
    'use_wr_rst_busy',
    'almost_full_thresh',
]}

# checkbox and list box parameters, handled generically below
CHECKBOXES = ['embedded_registers', 'rst', 'en', 'use_dcount', 'use_percent_full_port',
              'use_almost_empty', 'use_almost_full', 'use_rd_rst_busy', 'use_wr_rst_busy']
COMBOBOXES = ['depth', 'percent_nbits', 'rst_latency']
RADIOGROUPS = ['mem_type', 'performance_options']
LINEEDITS = ['almost_empty_thresh', 'almost_full_thresh']

# the Simulink mask offers Built-in FIFO depths from 512 only (fifoaction.m)
BUILTIN_MIN_DEPTH = '512'


def depth_words(depth):
    """Number of words of a depth list box value ('16' .. '512', '1K' .. '4M')."""
    val = str(depth).strip().upper()
    scale = {'K': 1024, 'M': 1048576}
    if val and val[-1] in scale:
        return int(val[:-1]) * scale[val[-1]]
    return int(val)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class FifoOperations(object):
    def __init__(self, winobj, template_config='fifo.json', target_config='fifo.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('fifo.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('fifo.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('FIFO Mask started.')
        self.logger.info('*************************************************')
        self.logger.info(f'Source config file is {template_config}.')
        self.logger.info(f'Dest config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.load_config()
        # what the Simulink dialog does when it opens (fifoaction.m 'opened'):
        # a Built-in FIFO gets its restricted depth list and no ae / af port
        if self.get_mem_type() == 'Built-in FIFO':
            self.apply_builtin_fifo()
        self.setup_signal_functions()
        # sync the enabled state of the dependent widgets to the loaded
        # values -- the signals are connected after load_config() runs
        self.update_enablement()

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
    # Low-level APIs (checkboxes, list boxes, radio groups and edit boxes
    # are generated generically: get_<key> / set_<key>, see __getattr__)
    # *******************************************************************
    def get_n_bits(self):
        val = self.ui.n_bits.value()
        self.logger.debug(f'n_bits is {val}')
        return str(val)

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        self.ui.n_bits.setValue(int(float(val)))

    def _get_checkbox(self, key):
        status = getattr(self.ui, key).isChecked()
        self.logger.debug(f'{key} status is {status}')
        return self._convert_status(status)

    def _set_checkbox(self, key, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set {key} status to {status}')
        getattr(self.ui, key).setChecked(status)

    def _get_combobox(self, key):
        text = getattr(self.ui, key).currentText()
        self.logger.debug(f'{key} is {text}')
        return text

    def _set_combobox(self, key, text):
        self.logger.debug(f'Set {key} to {text}')
        widget = getattr(self.ui, key)
        # an integer-valued number may come back as e.g. '16.0'
        text = str(text).strip()
        if re.fullmatch(r'[0-9]+\.0*', text):
            text = text.split('.')[0]
        if widget.findText(text) < 0:
            self.logger.error(f'{key}: value {text} not supported, keeping {widget.currentText()}')
            return
        widget.setCurrentText(text)

    def _get_radiogroup(self, key):
        for value, button in getattr(self.ui, key + '_buttons').items():
            if button.isChecked():
                self.logger.debug(f'{key} is {value}')
                return value
        return None

    def _set_radiogroup(self, key, value):
        self.logger.debug(f'Set {key} to {value}')
        buttons = getattr(self.ui, key + '_buttons')
        if str(value) not in buttons:
            self.logger.error(f'{key}: value {value} not supported')
            return
        buttons[str(value)].setChecked(True)

    def _get_lineedit(self, key):
        val = getattr(self.ui, key).text()
        self.logger.debug(f'{key} is {val}')
        return val

    def _set_lineedit(self, key, val):
        self.logger.debug(f'Set {key} to {val}')
        getattr(self.ui, key).setText(str(val))

    def __getattr__(self, attr):
        # get_<key> / set_<key> of the generic widgets
        for kind, keys in (('checkbox', CHECKBOXES), ('combobox', COMBOBOXES),
                           ('radiogroup', RADIOGROUPS), ('lineedit', LINEEDITS)):
            for prefix in ('get_', 'set_'):
                if attr.startswith(prefix) and attr[len(prefix):] in keys:
                    func = getattr(self, f'_{prefix}{kind}')
                    key = attr[len(prefix):]
                    return lambda *args: func(key, *args)
        raise AttributeError(attr)

    # *******************************************************************
    # Validation
    # *******************************************************************
    def validate_config(self):
        """
        Return a list of error messages. The list is empty if the config is valid.
        The rules are the conditions the Simulink mask rejects, which fifo.sv
        stops on with $fatal.
        """
        errors = []
        mem_type = self.get_mem_type()
        fwft = self.get_performance_options() == 'First_Word_Fall_Through'
        depth = depth_words(self.get_depth())
        log2_depth = depth.bit_length() - 1
        if int(self.get_n_bits()) < 1:
            errors.append('Data width must be at least 1 bit.')
        if mem_type == 'Shift Register' and fwft:
            errors.append('A Shift Register FIFO does not support First Word Fall Through.')
        if mem_type == 'Built-in FIFO' and depth < int(BUILTIN_MIN_DEPTH):
            errors.append(f'A Built-in FIFO needs a depth of at least {BUILTIN_MIN_DEPTH}.')
        if int(self.get_percent_nbits()) > log2_depth:
            errors.append(f'Bits of precision to use for %full signal must be at most '
                          f'log2(depth) = {log2_depth}.')
        # thresholds: integers, checked against the range only when their
        # port is on (as Simulink and fifo.sv do)
        th_min = 5 if fwft else 3
        th_max = depth - th_min
        for key, use, label in [
            ('almost_empty_thresh', 'use_almost_empty', 'Almost empty threshold'),
            ('almost_full_thresh', 'use_almost_full', 'Almost full threshold'),
        ]:
            val = str(getattr(self, FIFO_CONFIG[key]['get'])()).strip()
            if not re.fullmatch(r'[+-]?[0-9]+', val):
                errors.append(f'{label} must be an integer.')
            elif getattr(self, FIFO_CONFIG[use]['get'])() == 'on' and not th_min <= int(val) <= th_max:
                errors.append(f'{label} must be between {th_min} and {th_max} '
                              f'(depth {depth}, {"First Word Fall Through" if fwft else "Standard FIFO"}).')
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

    def set_depth_items(self, builtin):
        """The depth list: from 512 for a Built-in FIFO (fifoaction.m), the
        full list otherwise; keeps the current depth when it is still offered
        and moves it up to 512 otherwise, as Simulink does."""
        current = self.get_depth()
        items = DEPTH_ITEMS[DEPTH_ITEMS.index(BUILTIN_MIN_DEPTH):] if builtin else DEPTH_ITEMS
        self.ui.depth.blockSignals(True)
        self.ui.depth.clear()
        self.ui.depth.addItems(items)
        self.ui.depth.setCurrentText(current if current in items else BUILTIN_MIN_DEPTH)
        self.ui.depth.blockSignals(False)

    def apply_builtin_fifo(self):
        """Built-in FIFO: depth from 512, and no data count / %full /
        almost empty / almost full port (fifoaction.m / fifoenablement.m)."""
        self.set_depth_items(True)
        for key in ('use_dcount', 'use_percent_full_port', 'use_almost_empty', 'use_almost_full'):
            getattr(self.ui, key).setChecked(False)

    def update_enablement(self):
        """
        The enabled state of the dependent widgets (fifoenablement.m):
        - Shift Register disables the performance options (it is Standard
          FIFO only);
        - embedded registers can be chosen for Block RAM and Built-in FIFO
          only;
        - Built-in FIFO disables the data count, percent full, almost empty
          and almost full ports;
        - each threshold is enabled only when its port is on.
        """
        mem_type = self.get_mem_type()
        builtin = mem_type == 'Built-in FIFO'
        self.ui.performance_options.setEnabled(mem_type != 'Shift Register')
        self.ui.embedded_registers.setEnabled(mem_type in ('Block RAM', 'Built-in FIFO'))
        for key in ('use_dcount', 'use_percent_full_port', 'use_almost_empty', 'use_almost_full'):
            getattr(self.ui, key).setEnabled(not builtin)
        self.ui.almost_empty_thresh.setEnabled(self.ui.use_almost_empty.isChecked())
        self.ui.label_almost_empty_thresh.setEnabled(self.ui.use_almost_empty.isChecked())
        self.ui.almost_full_thresh.setEnabled(self.ui.use_almost_full.isChecked())
        self.ui.label_almost_full_thresh.setEnabled(self.ui.use_almost_full.isChecked())

    def MemType_Changed(self, button, checked):
        """What the Simulink dialog does when a memory type is clicked
        (fifoaction.m): Distributed RAM / Shift Register clear the embedded
        registers, Built-in FIFO restricts the depth and clears its
        unsupported ports. Shift Register also falls back to Standard FIFO,
        the only mode it supports."""
        if not checked:
            return
        self.logger.info('---------------------------------------------')
        self.logger.info('Memory type changed.')
        self.logger.info('---------------------------------------------')
        mem_type = self.get_mem_type()
        if mem_type in ('Distributed RAM', 'Shift Register'):
            self.ui.embedded_registers.setChecked(False)
        if mem_type == 'Shift Register':
            self.ui.performance_options_buttons['Standard_FIFO'].setChecked(True)
        if mem_type == 'Built-in FIFO':
            self.apply_builtin_fifo()
        else:
            self.set_depth_items(False)
        self.update_enablement()

    def PerformanceOptions_Changed(self, button, checked):
        """Choosing First Word Fall Through clears the data count and percent
        full ports (fifoaction.m); they can be turned on again."""
        if not checked:
            return
        self.logger.info('---------------------------------------------')
        self.logger.info('Performance options changed.')
        self.logger.info('---------------------------------------------')
        if self.get_performance_options() == 'First_Word_Fall_Through':
            self.ui.use_dcount.setChecked(False)
            self.ui.use_percent_full_port.setChecked(False)
        self.update_enablement()

    # *******************************************************************
    # Setup Signal functions
    # *******************************************************************
    def setup_signal_functions(self):
        self.ui.button_ok.clicked.connect(self.ButtonOK_Clicked)
        self.ui.button_cancel.clicked.connect(self.ButtonCancel_Clicked)
        self.ui.button_apply.clicked.connect(self.ButtonApply_Clicked)
        self.ui.mem_type_group.buttonToggled.connect(self.MemType_Changed)
        self.ui.performance_options_group.buttonToggled.connect(self.PerformanceOptions_Changed)
        self.ui.use_almost_empty.toggled.connect(self.update_enablement)
        self.ui.use_almost_full.toggled.connect(self.update_enablement)

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
            if k in FIFO_CONFIG:
                setfunc = FIFO_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid FIFO parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:fifo'
        for k, v in FIFO_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for FIFO Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='fifo.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = FifoOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
