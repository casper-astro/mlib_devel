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

function [result,msg] = drc(blk_obj, xps_objs)
result = 0;
msg = '';

if ~exist(blk_obj.hw_sys) | ~isstruct(blk_obj.hw_sys)
    load_hw_routes();
end % ~exist(blk_obj.hw_sys) | ~isstruct(blk_obj.hw_sys)

try
    eval(['pads = ',blk_obj.hw_sys,'.',blk_obj.io_group,';']);
catch
    try
        eval(['pads = ',blk_obj.hw_sys,'.',blk_obj.io_group,'_p;']);
    catch
        msg = ['Undefined routing table for hardware system: ',blk_obj.hw_sys,'(',blk_obj.io_group,')'];
        result = 1;
    end % try
end % try

if ~isempty(find(blk_obj.bit_index>=length(pads)))
    msg = 'Gateway bit index contain values that exceeds the io_bitwidth';
    result = 1;
end % ~isempty(find(blk_obj.bit_index>=length(pads)))

if blk_obj.use_ddr
    if ~blk_obj.reg_iob
        msg = 'When using DDR signaling mode, "Pack register in the pad" option must be on';
        result = 1;
    end % ~blk_obj.reg_iob
    if blk_obj.io_bitwidth/2 > length(pads)
        msg = 'Gateway io_bitwidth is larger than the number of available pads';
        result = 1;
    end % blk_obj.io_bitwidth/2 > length(pads)
    if length(blk_obj.bit_index) ~= blk_obj.io_bitwidth/2
        msg = 'Gateway bit index does not have half the number of elements of the I/O io_bitwidth';
        result = 1;
    end % length(blk_obj.bit_index) ~= blk_obj.io_bitwidth/2
else
    if blk_obj.io_bitwidth > length(pads)
        msg = 'Gateway io_bitwidth is larger than the number of available pads';
        result = 1;
    end % if blk_obj.io_bitwidth > length(pads)
    if length(blk_obj.bit_index) ~= blk_obj.io_bitwidth
        msg = 'Gateway bit index does not have the same number of elements as the I/O io_bitwidth';
        result = 1;
    end % if length(blk_obj.bit_index) ~= blk_obj.io_bitwidth
end %blk_obj.use_ddr

xsg_obj = get(blk_obj,'xsg_obj');
clk_src = get(xsg_obj,'clk_src');

if strcmp(blk_obj.hw_sys, 'iBOB') & strmatch('usr_clk', clk_src)
    try
        if strcmp(get(xsg_obj, 'gpioclk_grp'), blk_obj.io_group)
            bit_index = blk_obj.bit_index;
            for n=1:length(bit_index)
                if ~isempty(find(get(xsg_obj,'gpioclkbit')==bit_index(n)))
                    msg = ['User clock input and GPIO ',get(blk_obj,'simulink_name'),' share the same I/O pin.'];
                    result = 1;
                end % if ~isempty(find(get(xsg_obj,'gpioclkbit')==bit_index(n)))
            end % for n=1:length(bit_index)
        end % if strcmp(get(xsg_obj, 'gpioclk_grp'), blk_obj.io_group)
    end % try
end % if strcmp(blk_obj.hw_sys, 'iBOB') & strmatch('usr_clk', clk_src)


for n=1:length(xps_objs)
    try
        if strcmp(blk_obj.hw_sys,get(xps_objs{n},'hw_sys')) && strcmp(blk_obj.io_group,get(xps_objs{n},'io_group'))
            if ~strcmp(get(blk_obj,'simulink_name'),get(xps_objs{n},'simulink_name'))

                bit_index = blk_obj.bit_index;

			    % Check for single-ended/differential I/O conflicts
                if ~isempty(find(strcmp(blk_obj.io_group,{'zdok0', 'zdok1', 'mdr'})))
                    if strcmp(get(blk_obj,'single_ended'), 'on') & strcmp(get(xps_objs{n},'single_ended'), 'off')
                        for k=1:length(bit_index)
		    			    if ~isempty(find(get(xps_objs{n},'bit_index')==floor(bit_index(k)/2)))
			    			    msg = ['GPIO ',get(blk_obj,'simulink_name'),' and GPIO ',get(xps_objs{n},'simulink_name'),' share the same I/O pin.'];
				    		    result = 1;
					        end % if ~isempty(find(get(xps_objs{n},'bit_index')==floor(bit_index(k)/2)))
					    end % for k=1:length(bit_index)
                    elseif strcmp(get(blk_obj,'single_ended'), 'off') & strcmp(get(xps_objs{n}, 'single_ended'), 'on')
                        for k=1:length(bit_index)
		    			    if ~isempty(find(get(xps_objs{i},'bit_index')==floor(bit_index(j)/2)))
			    			    msg = ['GPIO ',get(blk_obj,'simulink_name'),' and GPIO ',get(xps_objs{n},'simulink_name'),' share the same I/O pin.'];
				    		    result = 1;
					        end % if ~isempty(find(get(xps_objs{i},'bit_index')==floor(bit_index(j)/2)))
					    end % for k=1:length(bit_index)
                    else
	    			    for k=1:length(bit_index)
		    			    if ~isempty(find(get(xps_objs{n},'bit_index')==bit_index(k)))
			    			    msg = ['GPIO ',get(blk_obj,'simulink_name'),' and GPIO ',get(xps_objs{n},'simulink_name'),' share the same I/O pin.'];
				    		    result = 1;
					        end % if ~isempty(find(get(xps_objs{n},'bit_index')==bit_index(k)))
				        end % for k=1:length(bit_index)
				    end % if strcmp(get(blk_obj,'single_ended'), 'on') & strcmp(get(xps_objs{n},'single_ended'), 'off')
				else
                    for k=1:length(bit_index)
                        if ~isempty(find(get(xps_objs{n},'bit_index')==bit_index(k)))
                            msg = ['GPIO ',get(blk_obj,'simulink_name'),' and GPIO ',get(xps_objs{n},'simulink_name'),' share the same I/O pin.'];
                            result = 1;
                        end % if ~isempty(find(get(xps_objs{n},'bit_index')==bit_index(k)))
                    end % for k=1:length(bit_index)
                end % if ~isempty(find(strcmp(blk_obj.io_group,{'zdok0', 'zdok1', 'mdr'})))
            end % if ~strcmp(get(blk_obj,'simulink_name'),get(xps_objs{n},'simulink_name'))
        end % if strcmp(blk_obj.hw_sys,get(xps_objs{n},'hw_sys')) && strcmp(blk_obj.io_group,get(xps_objs{n},'io_group'))
    end % try
end % for n=1:length(xps_objs)
