function [str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,opb_name)
opb_addr_end = opb_addr_start;

inst_name = clear_name(get(blk_obj,'simulink_name'));
xsg_obj   = get(blk_obj,'xsg_obj');

hw_qdr   = get(blk_obj,'hw_qdr');
hw_sys   = get(blk_obj,'hw_sys');
clk_src  = get(blk_obj,'clk_src'); 
clk_rate = get(blk_obj,'clk_rate'); 
use_sniffer = get(blk_obj,'use_sniffer'); 

data_width = get(blk_obj,'data_width');
addr_width= get(blk_obj,'addr_width');
bw_width= get(blk_obj,'bw_width');
qdr_latency = get(blk_obj, 'qdr_latency');

%some strings (like '[17:0]
data_vec = ['[',num2str(str2num(data_width)-1),':0]'];
addr_vec = ['[',num2str(str2num(addr_width)-1),':0]'];
bw_vec   = ['[',num2str(str2num(bw_width)-1),':0]'];
str = '';

% OPB addresses
switch hw_qdr
    case 'qdr0'
        controller_base_addr = '0x0003_0000';
        controller_high_addr = '0x0003_FFFF';
        ram_base_addr        = '0x0200_0000';
        ram_high_addr        = '0x027F_FFFF';
        sniff_base_addr      = '0x0007_0000';
        sniff_high_addr      = '0x0007_FFFF';
    case 'qdr1'                             
        controller_base_addr = '0x0004_0000';
        controller_high_addr = '0x0004_FFFF';
        ram_base_addr        = '0x0280_0000';
        ram_high_addr        = '0x02FF_FFFF';
        sniff_base_addr      = '0x0008_0000';
        sniff_high_addr      = '0x0008_FFFF';
    case 'qdr2'                             
        controller_base_addr = '0x0005_0000';
        controller_high_addr = '0x0005_FFFF';
        ram_base_addr        = '0x0300_0000';
        ram_high_addr        = '0x037F_FFFF';
        sniff_base_addr      = '0x0009_0000';
        sniff_high_addr      = '0x0009_FFFF';
    case 'qdr3'                             
        controller_base_addr = '0x0006_0000';
        controller_high_addr = '0x0006_00FF';
        ram_base_addr        = '0x0380_0000';
        ram_high_addr        = '0x03FF_FFFF';
        sniff_base_addr      = '0x000A_0000';
        sniff_high_addr      = '0x000A_FFFF';
end %switch hw_qdr

%%%%% QDR Controller Entry %%%%%

% pcore Instantiation
switch hw_sys
    case 'ROACH'
        str = [str, 'BEGIN qdr_controller\n'];
        
        str = [str, ' PARAMETER INSTANCE = ', hw_qdr,'_controller',    '\n'];
        str = [str, ' PARAMETER CLK_FREQ = ', sprintf('%d', clk_rate), '\n'];
        str = [str, ' PARAMETER HW_VER   = 1.00.a',                    '\n'];
        str = [str, ' PARAMETER DATA_WIDTH = ', data_width,            '\n'];
        str = [str, ' PARAMETER ADDR_WIDTH = ', addr_width,            '\n'];
        str = [str, ' PARAMETER BW_WIDTH   = ', bw_width,              '\n'];
        
        str = [str, ' PORT clk0    = ', clk_src,              '\n'];
        str = [str, ' PORT clk180  = ', clk_src, '180',       '\n'];
        str = [str, ' PORT clk270  = ', clk_src, '270',       '\n'];
        str = [str, ' PORT div_clk = dly_clk',                '\n'];
        str = [str, ' PORT idelay_rdy = idelay_rdy',          '\n'];
        str = [str, ' PORT reset   = ', inst_name, '_reset',  '\n'];
        
        str = [str, ' PORT qdr_k_n       = ', hw_qdr, '_k_n',       '\n'];
        str = [str, ' PORT qdr_k         = ', hw_qdr, '_k',         '\n'];
        str = [str, ' PORT qdr_d         = ', hw_qdr, '_d',         '\n'];
        str = [str, ' PORT qdr_bw_n      = ', hw_qdr, '_bw_n',      '\n'];
        str = [str, ' PORT qdr_sa        = ', hw_qdr, '_sa',        '\n'];
        str = [str, ' PORT qdr_w_n       = ', hw_qdr, '_w_n',       '\n'];
        str = [str, ' PORT qdr_r_n       = ', hw_qdr, '_r_n',       '\n'];
        str = [str, ' PORT qdr_q         = ', hw_qdr, '_q',         '\n'];
        str = [str, ' PORT qdr_cq_n      = ', hw_qdr, '_cq_n',      '\n'];
        str = [str, ' PORT qdr_cq        = ', hw_qdr, '_cq',        '\n'];
        str = [str, ' PORT qdr_qvld      = ', hw_qdr, '_qvld',      '\n'];
        str = [str, ' PORT qdr_dll_off_n = ', hw_qdr, '_dll_off_n', '\n'];
        
        str = [str, ' PORT phy_rdy  = ', inst_name, '_phy_ready ', '\n'];
        str = [str, ' PORT cal_fail = ', inst_name, '_cal_fail',   '\n'];
        
        str = [str, ' BUS_INTERFACE MQDR = ', inst_name,           '\n'];
        
        str = [str, 'END\n'];
        str = [str, '\n'];
        
        % QDR Controller Externals
        
        str = [str, 'PORT ', hw_qdr, '_k_n       = ', hw_qdr,'_k_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_k         = ', hw_qdr,'_k         , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_d         = ', hw_qdr,'_d         , DIR = O, VEC=', data_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_bw_n      = ', hw_qdr,'_bw_n      , DIR = O, VEC=', bw_vec,     '\n'];
        str = [str, 'PORT ', hw_qdr, '_sa        = ', hw_qdr,'_sa        , DIR = O, VEC=', addr_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_w_n       = ', hw_qdr,'_w_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_r_n       = ', hw_qdr,'_r_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_q         = ', hw_qdr,'_q         , DIR = I, VEC=', data_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_cq_n      = ', hw_qdr,'_cq_n      , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_cq        = ', hw_qdr,'_cq        , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_qvld      = ', hw_qdr,'_qvld      , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_dll_off_n = ', hw_qdr,'_dll_off_n , DIR = O',                   '\n'];

        %%%%% QDR Sniffer Entry %%%%%
        
        % pcore Instantiation
        str = [str, '\n'];
        str = [str, '\n'];
        str = [str, 'BEGIN opb_qdr_sniffer\n'];
        
        str = [str, ' PARAMETER INSTANCE   = ', hw_qdr,'_sniffer',      '\n'];
        str = [str, ' PARAMETER HW_VER     = 1.00.a',                   '\n'];
        str = [str, ' PARAMETER ENABLE     = ', use_sniffer,            '\n'];
        str = [str, ' PARAMETER QDR_DATA_WIDTH = ', data_width,         '\n'];
        str = [str, ' PARAMETER QDR_ADDR_WIDTH = ', addr_width,         '\n'];
        str = [str, ' PARAMETER QDR_BW_WIDTH   = ', bw_width,           '\n'];
        str = [str, ' PARAMETER QDR_LATENCY    = ', qdr_latency,        '\n'];
        str = [str, ' PARAMETER C_CONFIG_BASEADDR = ', sniff_base_addr, '\n'];
        str = [str, ' PARAMETER C_CONFIG_HIGHADDR = ', sniff_high_addr, '\n'];
        str = [str, ' PARAMETER C_BASEADDR = ', ram_base_addr,          '\n'];
        str = [str, ' PARAMETER C_HIGHADDR = ', ram_high_addr,          '\n'];
        
        str = [str, ' BUS_INTERFACE SQDR = ', inst_name, '\n'];
        str = [str, ' BUS_INTERFACE SOPB = opb0',        '\n'];
        str = [str, ' BUS_INTERFACE COPB = opb0',        '\n'];
        
        str = [str, ' PORT qdr_clk       = ', clk_src,         '\n'];
        str = [str, ' PORT OPB_Clk       = epb_clk',           '\n'];
        str = [str, ' PORT OPB_Clk_config= epb_clk',           '\n'];
        
        str = [str, ' PORT slave_addr    = ', inst_name, '_address',   '\n'];
        str = [str, ' PORT slave_wr_strb = ', inst_name, '_wr_en',     '\n'];
        str = [str, ' PORT slave_wr_data = ', inst_name, '_data_in',   '\n'];
        str = [str, ' PORT slave_wr_be   = ', inst_name, '_be',        '\n'];
        str = [str, ' PORT slave_rd_strb = ', inst_name, '_rd_en',     '\n'];
        str = [str, ' PORT slave_rd_data = ', inst_name, '_data_out',  '\n'];
        str = [str, ' PORT slave_ack     = ', inst_name, '_ack',       '\n'];
        
        str = [str, ' PORT phy_rdy       = ', inst_name, '_phy_ready', '\n'];
        str = [str, ' PORT cal_fail      = ', inst_name, '_cal_fail',  '\n'];
        str = [str, ' PORT qdr_reset     = ', inst_name, '_reset',     '\n'];
        
        str = [str, 'END\n'];
        str = [str, '\n'];
        str = [str, '\n'];
        
    case 'ROACH2'
        str = [str, 'BEGIN qdr_controller\n'];
        
        str = [str, ' PARAMETER INSTANCE = ', hw_qdr,'_controller',    '\n'];
        str = [str, ' PARAMETER CLK_FREQ = ', sprintf('%d', clk_rate), '\n'];
        str = [str, ' PARAMETER HW_VER   = 1.00.a',                    '\n'];
        str = [str, ' PARAMETER DATA_WIDTH = ', data_width,            '\n'];
        str = [str, ' PARAMETER ADDR_WIDTH = ', addr_width,            '\n'];
        str = [str, ' PARAMETER BW_WIDTH   = ', bw_width,              '\n'];
        
        str = [str, ' PORT clk0    = ', clk_src,              '\n'];
        str = [str, ' PORT clk180  = ', clk_src, '180',       '\n'];
        str = [str, ' PORT clk270  = ', clk_src, '270',       '\n'];
        str = [str, ' PORT div_clk = sys_clk2x',              '\n'];
        str = [str, ' PORT idelay_rdy = idelay_rdy',          '\n'];
        str = [str, ' PORT reset   = ', inst_name, '_reset',  '\n'];
        
        str = [str, ' PORT qdr_k_n       = ', hw_qdr, '_k_n',       '\n'];
        str = [str, ' PORT qdr_k         = ', hw_qdr, '_k',         '\n'];
        str = [str, ' PORT qdr_d         = ', hw_qdr, '_d',         '\n'];
        str = [str, ' PORT qdr_bw_n      = ', hw_qdr, '_bw_n',      '\n'];
        str = [str, ' PORT qdr_sa        = ', hw_qdr, '_sa',        '\n'];
        str = [str, ' PORT qdr_w_n       = ', hw_qdr, '_w_n',       '\n'];
        str = [str, ' PORT qdr_r_n       = ', hw_qdr, '_r_n',       '\n'];
        str = [str, ' PORT qdr_q         = ', hw_qdr, '_q',         '\n'];
        str = [str, ' PORT qdr_cq_n      = ', hw_qdr, '_cq_n',      '\n'];
        str = [str, ' PORT qdr_cq        = ', hw_qdr, '_cq',        '\n'];
        str = [str, ' PORT qdr_qvld      = ', hw_qdr, '_qvld',      '\n'];
        str = [str, ' PORT qdr_dll_off_n = ', hw_qdr, '_dll_off_n', '\n'];
        
        str = [str, ' PORT bit_align_state_prb  = ', hw_qdr, '_bit_align_state_prb ', '\n'];
        str = [str, ' PORT bit_train_state_prb  = ', hw_qdr, '_bit_train_state_prb ', '\n'];
        str = [str, ' PORT bit_train_error_prb  = ', hw_qdr, '_bit_train_error_prb ', '\n'];
        str = [str, ' PORT phy_state_prb  = ',       hw_qdr, '_phy_state_prb ',       '\n'];

        str = [str, ' PORT phy_rdy  = ', inst_name, '_phy_ready ', '\n'];
        str = [str, ' PORT cal_fail = ', inst_name, '_cal_fail',   '\n'];
        
        str = [str, ' BUS_INTERFACE MQDR = ', inst_name,           '\n'];
        
        str = [str, 'END\n'];
        str = [str, '\n'];
        
        % QDR Controller Externals
        
        str = [str, 'PORT ', hw_qdr, '_k_n       = ', hw_qdr,'_k_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_k         = ', hw_qdr,'_k         , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_d         = ', hw_qdr,'_d         , DIR = O, VEC=', data_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_bw_n      = ', hw_qdr,'_bw_n      , DIR = O, VEC=', bw_vec,     '\n'];
        str = [str, 'PORT ', hw_qdr, '_sa        = ', hw_qdr,'_sa        , DIR = O, VEC=', addr_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_w_n       = ', hw_qdr,'_w_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_r_n       = ', hw_qdr,'_r_n       , DIR = O',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_q         = ', hw_qdr,'_q         , DIR = I, VEC=', data_vec,   '\n'];
        str = [str, 'PORT ', hw_qdr, '_cq_n      = ', hw_qdr,'_cq_n      , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_cq        = ', hw_qdr,'_cq        , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_qvld      = ', hw_qdr,'_qvld      , DIR = I',                   '\n'];
        str = [str, 'PORT ', hw_qdr, '_dll_off_n = ', hw_qdr,'_dll_off_n , DIR = O',                   '\n'];

        %%%%% QDR Sniffer Entry %%%%%
        
        % pcore Instantiation
        str = [str, '\n'];
        str = [str, '\n'];
        str = [str, 'BEGIN opb_qdr_sniffer\n'];
        
        str = [str, ' PARAMETER INSTANCE   = ', hw_qdr,'_sniffer',      '\n'];
        str = [str, ' PARAMETER HW_VER     = 1.00.a',                   '\n'];
        str = [str, ' PARAMETER ENABLE     = ', use_sniffer,            '\n'];
        str = [str, ' PARAMETER QDR_DATA_WIDTH = ', data_width,         '\n'];
        str = [str, ' PARAMETER QDR_ADDR_WIDTH = ', addr_width,         '\n'];
        str = [str, ' PARAMETER QDR_BW_WIDTH   = ', bw_width,           '\n'];
        str = [str, ' PARAMETER QDR_LATENCY    = ', qdr_latency,        '\n'];
        str = [str, ' PARAMETER C_CONFIG_BASEADDR = ', sniff_base_addr, '\n'];
        str = [str, ' PARAMETER C_CONFIG_HIGHADDR = ', sniff_high_addr, '\n'];
        str = [str, ' PARAMETER C_BASEADDR = ', ram_base_addr,          '\n'];
        str = [str, ' PARAMETER C_HIGHADDR = ', ram_high_addr,          '\n'];
        
        str = [str, ' BUS_INTERFACE SQDR = ', inst_name, '\n'];
        str = [str, ' BUS_INTERFACE SOPB = opb0',        '\n'];
        str = [str, ' BUS_INTERFACE COPB = opb0',        '\n'];
        
        str = [str, ' PORT qdr_clk       = ', clk_src,         '\n'];
        str = [str, ' PORT OPB_Clk       = epb_clk',           '\n'];
        str = [str, ' PORT OPB_Clk_config= epb_clk',           '\n'];
        
        str = [str, ' PORT slave_addr    = ', inst_name, '_address',   '\n'];
        str = [str, ' PORT slave_wr_strb = ', inst_name, '_wr_en',     '\n'];
        str = [str, ' PORT slave_wr_data = ', inst_name, '_data_in',   '\n'];
        str = [str, ' PORT slave_wr_be   = ', inst_name, '_be',        '\n'];
        str = [str, ' PORT slave_rd_strb = ', inst_name, '_rd_en',     '\n'];
        str = [str, ' PORT slave_rd_data = ', inst_name, '_data_out',  '\n'];
        str = [str, ' PORT slave_ack     = ', inst_name, '_ack',       '\n'];
        
        str = [str, ' PORT bit_align_state_prb  = ', hw_qdr, '_bit_align_state_prb ', '\n'];
        str = [str, ' PORT bit_train_state_prb  = ', hw_qdr, '_bit_train_state_prb ', '\n'];
        str = [str, ' PORT bit_train_error_prb  = ', hw_qdr, '_bit_train_error_prb ', '\n'];
        str = [str, ' PORT phy_state_prb  = ',       hw_qdr, '_phy_state_prb ',       '\n'];

        str = [str, ' PORT phy_rdy       = ', inst_name, '_phy_ready', '\n'];
        str = [str, ' PORT cal_fail      = ', inst_name, '_cal_fail',  '\n'];
        str = [str, ' PORT qdr_reset     = ', inst_name, '_reset',     '\n'];
        
        str = [str, 'END\n'];
        str = [str, '\n'];
        str = [str, '\n'];

    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end %switch hw_sys
