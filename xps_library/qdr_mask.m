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

function qdr_mask(blk)

myname = blk;

%get hardware platform from XSG block
try
    xsg_blk = find_system(bdroot(blk), 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
    hw_sys = xps_get_hw_plat(get_param(xsg_blk{1},'hw_sys'));
catch
    if ~regexp(bdroot(blk), '(casper|xps)_library')
      warndlg('Could not find hardware platform for QDR configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
      warning('Could not find hardware platform for QDR configuration - is there an XSG block in this model? Defaulting platform to ROACH.');
    end
    hw_sys = 'ROACH';
end %try/catch

clog(['Drawing QDR block for platform: ', hw_sys], 'qdr_mask_debug');

switch hw_sys
    case 'ROACH'
        data_width = 36;
        be_width = 4;
        qdr_latency = 10;
        n_qdr = 2;
    % end case 'ROACH'
    case 'ROACH2'
        data_width = 72;
        be_width = 8;
        qdr_latency = 10;
        n_qdr = 4;
        %%data_width = 72;
        %be_width = 8;
        %%qdr_latency = 14;
        %qdr_latency = 10;
        %n_qdr = 4;
    % end case 'ROACH2'
end % end switch hw_sys

% catch incorrect qdr selection
which_qdr = get_param(myname, 'which_qdr');
qdr_num = str2num(which_qdr(4));
if (qdr_num > (n_qdr-1))
    warndlg(['Block configured for QDR ', num2str(qdr_num), '. ', hw_sys, ' only has ', num2str(n_qdr), ' QDR chips. Defaulting to QDR 0']);
    warning(['Block configured for QDR ', num2str(qdr_num), '. ', hw_sys, ' only has ', num2str(n_qdr), ' QDR chips. Defaulting to QDR 0']);
    set_param(myname, 'which_qdr', 'qdr0');
end


%Set qdr latency to correctly align data valid out signal
set_param([myname, '/qdr_latency'], 'Latency', num2str(qdr_latency));


%construct bit remapping to move parity bits
input_parity_map  = 'b = {';
output_parity_map = 'b = {';
output_parity_map_top = '';
output_parity_map_bottom = '';

for i=[be_width-1:-1:0]
   input_parity_map = [input_parity_map, 'a[', num2str(data_width-(be_width-i)), '],a[', num2str((i+1)*8-1), ':', num2str(i*8), ']'];
   output_parity_map_top = [output_parity_map_top, 'a[', num2str(9*(i+1) - 1), ']'];
   output_parity_map_bottom = [output_parity_map_bottom, 'a[', num2str(9*(i+1)-1 - 1), ':', num2str(9*(i+1)-1 - 8), ']'];
   if i==0
       input_parity_map = [input_parity_map, '}'];
       output_parity_map = [output_parity_map, output_parity_map_top, ',', output_parity_map_bottom, '}'];
   else
       input_parity_map = [input_parity_map, ','];
       output_parity_map_top = [output_parity_map_top, ','];
       output_parity_map_bottom = [output_parity_map_bottom, ','];
   end
end

%update expressions in bitbasher blocks
extract_parity_blk = [myname, '/extract_parity'];
insert_parity_blk = [myname, '/insert_parity'];
set_param(insert_parity_blk, 'bitexpr', input_parity_map);
set_param(extract_parity_blk, 'bitexpr', output_parity_map);



set_param([myname,'/convert_data_in'],'n_bits',num2str(data_width));
set_param([myname,'/convert_data_in1'],'n_bits',num2str(data_width));
set_param([myname,'/convert_be'],'n_bits',num2str(be_width));

gateway_outs = find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(wr_en)$')
        toks = regexp(get_param(gw,'Name'),'(wr_en)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rd_en)$')
        toks = regexp(get_param(gw,'Name'),'(rd_en)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(be)$')
        toks = regexp(get_param(gw,'Name'),'(be)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(address)$')
        toks = regexp(get_param(gw,'Name'),'(address)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(data_in)$')
        toks = regexp(get_param(gw,'Name'),'(data_in)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end

gateway_ins =find_system(myname,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(data_out)$')
        toks = regexp(get_param(gw,'Name'),'(data_out)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
        set_param(gw,'n_bits',num2str(data_width));
    elseif regexp(get_param(gw,'Name'),'(phy_ready)$')
        toks = regexp(get_param(gw,'Name'),'(phy_ready)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(cal_fail)$')
        toks = regexp(get_param(gw,'Name'),'(cal_fail)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(ack)$')
        toks = regexp(get_param(gw,'Name'),'(ack)$','tokens');
        set_param(gw,'Name',clear_name([myname,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end

