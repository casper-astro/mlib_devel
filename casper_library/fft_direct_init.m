function fft_direct_init(blk, varargin)
% Initialize and configure an fft_direct block.
%
% fft_direct_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
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
%   http://casper.berkeley.edu                                                %
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

clog('entering fft_direct_init','trace');

% Set default vararg values.
defaults = { ...
    'FFTSize', 1,  ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18, ...
    'map_tail', 'on', ...
    'LargerFFTSize', 5, ...
    'StartStage', 4, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'coeffs_bit_limit', 8,  ...
    'mult_spec', [2], ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1], ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_direct_init post same_state','trace');
check_mask_type(blk, 'fft_direct');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
map_tail = get_var('map_tail', 'defaults', defaults, varargin{:});
LargerFFTSize = get_var('LargerFFTSize', 'defaults', defaults, varargin{:});
StartStage = get_var('StartStage', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin),'fft_direct_init_debug');

if FFTSize == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_direct_init','trace');
  return;
end
% check the per-stage multiplier specification
stage_mult_spec = multiplier_specification(mult_spec, FFTSize, 'fft_direct_init');

current_stages = find_system(blk, ...
    'lookUnderMasks', 'all', ...
    'FollowLinks', 'on', ...
    'SearchDepth', 1, ...
    'masktype', 'butterfly_direct');
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
reuse_block(blk, 'of', 'built-in/outport', 'Port', tostring((2^FFTSize)+2), ...
    'Position', [300*FFTSize+210 100*(2^FFTSize)+100 300*FFTSize+240 100*(2^FFTSize)+115]);

%FFTSize == 1 implies 1 input or block which generates an error
if (FFTSize ~= 1),
    pos = [300*FFTSize+150 100*(2^FFTSize)+100 300*FFTSize+180 100*(2^FFTSize)+115+(FFTSize*10)];
    reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
        'Position', pos, ...
        'logical_function', 'OR', ...
        'inputs', tostring(FFTSize), ...
        'latency', '0');
    add_line(blk, 'of_or/1', 'of/1');
end

% Add nodes
for stage=0:FFTSize,
    for i=0:2^FFTSize-1,
        name = ['node',num2str(stage),'_',num2str(i)];
        pos = [300*stage+90 100*i+100 300*stage+120 100*i+130];
        reuse_block(blk, name, 'xbsIndex_r4/Delay', ...
            'Position', pos, ...
            'latency', '0');

        if (stage == 0),
            add_line(blk, ['in',num2str(i),'/1'], [name,'/1']);
        end

        if (stage == FFTSize),
            add_line(blk, [name,'/1'], ['out',num2str(bit_reverse(i, FFTSize)),'/1']);
        end
    end
    if (stage ~= FFTSize),
        name = ['slice',num2str(stage)];
        pos = [300*stage+90 70 300*stage+120 85];
        reuse_block(blk, name, 'xbsIndex_r4/Slice', ...
            'Position', pos, ...
            'mode', 'Lower Bit Location + Width', ...
            'nbits', '1', ...
            'bit0', num2str(stage), ...
            'boolean_output', 'on');
        add_line(blk,'shift/1', [name,'/1']);
    end
end

% Add butterflies
for stage = 1 : FFTSize,
    if (strcmp(hardcode_shifts, 'on') && (shift_schedule(stage) == 1)),
        downshift = 'on';
    else
        downshift = 'off';
    end

    %add overflow logic
    if (FFTSize ~= 1),
        pos = [300*stage+90 100*(2^FFTSize)+100+(stage*15) 300*stage+120 120+100*(2^FFTSize)+(FFTSize*5)+(stage*15)];
        reuse_block(blk, ['of_', num2str(stage)], 'xbsIndex_r4/Logical', ...
            'Position', pos, ...
            'logical_function', 'OR', ...
            'inputs', num2str(2^(FFTSize-1)), ...
            'latency', '1');
        add_line(blk, ['of_',num2str(stage),'/1'], ['of_or/',num2str(stage)]);
    end

    for i=0:2^(FFTSize-1)-1,
        % Implement a normal FFT or the tail end of a larger FFT
        if strcmp(map_tail, 'off'),
            coeffs = ['[',num2str(floor(i/2^(FFTSize-stage))),']'];
            actual_fft_size = FFTSize;
            num_coeffs = 1;
        else
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

        if ((num_coeffs * coeff_bit_width * 2) > 2^coeffs_bit_limit),
            coeffs_bram = 'on';
        else
            coeffs_bram = 'off';
        end

        name = ['butterfly', num2str(stage), '_', num2str(i)];
        pos = [300*(stage-1)+220 200*i+100 300*(stage-1)+300 200*i+175];
        biplex = get_var('biplex', 'defaults', defaults, varargin{:});

        reuse_block(blk, name, 'casper_library_ffts/butterfly_direct', ...
            'Position', pos, ...
            'biplex', 'off', ...
            'FFTSize', num2str(actual_fft_size), ...
            'Coeffs', coeffs, ...
            'StepPeriod', '0', ...
            'coeff_bit_width', num2str(coeff_bit_width), ...
            'input_bit_width', num2str(input_bit_width), ...
            'downshift', tostring(downshift), ...
            'bram_latency', num2str(bram_latency), ...
            'add_latency', num2str(add_latency), ...
            'mult_latency', num2str(mult_latency), ...
            'conv_latency', num2str(conv_latency), ...
            'quantization', tostring(quantization), ...
            'overflow', tostring(overflow), ...
            'arch', tostring(arch), ...
            'opt_target', tostring(opt_target), ...
            'coeffs_bram', coeffs_bram, ...
            'use_hdl', stage_mult_spec(stage).use_hdl, ...
            'use_embedded', stage_mult_spec(stage).use_embedded, ...
            'hardcode_shifts', tostring(hardcode_shifts), ...
            'dsp48_adders', tostring(dsp48_adders));

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
        if (stage == 1),
            add_line(blk, 'sync/1', [name,'/3']);
        else
            add_line(blk, ['butterfly',num2str(stage-1),'_',num2str(i),'/4'], [name,'/3']);
        end
        if ((stage == FFTSize) && (i == 0)),
            add_line(blk, [name,'/4'], 'sync_out/1');
        end
        add_line(blk, ['slice',num2str(stage-1),'/1'], [name, '/4']);

        %add lines for overflow logic
        if (FFTSize ~= 1),
            add_line(blk, [name,'/3'], ['of_',num2str(stage),'/',num2str(i+1)])
        else
            add_line(blk, [name,'/3'], 'of/1')
        end
    end
end

clean_blocks(blk);

fmtstr = sprintf('%s\nstages [%s] of %d\n[%d,%d]\n%s\n%s', arch, num2str([StartStage:1:StartStage+FFTSize-1]), ...
    actual_fft_size,  input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_direct_init','trace');
