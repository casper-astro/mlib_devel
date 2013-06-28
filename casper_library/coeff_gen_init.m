% coeff_gen_init(blk, varargin)
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKA Africa                                                                %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009, 2013 Andrew Martens                                   %
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

function coeff_gen_init(blk, varargin)
  
  clog('entering coeff_gen_init.m',{'trace', 'coeff_gen_init_debug'});
  defaults = { ...
    'FFTSize', 6, ...
    'Coeffs', bit_rev([0:31],5), ...
    'coeff_bit_width', 18, ...
    'StepPeriod', 1, ...
    'async', 'on', ...
    'misc', 'on', ...
    'bram_latency', 2, ...
    'coeffs_bram', 'on', ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'off', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
  };

  check_mask_type(blk, 'coeff_gen');
%  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  clog('coeff_gen_init post same_state',{'trace', 'coeff_gen_init_debug'});
  munge_block(blk, varargin{:});

  FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
  Coeffs            = get_var('Coeffs', 'defaults', defaults, varargin{:});
  coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
  StepPeriod        = get_var('StepPeriod', 'defaults', defaults, varargin{:});
  async             = get_var('async', 'defaults', defaults, varargin{:});
  misc              = get_var('misc', 'defaults', defaults, varargin{:});
  bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
  coeffs_bram       = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
  coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
  coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
  coeff_generation  = get_var('coeff_generation', 'defaults', defaults, varargin{:});
  cal_bits          = get_var('cal_bits', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default case for library storage, do nothing
  if FFTSize == 0,
    clean_blocks(blk);
    set_param(blk, 'AttributesFormatString', '');
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting coeff_gen_init',{'coeff_gen_init_debug','trace'});
    return;
  end

  %%%%%%%%%
  % ports %
  %%%%%%%%%

  reuse_block(blk, 'rst', 'built-in/inport', 'Port', '1', 'Position', [25 48 55 62]);

  reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', 'Position', [395 54 435 96]);
  reuse_block(blk, 'w', 'built-in/outport', 'Port', '1', 'Position', [490 68 520 82]);
  add_line(blk, 'ri_to_c/1', 'w/1');

  port_offset = 1;
  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/inport', 'Port', '2', 'Position', [25 198 55 212]);
    reuse_block(blk, 'dvalid', 'built-in/outport', 'Port', '2', 'Position', [490 198 520 212]);

    port_offset = 2;  
  end %if async

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', 'Port', num2str(port_offset+1), 'Position', [25 248 55 262]);
    reuse_block(blk, 'misco', 'built-in/outport', 'Port', num2str(port_offset+1), 'Position', [490 248 520 262]);
  end

  % Compute the complex, bit-reversed values of the twiddle factors
  br_indices = bit_rev(Coeffs, FFTSize-1);
  br_indices = -2*pi*1j*br_indices/2^FFTSize;
  ActualCoeffs = exp(br_indices);

  %static coefficients
  if length(ActualCoeffs) == 1,
    %terminator
    reuse_block(blk, 'Terminator', 'built-in/Terminator', 'Position', [75 45 95 65]);
    add_line(blk, 'rst/1', 'Terminator/1');

    %constant blocks
    real_coeff = round(real(ActualCoeffs(1)) * 2^(coeff_bit_width-2)) / 2^(coeff_bit_width-2);
    imag_coeff = round(imag(ActualCoeffs(1)) * 2^(coeff_bit_width-2)) / 2^(coeff_bit_width-2);
    reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', ...
        'arith_type', 'Signed (2''s comp)', ...
        'const', num2str(real_coeff), 'n_bits', num2str(coeff_bit_width), ...
        'explicit_period', 'on', 'period', '1', ...
        'bin_pt', num2str(coeff_bit_width-1), 'Position', [185 34 255 66]);         
    add_line(blk, 'Constant/1', 'ri_to_c/1');
    reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', ...
        'arith_type', 'Signed (2''s comp)', ...
        'const', num2str(imag_coeff), 'n_bits', num2str(coeff_bit_width), ...
        'explicit_period', 'on', 'period', '1', ...
        'bin_pt', num2str(coeff_bit_width-1), 'Position', [185 84 255 116]);         
    add_line(blk, 'Constant1/1', 'ri_to_c/2');

    if strcmp(misc, 'on'),
      add_line(blk, 'misci/1', 'misco/1');
    end

    if strcmp(async, 'on'),
      add_line(blk, 'en/1', 'dvalid/1');
    end

  else,
    vlen = length(ActualCoeffs);

    %get hardware platform from XSG block
    try
        xsg_blk = find_system(bdroot, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
        hw_sys = xps_get_hw_plat(get_param(xsg_blk{1},'hw_sys'));
    catch,
        clog('Could not find hardware platform - is there an XSG block in this model? Defaulting platform to ROACH.', {'coeff_gen_init_debug'});
        warning('coeff_gen_init: Could not find hardware platform - is there an XSG block in this model? Defaulting platform to ROACH.');
        hw_sys = 'ROACH';
    end %try/catch

    %parameters to decide optimisation parameters
    switch hw_sys
        case 'ROACH'
          port_width = 36; %upper limit
          bram_capacity = 2^9*36;
        case 'ROACH2'
          port_width = 36; %upper limit
          bram_capacity = 2^9*36;
    end %switch

    %could we pack the whole word to output from one port
    if (coeff_bit_width * 2) <= port_width, can_pack = 1;
    else, can_pack = 0;
    end

    %can we use a single BRAM
    coeffs_volume = length(Coeffs) * 2 * coeff_bit_width;
    if coeffs_volume <= bram_capacity, single_bram = 1;
    else, single_bram = 0;
    end
    
    % check to see if we can generate by bit reversing a counter
    inorder = 1;
    for i = 1:length(Coeffs)-1,
      if ~(Coeffs(i+1) == Coeffs(i)+1), inorder = 0; break; end         
    end %for

    %if not in order, check if we can generate by undoing bit reversal
    if inorder == 0,
      bit_reversed = 1;
      for i = 1:length(Coeffs)-1, 
        clog(['bit_rev(Coeffs(',num2str(i),',',num2str(FFTSize-1),') = ',num2str(bit_rev(Coeffs(i),FFTSize-1))], 'coeff_gen_init_desperate_debug');
        clog(['bit_rev(Coeffs(',num2str(i+1),',',num2str(FFTSize-1),') = ',num2str(bit_rev(Coeffs(i+1),FFTSize-1))], 'coeff_gen_init_desperate_debug');
        if ~(bit_rev(Coeffs(i+1), FFTSize-1) == bit_rev(Coeffs(i),FFTSize-1)+1), bit_reversed = 0; break; end         
      end %for
    else
      bit_reversed = 0;
    end %if

    %determine fraction of cycle phase offset
    if inorder == 0, phase_offset = bit_rev(Coeffs(1), FFTSize-1);
    else, phase_offset = Coeffs(1);
    end
    phase_offset_fraction = phase_offset/(2^FFTSize);
    phase_multiple = phase_offset/length(Coeffs);

    %what fraction of the cycle is required
    if inorder == 0, 
      top = bit_rev(Coeffs(length(Coeffs)), FFTSize-1);
      bottom = bit_rev(Coeffs(1), FFTSize-1);
    else
      top = Coeffs(length(Coeffs));
      bottom = Coeffs(1);
    end

    multiple = (2^FFTSize)/((top+1)-bottom);
    multiple_bits = log2(multiple);
    step_bits = multiple_bits+log2(length(Coeffs));

    clog(['Can use single BRAM : ',num2str(single_bram)], 'coeff_gen_init_debug');
    clog(['Can pack into same port : ',num2str(can_pack)], 'coeff_gen_init_debug');
    clog(['In order : ',num2str(inorder)],'coeff_gen_init_debug');
    clog(['Bit reversed : ',num2str(bit_reversed)],'coeff_gen_init_debug');
    clog(['Fraction of cycle to output : 1/2^',num2str(multiple_bits)],'coeff_gen_init_debug');
    clog(['Step size : 1/2^',num2str(step_bits)],'coeff_gen_init_debug');
    clog(['Phase offset : ',num2str(phase_offset),' = ',num2str(phase_multiple),' * output cycle fraction'],'coeff_gen_init_debug');

    %
    % sanity checks

    %if in order, then must have phase offset of 0
    if inorder == 1 && phase_offset ~= 0,
      clog(['In order coefficients not starting at 0 not handled'], {'error', 'coeff_gen_init_debug'});
      error(['In order coefficients not starting at 0 not handled']);
    end

    %initial phase must be an exact multiple of the number of coefficients
    if floor(phase_multiple) ~= phase_multiple,
      clog(['initial phase offset must be an exact multiple of the number of coefficients'], {'error', 'coeff_gen_init_debug'});
      error(['initial phase offset must be an exact multiple of the number of coefficients']);
    end

    %if we don't have a power of two fraction of a cycle then we have a problem
    if multiple_bits ~= floor(log2(multiple)), 
      clog(['The FFT size must be a power-of-two-multiple of the number of coefficients '], {'error', 'coeff_gen_init_debug'});
      error(['The FFT size must be a power-of-two-multiple of the number of coefficients ']);
    end

    %coefficients must be in order or bit reversed
    if (inorder == 0) && (bit_reversed == 0),
      clog(['we don''t know how to generate coefficients that are not in order nor bit reversed'], {'error','coeff_gen_init_debug'});
      error(['we don''t know how to generate coefficients that are not in order nor bit reversed']);
    end

    %If the coefficients to be generated are in order then we can generate them by 
    %bit reversing the output of a counter and performing a lookup on these values
    %
    %If the coefficients are bit reversed then we can generate them by taking the output of a 
    %counter and getting the lookup directly. We can also generate the values as the next
    %value is just the current value rotated by a particular angle.
    %
    %An initial coefficient not being 0 can be compensated for by starting the counter with a 
    %non-zero offset. Similarly for final value
    %
    %When generating coefficients by phase rotation with a StepPeriod ~= 2^0, we must use a
    %counter and control using the en port on the oscillator

    %if not allowed to generate or coeffs in order (bit reversed when being looked up) then store in lookup and use counter
    if (inorder == 1) || strcmp(coeff_generation, 'off'),

      reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
          'cnt_type', 'Free Running', 'start_count', '0', 'cnt_by_val', '1', ...
          'arith_type', 'Unsigned', 'n_bits', num2str(log2(vlen)+StepPeriod), ...
          'bin_pt', '0', 'rst', 'on', 'en', async, 'Position', [75 29 125 81]);
      add_line(blk, 'rst/1', 'Counter/1');

      if strcmp(async, 'on'), add_line(blk, 'en/1', 'Counter/2');
      end

      reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice', ...
          'nbits', num2str(log2(vlen)), ...
          'mode', 'Upper Bit Location + Width', ...
          'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [145 41 190 69]);
      add_line(blk, 'Counter/1', 'Slice/1');

      if (strcmp(async, 'on') && strcmp(misc, 'on')),
        reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [90 182 115 278]);
        
        add_line(blk, 'en/1', 'Concat/1');
        add_line(blk, 'misci/1', 'Concat/2');
      end
      
      if inorder == 1,        
        %bit reverse block
        reuse_block(blk, 'bit_reverse', 'casper_library_misc/bit_reverse', ...
          'n_bits', num2str(log2(vlen)), ...
          'Position', [205 44 260 66]);
        add_line(blk, 'Slice/1', 'bit_reverse/1');
      end
      
      table_bits = log2(length(Coeffs));

      %
      % calculate what fraction of cycle we are going to store
      %
      if strcmp(coeff_decimation, 'on'),
        %if storing in BRAM
        if strcmp(coeffs_bram, 'on'), 
          %if all can fit in 1, then store all
          if single_bram == 1, store = multiple_bits;
          %if needing more than 1 BRAM
          else,
            %if we are required to output less than a quarter of a cycle
            %then we can't optimise
            if multiple_bits > 2, store = multiple_bits; %store all bits
            else store = 2;                              %store a quarter cycle %TODO half cycle?
            end
          end
        else, %when using distributed RAM, store all needed output points
          store = multiple_bits;
        end
      else, 
        store = multiple_bits; %store same amount as need to output
      end

      %
      % work out optimal output functions depending on phase offset
      output_ref = {'cos', '-sin', '-cos', 'sin'}; 
      output_ref_index = floor(phase_offset_fraction/(1/4));
      output0 = output_ref{output_ref_index+1};
      output1 = output_ref{mod(output_ref_index+1,4)+1};

      %
      % adjust initial phase to use new reference point
      phase_offset = phase_offset_fraction - output_ref_index*(1/4); 
      
      %
      % packing coefficients next to each other is useful;
      % 1. if 2 can fit through 1 BRAM port and we can fill less than a BRAM with all values OR
      % 2. we must store all values as we need to output less than 1/4 cycle OR
      % 3. we want a separate storage area for real and imaginary parts (address manipulation logic disappears)
      % 4. we are not using BRAM for storage
      % the only time we don't want to pack them is
      % 1. We want to share coefficients AND
      % 2. We are using BRAM for storage AND
      % 3. We have enough coefficients to require more than one full BRAM OR coefficient width is too wide

      if strcmp(coeffs_bram, 'on') && strcmp(coeff_sharing, 'on') && (can_pack == 0 || single_bram == 0), pack = 'off'; 
      else pack = 'on';
      end

      if strcmp(coeffs_bram, 'on'), bram = 'BRAM';
      else bram = 'distributed RAM';
      end

      if strcmp(misc, 'on') || strcmp(async, 'on'), cosin_misc = 'on';
      else, cosin_misc = 'off';
      end

      clog(['adding cosin block to ',blk], 'coeff_gen_init_debug');
      clog(['output0 = ',output0], 'coeff_gen_init_debug');
      clog(['output1 = ',output1], 'coeff_gen_init_debug');
      clog(['initial phase offset ',num2str(phase_offset)], 'coeff_gen_init_debug');
      clog(['outputting 2^',num2str(table_bits),' points across 1/2^',num2str(multiple_bits),' of a cycle'], 'coeff_gen_init_debug');
      clog(['storing 1/2^',num2str(store),' of a cycle'], 'coeff_gen_init_debug');
      if strcmp(pack, 'on') clog(['packing coefficients'], 'coeff_gen_init_debug'); end
      if strcmp(pack, 'off') clog(['not packing coefficients'], 'coeff_gen_init_debug'); end

      %cosin block
      reuse_block(blk, 'cosin', 'casper_library_downconverter/cosin', ...
        'output0', output0, 'output1', output1, ...
        'phase', num2str(phase_offset), ...
        'fraction', num2str(multiple_bits), ...
        'table_bits', num2str(table_bits), ...
        'n_bits', 'coeff_bit_width', 'bin_pt', 'coeff_bit_width-1', ...
        'bram_latency', 'bram_latency', 'add_latency', '1', ...
        'mux_latency', '1', 'neg_latency', '1', 'conv_latency', '1', ...
        'store', num2str(store), 'pack', pack, 'bram', bram, 'misc', cosin_misc, ...
        'Position', [280 23 345 147]);

      if inorder == 1, add_line(blk, 'bit_reverse/1', 'cosin/1');
      else, add_line(blk, 'Slice/1', 'cosin/1');
      end

      add_line(blk, 'cosin/1', 'ri_to_c/1');
      add_line(blk, 'cosin/2', 'ri_to_c/2');

      if strcmp(async, 'on') && strcmp(misc, 'on'), 
        add_line(blk, 'Concat/1', 'cosin/2');

        %separate data valid from misco
        reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
            'nbits', '1', ...
            'mode', 'Upper Bit Location + Width', ...
            'bit1', '0', 'base1', 'MSB of Input', ...
            'Position', [395 191 440 219]);
        add_line(blk, 'cosin/3', 'Slice1/1');
        add_line(blk, 'Slice1/1', 'dvalid/1');

        reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
            'mode', 'Two Bit Locations', ...
            'bit1', '-1', 'base1', 'MSB of Input', ...
            'bit0', '0', 'base0', 'LSB of Input', ...
            'Position', [395 241 440 269]);
        add_line(blk, 'cosin/3', 'Slice2/1');
        add_line(blk, 'Slice2/1', 'misco/1');

      elseif strcmp(async, 'on') && strcmp(misc, 'off'),
        add_line(blk, 'en/1', 'cosin/2');
        add_line(blk, 'cosin/3', 'dvalid/1');
      elseif strcmp(async, 'off') && strcmp(misc, 'on'),
        add_line(blk, 'misci/1', 'cosin/2');
        add_line(blk, 'cosin/3', 'misco/1');
      end 
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % if coefficient indices are bit_reversed (values in order) and allowed to generate %
    % then generate using feedback oscillator using multipliers                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif (bit_reversed == 1) && (strcmp(coeff_generation,'on')),
   
      %concat enable and misc inputs 
      if (strcmp(async, 'on') && strcmp(misc, 'on')),
        reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', 'num_inputs', '2', 'Position', [90 182 115 278]);
        
        add_line(blk, 'en/1', 'Concat/1');
        add_line(blk, 'misci/1', 'Concat/2');
      end
  
      if strcmp(coeffs_bram, 'on'), bram = 'Block RAM';
      else bram = 'Distributed memory';
      end

      phase_step_bits = step_bits;
      phase_steps_bits = log2(length(Coeffs));

      clog(['adding feedback oscillator block to ',blk], 'coeff_gen_init_debug');
      clog(['initial phase is ',num2str(phase_offset_fraction),' * 2*pi'], 'coeff_gen_init_debug');
      clog(['outputting 2^',num2str(phase_steps_bits),' steps of size 1/2^',num2str(phase_step_bits),' of a cycle'], 'coeff_gen_init_debug');

      %feedback oscillator
      reuse_block(blk, 'feedback_osc', 'casper_library_downconverter/feedback_osc', ...
        'n_bits', 'coeff_bit_width', ...           
        'n_bits_rotation', '25', ...           %TODO  
        'phase_initial', num2str(phase_offset_fraction), ...
        'phase_step_bits', num2str(phase_step_bits), ...
        'phase_steps_bits', num2str(phase_steps_bits), ...
        'ref_values_bits', num2str(cal_bits), ...
        'bram_latency', 'bram_latency', ...
        'mult_latency', '3', ...              %TODO
        'add_latency', '1', ...               %TODO
        'conv_latency', '2', ...              %TODO
        'bram', bram, ...
        'quantization', 'Round  (unbiased: Even Values)', ... %TODO
        'Position', [280 23 345 147]);

      %generate counter to slow enable if required
      if StepPeriod ~= 0,
        reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
            'cnt_type', 'Free Running', 'start_count', '0', 'cnt_by_val', '1', ...
            'arith_type', 'Unsigned', 'n_bits', num2str(StepPeriod+1), ...
            'bin_pt', '0', 'rst', 'on', 'en', async, 'Position', [75 29 125 81]);
        add_line(blk, 'rst/1', 'Counter/1');

        if strcmp(async, 'on'), add_line(blk, 'en/1', 'Counter/2');
        end

        reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice', ...
            'nbits', '1', 'boolean_output', 'on', ...
            'mode', 'Upper Bit Location + Width', ...
            'bit1', '0', 'base1', 'MSB of Input', ...
            'Position', [145 41 180 69]);
        add_line(blk, 'Counter/1', 'Slice/1');

        %edge detect
        reuse_block(blk, 'edge_detect', 'casper_library_misc/edge_detect', ...
          'edge', 'Both', 'Polarity', 'Active High', ...
          'Position', [205 44 260 66]);
        add_line(blk, 'Slice/1', 'edge_detect/1');

        add_line(blk, 'edge_detect/1', 'feedback_osc/2');

      else, 
        if strcmp(async, 'off'), %if StepPeriod 0 but no enable, then create constant to enable always
          reuse_block(blk, 'en', 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', 'const', '1', 'explicit_period', 'on', 'period', '1', ...
            'Position', [205 44 260 66]);
        end        

        add_line(blk, 'en/1', 'feedback_osc/2'); 
      end %if StepPeriod ~= 0

      add_line(blk, 'rst/1', 'feedback_osc/1', 'autorouting', 'on');  

      reuse_block(blk, 't0', 'built-in/Terminator', 'Position', [370 25 390 45]);
      add_line(blk, 'feedback_osc/1', 't0/1');
      reuse_block(blk, 't1', 'built-in/Terminator', 'Position', [370 100 390 120]);
      add_line(blk, 'feedback_osc/4', 't1/1');

      add_line(blk, 'feedback_osc/2', 'ri_to_c/1');
      add_line(blk, 'feedback_osc/3', 'ri_to_c/2');

      if strcmp(async, 'on') && strcmp(misc, 'on'), 
        add_line(blk, 'Concat/1', 'feedback_osc/3');

        %separate data valid from misco
        reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
            'nbits', '1', ...
            'mode', 'Upper Bit Location + Width', ...
            'bit1', '0', 'base1', 'MSB of Input', ...
            'Position', [395 191 440 219]);
        add_line(blk, 'feedback_osc/5', 'Slice1/1');
        add_line(blk, 'Slice1/1', 'dvalid/1');

        reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
            'mode', 'Two Bit Locations', ...
            'bit1', '-1', 'base1', 'MSB of Input', ...
            'bit0', '0', 'base0', 'LSB of Input', ...
            'Position', [395 241 440 269]);
        add_line(blk, 'feedback_osc/5', 'Slice2/1');
        add_line(blk, 'Slice2/1', 'misco/1');

      elseif strcmp(async, 'on') && strcmp(misc, 'off'),
        add_line(blk, 'en/1', 'feedback_osc/3');
        add_line(blk, 'feedback_osc/5', 'dvalid/1');
      elseif strcmp(async, 'off') && strcmp(misc, 'on'),
        add_line(blk, 'misci/1', 'feedback_osc/3');
        add_line(blk, 'feedback_osc/5', 'misco/1');
      else
        add_line(blk, 'rst/1', 'feedback_osc/3', 'autorouting', 'on');
        reuse_block(blk, 't2', 'built-in/Terminator', 'Position', [370 125 390 145]);
        add_line(blk, 'feedback_osc/5', 't2/1');
      end 

    else,
      error('Bad news, this should never happen');  
      %TODO
    end %if inorder

  %  else,
  %    %ROMS
  %
  %    if( strcmp(coeffs_bram, 'on')),
  %        mem = 'Block RAM';
  %    else
  %        mem = 'Distributed memory';
  %    end
  %    real_coeffs = round( real(ActualCoeffs) * 2^(coeff_bit_width-2) ) / 2^(coeff_bit_width-2);
  %    imag_coeffs = round( imag(ActualCoeffs) * 2^(coeff_bit_width-2)  ) / 2^(coeff_bit_width-2);
  %    reuse_block(blk, 'ROM', 'xbsIndex_r4/ROM', ...
  %        'depth', num2str(length(ActualCoeffs)), 'initVector', mat2str(real_coeffs), ...
  %        'distributed_mem', mem, 'latency', 'bram_latency', ...
  %        'arith_type', 'Signed  (2''s comp)', 'n_bits', 'coeff_bit_width', ...
  %        'bin_pt', 'coeff_bit_width-1', 'Position', [210 30 260 82]);
  %    add_line(blk, 'Slice/1', 'ROM/1');
  %    add_line(blk, 'ROM/1','ri_to_c/1');
  %
  %    reuse_block(blk, 'ROM1', 'xbsIndex_r4/ROM', ...
  %        'depth', num2str(length(ActualCoeffs)), 'initVector', mat2str(imag_coeffs), ...
  %        'distributed_mem', mem, 'latency', 'bram_latency', ...
  %        'arith_type', 'Signed  (2''s comp)', 'n_bits', 'coeff_bit_width', ...
  %        'bin_pt', 'coeff_bit_width-1', 'Position', [210 95 260 147]);
  %    add_line(blk, 'Slice/1', 'ROM1/1');
  %    add_line(blk, 'ROM1/1','ri_to_c/2');
  %
  %    if strcmp(async, 'on'),
  %      reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
  %        'latency', 'bram_latency', ...
  %        'Position', [220 195 250 215]);
  %      add_line(blk, 'den/1', 'den/1');
  %      add_line(blk, 'den/1', 'dvalid/1');
  %    end
  %
  %    if strcmp(misc, 'on')
  %      reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
  %        'latency', 'bram_latency', ...
  %        'Position', [220 244 250 266]);
  %      add_line(blk, 'misci/1','dmisc/1');
  %      add_line(blk, 'dmisc/1','misco/1');
  %    end
  %
  %  end %willing and able
  % 
  end %if length(ActualCoeffs)

%  clean_blocks(blk);

  fmtstr = sprintf('%d @ (%d,%d)', length(ActualCoeffs), coeff_bit_width, coeff_bit_width-1);
  set_param(blk, 'AttributesFormatString', fmtstr);
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting coeff_gen_init',{'trace', 'coeff_gen_init_debug'});

end %coeff_gen_init
