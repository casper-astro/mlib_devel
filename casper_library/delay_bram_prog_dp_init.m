%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
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

function delay_bram_prog_dp_init(blk, varargin)

  log_group = 'delay_bram_prog_dp_init_debug';

  clog('entering delay_bram_prog_dp_init', {log_group, 'trace'});
  
  defaults = { ...
    'ram_bits', 10, ...
    'bram_latency', 2, ...
    'async', 'off'};  
  
  check_mask_type(blk, 'delay_bram_prog_dp');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  ram_bits                   = get_var('ram_bits', 'defaults', defaults, varargin{:});
  bram_latency               = get_var('bram_latency', 'defaults', defaults, varargin{:});
  async                      = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  if (ram_bits == 0),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:}); 
    clog('exiting delay_bram_prog_dp_init', {log_group, 'trace'});
    return;
  end
  
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '1', 'Position', [235 43 265 57]);
  reuse_block(blk, 'delay', 'built-in/Inport', 'Port', '2', 'Position', [115 83 145 97]);
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '3', 'Position', [15 28 45 42]);
  end

  reuse_block(blk, 'wr_addr', 'xbsIndex_r4/Counter', ...
    'n_bits', 'ram_bits', 'use_behavioral_HDL', 'on', 'use_rpm', 'on', ...
    'en', async, 'Position', [75 18 110 52]);
  if strcmp(async, 'on'), 
    add_line(blk, 'en/1', 'wr_addr/1');
  end

  reuse_block(blk, 'AddSub', 'xbsIndex_r4/AddSub', ...
    'mode', 'Subtraction', 'latency', '1', ...
    'precision', 'User Defined', 'n_bits', 'ram_bits', 'bin_pt', '0', ...
    'use_behavioral_HDL', 'on', 'use_rpm', 'on', ...
    'Position', [175 52 225 103]);
  add_line(blk, 'delay/1', 'AddSub/2');
  add_line(blk, 'wr_addr/1', 'AddSub/1');

  reuse_block(blk, 'Constant2', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'n_bits', '1', 'bin_pt', '0', ...
    'explicit_period', 'on', 'Position', [285 56 300 74]);

  reuse_block(blk, 'Constant4', 'xbsIndex_r4/Constant', ...
    'const', '0', 'arith_type', 'Boolean', 'n_bits', '1', 'bin_pt', '0', ...
    'explicit_period', 'on', 'Position', [285 102 300 118]);

  reuse_block(blk, 'Dual Port RAM', 'xbsIndex_r4/Dual Port RAM', ...
    'depth', '2^ram_bits', 'initVector', '0', ...
    'latency', 'bram_latency', 'write_mode_B', 'Read Before Write', ...
    'optimize', 'Area', 'Position', [315 26 385 119]);
  add_line(blk, 'din/1', 'Dual Port RAM/2');
  add_line(blk, 'din/1', 'Dual Port RAM/5');
  add_line(blk, 'wr_addr/1', 'Dual Port RAM/1');
  add_line(blk, 'AddSub/1', 'Dual Port RAM/4');
  add_line(blk, 'Constant2/1', 'Dual Port RAM/3');
  add_line(blk, 'Constant4/1', 'Dual Port RAM/6');

  reuse_block(blk, 'Terminator', 'built-in/Terminator', 'Position', [420 40 440 60]);
  add_line(blk,'Dual Port RAM/1', 'Terminator/1');

  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '1', 'Position', [415 88 445 102]);
  add_line(blk, 'Dual Port RAM/2', 'dout/1');

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting delay_bram_prog_dp_init', {log_group, 'trace'});
end % delay_bram_prog_dp_init

