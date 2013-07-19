function biplex_cplx_unscrambler_init(blk, varargin)

% Configure the biplex_cplx_unscrambler block.
% 
% biplex_cplx_unscrambler_init(blk, varargin)
% 
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% * FFTSize = Size of the FFT (2^FFTSize points).
% * n_bits = Data bitwidth.
% * add_latency = Latency of adders blocks.
% * conv_latency = Latency of cast blocks.
% * bram_latency = Latency of BRAM blocks.
% * bram_map = Store map in BRAM.
% * dsp48_adders = Use DSP48s for adders.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKASA radio telescope project                                             %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2012, 2013 Andrew Martens                                   %
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

  defaults = { ...
    'FFTSize', 2, ...
    'bram_latency', 2, ...
    'async', 'off'};

  % Skip init script if mask state has not changed.
  if same_state(blk, 'defaults', defaults, varargin{:}), return; end

  % Verify that this is the right mask for the block.
  check_mask_type(blk, 'biplex_cplx_unscrambler');

  % Disable link if state changes from default.
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
  bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
  async = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);
  
  if FFTSize == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    return;
  end

  %
  % input ports
  %

  reuse_block(blk, 'even', 'built-in/Inport', 'Port', '1', 'Position', [25 198 55 212]);
  reuse_block(blk, 'odd', 'built-in/Inport', 'Port', '2', 'Position', [25 248 55 262]);
  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '3', 'Position', [25 118 55 132]);

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [25 298 55 312]);
    en = 'on';
    position = [270 80 355 330];
  else,
    en = 'off';
    position = [265 78 340 282];
  end

  %
  % first barrel switcher
  %

  reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
          'n_bits', 'FFTSize', ...
          'rst', 'on', ...
          'en', en, ...
          'explicit_period', 'off', ...
          'use_rpm', 'on', ...
          'Position', [100 107 135 143]);
  add_line(blk,'sync/1','Counter/1');

  reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', ...
          'const', '2^(FFTSize-1)', ...
          'arith_type', 'Unsigned', ...
          'n_bits', 'FFTSize', ...
          'bin_pt', '0', ...
          'explicit_period', 'on', ...
          'Position', [100 76 135 94]);

  reuse_block(blk, 'Relational', 'xbsIndex_r4/Relational', ...
          'mode', 'a<=b', ...
          'Position', [155 65 200 145]);
  add_line(blk,'Counter/1','Relational/2');
  add_line(blk,'Constant1/1','Relational/1');

  reuse_block(blk, 'Convert', 'xbsIndex_r4/Convert', ...
          'arith_type', 'Unsigned', ...
          'n_bits', '1', ...
          'bin_pt', '0', ...
          'Position', [220 93 250 117]);
  add_line(blk,'Relational/1','Convert/1');

  reuse_block(blk, 'barrel_switcher', 'casper_library_reorder/barrel_switcher', ...
          'n_inputs', '1', ...
          'async', async, ...
          'Position', position);

  add_line(blk,'even/1','barrel_switcher/3');
  add_line(blk,'odd/1','barrel_switcher/4');
  add_line(blk,'sync/1','barrel_switcher/2');
  add_line(blk,'Convert/1','barrel_switcher/1');

  if strcmp(async, 'on'),
    add_line(blk, 'en/1', 'Counter/2'); 
    add_line(blk, 'en/1', 'barrel_switcher/5'); 
  end

  %
  % reorders
  %

  map = bit_reverse(0:2^(FFTSize-1)-1, FFTSize-1);

  reuse_block(blk, 'reorder', 'casper_library_reorder/reorder', ...
          'map', mat2str([map,map+2^(FFTSize-1)]), ...
          'bram_latency', 'bram_latency', ...
          'map_latency', '0', ...
          'Position', [415 99 510 171]);

  reuse_block(blk, 'reorder1', 'casper_library_reorder/reorder', ...
          'map', mat2str([map+2^(FFTSize-1),map]), ...
          'bram_latency', 'bram_latency', ...
          'map_latency', '0', ...
          'Position', [415 189 510 261]);

  reuse_block(blk, 'T0', 'built-in/Terminator', ...
    'Position', [535 190 555 210]);
  add_line(blk, 'reorder1/1', 'T0/1');
  
  add_line(blk,'barrel_switcher/1','reorder/1');
  add_line(blk,'barrel_switcher/1','reorder1/1');
  add_line(blk,'barrel_switcher/2','reorder/3');
  add_line(blk,'barrel_switcher/3','reorder1/3');

  %
  % second barrel switcher
  %
  
  reuse_block(blk, 'Constant2', 'xbsIndex_r4/Constant', ...
          'const', '2^(FFTSize-1)', ...
          'arith_type', 'Unsigned', ...
          'n_bits', 'FFTSize', ...
          'bin_pt', '0', ...
          'explicit_period', 'on', ...
          'Position', [570 60 605 78]);

  reuse_block(blk, 'Counter1', 'xbsIndex_r4/Counter', ...
          'n_bits', 'FFTSize', ...
          'rst', 'on', ...
          'en', en, ...
          'explicit_period', 'off', ...
          'use_rpm', 'on', ...
          'Position', [570 91 605 127]);

  reuse_block(blk, 'Relational1', 'xbsIndex_r4/Relational', ...
          'mode', 'a<=b', ...
          'Position', [625 49 670 129]);

  reuse_block(blk, 'Convert1', 'xbsIndex_r4/Convert', ...
          'arith_type', 'Unsigned', ...
          'n_bits', '1', ...
          'bin_pt', '0', ...
          'Position', [690 77 720 101]);

  reuse_block(blk, 'barrel_switcher1', 'casper_library_reorder/barrel_switcher', ...
          'n_inputs', '1', 'async', async, ...
          'Position', [740 61 830 274]);
  
  add_line(blk,'reorder/1','Counter1/1');
  add_line(blk,'reorder/1','barrel_switcher1/2');
  add_line(blk,'reorder/3','barrel_switcher1/3');
  add_line(blk,'reorder1/3','barrel_switcher1/4');
  add_line(blk,'Constant2/1','Relational1/1');
  add_line(blk,'Counter1/1','Relational1/2');
  add_line(blk,'Relational1/1','Convert1/1');
  add_line(blk,'Convert1/1','barrel_switcher1/1');

  %
  % output ports
  %

  reuse_block(blk, 'pol1', 'built-in/Outport', ...
          'Port', '1', ...
          'Position', [875 148 905 162]);
  add_line(blk,'barrel_switcher1/2','pol1/1');

  reuse_block(blk, 'pol2', 'built-in/Outport', ...
          'Port', '2', ...
          'Position', [875 203 905 217]);
  add_line(blk,'barrel_switcher1/3','pol2/1');

  reuse_block(blk, 'sync_out', 'built-in/Outport', ...
          'Port', '3', ...
          'Position', [875 93 905 107]);
  add_line(blk,'barrel_switcher1/1','sync_out/1');

  if strcmp(async, 'on'),
    add_line(blk, 'barrel_switcher/4', 'reorder/2');
    add_line(blk, 'barrel_switcher/4', 'reorder1/2');

    add_line(blk, 'reorder/2', 'Counter1/2');
    add_line(blk, 'reorder1/2', 'barrel_switcher1/5');

    reuse_block(blk, 'dvalid', 'built-in/Outport', ...
            'Port', '4', ...
            'Position', [875 258 905 272]);
    add_line(blk,'barrel_switcher1/4','dvalid/1');

  else,
    reuse_block(blk, 'T1', 'built-in/Terminator', ...
      'Position', [535 215 555 235]);
    add_line(blk, 'reorder1/2', 'T1/1');

    reuse_block(blk, 'T2', 'built-in/Terminator', ...
      'Position', [535 125 555 145]);
    add_line(blk, 'reorder/2', 'T2/1');
    
    reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', ...
            'n_bits', '1', ...
            'bin_pt', '0', ...
            'explicit_period', 'on', ...
            'Position', [295 325 335 345]);
    add_line(blk, 'Constant/1', 'reorder/2');
    add_line(blk, 'Constant/1', 'reorder1/2');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});

end %function
