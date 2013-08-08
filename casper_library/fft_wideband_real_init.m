function fft_wideband_real_init(blk, varargin)
% Initialize and configure an fft_wideband_real block.
%
% fft_real_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% n_inputs = Number of parallel input streams
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficient data.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% conv_latency = 
% input_latency = 
% biplex_direct_latency = 
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% arch = 
% opt_target = 
% coeffs_bit_limit = 
% delays_bit_limit = 
% mult_spec = 
% hardcode_shifts = 
% shift_schedule = 
% dsp48_adders = 
% unscramble = 

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

clog('entering fft_wideband_real_init', 'trace');

% If we are in a library, do nothing
if is_library_block(blk)
  clog('exiting fft_wideband_real_init (block in library)','trace');
  return
end

% If FFTSize is passed as 0, do nothing
if get_var('FFTSize', varargin{:}) == 0
  clog('exiting fft_wideband_real_init (FFTSize==0)','trace');
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
      clog('throwing from fft_wideband_real_init', 'trace');
      % We really want to dump this exception, even if its a duplicate of the
      % previously dumped exception, so reset dump_exception before dumping.
      dump_exception([]);
      dump_and_rethrow(ex);
    end
end

% Set default vararg values.
defaults = { ...
    'n_streams', 1, ...
    'FFTSize', 6, ...
    'n_inputs', 2, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18,  ...
    'async', 'off', ...
    'unscramble', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'input_latency', 0, ...
    'biplex_direct_latency', 0, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'delays_bit_limit', 8, ...
    'coeffs_bit_limit', 8, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
    'n_bits_rotation', 25, ...
    'max_fanout', 4, ...   
    'mult_spec', 2, ...
    'bitgrowth', 'off', ...
    'max_bits', 19, ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1 1 1 1], ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_wideband_real_init post same_state', 'trace');
check_mask_type(blk, 'fft_wideband_real');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_streams             = get_var('n_streams', 'defaults', defaults, varargin{:});
FFTSize               = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_inputs              = get_var('n_inputs', 'defaults', defaults, varargin{:});
input_bit_width       = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in             = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width       = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
unscramble            = get_var('unscramble', 'defaults', defaults, varargin{:});
async                 = get_var('async', 'defaults', defaults, varargin{:});
add_latency           = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency          = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency          = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency          = get_var('conv_latency', 'defaults', defaults, varargin{:});
input_latency         = get_var('input_latency', 'defaults', defaults, varargin{:});
biplex_direct_latency = get_var('biplex_direct_latency', 'defaults', defaults, varargin{:});
quantization          = get_var('quantization', 'defaults', defaults, varargin{:});
overflow              = get_var('overflow', 'defaults', defaults, varargin{:});
delays_bit_limit      = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
coeffs_bit_limit      = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing         = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation      = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
coeff_generation      = get_var('coeff_generation', 'defaults', defaults, varargin{:});
cal_bits              = get_var('cal_bits', 'defaults', defaults, varargin{:});
n_bits_rotation       = get_var('n_bits_rotation', 'defaults', defaults, varargin{:});
max_fanout            = get_var('max_fanout', 'defaults', defaults, varargin{:});
mult_spec             = get_var('mult_spec', 'defaults', defaults, varargin{:});
bitgrowth             = get_var('bitgrowth', 'defaults', defaults, varargin{:});
max_bits              = get_var('max_bits', 'defaults', defaults, varargin{:});
hardcode_shifts       = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule        = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders          = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

% bin_pt_in == -1 is a special case for backwards compatibility
if bin_pt_in == -1
  bin_pt_in = input_bit_width - 1;
  set_mask_params(blk, 'bin_pt_in', num2str(bin_pt_in));
end

ytick = 45;

% validate input fields
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

if n_inputs < 2,
    error_string = sprintf('REAL FFT: Number of inputs must be at least 4!');
    clog(error_string, {'error', 'fft_wideband_real_init_debug'});
    error(error_string);
    return;
end

