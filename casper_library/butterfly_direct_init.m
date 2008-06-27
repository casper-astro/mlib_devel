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
% BitWidth = Bitwidth of input data.
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

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
BitWidth = get_var('BitWidth', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
use_bram = get_var('use_bram', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});

twiddle = [blk, '/twiddle'];

coeff_gen = [twiddle,'/twiddle_general_3mult/coeff_gen'];
br_coeff_gen = [coeff_gen,'/br_coeff_gen'];
block_type = get_param(twiddle, 'BlockChoice');
% Compute the complex, bit-reversed values of the twiddle factors
br_indices = bit_rev(Coeffs, FFTSize-1);
br_indices = -2*pi*1j*br_indices/2^FFTSize;
ActualCoeffs = exp(br_indices);
ActualCoeffsStr = 'exp(-2*pi*1j*(bit_rev(Coeffs, FFTSize-1))/2^FFTSize)';
fprintf(['coeffs: ', mat2str(ActualCoeffs),'\n']);
fprintf([ActualCoeffsStr,'\n']);
fprintf(['size: ', num2str(length(ActualCoeffs)), ' optimizing twiddle\n']);
% Optimize twiddler for coeff = 0, 1, or alternating 0-1
if length(Coeffs) == 1,
    if Coeffs(1) == 0,
        set_param(twiddle, 'BlockChoice', 'twiddle_coeff_0');
        block_type = 'twiddle_coeff_0';
    elseif Coeffs(1) == 1,

        set_param(twiddle, 'BlockChoice', 'twiddle_coeff_1');
        block_type = 'twiddle_coeff_1';
    else,
        set_param(twiddle, 'BlockChoice', 'twiddle_general_3mult');
        block_type = 'twiddle_general_3mult';
        set_param(coeff_gen, 'BlockChoice', 'static_coeff_gen');
    end
elseif length(Coeffs)==2 && Coeffs(1)==0 && Coeffs(2)==1 && StepPeriod==FFTSize-2,
    set_param(twiddle, 'BlockChoice', 'twiddle_stage_2');
    block_type = 'twiddle_stage_2';
else,
    set_param(twiddle, 'BlockChoice', 'twiddle_general_3mult');
    block_type = 'twiddle_general_3mult';
    set_param([twiddle,'/',block_type], 'Coeffs', ['[',ActualCoeffsStr,']']);
   
    set_param(coeff_gen, 'BlockChoice', 'br_coeff_gen');
    br_coeff_gen = [coeff_gen, '/br_coeff_gen'];
    
    if use_bram, dist_mem = 'Distributed memory';
    else, dist_mem = 'Block RAM';
    end

    set_param([br_coeff_gen,'/ROM'], 'distributed_mem', dist_mem);
    set_param([br_coeff_gen,'/ROM1'], 'distributed_mem', dist_mem);
end

propagate_vars([twiddle,'/',block_type],'defaults', defaults, varargin{:});
if(strcmp(block_type,'twiddle_general_3mult')),
    set_param([twiddle,'/',block_type], 'Coeffs', ['[',ActualCoeffsStr,']']);
end

% Propagate quantization behavior
set_param([blk,'/Convert'], 'quantization', quantization);
set_param([blk,'/Convert1'], 'quantization', quantization);
set_param([blk,'/Convert2'], 'quantization', quantization);
set_param([blk,'/Convert3'], 'quantization', quantization);

% Propagate overflow behavior
set_param([blk,'/Convert'],  'overflow', overflow);
set_param([blk,'/Convert1'], 'overflow', overflow);
set_param([blk,'/Convert2'], 'overflow', overflow);
set_param([blk,'/Convert3'], 'overflow', overflow);

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, Coeffs=[%s],\n StepPeriod=%d, BitWidth=%d', ...
                  FFTSize, num2str(Coeffs), StepPeriod, BitWidth);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
