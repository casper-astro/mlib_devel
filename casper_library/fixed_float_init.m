%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew van der Byl (avanderbyl@ska.ac.za)                      %
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


function fixed_float_init(blk, varargin)
  clog('entering fixed_float_init', 'trace');
  
  defaults = { ...
    'float_type', 'single', ...
    'exp_width', 8, ...
    'frac_width', 24, ...      
    'n_bits_in', 18, ...
    'bin_pt', 17, ...
    'num_vec', 1, ...
    'cmplx', 'off', ...
    'csp_latency', 0, ...
  };
  
  check_mask_type(blk, 'fixed_to_float');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  rep_w = 50; rep_d = 30;
  bus_expand_w = 50;
  bus_create_w = 50;
  mult_w = 50; mult_d = 60;
  del_w = 30; del_d = 20;
  
  float_type     = get_var('float_type', 'defaults', defaults, varargin{:});
  exp_width      = get_var('exp_width', 'defaults', defaults, varargin{:});
  frac_width     = get_var('frac_width', 'defaults', defaults, varargin{:});      
  n_bits_in      = get_var('n_bits_in', 'defaults', defaults, varargin{:});
  bin_pt         = get_var('bin_pt', 'defaults', defaults, varargin{:});
  num_vec        = get_var('num_vec', 'defaults', defaults, varargin{:});
  cmplx          = get_var('cmplx', 'defaults', defaults, varargin{:});
  latency          = get_var('csp_latency', 'defaults', defaults, varargin{:});
  
  delete_lines(blk);
 

  if float_type == 2
      float_type_sel = 'custom';

  else
      float_type_sel = 'single';
      exp_width = 8;
      frac_width = 24;
  end
  
  
   %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos;
  reuse_block(blk, 'in', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);


  xpos = xpos + xinc + port_w/2;  

  
  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + mult_d; %reset ypos

  if strcmp(cmplx, 'on')
    outputWidth           = mat2str((exp_width+frac_width)*2);
    outputBinaryPt        = mat2str(0);
    outputArithmeticType  = mat2str(0);  
  else
    outputWidth           = mat2str(exp_width+frac_width);
    outputBinaryPt        = mat2str(0);
    outputArithmeticType  = mat2str(0);


  reuse_block(blk, 'debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', ...
    'outputNum', num2str(num_vec), ...
    'outputWidth', num2str(n_bits_in), ...
    'outputBinaryPt', num2str(bin_pt), 'outputArithmeticType', '1', ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos ypos xpos+bus_expand_w/2 ypos_tmp/2]);
  add_line(blk, 'in/1', 'debus/1');

  reuse_block(blk, 'floatbus', 'casper_library_flow_control/bus_create', ...
   'inputNum', num2str(num_vec), ...
   'Position', [xpos-bus_create_w/2 ypos_tmp-mult_d*1/2 xpos+bus_create_w/2 ypos_tmp+mult_d*1/2]);

  
  for index = 1:num_vec
      convert_name = ['conv',num2str(index)];

      reuse_block(blk, convert_name, 'xbsIndex_r4/Convert', ...
      'arith_type', 'Floating-Point', ...
      'float_type', float_type_sel, ...
      'exp_bits', num2str(exp_width), ...
      'fraction_bits', num2str(frac_width), ...
      'latency', num2str(latency),...
      'Position', [750 100 785 120]);     
      
      add_line(blk, ['debus','/',num2str(index)], [convert_name,'/1' ]);
      add_line(blk, [convert_name,'/1' ], ['floatbus/',num2str(index)]);
  
  end

  
  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  
  add_line(blk, ['floatbus/1'], ['out/1']);
  
  
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting fixed_float_init','trace');

end % pfb_fir_taps_init

