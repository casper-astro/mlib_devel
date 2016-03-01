%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens (andrew@ska.ac.za)                      %
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

function pfb_fir_coeff_gen_init(blk, varargin)
  log_group = 'pfb_fir_coeff_gen_init_debug';
  clog('entering pfb_fir_coeff_gen_init', {'trace', log_group});

  defaults = { ...
    'n_inputs', 2, ...
    'pfb_size', 5, ...
    'n_taps', 4, ...
    'n_bits_coeff', 18, ...
    'WindowType', 'hamming', ...
    'fwidth', 1, ...
    'async', 'off', ...
    'bram_latency', 2, ...
    'fan_latency', 2, ...
    'add_latency', 1, ...
    'max_fanout', 1, ...
    'bram_optimization', 'Area', ...
  };
  
  check_mask_type(blk, 'pfb_fir_coeff_gen');

  yinc = 40;

%  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  n_inputs                    = get_var('n_inputs', 'defaults', defaults, varargin{:});
  pfb_size                    = get_var('pfb_size', 'defaults', defaults, varargin{:});
  n_taps                      = get_var('n_taps', 'defaults', defaults, varargin{:});
  n_bits_coeff                = get_var('n_bits_coeff', 'defaults', defaults, varargin{:});
  WindowType                  = get_var('WindowType', 'defaults', defaults, varargin{:});
  fwidth                      = get_var('fwidth', 'defaults', defaults, varargin{:});
  async                       = get_var('async', 'defaults', defaults, varargin{:});
  bram_latency                = get_var('bram_latency', 'defaults', defaults, varargin{:});
  fan_latency                 = get_var('fan_latency', 'defaults', defaults, varargin{:});
  add_latency                 = get_var('add_latency', 'defaults', defaults, varargin{:});
  max_fanout                  = get_var('max_fanout', 'defaults', defaults, varargin{:});
  bram_optimization           = get_var('bram_optimization', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default empty block for storage in library
  if n_taps == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting pfb_fir_coeff_gen_init', {'trace', log_group});
    return;
  end

  %check parameters
  if n_taps < 4,
    clog('need at least 4 taps', {'error', log_group});
    error('need at least 4 taps');
    return;
  end
  
  if mod(n_taps, 2) ~= 0,
    clog('Number of taps must be an even number', {'error', log_group});
    error('Number of taps must be an even number');
    return;
  end
    
  %get hardware platform from XSG block
  try
    xsg_blk = find_system(bdroot, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
    hw_sys = xps_get_hw_plat(get_param(xsg_blk{1},'hw_sys'));
  catch,
    clog('Could not find hardware platform - is there an XSG block in this model? Defaulting platform to ROACH.', {log_group});
    warning('pfb_fir_coeff_gen_init: Could not find hardware platform - is there an XSG block in this model? Defaulting platform to ROACH.');
    hw_sys = 'ROACH';
  end %try/catch

  %parameters to decide optimisation parameters
  switch hw_sys
    case 'ROACH'
      port_width = 36; %upper limit
    case 'ROACH2'
      port_width = 36; %upper limit
  end %switch

  yoff = 226;

  %%%%%%%%%%%%%%%%%
  % sync pipeline %
  %%%%%%%%%%%%%%%%%

  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [15 23 45 37]);
  reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(fan_latency+bram_latency+1), 'Position', [255 22 1035 38]);
  add_line(blk,'sync/1', 'sync_delay/1');
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1185 23 1215 37]);
  add_line(blk,'sync_delay/1', 'sync_out/1');
 
  %%%%%%%%%%%%%%%%
  % din pipeline %
  %%%%%%%%%%%%%%%%

  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [15 68 45 82]);
  reuse_block(blk, 'din_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on',...
    'latency', num2str(fan_latency+bram_latency+1), 'Position', [255 67 1035 83]);
  add_line(blk, 'din/1', 'din_delay/1');
  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [1185 68 1215 82]);
  add_line(blk,'din_delay/1', 'dout/1');

  %%%%%%%%%%%%%%%%%%%%%%%%%%
  % coefficient generation %
  %%%%%%%%%%%%%%%%%%%%%%%%%%

  % address generation
  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Free Running', 'operation', 'Up', 'start_count', '0', 'cnt_by_val', '1', ...
    'n_bits', num2str(pfb_size-n_inputs), 'arith_type', 'Unsigned', 'bin_pt', '0', ...
    'rst', 'on', 'en', async, ...
    'Position', [95 211 145 264]);
  add_line(blk, 'sync/1', 'counter/1'); 

  %we invert the address to get address for the other half of the taps
  reuse_block(blk, 'inverter', 'xbsIndex_r4/Inverter', ...
    'latency', '0', 'Position', [175 318 210 342]);
  add_line(blk, 'counter/1', 'inverter/1'); 
 
  % ROM generation
  outputs_required = 2^n_inputs*(n_taps/2); 
  
  % constants
  reuse_block(blk, 'rom_din', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Unsigned', ...
        'n_bits', num2str(outputs_required*n_bits_coeff), 'bin_pt', '0', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [255 262 275 278]);
  reuse_block(blk, 'rom_we', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Boolean', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [255 292 275 308]);

  % rom
  init_vector = '';
  for tap_index = 1:(n_taps/2), 
    for input_index = 0:(2^n_inputs)-1,
      vec = ['pfb_coeff_gen_calc(', num2str(pfb_size), ', ', num2str(n_taps), ', ''', WindowType, ''', ', num2str(n_inputs), ', ', num2str(input_index), ', ', num2str(fwidth), ', ', num2str(tap_index), ', false)'''];
      if(tap_index == 1 && input_index == 0), init_vector = vec; 
      else, init_vector = [init_vector, ', ', vec];
      end
    end %for input_index
  end %for tap_index

  reuse_block(blk, 'rom', 'casper_library_bus/bus_dual_port_ram', ...
          'n_bits', mat2str(repmat(n_bits_coeff, 1, outputs_required)), ...
          'bin_pts', mat2str(repmat(n_bits_coeff-1, 1, outputs_required)), ...
          'init_vector', ['[', init_vector, ']'], ...
          'max_fanout', num2str(max_fanout), ...
          'mem_type', 'Block RAM', 'bram_optimization', bram_optimization, ...
          'async_a', 'off', 'async_b', 'off', 'misc', 'off', ...
          'bram_latency', num2str(bram_latency), ...
          'fan_latency', num2str(fan_latency), ...
          'addra_register', 'on', 'addra_implementation', 'core', ...
          'dina_register', 'off', 'dina_implementation', 'behavioral', ...
          'wea_register', 'off', 'wea_implementation', 'behavioral', ...
          'addrb_register', 'on', 'addra_implementation', 'core', ...
          'dinb_register', 'off', 'dinb_implementation', 'behavioral', ...
          'web_register', 'off', 'web_implementation', 'behavioral', ...
          'Position', [330 226 385 404]);
  add_line(blk, 'counter/1', 'rom/1');
  add_line(blk, 'inverter/1', 'rom/4');
  add_line(blk, 'rom_din/1', 'rom/2');
  add_line(blk, 'rom_din/1', 'rom/5');
  add_line(blk, 'rom_we/1', 'rom/3');
  add_line(blk, 'rom_we/1', 'rom/6');

  % logic for second half of taps 
  % Coefficients are not quite symmetrical, they are off by one, and do not overlap by one
  % e.g with T taps and fft size of N: tap T-1, sample 0 is not the same as tap 0, sample N-1
  % instead it is unique and not included in the coefficients for Tap 0

  reuse_block(blk, 'zero', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Unsigned', ...
        'n_bits', num2str(pfb_size-n_inputs), 'bin_pt', '0', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [185 122 205 138]);
  
  reuse_block(blk, 'first', 'xbsIndex_r4/Relational' , ...
        'latency', num2str(fan_latency), 'mode', 'a=b', 'Position', [255 114 285 176]);
  add_line(blk, 'counter/1', 'first/2');
  add_line(blk, 'zero/1', 'first/1');
  
  reuse_block(blk, 'dfirst', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(bram_latency), 'Position', [385 136 925 154] );
  add_line(blk, 'first/1', 'dfirst/1');

  % reorder output of port B 
  order = zeros(1, n_taps/2 * 2^n_inputs);
  for tap_index = 0:n_taps/2-1,
    for input_index = 0:2^n_inputs-1,
      offset = ((n_taps/2)-tap_index-1) * (2^n_inputs);
      if input_index == 0, index = offset;
      else, index = offset + (2^n_inputs - input_index);
      end
    
      order(tap_index*(2^n_inputs) + input_index + 1) = index;
    end %for
  end %for

  reuse_block(blk, 'munge', 'casper_library_flow_control/munge', ...
    'divisions', num2str(outputs_required), ...
    'div_size', mat2str(repmat(n_bits_coeff, 1, outputs_required)), ...
    'order', mat2str(order), 'arith_type_out', 'Unsigned', 'bin_pt_out', '0', ... 
    'Position', [435 377 475 403] );
  add_line(blk, 'rom/2', 'munge/1');
  
  % coefficient extraction
  reuse_block(blk, 'a_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(outputs_required), ...
    'outputWidth', num2str(n_bits_coeff), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [620 yoff 670 yoff+(outputs_required*yinc)]);
  add_line(blk, 'rom/1', 'a_expand/1');
  
  reuse_block(blk, 'b_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(outputs_required), ...
    'outputWidth', num2str(n_bits_coeff), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [515 yoff+(outputs_required*yinc) 565 yoff+(outputs_required*yinc*2)]);
  add_line(blk, 'munge/1', 'b_expand/1');

  reuse_block(blk, 'coeffs', 'built-in/Outport', 'Port', '3', ...
    'Position', [1185 yoff+outputs_required*yinc-7 1215 yoff+outputs_required*yinc+7]);

  % concat a and b busses together
  reuse_block(blk, 'concat', 'xbsIndex_r4/Concat', ...
    'num_inputs', num2str(outputs_required*2), ...
    'Position', [1095 yoff 1120 yoff+(outputs_required*2*yinc)]); 
  add_line(blk, 'concat/1', 'coeffs/1');

  % delays for each output
  for d_index = 0:outputs_required*2-1,
    src_port = mod(d_index, outputs_required) + 1;
    d_name = ['d',num2str(d_index)];

    if ((d_index/outputs_required) < 1),
      reuse_block(blk, d_name, 'xbsIndex_r4/Delay', ...
        'latency', '1', 'reg_retiming', 'on', ...
        'Position', [980 yoff+d_index*yinc 1035 yoff+d_index*yinc+18]);

      src_blk = 'a_expand';
      add_line(blk, [src_blk, '/', num2str(src_port)], [d_name, '/1']);
    else,
      %if first element of coefficients for tap, need to choose a special first value
      if mod(d_index, 2^n_inputs) == 0,
        reuse_block(blk, d_name, 'xbsIndex_r4/Delay', ...
          'latency', '1', 'reg_retiming', 'on', 'en', async, ...
          'Position', [745 yoff+d_index*yinc 800 yoff+d_index*yinc+18]);

        add_line(blk, ['b_expand/', num2str(src_port)], [d_name, '/1']);

        offset = d_index - outputs_required;
        vector = pfb_coeff_gen_calc(pfb_size, n_taps, WindowType, n_inputs, 0, fwidth, n_taps/2+1+offset/(2^n_inputs), false);
        m_name = ['mux', num2str(offset/2^n_inputs)];
        c_name = ['const',num2str(offset/2^n_inputs)];
        r_name = ['reinterpret',num2str(offset/2^n_inputs)];
        reuse_block(blk, c_name, 'xbsIndex_r4/Constant', ...
          'const', num2str(vector(1)), 'explicit_period', 'on', 'period', '1', ...
          'arith_type', 'Signed (2''s comp)', 'n_bits', num2str(n_bits_coeff), 'bin_pt', num2str(n_bits_coeff-1), ...
          'Position', [620 yoff+(d_index*yinc)+20 740 yoff+(d_index*yinc)+40]);
        reuse_block(blk, r_name, 'xbsIndex_r4/Reinterpret', ...
          'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
          'force_bin_pt', 'on', 'bin_pt', '0', ...
          'Position', [840 yoff+(d_index*yinc)+20 890 yoff+(d_index*yinc)+40]);
        reuse_block(blk, m_name, 'xbsIndex_r4/Mux', ...
          'latency', '1', 'inputs', '2', ...
          'Position', [980 yoff+(d_index*yinc)-10 1035 yoff+(d_index*yinc)+25]);
	add_line(blk, [c_name,'/1'], [r_name, '/1']);
	add_line(blk, [r_name,'/1'], [m_name, '/3']);
    	add_line(blk, 'dfirst/1', [m_name,'/1']);    
        add_line(blk, [d_name, '/1'], [m_name, '/2']);
        
	d_name = m_name;
      else,
        reuse_block(blk, d_name, 'xbsIndex_r4/Delay', ...
          'latency', '1', 'reg_retiming', 'on', ...
          'Position', [980 yoff+d_index*yinc 1035 yoff+d_index*yinc+18]);

        src_blk = 'b_expand';
        add_line(blk, [src_blk, '/', num2str(src_port)], [d_name, '/1']);
      end
    end
    add_line(blk, [d_name,'/1'], ['concat/',num2str(d_index+1)]);    

  end %for 
  
  % asynchronous pipeline
  if strcmp(async, 'on'),
    yoff = 226;

    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '3', ...
      'Position', [15 243 45 257]);
    add_line(blk, 'en/1', 'counter/2');  
 
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(fan_latency+bram_latency), ...
      'Position', [255 yoff+(outputs_required*2+2)*yinc 670 yoff+(outputs_required*2+2)*yinc+18]);
    add_line(blk, 'en/1', 'den0/1');
          
    for n = n_taps/2:n_taps-1,
      add_line(blk, 'den0/1', ['d', num2str(n*2^n_inputs), '/2']);
    end
    
    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', '1', ...
      'Position', [980 yoff+(outputs_required*2+2)*yinc 1035 yoff+(outputs_required*2+2)*yinc+18]);
    add_line(blk, 'den0/1', 'den1/1');
    
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', ...
      'Position', [1185 yoff+(outputs_required*2+2)*yinc+2 1215 yoff+(outputs_required*2+2)*yinc+16]);
    add_line(blk, 'den1/1', 'dvalid/1');

  end %if async

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_coeff_gen_init', {'trace', log_group});

end %pfb_fir_coeff_gen_init
