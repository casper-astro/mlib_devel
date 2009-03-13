% Initialize and configure the direct FFT.
%
% fft_direct_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points). 
% input_bit_width = Bitwidth of input and output data.
% coeff_bit_width = Bitwidth of coefficients
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% map_tail = 
% LargerFFTSize = Size of the entire FFT.
% StartStage = First stage in this FFT.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
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

function fft_direct_init(blk, varargin)

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_direct');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
map_tail = get_var('map_tail', 'defaults', defaults, varargin{:});
LargerFFTSize = get_var('LargerFFTSize', 'defaults', defaults, varargin{:});
StartStage = get_var('StartStage', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});

current_stages = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on',...
    'SearchDepth',1,'masktype', 'butterfly_direct');
prev_stages = length(current_stages);

delete_lines(blk);
% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 0 60 15], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 45 60 60], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [300*FFTSize+150 0 300*FFTSize+180 15], 'Port', '1');
for i=0:2^FFTSize-1,
    reuse_block(blk, ['in',num2str(i)], 'built-in/inport', 'Position', [30 100*i+100 60 100*i+115]);
    reuse_block(blk, ['out',num2str(i)], 'built-in/outport', 'Position', [300*FFTSize+150 100*i+100 300*FFTSize+180 100*i+115]);
end
reuse_block(blk, 'of', 'built-in/outport', 'Position', [300*FFTSize+210 100*(2^FFTSize)+100 300*FFTSize+240 100*(2^FFTSize)+115], 'Port', tostring((2^FFTSize)+2));
reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', 'inputs', tostring(FFTSize), 'latency', '0', ...
    'Position', [300*FFTSize+150 100*(2^FFTSize)+100 300*FFTSize+180 100*(2^FFTSize)+115+(FFTSize*10)]);
add_line(blk, 'of_or/1', 'of/1');

% Add nodes
for stage=0:FFTSize,
    for i=0:2^FFTSize-1,
        name = ['node',num2str(stage),'_',num2str(i)];
        reuse_block(blk, name, 'xbsIndex_r4/Delay', ...
            'latency', '0', 'Position', [300*stage+90 100*i+100 300*stage+120 100*i+130]);
        if stage == 0,
            add_line(blk, ['in',num2str(i),'/1'], [name,'/1']);
        end
        if stage == FFTSize,
            add_line(blk, [name,'/1'], ['out',num2str(bit_reverse(i, FFTSize)),'/1']);
        end
    end
    if stage ~= FFTSize,
        name = ['slice',num2str(stage)];
        reuse_block(blk, name, 'xbsIndex_r4/Slice', ...
            'mode', 'Lower Bit Location + Width', 'nbits', '1', 'bit0', num2str(stage), ...
            'boolean_output', 'on', 'Position', [300*stage+90 70 300*stage+120 85]);
        add_line(blk,'shift/1', [name,'/1']);
    end

end

% Add butterflies
for stage=1:FFTSize,
    %add overflow logic
    reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Logical', ...
        'logical_function', 'OR', 'inputs', tostring(2^(FFTSize-1)), 'latency', '1', ...
        'Position', [300*stage+90 100*(2^FFTSize)+100+(stage*15) 300*stage+120 120+100*(2^FFTSize)+(FFTSize*5)+(stage*15)]);
    add_line(blk, ['of_',num2str(stage),'/1'], ['of_or/',num2str(stage)]);
    for i=0:2^(FFTSize-1)-1,
        name = ['butterfly',num2str(stage),'_',num2str(i)];
        reuse_block(blk, name, 'casper_library/FFTs/butterfly_direct', ...
            'biplex', 'off', 'StepPeriod', '0', ... 
            'Position', [300*(stage-1)+220 200*i+100 300*(stage-1)+300 200*i+175]);
        propagate_vars([blk,'/',name], 'defaults', defaults, varargin{:});
        node_one_num = 2^(FFTSize-stage+1)*floor(i/2^(FFTSize-stage)) + mod(i, 2^(FFTSize-stage));
        node_two_num = node_one_num+2^(FFTSize-stage);
        input_one = ['node',num2str(stage-1),'_',num2str(node_one_num),'/1'];
        input_two = ['node',num2str(stage-1),'_',num2str(node_two_num),'/1'];
        output_one = ['node',num2str(stage),'_',num2str(node_one_num),'/1'];
        output_two = ['node',num2str(stage),'_',num2str(node_two_num),'/1'];
        add_line(blk, input_one, [name,'/1']);
        add_line(blk, input_two, [name,'/2']);
        add_line(blk, [name,'/1'], output_one);
        add_line(blk, [name,'/2'], output_two);
        if stage == 1, add_line(blk, 'sync/1', [name,'/3']);
        else, add_line(blk, ['butterfly',num2str(stage-1),'_',num2str(i),'/4'], [name,'/3']);
        end
        if stage == FFTSize && i == 0, add_line(blk, [name,'/4'], 'sync_out/1');
        end
        add_line(blk, ['slice',num2str(stage-1),'/1'], [name, '/4']);

        %add lines for overflow logic
        add_line(blk, [name,'/3'], ['of_',num2str(stage),'/',num2str(i+1)])
    end
end

% Check dynamic settings
for stage=1:FFTSize,

    use_hdl = 'on';
    use_embedded = 'off';
    if(strcmp(specify_mult,'on')),
        if( mult_spec(stage) == 2)
            use_hdl = 'on'; 
            use_embedded = 'off';
        elseif( mult_spec(stage) == 1), 
            use_hdl = 'off';
            use_embedded = 'on'; 
        else
            use_hdl = 'off';
            use_embedded = 'off';
        end
    end

    for i=0:2^(FFTSize-1)-1,
        butterfly = [blk,'/butterfly',num2str(stage),'_',num2str(i)];
        % Implement a normal FFT or the tail end of a larger FFT
        if strcmp(map_tail,'off'),
            coeffs = ['[',num2str(floor(i/2^(FFTSize-stage))),']'];
            actual_fft_size = FFTSize;
            num_coeffs = 1;
        else,
            redundancy = 2^(LargerFFTSize - FFTSize);
            coeffs = '[';
            for r=0:redundancy-1,
                n = bit_reverse(r, LargerFFTSize - FFTSize);
                coeffs = [coeffs,' ',num2str(floor((i+n*2^(FFTSize-1))/2^(LargerFFTSize-(StartStage+stage-1))))];
            end
            coeffs = [coeffs, ']'];
            actual_fft_size = LargerFFTSize;
            num_coeffs = redundancy;
        end
        if (num_coeffs * coeff_bit_width) > (2^coeffs_bit_limit), coeffs_bram = 'on';
        else, coeffs_bram = 'off';
        end
        set_param(butterfly, 'FFTSize', num2str(actual_fft_size), ...
        'coeffs_bram', tostring(coeffs_bram), 'Coeffs', coeffs, 'use_hdl', tostring(use_hdl), ...
        'use_embedded', tostring(use_embedded));
    end
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d', FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
