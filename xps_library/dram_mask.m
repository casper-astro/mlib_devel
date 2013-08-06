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
function dram_mask(myname, wide_data)

set_param([myname,'/convert_data_in'], 'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/convert_data_in'], 'bin_pt', num2str(get_param(myname,'bin_pt')));
set_param([myname,'/force_rd_dout'], 'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/force_rd_dout'], 'bin_pt', num2str(get_param(myname,'bin_pt')));

%get hardware platform from XSG block
try
    xsg_blk = find_system(bdroot, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
    hw_sys = xps_get_hw_plat(get_param(xsg_blk{1},'hw_sys'));
catch
    warndlg('Count not find hardware platform for DRAM configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
    warning('Count not find hardware platform for DRAM configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
    hw_sys = 'ROACH';
end %try/catch

%TODO --> Add code to check whether the DRAM clock period (in ps) is an integer value, if this is not the case choose the next closest value

switch hw_sys
    case 'ROACH'
	if strcmp(get_param(myname, 'wide_data'), 'on')
    	set_param([myname,'/convert_data_in'],'n_bits', '288');
    	set_param([myname,'/convert_wr_be'], 'n_bits', '36');
	else
    	set_param([myname,'/convert_data_in'],'n_bits', '144');
    	set_param([myname,'/convert_wr_be'], 'n_bits', '18');
    	end	
    case 'ROACH2'
	set_param([myname,'/convert_data_in'],'n_bits', '288');
    	set_param([myname,'/convert_wr_be'], 'n_bits', '36');
    	%Change the bit widths of the DRAM simulation model for the ROACH-2
	set_param([myname,'/dram_sim/cast_narrow'], 'n_bits', '288');
	set_param([myname,'/dram_sim/cast_narrow1'], 'n_bits', '36');
    	set_param([myname,'/dram_sim/msbs'], 'nbits', '288');
    	set_param([myname,'/dram_sim/msbs'], 'bit0', '288');
	set_param([myname,'/dram_sim/lsbs'], 'nbits', '288');
  	set_param([myname,'/dram_sim/memory/cast_narrow2'], 'n_bits', '576');
    	set_param([myname,'/dram_sim/memory/cast_narrow3'], 'n_bits', '576');
end

gateway_outs = find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(Mem_Rst)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Rst)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Cmd_Address)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Cmd_Address)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Wr_Din)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Wr_Din)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Wr_BE)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Wr_BE)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Cmd_RNW)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Cmd_RNW)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Cmd_Tag)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Cmd_Tag)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Cmd_Valid)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Cmd_Valid)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Rd_Ack)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Rd_Ack)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end

gateway_ins = find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(Mem_Cmd_Ack)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Cmd_Ack)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Rd_Dout)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Rd_Dout)$','tokens');
        if strcmp(get_param(myname,'wide_data'),'on') || strcmp(hw_sys,'ROACH2')
            set_param(gw, 'n_bits', '288');
        else
            set_param(gw, 'n_bits', '144');
        end
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Rd_Tag)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Rd_Tag)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(Mem_Rd_Valid)$')
        toks = regexp(get_param(gw,'Name'),'(Mem_Rd_Valid)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(phy_ready)$')
        toks = regexp(get_param(gw,'Name'),'(phy_ready)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end

