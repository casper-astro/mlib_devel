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

%TODO Dave's adder width optimisation

function pfb_fir_taps_init(blk, varargin)
  clog('entering pfb_fir_taps_init', 'trace');

  defaults = { ...
    'n_streams', 1, ...
    'n_inputs', 2, ...
    'pfb_size', 5, ...
    'n_taps', 4, ...
    'n_bits_data', 8, ...
    'n_bits_coeff', 12, ...
    'bin_pt_coeff', 11, ...
    'complex', 'off', ...
    'async', 'on', ...
    'mult_latency', 3, ...
    'add_latency', 2, ...
    'fan_latency', 2, ... 
    'bram_latency', 2, ...
    'multiplier_implementation', 'behavioral HDL', ... 'embedded multiplier core' 'standard core' ...
    'bram_optimization', 'Area', ... 'Speed', 'Area'
  };
  
  check_mask_type(blk, 'pfb_fir_taps');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_streams                   = get_var('n_streams', 'defaults', defaults, varargin{:});
  n_inputs                    = get_var('n_inputs', 'defaults', defaults, varargin{:});
  pfb_size                    = get_var('pfb_size', 'defaults', defaults, varargin{:});
  n_taps                      = get_var('n_taps', 'defaults', defaults, varargin{:});
  n_bits_data                 = get_var('n_bits_data', 'defaults', defaults, varargin{:});
  n_bits_coeff                = get_var('n_bits_coeff', 'defaults', defaults, varargin{:});
  bin_pt_coeff                = get_var('bin_pt_coeff', 'defaults', defaults, varargin{:});
  complex                     = get_var('complex', 'defaults', defaults, varargin{:});
  async                       = get_var('async', 'defaults', defaults, varargin{:});
  mult_latency                = get_var('mult_latency', 'defaults', defaults, varargin{:});
  add_latency                 = get_var('add_latency', 'defaults', defaults, varargin{:});
  bram_latency                = get_var('bram_latency', 'defaults', defaults, varargin{:});
  fan_latency                 = get_var('fan_latency', 'defaults', defaults, varargin{:});
  multiplier_implementation   = get_var('multiplier_implementation', 'defaults', defaults, varargin{:});
  bram_optimization           = get_var('bram_optimization', 'defaults', defaults, varargin{:});

  if strcmp(complex, 'on'), mult_factor = 2;
  else, mult_factor = 1;
  end

  n_outputs = (2^n_inputs)*n_streams;

  delete_lines(blk);

  %default empty block for storage in library
  if n_taps == 0 | n_streams == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting pfb_fir_taps_init','trace');
    return;
  end

  % sync

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [70 23 100 37]);

  reuse_block(blk, 'dsync0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(fan_latency+bram_latency), 'Position', [415 40 450 60]);
  
  reuse_block(blk, 'dsync1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(mult_latency), 'Position', [695 40 730 60]);
  add_line(blk, 'dsync0/1', 'dsync1/1');

  reuse_block(blk, 'dsync2', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(ceil(log2(n_taps))*add_latency), 'Position', [925 40 960 60]);
  add_line(blk, 'dsync1/1', 'dsync2/1');
  
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1065 43 1095 57]);
  add_line(blk, 'dsync2/1', 'sync_out/1');
  
  % din
  
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [70 448 100 462]);
  
  reuse_block(blk, 'ddin', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
    'latency', num2str(fan_latency+bram_latency), 'Position', [415 445 450 465]);
  add_line(blk, 'din/1', 'ddin/1');
  
  % coeffs

  reuse_block(blk, 'coeffs', 'built-in/Inport', 'Port', '3', 'Position', [70 503 100 517]);

  reuse_block(blk, 'dcoeffs', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(bram_latency+fan_latency), 'Position', [415 500 450 520]);
  add_line(blk, 'coeffs/1', 'dcoeffs/1');

  % en

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [70 98 100 112]);

    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(fan_latency+bram_latency), 'Position', [415 95 450 115]);
    add_line(blk, 'en/1', 'den0/1');
    
    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(mult_latency), 'Position', [695 95 730 115]);
    add_line(blk, 'den0/1', 'den1/1');
    
    reuse_block(blk, 'den2', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(ceil(log2(n_taps))*add_latency), 'Position', [925 95 960 115]);
    add_line(blk, 'den1/1', 'den2/1');

  end

  % sync delay so that sync emerges at same point in data stream it entered delays

  if strcmp(async, 'on'), delay_type = 'casper_library_delays/sync_delay_en';
  else delay_type = 'casper_library_delays/sync_delay';
  end

  reuse_block(blk, 'sync_delay', delay_type , ...
          'DelayLen', '(2^(pfb_size-n_inputs))*(n_taps-1)', ...
          'Position', [240 13 290 82]);
  add_line(blk, 'sync/1', 'sync_delay/1');
  add_line(blk, 'sync_delay/1', 'dsync0/1');
  
  if strcmp(async, 'on'), add_line(blk, 'en/1', 'sync_delay/2');
  end

  % tap data delays

  reuse_block(blk, 'youngest', 'xbsIndex_r4/Slice', ...
          'nbits', ['(', num2str(mult_factor), '*n_bits_data)*(n_taps-2)*(2^n_inputs)*n_streams'], ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [160 341 190 359]);
  
  reuse_block(blk, 'bram_din', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [250 298 280 367]);
  add_line(blk, 'ddin/1', 'bram_din/1', 'autorouting', 'on');
  add_line(blk, 'youngest/1', 'bram_din/2');

  reuse_block(blk, 'mult_din', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [575 438 605 507]);
  add_line(blk, 'ddin/1', 'mult_din/1');

  % address generation

  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Free Running', ...
    'n_bits', num2str(pfb_size-n_inputs), 'bin_pt', '0', ...
    'rst', 'on', 'en', async, 'Position', [155 133 200 182]);
  add_line(blk, 'sync/1', 'counter/1') 
    
  reuse_block(blk, 'daddr', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(fan_latency+bram_latency), 'Position', [415 150 450 170]);
  add_line(blk, 'counter/1', 'daddr/1');
 
  if strcmp(async, 'on'), add_line(blk, 'en/1', 'counter/2');
  end
  
  reuse_block(blk, 'never', 'xbsIndex_r4/Constant', ...
    'const', '0', 'arith_type', 'Boolean', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [255 266 275 284]);

  reuse_block(blk, 'tap_delays', 'casper_library_bus/bus_dual_port_ram', ...
          'n_bits', mat2str(repmat(n_bits_data, 1, mult_factor*n_outputs*(n_taps-1))), ...
          'bin_pts', mat2str(zeros(1, mult_factor*n_outputs*(n_taps-1))), ...
          'init_vector', ['repmat(zeros(', mat2str(2^(pfb_size-n_inputs)), ', 1), 1, ', num2str(mult_factor*n_outputs*(n_taps-1)), ')'], ...
          'max_fanout', '1', 'mem_type', 'Block RAM', 'bram_optimization', bram_optimization, ...
          'misc', 'off', ...
          'bram_latency', num2str(bram_latency), 'fan_latency', num2str(fan_latency), ...
          'addra_register', 'on', 'addra_implementation', 'core', ...
          'dina_register', 'off', 'dina_implementation', 'behavioral', ...
          'wea_register', 'off', 'wea_implementation', 'behavioral', ...
          'ena_register', 'off', 'ena_implementation', 'behavioral', ...
          'addrb_register', 'on', 'addrb_implementation', 'core', ...
          'dinb_register', 'on', 'dinb_implementation', 'core', ...
          'web_register', 'on', 'web_implementation', 'core', ...
          'enb_register', 'off', 'enb_implementation', 'behavioral', ...
          'Position', [400 202 465 378]);
  add_line(blk, 'counter/1', 'tap_delays/1');
  add_line(blk, 'bram_din/1', 'tap_delays/2');
  add_line(blk, 'never/1', 'tap_delays/3');
  add_line(blk, 'daddr/1', 'tap_delays/4', 'autorouting', 'on');
  add_line(blk, 'bram_din/1', 'tap_delays/5', 'autorouting', 'on');
  if strcmp(async, 'on'), 
    add_line(blk, 'den0/1', 'tap_delays/6', 'autorouting', 'on');
  else,
    reuse_block(blk, 'always', 'xbsIndex_r4/Constant', ...
      'const', '1', 'arith_type', 'Boolean', ...
      'explicit_period', 'on', 'period', '1', ...
      'Position', [325 356 345 374]);

    add_line(blk, 'always/1', 'tap_delays/6');
  end
  reuse_block(blk, 'arnold', 'built-in/Terminator', 'Position', [580 325 600 345]);
  add_line(blk, 'tap_delays/2', 'arnold/1');

  add_line(blk,'tap_delays/1', 'mult_din/2', 'autorouting', 'on');
  add_line(blk,'tap_delays/1', 'youngest/1', 'autorouting', 'on');

  %multiplication of tap coefficients with data
  
  reuse_block(blk, 'bus_mult', 'casper_library_bus/bus_mult', ...
    'n_bits_a', mat2str(repmat(n_bits_data, 1, mult_factor*n_outputs*n_taps)), ...
    'bin_pt_a', num2str(n_bits_data-1), 'type_a', '1', 'cmplx_a', 'off', ...
    'n_bits_b', mat2str(repmat(n_bits_coeff, 1, mult_factor*n_outputs*n_taps)), ...
    'bin_pt_b', num2str(bin_pt_coeff), 'type_b', '1', 'cmplx_b', 'off', ...
    'n_bits_out', 'n_bits_data+n_bits_coeff', 'bin_pt_out', 'n_bits_data-1+bin_pt_coeff', 'type_out', '1', ...
    'quantization', '0', 'overflow', '0', ...
    'mult_latency', 'mult_latency', 'add_latency', '0', 'conv_latency', '0', ...
    'max_fanout', '1', 'fan_latency', '0', ...
    'multiplier_implementation', 'behavioral HDL', 'misc', 'off', ...
    'Position', [685 457 740 528]);
  add_line(blk, 'mult_din/1', 'bus_mult/1');
  add_line(blk, 'dcoeffs/1', 'bus_mult/2');

  reuse_block(blk, 'tap_split', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', ...
    'outputNum', num2str(n_taps), ...
    'outputWidth', num2str(mult_factor*n_outputs*(n_bits_data+n_bits_coeff)), ...
    'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [800 455 850 455+(n_taps*20)]);
  add_line(blk, 'bus_mult/1', 'tap_split/1');

  reuse_block(blk, 'bus_adder_tree', 'casper_library_bus/bus_adder_tree', ...
    'n_busses', num2str(n_taps), ...
    'n_bits', mat2str(repmat(n_bits_data+n_bits_coeff, 1, mult_factor*n_outputs)), ...
    'bin_pts', num2str(n_bits_data-1+bin_pt_coeff), 'dtypes', '1', ...
    'add_latency', num2str(add_latency), 'misc', 'off', ...
    'first_stage_hdl', 'on', 'adder_imp', 'Behavioral', ...
    'Position', [914 455 964 455+(n_taps*20)]); 
  for n = 0:n_taps-1,
    add_line(blk, ['tap_split/', num2str(n+1)], ['bus_adder_tree/', num2str(n+1)]);
  end

  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [1065 453 1095 467]);
  add_line(blk, 'bus_adder_tree/1', 'dout/1');
  
  if strcmp(async, 'on'),
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '3', 'Position', [1065 98 1095 112]);
    add_line(blk, 'den2/1', 'dvalid/1');
  end

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_taps_init','trace');

end % pfb_fir_taps_init

