% Initialize and configure an fft_biplex block.
%
% fft_biplex_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% n_inputs        = Number of simultaneous inputs
% FFTSize         = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% bin_pt_in       = Binary point position of input data.
% coeff_bit_width = Bit width of coefficients.
% add_latency     = The latency of adders in the system.
% mult_latency    = The latency of multipliers in the system.
% bram_latency    = The latency of BRAM in the system. 
% conv_latency    = The latency of convert operations in the system. 
% quantization    = Quantization strategy.
% overflow        = Overflow strategy.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%                                                                             %
%   SKA Africa                                                                %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2013 Andrew Martens                                         %
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

function fft_biplex_init(blk, varargin)
clog('entering fft_biplex_init','trace');

% If we are in a library, do nothing
if is_library_block(blk)
  clog('exiting fft_biplex_init (library block)','trace');
  return
end

% If FFTSize is passed as 0, do nothing
if get_var('FFTSize', varargin{:}) == 0
  clog('exiting fft_biplex_init (FFTSize==0)','trace');
  return
end

% If n_inputs is passed as 0, do nothing
if get_var('n_inputs', varargin{:}) == 0
  clog('exiting fft_biplex_init (n_inputs==0)','trace');
  return
end

% Make sure block is not too old for current init script
try
    get_param(blk, 'n_streams');
catch
    errmsg = sprintf(['Block %s is too old for current init script.\n', ...
                      'Please run "update_casper_block(%s)".\n'], ...
                      blk, blk);
    % We are not initializing the block because it is too old.  Make sure the
    % user knows this by using a modal error dialog.  Using a modal error
    % dialog is a drastic step, but the situation really needs user attention.
    errordlg(errmsg, 'FFT Block Too Old', 'modal');
    try
      ex = MException('casper:blockTooOldError', errmsg);
      throw(ex);
    catch ex
      clog('throwing from fft_biplex_init', 'trace');
      % We really want to dump this exception, even if its a duplicate of the
      % previously dumped exception, so reset dump_exception before dumping.
      dump_exception([]);
      dump_and_rethrow(ex);
    end
end

% Set default vararg values.
defaults = { ...
    'n_streams', 1, ...
    'n_inputs', 1, ...
    'FFTSize', 2, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'async', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'opt_target', 'logic', ...
    'delays_bit_limit', 8, ...
    'coeffs_bit_limit', 8, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'max_fanout', 4, ...
    'mult_spec', 2, ...
    'bitgrowth', 'off', ...
    'max_bits', 18, ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1], ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_biplex_init post same_state', {'trace', 'fft_biplex_init_debug'});
check_mask_type(blk, 'fft_biplex');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_streams         = get_var('n_streams', 'defaults', defaults, varargin{:});
n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
async             = get_var('async', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
delays_bit_limit  = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
mult_spec         = get_var('mult_spec', 'defaults', defaults, varargin{:});
bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
max_bits          = get_var('max_bits', 'defaults', defaults, varargin{:});
hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule    = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

ytick = 60;

delete_lines(blk);

% check the per-stage multiplier specification
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

%
% prepare bus creators
%

reuse_block(blk, 'even_bussify', 'casper_library_flow_control/bus_create', ...
  'inputNum', num2str(n_inputs*n_streams), 'Position', [150 74 210 116+(((n_streams*n_inputs)-1)*ytick)]); 

reuse_block(blk, 'odd_bussify', 'casper_library_flow_control/bus_create', ...
  'inputNum', num2str(n_inputs*n_streams), 'Position', [150 74+((n_streams*n_inputs)*ytick) 210 116+((((n_streams*n_inputs)*2)-1)*ytick)]); 

%
% prepare bus splitters
%

if strcmp(bitgrowth,'on'), n_bits_out = min(input_bit_width+FFTSize, max_bits);
else n_bits_out = input_bit_width;
end

for index = 0:1,
  reuse_block(blk, ['pol',num2str(index),'_debus'], 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(n_inputs*n_streams), ...
    'outputWidth', num2str(n_bits_out*2), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [490 49+((n_streams*n_inputs)*index)*ytick 580 81+(((n_streams*n_inputs)*(index+1))-1)*ytick]);
end %for

%input ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 13 45 27], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [15 43 45 57], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [635 25 665 39], 'Port', '1');
reuse_block(blk, 'of', 'built-in/outport', 'Position', [400 150 430 164], 'Port', num2str(1+((n_streams*n_inputs)*2)+1));

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Position', [180 73+(((n_streams*n_inputs*2)+1)*ytick) 210 87+(((n_streams*n_inputs*2)+1)*ytick)], 'Port', num2str(2+(n_streams*n_inputs*2)+1));
  reuse_block(blk, 'dvalid', 'built-in/outport', ...
    'Position', [490 73+(((n_streams*n_inputs*2)+1)*ytick) 520 87+(((n_streams*n_inputs*2)+1)*ytick)], 'Port', num2str(1+(n_streams*n_inputs*2)+1+1));
