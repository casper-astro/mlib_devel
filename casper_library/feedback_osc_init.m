function feedback_osc_init(blk, varargin)

  check_mask_type(blk, 'feedback_osc');
  defaults = { ...
    'n_bits', 18, ...           %reference and output resolution
    'n_bits_rotation', 25, ...  %rotation vector resolution DSP48Es can do 25x18 multiplies
    'phase_initial', 0, ...
    'phase_step_bits', 8, ...
    'phase_steps_bits', 8, ...
    'ref_values_bits', 1, ...
    'bram_latency', 2, ...
    'mult_latency', 2, ...
    'add_latency', 1, ...
    'conv_latency', 1, ...
    'bram', 'Distributed memory', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
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
  mux_latency = 1;

  delete_lines(blk);

  if ref_values_bits < 1,
    clog('There must be at least 2^1 (=2) calibration locations for the feedback_osc, forcing 1',{'error', 'feedback_osc_init_debug'});
    warning('There must be at least 2^1 (=2) calibration locations for the feedback_osc, forcing 1');
    ref_values_bits = 1;
  end

  %worst case latency through complex multiplier path
  wcl = mult_latency+add_latency+conv_latency+mux_latency;
  %round up to nearest power of 2
  wcl_bits = ceil(log2(wcl));
  %extra latency needs to be absorbed
  extra_latency = 2^wcl_bits - wcl;

  %keep mult_latency and add_latency the same but add to convert and mux which will hurt us most
  conv_latency = conv_latency+ceil(extra_latency/2);
  mux_latency = mux_latency+floor(extra_latency/2);

  clog(['After latency adjustment to fit ',num2str(2^wcl_bits),' pipeline;'],'feedback_osc_init_debug'); 
  clog(['mult_latency: ', num2str(mult_latency)],'feedback_osc_init_debug'); 
  clog(['add_latency: ', num2str(add_latency)],'feedback_osc_init_debug'); 
  clog(['conv_latency: ', num2str(conv_latency)],'feedback_osc_init_debug'); 
  clog(['mux_latency: ', num2str(mux_latency)],'feedback_osc_init_debug'); 

  %pointless using this block if generating the same size sinusoid as lookup, will give error when trying to 
  %slice 0 bits
  if (wcl_bits + ref_values_bits) >= phase_steps_bits,
    clog('The number of calibration values requested is the same or larger than the number of output values requested',{'error', 'feedback_osc_init_debug'});
    error('feedback_osc_init: The number of calibration values requested is the same or larger than the number of output values requested');
  end

  %default state in library
  if n_bits == 0 | n_bits_rotation == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  
    return; 
  end
  
  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [5 863 35 877]);
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', '2', 'Position', [5 773 35 787]);
  reuse_block(blk, 'misci', 'built-in/Inport', 'Port', '3', 'Position', [5 813 35 827]);

  reuse_block(blk, 'count', 'xbsIndex_r4/Counter', ...
          'n_bits', num2str(phase_steps_bits), ...
          'rst', 'on', 'en', 'on', ...
          'Position', [70 405 100 465]);
  add_line(blk,'en/1','count/2');
  add_line(blk,'sync/1','count/1');

  reuse_block(blk, 'choice', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(phase_steps_bits-(wcl_bits+ref_values_bits)), ...
          'mode', 'Upper Bit Location + Width', ...
          'bit1', num2str(-1*ref_values_bits), 'Position', [145 375 175 395]);
  add_line(blk,'count/1','choice/1');

  reuse_block(blk, 'segment', 'xbsIndex_r4/Slice', ...
          'mode', 'Upper Bit Location + Width', ...
          'nbits', num2str(ref_values_bits), ...
          'Position', [145 425 175 445]);
  add_line(blk,'count/1','segment/1');

  reuse_block(blk, 'offset', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(wcl_bits), 'mode', 'Lower Bit Location + Width', 'bit0', '0', ...
          'Position', [145 475 175 495]);
  add_line(blk,'count/1','offset/1');

  reuse_block(blk, 'cc0', 'xbsIndex_r4/Concat', ...
          'num_inputs', '2', 'Position', [220 409 240 511]);
  add_line(blk,'segment/1','cc0/1');
  add_line(blk,'offset/1','cc0/2');
  
  reuse_block(blk, 'c0', 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(phase_steps_bits-(wcl_bits+ref_values_bits)), ...
          'bin_pt', '0', 'explicit_period', 'on', ...
          'Position', [215 352 235 368]);

  reuse_block(blk, 'select', 'xbsIndex_r4/Relational', ...
          'mode', 'a!=b', 'latency', num2str(bram_latency), ...
          'Position', [285 347 345 398]);
  add_line(blk,'c0/1','select/1');
  add_line(blk,'choice/1','select/2');

  %calculate indices for reference values
  indices = [];
  step = phase_steps_bits - ref_values_bits;      %spacing of reference values
  for ref_index = 0:(2^ref_values_bits)-1,
    burst = [ref_index*(2^step):ref_index*(2^step)+((2^wcl_bits)-1)];
    clog(['burst ',num2str(ref_index),' = ', mat2str(burst)], 'feedback_osc_init_debug');
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
  cos_vals = fi(cos_vals, true, n_bits, bin_pt); %saturates at max so no overflow
  cos_vals = fi(cos_vals, false, n_bits, bin_pt, 'OverflowMode', 'wrap'); %wraps negative component so can get back when positive
  cos_vals = fi(cos_vals, false, n_bits*3, bin_pt); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
  cos_vals = bitshift(cos_vals,bin_pt+n_bits); %shift up to lie in top n_bits of word 

  sin_vals = -sin(init+(pi*period)/(2^(phase_steps_bits)) * indices);
  sin_vals = fi(sin_vals, true, n_bits, bin_pt); %saturates at max so no overflow
  sin_vals = fi(sin_vals, false, n_bits, bin_pt, 'OverflowMode', 'wrap'); %wraps negative component so can get back when positive
  sin_vals = fi(sin_vals, false, n_bits*2, bin_pt); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
  sin_vals = bitshift(sin_vals, bin_pt); %shift up 

  initVector = ['[',num2str(double(cos_vals+sin_vals)),']'];

  reuse_block(blk, 'reference', 'xbsIndex_r4/ROM', ...
          'depth', ['2^(',num2str(ref_values_bits),'+',num2str(wcl_bits),')'], ...
          'initVector', initVector, 'arith_type', 'Unsigned',...
          'distributed_mem', bram, 'latency', num2str(bram_latency), ...
          'n_bits', num2str(n_bits*2), 'bin_pt', '0', ...
          'Position', [285 446 345 474]);
  add_line(blk,'cc0/1','reference/1');

