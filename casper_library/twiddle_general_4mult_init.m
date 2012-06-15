% twiddle_general_4mult_init(blk, varargin)
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009 Andrew Martens                                         %
%                                                                             %
%   Radio Astronomy Lab                                                       %
%   University of California, Berkeley                                        %
%   http://ral.berkeley.edu/                                                  %
%   Copyright (C) 2010 David MacMahon                                         %
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

function twiddle_general_4mult_init(blk, varargin)
clog('entering twiddle_general_4mult_init','trace');

defaults = {'Coeffs', [0, j], 'StepPeriod', 0, 'input_bit_width', 18, ...
    'coeff_bit_width', 18,'add_latency', 1, 'mult_latency', 2, ...
    'conv_latency', 1, 'bram_latency', 2, 'arch', 'Virtex5', ...
    'coeffs_bram', 'off', 'use_hdl', 'off', 'use_embedded', 'off', ...
    'quantization', 'Round  (unbiased: +/- Inf)', 'overflow', 'Wrap'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('twiddle_general_4mult_init post same_state', 'trace');
check_mask_type(blk, 'twiddle_general_4mult');
munge_block(blk, varargin{:});

Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin),'twiddle_general_4mult_init_debug');

if( strcmp(arch,'Virtex2Pro') ),
elseif( strcmp(arch,'Virtex5') ),
else,
    clog(['twiddle_general_4mult_init: unknown target architecture ',arch],'error');
    error(['twiddle_general_4mult_init: Unknown target architecture ',arch]);
    return
end

delete_lines(blk);

%default case, leave clean block with nothing for storage in the libraries 
if isempty(Coeffs)
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_general_4mult_init', 'trace');
  return;
end

%a input signal path
reuse_block(blk, 'a', 'built-in/inport', 'Port', '1', 'Position',[225 28 255 42]);
reuse_block(blk, 'delay0', 'xbsIndex_r4/Delay', ...
    'latency','mult_latency + add_latency + bram_latency + conv_latency', ...
    'Position', [275 15 315 55]);
add_line(blk, 'a/1', 'delay0/1');
reuse_block(blk, 'c_to_ri1', 'casper_library_misc/c_to_ri', ...
    'n_bits', 'input_bit_width', 'bin_pt', 'input_bit_width-1', ...
    'Position', [340 14 380 56]);
add_line(blk,'delay0/1','c_to_ri1/1');
reuse_block(blk, 'a_re', 'built-in/outport', 'Port', '1', 'Position', [405 13 435 27]);
reuse_block(blk, 'a_im', 'built-in/outport', 'Port', '2', 'Position', [405 43 435 57]);
add_line(blk, 'c_to_ri1/1', 'a_re/1');
add_line(blk, 'c_to_ri1/2', 'a_im/1');

%sync input signal path
reuse_block(blk, 'sync', 'built-in/inport', 'Port', '3', 'Position',[40 393 70 407]);
reuse_block(blk, 'delay2', 'xbsIndex_r4/Delay', ...
    'latency','mult_latency + add_latency + bram_latency + conv_latency', ...
    'Position', [280 380 320 420]);
add_line(blk, 'sync/1', 'delay2/1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Port', '5', 'Position', [340 393 370 407]);
add_line(blk, 'delay2/1', 'sync_out/1');

%coefficient generator
reuse_block(blk, 'coeff_gen', 'casper_library_ffts_twiddle_coeff_gen/coeff_gen', ...
    'Coeffs', tostring(Coeffs),  ...
    'StepPeriod', tostring(StepPeriod), 'coeff_bit_width', 'coeff_bit_width', ...
    'bram_latency', 'bram_latency', 'coeffs_bram', coeffs_bram, ...
    'Position', [105 249 150 291]);
add_line(blk, 'sync/1', 'coeff_gen/1');

reuse_block(blk, 'c_to_ri2', 'casper_library_misc/c_to_ri', ...
    'n_bits', 'coeff_bit_width', 'bin_pt', 'coeff_bit_width-2', ...
    'Position', [180 249 220 291]);
add_line(blk, 'coeff_gen/1', 'c_to_ri2/1');

