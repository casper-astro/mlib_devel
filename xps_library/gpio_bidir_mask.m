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

% We need to rename the gateway blocks in the yellow block
% so that they respect the heirarchical naming conventions
% required by the toolflow

% find all the gateway in/out blocks
gateway_outs = find_system(gcb, ...
        'searchdepth', 1, ...
        'FollowLinks', 'on', ...
        'lookundermasks', 'all', ...
        'masktype','Xilinx Gateway Out Block'); 

gateway_ins = find_system(gcb, ...
        'searchdepth', 1, ...
        'FollowLinks', 'on', ...
        'lookundermasks', 'all', ...
        'masktype','Xilinx Gateway In Block');
% set number of bits for the Convert block    
convert_blkHandle = getSimulinkBlockHandle([gcb, '/Convert']);
set_param(convert_blkHandle, 'n_bits', num2str(bitwidth));
if length(bit_index) ~= bitwidth
    errordlg('Bit index does not have the same number of elements as the I/O bitwidth. When using bitwidths greater than one, you should specify a vector of bit indices to use.');
end

%rename the gateway outs
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    gw_name = get_param(gw, 'Name');
    if regexp(gw_name, 'in_not_out_i$')
        set_param(gw, 'Name', clear_name([gcb, '_in_not_out_i']));
    elseif regexp(gw_name, 'din_i$')
        set_param(gw, 'Name', clear_name([gcb, '_din_i']));
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end 

%rename the gateway ins
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    gw_name = get_param(gw, 'Name');
    % Set number of bits for gateway in block
    set_param(gw, 'n_bits', num2str(bitwidth));
    if regexp(gw_name, 'dout_o$')
        set_param(gw, 'Name', clear_name([gcb, '_dout_o']));
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end