% split up multiplier specification
mults_biplex(1 : FFTSize - n_inputs) = mult_spec(1 : FFTSize - n_inputs);
mults_direct = mult_spec(FFTSize - n_inputs + 1 : FFTSize);

% split up shift schedule
shifts_biplex = ones(1, FFTSize - n_inputs);
shifts_direct = ones(1, n_inputs);
if strcmp(hardcode_shifts, 'on'),
    shifts_biplex(1:FFTSize-n_inputs) = shift_schedule(1: FFTSize-n_inputs);
    shifts_direct = shift_schedule(FFTSize-n_inputs+1:FFTSize);
end

%%%%%%%%%%%%%%%%
% Draw blocks. %
%%%%%%%%%%%%%%%%

% Delete all wires.
delete_lines(blk);

%
% Add some input and output ports.
%

reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 102 45 117], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [15 52 45 67], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [805 72 835 88], 'Port', '1');

of_port_ypos = 160+(n_streams*ytick*2^n_inputs);
reuse_block(blk, 'of', 'built-in/outport', ...
    'Position', [805 of_port_ypos 835 of_port_ypos+15], ...
    'Port', num2str(n_streams*2^(n_inputs-1)+2));

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Position', [15 207+(ytick*(n_streams*2^n_inputs)) 45 227+(ytick*n_streams*(2^n_inputs))], ...
    'Port', num2str(n_streams*(2^n_inputs)+3));
    
  reuse_block(blk, 'dvalid', 'built-in/outport', ...
    'Position', [805 127+(ytick*n_streams*2^(n_inputs-1)) 835 143+(ytick*n_streams*2^(n_inputs-1))], ...
    'Port', num2str(n_streams*(2^(n_inputs-1))+3));
end

for s=0:n_streams-1,
  port_base = s*(2^(n_inputs-1));
  off_base = s*(2^(n_inputs-1))*ytick;
  for n=0:2^(n_inputs-1)-1,
    reuse_block(blk, ['out',num2str(s),num2str(n)], 'built-in/outport', ...
        'Position', [805 127+off_base+(ytick*n) 835 143+off_base+(ytick*n)], ...
        'Port', num2str(port_base+n+2));
  end %for s
end %for n

% Add a sync delay.
reuse_block(blk, 'in_del_sync_4x', 'casper_library_delays/pipeline', ...
    'Position', [95 115 145 135], ...
    'ShowName', 'off', ...
    'latency', num2str(input_latency));
add_line(blk, 'sync/1', 'in_del_sync_4x/1');

%add biplex_real_4x block

n_input_biplex = n_streams*2^(n_inputs-2);
% Add a biplex block.
reuse_block(blk, 'fft_biplex_real_4x', 'casper_library_ffts/fft_biplex_real_4x', ...
    'Position', [170 100 290 100+((n_streams*2^n_inputs+2)*ytick)], ...
    'n_inputs', num2str(n_input_biplex), ...
    'FFTSize', num2str(FFTSize-n_inputs), ...
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
    'mult_spec', mat2str(mults_biplex), ...
    'bitgrowth', bitgrowth, ...
    'max_bits', num2str(max_bits), ...
    'hardcode_shifts', hardcode_shifts, ...
    'shift_schedule', mat2str(shifts_biplex), ...
    'dsp48_adders', dsp48_adders);
add_line(blk, 'shift/1', 'fft_biplex_real_4x/2');
add_line(blk, 'in_del_sync_4x/1', 'fft_biplex_real_4x/1'); 

% Add a sync_out delay for the first biplex block only.
reuse_block(blk, 'del_sync_4x', 'casper_library_delays/pipeline', ...
    'Position', [315 115 365 135], ...
    'ShowName', 'off', ...
    'latency', num2str(biplex_direct_latency));
add_line(blk, 'fft_biplex_real_4x/1', 'del_sync_4x/1');

%
% Add direct FFT.
%

bit_growth_biplex = FFTSize-n_inputs;
if strcmp(bitgrowth, 'on'), 
  n_bits_fft_direct_in = min(max_bits, input_bit_width+bit_growth_biplex);
else, 
  n_bits_fft_direct_in = input_bit_width;
end

