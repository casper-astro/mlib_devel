from .yellow_block import YellowBlock
from .yellow_block_typecodes import *
from verilog import VerilogModule
from memory import Register
from constraints import PortConstraint, ClockConstraint, RawConstraint

class rfdc_V0_4(YellowBlock):
	def initialize(self):
		'''
		This function is called by YellowBlocks __init__ method.
		We could override __init__ here, but this seems a little
		bit more user friendly.
		'''
		#self.typecode = TYPECODE_RFDC
		self.typecode = TYPECODE_SWREG
		self.platform_support = 'zcu111'
		self.add_source('rfdc_V0_4/ADC1_R2R_2048.xci')
		self.add_source('rfdc_V0_4/ADC2_R2R_2048.xci')
		self.add_source('rfdc_V0_4/ADC4_R2R_2048.xci')
		self.add_source('rfdc_V0_4/ADC8_R2R_2048.xci')
		self.add_source('rfdc_V0_4/ADC1_R2R_4096.xci')
		self.add_source('rfdc_V0_4/ADC2_R2R_4096.xci')
		self.add_source('rfdc_V0_4/ADC4_R2R_4096.xci')
		self.add_source('rfdc_V0_4/ADC8_R2R_4096.xci')
		self.add_source('rfdc_V0_4/ADC8_R2R_MTS_2048.xci')
		self.add_source('rfdc_V0_4/ADC8_R2R_MTS_4096.xci')
		self.add_source('rfdc_V0_4/mts_sysref_sync.v')
		self.nbytes = 0x4
		self.memory_map = [ Register('IP_Ver_Info',   mode='r',  offset=0, default_val=0) ]

	def modify_top(self,top):
		if self.platform.mmbus_architecture == 'AXI4-Lite':
			#The register space for rfdc core is 0x3ffff, but we only implement the first register here.
			top.add_rfdc_interface(regname=self.unique_name, mode='r', nbytes=self.nbytes, memory_map=self.memory_map, typecode=self.typecode)
			for dev in top.rfdc_devices:
				if dev.regname == self.unique_name:
					dev.base_addr = self.platform.mmbus_rfdc_base_address
			# Inst a module that sits on clock crossing boundary
			top.add_signal(name=self.fullname + '_adc0_dout',width=128)
			#top.add_signal(name='user_rst', width=1)
			top.assign_signal('user_rst','sys_clk_rst')
			#if it's mts mode,we need a another mode for user_sysref port on rfdc core
			if(self.mts_mode == 'MTS'):
				module = 'mts_sysref_sync'
				inst = top.get_instance(entity=module, name=self.fullname+'sysref')
				#pl_sysref_p/n are used for mts
				inst.add_port('pl_sysref_p',signal='pl_sysref_p',dir='in',width=1,parent_port=True)
				inst.add_port('pl_sysref_n',signal='pl_sysref_n',dir='in',width=1,parent_port=True)
				inst.add_port('pl_clk',		signal='user_clk')
				inst.add_port('sysref_adc',	signal='sysref_adc')
			if(self.adc_sample_rate == 2048 and self.mts_mode == 'Non-MTS'):
				if(self.sys_config=='1 ADC CORE'):
					module = 'ADC1_R2R_2048'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n',     	signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p',     	signal='adc0_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('irq',signal='irq')
					#adc data port
					inst.add_port('m00_axis_tdata', 	signal=self.fullname+'_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready',   	signal='1', width=1							, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname+'_adc0_sync', width=1	, parent_sig=True)
					inst.add_port('m0_axis_aclk',      	signal='user_clk')
					inst.add_port('m0_axis_aresetn',    signal='~sys_clk_rst'						, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'					, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'					, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'					, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   		signal='sysref_in_n')
					inst.add_port('sysref_in_p',   		signal='sysref_in_p')
					inst.add_port('vin0_01_n',     		signal='vin0_01_n')
					inst.add_port('vin0_01_p',     		signal='vin0_01_p')
				elif(self.sys_config == '2 ADC CORES'):
					module = 'ADC2_R2R_2048'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid', 	signal=self.fullname+'_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
				elif(self.sys_config == '4 ADC CORES'):
					module = 'ADC4_R2R_2048'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname+'_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname+'_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'                 , parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
				elif(self.sys_config == '8 ADC CORES'):
					module = 'ADC8_R2R_2048'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('adc2_clk_n', signal='adc2_clk_clk_n')
					inst.add_port('adc2_clk_p', signal='adc2_clk_clk_p')
					inst.add_port('adc3_clk_n', signal='adc3_clk_clk_n')
					inst.add_port('adc3_clk_p', signal='adc3_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc2', signal=self.fullname + '_adc2_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc3', signal=self.fullname + '_adc3_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', 	signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname + '_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', 	signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname + '_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc4
					inst.add_port('m20_axis_tdata', 	signal=self.fullname + '_adc4_dout', width=128, parent_sig=True)
					inst.add_port('m20_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m20_axis_tvalid',   	signal=self.fullname + '_adc4_sync', wdth=1	, parent_sig=True)
					#adc5
					inst.add_port('m22_axis_tdata', 	signal=self.fullname + '_adc5_dout', width=128, parent_sig=True)
					inst.add_port('m22_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m22_axis_tvalid ', 	signal=self.fullname + '_adc5_sync', wdth=1, parent_sig=True)
					#adc4/5 axis clk & rst
					inst.add_port('m2_axis_aclk', 		signal='user_clk')
					inst.add_port('m2_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc6
					inst.add_port('m30_axis_tdata', 	signal=self.fullname + '_adc6_dout', width=128, parent_sig=True)
					inst.add_port('m30_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m30_axis_tvalid',   	signal=self.fullname + '_adc6_sync', wdth=1	, parent_sig=True)
					#adc7
					inst.add_port('m32_axis_tdata', 	signal=self.fullname + '_adc7_dout', width=128, parent_sig=True)
					inst.add_port('m32_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m32_axis_tvalid ', 	signal=self.fullname + '_adc7_sync', wdth=1, parent_sig=True)
					#adc6/7 axis clk & rst
					inst.add_port('m3_axis_aclk', 		signal='user_clk')
					inst.add_port('m3_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',			signal='axil_clk'				,	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
				#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
					inst.add_port('vin2_01_n',     	signal='vin2_01_n')
					inst.add_port('vin2_01_p',     	signal='vin2_01_p')
					inst.add_port('vin2_23_n', 		signal='vin2_23_n')
					inst.add_port('vin2_23_p', 		signal='vin2_23_p')
					inst.add_port('vin3_01_n',     	signal='vin3_01_n')
					inst.add_port('vin3_01_p',     	signal='vin3_01_p')
					inst.add_port('vin3_23_n', 		signal='vin3_23_n')
					inst.add_port('vin3_23_p', 		signal='vin3_23_p')
				else:
					pass
			elif(self.adc_sample_rate==4096 and self.mts_mode == 'Non-MTS'):
				if(self.sys_config=='1 ADC CORE'):
					module = 'ADC1_R2R_4096'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n',     	signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p',     	signal='adc0_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('irq',signal='irq')
					#adc data port
					inst.add_port('m00_axis_tdata', 	signal=self.fullname+'_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready',   	signal='1', width=1							, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname+'_adc0_sync', width=1	, parent_sig=True)
					inst.add_port('m0_axis_aclk',      	signal='user_clk')
					inst.add_port('m0_axis_aresetn',    signal='~sys_clk_rst'						, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'					, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'					, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'					, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   		signal='sysref_in_n')
					inst.add_port('sysref_in_p',   		signal='sysref_in_p')
					inst.add_port('vin0_01_n',     		signal='vin0_01_n')
					inst.add_port('vin0_01_p',     		signal='vin0_01_p')
				elif(self.sys_config == '2 ADC CORES'):
					module = 'ADC2_R2R_4096'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid', 	signal=self.fullname+'_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'				, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
				elif(self.sys_config == '4 ADC CORES'):
					module = 'ADC4_R2R_4096'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname+'_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname+'_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',       	signal='axil_clk'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'                 , parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
					#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
				elif(self.sys_config == '8 ADC CORES'):
					module = 'ADC8_R2R_4096'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('adc2_clk_n', signal='adc2_clk_clk_n')
					inst.add_port('adc2_clk_p', signal='adc2_clk_clk_p')
					inst.add_port('adc3_clk_n', signal='adc3_clk_clk_n')
					inst.add_port('adc3_clk_p', signal='adc3_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc2', signal=self.fullname + '_adc2_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc3', signal=self.fullname + '_adc3_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', 	signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname + '_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', 	signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname + '_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc4
					inst.add_port('m20_axis_tdata', 	signal=self.fullname + '_adc4_dout', width=128, parent_sig=True)
					inst.add_port('m20_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m20_axis_tvalid',   	signal=self.fullname + '_adc4_sync', wdth=1	, parent_sig=True)
					#adc5
					inst.add_port('m22_axis_tdata', 	signal=self.fullname + '_adc5_dout', width=128, parent_sig=True)
					inst.add_port('m22_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m22_axis_tvalid ', 	signal=self.fullname + '_adc5_sync', wdth=1, parent_sig=True)
					#adc4/5 axis clk & rst
					inst.add_port('m2_axis_aclk', 		signal='user_clk')
					inst.add_port('m2_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc6
					inst.add_port('m30_axis_tdata', 	signal=self.fullname + '_adc6_dout', width=128, parent_sig=True)
					inst.add_port('m30_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m30_axis_tvalid',   	signal=self.fullname + '_adc6_sync', wdth=1	, parent_sig=True)
					#adc7
					inst.add_port('m32_axis_tdata', 	signal=self.fullname + '_adc7_dout', width=128, parent_sig=True)
					inst.add_port('m32_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m32_axis_tvalid ', 	signal=self.fullname + '_adc7_sync', wdth=1, parent_sig=True)
					#adc6/7 axis clk & rst
					inst.add_port('m3_axis_aclk', 		signal='user_clk')
					inst.add_port('m3_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',			signal='axil_clk'				,	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
				#analog inputs
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
					inst.add_port('vin2_01_n',     	signal='vin2_01_n')
					inst.add_port('vin2_01_p',     	signal='vin2_01_p')
					inst.add_port('vin2_23_n', 		signal='vin2_23_n')
					inst.add_port('vin2_23_p', 		signal='vin2_23_p')
					inst.add_port('vin3_01_n',     	signal='vin3_01_n')
					inst.add_port('vin3_01_p',     	signal='vin3_01_p')
					inst.add_port('vin3_23_n', 		signal='vin3_23_n')
					inst.add_port('vin3_23_p', 		signal='vin3_23_p')
				else:
					pass
			elif(self.adc_sample_rate == 2048 and self.mts_mode == 'MTS'):
				if(self.sys_config == '1 ADC CORE'):
					pass #ToDo
				elif(self.sys_config == '2 ADC CORES'):
					pass#ToDo
				elif(self.sys_config == '4 ADC CORES'):
					pass#ToDo
				elif(self.sys_config == '8 ADC CORES'):
					module = 'ADC8_R2R_MTS_2048'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('adc2_clk_n', signal='adc2_clk_clk_n')
					inst.add_port('adc2_clk_p', signal='adc2_clk_clk_p')
					inst.add_port('adc3_clk_n', signal='adc3_clk_clk_n')
					inst.add_port('adc3_clk_p', signal='adc3_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc2', signal=self.fullname + '_adc2_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc3', signal=self.fullname + '_adc3_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', 	signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname + '_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', 	signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname + '_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc4
					inst.add_port('m20_axis_tdata', 	signal=self.fullname + '_adc4_dout', width=128, parent_sig=True)
					inst.add_port('m20_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m20_axis_tvalid',   	signal=self.fullname + '_adc4_sync', wdth=1	, parent_sig=True)
					#adc5
					inst.add_port('m22_axis_tdata', 	signal=self.fullname + '_adc5_dout', width=128, parent_sig=True)
					inst.add_port('m22_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m22_axis_tvalid ', 	signal=self.fullname + '_adc5_sync', wdth=1, parent_sig=True)
					#adc4/5 axis clk & rst
					inst.add_port('m2_axis_aclk', 		signal='user_clk')
					inst.add_port('m2_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc6
					inst.add_port('m30_axis_tdata', 	signal=self.fullname + '_adc6_dout', width=128, parent_sig=True)
					inst.add_port('m30_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m30_axis_tvalid',   	signal=self.fullname + '_adc6_sync', wdth=1	, parent_sig=True)
					#adc7
					inst.add_port('m32_axis_tdata', 	signal=self.fullname + '_adc7_dout', width=128, parent_sig=True)
					inst.add_port('m32_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m32_axis_tvalid ', 	signal=self.fullname + '_adc7_sync', wdth=1, parent_sig=True)
					#adc6/7 axis clk & rst
					inst.add_port('m3_axis_aclk', 		signal='user_clk')
					inst.add_port('m3_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',			signal='axil_clk'				,	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
				#analog inputs
					inst.add_port('user_sysref_adc',   	signal='sysref_adc')
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
					inst.add_port('vin2_01_n',     	signal='vin2_01_n')
					inst.add_port('vin2_01_p',     	signal='vin2_01_p')
					inst.add_port('vin2_23_n', 		signal='vin2_23_n')
					inst.add_port('vin2_23_p', 		signal='vin2_23_p')
					inst.add_port('vin3_01_n',     	signal='vin3_01_n')
					inst.add_port('vin3_01_p',     	signal='vin3_01_p')
					inst.add_port('vin3_23_n', 		signal='vin3_23_n')
					inst.add_port('vin3_23_p', 		signal='vin3_23_p')
			elif(self.adc_sample_rate == 4096 and self.mts_mode == 'MTS'):
				if(self.sys_config == '1 ADC CORE'):
					pass #ToDo
				elif(self.sys_config == '2 ADC CORES'):
					pass#ToDo
				elif(self.sys_config == '4 ADC CORES'):
					pass#ToDo
				elif(self.sys_config == '8 ADC CORES'):
					module = 'ADC8_R2R_MTS_4096'
					inst = top.get_instance(entity=module, name=self.fullname)
					inst.add_port('adc0_clk_n', signal='adc0_clk_clk_n')
					inst.add_port('adc0_clk_p', signal='adc0_clk_clk_p')
					inst.add_port('adc1_clk_n', signal='adc1_clk_clk_n')
					inst.add_port('adc1_clk_p', signal='adc1_clk_clk_p')
					inst.add_port('adc2_clk_n', signal='adc2_clk_clk_n')
					inst.add_port('adc2_clk_p', signal='adc2_clk_clk_p')
					inst.add_port('adc3_clk_n', signal='adc3_clk_clk_n')
					inst.add_port('adc3_clk_p', signal='adc3_clk_clk_p')
					inst.add_port('clk_adc0', signal=self.fullname + '_adc0_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc1', signal=self.fullname + '_adc1_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc2', signal=self.fullname + '_adc2_clk', width=1, parent_sig=True)
					inst.add_port('clk_adc3', signal=self.fullname + '_adc3_clk', width=1, parent_sig=True)
					inst.add_port('irq', signal='irq')
					#adc data port
					#adc0
					inst.add_port('m00_axis_tdata', 	signal=self.fullname + '_adc0_dout', width=128, parent_sig=True)
					inst.add_port('m00_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m00_axis_tvalid',   	signal=self.fullname + '_adc0_sync', wdth=1	, parent_sig=True)
					#adc1
					inst.add_port('m02_axis_tdata', 	signal=self.fullname + '_adc1_dout', width=128, parent_sig=True)
					inst.add_port('m02_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m02_axis_tvalid ', 	signal=self.fullname + '_adc1_sync', wdth=1, parent_sig=True)
					#adc0/1 axis clk & rst
					inst.add_port('m0_axis_aclk', 		signal='user_clk')
					inst.add_port('m0_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc2
					inst.add_port('m10_axis_tdata', 	signal=self.fullname + '_adc2_dout', width=128, parent_sig=True)
					inst.add_port('m10_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m10_axis_tvalid',   	signal=self.fullname + '_adc2_sync', wdth=1	, parent_sig=True)
					#adc3
					inst.add_port('m12_axis_tdata', 	signal=self.fullname + '_adc3_dout', width=128, parent_sig=True)
					inst.add_port('m12_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m12_axis_tvalid ', 	signal=self.fullname + '_adc3_sync', wdth=1, parent_sig=True)
					#adc2/3 axis clk & rst
					inst.add_port('m1_axis_aclk', 		signal='user_clk')
					inst.add_port('m1_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc4
					inst.add_port('m20_axis_tdata', 	signal=self.fullname + '_adc4_dout', width=128, parent_sig=True)
					inst.add_port('m20_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m20_axis_tvalid',   	signal=self.fullname + '_adc4_sync', wdth=1	, parent_sig=True)
					#adc5
					inst.add_port('m22_axis_tdata', 	signal=self.fullname + '_adc5_dout', width=128, parent_sig=True)
					inst.add_port('m22_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m22_axis_tvalid ', 	signal=self.fullname + '_adc5_sync', wdth=1, parent_sig=True)
					#adc4/5 axis clk & rst
					inst.add_port('m2_axis_aclk', 		signal='user_clk')
					inst.add_port('m2_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#adc6
					inst.add_port('m30_axis_tdata', 	signal=self.fullname + '_adc6_dout', width=128, parent_sig=True)
					inst.add_port('m30_axis_tready', 	signal='1', width=1						, parent_sig=True)
					inst.add_port('m30_axis_tvalid',   	signal=self.fullname + '_adc6_sync', wdth=1	, parent_sig=True)
					#adc7
					inst.add_port('m32_axis_tdata', 	signal=self.fullname + '_adc7_dout', width=128, parent_sig=True)
					inst.add_port('m32_axis_tready', 	signal='1', width=1					, parent_sig=True)
					inst.add_port('m32_axis_tvalid ', 	signal=self.fullname + '_adc7_sync', wdth=1, parent_sig=True)
					#adc6/7 axis clk & rst
					inst.add_port('m3_axis_aclk', 		signal='user_clk')
					inst.add_port('m3_axis_aresetn ', 	signal='~sys_clk_rst'					, parent_sig=False)
					#axi4-lite interface
					inst.add_port('s_axi_aclk',			signal='axil_clk'				,	width= 1, parent_sig=False)
					inst.add_port('s_axi_aresetn',      signal='axil_rst_n'		   		, 	width= 1, parent_sig=False)
					inst.add_port('s_axi_araddr',      	signal='M_AXI_RFDC_araddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_arready',     	signal='M_AXI_RFDC_arready'					, parent_sig=False)
					inst.add_port('s_axi_arvalid',     	signal='M_AXI_RFDC_arvalid'					, parent_sig=False)
					inst.add_port('s_axi_awaddr',      	signal='M_AXI_RFDC_awaddr[17:0]', 	width=18, parent_sig=False)
					inst.add_port('s_axi_awready',     	signal='M_AXI_RFDC_awready'					, parent_sig=False)
					inst.add_port('s_axi_awvalid',     	signal='M_AXI_RFDC_awvalid'  				, parent_sig=False)
					inst.add_port('s_axi_bready',      	signal='M_AXI_RFDC_bready'  				, parent_sig=False)
					inst.add_port('s_axi_bresp',       	signal='M_AXI_RFDC_bresp'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_bvalid',      	signal='M_AXI_RFDC_bvalid'					, parent_sig=False)
					inst.add_port('s_axi_rdata',       	signal='M_AXI_RFDC_rdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_rready',      	signal='M_AXI_RFDC_rready'					, parent_sig=False)
					inst.add_port('s_axi_rresp',       	signal='M_AXI_RFDC_rresp'		,	width= 2, parent_sig=False)
					inst.add_port('s_axi_rvalid',      	signal='M_AXI_RFDC_rvalid'					, parent_sig=False)
					inst.add_port('s_axi_wdata',       	signal='M_AXI_RFDC_wdata'		, 	width=32, parent_sig=False)
					inst.add_port('s_axi_wready',      	signal='M_AXI_RFDC_wready'  				, parent_sig=False)
					inst.add_port('s_axi_wstrb',       	signal='M_AXI_RFDC_wstrb'		, 	width= 2, parent_sig=False)
					inst.add_port('s_axi_wvalid',      	signal='M_AXI_RFDC_wvalid'					, parent_sig=False)
				#analog inputs
					inst.add_port('user_sysref_adc',   	signal='sysref_adc')
					inst.add_port('sysref_in_n',   	signal='sysref_in_n')
					inst.add_port('sysref_in_p',   	signal='sysref_in_p')
					inst.add_port('vin0_01_n',     	signal='vin0_01_n')
					inst.add_port('vin0_01_p',     	signal='vin0_01_p')
					inst.add_port('vin0_23_n', 		signal='vin0_23_n')
					inst.add_port('vin0_23_p', 		signal='vin0_23_p')
					inst.add_port('vin1_01_n',     	signal='vin1_01_n')
					inst.add_port('vin1_01_p',     	signal='vin1_01_p')
					inst.add_port('vin1_23_n', 		signal='vin1_23_n')
					inst.add_port('vin1_23_p', 		signal='vin1_23_p')
					inst.add_port('vin2_01_n',     	signal='vin2_01_n')
					inst.add_port('vin2_01_p',     	signal='vin2_01_p')
					inst.add_port('vin2_23_n', 		signal='vin2_23_n')
					inst.add_port('vin2_23_p', 		signal='vin2_23_p')
					inst.add_port('vin3_01_n',     	signal='vin3_01_n')
					inst.add_port('vin3_01_p',     	signal='vin3_01_p')
					inst.add_port('vin3_23_n', 		signal='vin3_23_n')
					inst.add_port('vin3_23_p', 		signal='vin3_23_p')
			else:
				pass
		else:
			pass

	def gen_constraints(self):
		const = []
		const +=[PortConstraint('pl_sysref_p', 'pl_sysref_p')]
		const +=[PortConstraint('pl_sysref_n', 'pl_sysref_n')]
		return const