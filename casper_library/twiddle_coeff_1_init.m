function twiddle_coeff_1_init(blk, varargin)

  clog('entering twiddle_coeff_1_init',{'trace', 'twiddle_coeff_1_init_debug'});

  defaults = { ...
    'n_inputs', 2, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 2, ...
    'async', 'off'};

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'twiddle_coeff_1');
  munge_block(blk, varargin{:});

  delete_lines(blk);

  n_inputs        = get_var('n_inputs', 'defaults', defaults, varargin{:});
  input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
  bin_pt_in       = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  add_latency     = get_var('add_latency', 'defaults', defaults, varargin{:});
  bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
  mult_latency    = get_var('mult_latency', 'defaults', defaults, varargin{:});
  conv_latency    = get_var('conv_latency', 'defaults', defaults, varargin{:});
  async           = get_var('async', 'defaults', defaults, varargin{:});
  
  %the latency here must match twiddle_general with single coefficient so that
  %latencies match when used in fft_direct
  latency_s = '1+mult_latency+add_latency+conv_latency';

  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting twiddle_coeff_1_init', {'trace', 'twiddle_coeff_1_init_debug'});
    return;
  end
  
  reuse_block(blk, 'ai', 'built-in/Inport', 'Port', '1', 'Position', [50 108 80 122]);
  reuse_block(blk, 'bi', 'built-in/Inport', 'Port', '2', 'Position', [50 223 80 237]);
  reuse_block(blk, 'sync_in', 'built-in/Inport', 'Port', '3', 'Position', [50 333 80 347]);
  reuse_block(blk, 'ao', 'built-in/Outport', 'Port', '1', 'Position', [465 108 495 122]);
  reuse_block(blk, 'bwo', 'built-in/Outport', 'Port', '2', 'Position', [465 223 495 237]);
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '3', 'Position', [465 333 495 347]);

  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [250 331 285 349]);
  add_line(blk,'sync_in/1','dsync/1');
  add_line(blk,'dsync/1','sync_out/1');

  reuse_block(blk, 'da', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [250 106 285 124]);
  add_line(blk,'ai/1','da/1');
  add_line(blk,'da/1','ao/1');

  reuse_block(blk, 'munge_in', 'casper_library_flow_control/munge', ...
          'divisions', 'n_inputs*2', ...
          'div_size', 'repmat(input_bit_width, 1, n_inputs*2)', ...
          'order', '[[0:2:(n_inputs-1)*2],[1:2:(n_inputs-1)*2+1]]', ...
          'Position', [100 219 140 241]);
  add_line(blk,'bi/1','munge_in/1');

  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', ...
          'outputNum', '2', ...
          'outputWidth', 'input_bit_width*n_inputs', ...
          'outputBinaryPt', '0', ...
          'outputArithmeticType', '0', ...
          'Position', [160 191 210 269]);
  add_line(blk,'munge_in/1','bus_expand/1');

  reuse_block(blk, 'negate_real', 'casper_library_bus/bus_negate', ...
          'n_bits_in', 'repmat(input_bit_width, 1, n_inputs)', ...
          'bin_pt_in', 'bin_pt_in', ...
          'cmplx', 'off', 'misc', 'off', 'overflow', '1', ...
          'latency', latency_s, ...
          'Position', [235 195 300 225]);
  add_line(blk,'bus_expand/1','negate_real/1', 'autorouting', 'on');

  reuse_block(blk, 'db', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [250 241 285 259]);
  add_line(blk,'bus_expand/2','db/1', 'autorouting', 'on');

  reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
          'inputNum', '2', 'Position', [335 190 380 270]);
  add_line(blk,'db/1','bus_create/1');
  add_line(blk,'negate_real/1','bus_create/2');

  reuse_block(blk, 'munge_out', 'casper_library_flow_control/munge', ...
          'divisions', 'n_inputs*2', ...
          'div_size', 'repmat(input_bit_width, 1, n_inputs*2)', ...
          'order', 'reshape([[0:(n_inputs-1)];[n_inputs:(n_inputs*2)-1]], 1, n_inputs*2)', ...
          'Position', [400 219 440 241]);
  add_line(blk,'bus_create/1','munge_out/1', 'autorouting', 'on');
  add_line(blk,'munge_out/1','bwo/1');
  
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [50 396 80 414]);
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
            'latency', latency_s, 'reg_retiming', 'on', 'Position', [250 396 285 414]);
    add_line(blk, 'en/1', 'den/1');
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', 'Position', [465 398 495 412]);
    add_line(blk, 'den/1', 'dvalid/1');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_coeff_0_init', {'trace','twiddle_coeff_1_init_debug'});
end % twiddle_coeff_1_init