reuse_block(blk, 'fft_direct', 'casper_library_ffts/fft_direct', ...
    'Position', [425 57 545 57+ytick*(n_streams*2^n_inputs+2)], ...
    'n_streams', num2str(n_streams), ...                          
    'FFTSize', num2str(n_inputs), ...
    'input_bit_width', num2str(n_bits_fft_direct_in), ...
    'bin_pt_in', num2str(bin_pt_in), ...
    'coeff_bit_width', num2str(coeff_bit_width), ...
    'async', async, 'map_tail', 'on', ...
    'LargerFFTSize', num2str(FFTSize), ...
    'StartStage', num2str(FFTSize-n_inputs+1), ...
    'add_latency', num2str(add_latency), ...
    'mult_latency', num2str(mult_latency), ...
    'bram_latency', num2str(bram_latency), ...
    'conv_latency', num2str(conv_latency), ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
    'coeff_sharing', coeff_sharing, ...
    'coeff_decimation', coeff_decimation, ...
    'coeff_generation', coeff_generation, ...
    'cal_bits', num2str(cal_bits), ...
    'n_bits_rotation', num2str(n_bits_rotation), ...
    'max_fanout', num2str(max_fanout), ...
    'mult_spec', mat2str(mults_direct), ...
    'bitgrowth', bitgrowth, ...
    'max_bits', num2str(max_bits), ...
    'hardcode_shifts', hardcode_shifts, ...
    'shift_schedule', mat2str(shifts_direct), ...
    'dsp48_adders', dsp48_adders);
add_line(blk, 'del_sync_4x/1', 'fft_direct/1');

%terminate unwanted outputs
for s = 0:n_streams-1,
  off_base = 115+(2^(n_inputs-1)*(s*2+1)*ytick);
  for n = 0:2^(n_inputs-1)-1,
    term = ['t',num2str(s*2^(n_inputs-1)+n)];
    reuse_block(blk, term, 'built-in/Terminator', 'Position', [600 off_base+(n*ytick) 620 off_base+(n*ytick)+20]);
    add_line(blk, ['fft_direct/',num2str((s*2^n_inputs)+2^(n_inputs-1)+n+2)], [term,'/1']); 
  end %for n
end %for s

%
% Add output unscrambler.
%

if strcmp(bitgrowth, 'on'), 
  n_bits_final = min(max_bits, input_bit_width+FFTSize);
else, 
  n_bits_final = input_bit_width;
end

if strcmp(unscramble, 'on'),
  reuse_block(blk, 'fft_unscrambler', 'casper_library_ffts/fft_unscrambler', ...
    'Position', [655 60 775 60+((n_streams*2^(n_inputs-1)+1)*ytick)], ...
    'FFTSize', num2str(FFTSize-1), ...
    'n_inputs', num2str(n_inputs-1), ...
    'n_streams', num2str(n_streams), ...
    'n_bits_in', num2str(n_bits_final), ...
    'async', async, ...
    'bram_latency', num2str(bram_latency));
  add_line(blk, 'fft_direct/1', 'fft_unscrambler/1');
  add_line(blk, 'fft_unscrambler/1', 'sync_out/1');
  for s = 0:n_streams-1,
    base = s*2^n_inputs;
    for n=1:2^(n_inputs-1),
      add_line(blk, ['fft_direct/', num2str(base+n+1)], ['fft_unscrambler/', num2str(base/2+n+1)]);
      add_line(blk, ['fft_unscrambler/', num2str(base/2+n+1)], ['out', num2str(s),num2str(n-1), '/1']);
    end
  end %for s
else
  add_line(blk, 'fft_direct/1', 'sync_out/1');
  for s = 0:n_streams-1,
    base = s*2^n_inputs;
    for n=1:2^(n_inputs-1),
      add_line(blk, ['fft_direct/', num2str(1+base+n)], ['out', num2str(s), num2str(n-1), '/1']);
    end
  end
end

%
% Add remaining blocks.
%

reuse_block(blk, 'slice', 'xbsIndex_r4/Slice', ...
    'Position', [95 52 145 68], 'ShowName', 'off', ...
    'mode', 'Lower Bit Location + Width', 'bit0', num2str(FFTSize-n_inputs), ...
    'nbits', num2str(n_inputs));
