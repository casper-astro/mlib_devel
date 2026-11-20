import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from one_gbe_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in one_gbe_ui.py.
# The keys must match scilab_blocks/casper_xps/one_gbe.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
ONE_GBE_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'local_en':
    {
        'get': 'get_local_en',
        'set': 'set_local_en'
    },
    'dis_cpu_rx':
    {
        'get': 'get_dis_cpu_rx',
        'set': 'set_dis_cpu_rx'
    },
    'dis_cpu_tx':
    {
        'get': 'get_dis_cpu_tx',
        'set': 'set_dis_cpu_tx'
    },
    'cpu_promiscuous':
    {
        'get': 'get_cpu_promiscuous',
        'set': 'set_cpu_promiscuous'
    },
    'local_mac':
    {
        'get': 'get_local_mac',
        'set': 'set_local_mac'
    },
    'local_ip':
    {
        'get': 'get_local_ip',
        'set': 'set_local_ip'
    },
    'local_port':
    {
        'get': 'get_local_port',
        'set': 'set_local_port'
    },
    'local_gateway':
    {
        'get': 'get_local_gateway',
        'set': 'set_local_gateway'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class OneGbeOperations(object):
    def __init__(self, winobj, template_config='one_gbe.json', target_config='one_gbe.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('one_gbe.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('one_gbe.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('One GbE Mask started.')
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

    def get_local_en(self):
        status = self.ui.local_en.isChecked()
        self.logger.debug(f'local_en status is {status}')
        return self._convert_status(status)

    def set_local_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set local_en status to {status}')
        self.ui.local_en.setChecked(status)

    def get_dis_cpu_rx(self):
        status = self.ui.dis_cpu_rx.isChecked()
        self.logger.debug(f'dis_cpu_rx status is {status}')
        return self._convert_status(status)

    def set_dis_cpu_rx(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dis_cpu_rx status to {status}')
        self.ui.dis_cpu_rx.setChecked(status)

    def get_dis_cpu_tx(self):
        status = self.ui.dis_cpu_tx.isChecked()
        self.logger.debug(f'dis_cpu_tx status is {status}')
        return self._convert_status(status)

    def set_dis_cpu_tx(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set dis_cpu_tx status to {status}')
        self.ui.dis_cpu_tx.setChecked(status)

    def get_cpu_promiscuous(self):
        status = self.ui.cpu_promiscuous.isChecked()
        self.logger.debug(f'cpu_promiscuous status is {status}')
        return self._convert_status(status)

    def set_cpu_promiscuous(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cpu_promiscuous status to {status}')
        self.ui.cpu_promiscuous.setChecked(status)

    def get_local_mac(self):
        val = self.ui.local_mac.text()
        self.logger.debug(f'local_mac is {val}')
        return val

    def set_local_mac(self, val):
        self.logger.debug(f'Set local_mac to {val}')
        self.ui.local_mac.setText(str(val))

    def get_local_ip(self):
        val = self.ui.local_ip.text()
        self.logger.debug(f'local_ip is {val}')
        return val

    def set_local_ip(self, val):
        self.logger.debug(f'Set local_ip to {val}')
        self.ui.local_ip.setText(str(val))

    def get_local_port(self):
        val = self.ui.local_port.value()
        self.logger.debug(f'local_port is {val}')
        return str(val)

    def set_local_port(self, val):
        self.logger.debug(f'Set local_port to {val}')
        self.ui.local_port.setValue(int(val))

    def get_local_gateway(self):
        val = self.ui.local_gateway.value()
        self.logger.debug(f'local_gateway is {val}')
        return str(val)

    def set_local_gateway(self, val):
        self.logger.debug(f'Set local_gateway to {val}')
        self.ui.local_gateway.setValue(int(val))


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
        if str(self.get_local_mac()).strip() == '':
            errors.append('Fabric MAC Address must not be empty.')
        if str(self.get_local_ip()).strip() == '':
            errors.append('Fabric IP Address must not be empty.')
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
            if k in ONE_GBE_CONFIG:
                setfunc = ONE_GBE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid One GbE parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:onegbe'
        for k, v in ONE_GBE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for One GbE Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='one_gbe.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = OneGbeOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
