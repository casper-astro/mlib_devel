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
    'n_streams', 2, ...
    'n_inputs', 0, ...
    'pfb_size', 5, ...
    'n_taps', 4, ...
    'n_bits_data', 8, ...
    'n_bits_coeff', 12, ...
    'bin_pt_coeff', 11, ...
    'complex', 'on', ...
    'async', 'on', ...
    'mult_latency', 2, ...
    'add_latency', 1, ...
    'fan_latency', 7, ... %TODO make a mask parameter
    'bram_latency', 1, ...
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

  % input ports

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [70 23 100 37]);
  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', num2str(fan_latency), ...
    'Position', [160 20 195 40]);
  add_line(blk, 'sync/1', 'dsync/1');
  
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [70 173 100 187]);
  
  % delays to reduce fanout and help timing
  
  reuse_block(blk, 'ddin0', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', num2str(fan_latency), ...
    'Position', [160 170 195 190]);
  add_line(blk, 'din/1', 'ddin0/1');
  
  reuse_block(blk, 'ddin1', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', num2str(fan_latency), ...
    'Position', [160 320 195 340]);
  add_line(blk, 'din/1', 'ddin1/1');

  reuse_block(blk, 'coeffs', 'built-in/Inport', 'Port', '3', 'Position', [70 398 100 412]);
  reuse_block(blk, 'dcoeffs', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', num2str(fan_latency), ...
    'Position', [160 395 195 415]);
  add_line(blk, 'coeffs/1', 'dcoeffs/1');

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [70 518 100 532]);

    % reduce fanout
    
    reuse_block(blk, 'en_replicate0', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(n_streams * 2^n_inputs * (n_taps-1)), ...
      'latency', num2str(fan_latency), 'misc', 'off', 'implementation', 'core', ...
      'Position', [160 433 195 457]);
    add_line(blk, 'en/1', 'en_replicate0/1');
    
    reuse_block(blk, 'en_replicate1', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(n_streams * 2^n_inputs * n_taps), ...
      'latency', num2str(fan_latency), 'misc', 'off', 'implementation', 'core', ...
      'Position', [160 473 195 497]);
    add_line(blk, 'en/1', 'en_replicate1/1');
    
    reuse_block(blk, 'en_replicate2', 'casper_library_bus/bus_replicate', ...
      'replication', '2', 'latency', num2str(fan_latency), 'implementation', 'core', ...
      'misc', 'off', 'Position', [160 513 195 537]);
    add_line(blk, 'en/1', 'en_replicate2/1');

    reuse_block(blk, 'en_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', '2', ...
      'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
      'Position', [325 484 375 526]);
    add_line(blk, 'en_replicate2/1', 'en_expand/1');

    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '0', ...
      'Position', [160 260 195 280]);
    add_line(blk, 'en/1', 'den/1');
    
  end

  % sync pipeline

  if strcmp(async, 'on'), delay_type = 'casper_library_delays/sync_delay_en';
  else delay_type = 'casper_library_delays/sync_delay';
  end

  reuse_block(blk, 'sync_delay', delay_type , ...
          'DelayLen', '(2^(pfb_size-n_inputs)+add_latency)*(n_taps-1)', ...
          'Position', [425 13 475 82]);
  add_line(blk, 'dsync/1', 'sync_delay/1');
  
  if strcmp(async, 'on'), add_line(blk, 'en_expand/1', 'sync_delay/2');
  end

  reuse_block(blk, 'sync_delay0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'mult_latency+1+add_latency+1', 'Position', [740 36 785 64]);
  add_line(blk, 'sync_delay/1', 'sync_delay0/1');
  
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1000 43 1030 57]);
  add_line(blk, 'sync_delay0/1', 'sync_out/1');

  % tap data delays

  reuse_block(blk, 'youngest', 'xbsIndex_r4/Slice', ...
          'nbits', ['(', num2str(mult_factor), '*' , num2str(n_bits_data), ')*', num2str(n_taps-2), '*', num2str(2^n_inputs), '*', num2str(n_streams)], ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [70 201 100 219]);
  
  reuse_block(blk, 'ddata0', 'casper_library_bus/bus_delay', ...
    'n_bits', ['repmat(', num2str(n_bits_data*mult_factor),', 1, ', num2str(n_streams * 2^n_inputs * (n_taps-2)), ')'], ...  
    'latency', num2str(add_latency), 'reg_retiming', 'on', 'cmplx', 'off', 'misc', 'off', ...
    'enable', async, 'Position', [245 200 275 235]);
  add_line(blk, 'youngest/1', 'ddata0/1');
  if strcmp(async, 'on'), add_line(blk, 'en_replicate0/1', 'ddata0/2');
  end 

  reuse_block(blk, 'bram_din', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [335 158 365 242]);
  add_line(blk, 'ddin0/1', 'bram_din/1');
  add_line(blk, 'ddata0/1', 'bram_din/2');

  reuse_block(blk, 'ddata1', 'casper_library_bus/bus_delay', ...
    'n_bits', ['repmat(', num2str(n_bits_data*mult_factor),', 1, ', num2str(n_streams * 2^n_inputs * (n_taps-1)), ')'], ...  
    'latency', num2str(add_latency), 'reg_retiming', 'on', 'cmplx', 'off', 'misc', 'off', ...
    'enable', async, 'Position', [565 342 595 373]);
  if strcmp(async, 'on'), add_line(blk, 'en_replicate1/1', 'ddata1/2');
  end 
  
  reuse_block(blk, 'madd_din', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [655 313 685 382]);
  add_line(blk, 'ddin1/1', 'madd_din/1');
  add_line(blk, 'ddata1/1', 'madd_din/2');

  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Count Limited', ...
    'cnt_to', num2str(2^(pfb_size-n_inputs)-bram_latency-1), ...
    'n_bits', num2str(pfb_size-n_inputs), 'bin_pt', '0', ...
    'en', async, 'Position', [160 92 220 118]);
  
  if strcmp(async, 'on'), add_line(blk, 'en/1', 'counter/1');
  end
  
  reuse_block(blk, 'we', 'xbsIndex_r4/Constant', ...
    'const', '1', 'arith_type', 'Boolean', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [380 227 395 243]);

  reuse_block(blk, 'delay_bram', 'casper_library_bus/bus_single_port_ram', ...
          'n_bits', mat2str(repmat(n_bits_data, 1, mult_factor*n_outputs*(n_taps-1))), ...
          'bin_pts', mat2str(zeros(1, mult_factor*n_outputs*(n_taps-1))), ...
          'init_vector', ['repmat(zeros(', mat2str(2^(pfb_size-n_inputs)), ', 1), 1, ', num2str(mult_factor*n_outputs*(n_taps-1)), ')'], ...
          'max_fanout', '1', 'mem_type', 'Block RAM', 'bram_optimization', bram_optimization, ...
          'async', async, 'misc', 'off', ...
          'bram_latency', num2str(bram_latency), 'fan_latency', num2str(fan_latency), ...
          'addr_register', 'on', 'addr_implementation', 'core', ...
          'din_register', 'off', 'din_implementation', 'behavioral', ...
          'we_register', 'off', 'we_implementation', 'behavioral', ...
          'en_register', 'on', 'en_implementation', 'core', ...
          'Position', [425 142 480 292]);
  add_line(blk, 'counter/1', 'delay_bram/1');
  add_line(blk, 'bram_din/1', 'delay_bram/2');
  add_line(blk, 'we/1', 'delay_bram/3');
  if strcmp(async, 'on'), 
    add_line(blk, 'den/1', 'delay_bram/4');
    reuse_block(blk, 'terminator', 'built-in/Terminator', 'Position', [500 245 520 265]);
    add_line(blk, 'delay_bram/2', 'terminator/1');
  end

  add_line(blk,'delay_bram/1', 'ddata1/1', 'autorouting', 'on');
  add_line(blk,'delay_bram/1', 'youngest/1', 'autorouting', 'on');

  % coefficient multiplication and add chain
  n_bits_mult = n_bits_coeff+n_bits_data; 
 
  reuse_block(blk, 'dummy', 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(n_bits_mult*n_outputs*mult_factor), 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [565 429 595 451]);
  
  reuse_block(blk, 'partial_sum', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(sum([n_bits_mult+n_taps-2:-1:n_bits_mult])*n_outputs*mult_factor), ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [565 465 595 485]);

  reuse_block(blk, 'tap_chain', 'xbsIndex_r4/Concat', 'Position', [655 423 685 492]);
  add_line(blk, 'dummy/1', 'tap_chain/1');
  add_line(blk, 'partial_sum/1', 'tap_chain/2');

  n_bits_c = reshape(repmat([n_bits_mult, [n_bits_mult:n_bits_mult+n_taps-2]], n_outputs*mult_factor, 1), 1, n_outputs*n_taps*mult_factor, 1);
  n_bits_out = reshape(repmat([n_bits_mult:n_bits_mult+n_taps-1], n_outputs*mult_factor, 1), 1, n_outputs*mult_factor*n_taps, 1);
  reuse_block(blk, 'bus_madd', 'casper_library_bus/bus_maddsub', ...
          'n_bits_a', mat2str(repmat(n_bits_data, 1, mult_factor*n_outputs*n_taps)), ... 
          'bin_pt_a', num2str(n_bits_data-1), 'type_a', '1', 'cmplx_a', 'off', ...
          'n_bits_b', mat2str(repmat(n_bits_coeff, 1, mult_factor*n_outputs*n_taps)), ...
          'bin_pt_b', num2str(bin_pt_coeff), 'type_b', '1', ...
          'mult_latency', num2str(mult_latency+1), ...
          'multiplier_implementation', 'behavioral HDL', 'replication_ab', 'on', 'opmode', 'Addition', ...
          'n_bits_c', mat2str(n_bits_c), 'bin_pt_c', num2str(n_bits_data-1+bin_pt_coeff), 'type_c', '1', ...
          'add_implementation', 'behavioral HDL', 'add_latency', num2str(add_latency), ...
          'async_add', async,  'align_c', 'off', 'replication_c', 'off', ...
          'n_bits_out', mat2str(n_bits_out), 'bin_pt_out', num2str(n_bits_data-1+bin_pt_coeff), ...
          'type_out', '1', 'quantization', '0', 'overflow', '0', ...
          'add_latency', 'add_latency', 'max_fanout', '1', ...
          'Position', [735 320 785 545]);
  add_line(blk,'madd_din/1', 'bus_madd/1');
  add_line(blk,'dcoeffs/1', 'bus_madd/2');
  add_line(blk,'tap_chain/1', 'bus_madd/3');
  if strcmp(async, 'on'), add_line(blk, 'en_expand/2', 'bus_madd/4');
  end
  add_line(blk,'bus_madd/1', 'partial_sum/1', 'autorouting', 'on');

  reuse_block(blk, 'final_sum', 'xbsIndex_r4/Slice', ...
    'nbits', num2str((n_bits_mult+n_taps-1)*n_outputs*mult_factor), ...
    'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of Input', ...
    'Position', [850 369 880 391]);
  add_line(blk,'bus_madd/1', 'final_sum/1');

  reuse_block(blk, 'dfinal_sum', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', '1', 'Position', [940 370 975 390]);
  add_line(blk, 'final_sum/1', 'dfinal_sum/1');

  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [1000 373 1030 387]);
  add_line(blk,'dfinal_sum/1', 'dout/1');

  if strcmp(async, 'on'),
    reuse_block(blk, 'dvalid', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', '1', 'Position', [940 480 975 500]);
    add_line(blk, 'bus_madd/2', 'dvalid/1');

    reuse_block(blk, 'valid', 'built-in/Outport', 'Port', '3', 'Position', [1000 483 1030 497]);
    add_line(blk, 'dvalid/1', 'valid/1');
  end

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_taps_init','trace');

end % pfb_fir_taps_init

