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

function biplex_core_init(blk, varargin)
% Initialize and configure the CASPER X Engine.
%
% x_engine_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'biplex_core');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
BitWidth = get_var('BitWidth', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

BRAMSize = 18432;
MaxCoeffNum = 11;	        % This is the maximum that will fit in a BRAM
%DelayBramThresh = 1/8;      % Use bram when delays will fill this fraction of a BRAM
CoeffBramThresh = 1/8;      % Use bram when coefficients will fill this fraction of a BRAM

if FFTSize < 2,
    errordlg('Biplex FFT must have length of at least 2^2.');
    set_param(blk, 'FFTSize', '2');
    FFTSize = 2;
end

current_stages = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'SearchDepth',1,...
    'masktype', 'fft_stage');
prev_stages = length(current_stages);

if FFTSize ~= prev_stages,
    outports = {'out1', 'out2', 'of', 'sync_out'};
    delete_lines(blk);
    % Create/Delete Stages and set static parameters
    for a=2:FFTSize,
        stage_name = ['fft_stage_',num2str(a)];
        reuse_block(blk, stage_name, 'casper_library/FFTs/fft_stage_n', ...
            'FFTSize', 'FFTSize', 'FFTStage', num2str(a), 'BitWidth', 'BitWidth', ...
            'MaxCoeffNum', 'MaxCoeffNum', 'add_latency', 'add_latency', ...
            'mult_latency', 'mult_latency', 'bram_latency', 'bram_latency', ...
            'Position', [110*a, 27, 110*a+95, 113]);
        prev_stage_name = ['fft_stage_',num2str(a-1)];
        add_line(blk, [prev_stage_name,'/1'], [stage_name,'/1']);
        add_line(blk, [prev_stage_name,'/2'], [stage_name,'/2']);
        add_line(blk, [prev_stage_name,'/3'], [stage_name,'/3']);
        add_line(blk, [prev_stage_name,'/4'], [stage_name,'/4']);
        add_line(blk, 'shift/1', [stage_name,'/5']);
    end
    add_line(blk, 'pol1/1', 'fft_stage_1/1');
    add_line(blk, 'pol2/1', 'fft_stage_1/2');
    add_line(blk, 'sync/1', 'fft_stage_1/3');
    add_line(blk, 'shift/1', 'fft_stage_1/4');
    % Reposition output ports
    last_stage = ['fft_stage_',num2str(FFTSize)];
    for a=1:length(outports),
    	x = 110*(FFTSize+1);
    	y = 33 + 20*(a-1);
        set_param([blk,'/',outports{a}], 'Position', [x, y, x+30, y+14]);
        add_line(blk, [last_stage,'/',num2str(a)], [outports{a},'/1']);
    end
end

% Set Dynamic Parameters
for a=1:FFTSize,
    stage_name = [blk,'/fft_stage_',num2str(a)];
    %if (2^(FFTSize - a) * BitWidth >= DelayBramThresh*BRAMSize), delay_bram = 'on';
    if (FFTSize - a >= 6), use_bram = '1';
    else, use_bram = '0';
    end
    if (min(2^(a-1), 2^MaxCoeffNum) * BitWidth >= CoeffBramThresh*BRAMSize), CoeffBram = '1';
 	else, CoeffBram = '0';
    end
    propagate_vars(stage_name, 'defaults', defaults, varargin{:});
    set_param(stage_name, 'use_bram', use_bram);
    set_param(stage_name, 'CoeffBram', CoeffBram);   
    set_param(stage_name, 'MaxCoeffNum', mat2str(MaxCoeffNum));
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d', FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
