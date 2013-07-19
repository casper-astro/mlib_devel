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

function rcmult_init(blk, varargin)

  defaults = {};
  check_mask_type(blk, 'rcmult');
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  latency = get_var('latency','defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state in library
  if latency == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  
    return; 
  end

  reuse_block(blk, 'd', 'built-in/Inport');
  set_param([blk,'/d'], ...
          'Port', '1', ...
          'Position', '[15 33 45 47]');

  reuse_block(blk, 'sin', 'built-in/Inport');
  set_param([blk,'/sin'], ...
          'Port', '2', ...
          'Position', '[75 138 105 152]');

  reuse_block(blk, 'cos', 'built-in/Inport');
  set_param([blk,'/cos'], ...
          'Port', '3', ...
          'Position', '[75 58 105 72]');

  reuse_block(blk, 'Mult0', 'xbsIndex_r4/Mult');
  set_param([blk,'/Mult0'], ...
          'n_bits', '8', ...
          'bin_pt', '2', ...
          'latency', 'latency', ...
          'use_rpm', 'off', ...
          'placement_style', 'Rectangular shape', ...
          'Position', '[160 27 210 78]');

  reuse_block(blk, 'Mult1', 'xbsIndex_r4/Mult');
  set_param([blk,'/Mult1'], ...
          'n_bits', '8', ...
          'bin_pt', '2', ...
          'latency', 'latency', ...
          'use_rpm', 'off', ...
          'placement_style', 'Rectangular shape', ...
          'Position', '[160 107 210 158]');

  reuse_block(blk, 'real', 'built-in/Outport');
  set_param([blk,'/real'], ...
          'Port', '1', ...
          'Position', '[235 48 265 62]');

  reuse_block(blk, 'imag', 'built-in/Outport');
  set_param([blk,'/imag'], ...
          'Port', '2', ...
          'Position', '[235 128 265 142]');

  add_line(blk,'cos/1','Mult0/2', 'autorouting', 'on');
  add_line(blk,'sin/1','Mult1/2', 'autorouting', 'on');
  add_line(blk,'d/1','Mult1/1', 'autorouting', 'on');
  add_line(blk,'d/1','Mult0/1', 'autorouting', 'on');
  add_line(blk,'Mult0/1','real/1', 'autorouting', 'on');
  add_line(blk,'Mult1/1','imag/1', 'autorouting', 'on');

  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});
end % rcmult_init

