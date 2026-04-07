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
function ddr4_mask(myname)

gateway_outs = find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(ddr4_we)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_we)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_addr)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_addr)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_cmd)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_cmd)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_din)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_din)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_rx_fifo_rd_en)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_rx_fifo_rd_en)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end

gateway_ins = find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(ddr4_app_rd_data_valid)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_app_rd_data_valid)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_out_vld)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_out_vld)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_app_rdy)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_app_rdy)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_fifo_out_overflow)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_fifo_out_overflow)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_fifo_out_underflow)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_fifo_out_underflow)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_fifo_in_overflow)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_fifo_in_overflow)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_fifo_in_underflow)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_fifo_in_underflow)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_calib_complete)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_calib_complete)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_dout)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_dout)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_in_fifo_rd_dc)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_in_fifo_rd_dc)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_in_fifo_wr_dc)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_in_fifo_wr_dc)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_out_fifo_rd_dc)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_out_fifo_rd_dc)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ddr4_out_fifo_wr_dc)$')
        toks = regexp(get_param(gw,'Name'),'(ddr4_out_fifo_wr_dc)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end

