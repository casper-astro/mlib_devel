% Create adder trees to sum components of multiple identical busses
%
% bus_adder_tree_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% n_busses = Number of busses
% n_bits = Number of bits for each bus component 
% bin_pts = Binary point position for each bus component
% dtypes = Data types for every bus component (0 = unsigned, 1 = signed)
% add_latency = Latency per adder
% first_stage_hdl = Implement first adder stage in adder trees as HDL
% adder_imp = Default adder implementation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   MeerKAT radio telescope                                                   %
%   www.ska.ac.za                                                             %
%   Copyright (C) 2016 Andrew Martens                                         %
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

function bus_adder_tree_init(blk, varargin)

  log_group = 'bus_adder_tree_init_debug';

  clog('entering bus_adder_tree_init', {log_group, 'trace'});
  defaults = {
    'n_busses', 5, ...
    'n_bits', [8 7 3 4], 'bin_pts', [6 6 2 2], 'dtypes', [0 1 0 1], ...
    'add_latency', 1, 'first_stage_hdl', 'off', 'adder_imp', 'Fabric', ...
    'misc', 'on'};
  
  check_mask_type(blk, 'bus_adder_tree');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_busses        = get_var('n_busses', 'defaults', defaults, varargin{:});
  n_bits          = get_var('n_bits', 'defaults', defaults, varargin{:});
  bin_pts         = get_var('bin_pts', 'defaults', defaults, varargin{:});
  dtypes          = get_var('dtypes', 'defaults', defaults, varargin{:});
  add_latency     = get_var('add_latency', 'defaults', defaults, varargin{:});
  first_stage_hdl = get_var('first_stage_hdl', 'defaults', defaults, varargin{:});
  adder_imp       = get_var('adder_imp', 'defaults', defaults, varargin{:});
  misc            = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if n_busses == 0 | n_busses == 1,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_adder_tree_init', {log_group, 'trace'});
    return;
  end
  
  lenb = length(n_bits); lenbp = length(bin_pts); lend = length(dtypes);
  comps = unique([lenb, lenbp, lend]);
  %if have more than 2 unique components or have two but one isn't 1
  if ((length(comps) > 2) | (length(comps) == 2 && comps(1) ~= 1)),
    clog('conflicting component sizes',{log_group, 'error'});
    return;
  end  
  
  ncomps = max([lenb, lenbp, lend]);	
  n_bits    = repmat(n_bits, 1, ncomps/lenb);
  bin_pts   = repmat(bin_pts, 1, ncomps/lenbp);
  dtypes    = repmat(dtypes, 1, ncomps/lend);

  xpos = 50; xinc = 50;
  ypos = 50; yinc = 60;
  port_w = 30; port_d = 14;
  
  addt_d = 20*n_busses; addt_w = 60;
  bus_expand_d = 20*ncomps; bus_expand_w = 60;
  bus_create_d = 20*ncomps; bus_create_w = 60;

  del_w = 30; del_d = 20;

  con_w = 30; con_d = 20;

  max_depth = max([n_busses*(bus_expand_d+yinc), ncomps*(addt_d+yinc)]);

  %%%%%%%%%%%%%%%%%%%%
  % input port layer %
  %%%%%%%%%%%%%%%%%%%%

  clog('drawing input ports', {log_group, 'trace'});
  
  ypos_tmp = ypos + bus_expand_d/2;	
  for n = 0:n_busses-1, 
    reuse_block(blk, ['d',num2str(n)], 'built-in/inport', ...
      'Port', num2str(n+1), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + bus_expand_d + yinc;
  end %for

  if strcmp(misc, 'on'),
    ypos_tmp = ypos + max_depth;
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', num2str(n_busses+1), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%%%%%%%%%%%%
  % data bus expand layer %
  %%%%%%%%%%%%%%%%%%%%%%%%%

  xpos = xpos + bus_expand_w/2;  
  ypos_tmp = ypos + bus_expand_d/2;

  clog('drawing bus expand blocks', {log_group, 'trace'});

  % one bus_expand block for each input
  for n = 0:n_busses-1,
    reuse_block(blk, ['expand', num2str(n)], 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of arbitrary size', ...
      'outputWidth', mat2str(n_bits), ...
      'outputBinaryPt', mat2str(bin_pts), ...
      'outputArithmeticType', mat2str(dtypes), ...
      'show_format', 'on', 'outputToWorkspace', 'off', ...
      'variablePrefix', '', 'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-bus_expand_d/2 xpos+bus_expand_w/2 ypos_tmp+bus_expand_d/2]);
    add_line(blk, ['d', num2str(n), '/1'], ['expand', num2str(n), '/1']);
    ypos_tmp = ypos_tmp + bus_expand_d + yinc;
  end %for

  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%%%%%%%
  % adder_tree layer %
  %%%%%%%%%%%%%%%%%%%%

  clog('drawing adder tree blocks', {log_group, 'trace'});

  xpos = xpos + xinc + con_w/2;
  ypos_tmp = ypos;

  reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
    'const', '0', 'arith_type', 'Boolean', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [xpos-con_w/2 ypos_tmp-con_d/2 xpos+con_w/2 ypos_tmp+con_d/2]);

  xpos = xpos + 2*xinc + con_w/2;

  xpos = xpos + addt_w/2;
  ypos_tmp = ypos + addt_d/2;

  for n = 0:ncomps-1,
    reuse_block(blk, ['add_tree', num2str(n)], 'casper_library/Misc/adder_tree', ...
      'n_inputs', num2str(n_busses), 'latency', num2str(add_latency), ...
      'adder_imp', adder_imp, 'first_stage_hdl', first_stage_hdl, ...
      'Position', [xpos-addt_w/2 ypos_tmp-addt_d/2 xpos+addt_w/2 ypos_tmp+addt_d/2]);
  
    add_line(blk, 'constant/1', ['add_tree', num2str(n), '/1']);

    for m = 0:n_busses-1, 
      add_line(blk, ['expand', num2str(m), '/', num2str(n+1)], ['add_tree', num2str(n), '/', num2str(m+2)]);
    end
   
    ypos_tmp = ypos_tmp + addt_d + yinc;
  end

  if strcmp(misc, 'on'),
    ypos_tmp = ypos + max_depth;
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', num2str(add_latency * ceil(log2(n_busses))), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
    ypos_tmp = ypos_tmp + del_d/2 + yinc;
  end

  xpos = xpos + addt_w/2 + xinc;

  %%%%%%%%%%%%%%%%%%%%%%%
  % bus creation layer  %
  %%%%%%%%%%%%%%%%%%%%%%%

  xpos = xpos + bus_create_w/2;
  ypos_tmp = ypos + bus_create_d/2;

  clog('drawing bus create blocks', {log_group, 'trace'});

  reuse_block(blk, 'd_bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(ncomps), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-bus_create_d/2 xpos+bus_create_w/2 ypos_tmp+bus_create_d/2]);

  for m = 0:ncomps-1,
    add_line(blk, ['add_tree',num2str(m), '/2'], ['d_bussify/', num2str(m+1)])
  end %for
 
  xpos = xpos + bus_create_w/2 + xinc;

  %%%%%%%%%%%%%%%%%%%%%
  % output port layer %
  %%%%%%%%%%%%%%%%%%%%%

  xpos = xpos + port_w/2;
  ypos_tmp = ypos + bus_create_d/2;
  
  clog('drawing output ports', {log_group, 'trace'});

  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, 'd_bussify/1', 'out/1');

  if strcmp(misc, 'on'),
    ypos_tmp = ypos + max_depth;
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  %%%%%%%%%%%%
  % clean up %
  %%%%%%%%%%%%

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_adder_tree_init', {log_group, 'trace'});

end %function bus_adder_tree_init
