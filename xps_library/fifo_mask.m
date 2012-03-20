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

cursys = gcb;

fifo_length = get_param(cursys, 'fifo_length');
data_width = str2num(get_param(cursys, 'data_width'));
arith_type = get_param(cursys, 'arith_type');
data_bin_pt = str2num(get_param(cursys, 'data_bin_pt'));

if data_bin_pt > data_width || data_bin_pt < 0
   errordlg('Wrong binary point');
end

% Custom block deletion
blks = get_param(cursys,'blocks');
lines = get_param(cursys,'lines');
for i = 1:length(blks),
    switch get_param([cursys,'/',blks{i}],'BlockType')
        case {'Inport' 'Outport' 'SubSystem'}
        otherwise
            delete_block([cursys,'/',blks{i}]);
    end
end
for i = 1:length(lines)
    delete_line(lines(i).Handle);
end
% Rename ports
blks = get_param(cursys,'blocks');
newblks = get_param(cursys,'blocks');
for i=1:length(blks),
    switch get_param([cursys,'/',blks{i}],'BlockType')
        case {'Inport' 'Outport'}
        otherwise
            newblks(i) = [];
    end
end
old_ports = ports_struct(newblks);
switch get_param(cursys, 'io_dir')
    case 'From Processor'
        iports = {'re', 'reset', 'level'};
        oports = {'data_out', 'empty', 'level_reached'};
        iport_widths = [1, 1, 16];
        oport_widths = [data_width, 1, 1];
    case 'To Processor'
        iports = {'data_in', 'we', 'reset', 'level'};
        oports = {'full', 'level_reached'};
        iport_widths = [data_width, 1, 1, 16];
        oport_widths = [1, 1];
    otherwise
        errordlg(['Unsupported I/O direction: ',get_param(cursys,'io_dir')]);
end
for i = 1:length(iports),
    old_ports = add_port(cursys,old_ports,'inport',iports{i},[20 50*i 50 15+50*i]);
    set_param([cursys,'/',iports{i}],'Port',num2str(i));
         if strcmp(iports(i),'data_in'),
            atype = arith_type;
            bin_pt = data_bin_pt;
         else
            atype = 'Unsigned';
            bin_pt = 0;
         end
        gw_name = [clear_name(cursys),'_user_',iports{i}];
        add_block('xbsIndex_r4/Convert', [cursys,'/','convert_',gw_name], 'Position',[100 50*i 150 15+50*i], ...
            'arith_type', atype,...
            'n_bits', num2str(iport_widths(i)),...
            'bin_pt', num2str(bin_pt));
        add_block('xbsIndex_r4/Gateway Out', [cursys,'/',gw_name], 'Position',[175 50*i 225 15+50*i]);
        add_line(cursys,[iports{i},'/1'],['convert_',gw_name,'/1']);
        add_line(cursys,['convert_',gw_name,'/1'],[gw_name,'/1']);
end
for i = 1:length(oports),
    old_ports = add_port(cursys,old_ports,'outport',oports{i},[570 50*i 600 15+50*i]);
    set_param([cursys,'/',oports{i}],'Port',num2str(i));
         gw_name =[clear_name(cursys),'_user_',oports{i}];
         if strcmp(oports(i),'data_out') ,
            atype = arith_type;
            bin_pt = data_bin_pt;
         else
            atype = 'Unsigned';
            bin_pt = 0;
         end
         add_block('xbsIndex_r4/Gateway In', [cursys,'/',gw_name], 'Position',[450 50*i 500 15+50*i], ...
            'arith_type', atype,...
            'n_bits', num2str(oport_widths(i)),...
            'bin_pt', num2str(bin_pt));
         add_line(cursys,[gw_name,'/1'],[oports{i},'/1']);
         add_block('built-in/Constant', [cursys,'/',gw_name,'_const'], 'Position',[350 50*i 400 15+50*i], 'value', '0');
         add_line(cursys,[gw_name,'_const','/1'],[gw_name,'/1']);

end
clean_ports(cursys,old_ports);
