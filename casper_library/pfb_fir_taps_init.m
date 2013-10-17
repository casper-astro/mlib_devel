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
    'bram_latency', 1, ...
    'multiplier_implementation', 'behavioral HDL', ... 'embedded multiplier core' 'standard core' ...
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
  multiplier_implementation   = get_var('multiplier_implementation', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default empty block for storage in library
  if n_taps == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting pfb_fir_taps_init','trace');
    return;
  end

  n_outputs = (2^n_inputs)*n_streams;

  % input ports

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [70 23 100 37]);
  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
    'Position', [160 20 195 40]);
  add_line(blk, 'sync/1', 'dsync/1');
  
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [70 158 100 172]);
  
  % delays to reduce fanout and help timing
  
  reuse_block(blk, 'ddin0', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [160 155 195 175]);
  add_line(blk, 'din/1', 'ddin0/1');
  
  reuse_block(blk, 'ddin1', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [160 320 195 340]);
  add_line(blk, 'din/1', 'ddin1/1');

  reuse_block(blk, 'coeffs', 'built-in/Inport', 'Port', '3', 'Position', [70 393 100 407]);
  reuse_block(blk, 'dcoeffs', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [160 390 195 410]);
  add_line(blk, 'coeffs/1', 'dcoeffs/1');

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [70 503 100 517]);

    % list of delays to reduce fanout
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', '1', 'Position', [160 500 195 520]);
    add_line(blk, 'en/1', 'den0/1');

    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [160 245 195 265]);
    add_line(blk, 'en/1', 'den1/1');

    reuse_block(blk, 'den2', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [160 90 195 110]);
    add_line(blk, 'en/1', 'den2/1');
    
    reuse_block(blk, 'den3', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [160 55 195 75]);
    add_line(blk, 'en/1', 'den3/1');
  end

  % sync pipeline

  if strcmp(async, 'on'), delay_type = 'casper_library_delays/sync_delay_en';
  else delay_type = 'casper_library_delays/sync_delay';
  end

  reuse_block(blk, 'sync_delay', delay_type , ...
          'DelayLen', '(2^(pfb_size-n_inputs)+add_latency)*(n_taps-1)', ...
          'Position', [395 13 445 82]);
  add_line(blk, 'dsync/1', 'sync_delay/1');
  
  if strcmp(async, 'on'), 
    add_line(blk, 'den3/1', 'sync_delay/2');
  end

  reuse_block(blk, 'sync_delay0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'mult_latency+1+add_latency', 'Position', [610 36 655 64]);
  add_line(blk, 'sync_delay/1', 'sync_delay0/1');
  
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [815 43 845 57]);
  add_line(blk, 'sync_delay0/1', 'sync_out/1');

  % tap data delays

  if strcmp(complex, 'on'), factor = 2;
  else factor = 1;
  end

  reuse_block(blk, 'youngest', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(factor*n_bits_data*(n_taps-2)*n_streams*(2^n_inputs)), ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [70 191 100 209]);

  reuse_block(blk, 'data_delay_chain', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [250 149 280 216]);
  add_line(blk, 'youngest/1', 'data_delay_chain/2');
  add_line(blk, 'ddin0/1', 'data_delay_chain/1');

  reuse_block(blk, 'data', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [405 319 435 366]);
  add_line(blk,'ddin1/1', 'data/1');

  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Count Limited', ...
    'cnt_to', num2str(2^(pfb_size-n_inputs)-bram_latency-1), ...
    'n_bits', num2str(pfb_size-n_inputs), 'bin_pt', '0', ...
    'en', async, 'Position', [300 83 335 117]);
  
  if strcmp(async, 'on'), add_line(blk, 'den2/1', 'counter/1');
  end
  
  reuse_block(blk, 'we', 'xbsIndex_r4/Constant', ...
    'const', '1', 'arith_type', 'Boolean', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [310 212 325 228]);

  reuse_block(blk, 'delay_bram', 'casper_library_bus/bus_single_port_ram', ...
          'n_bits', mat2str(repmat(n_bits_data, 1, factor*n_outputs*(n_taps-1))), ...
          'bin_pts', mat2str(zeros(1, factor*n_outputs*(n_taps-1))), ...
          'init_vector', ['repmat(zeros(', mat2str(2^(pfb_size-n_inputs)), ', 1), 1, ', num2str(factor*n_outputs*(n_taps-1)), ')'], ...
          'max_fanout', '1', 'mem_type', 'Block RAM', ...
          'async', async, 'misc', 'off', ...
          'bram_latency', num2str(bram_latency), 'fan_latency', '1', ...
          'Position', [395 133 445 272]);
  add_line(blk, 'counter/1', 'delay_bram/1');
  add_line(blk, 'data_delay_chain/1', 'delay_bram/2');
  add_line(blk, 'we/1', 'delay_bram/3');
  if strcmp(async, 'on'), 
    add_line(blk, 'den1/1', 'delay_bram/4');
    reuse_block(blk, 'terminator', 'built-in/Terminator', 'Position', [480 230 500 250]);
    add_line(blk, 'delay_bram/2', 'terminator/1');
  end

  reuse_block(blk, 'd_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'add_latency', 'Position', [615 156 655 184]);
  add_line(blk,'d_delay/1', 'youngest/1', 'autorouting', 'on');
  add_line(blk,'d_delay/1', 'data/2', 'autorouting', 'on');
  add_line(blk,'delay_bram/1', 'd_delay/1');

  % coefficient multiplication and add chain
  n_bits_mult = n_bits_coeff+n_bits_data; 
 
  reuse_block(blk, 'dummy', 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(n_bits_mult*n_outputs*factor), 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [315 424 345 446]);
  
  reuse_block(blk, 'partial_sum', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(sum([n_bits_mult+n_taps-2:-1:n_bits_mult])*n_outputs*factor), ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [315 460 345 480]);

  reuse_block(blk, 'tap_chain', 'xbsIndex_r4/Concat', 'Position', [405 418 435 487]);
  add_line(blk, 'dummy/1', 'tap_chain/1');
  add_line(blk, 'partial_sum/1', 'tap_chain/2');

  n_bits_c = reshape(repmat([n_bits_mult, [n_bits_mult:n_bits_mult+n_taps-2]], n_outputs*factor, 1), 1, n_outputs*n_taps*factor, 1);
  n_bits_out = reshape(repmat([n_bits_mult:n_bits_mult+n_taps-1], n_outputs*factor, 1), 1, n_outputs*factor*n_taps, 1);
  reuse_block(blk, 'bus_madd', 'casper_library_bus/bus_maddsub', ...
          'n_bits_a', mat2str(repmat(n_bits_data, 1, factor*n_outputs*n_taps)), ... 
          'bin_pt_a', num2str(n_bits_data-1), 'type_a', '1', 'cmplx_a', complex, ...
          'n_bits_b', mat2str(repmat(n_bits_coeff, 1, n_outputs*n_taps/n_streams)), ...
          'bin_pt_b', num2str(bin_pt_coeff), 'type_b', '1', ...
          'mult_latency', num2str(mult_latency+1), ...
          'multiplier_implementation', 'behavioral HDL', 'replication_ab', 'on', 'opmode', 'Addition', ...
          'n_bits_c', mat2str(n_bits_c), 'bin_pt_c', num2str(n_bits_data-1+bin_pt_coeff), 'type_c', '1', ...
          'add_implementation', 'behavioral HDL', 'add_latency', num2str(add_latency), ...
          'async_add', async,  'align_c', 'off', 'replication_c', 'off', ...
          'n_bits_out', mat2str(n_bits_out), 'bin_pt_out', num2str(n_bits_data-1+bin_pt_coeff), ...
          'type_out', '1', 'quantization', '0', 'overflow', '0', ...
          'add_latency', 'add_latency', 'max_fanout', '2', ...
          'Position', [615 312 660 543]);
  add_line(blk,'data/1', 'bus_madd/1');
  add_line(blk,'dcoeffs/1', 'bus_madd/2');
  add_line(blk,'tap_chain/1', 'bus_madd/3');
  if strcmp(async, 'on'), 
    add_line(blk, 'den0/1', 'bus_madd/4');
  end
  add_line(blk,'bus_madd/1', 'partial_sum/1', 'autorouting', 'on');

  reuse_block(blk, 'final_sum', 'xbsIndex_r4/Slice', ...
    'nbits', num2str((n_bits_mult+n_taps-1)*n_outputs*factor), ...
    'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of Input', ...
    'Position', [725 359 755 381]);
  add_line(blk,'bus_madd/1', 'final_sum/1');

  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [815 363 845 377]);
  add_line(blk,'final_sum/1', 'dout/1');

  if strcmp(async, 'on'),
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '3', 'Position', [815 478 845 492]);
    add_line(blk, 'bus_madd/2', 'dvalid/1');
  end

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_taps_init','trace');

end % pfb_fir_taps_init

