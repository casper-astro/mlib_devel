function cmult_init(blk, varargin)
% Configure a cmult block.
%
% cmult_init(blk, n_bits_b, bin_pt_b, n_bits_w, bin_pt_w, ...
%          n_bits_bw, bin_pt_bw, quantization, overflow, ...
%          mult_latency, add_latency)
%
% blk = Block to configure
% n_bits_X = Number of bits for port X.
%            Assumed equal for both components.
% bin_pt_X = Binary Point for port X.
%            Assumed equal for both components.
% quantization = Quantization mode
%                1 = 'Truncate'
%                2 = 'Round  (unbiased: +/- Inf)'
%                3 = 'Round  (unbiased: Even Values)'
% overflow - Overflow mode
%            1 = 'Wrap'
%            2 = 'Saturate'
% mult_latency = Latency to use for the underlying real multipliers.
% add_latency = Latency to use for the underlying real adders.
% conjugated = Whether or not to conjugate the 'a' input.

  defaults = { ...
    'n_bits_a', 18, ...
    'bin_pt_a', 17, ...
    'n_bits_b', 18, ...
    'bin_pt_b', 17, ...
    'n_bits_ab', 37, ...
    'bin_pt_ab', 14, ...
    'quantization', 'Truncate', ...
    'overflow', 'Wrap', ...
    'mult_latency', 3, ...
    'add_latency', 1, ...
    'conv_latency', 1, ...
    'conjugated', 'off', ...
    'async', 'off', ...
    'pipelined_enable', 'on', ...
    'multiplier_implementation', 'behavioral HDL', ... 'embedded multiplier core' 'standard core'
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end

  munge_block(blk,varargin);

  n_bits_a                  = get_var('n_bits_a','defaults',defaults,varargin{:});
  n_bits_b                  = get_var('n_bits_b','defaults',defaults,varargin{:});
  n_bits_ab                 = get_var('n_bits_ab','defaults',defaults,varargin{:});
  bin_pt_a                  = get_var('bin_pt_a','defaults',defaults,varargin{:});
  bin_pt_b                  = get_var('bin_pt_b','defaults',defaults,varargin{:});
  bin_pt_ab                 = get_var('bin_pt_ab','defaults',defaults,varargin{:});
  quantization              = get_var('quantization','defaults',defaults,varargin{:});
  overflow                  = get_var('overflow','defaults',defaults,varargin{:});
  mult_latency              = get_var('mult_latency','defaults',defaults,varargin{:});
  add_latency               = get_var('add_latency','defaults',defaults,varargin{:});
  conv_latency              = get_var('conv_latency','defaults',defaults,varargin{:});
  conjugated                = get_var('conjugated','defaults',defaults,varargin{:});
  async                     = get_var('async','defaults',defaults,varargin{:});
  pipelined_enable          = get_var('pipelined_enable','defaults',defaults,varargin{:});
  multiplier_implementation = get_var('multiplier_implementation','defaults',defaults,varargin{:});

  delete_lines(blk);

  if n_bits_a == 0 || n_bits_b == 0,
    clean_blocks(blk);
    set_param(blk,'AttributesFormatString','');
    save_state(blk, 'defaults', defaults, varargin{:});
    return;
  end

  if (n_bits_a < bin_pt_a),
      errordlg('Number of bits for a input must be greater than binary point position.'); return; end
  if (n_bits_b < bin_pt_b),
      errordlg('Number of bits for b input must be greater than binary point position.'); return; end
  if (n_bits_ab < bin_pt_ab),
      errordlg('Number of bits for ab input must be greater than binary point position.'); return; end

  latency=mult_latency+add_latency+conv_latency;

  %ports

  reuse_block(blk, 'a', 'built-in/Inport', ...
          'Port', '1', ...
          'Position', [65 143 95 157]);

  reuse_block(blk, 'c_to_ri', 'casper_library_misc/c_to_ri', ...
          'n_bits', 'n_bits_a', ...
          'bin_pt', 'bin_pt_a', ...
          'Position', [130 129 170 171]);
  add_line(blk,'a/1','c_to_ri/1');

  reuse_block(blk, 'b', 'built-in/Inport', ...
          'Port', '2', ...
          'Position', [65 333 95 347]);
 
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', ...
            'Port', '3', ...
            'Position', [145 438 175 452]);
  end 
 
  reuse_block(blk, 'c_to_ri1', 'casper_library_misc/c_to_ri', ...
          'n_bits', 'n_bits_b', ...
          'bin_pt', 'bin_pt_b', ...
          'Position', [135 319 175 361]);
  add_line(blk,'b/1','c_to_ri1/1');

  %multipliers

  if strcmp(multiplier_implementation, 'behavioral HDL'),
    use_behavioral_HDL = 'on';
    use_embedded = 'off';
  else
    use_behavioral_HDL = 'off';
    if strcmp(multiplier_implementation, 'embedded multiplier core'),
      use_embedded = 'on';
    elseif strcmp(multiplier_implementation, 'standard core'),
      use_embedded = 'off';
    else,
    end
  end

  reuse_block(blk, 'rere', 'xbsIndex_r4/Mult', 'Position', [290 102 340 153]);
  add_line(blk,'c_to_ri/1','rere/1');
  add_line(blk,'c_to_ri1/1','rere/2');

  reuse_block(blk, 'imim', 'xbsIndex_r4/Mult', 'Position', [290 172 340 223]);
  add_line(blk,'c_to_ri/2','imim/1');
  add_line(blk,'c_to_ri1/2','imim/2');

  reuse_block(blk, 'imre', 'xbsIndex_r4/Mult', 'Position', [290 267 340 318]);
  add_line(blk,'c_to_ri/2','imre/1');
  add_line(blk,'c_to_ri1/1','imre/2');

  reuse_block(blk, 'reim', 'xbsIndex_r4/Mult', 'Position', [290 337 340 388]);
  add_line(blk,'c_to_ri/1','reim/1');
  add_line(blk,'c_to_ri1/2','reim/2');

  for name = {'rere', 'imim', 'imre', 'reim'},
    set_param([blk, '/', name{1}], ...
          'use_behavioral_HDL', use_behavioral_HDL, ...
          'use_embedded', use_embedded, ...
          'en', async, ...
          'latency', 'mult_latency');
  end

  if strcmp(async, 'on'),
    if strcmp(pipelined_enable, 'on'), latency = mult_latency;
    else, latency = 0;
    end
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', ...
      'latency', num2str(latency), ...
      'Position', [300 435 330 455]);
    add_line(blk, 'en/1', 'den0/1');
    for name = {'rere', 'reim', 'imre', 'imim'}
      add_line(blk, 'en/1', [name{1},'/3']);
    end
  end

  %add/subs
  reuse_block(blk, 'addsub_re', 'xbsIndex_r4/AddSub', ...
          'Position', [400 94 450 236]);
  add_line(blk,'rere/1','addsub_re/1');
  add_line(blk,'imim/1','addsub_re/2');

  reuse_block(blk, 'addsub_im', 'xbsIndex_r4/AddSub', ...
          'Position', [400 259 450 401]);
  add_line(blk,'imre/1','addsub_im/1');
  add_line(blk,'reim/1','addsub_im/2');

  %common parameters
  for name = {'addsub_re', 'addsub_im'},
    set_param([blk, '/', name{1}], ...
      'en', async, ...
      'use_behavioral_HDL', 'on', ...
      'pipelined', 'on', ...
      'latency', 'add_latency', ...
      'use_rpm', 'on');
  end

  % Set conjugation mode.
  if strcmp(conjugated, 'on'),
    set_param([blk, '/addsub_re'], 'mode', 'Addition');
    set_param([blk, '/addsub_im'], 'mode', 'Subtraction');
  else,
    set_param([blk, '/addsub_re'], 'mode', 'Subtraction');
    set_param([blk, '/addsub_im'], 'mode', 'Addition');
  end
  
  if strcmp(async, 'on'),
    if strcmp(pipelined_enable, 'on'), latency = add_latency;
    else, latency = 0;
    end
    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', ...
      'latency', num2str(latency), ...
      'Position', [410 435 440 455]);
    add_line(blk, 'den0/1', 'den1/1');
    
    for name = {'addsub_re', 'addsub_im'}
      add_line(blk, 'den0/1', [name{1},'/3']);
    end
  end
 
