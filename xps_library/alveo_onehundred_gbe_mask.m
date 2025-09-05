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

function alveo_onehundred_gbe_mask(blk)

    function add_line_s(sys, srcprt, dstprt)
        try
            add_line(sys, srcprt, dstprt);
        catch
            % pass
        end
    end

    function delete_block_s(blockname)
        try
            delete_block(blockname);
        catch
            % pass
        end
    end

    function delete_block_lines_s(blockname)
        try
            delete_block_lines(blockname);
        catch
            % pass
        end
    end

cursys = blk;
set_param(cursys, 'LinkStatus', 'inactive');

% rename gateways
gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', ...
    'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for ctr = 1 : length(gateway_ins)
    gw = gateway_ins{ctr};
    if regexp(get_param(gw, 'Name'), '_tx_ack$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_ack']));
    elseif regexp(get_param(gw, 'Name'), '_rx_valid$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_valid']));
    elseif regexp(get_param(gw, 'Name'), '_rx_data$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_data']));
    elseif regexp(get_param(gw, 'Name'), '_rx_dest_port$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_dest_port']));
    elseif regexp(get_param(gw, 'Name'), '_rx_src_port$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_src_port']));
    elseif regexp(get_param(gw, 'Name'), '_rx_eof$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_eof']));
    elseif regexp(get_param(gw, 'Name'), '_rx_byte_en$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_byte_en']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end
gateway_outs = find_system(cursys, 'searchdepth', 1, ...
    'FollowLinks', 'on', 'lookundermasks', 'all', ...
    'masktype', 'Xilinx Gateway Out Block');
for ctr = 1 : length(gateway_outs)
    gw = gateway_outs{ctr};
    if regexp(get_param(gw, 'Name'), '_tx_valid$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_valid']));
    elseif regexp(get_param(gw, 'Name'), '_tx_data$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_data']));
    elseif regexp(get_param(gw, 'Name'), '_tx_dest_port$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_dest_port']));
    elseif regexp(get_param(gw, 'Name'), '_tx_eof$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_eof']));
    elseif regexp(get_param(gw, 'Name'), '_tx_byte_en$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_byte_en']));
    elseif regexp(get_param(gw, 'Name'), '_tx_src_port$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_src_port']));
    elseif regexp(get_param(gw, 'Name'), '_tx_ip_index$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_ip_index']));
    elseif regexp(get_param(gw, 'Name'), '_tx_valid$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_valid']));
    elseif regexp(get_param(gw, 'Name'), '_rx_ack$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_ack']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end
end

