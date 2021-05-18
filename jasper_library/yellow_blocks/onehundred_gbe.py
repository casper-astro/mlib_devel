from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, ClockGroupConstraint
from helpers import to_int_list
from .yellow_block_typecodes import *
from os.path import join
from memory import Register

class onehundred_gbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118', 'vcu128'] or plat.conf.get('family', None) in ["ultrascaleplus"]:
            return onehundredgbe_usplus(blk, plat, hdl_root)
        else:
            raise RuntimeError("Don't know how to implement 100GbE for this board/FPGA")
    """
    Future common methods here.
    """

class onehundredgbe_usplus(onehundred_gbe):
    def initialize(self):
        self.missing_registers = ['gmac_reg_bytes_rdy']
        self.memory_map = [
            Register('gmac_reg_core_type',            mode='r',  offset=0x00),
            Register('gmac_reg_buffer_max_size',      mode='r',  offset=0x04),
            Register('gmac_reg_word_size',            mode='r',  offset=0x08),
            Register('gmac_reg_mac_address_h',        mode='rw', offset=0x0C, default_val=(self.fab_mac & 0xffffffff)),
            Register('gmac_reg_mac_address_l',        mode='rw', offset=0x10, default_val=(self.fab_mac >> 32)),
            Register('gmac_reg_local_ip_address',     mode='rw', offset=0x14, default_val=self.fab_ip),
            Register('gmac_reg_gateway_ip_address',   mode='rw', offset=0x18, default_val=self.fab_gate),

            Register('gmac_reg_local_ip_netmask',     mode='rw', offset=0x1C),
            Register('gmac_reg_multicast_ip_address', mode='rw', offset=0x20, default_val=0),
            Register('gmac_reg_multicast_ip_mask',    mode='rw', offset=0x24, default_val=0),
            Register('gmac_reg_bytes_rdy',            mode='rw', offset=0x28),
            Register('gmac_reg_core_ctrl',            mode='rw', offset=0x2C, default_val=int(self.fab_en)),
            Register('gmac_reg_udp_port',             mode='rw', offset=0x30, default_val=self.fab_udp),
            Register('gmac_reg_phy_status_h',         mode='r',  offset=0x34),
            Register('gmac_reg_phy_status_l',         mode='r',  offset=0x38),
            Register('gmac_reg_phy_control_h',        mode='rw', offset=0x3C, default_val=0),
            Register('gmac_reg_phy_control_l',        mode='rw', offset=0x40, default_val=0),
            Register('gmac_reg_arp_size',             mode='r',  offset=0x44),
            Register('gmac_reg_tx_packet_rate',       mode='r',  offset=0x48),
            Register('gmac_reg_tx_packet_count',      mode='r',  offset=0x4C),
            Register('gmac_reg_tx_valid_rate',        mode='r',  offset=0x50),
            Register('gmac_reg_tx_valid_count',       mode='r',  offset=0x54),
            Register('gmac_reg_tx_overflow_count',    mode='r',  offset=0x58),
            Register('gmac_reg_tx_almost_full_count', mode='r',  offset=0x5C),
            Register('gmac_reg_rx_packet_rate',       mode='r',  offset=0x60),
            Register('gmac_reg_rx_packet_count',      mode='r',  offset=0x64),
            Register('gmac_reg_rx_valid_rate',        mode='r',  offset=0x68),
            Register('gmac_reg_rx_valid_count',       mode='r',  offset=0x6C),
            Register('gmac_reg_rx_overflow_count',    mode='r',  offset=0x70),
            Register('gmac_reg_rx_bad_packet_count',  mode='r',  offset=0x74),
            Register('gmac_reg_count_reset',          mode='rw', offset=0x78, default_val=0),

            # The 100G core doesn't have an interface for the ARP cache which will work with the
            # AXI infrastructure we currently have, so make a new one and deal with it in software :-S
            #Register('gmac_reg_arp_cache',            mode='rw', offset=0x1000, ram=True, ram_size=8*256, data_width=32),
            Register('gmac_arp_cache_write_enable',   mode='rw', offset=0x1000, default_val=0),
            Register('gmac_arp_cache_read_enable',    mode='rw', offset=0x1004, default_val=0),
            Register('gmac_arp_cache_write_data',     mode='rw', offset=0x1008, default_val=0),
            Register('gmac_arp_cache_write_address',  mode='rw', offset=0x100C, default_val=0),
            Register('gmac_arp_cache_read_address',   mode='rw', offset=0x1010, default_val=0),
            Register('gmac_arp_cache_read_data',      mode='r',  offset=0x1014),

            # Ignore RX/TX buffers for now -- do these actually work in the 100G core as per the mem map?
            #Register('gmac_reg_tx_buf',    mode='rw', offset=0x4000, ram=True, ram_size=2048),
            #Register('gmac_reg_rx_buf',    mode='rw', offset=0x8000, ram=True, ram_size=2048),
        ]

        self.typecode = TYPECODE_ETHCORE
        kdir = "onehundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl"

        self.add_source('onehundred_gbe/casper100g_noaxi.v')
        self.add_source('onehundred_gbe/async.v')
        self.add_source(kdir + '/preconfig/protocolchecksumprconfigsm.vhd')
        self.add_source(kdir + '/preconfig/prconfigcontroller.vhd')
        self.add_source(kdir + '/preconfig/icapwritersm.vhd')
        self.add_source(kdir + '/preconfig/protocolresponderprconfigsm.vhd')
        self.add_source(kdir + '/udp/axioffseter.vhd')
        self.add_source(kdir + '/udp/udpipinterfacepr.vhd')
        self.add_source(kdir + '/udp/udpstreamingapps.vhd')
        self.add_source(kdir + '/udp/udpdatastripper.vhd')
        self.add_source(kdir + '/udp/udpdatapacker_jh.vhd')
        self.add_source(kdir + '/udp/casper100gethernetblock_no_cpu.vhd')
        self.add_source(kdir + '/udp/udpstreamingapp.vhd')
        self.add_source(kdir + '/macphy/mac100gphy.vhd')
        self.add_source(kdir + '/macphy/macaxissender.vhd')
        self.add_source(kdir + '/macphy/macaxisdecoupler.vhd')
        self.add_source(kdir + '/macphy/macaxisreceiver.vhd')
        self.add_source(kdir + '/macphy/gmacqsfptop.vhd')
        self.add_source(kdir + '/ringbuffer/cpudualportpacketringbuffer.vhd')
        self.add_source(kdir + '/ringbuffer/packetringbuffer.vhd')
        self.add_source(kdir + '/ringbuffer/dualportpacketringbuffer.vhd')
        self.add_source(kdir + '/ringbuffer/packetramsp.vhd')
        self.add_source(kdir + '/ringbuffer/cpuifsenderpacketringbuffer.vhd')
        self.add_source(kdir + '/ringbuffer/cpuifreceiverpacketringbuffer.vhd')
        self.add_source(kdir + '/ringbuffer/packetstatusram.vhd')
        self.add_source(kdir + '/ringbuffer/packetramdp.vhd')
        self.add_source(kdir + '/ringbuffer/truedualportpacketringbuffer.vhd')
        self.add_source(kdir + '/arp/arpreceiver.vhd')
        self.add_source(kdir + '/arp/arpmodule.vhd')
        self.add_source(kdir + '/arp/arpramadpwrr.vhd')
        self.add_source(kdir + '/arp/arpcache.vhd')
        self.add_source(kdir + '/arp/arpramadpwr.vhd')
        self.add_source(kdir + '/arp/ramdpwr.vhd')
        self.add_source(kdir + '/arp/ramdpwrr.vhd')
        self.add_source(kdir + '/udp/macinterface/macifudpreceiver.vhd')
        self.add_source(kdir + '/udp/macinterface/yellow_block_100gbe_udp_rx.vhd')
        self.add_source(kdir + '/udp/macinterface/macifudpsender.vhd')
        self.add_source(kdir + '/udp/macinterface/axisfabricmultiplexer.vhd')
        self.add_source(kdir + '/udp/macinterface/cpuethernetmacif.vhd')
        self.add_source(kdir + '/udp/macinterface/macifudpserver.vhd')
        self.add_source(kdir + '/udp/macinterface/axistwoportfabricmultiplexer.vhd')
        self.add_source(kdir + '/udp/macinterface/axisthreeportfabricmultiplexer.vhd')
        self.add_source(kdir + '/udp/macinterface/cpuinterface/cpumacifudpreceiver.vhd')
        self.add_source(kdir + '/udp/macinterface/cpuinterface/cpumacifethernetreceiver.vhd')
        self.add_source(kdir + '/udp/macinterface/cpuinterface/cpumacifudpsender.vhd')
        self.add_source('onehundred_gbe/ip/axispacketbufferfifo/axispacketbufferfifo.xci')
        self.add_source('onehundred_gbe/ip/async_fifo_513b_512deep/async_fifo_513b_512deep.xci')
        self.add_source('onehundred_gbe/ip/axis_data_fifo/axis_data_fifo_0.xci')
        self.add_source('onehundred_gbe/ip/EthMACPHY100GQSFP4x/EthMACPHY100GQSFP4x.xci')
        self.add_source('onehundred_gbe/ip/dest_address_fifo/dest_address_fifo.xci')
        if self.platform.mmbus_architecture[0] == 'wishbone':
            self.add_source('onehundred_gbe/casper100g_wb_attach.v')

        ## TODO: remove this when we're done debugging
        if self.platform in ['vcu118']:
            self.add_source('onehundred_gbe/debug.xdc')

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

        # For partial reconfig, it is useful to have statically-named top-level ports
        # which don't depend on model name. Generate a prefix which will probably
        # be unique
        self.portbase = '{blocktype}{port}'.format(blocktype=self.blocktype, port=self.port)

        try:
            ethconf = self.platform.conf["onehundredgbe"]
        except KeyError:
            self.logger.exception("Failed to find `onehundredgbe` configuration in platform's YAML file")
            raise
        
        try:
            self.refclk_freq_str = ethconf["refclk_freq_str"]
        except KeyError:
            self.logger.error("Missing onehundredgbe `refclk_freq_str` parameter in YAML file")
            raise
        self.refclk_freq = float(self.refclk_freq_str)
        try:
            self.cmac_loc = ethconf["cmac_loc"][self.port]
        except KeyError:
            self.logger.error("Missing onehundredgbe `cmac_loc` parameter in YAML file")
            raise
        except IndexError:
            self.logger.error("Missing entry for port %d in onehundredgbe `cmac_loc` parameter" % self.port)
            raise

    def modify_top(self, top):
        inst = top.get_instance(entity='casper100g_noaxi', name=self.fullname+'_inst')

        if self.platform.mmbus_architecture[0] == 'wishbone':
            ctrl = top.get_instance(entity='casper100g_wb_attach', name=self.fullname+'_wb_attach_inst')
            ctrl.add_wb_interface(self.unique_name, mode='rw', nbytes=0xF000)
        else:
            # The below call doesn't (yet) add any AXI ports to `inst`, which is required
            # for anything useful to happen.
            # But the 100G core doesn't (yet) have an axi interface exposed in the HDL anyway!
            top.add_axi4lite_interface(regname=self.unique_name, mode='rw', nbytes=65536,
                                        typecode=self.typecode, memory_map=self.memory_map)

        # Set defaults at startup. The AXI registers above (which have defaults) won't
        # automatically propagate because until they are written externally their write-enable
        # output lines don't pulse
        inst.add_parameter("FABRIC_MAC", "48'h%x" % self.fab_mac)
        inst.add_parameter("FABRIC_IP", "32'h%x" % self.fab_ip)
        inst.add_parameter("FABRIC_PORT", "16'h%x" % self.fab_udp)
        inst.add_parameter("FABRIC_GATEWAY", "32'h%x" % self.fab_gate)
        inst.add_parameter("FABRIC_ENABLE_ON_START", "1'b%d" % int(self.fab_en))
        
        inst.add_port('RefClk100MHz', 'sys_clk') # sys_clk is decreed to be 100 MHz.
        inst.add_port('RefClkLocked', '~sys_rst', parent_sig=False)
        if self.platform.mmbus_architecture[0] == 'wishbone':
            inst.add_port('aximm_clk', 'wb_clk_i')
            inst.add_port('icap_clk', 'wb_clk_i')
        else:
            inst.add_port('aximm_clk', 'axil_clk')
            inst.add_port('icap_clk', 'axil_clk')
        inst.add_port('axis_reset',              self.fullname+'_rst')
        # MGT connections
        inst.add_port('mgt_qsfp_clock_p', self.portbase+'_refclk_p', dir='in', parent_port=True)
        inst.add_port('mgt_qsfp_clock_n', self.portbase+'_refclk_n', dir='in', parent_port=True)

        inst.add_port('qsfp_mgt_rx_p', self.portbase+'_qsfp_mgt_rx_p', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_rx_n', self.portbase+'_qsfp_mgt_rx_n', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_p', self.portbase+'_qsfp_mgt_tx_p', dir='out', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_n', self.portbase+'_qsfp_mgt_tx_n', dir='out', width=4, parent_port=True)
        # QSFP config interface
        if self.platform.name in ['vcu118']:
            inst.add_port('qsfp_modsell_ls', self.portbase+'_qsfp_modsell_ls', dir='out', parent_port=True)
            inst.add_port('qsfp_resetl_ls',  self.portbase+'_qsfp_resetl_ls',  dir='out', parent_port=True)
            inst.add_port('qsfp_modprsl_ls', self.portbase+'_qsfp_modprsl_ls', dir='in',  parent_port=True)
            inst.add_port('qsfp_lpmode_ls',  self.portbase+'_qsfp_lpmode_ls',  dir='out', parent_port=True)
            inst.add_port('qsfp_intl_ls',    '1\'b1') #self.portbase+'_qsfp_intl_ls')
        else:
            inst.add_port('qsfp_modsell_ls', '') #self.portbase+'_qsfp_modsell_ls')
            inst.add_port('qsfp_resetl_ls',  '') #self.portbase+'_qsfp_resetl_ls')
            inst.add_port('qsfp_modprsl_ls', self.portbase+'_qsfp_modprsl_ls', dir='in', parent_port=True)
            inst.add_port('qsfp_intl_ls',    '1\'b1') #self.portbase+'_qsfp_intl_ls')
            inst.add_port('qsfp_lpmode_ls',  '') #self.portbase+'_qsfp_lpmode_ls')

        inst.add_port('user_clk', 'user_clk')

        # Simulink Interfaces
        inst.add_port('gbe_tx_afull',         self.fullname+'_tx_afull')        
        inst.add_port('gbe_tx_overflow',      self.fullname+'_tx_overflow')
        inst.add_port('gbe_rx_data',          self.fullname+'_rx_data',        width=512)
        inst.add_port('gbe_rx_valid',         self.fullname+'_rx_valid')
        inst.add_port('gbe_rx_source_ip',     self.fullname+'_rx_source_ip',   width=32)
        inst.add_port('gbe_rx_source_port',   self.fullname+'_rx_source_port', width=16)
        inst.add_port('gbe_rx_dest_ip',       self.fullname+'_rx_dest_ip',     width=32)
        inst.add_port('gbe_rx_dest_port',     self.fullname+'_rx_dest_port',   width=16)
        inst.add_port('gbe_rx_end_of_frame',  self.fullname+'_rx_end_of_frame')
        inst.add_port('gbe_rx_bad_frame',     self.fullname+'_rx_bad_frame')
        inst.add_port('gbe_rx_overrun',       self.fullname+'_rx_overrun')
        inst.add_port('gbe_led_up',           self.fullname+'_led_up')
        inst.add_port('gbe_led_rx',           self.fullname+'_led_rx')
        inst.add_port('gbe_led_tx',           self.fullname+'_led_tx')

        inst.add_port('gbe_rst',              self.fullname+'_rst')
        inst.add_port('gbe_rx_ack',           self.fullname+'_rx_ack')
        inst.add_port('gbe_rx_overrun_ack',   self.fullname+'_rx_overrun_ack')
        inst.add_port('gbe_tx_dest_ip',       self.fullname+'_tx_dest_ip',     width=32)
        inst.add_port('gbe_tx_dest_port',     self.fullname+'_tx_dest_port',   width=16)
        inst.add_port('gbe_tx_data',          self.fullname+'_tx_data',        width=512)
        inst.add_port('gbe_tx_valid',         self.fullname+'_tx_valid',       width=4)
        inst.add_port('gbe_tx_end_of_frame',  self.fullname+'_tx_end_of_frame')

        # Register interfaces
        for reg in self.memory_map:
            if reg.name in self.missing_registers:
                continue
            if not reg.ram:
                if 'w' in reg.mode:
                    if self.platform.mmbus_architecture[0] == 'wishbone':
                        ctrl.add_port(reg.name, self.unique_name+'_'+reg.name, width=32)
                        inst.add_port(reg.name, self.unique_name+'_'+reg.name, width=32)
                        inst.add_port(reg.name+'_we', "1'b1")
                    else:
                        # NOONE KNOWS HOW THE AXI INTERCONNECT IS GENERATED, SO THE BELOW
                        # PORT NAMES WERE DETERMINED BY TRIAL AND ERROR
                        inst.add_port(reg.name, self.unique_name+'_'+reg.name+'_out', width=32)
                        inst.add_port(reg.name+'_we', self.unique_name+'_'+reg.name+'_out_we', width=1)
                else:
                    if self.platform.mmbus_architecture[0] == 'wishbone':
                        ctrl.add_port(reg.name, self.unique_name+'_'+reg.name, width=32)
                        inst.add_port(reg.name, self.unique_name+'_'+reg.name, width=32)
                    else:
                        inst.add_port(reg.name, self.unique_name+'_'+reg.name+'_in', width=32)
                        # Read-only ports on the AXI interconnect have a write enable input. Tie it high.
                        # The sys_clkcounter reg doesn't seem to do this, so who knows how it works.
                        # Maybe it doesn't.
                        top.assign_signal(self.unique_name+'_'+reg.name+'_in_we', "1'b1")

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.portbase+'_refclk_p', 'qsfp_mgt_ref_clk_p', iogroup_index=self.port)]
        consts += [PortConstraint(self.portbase+'_refclk_n', 'qsfp_mgt_ref_clk_n', iogroup_index=self.port)]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_rx_p', 'qsfp_mgt_rx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_rx_n', 'qsfp_mgt_rx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_tx_p', 'qsfp_mgt_tx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_tx_n', 'qsfp_mgt_tx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]

        if self.platform.name in ['vcu118']:
            consts += [PortConstraint(self.portbase+'_qsfp_modsell_ls', 'qsfp_modsell_ls', iogroup_index=self.port)]
            consts += [PortConstraint(self.portbase+'_qsfp_resetl_ls',  'qsfp_resetl_ls', iogroup_index=self.port)]
            consts += [PortConstraint(self.portbase+'_qsfp_modprsl_ls', 'qsfp_modprsl_ls', iogroup_index=self.port)]
            consts += [PortConstraint(self.portbase+'_qsfp_lpmode_ls',  'qsfp_lpmode_ls', iogroup_index=self.port)]
        else:
            consts += [PortConstraint(self.portbase+'_qsfp_modprsl_ls', 'qsfp_modprsl_ls', iogroup_index=self.port)]

        clkname = self.portbase+'_refclk_p' # defined by IP
        #self.myclk = ClockConstraint(self.portbase+'_refclk_p', freq=self.refclk_freq)
        #consts += [self.myclk]
        # Set the 100G clock to be asynchronous to both the user clock and the system clock / axi clk
        consts += [ClockGroupConstraint('-include_generated_clocks -of_objects [get_ports sys_clk_p]', '-include_generated_clocks %s' % clkname, 'asynchronous')]
        consts += [ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets user_clk]', '-include_generated_clocks %s' % clkname, 'asynchronous')]
        consts += [ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets axil_clk]', '-include_generated_clocks %s' % clkname, 'asynchronous')]

        return consts

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        # Override the IP reference clock frequency
        tcl_cmds['pre_synth'] = ['set_property -dict [list CONFIG.GT_REF_CLK_FREQ {%s}] [get_ips EthMACPHY100GQSFP4x]' % self.refclk_freq_str]

        # The LOCs seem to get overriden by the user constraints above, but we need to manually unplace the CMAC blocks
        # Unplace all CMACs post_synth, then place all pre_impl, to avoid situations where we try to place on a site already being used
        tcl_cmds['pre_impl'] = []
        tcl_cmds['pre_impl'] += ['unplace_cell [get_cells -hierarchical -filter { PRIMITIVE_TYPE == ADVANCED.MAC.CMACE4 && NAME =~ "*%s_inst/*" }]' % self.fullname]
        tcl_cmds['pre_impl'] += ['place_cell [get_cells -hierarchical -filter { PRIMITIVE_TYPE == ADVANCED.MAC.CMACE4 && NAME =~ "*%s_inst/*" }] %s' % (self.fullname, self.cmac_loc)]
        return tcl_cmds
