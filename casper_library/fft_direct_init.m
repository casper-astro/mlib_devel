% Initialize and configure the direct FFT.
%
% fft_direct_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points). 
% BitWidth = Bitwidth of input data.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% MapTail = 
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
BitWidth = get_var('BitWidth', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
MapTail = get_var('MapTail', 'defaults', defaults, varargin{:});
LargerFFTSize = get_var('LargerFFTSize', 'defaults', defaults, varargin{:});
StartStage = get_var('StartStage', 'defaults', defaults, varargin{:});

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
    for i=0:2^(FFTSize-1)-1,
        name = ['butterfly',num2str(stage),'_',num2str(i)];
        reuse_block(blk, name, 'casper_library/FFTs/butterfly_direct', ...
            'StepPeriod', '0', 'BitWidth', 'BitWidth', 'mult_latency', 'mult_latency', ...
            'add_latency', 'add_latency', 'bram_latency', 'bram_latency', ...
            'use_bram', '1', 'Position', [300*(stage-1)+220 200*i+100 300*(stage-1)+300 200*i+175]);
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
    end
end

% Check dynamic settings
for stage=1:FFTSize,
    for i=0:2^(FFTSize-1)-1,
        butterfly = [blk,'/butterfly',num2str(stage),'_',num2str(i)];
        % Implement a normal FFT or the tail end of a larger FFT
        if ~MapTail,
            coeffs = ['[',num2str(floor(i/2^(FFTSize-stage))),']'];
            actual_fft_size = FFTSize;
        else,
            redundancy = 2^(LargerFFTSize - FFTSize);
            coeffs = '[';
            for r=0:redundancy-1,
                n = bit_reverse(r, LargerFFTSize - FFTSize);
                coeffs = [coeffs,' ',num2str(floor((i+n*2^(FFTSize-1))/2^(LargerFFTSize-(StartStage+stage-1))))];
            end
            coeffs = [coeffs, ']'];
            actual_fft_size = LargerFFTSize;
        end
        if get_param(butterfly, 'FFTSize') ~= actual_fft_size,
            set_param(butterfly, 'FFTSize', num2str(actual_fft_size));
        end
        if ~strcmp(get_param(butterfly, 'Coeffs'), coeffs),
            set_param(butterfly, 'Coeffs', coeffs);
        end
        if ~strcmp(get_param(butterfly, 'quantization'), quantization),
            set_param(butterfly, 'quantization', quantization);
        end
        if ~strcmp(get_param(butterfly, 'overflow'), overflow),
            set_param(butterfly, 'overflow', overflow);
        end
    end
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d', FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
