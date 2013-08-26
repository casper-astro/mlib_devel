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

function pfb_fir_coeff_gen_init(blk, varargin)
  clog('entering pfb_fir_coeff_gen_init', 'trace');

  defaults = { ...
    'n_inputs', 1, ...
    'pfb_size', 5, ...
    'n_taps', 4, ...
    'n_bits_coeff', 12, ...
    'WindowType', 'hamming', ...
    'fwidth', 1, ...
    'async', 'off', ...
    'bram_latency', 2, ...
    'fan_latency', 2, ...
    'add_latency', 2, ...
    'max_fanout', 4, ...
  };
  
  check_mask_type(blk, 'pfb_fir_coeff_gen');

  yinc = 60;

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

  delete_lines(blk);

  %default empty block for storage in library
  if n_taps == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting pfb_fir_coeff_gen_init','trace');
    return;
  end

  %check parameters
  if n_taps < 3,
    clog('need at least 3 taps', {'error', 'pfb_fir_coeff_gen_init_debug'});
    error('need at least 3 taps');
    return;
  end
    
  %get hardware platform from XSG block
  try
    xsg_blk = find_system(bdroot, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
    hw_sys = xps_get_hw_plat(get_param(xsg_blk{1},'hw_sys'));
  catch,
    clog('Could not find hardware platform - is there an XSG block in this model? Defaulting platform to ROACH.', {'pfb_fir_coeff_gen_init_debug'});
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
 
  port_multiple = floor(port_width/n_bits_coeff); %pack as many (complete) taps as possible next to each other
 
  outputs_required = (2^n_inputs*n_taps/2); %need this many values per clock cycle

  brams_required = ceil(outputs_required/port_multiple);
  last_bram_outputs = outputs_required - ((brams_required-1)*port_multiple);

  clog(['With a coefficient bit width of ',num2str(n_bits_coeff),' and requiring ',num2str(outputs_required*2),' outputs,'],{'pfb_fir_coeff_gen_init_debug'});
  clog(['we are going to pack ',num2str(port_multiple),' outputs into ',num2str(brams_required-1),' roms and ',num2str(last_bram_outputs),' into the last'], {'pfb_fir_coeff_gen_init_debug'});

  % sync pipeline
  reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [15 8 45 22]);
  reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'latency', num2str(fan_latency+bram_latency+1), 'Position', [410 4 455 51]);
  add_line(blk,'sync/1', 'sync_delay/1');
  reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [920 23 950 37]);
  add_line(blk,'sync_delay/1', 'sync_out/1');
 
  % din pipeline
  reuse_block(blk, 'din', 'built-in/Inport', 'Port', '2', 'Position', [15 73 45 87]);
  reuse_block(blk, 'din_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on',...
    'latency', num2str(fan_latency+bram_latency+1), 'Position', [410 69 455 116]);
  add_line(blk, 'din/1', 'din_delay/1');
  reuse_block(blk, 'dout', 'built-in/Outport', 'Port', '2', 'Position', [920 88 950 102]);
  add_line(blk,'din_delay/1', 'dout/1');

  % address generation
  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Free Running', 'operation', 'Up', 'start_count', '0', 'cnt_by_val', '1', ...
    'n_bits', num2str(pfb_size-n_inputs), 'arith_type', 'Unsigned', 'bin_pt', '0', ...
    'rst', 'on', 'en', async, ...
    'Position', [105 142 155 193]);
  add_line(blk, 'sync/1', 'counter/1'); 

  %we invert the address to get address for the other half of the taps
  %however, they are not quite symmetrical so we delay by one 
  reuse_block(blk, 'inverter', 'xbsIndex_r4/Inverter', ...
    'latency', '1', 'en', async, ...
    'Position', [180 216 230 269]);
  add_line(blk, 'counter/1', 'inverter/1'); 

  % logic for second half of taps 
  % Coefficients are not quite symmetrical, they are off by one, and do not overlap by one
  % e.g with T taps and fft size of N: tap T-1, sample 0 is not the same as tap 0, sample N-1
  % instead it is unique and not included in the coefficients for Tap 0
  % Also, tap T-1, sample 1 is the same as tap 0, sample N-1
  % So, we control a mux choosing either the value from port b or stored value
  % and delay the addressing for port B by one.

  reuse_block(blk, 'zero', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Unsigned', ...
        'n_bits', num2str(pfb_size-n_inputs), 'bin_pt', '0', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [120 327 140 343]);
  
  reuse_block(blk, 'first', 'xbsIndex_r4/Relational' , ...
        'mode', 'a=b', 'Position', [190 289 220 351]);
  add_line(blk, 'counter/1', 'first/1');
  add_line(blk, 'zero/1', 'first/2');

  yoff = 170; 
  % ROM generation
  for rom_index = 0:brams_required-1
    if rom_index < brams_required-1, outputs = port_multiple;
    else outputs = last_bram_outputs;
    end
    clog(['Getting coeffs for ROM',num2str(rom_index),' requiring ',num2str(outputs), ' output streams'],{'pfb_fir_coeff_gen_init_debug'});

    fanout_src = floor(rom_index/max_fanout);
    dcount_name = ['dcounter_', num2str(fanout_src)];
    dinvert_name = ['dinverter_', num2str(fanout_src)];
    dfirst_name = ['dfirst_', num2str(fanout_src)];

    if mod(rom_index, max_fanout) == 0,

      %explicitly forcing a separate register for each of these
      
      %fanout limiting register for counter
      reuse_block(blk, dcount_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
        'latency', num2str(min(1,fan_latency)), 'Position', [255 yoff-8 280 yoff+8]);
      add_line(blk, 'counter/1', [dcount_name,'/1']);

      %fanout limiting register for inverter
      reuse_block(blk, dinvert_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
        'latency', num2str(min(1,fan_latency)), 'Position', [255 yoff+75-8 280 yoff+75+8]);
      add_line(blk, 'inverter/1', [dinvert_name,'/1']);
      
      %fanout register for relational (first item detection)
      reuse_block(blk, dfirst_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
        'latency', num2str(min(1,fan_latency)), 'Position', [255 yoff+150-8 280 yoff+150+8]);
      add_line(blk, 'first/1', [dfirst_name,'/1']);
    end

    % fanout latency
    fana_name = ['fana_delay',num2str(rom_index)];
    reuse_block(blk, fana_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
      'latency', num2str(max(fan_latency-1,0)), 'Position', [340 yoff-8 365 yoff+8]);
    add_line(blk, [dcount_name,'/1'], [fana_name,'/1']);

    fanb_name = ['fanb_delay',num2str(rom_index)];
    reuse_block(blk, fanb_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
      'latency', num2str(max(fan_latency-1,0)), 'Position', [340 yoff+75-8 365 yoff+75+8]);
    add_line(blk, [dinvert_name,'/1'], [fanb_name,'/1']);

    % first fanout
    fan1st_name = ['first_delay',num2str(rom_index)];
    reuse_block(blk, fan1st_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
      'latency', num2str(max(fan_latency-1,0)+bram_latency), 'Position', [340 yoff+150-8 505 yoff+150+8]);
    add_line(blk, [dfirst_name,'/1'], [fan1st_name, '/1']);
  
    % constants
    reuse_block(blk, ['rom_din',num2str(rom_index)], 'xbsIndex_r4/Constant', ...
          'NamePlacement', 'alternate', ...
          'const', '0', 'arith_type', 'Unsigned', ...
          'n_bits', num2str(outputs*n_bits_coeff), 'bin_pt', '0', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [400 yoff+12 420 yoff+28]);
    reuse_block(blk, ['rom_we',num2str(rom_index)], 'xbsIndex_r4/Constant', ...
          'const', '0', 'arith_type', 'Boolean', ...
          'explicit_period', 'on', 'period', '1', ...
          'Position', [400 yoff+32 420 yoff+48]);
    
    % generate values to be stored in ROM  
    init_vector = zeros(outputs, 2^(pfb_size-n_inputs));
    init_val = zeros(outputs, 1);
    for out_index = 0:outputs-1,
      ref_index = (rom_index * port_multiple) + out_index;
      input_index = mod(ref_index, 2^n_inputs);
      tap_index = floor(ref_index/2^n_inputs) + 1;
      clog(['Getting coeffs for output ',num2str(ref_index),' => tap: ',num2str(tap_index),' input: ',num2str(input_index)],{'pfb_fir_coeff_gen_init_debug'});
      raw_vals = pfb_coeff_gen_calc(pfb_size, n_taps, WindowType, n_inputs, input_index, fwidth, tap_index, false);
      vals = fi(raw_vals, true, n_bits_coeff, n_bits_coeff-1);                        %saturates at max so no overflow
      vals = fi(vals, false, n_bits_coeff, n_bits_coeff-1, 'OverflowMode', 'wrap');   %wraps negative component so can get back when positive
      vals = fi(vals, false, n_bits_coeff*(2+(outputs-out_index-1)), n_bits_coeff-1); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
      vals = bitshift(vals, n_bits_coeff-1+(n_bits_coeff*(outputs-out_index-1)));     %shift up 
      init_vector(out_index+1,:) = vals;

      %find reset value for port B
      clog(['Getting initial value for output ',num2str(ref_index),' => tap: ',num2str(n_taps-tap_index+1),' input: ',num2str(2^n_inputs-input_index-1)],{'pfb_fir_coeff_gen_init_debug'});
      raw_vals = pfb_coeff_gen_calc(pfb_size, n_taps, WindowType, n_inputs, (2^n_inputs)-input_index-1, fwidth, n_taps-tap_index+1, false);
      raw_val = raw_vals(1);
      val = fi(raw_val, true, n_bits_coeff, n_bits_coeff-1);                        %saturates at max so no overflow
      val = fi(val, false, n_bits_coeff, n_bits_coeff-1, 'OverflowMode', 'wrap');   %wraps negative component so can get back when positive
      val = fi(val, false, n_bits_coeff*(2+(outputs-out_index-1)), n_bits_coeff-1); %expand whole bits, ready for shift up (being stored Unsigned so must be positive)
      val = bitshift(val, n_bits_coeff-1+(n_bits_coeff*(outputs-out_index-1)));     %shift up 
      init_val(out_index+1,1) = val;
    end

    % roms themselves
    rom_name = ['ROM',num2str(rom_index)];
    reuse_block(blk, rom_name, 'xbsIndex_r4/Dual Port RAM', ...
            'initVector', mat2str(double(sum(init_vector,1))), ...
            'depth', '2^(pfb_size-n_inputs)', ...
            'latency', num2str(bram_latency), ...
            'rst_b', 'off', 'en_a', 'off', 'en_b', 'off', ... 
            'distributed_mem', 'Block RAM', ...
            'Position', [465 yoff-18 505 yoff+118]);
    add_line(blk, [fana_name,'/1'], [rom_name,'/1']);
    add_line(blk, [fanb_name,'/1'], [rom_name,'/4']);
    add_line(blk, ['rom_din',num2str(rom_index),'/1'], [rom_name,'/2']);
    add_line(blk, ['rom_din',num2str(rom_index),'/1'], [rom_name,'/5']);
    add_line(blk, ['rom_we',num2str(rom_index),'/1'], [rom_name,'/3']);
    add_line(blk, ['rom_we',num2str(rom_index),'/1'], [rom_name,'/6']);

    % mux logic to choose first value of second half of taps
 
    da = ['da',num2str(rom_index)];
    reuse_block(blk, da, 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', '1', 'Position', [560 yoff+7 585 yoff+23] );
    add_line(blk, [rom_name, '/1'], [da,'/1']);

    fconst_name = ['first_val', num2str(rom_index)];
    reuse_block(blk, fconst_name, 'xbsIndex_r4/Constant', ...
      'const', num2str(double(sum(init_val,1))) , 'arith_type', 'Unsigned', ...
      'n_bits', num2str(outputs*n_bits_coeff), 'bin_pt', '0', ...
      'explicit_period', 'on', 'period', '1', ...
      'Position', [340 yoff+192 420 yoff+208]);
  
    mux_name = ['mux', num2str(rom_index)];
    reuse_block(blk, mux_name, 'xbsIndex_r4/Mux', ...
      'inputs', '2', 'latency', '1', ...
      'Position', [560 yoff+138 585 yoff+212]);
    add_line(blk, [fan1st_name,'/1'], [mux_name, '/1']);
    add_line(blk, [rom_name,'/2'], [mux_name, '/2']);
    add_line(blk, [fconst_name,'/1'], [mux_name, '/3']);

    % coefficient extraction
    busa_expand_name = ['busa_expand',num2str(rom_index)];
    reuse_block(blk, busa_expand_name, 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', num2str(outputs), ...
      'outputWidth', num2str(n_bits_coeff), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
      'Position', [640 yoff-15 690 yoff+65]);
    add_line(blk, [da,'/1'], [busa_expand_name,'/1']);
    busb_expand_name = ['busb_expand',num2str(rom_index)];
    reuse_block(blk, busb_expand_name, 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', num2str(outputs), ...
      'outputWidth', num2str(n_bits_coeff), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
      'Position', [640 yoff+137 690 yoff+213]);
    add_line(blk, [mux_name,'/1'], [busb_expand_name,'/1']);

    %increment yoffset
    yoff = yoff + 270;
  end 

  yoff = 170;
  reuse_block(blk, 'coeffs', 'built-in/Outport', 'Port', '3', ...
    'Position', [920 yoff+outputs_required*yinc-7 950 yoff+outputs_required*yinc+7]);

  % concat
  reuse_block(blk, 'concat', 'xbsIndex_r4/Concat', ...
    'num_inputs', num2str(outputs_required*2), ...
    'Position', [855 yoff-10 890 (yoff+outputs_required*2*yinc)+10]); 
  add_line(blk,'concat/1', 'coeffs/1');

  % delays for each output
  for d_index = 0:outputs_required*2-1,
    d_name = ['d',num2str(d_index)];
    latency = (floor((outputs_required*2-d_index-1)/(2^n_inputs)))*add_latency;
    
    %force delay block with 0 latency to have no enable port
    if latency > 0, en = async;
    else, en = 'off';
    end

    reuse_block(blk, d_name, 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'en', en, 'latency', num2str(latency), ...
      'Position', [765 yoff+d_index*yinc-10 820 yoff+d_index*yinc+8]);
    add_line(blk, [d_name,'/1'], ['concat/',num2str(d_index+1)]);    
  end  
  
  for dest = 0:(outputs_required*2)-1,
    if dest < outputs_required, 
      src = dest;
      src_debus_type = 'a';
    else, 
      src = outputs_required*2-dest-1;
      src_debus_type = 'b';
    end
    src_debus_index = floor(src/port_multiple);
    src_debus_port = mod(src, port_multiple)+1;
    
    src = ['bus', src_debus_type, '_expand', num2str(src_debus_index), '/', num2str(src_debus_port)];
    add_line(blk, src, ['d',num2str(dest),'/1']);
  end %for dest

  % asynchronous pipeline
  if strcmp(async, 'on'),
    yoff = 170;

    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '3', ...
      'Position', [15 173 45 187]);
    add_line(blk, 'en/1', 'counter/2');  
    add_line(blk, 'en/1', 'inverter/2');  
 
    ybase = max(outputs_required*2*yinc, brams_required * 270);
    reuse_block(blk, 'en_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(fan_latency+bram_latency+1), ...
      'Position', [255 yoff+ybase+60-8 695 yoff+ybase+60+8]);
    add_line(blk, 'en/1', 'en_delay/1');

    reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', ...
      'Position', [840 yoff+ybase-7+60 870 yoff+ybase+7+60]);
    add_line(blk, 'en_delay/1', 'dvalid/1');

    for rom_index = 0:brams_required-1,
      fanout_src = floor(rom_index/max_fanout);
      den_name = ['den_',num2str(fanout_src)];
    
      if mod(rom_index, max_fanout) == 0,
        %fanout register for en
        reuse_block(blk, den_name, 'xbsIndex_r4/Delay', ...
          'latency', num2str(min(1,fan_latency)), 'reg_retiming', 'off', ...
          'Position', [255 yoff+240-8 280 yoff+240+8]);
        add_line(blk, 'en/1', [den_name,'/1']);
      end

      en_delay_name = ['en_delay',num2str(rom_index)];
      reuse_block(blk, en_delay_name, 'xbsIndex_r4/Delay', ...
        'latency', num2str(max(fan_latency-1,0)+bram_latency+1), 'reg_retiming', 'off', ...
        'Position', [340 yoff+240-8 690 yoff+240+8]);
      add_line(blk, [den_name,'/1'], [en_delay_name,'/1']);
  
      yoff = yoff + 270;
    end
    
    yoff = 170;
    for d_index = 0:outputs_required*2-1,
      latency = (floor((outputs_required*2-d_index-1)/(2^n_inputs)))*add_latency;
      
      if(latency > 0), 
        d_name = ['d',num2str(d_index)];
        en_delays_name = ['en_delay', num2str(floor(d_index/(port_multiple*2)))];
        add_line(blk, [en_delays_name,'/1'], [d_name,'/2']);
      end
    end

  end %if async

  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting pfb_fir_coeff_gen_init','trace');

end %pfb_fir_coeff_gen_init
