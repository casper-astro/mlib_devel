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

function lo_const_init(blk, varargin)

  defaults = {};
  check_mask_type(blk, 'lo_const');
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_bits = get_var('n_bits','defaults', defaults, varargin{:});
  phase = get_var('phase','defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state in library
  if n_bits == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  
    return; 
  end

  reuse_block(blk, 'const1', 'xbsIndex_r4/Constant');
  set_param([blk,'/const1'], ...
    'const', sprintf('-imag(exp(phase*1j))'), ...
    'n_bits', sprintf('n_bits'), ...
    'bin_pt', sprintf('n_bits - 1'), ...
    'explicit_period', sprintf('on'), ...
    'Position', sprintf('[145 37 205 63]'));

  reuse_block(blk, 'const', 'xbsIndex_r4/Constant');
  set_param([blk,'/const'], ...
    'const', sprintf('real(exp(phase*1j))'), ...
    'n_bits', sprintf('n_bits'), ...
    'bin_pt', sprintf('n_bits - 1'), ...
    'explicit_period', sprintf('on'), ...
    'Position', sprintf('[145 77 205 103]'));

  reuse_block(blk, 'sin', 'built-in/Outport');
  set_param([blk,'/sin'], ...
    'Port', sprintf('1'), ...
    'Position', sprintf('[235 48 265 62]'));

  reuse_block(blk, 'cos', 'built-in/Outport');
  set_param([blk,'/cos'], ...
    'Port', sprintf('2'), ...
    'Position', sprintf('[235 78 265 92]'));

  add_line(blk,'const1/1','sin/1', 'autorouting', 'on');
  add_line(blk,'const/1','cos/1', 'autorouting', 'on');

  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});
end % lo_const_init

