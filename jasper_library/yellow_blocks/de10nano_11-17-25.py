from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, PortConstraint
import glob, os

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
        self.name = 'de10nano'
        self.fpga = '5CSEBA6U23I7'
        self.family = 'Cyclone V'
        self.manufacturer = 'intel'
        self.project_mode = True
        self.blkdesign = '{:s}_bd'.format(self.platform.conf['name'])
        self.backend_name = 'quartus'

        self.pl_clk_mhz = self.blk['pl_clk_rate']
        self.T_pl_clk_ns = 1.0/self.pl_clk_mhz*1000

        # what this platform offers to the rest of the design
        for p in ['sys_clk','sys_rst','axil_clk','axil_rst_n','fpga_clk1_50','fpga_clk2_50','fpga_clk3_50','pl_sysref']:
            self.provides.append(p)

        # sources: CDC helper
        self.add_source('utils/cdc_synchroniser.vhd')

        # HPS (Platform Designer) IP ? module names must match what you instantiate
        # Use your actual filenames/paths, these are based on what you shared.
        #self.add_source('de10nano/soc_system_hps_0.v')
        #self.add_source('de10nano/de10nano_hps_0_fpga_interfaces.sv')
        #self.add_source('de10nano/soc_system_hps_0_fpga_interfaces.sv')
        #self.add_source('de10nano/soc_system_hps_0_hps_io.v')

        # AXI4-Lite interconnect RTL so the instance created by the model can bind
        # (adjust these globs to your repo layout)
        hdl_root = getattr(self, 'hdl_root', os.getcwd())
        for patt in [
            'jasper_library/hdl_sources/axi4lite/*.v',
            'jasper_library/hdl_sources/axi4lite/*.sv',
            'jasper_library/hdl_sources/axi4lite_interconnect/*.v',
            'jasper_library/hdl_sources/axi4lite_interconnect/*.sv',
        ]:
            for f in glob.glob(os.path.join(hdl_root, patt)):
                rel = os.path.relpath(f, hdl_root)
                try:
                    self.add_source(rel)
                except Exception:
                    pass

    def modify_top(self, top):
        # --- Board clock (name must match the QSF/board pin) ---
        top.add_port('FPGA_CLK1_50', dir='in')


        # Alias for legacy/generated references that still use lowercase
        top.add_signal('fpga_clk1_50')
        top.add_raw_string("assign fpga_clk1_50 = FPGA_CLK1_50;")

        # Fabric clocks
        top.add_signal('sys_clk')
        #top.assign_signal('sys_clk', 'FPGA_CLK1_50')

        top.add_signal('axil_clk')
        top.assign_signal('axil_clk', 'fpga_clk1_50 ')

        # --- AXI-Lite master (internal nets only) ---
        axi = [
            ('M_AXI_awaddr', 32), ('M_AXI_awvalid', 1), ('M_AXI_awready', 1),
            ('M_AXI_wdata',  32), ('M_AXI_wstrb',  4), ('M_AXI_wvalid', 1), ('M_AXI_wready', 1),
            ('M_AXI_bresp',   2), ('M_AXI_bvalid', 1), ('M_AXI_bready', 1),
            ('M_AXI_araddr', 32), ('M_AXI_arvalid', 1), ('M_AXI_arready', 1),
            ('M_AXI_rdata',  32), ('M_AXI_rresp',  2), ('M_AXI_rvalid', 1), ('M_AXI_rready', 1),
        ]
        for name, w in axi:
            top.add_signal(name, width=w if w > 1 else None)

        # HPS uses 21-bit LW addresses; zero-extend to 32 for your fabric nets
        top.add_signal('hps_awaddr_21', width=21)
        top.add_signal('hps_araddr_21', width=21)
        top.add_raw_string("assign M_AXI_awaddr = {11'b0, hps_awaddr_21};")
        top.add_raw_string("assign M_AXI_araddr = {11'b0, hps_araddr_21};")

        # --- soc_system instance ---
        sys = top.get_instance('soc_system', 'soc_system')

        # Clocks / resets (names must exist in your soc_system.v)
        top.add_signal('h2f_rst_n')   # from HPS to fabric (active-high)
        top.add_signal('axil_rst')    # active-high fabric reset
        top.add_signal('axil_rst_n')
        top.add_signal('user_rst')


        sys.add_port('clk_clk', 'axil_clk', dir='in')
        sys.add_port('hps_0_h2f_reset_reset_n', 'h2f_rst_n', dir='out')
        top.add_raw_string("assign axil_rst_n = h2f_rst_n;\n")
        top.add_raw_string("assign axil_rst = ~h2f_rst_n;\n")
        top.add_raw_string("assign user_rst = ~h2f_rst_n;\n")

        # If your soc_system.v exposes an external reset (optional):
        # top.add_signal('soc_ext_reset_n')
        # top.add_raw_string("assign soc_ext_reset_n = 1'b1;")
        # sys.add_port('reset_reset_n', 'soc_ext_reset_n', dir='in')

        # --- Export DDR to top (exact names match Terasic QSF) ---
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


        # --- HPS LW AXI master (names must match *your* soc_system.v exactly) ---
        sys.add_port('hps_0_h2f_lw_axi_master_awaddr',  'hps_awaddr_21', dir='out', width=21)
        sys.add_port('hps_0_h2f_lw_axi_master_awvalid', 'M_AXI_awvalid', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_awready', 'M_AXI_awready', dir='in')

        sys.add_port('hps_0_h2f_lw_axi_master_wdata',   'M_AXI_wdata',   dir='out', width=32)
        sys.add_port('hps_0_h2f_lw_axi_master_wstrb',   'M_AXI_wstrb',   dir='out', width=4)
        sys.add_port('hps_0_h2f_lw_axi_master_wvalid',  'M_AXI_wvalid',  dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_wready',  'M_AXI_wready',  dir='in')

        sys.add_port('hps_0_h2f_lw_axi_master_bresp',   'M_AXI_bresp',   dir='in',  width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_bvalid',  'M_AXI_bvalid',  dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_bready',  'M_AXI_bready',  dir='out')

        sys.add_port('hps_0_h2f_lw_axi_master_araddr',  'hps_araddr_21', dir='out', width=21)
        sys.add_port('hps_0_h2f_lw_axi_master_arvalid', 'M_AXI_arvalid', dir='out')
        sys.add_port('hps_0_h2f_lw_axi_master_arready', 'M_AXI_arready', dir='in')

        sys.add_port('hps_0_h2f_lw_axi_master_rdata',   'M_AXI_rdata',   dir='in',  width=32)
        sys.add_port('hps_0_h2f_lw_axi_master_rresp',   'M_AXI_rresp',   dir='in',  width=2)
        sys.add_port('hps_0_h2f_lw_axi_master_rvalid',  'M_AXI_rvalid',  dir='in')
        sys.add_port('hps_0_h2f_lw_axi_master_rready',  'M_AXI_rready',  dir='out')


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