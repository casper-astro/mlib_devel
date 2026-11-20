import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from bus_dual_port_ram_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in bus_dual_port_ram_ui.py.
# The keys must match scilab_blocks/casper_dsp/bus_dual_port_ram.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
BUS_DUAL_PORT_RAM_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'addra_width':
    {
        'get': 'get_addra_width',
        'set': 'set_addra_width'
    },
    'addrb_width':
    {
        'get': 'get_addrb_width',
        'set': 'set_addrb_width'
    },
    'n_bits':
    {
        'get': 'get_n_bits',
        'set': 'set_n_bits'
    },
    'bin_pts':
    {
        'get': 'get_bin_pts',
        'set': 'set_bin_pts'
    },
    'init_vector':
    {
        'get': 'get_init_vector',
        'set': 'set_init_vector'
    },
    'max_fanout':
    {
        'get': 'get_max_fanout',
        'set': 'set_max_fanout'
    },
    'mem_type':
    {
        'get': 'get_mem_type',
        'set': 'set_mem_type'
    },
    'bram_optimization':
    {
        'get': 'get_bram_optimization',
        'set': 'set_bram_optimization'
    },
    'async_a':
    {
        'get': 'get_async_a',
        'set': 'set_async_a'
    },
    'async_b':
    {
        'get': 'get_async_b',
        'set': 'set_async_b'
    },
    'b_to_a_ratio_bits':
    {
        'get': 'get_b_to_a_ratio_bits',
        'set': 'set_b_to_a_ratio_bits'
    },
    'misc':
    {
        'get': 'get_misc',
        'set': 'set_misc'
    },
    'bram_latency':
    {
        'get': 'get_bram_latency',
        'set': 'set_bram_latency'
    },
    'fan_latency':
    {
        'get': 'get_fan_latency',
        'set': 'set_fan_latency'
    },
    'addra_register':
    {
        'get': 'get_addra_register',
        'set': 'set_addra_register'
    },
    'addra_implementation':
    {
        'get': 'get_addra_implementation',
        'set': 'set_addra_implementation'
    },
    'dina_register':
    {
        'get': 'get_dina_register',
        'set': 'set_dina_register'
    },
    'dina_implementation':
    {
        'get': 'get_dina_implementation',
        'set': 'set_dina_implementation'
    },
    'wea_register':
    {
        'get': 'get_wea_register',
        'set': 'set_wea_register'
    },
    'wea_implementation':
    {
        'get': 'get_wea_implementation',
        'set': 'set_wea_implementation'
    },
    'ena_register':
    {
        'get': 'get_ena_register',
        'set': 'set_ena_register'
    },
    'ena_implementation':
    {
        'get': 'get_ena_implementation',
        'set': 'set_ena_implementation'
    },
    'addrb_register':
    {
        'get': 'get_addrb_register',
        'set': 'set_addrb_register'
    },
    'addrb_implementation':
    {
        'get': 'get_addrb_implementation',
        'set': 'set_addrb_implementation'
    },
    'dinb_register':
    {
        'get': 'get_dinb_register',
        'set': 'set_dinb_register'
    },
    'dinb_implementation':
    {
        'get': 'get_dinb_implementation',
        'set': 'set_dinb_implementation'
    },
    'web_register':
    {
        'get': 'get_web_register',
        'set': 'set_web_register'
    },
    'web_implementation':
    {
        'get': 'get_web_implementation',
        'set': 'set_web_implementation'
    },
    'enb_register':
    {
        'get': 'get_enb_register',
        'set': 'set_enb_register'
    },
    'enb_implementation':
    {
        'get': 'get_enb_implementation',
        'set': 'set_enb_implementation'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class BusDualPortRamOperations(object):
    def __init__(self, winobj, template_config='bus_dual_port_ram.json', target_config='bus_dual_port_ram.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('bus_dual_port_ram.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('bus_dual_port_ram.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Bus Dual Port RAM Mask started.')
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

    def get_name(self):
        val = self.ui.name.text()
        self.logger.debug(f'name is {val}')
        return val

    def set_name(self, val):
        self.logger.debug(f'Set name to {val}')
        self.ui.name.setText(str(val))

    # *******************************************************************
    # Low-level APIs
    # *******************************************************************
    def get_addra_width(self):
        val = self.ui.addra_width.value()
        self.logger.debug(f'addra_width is {val}')
        return str(val)

    def set_addra_width(self, val):
        self.logger.debug(f'Set addra_width to {val}')
        self.ui.addra_width.setValue(int(val))

    def get_addrb_width(self):
        val = self.ui.addrb_width.value()
        self.logger.debug(f'addrb_width is {val}')
        return str(val)

    def set_addrb_width(self, val):
        self.logger.debug(f'Set addrb_width to {val}')
        self.ui.addrb_width.setValue(int(val))

    def get_n_bits(self):
        val = self.ui.n_bits.text()
        self.logger.debug(f'n_bits is {val}')
        return val

    def set_n_bits(self, val):
        self.logger.debug(f'Set n_bits to {val}')
        self.ui.n_bits.setText(str(val))

    def get_bin_pts(self):
        val = self.ui.bin_pts.text()
        self.logger.debug(f'bin_pts is {val}')
        return val

    def set_bin_pts(self, val):
        self.logger.debug(f'Set bin_pts to {val}')
        self.ui.bin_pts.setText(str(val))

    def get_init_vector(self):
        val = self.ui.init_vector.text()
        self.logger.debug(f'init_vector is {val}')
        return val

    def set_init_vector(self, val):
        self.logger.debug(f'Set init_vector to {val}')
        self.ui.init_vector.setText(str(val))

    def get_max_fanout(self):
        val = self.ui.max_fanout.text()
        self.logger.debug(f'max_fanout is {val}')
        return val

    def set_max_fanout(self, val):
        self.logger.debug(f'Set max_fanout to {val}')
        self.ui.max_fanout.setText(str(val))

    def get_mem_type(self):
        text = self.ui.mem_type.currentText()
        self.logger.debug(f'mem_type is {text}')
        return text

    def set_mem_type(self, text):
        self.logger.debug(f'Set mem_type to {text}')
        self.ui.mem_type.setCurrentText(str(text))

    def get_bram_optimization(self):
        text = self.ui.bram_optimization.currentText()
        self.logger.debug(f'bram_optimization is {text}')
        return text

    def set_bram_optimization(self, text):
        self.logger.debug(f'Set bram_optimization to {text}')
        self.ui.bram_optimization.setCurrentText(str(text))

    def get_async_a(self):
        status = self.ui.async_a.isChecked()
        self.logger.debug(f'async_a status is {status}')
        return self._convert_status(status)

    def set_async_a(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set async_a status to {status}')
        self.ui.async_a.setChecked(status)

    def get_async_b(self):
        status = self.ui.async_b.isChecked()
        self.logger.debug(f'async_b status is {status}')
        return self._convert_status(status)

    def set_async_b(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set async_b status to {status}')
        self.ui.async_b.setChecked(status)

    def get_b_to_a_ratio_bits(self):
        val = self.ui.b_to_a_ratio_bits.text()
        self.logger.debug(f'b_to_a_ratio_bits is {val}')
        return val

    def set_b_to_a_ratio_bits(self, val):
        self.logger.debug(f'Set b_to_a_ratio_bits to {val}')
        self.ui.b_to_a_ratio_bits.setText(str(val))

    def get_misc(self):
        status = self.ui.misc.isChecked()
        self.logger.debug(f'misc status is {status}')
        return self._convert_status(status)

    def set_misc(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set misc status to {status}')
        self.ui.misc.setChecked(status)

    def get_bram_latency(self):
        val = self.ui.bram_latency.text()
        self.logger.debug(f'bram_latency is {val}')
        return val

    def set_bram_latency(self, val):
        self.logger.debug(f'Set bram_latency to {val}')
        self.ui.bram_latency.setText(str(val))

    def get_fan_latency(self):
        val = self.ui.fan_latency.text()
        self.logger.debug(f'fan_latency is {val}')
        return val

    def set_fan_latency(self, val):
        self.logger.debug(f'Set fan_latency to {val}')
        self.ui.fan_latency.setText(str(val))

    def get_addra_register(self):
        status = self.ui.addra_register.isChecked()
        self.logger.debug(f'addra_register status is {status}')
        return self._convert_status(status)

    def set_addra_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set addra_register status to {status}')
        self.ui.addra_register.setChecked(status)

    def get_addra_implementation(self):
        text = self.ui.addra_implementation.currentText()
        self.logger.debug(f'addra_implementation is {text}')
        return text

    def set_addra_implementation(self, text):
        self.logger.debug(f'Set addra_implementation to {text}')
        self.ui.addra_implementation.setCurrentText(str(text))

    def get_dina_register(self):
        status = self.ui.dina_register.isChecked()
        self.logger.debug(f'dina_register status is {status}')
        return self._convert_status(status)

    def set_dina_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dina_register status to {status}')
        self.ui.dina_register.setChecked(status)

    def get_dina_implementation(self):
        text = self.ui.dina_implementation.currentText()
        self.logger.debug(f'dina_implementation is {text}')
        return text

    def set_dina_implementation(self, text):
        self.logger.debug(f'Set dina_implementation to {text}')
        self.ui.dina_implementation.setCurrentText(str(text))

    def get_wea_register(self):
        status = self.ui.wea_register.isChecked()
        self.logger.debug(f'wea_register status is {status}')
        return self._convert_status(status)

    def set_wea_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set wea_register status to {status}')
        self.ui.wea_register.setChecked(status)

    def get_wea_implementation(self):
        text = self.ui.wea_implementation.currentText()
        self.logger.debug(f'wea_implementation is {text}')
        return text

    def set_wea_implementation(self, text):
        self.logger.debug(f'Set wea_implementation to {text}')
        self.ui.wea_implementation.setCurrentText(str(text))

    def get_ena_register(self):
        status = self.ui.ena_register.isChecked()
        self.logger.debug(f'ena_register status is {status}')
        return self._convert_status(status)

    def set_ena_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set ena_register status to {status}')
        self.ui.ena_register.setChecked(status)

    def get_ena_implementation(self):
        text = self.ui.ena_implementation.currentText()
        self.logger.debug(f'ena_implementation is {text}')
        return text

    def set_ena_implementation(self, text):
        self.logger.debug(f'Set ena_implementation to {text}')
        self.ui.ena_implementation.setCurrentText(str(text))

    def get_addrb_register(self):
        status = self.ui.addrb_register.isChecked()
        self.logger.debug(f'addrb_register status is {status}')
        return self._convert_status(status)

    def set_addrb_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set addrb_register status to {status}')
        self.ui.addrb_register.setChecked(status)

    def get_addrb_implementation(self):
        text = self.ui.addrb_implementation.currentText()
        self.logger.debug(f'addrb_implementation is {text}')
        return text

    def set_addrb_implementation(self, text):
        self.logger.debug(f'Set addrb_implementation to {text}')
        self.ui.addrb_implementation.setCurrentText(str(text))

    def get_dinb_register(self):
        status = self.ui.dinb_register.isChecked()
        self.logger.debug(f'dinb_register status is {status}')
        return self._convert_status(status)

    def set_dinb_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dinb_register status to {status}')
        self.ui.dinb_register.setChecked(status)

    def get_dinb_implementation(self):
        text = self.ui.dinb_implementation.currentText()
        self.logger.debug(f'dinb_implementation is {text}')
        return text

    def set_dinb_implementation(self, text):
        self.logger.debug(f'Set dinb_implementation to {text}')
        self.ui.dinb_implementation.setCurrentText(str(text))

    def get_web_register(self):
        status = self.ui.web_register.isChecked()
        self.logger.debug(f'web_register status is {status}')
        return self._convert_status(status)

    def set_web_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set web_register status to {status}')
        self.ui.web_register.setChecked(status)

    def get_web_implementation(self):
        text = self.ui.web_implementation.currentText()
        self.logger.debug(f'web_implementation is {text}')
        return text

    def set_web_implementation(self, text):
        self.logger.debug(f'Set web_implementation to {text}')
        self.ui.web_implementation.setCurrentText(str(text))

    def get_enb_register(self):
        status = self.ui.enb_register.isChecked()
        self.logger.debug(f'enb_register status is {status}')
        return self._convert_status(status)

    def set_enb_register(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set enb_register status to {status}')
        self.ui.enb_register.setChecked(status)

    def get_enb_implementation(self):
        text = self.ui.enb_implementation.currentText()
        self.logger.debug(f'enb_implementation is {text}')
        return text

    def set_enb_implementation(self, text):
        self.logger.debug(f'Set enb_implementation to {text}')
        self.ui.enb_implementation.setCurrentText(str(text))


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
        if str(self.get_n_bits()).strip() == '':
            errors.append('data word bit widths must not be empty.')
        if str(self.get_bin_pts()).strip() == '':
            errors.append('data word binary points must not be empty.')
        if str(self.get_init_vector()).strip() == '':
            errors.append('initial value vector must not be empty.')
        if str(self.get_max_fanout()).strip() == '':
            errors.append('limit fanout to ? must not be empty.')
        if str(self.get_b_to_a_ratio_bits()).strip() == '':
            errors.append('b_to_a ratio bits must not be empty.')
        if str(self.get_bram_latency()).strip() == '':
            errors.append('bram latency must not be empty.')
        if str(self.get_fan_latency()).strip() == '':
            errors.append('input register latency must not be empty.')
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
            if k in BUS_DUAL_PORT_RAM_CONFIG:
                setfunc = BUS_DUAL_PORT_RAM_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Bus Dual Port RAM parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'dsp:bus_dual_port_ram'
        for k, v in BUS_DUAL_PORT_RAM_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Bus Dual Port RAM Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='bus_dual_port_ram.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = BusDualPortRamOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
