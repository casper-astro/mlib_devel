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

% Need to rename the delay block!
% function clock_constr_mask(blk)

cursys = gcb;
% get hardware platform from XSG block
% constr_blk = find_system(cursys);
% bitwidth=str2double(get_param(constr_blk{1},'bitwidth'));

delay_blks = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Delay Block');

for i = 1:length(delay_blks)
    delay_blk = delay_blks{i};
    if regexp(get_param(delay_blk, 'Name'), '(delay)$')
        toks = regexp(get_param(delay_blk, 'Name'), '(delay)$', 'tokens');
        set_param(delay_blk, 'Name', clear_name([cursys, '_', toks{1}{1}]));
    else
        error(['Unknown gateway name: ', delay_blk]);
    end
end

% gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');

% for i = 1:length(gateway_ins)
%     gw = gateway_ins{i};
%     if regexp(get_param(gw, 'Name'), '(gateway_in)$')
%         toks = regexp(get_param(gw, 'Name'), '(gateway_in)$', 'tokens');
%         set_param(gw, 'Name', clear_name([cursys, '_', toks{1}{1}]));
%     else
%         error(['Unknown gateway name: ', gw]);
%     end
% end

% gateway_outs = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');

% for i = 1:length(gateway_outs)
%     gw = gateway_outs{i};
%     if regexp(get_param(gw, 'Name'), '(gateway_out)$')
%         toks = regexp(get_param(gw, 'Name'), '(gateway_out)$', 'tokens');
%         set_param(gw, 'Name', clear_name([cursys, '_', toks{1}{1}]));
%     else
%         error(['Unknown gateway name: ', gw]);
%     end
% end