%  reuse_block(blk, '-sin_reference', 'xbsIndex_r4/ROM', ...
%          'depth', ['2^(',num2str(ref_values_bits),'+',num2str(wcl_bits),')'], ...
%          'initVector', ['-sin(',init,'+(pi*',period,')/(2^',num2str(phase_steps_bits),') * [',indices,'])'], ...
%          'distributed_mem', bram, 'latency', num2str(bram_latency), ...
%          'n_bits', num2str(n_bits), 'bin_pt', num2str(n_bits-1), ...
%          'Position', [285 491 345 519]);
%  add_line(blk,'cc0/1','-sin_reference/1');

%  reuse_block(blk, 'ri_to_c0', 'casper_library_misc/ri_to_c', ...
%          'Position', [400 437 425 528]);
%  add_line(blk, 'cos_reference/1', 'ri_to_c0/1');
%  add_line(blk, '-sin_reference/1', 'ri_to_c0/2');

  reuse_block(blk, 'amux', 'xbsIndex_r4/Mux', ...
          'inputs', '2', 'en', 'on', 'latency', num2str(mux_latency), 'Position', [480 323 510 757]);
  add_line(blk, 'select/1', 'amux/1');
  add_line(blk, 'reference/1', 'amux/2');

  reuse_block(blk, 'rotation_real', 'xbsIndex_r4/Constant', ...
          'const', ['cos(',num2str(2^wcl_bits),'*(pi*',period_s,'/2^',num2str(phase_steps_bits),'))' ], ...
          'n_bits', num2str(n_bits_rotation), 'bin_pt', num2str(n_bits_rotation-1), ...
          'Position', [520 584 640 606]);

  reuse_block(blk, 'rotation_imag', 'xbsIndex_r4/Constant', ...
          'const', ['-sin(',num2str(2^wcl_bits),'*(pi*',period_s,'/2^',num2str(phase_steps_bits),'))' ], ...
          'n_bits', num2str(n_bits_rotation), 'bin_pt', num2str(n_bits_rotation-1), ...
          'Position', [520 624 640 646]);

  reuse_block(blk, 'ri_to_c1', 'casper_library_misc/ri_to_c', 'Position', [695 575 720 655]);
  add_line(blk, 'rotation_real/1', 'ri_to_c1/1');
  add_line(blk, 'rotation_imag/1', 'ri_to_c1/2');

  reuse_block(blk, 'cmult', 'casper_library_multipliers/cmult', ...
          'n_bits_a', num2str(n_bits), 'bin_pt_a', num2str(n_bits-1), ...
          'n_bits_b', num2str(n_bits_rotation), 'bin_pt_b', num2str(n_bits_rotation-1), ...
          'n_bits_ab', num2str(n_bits), 'bin_pt_ab', num2str(n_bits-1), ...
          'quantization', quantization, 'overflow', 'Saturate', ... %you want Saturate here
          'mult_latency', num2str(mult_latency), 'add_latency', num2str(add_latency), ...
          'conv_latency', num2str(conv_latency), 'conjugated', 'off', ...
          'async', 'on', 'pipelined_enable', 'off', ...
          'Position', [780 499 815 731]);
  add_line(blk, 'amux/1', 'cmult/1');
  add_line(blk, 'ri_to_c1/1', 'cmult/2');
  add_line(blk, 'cmult/1', 'amux/3', 'autorouting', 'on');

  reuse_block(blk, 'outmux', 'xbsIndex_r4/Mux', ...
          'inputs', '2', 'latency', '2', 'Position', [910 490 940 640]);
  add_line(blk, 'select/1', 'outmux/1', 'autorouting', 'on');
  add_line(blk, 'reference/1', 'outmux/2', 'autorouting', 'on');
  add_line(blk, 'cmult/1', 'outmux/3');

  reuse_block(blk, 'c_to_ri', 'casper_library_misc/c_to_ri', ...
          'n_bits', num2str(n_bits), 'bin_pt', num2str(n_bits-1), 'Position', [995 518 1020 607]);
  add_line(blk,'outmux/1','c_to_ri/1');
  
  %en input

  reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'latency', 'bram_latency', 'Position', [285 769 345 791]);
  add_line(blk, 'en/1', 'den0/1');
  add_line(blk, 'den0/1', 'cmult/3');
  add_line(blk, 'den0/1', 'amux/4');
  reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'latency', '2', 'Position', [895 769 955 791]);
  add_line(blk, 'den0/1', 'den1/1');

  %sync
  reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', 'latency', 'bram_latency+2', 'Position', [550 859 610 881]);
  add_line(blk, 'sync/1', 'dsync/1');

  %misc
  reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', 'latency', 'bram_latency+2', 'Position', [550 809 610 831]);
  add_line(blk, 'misci/1', 'dmisc/1');

  %output ports
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1075 863 1105 877]);
  add_line(blk, 'dsync/1', 'sync_out/1'); 

  reuse_block(blk, 'cos', 'built-in/Outport', 'Port', '2', 'Position', [1075 533 1105 547]);
  add_line(blk, 'c_to_ri/1', 'cos/1'); 

  reuse_block(blk, '-sin', 'built-in/Outport', 'Port', '3', 'Position', [1075 578 1105 592]);
  add_line(blk, 'c_to_ri/2', '-sin/1'); 

  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', 'Position', [1075 773 1105 787]);
  add_line(blk, 'den1/1', 'dvalid/1'); 

  reuse_block(blk, 'misco', 'built-in/Outport', 'Port', '5', 'Position', [1075 813 1105 827]);
  add_line(blk, 'dmisc/1', 'misco/1'); 

  clean_blocks(blk);
  args = {'n_bits', n_bits, 'n_bits_rotation', n_bits_rotation, 'phase_initial', phase_initial, ...
    'phase_step_bits', phase_step_bits, 'phase_steps_bits', phase_steps_bits, ...
    'ref_values_bits', ref_values_bits, 'bram_latency', bram_latency, 'mult_latency', mult_latency, ...
    'add_latency', add_latency, 'conv_latency', conv_latency, 'bram', bram, 'quantization', quantization};

  fmtstr = sprintf('%d cal vals',2^(wcl_bits+ref_values_bits));
  set_param(blk, 'AttributesFormatString', fmtstr);
  save_state(blk, 'defaults', defaults, args{:});
end % feedback_osc_new_init

