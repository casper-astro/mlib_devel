function convert_init(blk,varargin)
% Configure a convert block
%
% convert_init(blk, bin_pt_in, ...
%   n_bits_out, bin_pt_out, quantization, overflow, latency)
%
% blk = Block to configure
% bin_pt_in = Specifies the binary point of the real/imag input components.
% n_bits_out = Specifies the width of the real/imaginary output components.
% bin_pt_out = Specifies the binary point of the real/imag output components.
% quantization = Quantization mode
%                1 = 'Truncate'
%                2 = 'Round  (unbiased: +/- Inf)'
%                3 = 'Round  (unbiased: Even Values)'
%                4 = 'Round  (unbiased: Zero)'
%                5 = 'Round  (unbiased: Odd Values)'
%                6 = 'Round  (biased: Up)'
%                7 = 'Round  (biased: Down)'
% overflow = Overflow mode
%            1 = 'Wrap'
%            2 = 'Saturate'
% latency = The latency of the underlying adder block.

check_mask_type(blk, 'convert');

defaults = {'latency', 2};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});
bin_pt_in = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
n_bits_out = get_var('n_bits_out', 'defaults', defaults, varargin{:});
bin_pt_out = get_var('bin_pt_out', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
latency = get_var('latency', 'defaults', defaults, varargin{:});

% If bin_pt_out == bin_pt_in, set quantization mode to truncate
if bin_pt_out == bin_pt_in
    quantization = 'Truncate';
end

% Calc number of fractional bits that will be chopped
chop=bin_pt_in-bin_pt_out;
if chop < 0
  errordlg('Does not support upscaling of fractional bits.')
end

% Setup some defaults for round to even
  qparam = 'Round  (unbiased: Even Values)';
  qstr='round even';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='AND';
  almost_half=2^chop-1;

% Override above defaults based on quantization mode
switch quantization
case 'Truncate'
  qstr='truncate';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='NOR';
  almost_half=0;
case 'Round  (unbiased: +/- Inf)'
  qstr='round inf';
  slice_base0='MSB of Input';
  slice_bit0=chop;
  slice_bit0=0;
  tweak_op='XOR';
case 'Round  (unbiased: Even Values)'
  qstr='round even';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='AND';
  almost_half=2^chop-1;
case 'Round  (unbiased: Zero)'
  qstr='round zero';
  slice_base0='MSB of Input';
  slice_bit0=chop;
  slice_bit0=0;
case 'Round  (unbiased: Odd Values)'
  qstr='round odd';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='XOR';
case 'Round  (biased: Up)'
  qstr='round half up';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='OR';
case 'Round  (biased: Down)'
  qstr='round half down';
  slice_base0='LSB of Input';
  slice_bit0=chop;
  tweak_op='NOR';
end

% Setup bit slice
set_param([blk,'/bit'], ...
    'base0', num2str(slice_base0), ...
    'bit0', num2str(slice_bit0));

  % Setup tweak
  set_param([blk,'/tweak_op'], ...
    'logical_function', tweak_op);

  % Setup almost_half
  set_param([blk,'/almost_half'], ...
    'const', num2str(almost_half), ...
    'n_bits', num2str(bin_pt_in+1));

  % Setup force blocks
  for name={'force1','force2'}
    set_param([blk,'/',name{1}], ...
      'bin_pt', num2str(bin_pt_in+1));
  end

  % Setup adder
  set_param([blk,'/adder'], ...
    'n_bits', num2str(n_bits_out), ...
    'bin_pt', num2str(bin_pt_out), ...
    'overflow', overflow, ...
    'latency', num2str(latency));

  % Set attribute format string (block annotation)
  annotation=sprintf('N_%d ==> %d_%d\n%s, %s\nlatency = %d', ...
    bin_pt_in,n_bits_out,bin_pt_out,qstr,lower(overflow),latency);
  set_param(blk,'AttributesFormatString',annotation);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter value