%b input signal path
reuse_block(blk, 'b', 'built-in/inport', 'Port', '2', 'Position',[35 148 65 162]);
reuse_block(blk, 'delay1', 'xbsIndex_r4/Delay', 'latency', 'bram_latency', ...
    'reg_retiming', 'on', 'Position', [105 135 145 175]);
add_line(blk, 'b/1', 'delay1/1');
reuse_block(blk, 'c_to_ri3', 'casper_library_misc/c_to_ri', ...
    'n_bits', 'input_bit_width', 'bin_pt', 'input_bit_width-1', ...
    'Position', [185 134 225 176]);
add_line(blk, 'delay1/1', 'c_to_ri3/1');

%Mult
reuse_block(blk, 'mult', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', 'mult_latency', ...
    'Position', [275 128 320 172]);
add_line(blk, 'c_to_ri3/1', 'mult/1');
add_line(blk, 'c_to_ri2/1', 'mult/2');

%Mult1
reuse_block(blk, 'mult1', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', 'mult_latency', ...
    'Position', [275 188 320 232]);
add_line(blk, 'c_to_ri3/2', 'mult1/1');
add_line(blk, 'c_to_ri2/1', 'mult1/2');

%Mult2
reuse_block(blk, 'mult2', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', 'mult_latency', ...
    'Position', [275 248 320 292]);
add_line(blk, 'c_to_ri3/2', 'mult2/1');
add_line(blk, 'c_to_ri2/2', 'mult2/2');

%Mult3
reuse_block(blk, 'mult3', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', 'mult_latency', ...
    'Position', [275 308 320 352]);
add_line(blk, 'c_to_ri3/1', 'mult3/1');
add_line(blk, 'c_to_ri2/2', 'mult3/2');

%adders
reuse_block(blk, 'AddSub', 'xbsIndex_r4/AddSub', 'latency', 'add_latency', ...
    'mode', 'Subtraction','use_behavioral_HDL', 'on', ...
    'Position', [410 138 455 182]);
reuse_block(blk, 'AddSub1', 'xbsIndex_r4/AddSub', 'latency', 'add_latency', ...
    'mode', 'Addition','use_behavioral_HDL', 'on', ...
    'Position', [410 298 455 342]);

%output ports
reuse_block(blk, 'bw_re', 'built-in/outport', 'Port', '3', 'Position', [670 153 710 167]);
reuse_block(blk, 'bw_im', 'built-in/outport', 'Port', '4', 'Position', [670 313 710 327]);

% First delete any convert blocks that exist so that different architectures
% can use different convert blocks.  For Virtex2Pro, use CASPER convert blocks.
% For Virtex5 blocks, use Xilinx convert blocks (for "historical"
% compatibility; recommend changing V5 to use CASPER convert blocks, too).
% Deleting beforehand is needed so that reuse_block for V2P will not try to
% configure Xilinx convert blocks (left over from code for V5) as CASPER
% convert blocks and vice versa.
%
% It would probably be better to simply change the block in
% casper_library_ffts_twiddle.mdl to use CASPER converts always regardless of
% architecture (e.g. V5 vs V2P), but changing the .mdl file is riskier in that
% it could lead to merges that tend not to be pleasant.
for k=0:3
  conv_name = sprintf('convert%d', k);
  conv_blk = find_system(blk, ...
      'LookUnderMasks','all', 'FollowLinks','on', ...
      'SearchDepth',1, 'Name',conv_name);
  if ~isempty(conv_blk)
      delete_block(conv_blk{1});
  end
end

