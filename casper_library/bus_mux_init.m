%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens (andrew@ska.ac.za)                      %
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

function bus_mux_init(blk, varargin)
  log_group = 'bus_mux_init_debug';

  clog('entering bus_mux_init', {log_group, 'trace'});
  defaults = {
    'n_inputs', 1, ...
    'n_bits', [8 7 3 4], ...
    'mux_latency', 0, ...
    'cmplx', 'off', ...
    'misc', 'off'};
  
  check_mask_type(blk, 'bus_mux');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 150;
  ypos = 50; yinc = 60;

  port_w = 30; port_d = 14;
  muxi_d = 30;
  bus_expand_w = 60;
  bus_create_w = 60;
  mux_w = 50;
  del_w = 30; del_d = 20;

  n_inputs      = get_var('n_inputs', 'defaults', defaults, varargin{:});
  n_bits        = get_var('n_bits', 'defaults', defaults, varargin{:});
  mux_latency   = get_var('mux_latency', 'defaults', defaults, varargin{:});
  misc          = get_var('misc', 'defaults', defaults, varargin{:});
  cmplx         = get_var('cmplx', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_mux_init', {log_group, 'trace'});
    return;
  end
  
  len = length(n_bits);
  if strcmp(cmplx, 'on'), n_bits = 2*n_bits; end

  % the mux depth depends on
  % whether splitting one input, or many
  if n_inputs == 1, depth = muxi_d*len;
  else, depth = muxi_d*n_inputs;
  end

  % if doing one, number muxes == 1, otherwise == number of elements
  if n_inputs == 1, n_muxes = 1;
  else, n_muxes = len;
  end

  %%%%%%%%%%%%%%%%%%%%
  % input port layer %
  %%%%%%%%%%%%%%%%%%%%

  xpos = xpos + port_w/2;
  ypos_tmp = ypos + (n_muxes*muxi_d)/2;  

  reuse_block(blk, 'sel', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
 
  % for the data ports, if only one input then are to mux between separate components of the same
  % bus, otherwise are to mux between components of separate busses
  ypos_tmp = ypos_tmp + (n_muxes*muxi_d)/2 + yinc;

  for n = 0:n_inputs-1, 
    ypos_tmp = ypos_tmp + depth/2;
    reuse_block(blk, ['d',num2str(n)], 'built-in/inport', ...
      'Port', num2str(n+2), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + depth/2 + yinc;
  end %for

  if strcmp(misc, 'on'),
    ypos_tmp = ypos + (yinc + (n_muxes*muxi_d)) + max(n_muxes, n_inputs)*(depth + yinc) + del_d/2;
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', num2str(n_inputs+2), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%%%%%%%%%%%%
  % data bus expand layer %
  %%%%%%%%%%%%%%%%%%%%%%%%%

  if n_inputs == 1, inputs = len;
  else, inputs = n_inputs;
  end

  xpos = xpos + bus_expand_w/2;  
  ypos_tmp = ypos + (n_muxes*muxi_d)/2;

  % one bus_expand for sel input
  reuse_block(blk, 'sel_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', ...
    'outputNum', num2str(n_muxes), ...
    'outputWidth', num2str(ceil(log2(inputs))), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-(n_muxes*muxi_d)/2 xpos+bus_expand_w/2 ypos_tmp+(n_muxes*muxi_d)/2]);
  add_line(blk, 'sel/1', 'sel_expand/1');

  ypos_tmp = ypos_tmp + (n_muxes*muxi_d)/2 + yinc;

  % one bus_expand block for each input
  for n = 0:n_inputs-1,
    ypos_tmp = ypos_tmp + depth/2;
    reuse_block(blk, ['expand', num2str(n)], 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of arbitrary size', ...
      'outputWidth', mat2str(n_bits), ...
      'outputBinaryPt', ['[',num2str(zeros(1, length(n_bits))),']'], ...
      'outputArithmeticType', ['[',num2str(zeros(1, length(n_bits))),']'], ...
      'show_format', 'on', 'outputToWorkspace', 'off', ...
      'variablePrefix', '', 'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-depth/2 xpos+bus_expand_w/2 ypos_tmp+depth/2]);
    add_line(blk, ['d', num2str(n), '/1'], ['expand', num2str(n), '/1']);
    ypos_tmp = ypos_tmp + depth/2 + yinc;
  end %for

  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%
  % mux layer %
  %%%%%%%%%%%%%

  xpos = xpos + mux_w/2;
  ypos_tmp = ypos + (n_muxes*muxi_d) + yinc;

  for n = 0:n_muxes-1,
    ypos_tmp = ypos_tmp + depth/2;
    
    reuse_block(blk, ['mux', num2str(n)], 'xbsIndex_r4/Mux', ...
      'inputs', num2str(inputs), 'latency', num2str(mux_latency), ...
      'Position', [xpos-mux_w/2 ypos_tmp-depth/2 xpos+mux_w/2 ypos_tmp+depth/2]);
    
    add_line(blk, ['sel_expand/', num2str(n+1)], ['mux', num2str(n), '/1']);

    % take all mux inputs from single input
    if n_inputs == 1, 
      for index = 1:len, add_line(blk, ['expand0/',num2str(index)], ['mux0/',num2str(index+1)]);
      end %for
    %or take a mux input from each input
    else, 
      for in_index = 0:n_inputs-1, 
        add_line(blk, ['expand', num2str(in_index), '/', num2str(n+1)], ['mux',num2str(n), '/', num2str(in_index+2)])
      end
    end %if
    ypos_tmp = ypos_tmp + depth/2 + yinc;
  end %for n_muxes
  
  if strcmp(misc, 'on'),
    ypos_tmp = ypos + (yinc + (n_muxes*muxi_d)) + max(n_muxes, n_inputs)*(depth + yinc) + del_d/2;
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', num2str(mux_latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
    ypos_tmp = ypos_tmp + del_d/2 + yinc;
  end

  xpos = xpos + mux_w/2 + xinc;

  %%%%%%%%%%%%%%%%%%%%%%%
  % bus creation layer  %
  %%%%%%%%%%%%%%%%%%%%%%%

  xpos = xpos + bus_create_w/2;
  ypos_tmp = ypos + (n_muxes*muxi_d)/2;
 
  reuse_block(blk, 'd_bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(n_muxes), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-(n_muxes*muxi_d)/2 xpos+bus_create_w/2 ypos_tmp+(n_muxes*muxi_d)/2]);

  for n = 0:n_muxes-1,
    add_line(blk, ['mux', num2str(n), '/1'], ['d_bussify/', num2str(n+1)])
  end %for
 
  xpos = xpos + xinc + bus_create_w/2;

  %%%%%%%%%%%%%%%%%%%%%
  % output port layer %
  %%%%%%%%%%%%%%%%%%%%%

  xpos = xpos + port_w/2;
  ypos_tmp = ypos + (n_muxes*muxi_d)/2;

  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, 'd_bussify/1', 'out/1');
  ypos_tmp = ypos + (n_muxes*muxi_d)/2 + yinc;

  if strcmp(misc, 'on'),
    ypos_tmp = ypos + (yinc + (n_muxes*muxi_d)) + max(n_muxes, n_inputs)*(depth + yinc) + del_d/2;
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_mux_init', {log_group, 'trace'});

end %function bus_mux_init


