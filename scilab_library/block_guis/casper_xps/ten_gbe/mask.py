import sys
import logging
import json
from argparse import ArgumentParser
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox
from PyQt6.QtGui import QIcon
import os
from ten_gbe_ui import Ui_MainWindow

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig

# Mapping between the JSON parameter keys and the get/set methods used to
# synchronize them with the Qt widgets defined in ten_gbe_ui.py.
# The keys must match scilab_blocks/casper_xps/ten_gbe.json, since the
# Scilab side (update_exprs) only reads back the keys listed in that template.
TEN_GBE_CONFIG = {
    'name':
    {
        'get': 'get_name',
        'set': 'set_name'
    },
    'flavour':
    {
        'get': 'get_flavour',
        'set': 'set_flavour'
    },
    'slot':
    {
        'get': 'get_slot',
        'set': 'set_slot'
    },
    'port_r1':
    {
        'get': 'get_port_r1',
        'set': 'set_port_r1'
    },
    'port_r2_cx4':
    {
        'get': 'get_port_r2_cx4',
        'set': 'set_port_r2_cx4'
    },
    'port_r2_sfpp':
    {
        'get': 'get_port_r2_sfpp',
        'set': 'set_port_r2_sfpp'
    },
    'rx_dist_ram':
    {
        'get': 'get_rx_dist_ram',
        'set': 'set_rx_dist_ram'
    },
    'large_frames':
    {
        'get': 'get_large_frames',
        'set': 'set_large_frames'
    },
    'show_param':
    {
        'get': 'get_show_param',
        'set': 'set_show_param'
    },
    'pre_emph_r2':
    {
        'get': 'get_pre_emph_r2',
        'set': 'set_pre_emph_r2'
    },
    'pre_emph':
    {
        'get': 'get_pre_emph',
        'set': 'set_pre_emph'
    },
    'post_emph_r2':
    {
        'get': 'get_post_emph_r2',
        'set': 'set_post_emph_r2'
    },
    'rxeqmix_r2':
    {
        'get': 'get_rxeqmix_r2',
        'set': 'set_rxeqmix_r2'
    },
    'swing_r2':
    {
        'get': 'get_swing_r2',
        'set': 'set_swing_r2'
    },
    'swing':
    {
        'get': 'get_swing',
        'set': 'set_swing'
    },
    'fab_en':
    {
        'get': 'get_fab_en',
        'set': 'set_fab_en'
    },
    'fab_mac':
    {
        'get': 'get_fab_mac',
        'set': 'set_fab_mac'
    },
    'fab_ip':
    {
        'get': 'get_fab_ip',
        'set': 'set_fab_ip'
    },
    'fab_udp':
    {
        'get': 'get_fab_udp',
        'set': 'set_fab_udp'
    },
    'fab_gate':
    {
        'get': 'get_fab_gate',
        'set': 'set_fab_gate'
    },
    'cpu_rx_en':
    {
        'get': 'get_cpu_rx_en',
        'set': 'set_cpu_rx_en'
    },
    'cpu_tx_en':
    {
        'get': 'get_cpu_tx_en',
        'set': 'set_cpu_tx_en'
    },
    'ttl':
    {
        'get': 'get_ttl',
        'set': 'set_ttl'
    },
    'promisc_mode':
    {
        'get': 'get_promisc_mode',
        'set': 'set_promisc_mode'
    },
    'debug_ctr_width':
    {
        'get': 'get_debug_ctr_width',
        'set': 'set_debug_ctr_width'
    },
    'txctr':
    {
        'get': 'get_txctr',
        'set': 'set_txctr'
    },
    'txerrctr':
    {
        'get': 'get_txerrctr',
        'set': 'set_txerrctr'
    },
    'txerrctr_len':
    {
        'get': 'get_txerrctr_len',
        'set': 'set_txerrctr_len'
    },
    'txofctr':
    {
        'get': 'get_txofctr',
        'set': 'set_txofctr'
    },
    'txfullctr':
    {
        'get': 'get_txfullctr',
        'set': 'set_txfullctr'
    },
    'txvldctr':
    {
        'get': 'get_txvldctr',
        'set': 'set_txvldctr'
    },
    'txsnaplen':
    {
        'get': 'get_txsnaplen',
        'set': 'set_txsnaplen'
    },
    'rxctr':
    {
        'get': 'get_rxctr',
        'set': 'set_rxctr'
    },
    'rxerrctr':
    {
        'get': 'get_rxerrctr',
        'set': 'set_rxerrctr'
    },
    'rxerrctr_len':
    {
        'get': 'get_rxerrctr_len',
        'set': 'set_rxerrctr_len'
    },
    'rxofctr':
    {
        'get': 'get_rxofctr',
        'set': 'set_rxofctr'
    },
    'rxbadctr':
    {
        'get': 'get_rxbadctr',
        'set': 'set_rxbadctr'
    },
    'rxvldctr':
    {
        'get': 'get_rxvldctr',
        'set': 'set_rxvldctr'
    },
    'rxeofctr':
    {
        'get': 'get_rxeofctr',
        'set': 'set_rxeofctr'
    },
    'rxsnaplen':
    {
        'get': 'get_rxsnaplen',
        'set': 'set_rxsnaplen'
    },
}


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