%architecture specific logic
if( strcmp(arch,'Virtex2Pro') ),

    %add convert blocks to reduce logic in adders

    % Multiplication by a complex twiddle factor is nothing more than a
    % rotation in the complex plane.  The bit width of the input value being
    % twiddled can grow no more than one non-fractional bit.  The input value
    % does not gain more precision by being twiddled so therefore it need not
    % grow any fractional bits.
    %
    % Since the growth by one non-fractional bit provides sufficient dynamic
    % range for the twiddle operation, any "overflow" can (and should!) be
    % ignored (i.e. set to "Wrap"; *not* set to "Saturate").

    reuse_block(blk, 'convert0', 'casper_library_misc/convert', ...
        'bin_pt_in', '(input_bit_width-1)+(coeff_bit_width-2)', ...
        'n_bits_out', 'input_bit_width+1', ...
        'bin_pt_out', 'input_bit_width-1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', 'Wrap', ...
        'Position', [340 135 380 165]);
    add_line(blk, 'mult/1', 'convert0/1');

    reuse_block(blk, 'convert1', 'casper_library_misc/convert', ...
        'bin_pt_in', '(input_bit_width-1)+(coeff_bit_width-2)', ...
        'n_bits_out', 'input_bit_width+1', ...
        'bin_pt_out', 'input_bit_width-1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', 'Wrap', ...
        'Position', [340 195 380 225]);
    add_line(blk, 'mult1/1', 'convert1/1');

    reuse_block(blk, 'convert2', 'casper_library_misc/convert', ...
        'bin_pt_in', '(input_bit_width-1)+(coeff_bit_width-2)', ...
        'n_bits_out', 'input_bit_width+1', ...
        'bin_pt_out', 'input_bit_width-1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', 'Wrap', ...
        'Position', [340 255 380 285]);
    add_line(blk, 'mult2/1', 'convert2/1');

    reuse_block(blk, 'convert3', 'casper_library_misc/convert', ...
        'bin_pt_in', '(input_bit_width-1)+(coeff_bit_width-2)', ...
        'n_bits_out', 'input_bit_width+1', ...
        'bin_pt_out', 'input_bit_width-1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', 'Wrap', ...
        'Position', [340 315 380 345]);
    add_line(blk, 'mult3/1', 'convert3/1');

    %join convert blocks to adders
    add_line(blk, 'convert0/1', 'AddSub/1');
    add_line(blk, 'convert2/1', 'AddSub/2');
    add_line(blk, 'convert1/1', 'AddSub1/1');
    add_line(blk, 'convert3/1', 'AddSub1/2');

    %join adders to ouputs
    add_line(blk, 'AddSub/1', 'bw_re/1');
    add_line(blk, 'AddSub1/1', 'bw_im/1');

    % Set output precision on adder outputs
    set_param([blk,'/AddSub'], ...
        'precision', 'User Defined', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'n_bits', 'input_bit_width+1', ...
        'bin_pt', 'input_bit_width-1', ...
        'quantization', 'Truncate', ...
        'overflow', 'Wrap');

    set_param([blk,'/AddSub1'], ...
        'precision', 'User Defined', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'n_bits', 'input_bit_width+1', ...
        'bin_pt', 'input_bit_width-1', ...
        'quantization', 'Truncate', ...
        'overflow', 'Wrap');

elseif( strcmp(arch,'Virtex5') )
    %add convert blocks to after adders to ensure adders absorbed into multipliers
    add_line(blk, 'mult/1', 'AddSub/1');
    add_line(blk, 'mult1/1', 'AddSub1/1');
    add_line(blk, 'mult2/1', 'AddSub/2');
    add_line(blk, 'mult3/1', 'AddSub1/2');

    reuse_block(blk, 'convert0', 'xbsIndex_r4/Convert', ...
        'pipeline', 'on', ...
        'n_bits', 'input_bit_width+4', ...
        'bin_pt', 'input_bit_width+1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [485 145 525 175]);
    add_line(blk, 'AddSub/1', 'convert0/1');
    add_line(blk, 'convert0/1', 'bw_re/1');

    reuse_block(blk, 'convert1', 'xbsIndex_r4/Convert', ...
        'pipeline', 'on', ...
        'n_bits', 'input_bit_width+4', ...
        'bin_pt', 'input_bit_width+1', ...
        'latency', 'conv_latency', 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [485 305 525 335]);
    add_line(blk, 'AddSub1/1', 'convert1/1');
    add_line(blk, 'convert1/1', 'bw_im/1');

else
    return;
end

clean_blocks(blk);

fmtstr = sprintf('data=(%d,%d)\ncoeffs=(%d,%d)\n%s\n(%s,%s)', ...
    input_bit_width, input_bit_width-1, coeff_bit_width, coeff_bit_width-2, arch, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting twiddle_general_4mult_init', 'trace');
