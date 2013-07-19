%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
%                                                                             %
%   MeerKAT Radio Telescope Project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2013 Andrew Martens (meerKAT)                               %
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

function fir_tap_init(blk, varargin)

  defaults = {};
  check_mask_type(blk, 'fir_tap');
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  factor          = get_var('factor','defaults', defaults, varargin{:});
  latency         = get_var('latency','defaults', defaults, varargin{:});
  coeff_bit_width = get_var('coeff_bit_width','defaults', defaults, varargin{:});
  coeff_bin_pt    = get_var('coeff_bin_pt','defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state in library
  if coeff_bit_width == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  
    return; 
  end

  reuse_block(blk, 'a', 'built-in/Inport');
  set_param([blk,'/a'], ...
          'Port', '1', ...
          'Position', '[205 68 235 82]');

  reuse_block(blk, 'b', 'built-in/Inport');
  set_param([blk,'/b'], ...
          'Port', '2', ...
          'Position', '[205 158 235 172]');

  reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant');
  set_param([blk,'/Constant'], ...
          'const', 'factor', ...
          'n_bits', 'coeff_bit_width', ...
          'bin_pt', 'coeff_bin_pt', ...
          'explicit_period', 'on', ...
          'Position', '[25 36 150 64]');

  reuse_block(blk, 'Mult0', 'xbsIndex_r4/Mult');
  set_param([blk,'/Mult0'], ...
          'n_bits', '18', ...
          'bin_pt', '17', ...
          'latency', 'latency', ...
          'use_behavioral_HDL', 'on', ...
          'use_rpm', 'off', ...
          'placement_style', 'Rectangular shape', ...
          'Position', '[280 37 330 88]');

  reuse_block(blk, 'Mult1', 'xbsIndex_r4/Mult');
  set_param([blk,'/Mult1'], ...
          'n_bits', '18', ...
          'bin_pt', '17', ...
          'latency', 'latency', ...
          'use_behavioral_HDL', 'on', ...
          'use_rpm', 'off', ...
          'placement_style', 'Rectangular shape', ...
          'Position', '[280 127 330 178]');

  reuse_block(blk, 'Register0', 'xbsIndex_r4/Register');
  set_param([blk,'/Register0'], ...
          'Position', '[410 86 455 134]');

  reuse_block(blk, 'Register1', 'xbsIndex_r4/Register');
  set_param([blk,'/Register1'], ...
          'Position', '[410 181 455 229]');

  reuse_block(blk, 'a_out', 'built-in/Outport');
  set_param([blk,'/a_out'], ...
          'Port', '1', ...
          'Position', '[495 103 525 117]');

  reuse_block(blk, 'b_out', 'built-in/Outport');
  set_param([blk,'/b_out'], ...
          'Port', '2', ...
          'Position', '[495 198 525 212]');

  reuse_block(blk, 'real', 'built-in/Outport');
  set_param([blk,'/real'], ...
          'Port', '3', ...
          'Position', '[355 58 385 72]');

  reuse_block(blk, 'imag', 'built-in/Outport');
  set_param([blk,'/imag'], ...
          'Port', '4', ...
          'Position', '[355 148 385 162]');

  add_line(blk,'b/1','Mult1/2', 'autorouting', 'on');
  add_line(blk,'b/1','Register1/1', 'autorouting', 'on');
  add_line(blk,'a/1','Mult0/2', 'autorouting', 'on');
  add_line(blk,'a/1','Register0/1', 'autorouting', 'on');
  add_line(blk,'Constant/1','Mult1/1', 'autorouting', 'on');
  add_line(blk,'Constant/1','Mult0/1', 'autorouting', 'on');
  add_line(blk,'Mult0/1','real/1', 'autorouting', 'on');
  add_line(blk,'Mult1/1','imag/1', 'autorouting', 'on');
  add_line(blk,'Register0/1','a_out/1', 'autorouting', 'on');
  add_line(blk,'Register1/1','b_out/1', 'autorouting', 'on');

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});

end % fir_tap_init

