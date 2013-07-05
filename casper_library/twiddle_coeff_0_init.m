function twiddle_coeff_0_init(blk, varargin)

  clog('entering twiddle_coeff_0_init',{'trace', 'twiddle_coeff_0_init_debug'});

  defaults = { ...
    'n_inputs', 1, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 2, ...
    'async', 'off'};

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'twiddle_coeff_0');
  munge_block(blk, varargin{:});

  delete_lines(blk);

  n_inputs       = get_var('n_inputs', 'defaults', defaults, varargin{:});
  add_latency    = get_var('add_latency', 'defaults', defaults, varargin{:});
  bram_latency   = get_var('bram_latency', 'defaults', defaults, varargin{:});
  mult_latency   = get_var('mult_latency', 'defaults', defaults, varargin{:});
  conv_latency   = get_var('conv_latency', 'defaults', defaults, varargin{:});
  async          = get_var('async', 'defaults', defaults, varargin{:});

  %the latency here must match twiddle_general with single coefficient so that
  %latencies match when used in fft_direct
  latency_s = '1+mult_latency+add_latency+conv_latency';

  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting twiddle_coeff_0_init', {'trace', 'twiddle_coeff_0_init_debug'});
    return;
  end
  
  reuse_block(blk, 'ai', 'built-in/Inport', 'Port', '1', 'Position', [145 28 175 42]);
  reuse_block(blk, 'bi', 'built-in/Inport', 'Port', '2', 'Position', [145 93 175 107]);
  reuse_block(blk, 'sync_in', 'built-in/Inport', 'Port', '3', 'Position', [145 163 175 177]);
  reuse_block(blk, 'ao', 'built-in/Outport', 'Port', '1', 'Position', [255 28 285 42]);
  reuse_block(blk, 'bwo', 'built-in/Outport', 'Port', '2', 'Position', [255 93 285 107]);
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '3', 'Position', [255 163 285 177]);


  reuse_block(blk, 'da', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [195 14 235 56]);
  add_line(blk,'ai/1','da/1');
  add_line(blk,'da/1','ao/1');

  reuse_block(blk, 'db', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [195 79 235 121]);
  add_line(blk,'bi/1','db/1');
  add_line(blk,'db/1','bwo/1');

  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', ...
          'latency', latency_s, 'reg_retiming', 'on', 'Position', [195 149 235 191]);
  add_line(blk,'sync_in/1','dsync/1');
  add_line(blk,'dsync/1','sync_out/1');
  
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', ...
            'Port', '4', ...
            'Position', [145 163+65 175 177+65]);
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
            'latency', latency_s, 'reg_retiming', 'on', 'Position', [195 149+65 235 191+65]);
    add_line(blk, 'en/1', 'den/1');
    reuse_block(blk, 'dvalid', 'built-in/Outport', ...
            'Port', '4', ...
            'Position', [255 163+65 285 177+65]);
    add_line(blk, 'den/1', 'dvalid/1');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_coeff_0_init', {'trace','twiddle_coeff_0_init_debug'});
end % twiddle_coeff_0_init

