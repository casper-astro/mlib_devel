function twiddle_pass_through_init(blk, varargin)

  clog('entering twiddle_pass_through_init',{'trace', 'twiddle_pass_through_init_debug'});

  defaults = {'n_inputs', 1, 'async', 'off'};

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'twiddle_pass_through');
  munge_block(blk, varargin{:});

  delete_lines(blk);

  n_inputs       = get_var('n_inputs', 'defaults', defaults, varargin{:});
  async          = get_var('async', 'defaults', defaults, varargin{:});

  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting twiddle_pass_through_init', {'trace', 'twiddle_pass_through_init_debug'});
    return;
  end

  reuse_block(blk, 'ai', 'built-in/Inport');
  set_param([blk,'/ai'], ...
          'Port', sprintf('1'), ...
          'Position', sprintf('[145 28 175 42]'));

  reuse_block(blk, 'bi', 'built-in/Inport');
  set_param([blk,'/bi'], ...
          'Port', sprintf('2'), ...
          'Position', sprintf('[145 93 175 107]'));

  reuse_block(blk, 'sync_in', 'built-in/Inport');
  set_param([blk,'/sync_in'], ...
          'Port', sprintf('3'), ...
          'Position', sprintf('[145 158 175 172]'));

  reuse_block(blk, 'ao', 'built-in/Outport');
  set_param([blk,'/ao'], ...
          'Port', sprintf('1'), ...
          'Position', sprintf('[255 28 285 42]'));

  reuse_block(blk, 'bwo', 'built-in/Outport');
  set_param([blk,'/bwo'], ...
          'Port', sprintf('2'), ...
          'Position', sprintf('[255 93 285 107]'));

  reuse_block(blk, 'sync_out', 'built-in/Outport');
  set_param([blk,'/sync_out'], ...
          'Port', sprintf('3'), ...
          'Position', sprintf('[255 158 285 172]'));

  add_line(blk,'ai/1','ao/1', 'autorouting', 'on');
  add_line(blk,'sync_in/1','sync_out/1', 'autorouting', 'on');
  add_line(blk,'bi/1','bwo/1', 'autorouting', 'on');

  if strcmp(async, 'on'),
    reuse_block(blk, 'dvi', 'built-in/Inport', ...
            'Port', sprintf('4'), ...
            'Position', sprintf('[145 223 175 237]'));

    reuse_block(blk, 'dvo', 'built-in/Outport', ...
            'Port', sprintf('4'), ...
            'Position', sprintf('[255 223 285 237]'));
    add_line(blk,'dvi/1','dvo/1', 'autorouting', 'on');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_pass_through_init', {'trace','twiddle_pass_through_init_debug'});

end % twiddle_pass_through_init

