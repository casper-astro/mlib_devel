function delay_bram_init(blk, varargin)

  clog('entering delay_bram_init', {'trace', 'delay_bram_init_debug'});
  defaults = { ...
    'DelayLen', 0, ...
    'bram_latency', 2, ...
    'use_dsp48', 'off', ...
    'async', 'off'};
  
  check_mask_type(blk, 'delay_bram');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  DelayLen       = get_var('DelayLen', 'defaults', defaults, varargin{:});
  bram_latency   = get_var('bram_latency', 'defaults', defaults, varargin{:});
  use_dsp48      = get_var('use_dsp48', 'defaults', defaults, varargin{:});
  async          = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if DelayLen == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting delay_bram_init',{'trace', 'delay_bram_init_debug'});
    return;
  end
  
  if (DelayLen <= bram_latency)
    clog('delay value must be greater than BRAM Latency',{'error', 'delay_bram_init_debug'});
    error('delay_bram_init: delay value must be greater than BRAM Latency');
  end
  
  %input ports

  reuse_block(blk, 'din', 'built-in/inport', 'Port', '1', ...
      'Position', [40 113 70 127]);

  %we input to ram either from port or constant

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/inport', 'Port', '2', ...
        'Position', [40 73 70 87]);
  else,
    reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
        'arith_type', 'Boolean', 'const', '1', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [95 148 130 172]);
  end
  
  if strcmp(use_dsp48,'on'), 
    use_rpm = 'on'; 
    implementation = 'DSP48';
  else 
    use_rpm = 'off';
    implementation = 'Fabric';
  end

  bitwidth = max(ceil(log2(DelayLen)), 2);
  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Count Limited', 'operation', 'Up', ...
    'cnt_to', 'DelayLen - bram_latency - 1', ...
    'start_count', '0' , 'cnt_by_val', '1', ...
    'en', async, 'use_behavioral_HDL', 'off', ...
    'n_bits', num2str(bitwidth), ...
    'bin_pt', '0', ... 
    'use_rpm', use_rpm, 'implementation', implementation, ...
    'Position', [95 64 130 96]);
  
  reuse_block(blk, 'ram', 'xbsIndex_r4/Single Port RAM', ...
    'depth', num2str(2^bitwidth), 'initVector', '0', ...
    'distributed_mem', 'Block RAM', ...
    'write_mode', 'Read before write', 'en', async, ...
    'optimize', 'Area', 'latency', 'bram_latency', ...
    'Position', [150 62 215 178]);
  add_line(blk, 'counter/1', 'ram/1');
  add_line(blk, 'din/1', 'ram/2');

  if strcmp(async,'on'),
    add_line(blk, 'en/1', 'counter/1');
    add_line(blk, 'en/1', 'ram/3');
    add_line(blk, 'en/1', 'ram/4');
  else
    add_line(blk, 'constant/1', 'ram/3');
  end

  reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', ...
      'Position', [240 113 270 127]);
  add_line(blk, 'ram/1', 'dout/1');

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting delay_bram_init', {'trace','delay_bram_init_debug'});

end %function
