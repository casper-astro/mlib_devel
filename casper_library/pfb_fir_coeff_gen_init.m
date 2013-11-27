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
    'async', 'on', ...
    'bram_latency', 2, ...
    'fan_latency', 2, ...
    'add_latency', 1, ...
    'max_fanout', 1, ...
    'bram_optimization', 'Area', ...
  };
  
  check_mask_type(blk, 'pfb_fir_coeff_gen');

  yinc = 40;

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
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
    'latency', num2str(fan_latency+bram_latency), 'Position', [255 22 515 38]);
  add_line(blk,'sync/1', 'sync_delay/1');
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [1060 23 1090 37]);
  add_line(blk,'sync_delay/1', 'sync_out/1');
 
  %%%%%%%%%%%%%%%%
  % din pipeline %
  %%%%%%%%%%%%%%%%

  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [15 68 45 82]);
  reuse_block(blk, 'din_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on',...
    'latency', num2str(fan_latency+bram_latency), 'Position', [255 67 515 83]);
  add_line(blk, 'din/1', 'din_delay/1');
  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [1060 68 1090 82]);
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
    'latency', '0', 'Position', [170 303 220 357]);
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
        'Position', [210 122 230 138]);
  
  reuse_block(blk, 'first', 'xbsIndex_r4/Relational' , ...
        'latency', '1', 'mode', 'a=b', 'Position', [295 114 325 176]);
  add_line(blk, 'counter/1', 'first/2');
  add_line(blk, 'zero/1', 'first/1');
  
  reuse_block(blk, 'dfirst', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(bram_latency+fan_latency-1-1), 'Position', [455 136 515 154] );
  add_line(blk, 'first/1', 'dfirst/1');

  % get the first value of the second half of the taps
  vector = pfb_coeff_gen_calc(pfb_size, n_taps, WindowType, n_inputs, 0, fwidth, n_taps/2+1, false);
  val = doubles2unsigned(vector(1), n_bits_coeff, n_bits_coeff-1, n_bits_coeff); 

  init = val(1);
  reuse_block(blk, 'register', 'xbsIndex_r4/Register', ...
    'init', num2str(init), 'rst', 'on', 'en', async, ...
    'Position', [675 yoff+(outputs_required*yinc) 720 yoff+((outputs_required+1)*yinc)]);
  add_line(blk, 'dfirst/1', 'register/2');

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
    'Position', [740 yoff 790 yoff+(outputs_required*yinc)]);
  add_line(blk, 'rom/1', 'a_expand/1');
  
  reuse_block(blk, 'b_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(outputs_required), ...
    'outputWidth', num2str(n_bits_coeff), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
    'Position', [515 yoff+(outputs_required*yinc) 565 yoff+(outputs_required*yinc*2)]);
  add_line(blk, 'munge/1', 'b_expand/1');
  add_line(blk, 'b_expand/1', 'register/1');

  reuse_block(blk, 'coeffs', 'built-in/Outport', 'Port', '3', ...
    'Position', [1060 yoff+outputs_required*yinc-7 1090 yoff+outputs_required*yinc+7]);

  % concat a and b busses together
  reuse_block(blk, 'concat', 'xbsIndex_r4/Concat', ...
    'num_inputs', num2str(outputs_required*2), ...
    'Position', [1005 yoff 1035 yoff+(outputs_required*2*yinc)]); 
  add_line(blk, 'concat/1', 'coeffs/1');

  % delays for each output
  for d_index = 0:outputs_required*2-1,
    d_name = ['d',num2str(d_index)];

    latency = (floor((outputs_required*2-d_index-1)/(2^n_inputs)))*add_latency;
  
    if d_index >= outputs_required,
      if mod(d_index, 2^n_inputs) == 0, 
        if mod(d_index, (n_taps/2)*2^n_inputs) ~= 0, 
          latency = latency + 1;
        end
      end
    end
 
    %force delay block with 0 latency to have no enable port
    if latency > 0, en = async;
    else, en = 'off';
    end

    reuse_block(blk, d_name, 'casper_library_delays/delay_srl', ...
      'async', en, 'DelayLen', num2str(latency), ...
      'Position', [875 yoff+d_index*yinc 930 yoff+d_index*yinc+18]);
    add_line(blk, [d_name,'/1'], ['concat/',num2str(d_index+1)]);    

    % join bus expansion blocks to delay
    if ((d_index/outputs_required) < 1), 
      src_blk = 'a_expand';
    else,
      if (mod(d_index, outputs_required) == 0), src_blk = 'register';
      else, src_blk = 'b_expand';
      end
    end %if
    
    src_port = mod(d_index, outputs_required) + 1;
    add_line(blk, [src_blk, '/', num2str(src_port)], [d_name, '/1']);

  end %for 
  
  % asynchronous pipeline
  if strcmp(async, 'on'),
    yoff = 226;

    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '3', ...
      'Position', [15 243 45 257]);
    add_line(blk, 'en/1', 'counter/2');  
 
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(bram_latency), ...
      'Position', [255 yoff+(outputs_required*2+2)*yinc 280 yoff+(outputs_required*2+2)*yinc+18]);
    add_line(blk, 'en/1', 'den0/1');
    
    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(fan_latency), ...
      'Position', [540 yoff+(outputs_required*2+2)*yinc 565 yoff+(outputs_required*2+2)*yinc+18]);
    add_line(blk, 'den0/1', 'den1/1');
    add_line(blk, 'den1/1', 'register/3');

    outputNum = outputs_required*2-(2^n_inputs-1);
    reuse_block(blk, 'en_replicate', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(outputNum), 'latency', num2str(fan_latency+bram_latency), 'misc', 'off', ...
      'Position', [245 yoff+(outputs_required*2+4)*yinc 295 yoff+(outputs_required*2+4)*yinc+30]);
    add_line(blk, 'en/1', 'en_replicate/1');

    reuse_block(blk, 'en_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', num2str(outputNum), ...
      'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
      'Position', [740 yoff+(outputs_required*2+4)*yinc 790 yoff+(outputs_required*3+4)*yinc]);
    add_line(blk, 'en_replicate/1', 'en_expand/1');

    for d_index = 0:outputs_required*2-1,
    
      latency = (floor((outputs_required*2-d_index-1)/(2^n_inputs)))*add_latency;
    
      if d_index >= outputs_required,
        if mod(d_index, 2^n_inputs) == 0, 
          if mod(d_index, (n_taps/2)*2^n_inputs) ~= 0, latency = latency + 1;
          end
        end
      end
      
      if(latency > 0), 
        d_name = ['d',num2str(d_index)];
        add_line(blk, ['en_expand/',num2str(d_index+1)], [d_name,'/2']);
      end
    end %for
    
    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', ...
      'Position', [1060 yoff+(outputs_required*2+2)*yinc+2 1090 yoff+(outputs_required*2+2)*yinc+16]);
    add_line(blk, 'den1/1', 'dvalid/1');

  end %if async

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_coeff_gen_init', {'trace', log_group});

end %pfb_fir_coeff_gen_init
