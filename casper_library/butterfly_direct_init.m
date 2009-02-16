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

function butterfly_direct_init(blk, varargin)
% Initialize and configure the direct butterfly
%
% butterfly_direct_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% Coeffs = Coefficients for twiddle blocks
% StepPeriod = Coefficient step period.
% input_bit_width = Bitwidth of input and output data.
% coeff_bit_width = Bitwdith of coefficients
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% use_bram = Use bram or slr delays
% dist_mem =
% quantization = Quantization behavior.
% overflow = Overflow behavior.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'butterfly_direct');
munge_block(blk, varargin{:});

pass_through = get_var('pass_through', 'defaults', defaults, varargin{:});
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
use_bram = get_var('use_bram', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});

twiddle = [blk, '/twiddle'];

coeff_gen = [twiddle,'/coeff_gen'];
% Compute the complex, bit-reversed values of the twiddle factors
br_indices = bit_rev(Coeffs, FFTSize-1);
br_indices = -2*pi*1j*br_indices/2^FFTSize;
ActualCoeffs = exp(br_indices);
ActualCoeffsStr = 'exp(-2*pi*1j*(bit_rev(Coeffs, FFTSize-1))/2^FFTSize)';
%fprintf(['coeffs: ', tostring(ActualCoeffs),'\n']);
%fprintf([ActualCoeffsStr,'\n']);
%fprintf(['size: ', num2str(length(ActualCoeffs)), ' optimizing twiddle\n']);
% Optimize twiddler for coeff = 0, 1, or alternating 0-1
if length(Coeffs) == 1,
    if Coeffs(1) == 0,
        replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_coeff_0','noprompt');
        set_param(twiddle,'LinkStatus','inactive')
        block_type = 'twiddle_coeff_0';
    elseif Coeffs(1) == 1,
        replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_coeff_1','noprompt');
        set_param(twiddle,'LinkStatus','inactive')
        block_type = 'twiddle_coeff_1';
    else,
        replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_general_3mult','noprompt');
        set_param(twiddle,'LinkStatus','inactive')
        block_type = 'twiddle_general_3mult';
        replace_block(twiddle,'Name','coeff_gen','casper_library/FFTs/Twiddle/coeff_gen/static_coeff_gen','noprompt');
        set_param([twiddle,'/coeff_gen'],'LinkStatus','inactive');
    end

    if( pass_through == 1 )
        replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_pass_through','noprompt');
        set_param(twiddle,'LinkStatus','inactive')
        block_type = 'twiddle_pass_through';
    end
elseif length(Coeffs)==2 && Coeffs(1)==0 && Coeffs(2)==1 && StepPeriod==FFTSize-2,
    replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_stage_2','noprompt');
    set_param(twiddle,'LinkStatus','inactive');
    block_type = 'twiddle_stage_2';
else,
    replace_block(blk, 'Name', 'twiddle', 'casper_library/FFTs/Twiddle/twiddle_general_3mult','noprompt');
    set_param(twiddle,'LinkStatus','inactive');
    block_type = 'twiddle_general_3mult';
    set_param(twiddle, 'Coeffs', ['[',ActualCoeffsStr,']']);

    replace_block(twiddle,'Name','coeff_gen','casper_library/FFTs/Twiddle/coeff_gen/br_coeff_gen','noprompt');
    set_param([twiddle,'/coeff_gen'],'LinkStatus','inactive');
    
    if use_bram, dist_mem = 'Block RAM';
    else, dist_mem = 'Distributed memory';
    end

    set_param([coeff_gen,'/ROM'], 'distributed_mem', dist_mem);
    set_param([coeff_gen,'/ROM1'], 'distributed_mem', dist_mem);
end

propagate_vars(twiddle,'defaults', defaults, varargin{:});
if(strcmp(block_type,'twiddle_general_3mult')),
    set_param(twiddle, 'Coeffs', ['[',ActualCoeffsStr,']']);
    propagate_vars([twiddle,'/coeff_gen'],'defaults', defaults, varargin{:});
    set_param([twiddle,'/coeff_gen'], 'Coeffs', 'Coeffs');
end

%set up overflow indication blocks
bw = input_bit_width+6; 
bd = input_bit_width+1;
if strcmp(block_type, 'twiddle_general_3mult'),
	bw = input_bit_width+6; 
	bd = input_bit_width+1;
elseif (strcmp(block_type, 'twiddle_stage_2') || strcmp(block_type, 'twiddle_coeff_0') || strcmp(block_type, 'twiddle_coeff_1') || strcmp(block_type, 'twiddle_pass_through')),
	bw = input_bit_width+2;
	bd = input_bit_width;
else
	fprintf('butterfly_direct_init: Unknown twiddle %s\n',block_type);
end

for i = 1:4 ,
	set_param([blk,'/convert_of',num2str(i)], ...
	'quantization', quantization, 'overflow', overflow, ...
	'bit_width_i', tostring(bw), 'binary_point_i', tostring(bd), ...
	'bit_width_o', tostring(input_bit_width), ...
       	'binary_point_o', tostring(input_bit_width-1));
end
%disp('convert_of params set');

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, Coeffs=[%s],\n StepPeriod=%d, input_bit_width=%d,\n coeff_bit_width=%d', ...
                  FFTSize, num2str(Coeffs), StepPeriod, input_bit_width, coeff_bit_width);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
