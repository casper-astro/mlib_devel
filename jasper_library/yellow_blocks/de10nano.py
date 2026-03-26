from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, PortConstraint
import glob, os

# Infer signal width based on common AXI naming conventions
def signal_width(sig):
    if 'addr' in sig or 'data' in sig:
        return 32
    elif 'strb' in sig:
        return 4
    elif 'resp' in sig:
        return 2
    else:
        return 1

class de10nano(YellowBlock):
    def initialize(self):
        """
        Called once when the platform block is created.
        Defines board-level parameters, available resources, and HDL sources.
        """
        self.name = 'de10nano'
        self.fpga = '5CSEBA6U23I7'
        self.family = 'Cyclone V'
        self.manufacturer = 'intel'
        
        # Quartus requires project-mode operation for IP handling
        self.project_mode = True
        
        # For compatibility with CASPER naming conventions
        self.blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
        self.backend_name = 'quartus'

        # Clock frequency from YAML platform config
        self.pl_clk_mhz = self.blk['pl_clk_rate']
        self.T_pl_clk_ns = 1.0/self.pl_clk_mhz*1000

        # Exported board-level signals that other YellowBlocks may request
        for p in ['sys_clk','sys_rst','axil_clk','axil_rst_n','fpga_clk1_50','fpga_clk2_50','fpga_clk3_50','pl_sysref']:
            self.provides.append(p)

       
        # ------------------------------------------------------------------
        # Add HDL sources: AXI4-Lite, registers, bridges, CDC, soc_system.v
        # ------------------------------------------------------------------
        
        hdl_root = os.environ['HDL_ROOT']
        for patt in ['utils/cdc_synchroniser.vhd', 'axi4_lite/*.v', 'axi4_lite/*.sv', 'axi4_register/*.v', 'axi4_register/*.sv', 'de10nano/axi_axil_adapter*.v', 'de10nano/*.v', 'de10nano/*.sv', 'de10nano/soc_system/synthesis/*.v',  'de10nano/soc_system/synthesis/*.sv']:
            for f in glob.glob(os.path.join(hdl_root, patt)):
                rel = os.path.relpath(f, hdl_root)
                print('Adding path for...' + str(rel))
                try:
                    substr = f[f.rfind('/')+1:]
                    if 'de10nano' not in substr:
                        self.add_source(rel)
                    else:
                        print('Not adding ' + rel)
                except Exception:
                    pass

    # ----------------------------------------------------------------------
    # modify_top(): CASPER auto-top builder calls this to populate top.v
    # ----------------------------------------------------------------------

    def modify_top(self, top):
        """
        Wire:
        - Device pins
        - clocks
        - AXI-Lite nets
        - soc_system (HPS subsystem) ports
        - AXI to AXI-Lite bridge instance
        - DDR3 interface to top-level pins
        """

        # --- Board clock (name must match the QSF/board pin) ---
        top.add_port('FPGA_CLK1_50', dir='in')


        # Alias for legacy/generated references that still use lowercase
        top.add_signal('fpga_clk1_50')
        top.add_raw_string("assign fpga_clk1_50 = FPGA_CLK1_50;")

        # Fabric clocks
        top.add_signal('sys_clk')
        #top.assign_signal('sys_clk', 'FPGA_CLK1_50')
        top.assign_signal('sys_clk', 'fpga_clk1_50')

        # AXI-Lite interconnect operates on the same clock
        top.add_signal('axil_clk')
        top.assign_signal('axil_clk', 'fpga_clk1_50')

        # ------------------------------------------------------------------
        # Internal AXI-Lite master bus (from axi_axil_adapter)
        # ------------------------------------------------------------------
        axi = [
            ('M_AXI_awaddr', 32), ('M_AXI_awprot', 3),
            ('M_AXI_awvalid', 1), ('M_AXI_awready', 1),
            ('M_AXI_wdata',  32), ('M_AXI_wstrb',  4),
            ('M_AXI_wvalid', 1),  ('M_AXI_wready', 1),
            ('M_AXI_bresp',   2), ('M_AXI_bvalid', 1), 
            ('M_AXI_bready', 1),  ('M_AXI_araddr', 32), 
            ('M_AXI_arprot', 3),  ('M_AXI_arvalid', 1), 
            ('M_AXI_arready', 1), ('M_AXI_rdata',  32), 
            ('M_AXI_rresp',  2),  ('M_AXI_rvalid', 1), ('M_AXI_rready', 1)]
        for name, w in axi:
            top.add_signal(name, width=w if w > 1 else None)

        # -------------------------------------------------------------------
        # soc_system_inst ? the Platform Designer / Qsys-generated HPS system
        # -------------------------------------------------------------------        
        sys = top.get_instance('soc_system', 'soc_system_inst')

        # # Basic HPS/fabric clocks + reset
        top.add_signal('h2f_rst_n')   # from HPS to fabric (active-high)
        top.add_signal('axil_rst')    # active-high fabric reset
        top.add_signal('axil_rst_n')
        top.add_signal('user_rst')


        sys.add_port('clk_clk', 'axil_clk', dir='in')
        sys.add_port('hps_0_h2f_reset_reset_n', 'h2f_rst_n', dir='out')
        

        # ------------------------------------------------------------------
        # Add ALL HPS?Fabric full AXI ports (21b addr, full bursts, etc.)
        # These ports are consumed by axi_axil_adapter.
        # ------------------------------------------------------------------
        sys.add_port('hps_0_h2f_lw_axi_master_araddr',   'hps_0_h2f_lw_axi_master_araddr', dir='out', width=21)
        sys.add_port('hps_0_h2f_lw_axi_master_arburst',  'hps_0_h2f_lw_axi_master_arburst', dir='out', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_arcache',  'hps_0_h2f_lw_axi_master_arcache', dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_arid',     'hps_0_h2f_lw_axi_master_arid', dir='out', width=12)

        sys.add_port('hps_0_h2f_lw_axi_master_arlen',    'hps_0_h2f_lw_axi_master_arlen', dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_arlock',   'hps_0_h2f_lw_axi_master_arlock', dir='out', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_arprot',   'hps_0_h2f_lw_axi_master_arprot', dir='out', width=3)
        sys.add_port('hps_0_h2f_lw_axi_master_arready',  'hps_0_h2f_lw_axi_master_arready', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_arsize',   'hps_0_h2f_lw_axi_master_arsize', dir='out', width=3)
        sys.add_port('hps_0_h2f_lw_axi_master_arvalid',  'hps_0_h2f_lw_axi_master_arvalid', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_awaddr',   'hps_0_h2f_lw_axi_master_awaddr', dir='out', width=21)
        sys.add_port('hps_0_h2f_lw_axi_master_awburst',  'hps_0_h2f_lw_axi_master_awburst', dir='out', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_awcache',  'hps_0_h2f_lw_axi_master_awcache', dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_awid',     'hps_0_h2f_lw_axi_master_awid', dir='out', width=12)
        sys.add_port('hps_0_h2f_lw_axi_master_awlen',    'hps_0_h2f_lw_axi_master_awlen', dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_awlock',   'hps_0_h2f_lw_axi_master_awlock', dir='out', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_awprot',   'hps_0_h2f_lw_axi_master_awprot', dir='out', width=3)
        sys.add_port('hps_0_h2f_lw_axi_master_awready',  'hps_0_h2f_lw_axi_master_awready', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_awsize',   'hps_0_h2f_lw_axi_master_awsize', dir='out', width=3)
        sys.add_port('hps_0_h2f_lw_axi_master_awvalid',  'hps_0_h2f_lw_axi_master_awvalid', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_bid',      'hps_0_h2f_lw_axi_master_bid', dir='in', width=12)
        sys.add_port('hps_0_h2f_lw_axi_master_bready',   'hps_0_h2f_lw_axi_master_bready', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_bresp',    'hps_0_h2f_lw_axi_master_bresp', dir='in', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_bvalid',   'hps_0_h2f_lw_axi_master_bvalid', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_rdata',    'hps_0_h2f_lw_axi_master_rdata', dir='in', width=32)
        sys.add_port('hps_0_h2f_lw_axi_master_rid',      'hps_0_h2f_lw_axi_master_rid', dir='in', width=12)
        sys.add_port('hps_0_h2f_lw_axi_master_rlast',    'hps_0_h2f_lw_axi_master_rlast', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_rready',   'hps_0_h2f_lw_axi_master_rready', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_rresp',    'hps_0_h2f_lw_axi_master_rresp', dir='in', width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_rvalid',   'hps_0_h2f_lw_axi_master_rvalid', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_wdata',    'hps_0_h2f_lw_axi_master_wdata', dir='out', width=32)
        sys.add_port('hps_0_h2f_lw_axi_master_wid',      'hps_0_h2f_lw_axi_master_wid', dir='out', width=12)
        sys.add_port('hps_0_h2f_lw_axi_master_wlast',    'hps_0_h2f_lw_axi_master_wlast', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_wready',   'hps_0_h2f_lw_axi_master_wready', dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_wstrb',    'hps_0_h2f_lw_axi_master_wstrb', dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_wvalid',   'hps_0_h2f_lw_axi_master_wvalid', dir='out')


        # ------------------------------------------------------------------
        # Helper reduced-width conversion required by axi_axil_adapter
        # ------------------------------------------------------------------
        top.add_signal('awlen8', width=8)
        top.add_signal('arlen8', width=8)
        top.add_signal('awlock1')
        top.add_signal('arlock1')

        top.add_raw_string("assign awlen8  = {4'b0000, hps_0_h2f_lw_axi_master_awlen};")
        top.add_raw_string("assign arlen8  = {4'b0000, hps_0_h2f_lw_axi_master_arlen};")
        top.add_raw_string("assign awlock1 = (hps_0_h2f_lw_axi_master_awlock == 2'b01);")
        top.add_raw_string("assign arlock1 = (hps_0_h2f_lw_axi_master_arlock == 2'b01);")

        # ------------------------------------------------------------------
        # AXI?AXI-Lite adapter instance
        # ------------------------------------------------------------------
        bridge = top.get_instance('axi_axil_adapter', 'axi_axil_adapter')
        bridge.add_parameter('AXI_ID_WIDTH',   12)
        bridge.add_parameter('ADDR_WIDTH',     21)
        bridge.add_parameter('AXI_DATA_WIDTH', 32)
        bridge.add_parameter('AXIL_DATA_WIDTH',32)

        # Clock/reset for the bridge: assumes axil_clk/axil_rst already defined
        bridge.add_port('clk', 'axil_clk')
        bridge.add_port('rst', 'axil_rst')

        bridge.add_port('s_axi_awid',   'hps_0_h2f_lw_axi_master_awid',     width = 12)
        bridge.add_port('s_axi_awaddr', 'hps_0_h2f_lw_axi_master_awaddr',   width = 21)
        bridge.add_port('s_axi_awlen',  'awlen8',                           width = 8)
        bridge.add_port('s_axi_awsize', 'hps_0_h2f_lw_axi_master_awsize',   width = 3)
        bridge.add_port('s_axi_awburst','hps_0_h2f_lw_axi_master_awburst',  width = 2)
        bridge.add_port('s_axi_awlock', 'awlock1')
        bridge.add_port('s_axi_awcache','hps_0_h2f_lw_axi_master_awcache',  width = 4)
        bridge.add_port('s_axi_awprot', 'hps_0_h2f_lw_axi_master_awprot',   width = 3)
        bridge.add_port('s_axi_awvalid','hps_0_h2f_lw_axi_master_awvalid')
        bridge.add_port('s_axi_awready','hps_0_h2f_lw_axi_master_awready')

        bridge.add_port('s_axi_wdata', 'hps_0_h2f_lw_axi_master_wdata',     width = 32)
        bridge.add_port('s_axi_wstrb', 'hps_0_h2f_lw_axi_master_wstrb',     width = 4)
        bridge.add_port('s_axi_wlast', 'hps_0_h2f_lw_axi_master_wlast')
        bridge.add_port('s_axi_wvalid','hps_0_h2f_lw_axi_master_wvalid')
        bridge.add_port('s_axi_wready','hps_0_h2f_lw_axi_master_wready')

        bridge.add_port('s_axi_bid',   'hps_0_h2f_lw_axi_master_bid',       width = 12)
        bridge.add_port('s_axi_bresp', 'hps_0_h2f_lw_axi_master_bresp',     width = 2)
        bridge.add_port('s_axi_bvalid','hps_0_h2f_lw_axi_master_bvalid')
        bridge.add_port('s_axi_bready','hps_0_h2f_lw_axi_master_bready')

        bridge.add_port('s_axi_arid',   'hps_0_h2f_lw_axi_master_arid',     width = 12)
        bridge.add_port('s_axi_araddr', 'hps_0_h2f_lw_axi_master_araddr',   width = 21)
        bridge.add_port('s_axi_arlen',  'arlen8',                           width = 8)
        bridge.add_port('s_axi_arsize', 'hps_0_h2f_lw_axi_master_arsize',   width = 3)
        bridge.add_port('s_axi_arburst','hps_0_h2f_lw_axi_master_arburst',  width = 2)
        bridge.add_port('s_axi_arlock', 'arlock1')
        bridge.add_port('s_axi_arcache','hps_0_h2f_lw_axi_master_arcache',  width = 4)
        bridge.add_port('s_axi_arprot', 'hps_0_h2f_lw_axi_master_arprot',   width = 3)
        bridge.add_port('s_axi_arvalid','hps_0_h2f_lw_axi_master_arvalid')
        bridge.add_port('s_axi_arready','hps_0_h2f_lw_axi_master_arready')

        bridge.add_port('s_axi_rid',   'hps_0_h2f_lw_axi_master_rid',       width = 12)
        bridge.add_port('s_axi_rdata', 'hps_0_h2f_lw_axi_master_rdata',     width = 32)
        bridge.add_port('s_axi_rresp', 'hps_0_h2f_lw_axi_master_rresp',     width = 2)
        bridge.add_port('s_axi_rlast', 'hps_0_h2f_lw_axi_master_rlast')
        bridge.add_port('s_axi_rvalid','hps_0_h2f_lw_axi_master_rvalid')
        bridge.add_port('s_axi_rready','hps_0_h2f_lw_axi_master_rready')

        # AXI-Lite host interface towards CASPER axi4lite_interconnect (M_AXI_*)
        bridge.add_port('m_axil_awaddr', 'M_AXI_awaddr',                   width = 32)
        bridge.add_port('m_axil_awprot', 'M_AXI_awprot',                   width = 3)
        bridge.add_port('m_axil_awvalid','M_AXI_awvalid')
        bridge.add_port('m_axil_awready','M_AXI_awready')

        bridge.add_port('m_axil_wdata', 'M_AXI_wdata',                     width = 32)
        bridge.add_port('m_axil_wstrb', 'M_AXI_wstrb',                     width = 4)
        bridge.add_port('m_axil_wvalid','M_AXI_wvalid')
        bridge.add_port('m_axil_wready','M_AXI_wready')

        bridge.add_port('m_axil_bresp', 'M_AXI_bresp',                     width= 2)
        bridge.add_port('m_axil_bvalid','M_AXI_bvalid')
        bridge.add_port('m_axil_bready','M_AXI_bready')

        bridge.add_port('m_axil_araddr', 'M_AXI_araddr',                   width = 32)
        bridge.add_port('m_axil_arprot', 'M_AXI_arprot',                   width = 3)
        bridge.add_port('m_axil_arvalid','M_AXI_arvalid')
        bridge.add_port('m_axil_arready','M_AXI_arready')

        bridge.add_port('m_axil_rdata', 'M_AXI_rdata',                     width = 32)
        bridge.add_port('m_axil_rresp', 'M_AXI_rresp',                     width = 2)
        bridge.add_port('m_axil_rvalid','M_AXI_rvalid')
        bridge.add_port('m_axil_rready','M_AXI_rready')

        # ------------------------------------------------------------------
        # Reset mapping
        # ------------------------------------------------------------------

        top.add_raw_string("assign axil_rst_n = h2f_rst_n;\n")
        top.add_raw_string("assign axil_rst = ~h2f_rst_n;\n")
        top.add_raw_string("assign user_rst = ~h2f_rst_n;\n")

        # ------------------------------------------------------------------
        # Expose DDR3 pins on top-level to soc_system
        # Names must exactly match DE10-Nano QSF pin names
        # ------------------------------------------------------------------
        sys.add_port('memory_mem_a',       'HPS_DDR3_ADDR',     dir='out',   width=15, parent_port=True)
        sys.add_port('memory_mem_ba',      'HPS_DDR3_BA',       dir='out',   width=3,  parent_port=True)
        sys.add_port('memory_mem_ck',      'HPS_DDR3_CK_P',     dir='out',               parent_port=True)
        sys.add_port('memory_mem_ck_n',    'HPS_DDR3_CK_N',     dir='out',               parent_port=True)
        sys.add_port('memory_mem_cke',     'HPS_DDR3_CKE',      dir='out',               parent_port=True)
        sys.add_port('memory_mem_cs_n',    'HPS_DDR3_CS_N',     dir='out',               parent_port=True)
        sys.add_port('memory_mem_ras_n',   'HPS_DDR3_RAS_N',    dir='out',               parent_port=True)
        sys.add_port('memory_mem_cas_n',   'HPS_DDR3_CAS_N',    dir='out',               parent_port=True)
        sys.add_port('memory_mem_we_n',    'HPS_DDR3_WE_N',     dir='out',               parent_port=True)
        sys.add_port('memory_mem_reset_n', 'HPS_DDR3_RESET_N',  dir='out',               parent_port=True)
        sys.add_port('memory_mem_dq',      'HPS_DDR3_DQ',       dir='inout', width=32,   parent_port=True)
        sys.add_port('memory_mem_dqs',     'HPS_DDR3_DQS_P',    dir='inout', width=4,    parent_port=True)
        sys.add_port('memory_mem_dqs_n',   'HPS_DDR3_DQS_N',    dir='inout', width=4,    parent_port=True)
        sys.add_port('memory_mem_odt',     'HPS_DDR3_ODT',      dir='out',               parent_port=True)
        sys.add_port('memory_mem_dm',      'HPS_DDR3_DM',       dir='out',   width=4,    parent_port=True)
        sys.add_port('memory_oct_rzqin',   'HPS_DDR3_RZQ',      dir='in',                parent_port=True)

        print('Made it to the end')
    def gen_children(self):
        return []
        # Add exactly one system block named 'sys' so memory_map['sys'] exists
        #return [
        #    YellowBlock.make_block({
        #        'fullpath': self.fullpath,
        #        'tag': 'xps:sys_block_intel',
        #        'name': 'sys',        # <-- important
        #        'board_id': '167',
        #        'rev_maj': '1',
        #        'rev_min': '0',
        #        'rev_rcs': '0',
        #    }, self.platform)
        #]

    def gen_constraints(self):
        cons = []
        # The auto-top uses fpga_clk1_50 for sys/axil clocks; give it a pin and a period.
        cons.append(ClockConstraint('FPGA_CLK1_50', 'sys_clk', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        #cons.append(ClockConstraint('FPGA_CLK1_50', 'sys_clk', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        #cons.append(PortConstraint('fpga_clk1_50', 'FPGA_CLK1_50'))
        return cons

    def gen_tcl_cmds(self):
        return {'init': [], 'create_bd': [], 'pre_synth': [], 'post_synth': [], 'post_bitgen': []}