%code below taken from original cmult_init script but unsure of what is supposed to happen 
%  % If overflow mode is "wrap", do the wrap for free in the multipliers
%  % and post-multiply adders to save bits.
  wrapables={'rere','imim','imre','reim','addsub_re','addsub_im'};
%  if overflow == 1,
%    bin_pt_wrap=bin_pt_b+bin_pt_a;
%    n_bits_wrap=(n_bits_ab-bin_pt_ab)+bin_pt_wrap;

%    for name=wrapables
%      set_param([blk,'/',name{1}], ...
%        'precision',    'User Defined', ...
%        'arith_type',   'Signed  (2''s comp)', ...
%        'n_bits',        num2str(n_bits_wrap), ...
%        'bin_pt',        num2str(bin_pt_wrap), ...
%        'quantization', 'Truncate', ...
%        'overflow',     'Wrap');
%    end
%  else
    for name=wrapables
      set_param([blk,'/',name{1}],'precision','Full');
    end
%  end

  %convert
  reuse_block(blk, 'convert_re', 'xbsIndex_r4/Convert', ...
          'Position', [515 150 560 180]);
  add_line(blk,'addsub_re/1','convert_re/1');

  reuse_block(blk, 'convert_im', 'xbsIndex_r4/Convert', ...
          'Position', [515 315 560 345]);
  add_line(blk,'addsub_im/1','convert_im/1');

  for name={'convert_re','convert_im'}
    set_param([blk,'/',name{1}], ...
      'en',           async, ...
      'n_bits',       num2str(n_bits_ab), ...
      'bin_pt',       num2str(bin_pt_ab), ...
      'quantization', quantization, ...
      'overflow',     overflow, ...
      'pipeline',     'on', ...
      'latency',      'conv_latency');
  end

  if strcmp(async, 'on'),
    if strcmp(pipelined_enable, 'on'),
      reuse_block(blk, 'den2', 'xbsIndex_r4/Delay', ...
        'latency', num2str(latency), ...
        'Position', [525 435 555 455]);
      add_line(blk, 'den1/1', 'den2/1');
    end
 
    for name = {'convert_re', 'convert_im'}
      add_line(blk, 'den1/1', [name{1},'/2']);
    end
  end

  %output ports

  reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
          'Position', [660 229 700 271]);
  add_line(blk,'convert_re/1','ri_to_c/1');
  add_line(blk,'convert_im/1','ri_to_c/2');

  reuse_block(blk, 'ab', 'built-in/Outport', ...
          'Port', '1', ...
          'Position', [745 243 775 257]);
  add_line(blk,'ri_to_c/1','ab/1');

  if strcmp(async, 'on') && strcmp(pipelined_enable, 'on'),
    reuse_block(blk, 'dvalid', 'built-in/Outport', ...
      'Port', '2', ...
      'Position', [745 438 775 452]);
    add_line(blk, 'den2/1', 'dvalid/1');
  end

  clean_blocks(blk);

  % Set attribute format string (block annotation)
  annotation=sprintf('%d_%d * %d_%d ==> %d_%d\n%s, %s\nLatency=%d', ...
    n_bits_a,bin_pt_a,n_bits_b,bin_pt_b,n_bits_ab,bin_pt_ab,quantization,overflow,latency);
  set_param(blk,'AttributesFormatString',annotation);

  % Save and back-populate mask parameter values
  save_state(blk, 'defaults', defaults, varargin{:});

