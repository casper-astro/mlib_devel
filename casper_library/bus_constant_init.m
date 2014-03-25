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

function bus_constant_init(blk, varargin)
  log_group = 'bus_constant_init_debug';

  clog('entering bus_constant_init', {log_group, 'trace'});
  defaults = { ...
    'values', [1 1 1], ...
    'n_bits', [8 8 1], ...
    'bin_pts', [7 0 0], ...
    'types', [1 0 2]};
  
  check_mask_type(blk, 'bus_constant');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end %if
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  con_w = 100; con_d = 25;
  bus_create_w = 80;

  values        = get_var('values', 'defaults', defaults, varargin{:});
  n_bits        = get_var('n_bits', 'defaults', defaults, varargin{:});
  bin_pts       = get_var('bin_pts', 'defaults', defaults, varargin{:});
  types         = get_var('types', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if isempty(values),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_constant_init', {log_group, 'trace'});
    return;
  end %if

  lenv = length(values); lenb = length(n_bits); lenp = length(bin_pts); lent = length(types);
  in = [lenv, lenb, lenp, lent];  

  comps = unique(in);
  %if have more than 2 unique components or have two but one isn't 1
  if ((length(comps) > 2) | (length(comps) == 2 && comps(1) ~= 1)),
    clog('conflicting component sizes',{log_group, 'error'});
    return;
  end %if
  
  comp_in = max(in);

  %replicate items if needed for a input
  values    = repmat(values, 1, comp_in/lenv);
  n_bits    = repmat(n_bits, 1, comp_in/lenb);
  bin_pts   = repmat(bin_pts, 1, comp_in/lenp);
  types     = repmat(types, 1, comp_in/lent);
  
  len = length(n_bits);

  ypos_tmp = ypos + yinc/2;
  xpos = xpos + con_w/2;
  
  %constant layer
  for index = 1:len,
    if types(index) == 0, arith_type = 'Unsigned';
    elseif types(index) == 1, arith_type = 'Signed (2''s comp)';
    elseif types(index) == 2, arith_type = 'Boolean';
    end

    reuse_block(blk, ['constant', num2str(index-1)], 'xbsIndex_r4/Constant', ...
      'const', num2str(values(index)), 'arith_type', arith_type, ...
      'n_bits', num2str(n_bits(index)), 'bin_pt', num2str(bin_pts(index)), ...
      'explicit_period', 'on', 'period', '1', ... 
      'Position', [xpos-con_w/2 ypos_tmp-con_d/2 xpos+con_w/2 ypos_tmp+con_d/2]);
    
    ypos_tmp = ypos_tmp + yinc;
  end %for 

  xpos = xpos + xinc + con_w/2;
 
  %create bus
  ypos_tmp = ypos + yinc*len/2;
  xpos = xpos + bus_create_w/2;

  reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(len), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-yinc*len/2 xpos+bus_create_w/2 ypos_tmp+yinc*len/2]);
  
  for index = 0:len-1,
    add_line(blk, ['constant',num2str(index),'/1'], ['bus_create/',num2str(index+1)]);
  end %for
  
  xpos = xpos + xinc + bus_create_w/2;

  %output port/s
  xpos = xpos + port_w/2;
  ypos_tmp = ypos + yinc*len/2;
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bus_create/1'], ['dout/1']);
  ypos_tmp = ypos_tmp + yinc + port_d/2;  

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_constant_init', {log_group, 'trace'});

end %function bus_constant_init


