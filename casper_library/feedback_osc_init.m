function feedback_osc_init(blk, varargin)
  log_group = 'feedback_osc_init_debug';

  check_mask_type(blk, 'feedback_osc');
  defaults = { ...
    'n_bits', 18, ...           %reference and output resolution
    'n_bits_rotation', 25, ...  %rotation vector resolution DSP48Es can do 25x18 multiplies
    'phase_initial', 0, ...
    'phase_step_bits', 8, ...
    'phase_steps_bits', 8, ...
    'ref_values_bits', 1, ...
    'bram_latency', 3, ...
    'mult_latency', 2, ...
    'add_latency', 1, ...
    'conv_latency', 1, ...
    'bram', 'Distributed memory', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'async', 'on', ... %TODO make optional
    'misc', 'on', ... %TODO make optional
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_bits                  = get_var('n_bits','defaults', defaults, varargin{:});
  n_bits_rotation         = get_var('n_bits_rotation','defaults', defaults, varargin{:});
  phase_initial           = get_var('phase_initial','defaults', defaults, varargin{:});
  phase_step_bits         = get_var('phase_step_bits','defaults', defaults, varargin{:});
  phase_steps_bits        = get_var('phase_steps_bits','defaults', defaults, varargin{:});
  ref_values_bits         = get_var('ref_values_bits','defaults', defaults, varargin{:});
  bram                    = get_var('bram','defaults', defaults, varargin{:});
  bram_latency            = get_var('bram_latency','defaults', defaults, varargin{:});
  mult_latency            = get_var('mult_latency','defaults', defaults, varargin{:});
  add_latency             = get_var('add_latency','defaults', defaults, varargin{:});
  conv_latency            = get_var('conv_latency','defaults', defaults, varargin{:});
  quantization            = get_var('quantization','defaults', defaults, varargin{:});
  mux_latency = 2;
  working_vals_latency = 2;
  async                   = get_var('async','defaults', defaults, varargin{:});
  misc                    = get_var('misc','defaults', defaults, varargin{:});

  delete_lines(blk);

  if ref_values_bits < 1,
    clog('There must be at least 2^1 (=2) calibration locations for the feedback_osc, forcing 1',{log_group, 'error'});
    warning('There must be at least 2^1 (=2) calibration locations for the feedback_osc, forcing 1');
    ref_values_bits = 1;
  end

  %worst case latency through complex multiplier path
  wcl = 1 + working_vals_latency + (1+mult_latency)+add_latency+conv_latency+mux_latency;
  %round up to nearest power of 2
  wcl_bits = ceil(log2(wcl));

  %pointless using this block if generating the same size sinusoid as lookup, will give error when trying to 
  %slice 0 bits
  if (wcl_bits + ref_values_bits) >= phase_steps_bits,
    %decrease various latencies 
    mux_latency = 1; working_vals_latency = 1; add_latency = 1;
    
    wcl = 1 + working_vals_latency + (1+mult_latency)+add_latency+conv_latency+mux_latency;
    %round up to nearest power of 2
    wcl_bits = ceil(log2(wcl));
    
    if (wcl_bits + ref_values_bits) >= phase_steps_bits,
      clog('The number of calibration values requested is the same or larger than the number of output values requested',{log_group, 'error'});
      error('feedback_osc_init: The number of calibration values requested is the same or larger than the number of output values requested');
    end
  end

  %default state in library
  if n_bits == 0 | n_bits_rotation == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  
    return; 
  end
  
  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [5 853 35 867]);
 
  if strcmp(async, 'on'), reuse_block(blk, 'en', 'built-in/Inport', 'Port', '2', 'Position', [5 768 35 782]);
  end
  if strcmp(misc, 'on'), reuse_block(blk, 'misci', 'built-in/Inport', 'Port', '3', 'Position', [5 808 35 822]);
  end

  reuse_block(blk, 'count', 'xbsIndex_r4/Counter', ...
          'n_bits', num2str(phase_steps_bits), ...
          'rst', 'on', 'en', async, 'use_behavioral_HDL', 'off', 'implementation', 'Fabric', ...
          'Position', [65 225 120 285]);
  if strcmp(async, 'on'), add_line(blk,'en/1','count/2');
  end
  add_line(blk, 'sync/1', 'count/1');

  reuse_block(blk, 'choice', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(phase_steps_bits-(wcl_bits+ref_values_bits)), ...
          'mode', 'Upper Bit Location + Width', ...
          'bit1', num2str(-1*ref_values_bits), 'Position', [170 245 200 265]);
  add_line(blk,'count/1','choice/1');

  reuse_block(blk, 'segment', 'xbsIndex_r4/Slice', ...
          'mode', 'Upper Bit Location + Width', ...
          'nbits', num2str(ref_values_bits), ...
          'Position', [170 350 200 370]);
  add_line(blk,'count/1','segment/1');

  reuse_block(blk, 'offset', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(wcl_bits), 'mode', 'Lower Bit Location + Width', 'bit0', '0', ...
          'Position', [170 385 200 405]);
  add_line(blk,'count/1','offset/1');

  reuse_block(blk, 'concat', 'xbsIndex_r4/Concat', ...
          'num_inputs', '2', 'Position', [250 340 270 415]);
  add_line(blk,'segment/1','concat/1');
  add_line(blk,'offset/1','concat/2');
  
  reuse_block(blk, 'dconcat', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'off', 'latency', num2str(wcl - bram_latency - mux_latency), ... 
    'Position', [320 371 680 389]);
  add_line(blk, 'concat/1', 'dconcat/1');

  reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(phase_steps_bits-(wcl_bits+ref_values_bits)), ...
          'bin_pt', '0', 'explicit_period', 'on', ...
          'Position', [250 217 270 233]);

  reuse_block(blk, 'select', 'xbsIndex_r4/Relational', ...
          'mode', 'a!=b', 'latency', '1', ...
          'Position', [320 209 380 271]);
  add_line(blk,'constant/1','select/1');
  add_line(blk,'choice/1','select/2');
  
  reuse_block(blk, 'dselect', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', ...
    'latency', num2str(wcl - 1 - 1 - mux_latency), ...
    'Position', [410 231 675 249]);
  add_line(blk, 'select/1', 'dselect/1');

  reuse_block(blk, 'sel_replicate', 'casper_library_bus/bus_replicate', ...
    'replication', '2', 'latency', '1', 'implementation', 'core', 'misc', 'off',...
    'Position', [755 229 800 251]);
  add_line(blk, 'dselect/1', 'sel_replicate/1');

  %calculate indices for reference values
  indices = [];
  step = phase_steps_bits - ref_values_bits;      %spacing of reference values
  for ref_index = 0:(2^ref_values_bits)-1,
    burst = [ref_index*(2^step):ref_index*(2^step)+((2^wcl_bits)-1)];
    clog(['burst ',num2str(ref_index),' = ', mat2str(burst)], log_group);
    indices = [indices, burst];
  end %for

  %initial phase
  init = 2*pi*phase_initial;

  %arguments controlling complex exponential period
  fraction = phase_step_bits - phase_steps_bits;  %fraction of period stepping through
  period = 2/(2^fraction);
  period_s = ['(2/(2^',num2str(fraction),'))'];

  bin_pt = n_bits-1;
  cos_vals = cos(init+(pi*period)/(2^(phase_steps_bits)) * indices);

  sin_vals = -sin(init+(pi*period)/(2^(phase_steps_bits)) * indices);

  vals = doubles2unsigned([cos_vals',sin_vals'], n_bits, bin_pt, n_bits*2);

  initVector = mat2str(vals');

  reuse_block(blk, 'reference_values', 'xbsIndex_r4/ROM', ...
          'depth', ['2^(',num2str(ref_values_bits),'+',num2str(wcl_bits),')'], ...
          'initVector', initVector, 'arith_type', 'Unsigned',...
          'distributed_mem', bram, 'latency', num2str(bram_latency), ...
          'n_bits', num2str(n_bits*2), 'bin_pt', '0', 'optimize', 'Speed', ...
          'Position', [735 338 820 422]);
  add_line(blk,'dconcat/1','reference_values/1');

  % this register guarantees a delay of at least 1 between writes to an address and
  % a read from that location
  reuse_block(blk, 'doffset0', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'off', 'latency', '1', ...
    'Position', [320 501 355 519]);
  add_line(blk, 'offset/1', 'doffset0/1');
  
  reuse_block(blk, 'doffset1', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'off', ...
    'latency', num2str(wcl), ...
    'Position', [320 626 915 644]);
  add_line(blk, 'offset/1', 'doffset1/1');
  
  reuse_block(blk, 'working_values', 'xbsIndex_r4/Dual Port RAM', ...
    'depth', ['2^', num2str(wcl_bits)], 'initVector', ['zeros(1, 2^', num2str(wcl_bits), ')'], ...
    'distributed_mem', 'Distributed memory', 'latency', num2str(working_vals_latency), ...
    'Position', [415 426 465 519]);
  add_line(blk, 'doffset0/1', 'working_values/4');
  add_line(blk, 'doffset1/1', 'working_values/1', 'autorouting', 'on');

  reuse_block(blk, 'arnold', 'built-in/Terminator', 'Position', [520 440 540 460]);
  add_line(blk, 'working_values/1', 'arnold/1');

  reuse_block(blk, 'rotation_real', 'xbsIndex_r4/Constant', ...
          'const', ['cos(',num2str(2^wcl_bits),'*(pi*',period_s,'/2^',num2str(phase_steps_bits),'))' ], ...
          'n_bits', num2str(n_bits_rotation), 'bin_pt', num2str(n_bits_rotation-1), ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [480 509 600 531]);

  reuse_block(blk, 'rotation_imag', 'xbsIndex_r4/Constant', ...
          'const', ['-sin(',num2str(2^wcl_bits),'*(pi*',period_s,'/2^',num2str(phase_steps_bits),'))' ], ...
          'n_bits', num2str(n_bits_rotation), 'bin_pt', num2str(n_bits_rotation-1), ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [480 544 600 566]);

  reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', 'Position', [655 500 680 575]);
  add_line(blk, 'rotation_real/1', 'ri_to_c/1');
  add_line(blk, 'rotation_imag/1', 'ri_to_c/2');

  reuse_block(blk, 'cmult', 'casper_library_multipliers/cmult', ...
          'n_bits_a', num2str(n_bits), 'bin_pt_a', num2str(n_bits-1), ...
          'n_bits_b', num2str(n_bits_rotation), 'bin_pt_b', num2str(n_bits_rotation-1), ...
          'n_bits_ab', num2str(n_bits), 'bin_pt_ab', num2str(n_bits-1), ...
          'quantization', quantization, 'overflow', 'Saturate', ... %you want Saturate here
          'in_latency', '1', 'mult_latency', num2str(mult_latency), 'add_latency', num2str(add_latency), ...
          'conv_latency', num2str(conv_latency), 'conjugated', 'off', ...
          'async', 'off', 'pipelined_enable', 'off', ...
          'Position', [735 470 820 565]);
  add_line(blk, 'working_values/2', 'cmult/1');
  add_line(blk, 'ri_to_c/1', 'cmult/2');

  reuse_block(blk, 'outmux', 'casper_library_bus/bus_mux', ...
          'n_inputs', '2', 'n_bits', mat2str([n_bits, n_bits]), 'mux_latency', num2str(mux_latency), ...
          'cmplx', 'off', 'misc', 'off', 'Position', [875 167 915 593]);
  add_line(blk, 'sel_replicate/1', 'outmux/1');
  add_line(blk, 'reference_values/1', 'outmux/2');
  add_line(blk, 'cmult/1', 'outmux/3');
  add_line(blk, 'outmux/1', 'working_values/2', 'autorouting', 'on');
    
  reuse_block(blk, 'dcoeffs', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'latency', '1', 'Position', [965 371 995 389]);
  add_line(blk, 'outmux/1', 'dcoeffs/1');

  reuse_block(blk, 'c_to_ri', 'casper_library_misc/c_to_ri', ...
          'n_bits', num2str(n_bits), 'bin_pt', num2str(n_bits-1), 'Position', [1040 333 1065 422]);
  add_line(blk, 'dcoeffs/1', 'c_to_ri/1');
 
  % data out 
  reuse_block(blk, 'cos', 'built-in/Outport', 'Port', '2', 'Position', [1120 348 1150 362]);
  add_line(blk, 'c_to_ri/1', 'cos/1'); 

  reuse_block(blk, '-sin', 'built-in/Outport', 'Port', '3', 'Position', [1120 393 1150 407]);
  add_line(blk, 'c_to_ri/2', '-sin/1'); 

  %en input
  if strcmp(async, 'on'),
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', ...
      'reg_retiming', 'off', ...
      'latency', num2str(wcl), ... 
      'Position', [320 716 915 734]);
    add_line(blk, 'en/1', 'den0/1');
    add_line(blk, 'den0/1', 'working_values/3', 'autorouting', 'on');

    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', ...
      'reg_retiming', 'off', ...
      'latency', num2str(wcl + 1), ... 
      'Position', [575 764 635 786]);
    add_line(blk, 'en/1', 'den1/1');
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', 'Position', [1120 768 1150 782]);
    add_line(blk, 'den1/1', 'dvalid/1'); 
  end %if

  %sync
  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', ...
    'latency', num2str(wcl + 1), ...
    'Position', [575 849 635 871]);
  add_line(blk, 'sync/1', 'dsync/1');

  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1120 853 1150 867]);
  add_line(blk, 'dsync/1', 'sync_out/1'); 

  %misc
  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'reg_retiming', 'on', ...
      'latency', num2str(wcl + 1), ...
      'Position', [575 804 635 826]);
    add_line(blk, 'misci/1', 'dmisc/1');

    reuse_block(blk, 'misco', 'built-in/Outport', 'Port', '5', 'Position', [1120 808 1150 822]);
    add_line(blk, 'dmisc/1', 'misco/1'); 
  end

  clean_blocks(blk);
  args = {'n_bits', n_bits, 'n_bits_rotation', n_bits_rotation, 'phase_initial', phase_initial, ...
    'phase_step_bits', phase_step_bits, 'phase_steps_bits', phase_steps_bits, ...
    'ref_values_bits', ref_values_bits, 'bram_latency', bram_latency, 'mult_latency', mult_latency, ...
    'add_latency', add_latency, 'conv_latency', conv_latency, 'bram', bram, 'quantization', quantization};

  fmtstr = sprintf('%d cal vals',2^(wcl_bits+ref_values_bits));
  set_param(blk, 'AttributesFormatString', fmtstr);
  save_state(blk, 'defaults', defaults, args{:});
end % feedback_osc_init

