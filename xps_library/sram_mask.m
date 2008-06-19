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

myname = gcb;
%set_param(myname, 'LinkStatus', 'inactive');

if strcmp(use_sim, 'on')
    depth=length(regexp(gcb,'/'));
    str='';
    for i=0:depth
        str=[str,'../'];
    end
    str=[str,'ModelSim'];
    set_param([gcb, '/sram_sim/sram_sim'], 'engine_block', 'ModelSim');
    set_param([gcb, '/sram_sim/sram_sim'], 'sim_method', 'External co-simulator');
    set_param([gcb, '/sram_sim/sram_sim'], 'engine_block', str);
elseif strcmp(use_sim, 'off')
    set_param([gcb, '/sram_sim/sram_sim'], 'engine_block', 'ModelSim');
    set_param([gcb, '/sram_sim/sram_sim'], 'sim_method', 'Inactive');
end

set_param([myname,'/convert_data_in'],'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/convert_data_in'],'n_bits', '36');
set_param([myname,'/convert_data_in'],'bin_pt', num2str(get_param(myname,'bin_pt')));

set_param([myname,'/force_data_out'],'arith_type', get_param(myname,'arith_type'));
set_param([myname,'/force_data_out'],'bin_pt', num2str(get_param(myname,'bin_pt')));

gateway_outs =find_system(gcb,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(we)$')
        toks = regexp(get_param(gw,'Name'),'(we)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(be)$')
        toks = regexp(get_param(gw,'Name'),'(be)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(address)$')
        toks = regexp(get_param(gw,'Name'),'(address)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(data_in)$')
        toks = regexp(get_param(gw,'Name'),'(data_in)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end

gateway_ins =find_system(gcb,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(data_out)$')
        toks = regexp(get_param(gw,'Name'),'(data_out)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(data_valid)$')
        toks = regexp(get_param(gw,'Name'),'(data_valid)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end

