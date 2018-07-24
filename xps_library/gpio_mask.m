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

pos = get_param(cursys,'Position');
x= pos(1);
y= pos(2);

try
  remove_all_blks(cursys);
catch ex
  % If remove_all_blks throws a CallbackDelete exception (more specifically a
  % Simulink:Engine:CallbackDelete exception), then we're in a callback of some
  % sort so we shouldn't be removing blocks or redrawing things anyway so just
  % return.
  if regexp(ex.identifier, 'CallbackDelete')
    return
  end
  % Otherwise it's perhaps a legitamite exception so dump and rethrow it.
  dump_and_rethrow(ex);
end

old_ports = ports_struct(get_param(cursys,'blocks'));

switch get_param(cursys,'io_dir')
    case 'in'
        gw_name = [clear_name(gcb),'_gateway'];
        old_ports = add_port(cursys,old_ports,'outport','gpio_in', [350 50 380 65]);
        old_ports = add_port(cursys,old_ports,'inport','sim_in', [20 50 50 65]);
        add_block('xbsIndex_r4/Gateway In',[cursys,'/',gw_name],'Position', [230 50 290 70],...
            'arith_type', get_param(cursys,'arith_type'),...
            'n_bits', num2str(bitwidth),...
            'bin_pt', num2str(bin_pt),...
            'period','sample_period');

        add_line(cursys,['sim_in/1'],[gw_name,'/1']);
        add_line(cursys,[gw_name,'/1'],['gpio_in/1']);

    case 'out'
        gw_name = [clear_name(gcb),'_gateway'];
        old_ports = add_port(cursys,old_ports,'outport','sim_out', [350 50 380 65]);
        old_ports = add_port(cursys,old_ports,'inport','gpio_out', [20 50 50 65]);
        add_block('xbsIndex_r4/Gateway Out',[cursys,'/',gw_name],'Position', [150 50 190 70]);
        add_block('xbsIndex_r4/Convert',[cursys,'/convert'],'Position', [80 50 110 70],...
            'arith_type', get_param(cursys,'arith_type'),...
            'n_bits', num2str(bitwidth),...
            'bin_pt', num2str(bin_pt));
        add_line(cursys,['gpio_out/1'],['convert/1']);
        add_line(cursys,['convert/1'],[gw_name,'/1']);
        add_line(cursys,[gw_name,'/1'],['sim_out/1']);

    otherwise
        errordlg(['Unsupported I/O direction: ',get_param(cursys,'io_dir')]);
end

clean_ports(cursys,old_ports);

% set the real io_group parameter, now named 'io_group_real'
% this is a hack in order to deprecate the old io_group parameters that had
% platform names in the parameter like ROACH:led, so that a user's model
% will hold its parameter when updating to the new xps_library
io_group_string = get_param(cursys, 'io_group');
switch io_group_string
    case {'ROACH:led', 'ROACH2:led'}
        set_param(cursys, 'io_group_real', 'led');
    case {'ROACH:gpioa', 'ROACH:gpioa_oe_n', 'ROACH:gpiob', ...
          'ROACH:gpiob_oe_n', 'ROACH2:gpio'}
        set_param(cursys, 'io_group_real', 'gpio');
    case 'ROACH2:sync_in'
        set_param(cursys, 'io_group_real', 'sync_in');
    case 'ROACH2:sync_out'
        set_param(cursys, 'io_group_real', 'sync_out');
    case {'ROACH:zdok0', 'ROACH2:zdok0'}
        set_param(cursys, 'io_group_real', 'zdok0');
    case {'ROACH:zdok1', 'ROACH2:zdok1'}
        set_param(cursys, 'io_group_real', 'zdok1');
    case {'ROACH:aux0_clk' 'ROACH:aux1_clk' 'ROACH2:aux_clk'}
        set_param(cursys, 'io_group_real', 'aux_clk_diff');
    case 'custom:custom'
        set_param(cursys, 'io_group_real', 'custom');
    otherwise
        % strip off parameter and insert to custom io_group param
        set_param(cursys, 'io_group_real', 'custom');
        customValue = strsplit(io_group_string, ':');
        set_param(cursys, 'io_group_custom', char(customValue(2)));
end

if ~strcmp(io_group_real, 'custom')
    if arith_type==1
    	real_bitwidth = 1;
    else
    	real_bitwidth = bitwidth;
    end
    
    if use_ddr
        if ~reg_iob
            errordlg('When using DDR signaling mode, "Register at IOB" option must be on');
        end
        if length(bit_index) ~= real_bitwidth/2
            errordlg('Gateway bit index does not have half the number of elements as the I/O bitwidth');
        end
    else
        if length(bit_index) ~= real_bitwidth
            errordlg('Gateway bit index does not have the same number of elements as the I/O bitwidth. When using bitwidths greater than one, you should specify a vector of bit indices to use.');
        end
    end
end
