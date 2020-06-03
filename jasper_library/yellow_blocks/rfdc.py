from .yellow_block import YellowBlock
from .yellow_block_typecodes import *
from constraints import PortConstraint, ClockConstraint, RawConstraint
from memory import Register

class rfdc(YellowBlock):
  def initialize(self):
    # mcb: how does the type code really help us?
    self.typecode = TYPECODE_RFDC

    # mcb: the rfdc does produce some clocks, think we should expose them?
    #self.provides = ['adc0_clk', 'adc0_clk90', 'adc0_clk180', 'adc0_clk270']

    # mcb: this is how we get the vivado ip integrator core
    self.add_source('rfdc/usp_rf_data_converter.xci')

  def modify_top(self, top):
    rfdc_inst = top.get_instance(entity='usp_rf_data_converter', name='usp_rf_data_converter_inst')

    # mcb: noticed that from the sys_block YB that the mode is only 'r' with
    # some 'rw' registers. What am I missing here, why have to specify a
    # read-only interface but then am able to get a read/write register.
    top.add_axi4lite_interface(regname=self.unique_name, mode='r', nbytes=4, typecode=self.typecode)

    # mcb: manually adding ports for a simple real single port rfdc
    # implementation to work out bugs and test the yellow block creation process

    rfdc_inst.add_port('sysref_in_p', self.fullname+'_sysref_in_p', dir='in', parent_port=True)
    rfdc_inst.add_port('sysref_in_n', self.fullname+'_sysref_in_n', dir='in', parent_port=True)
    rfdc_inst.add_port('adc0_clk_p',  self.fullname+'_adc0_clk_p',  dir='in', parent_port=True)
    rfdc_inst.add_port('adc0_clk_n',  self.fullname+'_adc0_clk_n',  dir='in', parent_port=True)
    rfdc_inst.add_port('vin0_01_p',   self.fullname+'_vin0_01_p' ,  dir='in', parent_port=True)
    rfdc_inst.add_port('vin0_01_n',   self.fullname+'_vin0_01_n' ,  dir='in', parent_port=True)

    rfdc_inst.add_port('clk_adc0', self.fullname+'_clk_adc0', dir='out')
    rfdc_inst.add_port('irq', self.fullname+'_irq')

    # AXI4-lite slave interface
    rfdc_inst.add_port('s_axi_aclk',    'axil_clk')
    rfdc_inst.add_port('s_axi_aresetn', 'axil_rst_n')

    # some of the data/addr widths of 32 differ than what I had previous of 18. I think 18 came from
    # the rfdc core and 32 was choosen to match the ic block and I also think axi and vivado will
    # truncate down to the size
    rfdc_inst.add_port('s_axi_awaddr',  'M_AXI_awaddr', width=32)
    rfdc_inst.add_port('s_axi_awvalid', 'M_AXI_awvalid')
    rfdc_inst.add_port('s_axi_awready', 'M_AXI_awready')
    rfdc_inst.add_port('s_axi_wdata',   'M_AXI_wdata', width=32)
    rfdc_inst.add_port('s_axi_wstrb',   'M_AXI_wstrb', width=4)
    rfdc_inst.add_port('s_axi_wvalid',  'M_AXI_wvalid')
    rfdc_inst.add_port('s_axi_wready',  'M_AXI_wready')
    rfdc_inst.add_port('s_axi_bresp',   'M_AXI_bresp', width=2)
    rfdc_inst.add_port('s_axi_bvalid',  'M_AXI_bvalid')
    rfdc_inst.add_port('s_axi_bready',  'M_AXI_bready') 
    rfdc_inst.add_port('s_axi_araddr',  'M_AXI_araddr', width=32)
    rfdc_inst.add_port('s_axi_arvalid', 'M_AXI_arvalid')
    rfdc_inst.add_port('s_axi_arready', 'M_AXI_arready') 
    rfdc_inst.add_port('s_axi_rdata',   'M_AXI_rdata', width=32)
    rfdc_inst.add_port('s_axi_rresp',   'M_AXI_rresp', width=2)
    rfdc_inst.add_port('s_axi_rvalid',  'M_AXI_rvalid')
    rfdc_inst.add_port('s_axi_rready',  'M_AXI_rready')

    # mcb: the prot ports are present in the zcu111 block but are not on the axi4lite ic yb
    # do we need them?
    #inst.add_port('M_AXI_arprot', 'M_AXI_arprot', width=3)
    #inst.add_port('M_AXI_awprot', 'M_AXI_awprot', width=3)

    # AXI4-Stream interface
    rfdc_inst.add_port('m0_axis_aclk',    self.fullname+'_m0_axis_aclk')
    rfdc_inst.add_port('m0_axis_aresetn', self.fullname+'_m0_axis_aresetn')
    
    rfdc_inst.add_port('m00_axis_tdata',  self.fullname+'_m00_axis_tdata', width=128)
    rfdc_inst.add_port('m00_axis_tready', self.fullname+'_m00_axis_tready')
    rfdc_inst.add_port('m00_axis_tvalid', self.fullname+'_m00_axis_tvalid')


  def gen_constraints(self):
    cons = []
    # mcb: TODO need to add clock constraints