class TenGbeOperations(object):
    def __init__(self, winobj, template_config='ten_gbe.json', target_config='ten_gbe.json', logdir='.', debug=False):
        if debug:
            self.logger = make_rich_logger('ten_gbe.log', logging.DEBUG, mode='a', logdir=logdir)
        else:
            self.logger = make_rich_logger('ten_gbe.log', logging.ERROR, mode='a', logdir=logdir)
        self.logger.info('*************************************************')
        self.logger.info('Ten GbE Mask started.')
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

    def get_flavour(self):
        text = self.ui.flavour.currentText()
        self.logger.debug(f'flavour is {text}')
        return text

    def set_flavour(self, text):
        self.logger.debug(f'Set flavour to {text}')
        self.ui.flavour.setCurrentText(str(text))

    def get_slot(self):
        text = self.ui.slot.currentText()
        self.logger.debug(f'slot is {text}')
        return text

    def set_slot(self, text):
        self.logger.debug(f'Set slot to {text}')
        self.ui.slot.setCurrentText(str(text))

    def get_port_r1(self):
        text = self.ui.port_r1.currentText()
        self.logger.debug(f'port_r1 is {text}')
        return text

    def set_port_r1(self, text):
        self.logger.debug(f'Set port_r1 to {text}')
        self.ui.port_r1.setCurrentText(str(text))

    def get_port_r2_cx4(self):
        text = self.ui.port_r2_cx4.currentText()
        self.logger.debug(f'port_r2_cx4 is {text}')
        return text

    def set_port_r2_cx4(self, text):
        self.logger.debug(f'Set port_r2_cx4 to {text}')
        self.ui.port_r2_cx4.setCurrentText(str(text))

    def get_port_r2_sfpp(self):
        text = self.ui.port_r2_sfpp.currentText()
        self.logger.debug(f'port_r2_sfpp is {text}')
        return text

    def set_port_r2_sfpp(self, text):
        self.logger.debug(f'Set port_r2_sfpp to {text}')
        self.ui.port_r2_sfpp.setCurrentText(str(text))

    def get_rx_dist_ram(self):
        status = self.ui.rx_dist_ram.isChecked()
        self.logger.debug(f'rx_dist_ram status is {status}')
        return self._convert_status(status)

    def set_rx_dist_ram(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rx_dist_ram status to {status}')
        self.ui.rx_dist_ram.setChecked(status)

    def get_large_frames(self):
        status = self.ui.large_frames.isChecked()
        self.logger.debug(f'large_frames status is {status}')
        return self._convert_status(status)

    def set_large_frames(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set large_frames status to {status}')
        self.ui.large_frames.setChecked(status)

    def get_show_param(self):
        status = self.ui.show_param.isChecked()
        self.logger.debug(f'show_param status is {status}')
        return self._convert_status(status)

    def set_show_param(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set show_param status to {status}')
        self.ui.show_param.setChecked(status)

    def get_pre_emph_r2(self):
        text = self.ui.pre_emph_r2.currentText()
        self.logger.debug(f'pre_emph_r2 is {text}')
        return text

    def set_pre_emph_r2(self, text):
        self.logger.debug(f'Set pre_emph_r2 to {text}')
        self.ui.pre_emph_r2.setCurrentText(str(text))

    def get_pre_emph(self):
        text = self.ui.pre_emph.currentText()
        self.logger.debug(f'pre_emph is {text}')
        return text

    def set_pre_emph(self, text):
        self.logger.debug(f'Set pre_emph to {text}')
        self.ui.pre_emph.setCurrentText(str(text))

    def get_post_emph_r2(self):
        text = self.ui.post_emph_r2.currentText()
        self.logger.debug(f'post_emph_r2 is {text}')
        return text

    def set_post_emph_r2(self, text):
        self.logger.debug(f'Set post_emph_r2 to {text}')
        self.ui.post_emph_r2.setCurrentText(str(text))

    def get_rxeqmix_r2(self):
        text = self.ui.rxeqmix_r2.currentText()
        self.logger.debug(f'rxeqmix_r2 is {text}')
        return text

    def set_rxeqmix_r2(self, text):
        self.logger.debug(f'Set rxeqmix_r2 to {text}')
        self.ui.rxeqmix_r2.setCurrentText(str(text))

    def get_swing_r2(self):
        text = self.ui.swing_r2.currentText()
        self.logger.debug(f'swing_r2 is {text}')
        return text

    def set_swing_r2(self, text):
        self.logger.debug(f'Set swing_r2 to {text}')
        self.ui.swing_r2.setCurrentText(str(text))

    def get_swing(self):
        text = self.ui.swing.currentText()
        self.logger.debug(f'swing is {text}')
        return text

    def set_swing(self, text):
        self.logger.debug(f'Set swing to {text}')
        self.ui.swing.setCurrentText(str(text))

    def get_fab_en(self):
        status = self.ui.fab_en.isChecked()
        self.logger.debug(f'fab_en status is {status}')
        return self._convert_status(status)

    def set_fab_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set fab_en status to {status}')
        self.ui.fab_en.setChecked(status)

    def get_fab_mac(self):
        val = self.ui.fab_mac.text()
        self.logger.debug(f'fab_mac is {val}')
        return val

    def set_fab_mac(self, val):
        self.logger.debug(f'Set fab_mac to {val}')
        self.ui.fab_mac.setText(str(val))

    def get_fab_ip(self):
        val = self.ui.fab_ip.text()
        self.logger.debug(f'fab_ip is {val}')
        return val

    def set_fab_ip(self, val):
        self.logger.debug(f'Set fab_ip to {val}')
        self.ui.fab_ip.setText(str(val))

    def get_fab_udp(self):
        val = self.ui.fab_udp.text()
        self.logger.debug(f'fab_udp is {val}')
        return val

    def set_fab_udp(self, val):
        self.logger.debug(f'Set fab_udp to {val}')
        self.ui.fab_udp.setText(str(val))

    def get_fab_gate(self):
        val = self.ui.fab_gate.text()
        self.logger.debug(f'fab_gate is {val}')
        return val

    def set_fab_gate(self, val):
        self.logger.debug(f'Set fab_gate to {val}')
        self.ui.fab_gate.setText(str(val))

    def get_cpu_rx_en(self):
        status = self.ui.cpu_rx_en.isChecked()
        self.logger.debug(f'cpu_rx_en status is {status}')
        return self._convert_status(status)

    def set_cpu_rx_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cpu_rx_en status to {status}')
        self.ui.cpu_rx_en.setChecked(status)

    def get_cpu_tx_en(self):
        status = self.ui.cpu_tx_en.isChecked()
        self.logger.debug(f'cpu_tx_en status is {status}')
        return self._convert_status(status)

    def set_cpu_tx_en(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set cpu_tx_en status to {status}')
        self.ui.cpu_tx_en.setChecked(status)

    def get_ttl(self):
        val = self.ui.ttl.text()
        self.logger.debug(f'ttl is {val}')
        return val

    def set_ttl(self, val):
        self.logger.debug(f'Set ttl to {val}')
        self.ui.ttl.setText(str(val))

    def get_promisc_mode(self):
        status = self.ui.promisc_mode.isChecked()
        self.logger.debug(f'promisc_mode status is {status}')
        return self._convert_status(status)

    def set_promisc_mode(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set promisc_mode status to {status}')
        self.ui.promisc_mode.setChecked(status)

    def get_debug_ctr_width(self):
        val = self.ui.debug_ctr_width.text()
        self.logger.debug(f'debug_ctr_width is {val}')
        return val

    def set_debug_ctr_width(self, val):
        self.logger.debug(f'Set debug_ctr_width to {val}')
        self.ui.debug_ctr_width.setText(str(val))

    def get_txctr(self):
        status = self.ui.txctr.isChecked()
        self.logger.debug(f'txctr status is {status}')
        return self._convert_status(status)

    def set_txctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set txctr status to {status}')
        self.ui.txctr.setChecked(status)

    def get_txerrctr(self):
        status = self.ui.txerrctr.isChecked()
        self.logger.debug(f'txerrctr status is {status}')
        return self._convert_status(status)

    def set_txerrctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set txerrctr status to {status}')
        self.ui.txerrctr.setChecked(status)

    def get_txerrctr_len(self):
        val = self.ui.txerrctr_len.text()
        self.logger.debug(f'txerrctr_len is {val}')
        return val

    def set_txerrctr_len(self, val):
        self.logger.debug(f'Set txerrctr_len to {val}')
        self.ui.txerrctr_len.setText(str(val))

    def get_txofctr(self):
        status = self.ui.txofctr.isChecked()
        self.logger.debug(f'txofctr status is {status}')
        return self._convert_status(status)

    def set_txofctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set txofctr status to {status}')
        self.ui.txofctr.setChecked(status)

    def get_txfullctr(self):
        status = self.ui.txfullctr.isChecked()
        self.logger.debug(f'txfullctr status is {status}')
        return self._convert_status(status)

    def set_txfullctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set txfullctr status to {status}')
        self.ui.txfullctr.setChecked(status)

    def get_txvldctr(self):
        status = self.ui.txvldctr.isChecked()
        self.logger.debug(f'txvldctr status is {status}')
        return self._convert_status(status)

    def set_txvldctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set txvldctr status to {status}')
        self.ui.txvldctr.setChecked(status)

    def get_txsnaplen(self):
        text = self.ui.txsnaplen.currentText()
        self.logger.debug(f'txsnaplen is {text}')
        return text

    def set_txsnaplen(self, text):
        self.logger.debug(f'Set txsnaplen to {text}')
        self.ui.txsnaplen.setCurrentText(str(text))

    def get_rxctr(self):
        status = self.ui.rxctr.isChecked()
        self.logger.debug(f'rxctr status is {status}')
        return self._convert_status(status)

    def set_rxctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxctr status to {status}')
        self.ui.rxctr.setChecked(status)

    def get_rxerrctr(self):
        status = self.ui.rxerrctr.isChecked()
        self.logger.debug(f'rxerrctr status is {status}')
        return self._convert_status(status)

    def set_rxerrctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxerrctr status to {status}')
        self.ui.rxerrctr.setChecked(status)

    def get_rxerrctr_len(self):
        val = self.ui.rxerrctr_len.text()
        self.logger.debug(f'rxerrctr_len is {val}')
        return val

    def set_rxerrctr_len(self, val):
        self.logger.debug(f'Set rxerrctr_len to {val}')
        self.ui.rxerrctr_len.setText(str(val))

    def get_rxofctr(self):
        status = self.ui.rxofctr.isChecked()
        self.logger.debug(f'rxofctr status is {status}')
        return self._convert_status(status)

    def set_rxofctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxofctr status to {status}')
        self.ui.rxofctr.setChecked(status)

    def get_rxbadctr(self):
        status = self.ui.rxbadctr.isChecked()
        self.logger.debug(f'rxbadctr status is {status}')
        return self._convert_status(status)

    def set_rxbadctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxbadctr status to {status}')
        self.ui.rxbadctr.setChecked(status)

    def get_rxvldctr(self):
        status = self.ui.rxvldctr.isChecked()
        self.logger.debug(f'rxvldctr status is {status}')
        return self._convert_status(status)

    def set_rxvldctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxvldctr status to {status}')
        self.ui.rxvldctr.setChecked(status)

    def get_rxeofctr(self):
        status = self.ui.rxeofctr.isChecked()
        self.logger.debug(f'rxeofctr status is {status}')
        return self._convert_status(status)

    def set_rxeofctr(self, status):
        status = self._convert_status(status)
        self.logger.debug(f'Set rxeofctr status to {status}')
        self.ui.rxeofctr.setChecked(status)

    def get_rxsnaplen(self):
        text = self.ui.rxsnaplen.currentText()
        self.logger.debug(f'rxsnaplen is {text}')
        return text

    def set_rxsnaplen(self, text):
        self.logger.debug(f'Set rxsnaplen to {text}')
        self.ui.rxsnaplen.setCurrentText(str(text))


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
        if str(self.get_fab_mac()).strip() == '':
            errors.append('Fabric MAC Address must not be empty.')
        if str(self.get_fab_ip()).strip() == '':
            errors.append('Fabric IP Address must not be empty.')
        if str(self.get_fab_udp()).strip() == '':
            errors.append('Fabric UDP Port must not be empty.')
        if str(self.get_fab_gate()).strip() == '':
            errors.append('Fabric Gateway must not be empty.')
        if str(self.get_ttl()).strip() == '':
            errors.append('TTL must not be empty.')
        debug_ctr_width_str = str(self.get_debug_ctr_width()).strip()
        if debug_ctr_width_str == '':
            errors.append('Debug counter width must not be empty.')
        else:
            try:
                # ported from the real init_call: debug counters must be > 0
                if int(debug_ctr_width_str) <= 0:
                    errors.append('Debug counters cannot be <= zero.')
            except ValueError:
                pass
        if str(self.get_txerrctr_len()).strip() == '':
            errors.append('-- expected TX packet length must not be empty.')
        if str(self.get_rxerrctr_len()).strip() == '':
            errors.append('-- expected RX packet length must not be empty.')
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
            if k in TEN_GBE_CONFIG:
                setfunc = TEN_GBE_CONFIG[k]['set']
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
            QMessageBox.critical(self.winobj, 'Invalid Ten GbE parameters', chr(10).join(errors))
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
            config['parameters']['tag'] = 'xps:ten_gbe'
        for k, v in TEN_GBE_CONFIG.items():
            getfunc = v['get']
            config['parameters'][k] = str(getattr(self, getfunc)())
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)
        return True


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for Ten GbE Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='ten_gbe.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = TenGbeOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
