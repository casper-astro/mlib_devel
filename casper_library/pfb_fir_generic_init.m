
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens                                         %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pfb_fir_generic_init(blk, varargin)
  clog('entering pfb_fir_generic_init', 'trace');

  defaults = { ...
    'n_streams', 1, ...
    'PFBSize', 5, ...
    'TotalTaps', 4, ...
    'WindowType', 'hamming', ...
    'n_inputs', 0, ...
    'BitWidthIn', 8, ...
    'BitWidthOut', 18, ...
    'CoeffBitWidth', 12, ...
    'complex', 'on', ...
    'async', 'on', ...
    'mult_latency', 2, ...
    'add_latency', 1, ...
    'bram_latency', 2, ...
    'fan_latency', 1, ...
    'conv_latency', 1, ...
    'quantization', 'Truncate', ...
    'fwidth', 1, ...
    'fanout', 4, ...
  };
  
  check_mask_type(blk, 'pfb_fir_generic');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_streams                   = get_var('n_streams', 'defaults', defaults, varargin{:});
  PFBSize                     = get_var('PFBSize', 'defaults', defaults, varargin{:});
  TotalTaps                   = get_var('TotalTaps', 'defaults', defaults, varargin{:});
  WindowType                  = get_var('WindowType', 'defaults', defaults, varargin{:});
  n_inputs                    = get_var('n_inputs', 'defaults', defaults, varargin{:});
  complex                     = get_var('complex', 'defaults', defaults, varargin{:});
  BitWidthIn                  = get_var('BitWidthIn', 'defaults', defaults, varargin{:});
  BitWidthOut                 = get_var('BitWidthOut', 'defaults', defaults, varargin{:});
  CoeffBitWidth               = get_var('CoeffBitWidth', 'defaults', defaults, varargin{:});
  complex                     = get_var('complex', 'defaults', defaults, varargin{:});
  async                       = get_var('async', 'defaults', defaults, varargin{:});
  mult_latency                = get_var('mult_latency', 'defaults', defaults, varargin{:});
  add_latency                 = get_var('add_latency', 'defaults', defaults, varargin{:});
  bram_latency                = get_var('bram_latency', 'defaults', defaults, varargin{:});
  fan_latency                 = get_var('fan_latency', 'defaults', defaults, varargin{:});
  conv_latency                = get_var('conv_latency', 'defaults', defaults, varargin{:});
  quantization                = get_var('quantization', 'defaults', defaults, varargin{:});
  fwidth                      = get_var('fwidth', 'defaults', defaults, varargin{:});
  multiplier_implementation   = get_var('multiplier_implementation', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  % default empty block for storage in library
  if TotalTaps == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting pfb_fir_generic_init','trace');
    return;
  end

  %check parameters
  if TotalTaps < 3,
    clog('need at least 3 taps', {'error', 'pfb_fir_generic_init_debug'});
    error('need at least 3 taps');
    return;
  end
    
  if strcmp(async, 'on') && fan_latency < 1,
    clog('fanout latency must be at least 1 for asynchonrous operation', {'error', 'pfb_fir_generic_init_debug'});
    error('fanout latency must be at least 1 for asynchonrous operation');
    return;
  end

  % Compute the maximum gain through all of the 2^PFBSize sub-filters.  This is
  % used to determine how much bit growth is really needed.  The maximum gain of
  % each filter is the sum of the absolute values of its coefficients.  The
  % maximum of these gains sets the upper bound on bit growth through the
  % pfb_fir.  The products, partial sums, and final sum throughout the pfb_fir
  % (including the adder tree) need not accomodate any more bit growth than the
  % absolute maximum gain requires, provided that any "overflow" is ignored (i.e.
  % set to "Wrap").  This works thanks to the wonders of modulo math.  Note that
  % the "gain" for typical signals will be different (less) than the absolute
  % maximum gain of each filter.  For Gaussian noise, the gain of a filter is the
  % square root of the sum of the squares of the coefficients (aka
  % root-sum-squares or RSS).

  % Get all coefficients of the pfb_fir in one vector (by passing -1 for a)
  all_coeffs = pfb_coeff_gen_calc(PFBSize, TotalTaps, WindowType, n_inputs, 0, fwidth, -1, false);
  % Rearrange into matrix with 2^PFBSize rows and TotalTaps columns.
  % Each row contains coefficients for one sub-filter.
  all_filters = reshape(all_coeffs, 2^PFBSize, TotalTaps);
  % Compute max gain
  % NB: sum rows, not columns!
  max_gain = max(sum(abs(all_filters), 2));
  % Compute bit growth (make sure it is non-negative)
  bit_growth = max(0, nextpow2(max_gain));
  % Compute adder output width and binary point.  We know that the adders in the
  % adder tree need to have (bit_growth+1) non-fractional bits to accommodate the
  % maximum gain.  The products from the taps will have
  % (BitWidthIn+CoeffBitWidth-2) fractional bits.  We will preserve them through
  % the adder tree.
  adder_bin_pt_out = BitWidthIn + CoeffBitWidth - 2;
  adder_n_bits_out = bit_growth + 1 + adder_bin_pt_out;

  %TODO add this optimisation

  % If BitWidthOut is 0, set it to accomodate bit growth in the
  % non-fractional part and full-precision of the fractional part.
  if BitWidthOut == 0
      BitWidthOut = adder_n_bits_out;
  end

  % input data pipeline

  yoff = 115;
  yinc = 40;
  n_inputs_total = n_streams*(2^n_inputs);

  reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
          'inputNum', num2str(n_inputs_total), 'Position', [80 yoff-15 140 yoff+((n_inputs_total-1)*yinc)+15]);

  if strcmp(complex, 'on'),
    outputWidth = BitWidthOut*2; outputBinaryPt = 0; outputArithmeticType = 0;
  else
    outputWidth = BitWidthOut; outputBinaryPt = BitWidthOut-1; outputArithmeticType = 1;
  end
  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', ...
          'outputNum', num2str(n_inputs_total), ...
          'outputWidth', num2str(outputWidth), ...
          'outputBinaryPt', num2str(outputBinaryPt), ...
          'outputArithmeticType', num2str(outputArithmeticType), ...
          'Position', [1000 yoff-15 1100 yoff+((n_inputs_total-1)*yinc)+15]);

  % data ports

  for stream_index = 0:n_streams-1,
    for port_index = 0:2^n_inputs-1,
      in_port_name = ['pol',num2str(stream_index), '_in', num2str(port_index)];
      port_no = stream_index*2^n_inputs + port_index;
      port_offset = port_index*n_streams + stream_index;

      in_position = [0 yoff+(port_offset*yinc)-8 30 yoff+(port_offset*yinc)+8];
      reuse_block(blk, in_port_name, 'built-in/Inport', 'Port', num2str(port_no+1), 'Position', in_position);
      add_line(blk,[in_port_name,'/1'], ['bus_create/',num2str(port_offset+1)]);

      out_port_name = ['pol',num2str(stream_index), '_out', num2str(port_index)];
      out_position = [1155 yoff+(port_offset*yinc)-8 1185 yoff+(port_offset*yinc)+8];
      reuse_block(blk, out_port_name, 'built-in/Outport', 'Port', num2str(port_no+1), 'Position', out_position);
      add_line(blk, ['bus_expand/',num2str(port_offset+1)], [out_port_name,'/1']);

    end %for n_inputs
  end %for n_streams

  % block to generate basic coefficients

  reuse_block(blk, 'pfb_fir_coeff_gen', 'casper_library_pfbs/pfb_fir_coeff_gen', ...
          'pfb_size', num2str(PFBSize), ...
          'n_taps', num2str(TotalTaps), ...
          'n_bits_coeff', num2str(CoeffBitWidth), ...
          'WindowType', WindowType, ...
          'n_inputs', num2str(n_inputs), ...
          'fwidth', num2str(fwidth), ...
          'async', async, ...
          'bram_latency', num2str(bram_latency), ...
          'fan_latency', num2str(fan_latency), ...
          'add_latency', num2str(add_latency), ...
          'Position', [285 33 380 197]);
  add_line(blk, 'bus_create/1', 'pfb_fir_coeff_gen/2'); 

  % replicate coefficients and pack them next to each other
  % also reverse the order of coefficients ...
  n_coeffs = TotalTaps*2^n_inputs;
  output_order = reshape([0:n_coeffs-1], 2^n_inputs, TotalTaps);
  output_order = output_order(:, TotalTaps:-1:1);
  output_order = reshape(repmat(reshape(output_order, 1, n_coeffs), n_streams, 1), 1, n_coeffs*n_streams);
  reuse_block(blk, 'coeff_munge', 'casper_library_flow_control/munge', ...
          'divisions', num2str(n_coeffs), ...
          'div_size', mat2str(repmat(CoeffBitWidth, 1, n_coeffs)), ...
          'order', mat2str(output_order), ...
          'arith_type_out', 'Unsigned', ...
          'bin_pt_out', '0', ...
          'Position', [440 119 485 151]);
  add_line(blk, 'pfb_fir_coeff_gen/3', 'coeff_munge/1');

  reuse_block(blk, 'pfb_fir_taps', 'casper_library_pfbs/pfb_fir_taps', ...
          'n_streams', num2str(n_streams), ...
          'n_inputs', num2str(n_inputs), ...
          'pfb_size', num2str(PFBSize), ...
          'n_taps', num2str(TotalTaps), ...
          'n_bits_data', num2str(BitWidthIn), ...
          'n_bits_coeff', num2str(CoeffBitWidth), ...
          'bin_pt_coeff', num2str(CoeffBitWidth-1), ...
          'complex', complex, ...
          'async', async, ...
          'mult_latency', num2str(mult_latency), ...
          'add_latency', num2str(add_latency), ...
          'bram_latency', num2str(bram_latency), ...
          'multiplier_implementation', 'behavioral HDL', ...
          'Position', [550 32 640 198]);
  add_line(blk, 'pfb_fir_coeff_gen/2', 'pfb_fir_taps/2');
  add_line(blk, 'coeff_munge/1', 'pfb_fir_taps/3');

  n_outputs_total = n_inputs_total;
  if strcmp(complex, 'on'), 
    n_outputs_total = n_outputs_total*2;
  end

  reuse_block(blk, 'bus_scale', 'casper_library_bus/bus_scale', ...
          'n_bits_in', mat2str(repmat(BitWidthIn+CoeffBitWidth+TotalTaps-1, 1, n_outputs_total)), ...
          'bin_pt_in', num2str(BitWidthIn-1+CoeffBitWidth-1), ...
          'scale_factor', num2str(-bit_growth), ...
          'misc', 'off', 'Position', [700 101 740 129]);
  add_line(blk, 'pfb_fir_taps/2', 'bus_scale/1');

  if strcmp(quantization, 'Truncate'), quant = 0;
  elseif strcmp(quantization, 'Round  (unbiased: +/- Inf)'), quant = 1;
  else quant = 2;
  end

  reuse_block(blk, 'bus_convert', 'casper_library_bus/bus_convert', ...
          'n_bits_in', mat2str(repmat(BitWidthIn+CoeffBitWidth+TotalTaps-1, 1, n_outputs_total)), ...
          'bin_pt_in', num2str(BitWidthIn-1+CoeffBitWidth-1+bit_growth), ...
          'n_bits_out', num2str(BitWidthOut), 'bin_pt_out', num2str(BitWidthOut-1), ...
          'quantization', num2str(quant), 'overflow', '0', ...\
          'latency', num2str(conv_latency), 'of', 'off', 'misc', 'off', ...
          'Position', [800 101 840 129]);
  add_line(blk, 'bus_scale/1', 'bus_convert/1');
  add_line(blk, 'bus_convert/1', 'bus_expand/1');

  % sync chain  

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [0 52 30 68]);
  add_line(blk, 'sync/1', 'pfb_fir_coeff_gen/1');
  add_line(blk, 'pfb_fir_coeff_gen/1', 'pfb_fir_taps/1');

  reuse_block(blk, 'sync_delay','xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', 'conv_latency', 'Position', [805 52 835 68]);
  add_line(blk, 'pfb_fir_taps/1', 'sync_delay/1');
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1155 52 1185 68]);
  add_line(blk, 'sync_delay/1', 'sync_out/1');

  % asynchronous infrastructure

  yoff = 115;
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', num2str(2+n_inputs_total), ...
      'Position', [95 yoff+(n_inputs_total*yinc)-8 125 yoff+(n_inputs_total*yinc)+8]);
    add_line(blk, 'en/1', 'pfb_fir_coeff_gen/3');
    add_line(blk, 'pfb_fir_coeff_gen/4', 'pfb_fir_taps/4');
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', 'conv_latency', 'Position', [805 162 835 178]);
    add_line(blk, 'pfb_fir_taps/3', 'den/1');
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', num2str(2+n_inputs_total), ...
      'Position', [1035 yoff+(n_inputs_total*yinc)-8 1065 yoff+(n_inputs_total*yinc)+8]);
    add_line(blk, 'den/1', 'dvalid/1');
  end %if async

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_generic_init','trace');

end % pfb_fir_generic_init

