from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint
import glob
import os

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

        self.provides.append('sys_clk')
        self.provides.append('sys_rst')

        self.provides.append('fpga_clk1_50')
        self.provides.append('fpga_clk2_50')
        self.provides.append('fpga_clk3_50')
        self.add_source('utils/cdc_synchroniser.vhd')
        self.add_source('de10nano/de10nano.v')
        self.add_source('de10nano/de10nano_hps_0_fpga_interfaces.sv')
        #self.add_source('de10nano/de10nano_hps_0_hps_io.v')
        #self.add_source('de10nano/de10nano_hps_0_hps_io_border.sv')
        #self.add_source('de10nano/hps_sdram.v')
        #self.add_source('de10nano/hps_sdram_pll.sv')
        #self.add_source('de10nano/hps_sdram_p0.sv')
        #source_dir = os.path.join(self.hdl_root, 'de10nano')
        #for file in os.listdir(source_dir):
        #    if file.endswith('.v') or file.endswith('.sv'):
        #        self.add_source(os.path.join('de10nano', file))

        # TODO: is a bug that `axi4lite_interconnect` does not make a `requires` on `axil_clk`.
        # Looking into this more: the `_drc` check on YB requires/provides is done in `gen_periph_objs` but the `axi4lite_interconnect`
        # is not done until later within `generate_hdl > _instantiate_periphs`, therefore, by-passing any checks done.
        #self.provides.append('axil_clk')    # from block design
        #self.provides.append('axil_rst_n')  # from block desgin

        # rfsocs use the requires/provides for to check for `sysref` and `pl_sysref` for MTS
        self.provides.append('pl_sysref') # rfsoc platform/infrastructure provides so rfdc can require

        #self.requires.append('M_AXI') # axi4lite interface from block design

    def modify_top(self, top):
        # Declare and connect de10nano module

        # Clock input and basic signals
        #top.add_port('oct_rzqin', dir='inout', width=0)  

        top.add_port('fpga_clk1_50', dir='in', width=0)

        # Declare internal signals
        #top.add_signal('axil_clk', width=1)
        #top.add_signal('axil_rst_n', width=1)
        top.add_signal('sys_clk', width = 0)
        top.add_signal('sys_rst')
        top.add_signal("axil_rst", width=1)
        top.add_signal('h2f_rst_n', width=1)

        #top.add_signal('user_clk', width = 1)

        # Assign fpga_clk1_50 to internal clocks
        top.assign_signal('axil_clk', 'fpga_clk1_50')
        top.assign_signal('sys_clk', 'fpga_clk1_50')  # for consistency
        #top.assign_signal('user_clk', 'fpga_clk1_50')
        top.assign_signal('axil_rst', 'sys_rst')
        top.assign_signal('user_rst', '1\'b0')
        top.assign_signal('sys_rst', "1'b0")
        top.assign_signal('h2f_rst_n', "1'b1")

        axi_names = [
            'awaddr', 'awvalid', 'awready',
            'wdata', 'wstrb', 'wvalid', 'wready',
            'bresp', 'bvalid', 'bready',
            'araddr', 'arvalid', 'arready',
            'rdata', 'rresp', 'rvalid', 'rready'
        ]

        for sig in axi_names:
            top.add_signal(f'M_AXI_{sig}', width=signal_width(sig))


        # Declare and tie off constant PROT signals
        top.add_signal('awprot_000', width=3)
        top.assign_signal('awprot_000', "3'b000")

        top.add_signal('arprot_000', width=3)
        top.assign_signal('arprot_000', "3'b000")

        top.add_raw_string("""
        de10nano #(
            .F2S_Width(1),
            .S2F_Width(0)
        ) de10nano_inst (
            .f2h_axi_clk(axil_clk),
            .f2h_AWVALID(M_AXI_awvalid),
            .f2h_AWREADY(M_AXI_awready),
            .h2f_lw_AWADDR(M_AXI_awaddr),
            .h2f_lw_AWPROT(awprot_000),
            .h2f_lw_WDATA(M_AXI_wdata),
            .h2f_lw_WSTRB(M_AXI_wstrb),
            .h2f_lw_WVALID(M_AXI_wvalid),
            .h2f_lw_WREADY(M_AXI_wready),
            .h2f_lw_BRESP(M_AXI_bresp),
            .h2f_lw_BVALID(M_AXI_bvalid),
            .h2f_lw_BREADY(M_AXI_bready),
            .h2f_lw_ARADDR(M_AXI_araddr),
            .h2f_lw_ARPROT(arprot_000),
            .h2f_lw_ARVALID(M_AXI_arvalid),
            .h2f_lw_ARREADY(M_AXI_arready),
            .h2f_lw_RDATA(M_AXI_rdata),
            .h2f_lw_RRESP(M_AXI_rresp),
            .h2f_lw_RVALID(M_AXI_rvalid),
            .h2f_lw_RREADY(M_AXI_rready),
            .h2f_rst_n(h2f_rst_n),
        );
        """)
   
    def gen_children(self):
        children = []

        # Add the sys_block ? this ensures sys_board_id shows up
        
        
        children.append(YellowBlock.make_block({
            'fullpath': self.fullpath,
            'tag': 'xps:sys_block_intel',
            'board_id': '167',  # or an actual board ID
            'rev_maj': '1',
            'rev_min': '0',
            'rev_rcs': '0'
        }, self.platform))
        

        
        #axi_buffer_blk = {
        #    'tag': 'xps:axi4lite_buffer',
        #    'name': 'axi_passthrough'
        #}
        #children.append(YellowBlock.make_block(axi_buffer_blk, self.platform))
        children.append(YellowBlock.make_block({'fullpath': self.fullpath, 'tag': 'xps:axi4lite_interconnect','name': 'axi_interconnect'}, self.platform))

        return children

    
    def gen_constraints(self):
        cons = []
        cons.append(ClockConstraint('fpga_clk1_50', 'sys_clk', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        cons.append(ClockConstraint('fpga_clk1_50', 'axil_clk', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        cons.append(PortConstraint('fpga_clk1_50', 'fpga_clk1_50'))
        #cons.append(PortConstraint('oct_rzqin', 'oct_rzqin'))
        #cons.append(PortConstraint('fpga_clk2_50', 'fpga_clk2_50'))
        #cons.append(PortConstraint('fpga_clk3_50', 'fpga_clk3_50'))
        
        return cons


def gen_tcl_cmds(self):
    tcl_cmds = {}
    
    '''
    tcl_cmds['init'] = []
    tcl_cmds['create_bd'] = []
    tcl_cmds['pre_synth'] = []

    # Example: set number of processors for Quartus
    total_cores = os.cpu_count()
    cpu_count = 1 if not(int(0.75*total_cores)) else int(0.75*total_cores) 
    
    tcl_cmds['pre_synth'] += [
        f'set_global_assignment -name NUM_PARALLEL_PROCESSORS {cpu_count}'
    ]

    # Example: pass Verilog defines
    tcl_cmds['pre_synth'] += [
        'set_global_assignment -name VERILOG_MACRO "HAS_REAL_AXI"',
        'set_global_assignment -name VERILOG_MACRO "MY_OTHER_MACRO=1"'
    ]

    # Optionally post-bitgen commands (not always relevant for Quartus, but structure is there)
    tcl_cmds['post_bitgen'] = []
    '''

    return tcl_cmds


