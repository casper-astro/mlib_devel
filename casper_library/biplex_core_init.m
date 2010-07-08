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
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Input and output bit width
% coeff_bit_width = Coefficient bit width
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

clog('entering biplex_core_init','trace');
% Declare any default values for arguments you might like.
defaults = {'FFTSize', 2, 'input_bit_width', 18, 'coeff_bit_width', 18, ...
    'quantization', 'Round  (unbiased: +/- Inf)', 'overflow', 'Saturate', ...
    'add_latency', 1, 'mult_latency', 2, 'bram_latency', 2, 'conv_latency', 1, ...
    'arch', 'Virtex5', 'opt_target', 'logic', ...
    'coeffs_bit_limit', 8, 'delays_bit_limit', 8, ...
    'specify_mult', 'off', 'mult_spec', [2 2], 'dsp48_adders', 'off'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('biplex_core_init post same_state','trace');
check_mask_type(blk, 'biplex_core');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

if FFTSize < 2,
    errordlg('biplex_core_init.m: Biplex FFT must have length of at least 2^2, forcing size to 2.');
    clog('biplex_core_init.m: Biplex FFT must have length of at least 2^2, forcing size to 2.','error');
    set_param(blk, 'FFTSize', '2');
    FFTSize = 2;
end

if( strcmp(specify_mult, 'on') && (length(mult_spec) ~= FFTSize)),
    error('biplex_core_init.m: Multiplier use specification for stages does not match FFT size');
    clog('biplex_core_init.m: Multiplier use specification for stages does not match FFT size','error');
    return
end

current_stages = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'SearchDepth',1,...
    'masktype', 'fft_stage');
prev_stages = length(current_stages);

reuse_block(blk, 'pol1', 'built-in/inport', 'Port', '1', 'Position', [15 33 45 47]);
reuse_block(blk, 'pol2', 'built-in/inport', 'Port', '2', 'Position', [15 58 45 72]);
reuse_block(blk, 'sync', 'built-in/inport', 'Port', '3', 'Position', [15 108 45 122]);
reuse_block(blk, 'Constant', 'xbsindex_r4/Constant', 'arith_type', 'Boolean', 'const', '0', 'Position', [55 82 85 98]);
reuse_block(blk, 'shift', 'built-in/inport', 'Port', '4', 'Position', [15 193 45 207]);

if FFTSize ~= prev_stages,
    delete_lines(blk);

    % Create/Delete Stages
    for a=1:FFTSize,
        
        %if delays occupy larger space than specified then implement in BRAM
        if (2^(FFTSize-a) * input_bit_width * 2) >= (2^delays_bit_limit), delays_bram = 'on';
        else, delays_bram = 'off';
        end

        %if coefficients occupy larger space than specified then store in BRAM
%        if min(2^(a-1),2^MaxCoeffNum) * coeff_bit_width >= 2^coeffs_bit_limit, coeffs_bram = 'on';
        if (2^(a-1) * coeff_bit_width * 2) >= 2^coeffs_bit_limit, coeffs_bram = 'on';
        else, coeffs_bram = 'off';
        end
        
        use_hdl = 'on';
        use_embedded = 'off';
        if( strcmp(specify_mult,'on')),
            if( mult_spec(a) == 2 ), 
                use_hdl = 'on'; 
                use_embedded = 'off';
            elseif( mult_spec(a) == 1), 
                use_hdl = 'off';
                use_embedded = 'on'; 
            else
                use_hdl = 'on';
                use_embedded = 'off';
            end
        end
        
        stage_name = ['fft_stage_',num2str(a)];

        reuse_block(blk, stage_name, 'casper_library/FFTs/fft_stage_n', ...
            'FFTSize', num2str(FFTSize), 'FFTStage', num2str(a), ...
            'input_bit_width', num2str(input_bit_width), 'coeff_bit_width', num2str(coeff_bit_width), ...
            'coeffs_bram', coeffs_bram, 'delays_bram', delays_bram, ...
            'quantization', tostring(quantization), ...
            'overflow', tostring(overflow), 'add_latency', num2str(add_latency), ...
            'mult_latency', num2str(mult_latency), 'bram_latency', num2str(bram_latency), ...
            'conv_latency', num2str(conv_latency), 'arch', tostring(arch), ...
            'opt_target', tostring(opt_target), 'use_hdl', use_hdl, ...
            'use_embedded', use_embedded, 'dsp48_adders', tostring(dsp48_adders), ...
            'Position', [120*a, 32, 120*a+95, 148]);
        prev_stage_name = ['fft_stage_',num2str(a-1)];
        if( a > 1 ),
            add_line(blk, [prev_stage_name,'/1'], [stage_name,'/1']);
            add_line(blk, [prev_stage_name,'/2'], [stage_name,'/2']);
            add_line(blk, [prev_stage_name,'/3'], [stage_name,'/3']);
            add_line(blk, [prev_stage_name,'/4'], [stage_name,'/4']);
            add_line(blk, 'shift/1', [stage_name,'/5']);
        end
    end

    add_line(blk, 'pol1/1', 'fft_stage_1/1');
    add_line(blk, 'pol2/1', 'fft_stage_1/2');
    add_line(blk, 'Constant/1', 'fft_stage_1/3');
    add_line(blk, 'sync/1', 'fft_stage_1/4');
    add_line(blk, 'shift/1', 'fft_stage_1/5');
    % Reposition output ports
    last_stage = ['fft_stage_',num2str(FFTSize)];
    
    outports = {'out1', 'out2', 'of', 'sync_out'};
    for a=1:length(outports),
    	x = 120*(FFTSize+1);
    	y = 33 + 30*(a-1);
        reuse_block(blk, outports{a}, 'built-in/outport', 'Port', num2str(a), ...
        'Position', [x, y, x+30, y+14]);
        add_line(blk, [last_stage,'/',num2str(a)], [outports{a},'/1']);
    end
end

clean_blocks(blk);

fmtstr = sprintf('%d stages\nreduce %s\n%s', FFTSize, opt_target, arch);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting biplex_core_init','trace');
