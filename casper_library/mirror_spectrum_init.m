%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKASA                                                                     %
%   www.kat.ac.za                                                             %
%   Copyright (C) Andrew Martens 2013                                         %
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

function mirror_spectrum_init(blk, varargin)

  clog('entering mirror_spectrum_init', {'trace', 'mirror_spectrum_init_debug'});

  % Set default vararg values.
  defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 8, ...
    'input_bitwidth', 18, ...
    'bin_pt_in', 'input_bitwidth-1', ...
    'bram_latency', 2, ...
    'negate_latency', 1, ...
    'negate_mode', 'Logic', ...
    'async', 'off', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'mirror_spectrum');
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
  FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
  input_bitwidth = get_var('input_bitwidth', 'defaults', defaults, varargin{:});
  bin_pt_in = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
  negate_latency = get_var('negate_latency', 'defaults', defaults, varargin{:});
  negate_mode = get_var('negate_mode', 'defaults', defaults, varargin{:});
  async = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default setup for library
  if n_inputs == 0 | FFTSize == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting mirror_spectrum_init',{'trace','mirror_spectrum_init_debug'});
    return;
  end

  %
  % sync and counter
  %

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [10 177 40 193]);

  reuse_block(blk, 'sync_delay0', 'xbsIndex_r4/Delay', ...
    'latency', '1 + bram_latency + negate_latency', 'reg_retiming', 'on', ...
    'Position', [105 174 140 196]);
  add_line(blk, 'sync/1', 'sync_delay0/1');

  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
          'cnt_type', 'Free Running', 'operation', 'Up', 'start_count', '0', 'cnt_by_val', '1', ...
          'arith_type', 'Unsigned', 'n_bits', 'FFTSize', 'bin_pt', '0', ...
          'rst', 'on', 'en', async, ...
          'explicit_period', 'off', 'use_rpm', 'on', ...
          'Position', [195 74 255 106]);
  add_line(blk, 'sync_delay0/1', 'counter/1');

  reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
          'const', num2str(2^(FFTSize-1)), ...
          'arith_type', 'Unsigned', 'n_bits', num2str(FFTSize), 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [195 122 255 148]);

  reuse_block(blk, 'relational', 'xbsIndex_r4/Relational', 'latency', '0', 'mode', 'a>b', 'Position', [315 69 355 156]);
  add_line(blk, 'counter/1', 'relational/1');
  add_line(blk, 'constant/1', 'relational/2');

  reuse_block(blk, 'sync_delay1', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'latency', '1', ...
    'Position', [410 172 450 198]);
  add_line(blk, 'sync_delay0/1', 'sync_delay1/1');

  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [480 177 510 193]);
  add_line(blk, 'sync_delay1/1', 'sync_out/1');

  %
  % data
  %

  for index = 0:3,
    reuse_block(blk, ['din',num2str(index)], 'built-in/Inport', ...
      'Port', num2str((index+1)*2), 'Position', [10 310+(125*index) 40 325+(125*index)]);

    reuse_block(blk, ['delay',num2str(index)], 'xbsIndex_r4/Delay', ...
      'latency', '1 + bram_latency + negate_latency', 'reg_retiming', 'on', ...
      'Position', [105 307+(125*index) 140 329+(125*index)]);
    add_line(blk, ['din',num2str(index),'/1'], ['delay',num2str(index),'/1']);
    
    reuse_block(blk, ['reo_in',num2str(index)], 'built-in/Inport', ...
      'Port', num2str((index+1)*2+1), 'Position', [10 345+(125*index) 40 361+(125*index)]);
    
    %from original script (commit 8ea553 and earlier)
    if strcmp(negate_mode, 'dsp48e'), cc_latency = 3;
    else, cc_latency = negate_latency;
    end
    reuse_block(blk, ['complex_conj',num2str(index)], 'casper_library_misc/complex_conj', ...
      'n_inputs', num2str(n_inputs), 'n_bits', num2str(input_bitwidth), ...
      'bin_pt', num2str(bin_pt_in), 'latency', num2str(cc_latency), 'overflow', 'Wrap', ... %TODO Wrap really?
      'Position', [105 343+(125*index) 140 363+(125*index)]);
    add_line(blk, ['reo_in',num2str(index),'/1'], ['complex_conj',num2str(index),'/1']);

    reuse_block(blk, ['mux',num2str(index)], 'xbsIndex_r4/Mux', ...
      'precision', 'Full', 'latency', '1', 'Position', [410 266+(125*index) 445 370+(125*index)]);
    add_line(blk, 'relational/1', ['mux',num2str(index),'/1']);
    add_line(blk, ['delay',num2str(index),'/1'], ['mux',num2str(index),'/2']);
    add_line(blk, ['complex_conj',num2str(index),'/1'], ['mux',num2str(index),'/3']);

    reuse_block(blk, ['dout',num2str(index)], 'built-in/Outport', ...
      'Port', num2str(index+2), 'Position', [500 310+(125*index) 530 325+(125*index)]);
    add_line(blk, ['mux',num2str(index),'/1'], ['dout',num2str(index),'/1']);
  end

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '10', 'Position', [10 222 40 238]);

    reuse_block(blk, 'en_delay0', 'xbsIndex_r4/Delay', ...
      'latency', '1 + bram_latency + negate_latency', 'reg_retiming', 'on', ...
      'Position', [105 219 140 241]);
    add_line(blk, 'en/1', 'en_delay0/1');
    add_line(blk, 'en_delay0/1', 'counter/2');

    reuse_block(blk, 'en_delay1', 'xbsIndex_r4/Delay', ...
      'latency', '1', 'reg_retiming', 'on', ...
      'Position', [410 217 450 243]);
    add_line(blk, 'en_delay0/1', 'en_delay1/1');
   
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '6', 'Position', [480 222 510 238]);
    add_line(blk, 'en_delay1/1', 'dvalid/1');  
  end

  % Delete all unconnected blocks.
  clean_blocks(blk);

  % Save block state to stop repeated init script runs.
  save_state(blk, 'defaults', defaults, varargin{:});
end % mirror_spectrum_init
