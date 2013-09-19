%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function str = gen_ucf(blk_obj)
disp('DDR3 gen_ucf')

hw_sys 		= blk_obj.hw_sys;
parent_name 	= clear_name(get(blk_obj,'parent'));
blk_name 	= get(blk_obj,'simulink_name');
xsg_obj		= get(blk_obj,'xsg_obj');
str 		= gen_ucf(blk_obj.xps_block);
disp('DDR3 trying specific ucf generation')
switch hw_sys
    case 'ROACH2'
	str = [str,'CONFIG PROHIBIT = AK28,AN35;\n'];
	str = [str,'#######################################################################################\n'];
	str = [str,'###Place RSYNC OSERDES and IODELAY:                                                 ###\n'];
 	str = [str,'#######################################################################################\n\n'];
 	str = [str,'##Site: AK28 -- Bank 23\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_loop_col0.u_oserdes_rsync" LOC = "OLOGIC_X1Y143";\n'];
	str = [str, 'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_loop_col0.u_odelay_rsync" LOC = "IODELAY_X1Y143";\n\n'];
 	str = [str,'##Site: AN35 -- Bank 12\n'];
	str = [str,'#INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_loop_col2.u_oserdes_rsync" LOC = "OLOGIC_X0Y101";\n'];
	str = [str,'#INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_loop_col2.u_odelay_rsync" LOC = "IODELAY_X0Y101";\n\n'];
 	str = [str,'###############################################################################################\n'];
 	str = [str,'## The logic of this pin is used internally to drive a BUFIO for the byte group. Any clock\n'];
 	str = [str,'## capable pin in the same bank as the data byte group (DQS, DQ, DM if used) can be used for\n'];
 	str = [str,'## this pin. This pin cannot be used for other functions and should not be connected externally.\n'];
 	str = [str, '## If a different pin is chosen, the corresponding LOC constraint must also be changed.\n'];
 	str = [str, '################################################################################################\n\n'];
 	str = [str,'CONFIG PROHIBIT = AR34,AN28,AM26,BA30,AJ25,AT40,AL34,AR40;\n\n'];
 	str = [str,'#######################################################################################\n'];
 	str = [str,'###Place CPT OSERDES and IODELAY:                                                    ##\n'];
 	str = [str,'#######################################################################################\n\n'];
 	str= [str,'##Site: AR26 -- Bank 23\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[0].u_oserdes_cpt" LOC = "OLOGIC_X1Y137";\n'];
	str =[str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[0].u_odelay_cpt" LOC = "IODELAY_X1Y137";\n\n'];
 	str = [str,'##Site: AN28 -- Bank 22\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[1].u_oserdes_cpt" LOC = "OLOGIC_X1Y99";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[1].u_odelay_cpt" LOC = "IODELAY_X1Y99";\n\n'];
 	str = [str,'##Site: AM26 -- Bank 22\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[2].u_oserdes_cpt" LOC = "OLOGIC_X1Y101";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[2].u_odelay_cpt" LOC = "IODELAY_X1Y101";\n\n'];
 	str = [str,'##Site: BA30 -- Bank 22\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[3].u_oserdes_cpt" LOC = "OLOGIC_X1Y103";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[3].u_odelay_cpt" LOC = "IODELAY_X1Y103";\n\n'];
	str = [str,'##Site: AJ25 -- Bank 23\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[4].u_oserdes_cpt" LOC = "OLOGIC_X1Y141";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[4].u_odelay_cpt" LOC = "IODELAY_X1Y141";\n\n'];
 	str = [str,'##Site: AT40 -- Bank 13\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[5].u_oserdes_cpt" LOC = "OLOGIC_X0Y139";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[5].u_odelay_cpt" LOC = "IODELAY_X0Y139";\n\n'];
	str = [str,'##Site: AL34 -- Bank 13\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[6].u_oserdes_cpt" LOC = "OLOGIC_X0Y141";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[6].u_odelay_cpt" LOC = "IODELAY_X0Y141";\n\n'];
 	str = [str,'##Site: AR40 -- Bank 13\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[7].u_oserdes_cpt" LOC = "OLOGIC_X0Y143";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[7].u_odelay_cpt" LOC = "IODELAY_X0Y143";\n\n'];
 	str = [str,'##Site: AH24 -- Bank 23\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[8].u_oserdes_cpt" LOC = "OLOGIC_X1Y139";\n'];
	str = [str,'INST "ddr3_controller_inst/ddr3_controller_inst/u_memc_ui_top/u_mem_intfc/phy_top0/u_phy_read/u_phy_rdclk_gen/gen_ck_cpt[8].u_odelay_cpt" LOC = "IODELAY_X1Y139";\n\n'];
 	str = [str,'#######################################################################################\n'];
 	str = [str,'### MMCM_ADV CONSTRAINTS                                                             ##\n'];
 	str = [str,'#######################################################################################\n\n'];
	
	str = [str,'INST "ddr3_clk_inst/ddr3_clk_inst/u_mmcm_adv"      LOC = "MMCM_ADV_X0Y6";\n'];
        str = [str,'#ROACH infrastructure MMCM constraint for sys_clk\n'];
        str = [str,'INST "infrastructure_inst/infrastructure_inst/MMCM_BASE_sys_clk" LOC = "MMCM_ADV_X0Y7";\n'];
	
	str = [str,'#######################################################################################\n'];
 	str = [str,'### ASYNC TX/RX FIFO CONSTRAINTS                                                     ##\n'];
 	str = [str,'#######################################################################################\n\n'];
        str = [str,'##TIG constraints for de-referencing the rd and wr clks of the async fifos\n'];
	str = [str,'TIMESPEC "TS_XDOMAIN_ASYNC_FIFO_R2W" = FROM "ddr3_clk_inst_ddr3_clk_inst_clk_app_mmcm" TO "infrastructure_inst_infrastructure_inst_sys_clk_mmcm" TIG;\n'];
	str = [str,'TIMESPEC "TS_XDOMAIN_ASYNC_FIFO_W2R" = FROM "infrastructure_inst_infrastructure_inst_sys_clk_mmcm" TO "ddr3_clk_inst_ddr3_clk_inst_clk_app_mmcm" TIG;\n'];
end % switch hw_sys
