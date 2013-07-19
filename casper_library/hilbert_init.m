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

function hilbert_init(blk, varargin)

  clog('entering hilbert_init', {'trace', 'hilbert_init_debug'});

  % Set default vararg values.
  defaults = { ...
    'n_inputs', 1, ...
    'BitWidth', 18, ...
    'bin_pt_in', 'BitWidth-1', ...
    'add_latency', 1, ...
    'conv_latency', 1, ...
    'misc', 'off', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'hilbert');
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
  BitWidth = get_var('BitWidth', 'defaults', defaults, varargin{:});
  bin_pt_in = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
  conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
  misc = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default setup for library
  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting hilbert_init',{'trace','hilbert_init_debug'});
    return;
  end

  %
  % input ports
  %

  reuse_block(blk, 'a', 'built-in/Inport', 'Port', '1', 'Position', [25 48 55 62]);
  reuse_block(blk, 'b', 'built-in/Inport', 'Port', '2', 'Position', [25 198 55 212]);

  %
  % rearrange real and imaginary parts of inputs
  %

  reuse_block(blk, 'munge_a', 'casper_library_flow_control/munge', 'Position', [80 37 120 73]);
  reuse_block(blk, 'munge_b', 'casper_library_flow_control/munge', 'Position', [80 187 120 223]);
  
  for name = {'munge_a', 'munge_b'},
    set_param([blk, '/', name{1}], ...
          'divisions', num2str(2*n_inputs), ...
          'div_size', mat2str(repmat(BitWidth, 1, 2*n_inputs)), ...
          'order', mat2str([[0:2:(n_inputs-1)*2],[1:2:(n_inputs-1)*2+1]]));
  end

  add_line(blk,'b/1','munge_b/1');
  add_line(blk,'a/1','munge_a/1');

  %
  % separate real and imaginary parts
  %

  reuse_block(blk, 'bus_expand_a', 'casper_library_flow_control/bus_expand', 'Position', [140 29 190 76]);
  reuse_block(blk, 'bus_expand_b', 'casper_library_flow_control/bus_expand', 'Position', [140 179 190 226]);

  for name = {'bus_expand_a', 'bus_expand_b'},
    set_param([blk, '/', name{1}], ...
          'mode', 'divisions of equal size', ...
          'outputNum', '2', 'OutputWidth', num2str(BitWidth*n_inputs), ...
          'outputBinaryPt', '0', 'outputArithmeticType', '0');
  end
  add_line(blk,'munge_a/1','bus_expand_a/1');
  add_line(blk,'munge_b/1','bus_expand_b/1');

  %
  % do the addition and subtraction
  %

  reuse_block(blk, 'add_even_real', 'casper_library_bus/bus_addsub', 'opmode', '0', 'Position', [255 29 300 76]);
  reuse_block(blk, 'sub_odd_imag', 'casper_library_bus/bus_addsub', 'opmode', '1', 'Position', [255 104 300 151]);
  reuse_block(blk, 'sub_even_imag', 'casper_library_bus/bus_addsub', 'opmode', '1', 'Position', [255 179 300 226]);
  reuse_block(blk, 'add_odd_real', 'casper_library_bus/bus_addsub', 'opmode', '0', 'Position', [255 254 300 301]);

  for name = {'add_even_real', 'sub_odd_imag', 'sub_even_imag', 'add_odd_real'};
    set_param([blk,'/',name{1}], ...
          'n_bits_a', mat2str(repmat(BitWidth, 1, n_inputs)), 'bin_pt_a', num2str(bin_pt_in), 'type_a', '1', ...
          'n_bits_b', mat2str(repmat(BitWidth, 1, n_inputs)), 'bin_pt_b', num2str(bin_pt_in), 'type_b', '1', ...
          'n_bits_out', mat2str(repmat(BitWidth+1, 1, n_inputs)), 'bin_pt_out', num2str(bin_pt_in), 'type_out', '1', ...
          'cmplx', 'off', 'misc', 'off', 'latency', 'add_latency', ...
          'quantization', '0', 'overflow', '0');
  end

  add_line(blk,'bus_expand_a/1','add_even_real/1');
  add_line(blk,'bus_expand_b/1','add_even_real/2');
  add_line(blk,'bus_expand_a/1','sub_odd_imag/2');
  add_line(blk,'bus_expand_b/1','sub_odd_imag/1');
  add_line(blk,'bus_expand_a/2','sub_even_imag/1');
  add_line(blk,'bus_expand_b/2','sub_even_imag/2');
  add_line(blk,'bus_expand_a/2','add_odd_real/1');
  add_line(blk,'bus_expand_b/2','add_odd_real/2');
  
  % 
  % join components for common operations
  %

  reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', 'num_inputs', '4', 'Position', [330 20 360 315]);
  add_line(blk,'add_even_real/1','Concat/1');
  add_line(blk,'sub_odd_imag/1','Concat/2');
  add_line(blk,'sub_even_imag/1','Concat/3');
  add_line(blk,'add_odd_real/1','Concat/4');

  reuse_block(blk, 'bus_scale', 'casper_library_bus/bus_scale', ...
          'n_bits_in', mat2str(repmat(BitWidth+1, 1, n_inputs*4)), 'bin_pt_in', 'bin_pt_in', 'type_in', '1', ...
          'scale_factor', '-1', 'misc', 'off', 'cmplx', 'off', ...
          'Position', [380 156 420 184]);
  add_line(blk,'Concat/1','bus_scale/1');

  reuse_block(blk, 'bus_convert', 'casper_library_bus/bus_convert', ...
          'n_bits_in', mat2str(repmat(BitWidth+1, 1, n_inputs*4)), 'bin_pt_in', 'bin_pt_in+1', ...
          'n_bits_out', num2str(BitWidth), 'bin_pt_out', 'bin_pt_in', ...
          'quantization', '2', 'overflow', '0', ... %TODO Wrap for overflow?  
          'cmplx', 'off', 'of', 'off', 'latency', 'conv_latency', 'misc', 'off', ...
          'Position', [440 156 480 184]);
  add_line(blk,'bus_scale/1','bus_convert/1');

  %
  % separate components so can put in correct place
  %

  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', ...
          'outputNum', '4', 'OutputWidth', num2str(BitWidth*n_inputs), ...
          'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
          'Position', [505 107 555 233]);
  add_line(blk,'bus_convert/1','bus_expand/1');

  reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', 'Position', [605 114 645 156]);
  add_line(blk,'bus_expand/3','ri_to_c/2');
  add_line(blk,'bus_expand/1','ri_to_c/1');

  reuse_block(blk, 'ri_to_c1', 'casper_library_misc/ri_to_c', 'Position', [605 204 645 246]);
  add_line(blk,'bus_expand/2','ri_to_c1/2');
  add_line(blk,'bus_expand/4','ri_to_c1/1');

  %
  % reorder outputs so that real and imaginary parts are interspersed 
  %

  reuse_block(blk, 'munge_even', 'casper_library_flow_control/munge', ...
          'Position', [670 117 710 153]);

  reuse_block(blk, 'munge_odd', 'casper_library_flow_control/munge', ...
          'Position', [670 207 710 243]);

  for name = {'munge_even', 'munge_odd'},
    set_param([blk, '/', name{1}], ...
          'divisions', num2str(n_inputs*2), ...
          'div_size', mat2str(repmat(BitWidth, 1, n_inputs*2)), ...
          'order', mat2str(reshape([[0:(n_inputs-1)];[n_inputs:(n_inputs*2)-1]], 1, n_inputs*2)));
  end
  add_line(blk,'ri_to_c/1','munge_even/1');
  add_line(blk,'ri_to_c1/1','munge_odd/1');

  %
  % output ports
  %

  reuse_block(blk, 'even', 'built-in/Outport', ...
          'Port', sprintf('1'), ...
          'Position', sprintf('[735 128 765 142]'));
  add_line(blk,'munge_even/1','even/1');

  reuse_block(blk, 'odd', 'built-in/Outport', ...
          'Port', sprintf('2'), ...
          'Position', sprintf('[735 218 765 232]'));
  add_line(blk,'munge_odd/1','odd/1');

  %
  % miscellaneous input
  %

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/Inport', 'Port', '3', 'Position', [25 348 55 362]);

    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', 'add_latency+conv_latency', 'Position', [380 344 420 366]);
    add_line(blk,'misci/1', 'dmisc/1');
    
    reuse_block(blk, 'misco', 'built-in/Outport', 'Port', '3', 'Position', [735 348 765 362]);
    add_line(blk,'dmisc/1', 'misco/1');

  end


  % Delete all unconnected blocks.
  clean_blocks(blk);

  % Save block state to stop repeated init script runs.
  save_state(blk, 'defaults', defaults, varargin{:});
end % hilbert_init

