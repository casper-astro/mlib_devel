% cross_multiplier_init(blk, varargin)
%
% Used in refactor block 
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009 Andrew Martens                                         %
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

function refactor_storage_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'cross_multiplier');
munge_block(blk, varargin{:});
delete_lines(blk);

streams = get_var('streams', 'defaults', defaults, varargin{:});
aggregation = get_var('aggregation', 'defaults', defaults, varargin{:});
bit_width_in = get_var('bit_width_in', 'defaults', defaults, varargin{:});
binary_point_in = get_var('binary_point_in', 'defaults', defaults, varargin{:});
bit_width_out = get_var('bit_width_out', 'defaults', defaults, varargin{:});
binary_point_out = get_var('binary_point_out', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
quantisation = get_var('quantisation', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});

%delay infrastructure
reuse_block(blk, 'sync_in', 'built-in/inport', ...
    'Port', '1', 'Position', [30 30 60 45]);
reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', ...
    'latency', 'mult_latency+add_latency+1+conv_latency', ...
    'Position', [410 25 460 50]) 
add_line(blk, 'sync_in/1', 'sync_delay/1');
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Port', '1', 'Position', [950 30 980 45]);
add_line(blk, 'sync_delay/1', 'sync_out/1');

offset = 0;
tick=120;
for input = 0:streams-1,
    %number of multipliers to be used
    mults = (2*(input+1)-1)*aggregation; 

    reuse_block(blk, ['din',num2str(input)], 'built-in/inport', ...
        'Port', [num2str(input+2)], 'Position', [30 100+(offset+mults)*tick 60 115+(offset+mults)*tick]);

    % set up uncram block for each stream
    reuse_block(blk, ['unpack',num2str(input)], 'gavrt_library/uncram', ...
        'num_slice', 'aggregation', ...
        'slice_width', 'bit_width_in*2', ... 
        'bin_pt', '0', 'arith_type', '0', ...
        'Position', [120 100+(offset+mults)*tick 170 100+(offset+mults+aggregation)*tick]);
    add_line(blk, ['din',num2str(input),'/1'],['unpack',num2str(input),'/1']);

    %go through each aggregated stream
    for substream = 0:aggregation-1,

        %combine real from imaginary parts
        sub_name = ['c_to_ri', num2str(input), '_', num2str(substream)];
        reuse_block(blk, sub_name, 'casper_library_misc/c_to_ri', ...
            'n_bits', 'bit_width_in', 'bin_pt', 'binary_point_in', ...
            'Position', [200 100+(offset+mults+substream)*tick 250 150+(offset+mults+substream)*tick]);
        add_line(blk, ['unpack',num2str(input),'/',num2str(substream+1)], [sub_name,'/1']);
    end

    %go through multipliers    
    for mult = 0:(mults/aggregation)-1,
        
        %pick inputs to multipliers, generating mults based on matrix as follows
        %   |  A   B   C   D
        %------------------
        %A* | AA* BA* CA* DA*
        %B* | AB* BB* CB* DB*
        %C* | AC* BC* CC* DC*
        %D* | AD* BD* CD* DD*
        
        x_in = min(mult,input);
        y_in = min(input,mults/aggregation-mult-1);
    
        %to recombine streams
        pack_name = ['pack', num2str(input), '_', num2str(mult)];
        reuse_block(blk, pack_name, 'gavrt_library/cram', ...
            'num_slice', 'aggregation', ...
            'Position', [800 100+(offset+mults+(mult*aggregation))*tick 850 130+(offset+mults+(mult*aggregation))*tick]);
        
        for substream = 0:aggregation-1,

            %set up multiplier
            mult_name = ['cmult', num2str(input), '_', num2str(mult), '_', num2str(substream)];  
            reuse_block(blk, mult_name, 'casper_library_multipliers/cmult_4bit_hdl*', ...
                'mult_latency', 'mult_latency', 'add_latency', 'add_latency', ...
                'Position', [550 100+(offset+mults+(mult*aggregation)+substream)*tick 600 195+(offset+mults+(mult*aggregation)+substream)*tick]);

            %set up delays to remove fanout from c_to_ri blocks
            delay_name = ['delay', num2str(input), '_', num2str(mult), '_', num2str(substream), '_0'];
            reuse_block(blk, delay_name, 'xbsIndex_r4/Delay', ...
                'latency', '1', ...
                'Position', [450 100+(offset+mults+(mult*aggregation)+substream)*tick 480 100+(offset+mults+(mult*aggregation)+substream)*tick+15]); 
            add_line(blk, ['c_to_ri', num2str(x_in), '_', num2str(substream), '/1'], [delay_name,'/1']);
            add_line(blk, [delay_name,'/1'], [mult_name,'/1']);

            delay_name = ['delay', num2str(input), '_', num2str(mult), '_', num2str(substream), '_1'];
            reuse_block(blk, delay_name, 'xbsIndex_r4/Delay', ...
                'latency', '1', ...
                'Position', [450 100+(offset+mults+(mult*aggregation)+substream)*tick+30 480 100+(offset+mults+(mult*aggregation)+substream)*tick+45]);    
            add_line(blk, ['c_to_ri', num2str(x_in), '_', num2str(substream), '/2'], [delay_name,'/1']);
            add_line(blk, [delay_name,'/1'], [mult_name,'/2']);
            
            delay_name = ['delay', num2str(input), '_', num2str(mult), '_', num2str(substream), '_2'];
            reuse_block(blk, delay_name, 'xbsIndex_r4/Delay', ...
                'latency', '1', ...
                'Position', [450 100+(offset+mults+(mult*aggregation)+substream)*tick+60 480 100+(offset+mults+(mult*aggregation)+substream)*tick+75]);    
            add_line(blk, ['c_to_ri', num2str(y_in), '_', num2str(substream), '/1'], [delay_name,'/1']);
            add_line(blk, [delay_name,'/1'], [mult_name,'/3']);

            delay_name = ['delay', num2str(input), '_', num2str(mult), '_', num2str(substream), '_3'];
            reuse_block(blk, delay_name, 'xbsIndex_r4/Delay', ...
                'latency', '1', ...
                'Position', [450 100+(offset+mults+(mult*aggregation)+substream)*tick+90 480 100+(offset+mults+(mult*aggregation)+substream)*tick+105]);    
            add_line(blk, ['c_to_ri', num2str(y_in), '_', num2str(substream), '/2'], [delay_name,'/1']);
            add_line(blk, [delay_name,'/1'], [mult_name,'/4']);

            %TODO finish overflow detection
            %convert data to output precision
            cvrt_name = ['cvrt', num2str(input), '_', num2str(mult), '_', num2str(substream)];
            reuse_block(blk, [cvrt_name, '_real'], 'casper_library_misc/convert_of', ...
	    	'bit_width_i', tostring(bit_width_in*2+1), 'binary_point_i', tostring(binary_point_in*2), ...
	    	'bit_width_o', tostring(bit_width_out), 'binary_point_o', tostring(binary_point_out), ...
		'overflow', tostring(overflow), 'quantization', tostring(quantisation), 'latency', tostring(conv_latency), ...
                'Position', [625 100+(offset+mults+(mult*aggregation)+substream)*tick 675 130+(offset+mults+(mult*aggregation)+substream)*tick]);
            reuse_block(blk, [cvrt_name, '_imag'], 'casper_library_misc/convert_of', ...
	    	'bit_width_i', tostring(bit_width_in*2+1), 'binary_point_i', tostring(binary_point_in*2), ...
	    	'bit_width_o', tostring(bit_width_out), 'binary_point_o', tostring(binary_point_out), ...
		'overflow', tostring(overflow), 'quantization', tostring(quantisation), 'latency', tostring(conv_latency), ... 
                'Position', [625 150+(offset+mults+(mult*aggregation)+substream)*tick 675 180+(offset+mults+(mult*aggregation)+substream)*tick]);
            
	    add_line(blk, [mult_name,'/1'], [cvrt_name,'_real/1']);
            add_line(blk, [mult_name,'/2'], [cvrt_name,'_imag/1']);

            %join results into complex output
            ri2c_name = ['ri_to_c', num2str(input), '_', num2str(mult), '_', num2str(substream)];
            reuse_block(blk, ri2c_name, 'casper_library_misc/ri_to_c', ...
                'Position', [725 100+(offset+mults+(mult*aggregation)+substream)*tick 775 130+(offset+mults+(mult*aggregation)+substream)*tick]);

            add_line(blk, [cvrt_name,'_real/1'], [ri2c_name,'/1']);
            add_line(blk, [cvrt_name,'_imag/1'], [ri2c_name,'/2']);
        
            add_line(blk, [ri2c_name,'/1'], [pack_name,'/',num2str(substream+1)]);
            
        end
        
        %create output port
        out_name = ['din', num2str(x_in), '_x_din', num2str(y_in), '*']; 
        reuse_block(blk, out_name, 'built-in/outport', 'Port', num2str((offset/aggregation)+mult+2), ...
            'Position', [950 100+(offset+mults+(mult*aggregation))*tick 980 115+(offset+mults+(mult*aggregation))*tick])
        add_line(blk, [pack_name,'/1'], [out_name,'/1']);

    end

    offset = offset+mults;

end

clean_blocks(blk);

%fmtstr = sprintf('%d:1 %d bit',input_streams, bit_width);
%set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
