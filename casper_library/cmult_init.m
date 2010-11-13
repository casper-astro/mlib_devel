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
    'conjugated', 'off', ...
  };

  % Bail out if state matches parameters
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end

  % Maybe munge block
  munge_block(blk,varargin);

  n_bits_a = get_var('n_bits_a','defaults',defaults,varargin{:});
  n_bits_b = get_var('n_bits_b','defaults',defaults,varargin{:});
  n_bits_ab = get_var('n_bits_ab','defaults',defaults,varargin{:});
  bin_pt_a = get_var('bin_pt_a','defaults',defaults,varargin{:});
  bin_pt_b = get_var('bin_pt_b','defaults',defaults,varargin{:});
  bin_pt_ab = get_var('bin_pt_ab','defaults',defaults,varargin{:});
  quantization = get_var('quantization','defaults',defaults,varargin{:});
  overflow = get_var('overflow','defaults',defaults,varargin{:});
  mult_latency = get_var('mult_latency','defaults',defaults,varargin{:});
  add_latency = get_var('add_latency','defaults',defaults,varargin{:});
  conjugated = get_var('conjugated','defaults',defaults,varargin{:});
  conv_latency = 0;

  if (n_bits_a < bin_pt_a),
      errordlg('Number of bits for a input must be greater than binary point position.'); return; end
  if (n_bits_b < bin_pt_b),
      errordlg('Number of bits for b input must be greater than binary point position.'); return; end
  if (n_bits_ab < bin_pt_ab),
      errordlg('Number of bits for ab input must be greater than binary point position.'); return; end

  switch quantization
    case 'Truncate'
      qparam='Truncate';
      qstr='truncate';
    case 'Round  (unbiased: +/- Inf)'
      qparam = 'Round  (unbiased: +/- Inf)';
      qstr='round inf';
      conv_latency=3;
    case  'Round  (unbiased: Even Values)'
      qparam = 'Round  (unbiased: Even Values)';
      qstr='round even';
      conv_latency=3;
    otherwise
        errordlg('Invalid quantisation setting');
  end

  switch overflow
    case 'Wrap'
      oparam='Wrap';
      ostr='wrap';
    case 'Saturate'
      oparam = 'Saturate';
      ostr='saturate';
      conv_latency=3;
    otherwise
      errordlg('Invalid overflow setting');
  end

  latency=mult_latency+add_latency+conv_latency;

  % If overflow mode is "wrap", do the wrap for free in the multipliers
  % and post-multiply adders to save bits.
  wrapables={'rere','imim','imre','reim','addsub_re','addsub_im'};
  if overflow == 1
    bin_pt_wrap=bin_pt_b+bin_pt_a;
    n_bits_wrap=(n_bits_ab-bin_pt_ab)+bin_pt_wrap;

    for name=wrapables
      set_param(find_by_name(blk,name{1}), ...
        'precision',    'User Defined', ...
        'arith_type',   'Signed  (2''s comp)', ...
        'n_bits',        num2str(n_bits_wrap), ...
        'bin_pt',        num2str(bin_pt_wrap), ...
        'quantization', 'Truncate', ...
        'overflow',     'Wrap');
    end
  else
    for name=wrapables
      set_param([blk,'/',name{1}],'precision','Full');
    end
  end

  set_param([blk,'/rere'],'latency',num2str(mult_latency));
  set_param([blk,'/imim'],'latency',num2str(mult_latency));
  set_param([blk,'/imre'],'latency',num2str(mult_latency));
  set_param([blk,'/reim'],'latency',num2str(mult_latency));

  set_param([blk,'/addsub_re'],'latency',num2str(add_latency));
  set_param([blk,'/addsub_im'],'latency',num2str(add_latency));

  for name={'convert_re','convert_im'}
    set_param([blk,'/',name{1}], ...
      'n_bits',       num2str(n_bits_ab), ...
      'bin_pt',       num2str(bin_pt_ab), ...
      'quantization', qparam, ...
      'overflow',     oparam, ...
      'latency',      num2str(conv_latency));
  end

  set_param([blk,'/c_to_ri'],'n_bits',num2str(n_bits_a));
  set_param([blk,'/c_to_ri1'],'n_bits',num2str(n_bits_b));
  set_param([blk,'/c_to_ri'],'bin_pt',num2str(bin_pt_a));
  set_param([blk,'/c_to_ri1'],'bin_pt',num2str(bin_pt_b));

  % Set conjugation mode.
  if strcmp(conjugated, 'on'),
    set_param([blk, '/addsub_re'], 'mode', 'Addition');
    set_param([blk, '/addsub_im'], 'mode', 'Subtraction');
  else,
    set_param([blk, '/addsub_re'], 'mode', 'Subtraction');
    set_param([blk, '/addsub_im'], 'mode', 'Addition');
  end

  % Set attribute format string (block annotation)
  annotation=sprintf('%d_%d * %d_%d ==> %d_%d\n%s, %s\nLatency=%d', ...
    n_bits_a,bin_pt_a,n_bits_b,bin_pt_b,n_bits_ab,bin_pt_ab,qstr,ostr,latency);
  set_param(blk,'AttributesFormatString',annotation);

  % Save and back-populate mask parameter values
  save_state(blk, 'defaults', defaults, varargin{:});

