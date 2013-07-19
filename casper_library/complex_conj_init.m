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

function complex_conj_init(blk, varargin)

  clog('entering complex_conj_init', {'trace', 'complex_conj_init_debug'});

  % Set default vararg values.
  defaults = { ...
    'n_inputs', 1, ...
    'n_bits', 18, ...
    'bin_pt', 17, ...
    'latency', 1, ...
    'overflow', 'Wrap', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'complex_conj');
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
  n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
  bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});
  latency = get_var('latency', 'defaults', defaults, varargin{:});
  overflow = get_var('overflow', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default setup for library
  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting complex_conj_init',{'trace','complex_conj_init_debug'});
    return;
  end
  
  reuse_block(blk, 'z', 'built-in/Inport', 'Port', '1', 'Position', [10 92 40 108]);

  %move real and imaginary parts from multiple streams to be next to each other
  reuse_block(blk, 'munge_in', 'casper_library_flow_control/munge', ...
          'divisions', num2str(2*n_inputs), ...
          'div_size', mat2str(repmat(n_bits, 1, 2*n_inputs)), ...
          'order', mat2str([[0:2:(n_inputs-1)*2],[1:2:(n_inputs-1)*2+1]]), ...
          'Position', [70 87 110 113]);
  add_line(blk,'z/1','munge_in/1');

  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', 'outputNum', '2', 'outputWidth', num2str(n_bits*n_inputs), ...
          'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
          'Position', [140 52 190 148]);
  add_line(blk,'munge_in/1','bus_expand/1');

  reuse_block(blk, 'real_delay', 'xbsIndex_r4/Delay', ...
          'latency', num2str(latency), 'Position', [230 59 290 91]);
  add_line(blk,'bus_expand/1','real_delay/1');

  if strcmp(overflow, 'Wrap'), of = '0';
  elseif strcmp(overflow, 'Saturate'), of = '1';
  elseif strcmp(overflow, 'Flag as error'), of = '2';
  else %TODO
  end

  reuse_block(blk, 'imag_negate', 'casper_library_bus/bus_negate', ...
          'n_bits_in', mat2str(repmat(n_bits, 1, n_inputs)), 'bin_pt_in', num2str(bin_pt), ...
          'cmplx', 'off', 'overflow', of, 'misc', 'off', 'latency', num2str(latency), ... 
          'Position', [230 109 290 141]);
  add_line(blk,'bus_expand/2','imag_negate/1');

  reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
          'inputNum', '2', 'Position', [330 51 380 149]);
  add_line(blk,'real_delay/1','bus_create/1');
  add_line(blk,'imag_negate/1','bus_create/2');

  % move real and imaginary parts from multiple streams back
  reuse_block(blk, 'munge_out', 'casper_library_flow_control/munge', ...
          'divisions', num2str(n_inputs*2), ...
          'div_size', mat2str(repmat(n_bits, 1, n_inputs*2)), ...
          'order', mat2str(reshape([[0:(n_inputs-1)];[n_inputs:(n_inputs*2)-1]], 1, n_inputs*2)), ...
          'Position', [410 87 450 113]);
  add_line(blk,'bus_create/1','munge_out/1');

  reuse_block(blk, 'z*', 'built-in/Outport', 'Port', '1', 'Position', [480 92 510 108]);
  add_line(blk,'munge_out/1','z*/1');
  
  % Delete all unconnected blocks.
  clean_blocks(blk);

  % Save block state to stop repeated init script runs.
  save_state(blk, 'defaults', defaults, varargin{:});

  clog('exiting complex_conj_init',{'trace','complex_conj_init_debug'});

end %complex_conj_init
