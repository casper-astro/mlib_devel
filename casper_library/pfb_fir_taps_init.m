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
%TODO replicate en before bus_add to reduce fanout for asynchronous operation

function pfb_fir_taps_init(blk, varargin)
  clog('entering pfb_fir_taps_init', 'trace');

  defaults = { ...
    'n_streams', 1, ...
    'n_inputs', 0, ...
    'pfb_size', 5, ...
    'n_taps', 4, ...
    'n_bits_data', 8, ...
    'n_bits_coeff', 12, ...
    'bin_pt_coeff', 11, ...
    'complex', 'off', ...
    'async', 'off', ...
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

  % input ports

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [35 23 65 37]);
  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
    'Position', [110 22 140 38]);
  add_line(blk, 'sync/1', 'dsync/1');
  
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [35 123 65 137]);
  
  % delays to reduce fanout and help timing
  
  reuse_block(blk, 'ddin0', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [110 122 140 138]);
  add_line(blk, 'din/1', 'ddin0/1');
  
  reuse_block(blk, 'ddin1', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [110 287 140 303]);
  add_line(blk, 'din/1', 'ddin1/1');

  reuse_block(blk, 'coeffs', 'built-in/Inport', 'Port', '3', 'Position', [35 348 65 362]);
  reuse_block(blk, 'dcoeffs', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
    'Position', [110 347 140 363]);
  add_line(blk, 'coeffs/1', 'dcoeffs/1');

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [35 478 65 492]);

    %s list of delays to reduce fanout

    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [110 477 140 493]);
    add_line(blk, 'en/1', 'den1/1');
    
    reuse_block(blk, 'den2', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [110 232 140 248]);
    add_line(blk, 'en/1', 'den2/1');

    reuse_block(blk, 'den3', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [110 187 140 203]);
    add_line(blk, 'en/1', 'den3/1');
    
    reuse_block(blk, 'den4', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', ...
      'Position', [110 52 140 68]);
    add_line(blk, 'en/1', 'den4/1');
  end

  % sync pipeline

  if strcmp(async, 'on'), delay_type = 'casper_library_delays/sync_delay_en';
  else delay_type = 'casper_library_delays/sync_delay';
  end

  reuse_block(blk, 'sync_delay', delay_type , ...
          'DelayLen', '(2^(pfb_size-n_inputs)+add_latency)*(n_taps-1)', ...
          'Position', [325 13 375 77]);
  add_line(blk,'dsync/1','sync_delay/1');

  reuse_block(blk, 'sync_delay0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'mult_latency+1', 'Position', [435 31 480 59]);
  add_line(blk,'sync_delay/1','sync_delay0/1');
  
  reuse_block(blk, 'sync_delay1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'add_latency', 'Position', [700 31 740 59]);
  add_line(blk,'sync_delay0/1','sync_delay1/1', 'autorouting', 'on');
  
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [915 38 945 52]);
  add_line(blk,'sync_delay1/1', 'sync_out/1');

  % tap data delays

  if strcmp(complex, 'on'), factor = 2;
  else factor = 1;
  end

  reuse_block(blk, 'youngest', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(factor*n_bits_data*(n_taps-2)*n_streams*2^n_inputs), ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [35 156 65 174]);

  reuse_block(blk, 'data_delay_chain', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [225 114 255 181]);
  add_line(blk, 'youngest/1', 'data_delay_chain/2');
  add_line(blk, 'ddin0/1', 'data_delay_chain/1');

  reuse_block(blk, 'data', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [340 284 370 331]);
  add_line(blk,'ddin1/1', 'data/1');

  reuse_block(blk, 'delay_bram', 'casper_library_delays/delay_bram', ...
          'DelayLen', '2^(pfb_size-n_inputs)', 'bram_latency', 'bram_latency', 'async', async, 'Position', [330 126 370 219]);
  add_line(blk,'data_delay_chain/1','delay_bram/1');

  reuse_block(blk, 'd_delay', 'xbsIndex_r4/Delay', 'en', async, 'reg_retiming', 'on', ...
    'latency', 'add_latency', 'Position', [700 142 740 273]);
  add_line(blk,'d_delay/1', 'youngest/1', 'autorouting', 'on');
  add_line(blk,'d_delay/1', 'data/2', 'autorouting', 'on');
  add_line(blk,'delay_bram/1', 'd_delay/1');

  % coefficient multiplication

  n_outputs = 2^n_inputs*n_streams;

  n_bits_mult = n_bits_data+n_bits_coeff;
  reuse_block(blk, 'bus_mult', 'casper_library_bus/bus_mult', ...
          'n_bits_a', mat2str(repmat(n_bits_data, 1, n_outputs*n_taps)), ... 
          'bin_pt_a', num2str(n_bits_data-1), 'cmplx_a', complex, ...
          'n_bits_b', mat2str(repmat(n_bits_coeff, 1, n_outputs*n_taps)), ...
          'bin_pt_b', num2str(bin_pt_coeff), 'cmplx_b', 'off', ...
          'n_bits_out', num2str(n_bits_mult), ...
          'bin_pt_out', num2str(n_bits_data-1+bin_pt_coeff), ... 
          'mult_latency', 'mult_latency', 'fan_latency', '1', 'conv_latency', '0', ... %explicit 
          'quantization', '0', 'overflow', '0', ...
          'multiplier_implementation', multiplier_implementation, ...
          'misc', 'off', 'Position', [435 289 475 376]);
  add_line(blk, 'data/1', 'bus_mult/1');
  add_line(blk, 'dcoeffs/1', 'bus_mult/2');

  if strcmp(async, 'on'),
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', 'mult_latency+1', 'Position', [435 471 480 499]);
    add_line(blk, 'den1/1', 'den0/1');
    add_line(blk,'den2/1','d_delay/2', 'autorouting', 'on');
    add_line(blk,'den3/1','delay_bram/2');
    add_line(blk,'den4/1','sync_delay/2');
  end

  % add chain
  
  reuse_block(blk, 'dummy', 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(n_bits_mult*n_outputs*factor), 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [520 382 540 398]);
  
  reuse_block(blk, 'partial_sum', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(sum([n_bits_mult+n_taps-2:-1:n_bits_mult])*n_outputs*factor), ...
          'mode', 'Upper Bit Location + Width', 'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [520 415 545 435]);

  reuse_block(blk, 'tap_chain', 'xbsIndex_r4/Concat', 'Position', [610 373 640 442]);
  add_line(blk, 'dummy/1', 'tap_chain/1');
  add_line(blk, 'partial_sum/1', 'tap_chain/2');

  n_bits_b = reshape(repmat([n_bits_mult, [n_bits_mult:n_bits_mult+n_taps-2]], n_outputs*factor, 1), 1, n_outputs*factor*n_taps, 1);
  n_bits_out = reshape(repmat([n_bits_mult:n_bits_mult+n_taps-1], n_outputs*factor, 1), 1, n_outputs*factor*n_taps, 1);
  reuse_block(blk, 'bus_add', 'casper_library_bus/bus_addsub', ...
          'opmode', '0', ...
          'n_bits_a', mat2str(repmat(n_bits_data+n_bits_coeff, 1, n_outputs*n_taps*factor)), ... 
          'bin_pt_a', num2str(n_bits_data-1+bin_pt_coeff), ...
          'n_bits_b', mat2str(n_bits_b), ...
          'bin_pt_b', num2str(n_bits_data-1+bin_pt_coeff), ...
          'cmplx', 'off', 'misc', 'off', 'async', async, ...
          'n_bits_out', mat2str(n_bits_out), ...
          'bin_pt_out', num2str(n_bits_data-1+bin_pt_coeff), ...
          'latency', 'add_latency', ...
          'Position', [700 295 740 525]);
  add_line(blk,'bus_mult/1', 'bus_add/1');
  add_line(blk,'bus_add/1', 'partial_sum/1', 'autorouting', 'on');
  add_line(blk,'tap_chain/1', 'bus_add/2');

  reuse_block(blk, 'final_sum', 'xbsIndex_r4/Slice', ...
    'nbits', num2str((n_bits_mult+n_taps-1)*n_outputs*factor), ...
    'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of Input', ...
    'Position', [845 344 875 366]);
  add_line(blk,'bus_add/1', 'final_sum/1');

  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [935 348 965 362]);
  add_line(blk,'final_sum/1', 'dout/1');

  if strcmp(async, 'on'),
    add_line(blk,'den0/1','bus_add/3');

    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '3', 'Position', [935 463 965 477]);
    add_line(blk,'bus_add/2', 'dvalid/1');
  end

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_taps_init','trace');

end % pfb_fir_taps_init