add_line(blk, 'shift/1', 'slice/1');
add_line(blk, 'slice/1', 'fft_direct/2');

reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
    'Position', [680 160+(n_streams*2^n_inputs*ytick) 730 190+(n_streams*2^n_inputs*ytick)], ...
    'logical_function', 'OR', 'inputs', '2', 'latency', '1');
add_line(blk, ['fft_biplex_real_4x/',num2str(n_streams*2^n_inputs+2)], 'of_or/2');
add_line(blk, ['fft_direct/', num2str(n_streams*2^n_inputs+3-1)], 'of_or/1');
add_line(blk, 'of_or/1', 'of/1');

%add delays in and out of biplex_real_4x
for s = 0:n_streams-1,
  off_base = s*2^n_inputs*ytick;
  port_base = s*2^n_inputs;
  for n = 0:(2^n_inputs)-1,
    % input port
    in = ['in', num2str(s),num2str(n)];
    reuse_block(blk, in, 'built-in/inport', ... 
      'Position', [15 207+(off_base+ytick*n) 45 227+(off_base+ytick*n)], ...
      'Port', num2str(port_base+n+3));
    % input delay
    in_delay = ['in_del_4x_pol',num2str(port_base+n)];
    reuse_block(blk, in_delay , 'casper_library_delays/pipeline', ...
        'Position', [95 205+(off_base+n*ytick) 145 225+(off_base+n*ytick)], 'ShowName', 'on', ...
        'latency', num2str(input_latency));
    add_line(blk, [in,'/1'], [in_delay,'/1']); 
    add_line(blk, [in_delay,'/1'], ['fft_biplex_real_4x/',num2str(port_base+3+n)]);

    % Add biplex-to-direct delay
    out_delay = ['del_4x_pol',num2str(port_base+n)];
    reuse_block(blk, out_delay, 'casper_library_delays/pipeline', ...
        'Position', [315 160+(off_base+n*ytick) 365 180+(off_base+n*ytick)], ...
        'latency', num2str(biplex_direct_latency));
    add_line(blk, ['fft_biplex_real_4x/',num2str(port_base+2+n)], [out_delay,'/1']);
    add_line(blk, [out_delay,'/1'], ['fft_direct/',num2str(port_base+n+3)]);
  end %for
end %for s

%
% add asynchronous blocks

if strcmp(async, 'on'),
  reuse_block(blk, 'in_del_en_4x', 'casper_library_delays/pipeline', ...
    'Position', [95 205+(n_streams*2^n_inputs*ytick) 145 225+(ytick*n_streams*2^n_inputs)], ...
    'latency', num2str(input_latency));
  add_line(blk, 'en/1', 'in_del_en_4x/1');
  add_line(blk, 'in_del_en_4x/1', ['fft_biplex_real_4x/',num2str(n_streams*2^n_inputs+3)]);
  
  reuse_block(blk, 'out_del_en_4x', 'casper_library_delays/pipeline', ...
      'Position', [315 160+((n_streams*2^n_inputs+1)*ytick) 365 180+((n_streams*2^n_inputs+1)*ytick)], ...
      'latency', num2str(biplex_direct_latency));
  add_line(blk, ['fft_biplex_real_4x/',num2str(n_streams*2^n_inputs+3)], 'out_del_en_4x/1');
  add_line(blk, 'out_del_en_4x/1', ['fft_direct/',num2str(n_streams*2^n_inputs+3)]);
  add_line(blk, ['fft_direct/',num2str(n_streams*2^n_inputs+3)], ['fft_unscrambler/',num2str(n_streams*2^(n_inputs-1)+2)]);
  
  add_line(blk, ['fft_unscrambler/',num2str(n_streams*2^(n_inputs-1)+2)], ['dvalid/1']);
end

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%%
% Finish drawing. %
%%%%%%%%%%%%%%%%%%%

fmtstr = sprintf('%d stages\n(%d,%d)\n%s\n%s', FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_wideband_real_init','trace');

