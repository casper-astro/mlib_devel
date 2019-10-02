from yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint
from memory import Register
import re
# import IPython
# import pdb

class adc_zcu111(YellowBlock):
    def initialize(self):
        # self.provides = ['adc0_clk','adc0_clk90', 'adc0_clk180', 'adc0_clk270']
        self.add_source('adc_zcu111/usp_rf_data_converter.xci')
        # make dict of tiles from adc_zcu111 mask parameters
        self.tiles = {}
        for key, value in self.blk.items():
            if key.startswith('tile_'):
                tile = re.search('tile_\d+', key)
                tile = tile.group(0)
                param = key.split(tile)[1].lstrip('_')
                if tile not in self.tiles.keys():
                    self.tiles[tile] = {}
                else:
                    self.tiles[tile][param] = value
        """
        See pages 20-24 of 
        https://www.xilinx.com/support/documentation/ip_documentation/usp_rf_data_converter/v2_1/pg269-rf-data-converter.pdf
        for explanation behind these dictionaries... need to make respective X, Y, Z, and ZZ numbers based on mask parameters,
        for respective HDL ports.
        """
        # make dict for corresponding tile indexes
        self.tile_idx = {
            "tile_224": 0,
            "tile_225": 1,
            "tile_226": 2,
            "tile_227": 3,
        }

    def modify_top(self,top):
        module = 'usp_rf_data_converter'
        inst = top.get_instance(entity=module, name=self.fullname)
        
        # Register map: see https://github.com/Xilinx/embeddedsw/blob/master/XilinxProcessorIPLib/drivers/rfdc/src/
        # also: https://www.xilinx.com/support/documentation/ip_documentation/usp_rf_data_converter/v2_1/pg269-rf-data-converter.pdf 
        self.memory_map = [
            Register('XRFDC_CLK_EN_OFFSET', mode='rw', offset=0, default_val=0),
            Register('XRFDC_ADC_DEBUG_RST_OFFSET', mode='rw', offset=0x4, default_val=0),
            Register('XRFDC_ADC_FABRIC_RATE_OFFSET', mode='rw', offset=0x8, default_val=0),
            Register('XRFDC_ADC_FABRIC_OFFSET', mode='rw', offset=0xc, default_val=0),
            Register('XRFDC_ADC_FABRIC_ISR_OFFSET', mode='rw', offset=0x10, default_val=0),
            Register('XRFDC_ADC_DECI_MODE_OFFSET', mode='rw', offset=0x044, default_val=0),
            Register('XRFDC_ADC_MXR_CFG0_OFFSET', mode='rw', offset=0x080, default_val=0),
            Register('XRFDC_ADC_MXR_CFG1_OFFSET', mode='rw', offset=0x084, default_val=0),
            Register('XRFDC_MXR_MODE_OFFSET', mode='rw', offset=0x088, default_val=0),
            Register('XRFDC_NCO_UPDT_OFFSET', mode='rw', offset=0x08C, default_val=0),
            Register('XRFDC_NCO_RST_OFFSET', mode='rw', offset=0x090, default_val=0),
            Register('XRFDC_ADC_NCO_FQWD_UPP_OFFSET', mode='rw', offset=0x094, default_val=0),
            Register('XRFDC_ADC_NCO_FQWD_M_FABRIC_IMR_OFFSET', mode='rw', offset=0x014, default_val=0),
            Register('XRFDC_ADC_FABRIC_DBG_OFFSET', mode='rw', offset=0x018, default_val=0),
            Register('XRFDC_ADC_UPDATE_DYN_OFFSET', mode='rw', offset=0x01C, default_val=0),
            Register('XRFDC_ADC_FIFO_LTNC_CRL_OFFSET', mode='rw', offset=0x020, default_val=0),
            Register('XRFDC_ADC_DEC_ISR_OFFSET', mode='rw', offset=0x030, default_val=0),
            Register('XRFDC_DAC_DATAPATH_OFFSET', mode='rw', offset=0x034, default_val=0),
            Register('XRFDC_ADC_DEC_IMR_OFFSET', mode='rw', offset=0x034, default_val=0),
            Register('XRFDC_DATPATH_ISR_OFFSET', mode='rw', offset=0x038, default_val=0),
            Register('XRFDC_DATPATH_IMR_OFFSET', mode='rw', offset=0x03C, default_val=0),
            Register('XRFDC_ADC_DECI_CONFIG_OFFSET', mode='rw', offset=0x040, default_val=0),
            Register('XRFDC_ADCID_OFFSET', mode='rw', offset=0x098, default_val=0),
            Register('XRFDC_ADC_NCO_FQWD_LOW_OFFSET', mode='rw', offset=0x09C, default_val=0),
            Register('XRFDC_NCO_PHASE_UPP_OFFSET', mode='rw', offset=0x0A0, default_val=0),
            Register('XRFDC_NCO_PHASE_LOW_OFFSET', mode='rw', offset=0x0A4, default_val=0),
            Register('XRFDC_ADC_NCO_PHASE_MOD_OFFSET', mode='rw', offset=0x0A8, default_val=0),
            Register('XRFDC_QMC_UPDT_OFFSET', mode='rw', offset=0x0C8, default_val=0),
            Register('XRFDC_QMC_CFG_OFFSET', mode='rw', offset=0x0CC, default_val=0),
            Register('XRFDC_QMC_OFF_OFFSET', mode='rw', offset=0x0D0, default_val=0),
            Register('XRFDC_QMC_GAIN_OFFSET', mode='rw', offset=0x0D4, default_val=0),
            Register('XRFDC_QMC_PHASE_OFFSET', mode='rw', offset=0x0D8, default_val=0),
            Register('XRFDC_ADC_CRSE_DLY_UPDT_OFFSET', mode='rw', offset=0x0DC, default_val=0),
            Register('XRFDC_ADC_CRSE_DLY_CFG_OFFSET', mode='rw', offset=0x0E0, default_val=0),
            Register('XRFDC_ADC_DAT_SCAL_CFG_OFFSET', mode='rw', offset=0x0E4, default_val=0),
            Register('XRFDC_ADC_SWITCH_MATRX_OFFSET', mode='rw', offset=0x0E8, default_val=0),
            Register('XRFDC_ADC_TRSHD0_CFG_OFFSET', mode='rw', offset=0x0EC, default_val=0),
            Register('XRFDC_ADC_TRSHD0_AVG_UP_OFFSET', mode='rw', offset=0x0F0, default_val=0),
            Register('XRFDC_ADC_TRSHD0_AVG_LO_OFFSET', mode='rw', offset=0x0F4, default_val=0),
            Register('XRFDC_ADC_TRSHD0_UNDER_OFFSET', mode='rw', offset=0x0F8, default_val=0),
            Register('XRFDC_ADC_TRSHD0_OVER_OFFSET', mode='rw', offset=0x0FC, default_val=0),
            Register('XRFDC_ADC_TRSHD1_CFG_OFFSET', mode='rw', offset=0x100, default_val=0),
            Register('XRFDC_ADC_TRSHD1_AVG_UP_OFFSET', mode='rw', offset=0x104, default_val=0),
            Register('XRFDC_ADC_TRSHD1_AVG_LO_OFFSET', mode='rw', offset=0x108, default_val=0),
            Register('XRFDC_ADC_TRSHD1_UNDER_OFFSET', mode='rw', offset=0x10C, default_val=0),
            Register('XRFDC_ADC_TRSHD1_OVER_OFFSET', mode='rw', offset=0x110, default_val=0),
            Register('XRFDC_ADC_FEND_DAT_CRL_OFFSET', mode='rw', offset=0x140, default_val=0),
            Register('XRFDC_ADC_TI_DCB_CRL0_OFFSET', mode='rw', offset=0x144, default_val=0),
            Register('XRFDC_ADC_TI_DCB_CRL1_OFFSET', mode='rw', offset=0x148, default_val=0),
            Register('XRFDC_ADC_TI_DCB_CRL2_OFFSET', mode='rw', offset=0x14C, default_val=0),
            Register('XRFDC_ADC_TI_DCB_CRL3_OFFSET', mode='rw', offset=0x150, default_val=0),
            Register('XRFDC_ADC_TI_TISK_CRL0_OFFSET', mode='rw', offset=0x154, default_val=0),
            Register('XRFDC_DAC_MC_CFG0_OFFSET', mode='rw', offset=0x1C4, default_val=0),
            Register('XRFDC_ADC_TI_TISK_CRL1_OFFSET', mode='rw', offset=0x158, default_val=0),
            Register('XRFDC_ADC_TI_TISK_CRL2_OFFSET', mode='rw', offset=0x15C, default_val=0),
            Register('XRFDC_ADC_TI_TISK_CRL3_OFFSET', mode='rw', offset=0x160, default_val=0),
            Register('XRFDC_ADC_TI_TISK_CRL4_OFFSET', mode='rw', offset=0x164, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DAC0_OFFSET', mode='rw', offset=0x168, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DAC1_OFFSET', mode='rw', offset=0x16C, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DAC2_OFFSET', mode='rw', offset=0x170, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DAC3_OFFSET', mode='rw', offset=0x174, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DACP0_OFFSET', mode='rw', offset=0x178, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DACP1_OFFSET', mode='rw', offset=0x17C, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DACP2_OFFSET', mode='rw', offset=0x180, default_val=0),
            Register('XRFDC_ADC_TI_TISK_DACP3_OFFSET', mode='rw', offset=0x184, default_val=0),
            Register('XRFDC_ADC0_SUBDRP_ADDR_OFFSET', mode='rw', offset=0x198, default_val=0),
            Register('XRFDC_ADC0_SUBDRP_DAT_OFFSET', mode='rw', offset=0x19C, default_val=0),
            Register('XRFDC_ADC1_SUBDRP_ADDR_OFFSET', mode='rw', offset=0x1A0, default_val=0),
            Register('XRFDC_ADC1_SUBDRP_DAT_OFFSET', mode='rw', offset=0x1A4, default_val=0),
            Register('XRFDC_ADC2_SUBDRP_ADDR_OFFSET', mode='rw', offset=0x1A8, default_val=0),
            Register('XRFDC_ADC2_SUBDRP_DAT_OFFSET', mode='rw', offset=0x1AC, default_val=0),
            Register('XRFDC_ADC3_SUBDRP_ADDR_OFFSET', mode='rw', offset=0x1B0, default_val=0),
            Register('XRFDC_ADC3_SUBDRP_DAT_OFFSET', mode='rw', offset=0x1B4, default_val=0),
            Register('XRFDC_ADC_RX_MC_PWRDWN_OFFSET', mode='rw', offset=0x1C0, default_val=0),
            Register('XRFDC_ADC_DAC_MC_CFG0_OFFSET', mode='rw', offset=0x1C4, default_val=0),
            Register('XRFDC_ADC_DAC_MC_CFG1_OFFSET', mode='rw', offset=0x1C8, default_val=0),
            Register('XRFDC_ADC_DAC_MC_CFG2_OFFSET', mode='rw', offset=0x1CC, default_val=0),
            Register('XRFDC_ADC_RXPR_MC_CFG0_OFFSET', mode='rw', offset=0x1D0, default_val=0),
            Register('XRFDC_ADC_RXPR_MC_CFG1_OFFSET', mode='rw', offset=0x1D4, default_val=0),
        ]

        top.add_axi4lite_interface(regname=self.unique_name, mode='rw', nbytes=4, memory_map=self.memory_map, typecode=self.typecode)

        # External ports
        inst.add_port('sysref_in_p', self.fullname+'_sysref_in_p', dir='in', parent_port=True)
        inst.add_port('sysref_in_n', self.fullname+'_sysref_in_n', dir='in', parent_port=True)
        # iterate over tile dict
        for tile, param_dict in self.tiles.items():
            tile_num = self.tile_idx[tile]
            # check if either ADC on respective tile is enabled
            if param_dict['adc_0'] or param_dict['adc_1']:
                # Add ports relevant for respective tile
                inst.add_port('adc{}_clk_p'.format(tile_num), self.fullname+'_adc{}_clk_p'.format(tile_num), dir='in', parent_port=True)
                inst.add_port('adc{}_clk_n'.format(tile_num), self.fullname+'_adc{}_clk_n'.format(tile_num), dir='in', parent_port=True)
                inst.add_port('m{}_axis_aclk'.format(tile_num), self.fullname+'_m{}_axis_aclk'.format(tile_num), dir='in', parent_port=False)
                inst.add_port('m{}_axis_aresetn'.format(tile_num), self.fullname+'_m{}_axis_aresetn'.format(tile_num), dir='in', parent_port=False)
                inst.add_port('clk_adc{}'.format(tile_num), self.fullname+'_clk_adc{}'.format(tile_num), dir='out', parent_port=False)

            # only add these ports ADC0
            if param_dict['adc_0']:
                # lower ADC on tile, so ZZ is '01'
                adc = '01'
                inst.add_port('vin{}_{}_p'.format(tile_num, adc), self.fullname+'_vin{}_{}_p'.format(tile_num, adc), dir='in', parent_port=True)
                inst.add_port('vin{}_{}_n'.format(tile_num, adc), self.fullname+'_vin{}_{}_n'.format(tile_num, adc), dir='in', parent_port=True)
                inst.add_port('adc{}_{}_int_cal_freeze'.format(tile_num, adc), self.fullname+'_adc{}_{}_int_cal_freeze'.format(tile_num, adc), dir='in', parent_port=False)
                inst.add_port('adc{}_{}_cal_frozen'.format(tile_num, adc), self.fullname+'_adc{}_{}_cal_frozen'.format(tile_num, adc), dir='out', parent_port=False)
                # Add Master AXI4-Stream interfaces, 0 for real, 0,1 for I/Q
                if param_dict['adc0_digital_output'] == 'Real':
                    ddc_loc = [0]
                else:
                    ddc_loc = [0,1]

            # only add these ports ADC1
            if param_dict['adc_1']:
                # upper ADC on tile, so ZZ is '23'
                adc = '23'
                inst.add_port('vin{}_{}_p'.format(tile_num, adc), self.fullname+'_vin{}_{}_p'.format(tile_num, adc), dir='in', parent_port=True)
                inst.add_port('vin{}_{}_n'.format(tile_num, adc), self.fullname+'_vin{}_{}_n'.format(tile_num, adc), dir='in', parent_port=True)
                inst.add_port('adc{}_{}_int_cal_freeze'.format(tile_num, adc), self.fullname+'_adc{}_{}_int_cal_freeze'.format(tile_num, adc), dir='in', parent_port=False)
                inst.add_port('adc{}_{}_cal_frozen'.format(tile_num, adc), self.fullname+'_adc{}_{}_cal_frozen'.format(tile_num, adc), dir='out', parent_port=False)
                # Digital output data indexes: 2 for real, 2,3 for I/Q
                if param_dict['adc0_digital_output'] == 'Real':
                    ddc_loc = [2]
                else:
                    ddc_loc = [2,3]

            for ddc in ddc_loc:
                # Add Master AXI4-stream interfaces for each ADC, 1 for real or 2 for I/Q data
                inst.add_port('m{}{}_axis_tdata'.format(tile_num, ddc), self.fullname+'_m{}{}_axis_tdata'.format(tile_num, ddc), dir='out', parent_port=False)
                inst.add_port('m{}{}_axis_tvalid'.format(tile_num, ddc), self.fullname+'_m{}{}_axis_tdata'.format(tile_num, ddc), dir='out', parent_port=False)
                inst.add_port('m{}{}_axis_tready'.format(tile_num, ddc), self.fullname+'_m{}{}_axis_tdata'.format(tile_num, ddc), dir='in', parent_port=False)

        # AXI4-lite slave interface
        inst.add_port('s_axi_aclk', self.fullname+'s_axi_aclk', dir='in', parent_port=False)
        inst.add_port('s_axi_aresetn', self.fullname+'_s_axi_aresetn', dir='in', parent_port=False)
        inst.add_port('s_axi_awaddr', self.fullname+'_s_axi_awaddr', dir='in', parent_port=False, width=18)
        inst.add_port('s_axi_awvalid', self.fullname+'_s_axi_awvalid', dir='in', parent_port=False)
        inst.add_port('s_axi_awready', self.fullname+'_s_axi_awready', dir='out', parent_port=False)
        inst.add_port('s_axi_wdata', self.fullname+'_s_axi_wdata', dir='in', parent_port=False, width=32)
        inst.add_port('s_axi_wstrb', self.fullname+'_s_axi_wstrb', dir='in', parent_port=False, width=4)
        inst.add_port('s_axi_wvalid', self.fullname+'_s_axi_wvalid', dir='in', parent_port=False)
        inst.add_port('s_axi_wready', self.fullname+'_s_axi_wready', dir='out', parent_port=False)
        inst.add_port('s_axi_bresp', self.fullname+'_s_axi_bresp', dir='out', parent_port=False, width=2)
        inst.add_port('s_axi_bvalid', self.fullname+'_s_axi_bvalid', dir='out', parent_port=False)
        inst.add_port('s_axi_bready', self.fullname+'_s_axi_bready', dir='in', parent_port=False)
        inst.add_port('s_axi_araddr', self.fullname+'_s_axi_araddr', dir='in', parent_port=False, width=18)
        inst.add_port('s_axi_arvalid', self.fullname+'_s_axi_arvalid', dir='in', parent_port=False)
        inst.add_port('s_axi_arready', self.fullname+'_s_axi_arready', dir='out', parent_port=False)
        inst.add_port('s_axi_rdata', self.fullname+'_s_axi_rdata', dir='out', parent_port=False, width=32)
        inst.add_port('s_axi_rresp', self.fullname+'_s_axi_rresp', dir='out', parent_port=False, width=2)
        inst.add_port('s_axi_rvalid', self.fullname+'_s_axi_rvalid', dir='out', parent_port=False)
        inst.add_port('s_axi_rready', self.fullname+'_s_axi_rready', dir='in', parent_port=False)
        
        inst.add_port('user_sysref_adc', self.fullname+'_user_sysref_adc', dir='in', parent_port=False)
        inst.add_port('irq', self.fullname+'_irq', dir='out', parent_port=False)

    def gen_constraints(self):
        cons = []
        # need to add clock constraints
