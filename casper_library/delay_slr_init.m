function delay_slr_init(blk, varargin)

  clog('entering delay_slr_init', {'trace', 'delay_slr_init_debug'});
  defaults = { ...
    'DelayLen', 9, ...
    'async', 'on'};
  
  check_mask_type(blk, 'delay_slr');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  DelayLen       = get_var('DelayLen', 'defaults', defaults, varargin{:});
  async          = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if DelayLen == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting delay_slr_init',{'trace', 'delay_slr_init_debug'});
    return;
  end
  
  % ports
  
  if strcmp(async, 'on'),
    reuse_block(blk, 'dvi', 'built-in/inport', 'Port', '2', ...
        'Position', [40 73 70 87]);
    en = 'on';  
    position = [25 28 55 42];
  else, 
    en = 'off';
    position = [25 43 55 57];
  end

  reuse_block(blk, 'din', 'built-in/inport', 'Port', '1', ...
      'Position', position);

  if strcmp(async, 'on'),
    reuse_block(blk, 'dvi', 'built-in/inport', 'Port', '2', ...
        'Position', [25 58 55 72]);
  end

  reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', ...
      'Position', [165 43 195 57]);

  %delay
 
  reuse_block(blk, 'delay', 'xbsIndex_r4/Delay', ...
    'latency', 'DelayLen', 'en', en, ...
    'reg_retiming', 'on', ...
    'Position', [80 20 140 80]);
  add_line(blk, 'din/1', 'delay/1');
  add_line(blk, 'delay/1', 'dout/1');

  if strcmp(async, 'on'),
    add_line(blk, 'dvi/1', 'delay/2');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting delay_bram_init', {'trace','delay_bram_init_debug'});

end %function
