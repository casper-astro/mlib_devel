function fft_unscrambler_init(blk, varargin)
% Initialize and configure an fft_unscrambler block.
%
% fft_unscrambler_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% n_inputs = Number of parallel input streams
% bram_latency = The latency of BRAM in the system.

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

% If we are in a library, do nothing
if is_library_block(blk)
  clog('exiting fft_unscrambler_init (block in library)','trace');
  return
end

% If FFTSize is passed as 0, do nothing
if get_var('FFTSize', varargin{:}) == 0
  clog('exiting fft_unscrambler_init (FFTSize==0)','trace');
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
    'n_inputs', 3, ...
    'n_bits_in', 18, ...
    'bram_latency', 2, ...
    'async', 'on', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_unscrambler');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_streams     = get_var('n_streams', 'defaults', defaults, varargin{:});
FFTSize       = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_inputs      = get_var('n_inputs', 'defaults', defaults, varargin{:});
n_bits_in     = get_var('n_bits_in', 'defaults', defaults, varargin{:});
bram_latency  = get_var('bram_latency', 'defaults', defaults, varargin{:});
async         = get_var('async', 'defaults', defaults, varargin{:});

ytick = 40;

% Validate input fields.

if (n_inputs >= FFTSize - 2),
    error('FFT Unscrambler: 2^n_inputs must be < 2^(FFT size-2).');
end

part_mat = [0:2^(FFTSize-2*n_inputs)-1]*2^(n_inputs);
map_mat = [];
for n=0:2^n_inputs-1,
    map_mat = [map_mat, part_mat+n];
end
map_str = mat2str(map_mat);

delete_lines(blk);

% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 43 60 57], 'Port', '1');

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', ...
    'Position', [90 83+((2^n_inputs*n_streams)*ytick) 120 97+((2^n_inputs*n_streams)*ytick)], 'Port', num2str(((2^n_inputs)*n_streams)+2));

  reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [600 53 630 67], 'Port', '1');

  reuse_block(blk, 'dvalid', 'built-in/outport', ...
    'Position', [600 83 630 97], 'Port', num2str(((2^n_inputs)*n_streams)+2));
else
  reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [600 43 630 57], 'Port', '1');
end

%bus creators and expanders
for n=0:2^n_inputs-1,
  base = ytick*n*n_streams;

  %add bus creator on input
  bus = ['bus',num2str(n)];
  pos = [90 70+base 120 70+base+(n_streams*ytick)-20];
  reuse_block(blk, bus, 'casper_library_flow_control/bus_create', 'inputNum', num2str(n_streams), 'Position', pos);

  %add bus splitter on output
  debus = ['debus', num2str(n)];
  pos = [515 110+base 565 110+base+(n_streams*ytick)-20];
  reuse_block(blk, debus, 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(n_streams), ...
    'outputWidth', mat2str(repmat(n_bits_in*2, 1, n_streams)), 'outputBinaryPt', mat2str(zeros(1,n_streams)), ... 
    'outputArithmeticType', mat2str(zeros(1,n_streams)), 'Position', pos);
end %for n

%add ports
for s=0:n_streams-1,
  for n=0:2^n_inputs-1,
    port_base = s*2^n_inputs;
    off_base = ytick*n*n_streams;

    in = ['in',num2str(s),num2str(n)];
    reuse_block(blk, in, 'built-in/inport', ...
      'Position', [30 off_base+(ytick*s)+83 60 off_base+(ytick*s)+97], 'Port', num2str(port_base+n+2));
    bus = ['bus',num2str(n)];
    add_line(blk, [in,'/1'], [bus,'/',num2str(s+1)]);

    out = ['out',num2str(s),num2str(n)];
    reuse_block(blk, out, 'built-in/outport', ...
      'Position', [600 off_base+(ytick*s)+123 630 off_base+(ytick*s)+137], 'Port', num2str(port_base+n+2));
    debus = ['debus', num2str(n)];
    add_line(blk, [debus,'/',num2str(s+1)], [out,'/1']);
  end %for n
end %for s


if strcmp(async, 'on'), n_ctrl = 2;
else n_ctrl = 1;
end

% Add static blocks
reuse_block(blk, 'square_transposer', 'casper_library_reorder/square_transposer', ...
  'Position', [185 30 270 ((2^n_inputs+n_ctrl)*ytick)+30], ...
  'n_inputs', num2str(n_inputs), 'async', async);
add_line(blk, 'sync/1', 'square_transposer/1');

reuse_block(blk, 'reorder', 'casper_library_reorder/reorder', ...
  'Position', [365 30 460 ((2^n_inputs+2)*ytick)+30], ...
  'map', map_str, ...
  'n_inputs', num2str(2^n_inputs), ...
  'bram_latency', num2str(bram_latency), ...
  'map_latency', '1', 'double_buffer', '0');
add_line(blk, 'square_transposer/1', 'reorder/1');

if strcmp(async, 'on'),
  add_line(blk, 'en/1', ['square_transposer/',num2str(2^n_inputs+2)]);

  reuse_block(blk, 'logical', 'xbsIndex_r4/Logical', ...
    'logical_function', 'AND', 'latency', '0', ...
    'Position', [510 41 540 74]);
  add_line(blk, 'reorder/1', 'logical/1');
  add_line(blk, 'reorder/2', 'logical/2');
  add_line(blk, 'logical/1', 'sync_out/1');

  add_line(blk, ['square_transposer/',num2str(2^n_inputs+2)], 'reorder/2');

  add_line(blk, 'reorder/2','dvalid/1');
else
  add_line(blk, 'reorder/1', 'sync_out/1');

  reuse_block(blk, 'en', 'xbsIndex_r4/Constant', ...
      'Position', [320 82 345 98], ...
      'arith_type', 'Boolean', ...
      'explicit_period', 'on');
  add_line(blk, 'en/1','reorder/2');
  
  reuse_block(blk, 'ten', 'built-in/Terminator', 'Position', [485 80 505 100]);
  add_line(blk, 'reorder/2', 'ten/1');
end

% Add dynamic lines
for i=0:2^n_inputs-1,
    in_name = ['bus',num2str(i)];
    out_name = ['debus',num2str(i)];
    add_line(blk, [in_name,'/1'], ['square_transposer/',num2str(i+2)]);
    add_line(blk, ['square_transposer/',num2str(i+2)], ['reorder/',num2str(i+3)]);
    add_line(blk, ['reorder/',num2str(i+3)], [out_name,'/1']);
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, n_inputs=%d', FFTSize, n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