end

%data inputs, outputs, connections to bus creation and expansion blocks
mult = 2;
for s = 0:n_streams-1,
  base = s*(n_inputs*mult);
  for n = 0:(n_inputs*mult)-1,
    in = ['pol',num2str(s),num2str(n),'_in'];
    reuse_block(blk, in, 'built-in/inport', ...
      'Position', [15 73+((base+n)*ytick) 45 87+((base+n)*ytick)], ...
      'Port', num2str(3+base+n));

    out = ['pol',num2str(s),num2str(n),'_out'];
    reuse_block(blk, out, 'built-in/outport', ...
      'Position', [635 53+((base+n)*ytick) 665 67+((base+n)*ytick)], ...
      'Port', num2str(2+base+n));

    %connect inputs to bus creators
    if mod(n,mult) == 0, bussify_target = 'even';
    else bussify_target = 'odd';
    end
    add_line(blk, [in,'/1'], [bussify_target, '_bussify/', num2str(floor((base+n)/mult)+1)]);

    %connect debus outputs to output
    add_line(blk, ['pol', num2str(mod((base+n),mult)), '_debus/', num2str(floor((base+n)/mult)+1)], [out,'/1']); 
  end %for n
end %for s

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
  'n_inputs', num2str(n_streams*n_inputs), ...
  'FFTSize', num2str(FFTSize), ...
  'input_bit_width', num2str(input_bit_width), ...
  'bin_pt_in', num2str(bin_pt_in), ...
  'coeff_bit_width', num2str(coeff_bit_width), ...
  'async', async, ...
  'add_latency', num2str(add_latency), ...
  'mult_latency', num2str(mult_latency), ...
  'bram_latency', num2str(bram_latency), ...
  'conv_latency', num2str(conv_latency), ...
  'quantization', quantization, ...
  'overflow', overflow, ...
  'delays_bit_limit', num2str(delays_bit_limit), ...
  'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
  'coeff_sharing', coeff_sharing, ...
  'coeff_decimation', coeff_decimation, ...
  'max_fanout', num2str(max_fanout), ...
  'mult_spec', mat2str(mult_spec), ...
  'bitgrowth', bitgrowth, ...
  'max_bits', num2str(max_bits), ...
  'hardcode_shifts', hardcode_shifts, ...
  'shift_schedule', mat2str(shift_schedule), ...
  'dsp48_adders', dsp48_adders, ...
  'Position', [250 30 335 125]);

add_line(blk, 'sync/1', 'biplex_core/1');
add_line(blk, 'shift/1', 'biplex_core/2');
add_line(blk, 'even_bussify/1', 'biplex_core/3');
add_line(blk, 'odd_bussify/1', 'biplex_core/4');

reuse_block(blk, 'biplex_cplx_unscrambler', 'casper_library_ffts_internal/biplex_cplx_unscrambler', ...
  'FFTSize', num2str(FFTSize), ...
  'bram_latency', num2str(bram_latency), ...
  'async', async, ...
  'Position', [380 30 455 120]) 

add_line(blk, ['biplex_core/1'], ['biplex_cplx_unscrambler/3']);
add_line(blk, ['biplex_core/2'], ['biplex_cplx_unscrambler/1']);
add_line(blk, ['biplex_core/3'], ['biplex_cplx_unscrambler/2']);

add_line(blk, 'biplex_core/4', 'of/1');

%output ports

if strcmp(async, 'on'),
  add_line(blk, 'en/1', 'biplex_core/5');
  add_line(blk, 'biplex_core/5', 'biplex_cplx_unscrambler/4');
  add_line(blk, 'biplex_cplx_unscrambler/4', 'dvalid/1');
end

add_line(blk, 'biplex_cplx_unscrambler/3', 'sync_out/1');
add_line(blk, 'biplex_cplx_unscrambler/1', 'pol0_debus/1');
add_line(blk, 'biplex_cplx_unscrambler/2', 'pol1_debus/1');

clean_blocks(blk);

fmtstr = sprintf('%d stages',FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_biplex_init', {'trace', 'fft_biplex_init_debug'});

