function complex_convert_init(blk,varargin)
% Configure a complex_convert block
%
% complex_convert_init(blk, n_bits_in, bin_pt_in, ...
%   n_bits_out, bin_pt_out, quantization, overflow, latency)
%
% blk = Block to configure
% n_bits_in = Specifies the width of the real/imaginary input components.
% bin_pt_in = Specifies the binary point of the real/imag input components.
% n_bits_out = Specifies the width of the real/imaginary output components.
% bin_pt_out = Specifies the binary point of the real/imag output components.
% quantization = Quantization mode
%                1 = 'Truncate'
%                2 = 'Round  (unbiased: +/- Inf)'
%                3 = 'Round  (unbiased: Even Values)'
% overflow = Overflow mode
%            1 = 'Wrap'
%            2 = 'Saturate'
% latency = The latency of the underlying convert blocks.
%
% n_bits and bin_pt are assumed equal for both components.
check_mask_type(blk, 'complex_convert');

defaults = {};

% Bail out if state matches parameters
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

% Maybe munge block
munge_block(blk,varargin)

n_bits_in = get_var('n_bits_in','defaults',defaults,varargin{:});
bin_pt_in = get_var('bin_pt_in','defaults',defaults,varargin{:});
n_bits_out= get_var('n_bits_out','defaults',defaults,varargin{:});
bin_pt_out= get_var('bin_pt_out','defaults',defaults,varargin{:});
quantization= get_var('quantization','defaults',defaults,varargin{:});
overflow  = get_var('overflow','defaults',defaults,varargin{:});
latency   = get_var('latency','defaults',defaults,varargin{:});

%fprintf('quantisation: %s, overflow: %s',quantization,overflow);
switch quantization
case 'Truncate'
  qstr='truncate';
case 'Round  (unbiased: +/- Inf)'
  qstr='round inf';
case 'Round  (unbiased: Even Values)'
  qstr='round even';
otherwise
  errordlg('Error with quantization selection.');
end

switch overflow
case 'Wrap'
  ostr='wrap';
case 'Saturate'
  ostr='saturate';
otherwise
  errordlg('Error with overflow selection.');
end

for name={'convert_re','convert_im'}
set_param([blk,'/',name{1}], ...
  'n_bits',       num2str(n_bits_out), ...
  'bin_pt',       num2str(bin_pt_out), ...
  'quantization', quantization, ...
  'overflow',     overflow, ...
  'latency',      num2str(latency));
end

set_param([blk,'/c_to_ri'],'n_bits',num2str(n_bits_in));
set_param([blk,'/c_to_ri'],'bin_pt',num2str(bin_pt_in));

% Set attribute format string (block annotation)
annotation=sprintf('%d_%d ==> %d_%d\n%s, %s\nlatency = %d',n_bits_in, bin_pt_in, n_bits_out, bin_pt_out, qstr, ostr, latency);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});
