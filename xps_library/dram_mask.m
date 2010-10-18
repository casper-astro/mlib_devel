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
function dram_mask(myname, use_sim, wide_data)

set_param([myname,'/convert_data_in'], 'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/convert_data_in'], 'bin_pt', num2str(get_param(myname,'bin_pt')));
set_param([myname,'/force_rd_dout'], 'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/force_rd_dout'], 'bin_pt', num2str(get_param(myname,'bin_pt')));

if strcmp(use_sim, 'on')
    depth=length(regexp(myname,'/'));
    str='';
    for i=0:depth
        str=[str,'../'];
    end
    str=[str,'ModelSim'];
    set_param([myname, '/sim_wrapper/dram_sim'], 'engine_block', 'ModelSim');
    set_param([myname, '/sim_wrapper/dram_sim'], 'sim_method', 'External co-simulator');
    set_param([myname, '/sim_wrapper/dram_sim'], 'engine_block', str);
else
    set_param([myname, '/sim_wrapper/dram_sim'], 'engine_block', 'ModelSim');
    set_param([myname, '/sim_wrapper/dram_sim'], 'sim_method', 'Inactive');
end

if strcmp(get_param(myname, 'wide_data'), 'on')
    set_param([myname,'/convert_data_in'],'n_bits', '288');
    set_param([myname,'/convert_wr_be'], 'n_bits', '36');
else
    set_param([myname,'/convert_data_in'],'n_bits', '144');
    set_param([myname,'/convert_wr_be'], 'n_bits', '18');
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
        if strcmp(get_param(myname,'wide_data'),'on')
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

