% coeff_gen_init(blk, varargin)
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009 Andrew Martens                                         %
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
defaults = {'FFTSize', 5, 'dvalid', 'off', 'Coeffs', [0:3], 'StepPeriod', 1, 'coeff_bit_width', 18, 'bram_latency', 2, 'coeffs_bram', 'on', 'optimise', 'off', 'misc', 'off'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('coeff_gen_init post same_state',{'trace', 'coeff_gen_init_debug'});
check_mask_type(blk, 'coeff_gen');
munge_block(blk, varargin{:});

FFTSize =         get_var('FFTSize', 'defaults', defaults, varargin{:});
dvalid =          get_var('dvalid', 'defaults', defaults, varargin{:});
Coeffs =          get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod =      get_var('StepPeriod', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
bram_latency =    get_var('bram_latency', 'defaults', defaults, varargin{:});
coeffs_bram =     get_var('coeffs_bram', 'defaults', defaults, varargin{:});
optimise =        get_var('optimise', 'defaults', defaults, varargin{:});
misc =            get_var('misc', 'defaults', defaults, varargin{:});

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

reuse_block(blk, 'rst', 'built-in/inport', 'Port', '1', ...
    'Position', [25 48 55 62]);

reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
    'Position', [395 54 435 96]);

reuse_block(blk, 'w', 'built-in/outport', 'Port', '1', ...
    'Position', [490 68 520 82]);
add_line(blk, 'ri_to_c/1', 'w/1');

port_offset = 1;
if strcmp(dvalid, 'on'),
  reuse_block(blk, 'dvi', 'built-in/inport', 'Port', '2', ...
      'Position', [25 198 55 212]);

  reuse_block(blk, 'dvo', 'built-in/outport', 'Port', '2', ...
      'Position', [490 198 520 212]);

  port_offset = 2;  
end %if dvalid

if strcmp(misc, 'on'),
  reuse_block(blk, 'misci', 'built-in/inport', 'Port', num2str(port_offset+1), ...
      'Position', [25 248 55 262]);

  reuse_block(blk, 'misco', 'built-in/outport', 'Port', num2str(port_offset+1), ...
      'Position', [490 248 520 262]);
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

  if strcmp(dvalid, 'on'),
    add_line(blk, 'dvi/1', 'dvo/1');
  end

else,
  vlen = length(ActualCoeffs);

  reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
      'cnt_type', 'Free Running', 'start_count', '0', 'cnt_by_val', '1', ...
      'arith_type', 'Unsigned', 'n_bits', num2str(log2(vlen)+StepPeriod), ...
      'bin_pt', '0', 'rst', 'on', 'en', dvalid, 'Position', [75 29 125 81]);
  add_line(blk, 'rst/1', 'Counter/1');

  if strcmp(dvalid, 'on'), add_line(blk, 'dvi/1', 'Counter/2');
  end

  reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice', ...
      'nbits', num2str(log2(vlen)), ...
      'mode', 'Upper Bit Location + Width', ...
      'bit1', '0', 'base1', 'MSB of Input', ...
      'Position', [145 41 190 69]);
  add_line(blk, 'Counter/1', 'Slice/1');

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

  %TODO check for optimisation in FFT direct by looking at bit_rev(Coeffs, FFTSize-1)
  inorder = 1;
  for i = 1:length(Coeffs),
    if ~(Coeffs(i) == (i-1)), %if not in order from 0
      inorder = 0;
      break;
    end         
  end %for

  if inorder == 1, can_optimise = 1;
  else, can_optimise = 0;
  end

  clog(['single BRAM = ',num2str(single_bram),' Pack = ',num2str(can_pack),' In order = ',num2str(inorder)],'coeff_gen_init_debug');

  %if willing and able
  if strcmp(optimise, 'on') && (can_optimise == 1),
    clog('willing and able to optimise', {'coeff_gen_init_debug'});

    if strcmp(dvalid, 'on') && strcmp(misc, 'on'),
      reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', ...
          'num_inputs', '2', ...
          'Position', [90 182 115 278]);
      
      add_line(blk, 'dvi/1', 'Concat/1');
      add_line(blk, 'misci/1', 'Concat/2');
    end
          
    %bit reverse block
    reuse_block(blk, 'bit_reverse', 'casper_library_misc/bit_reverse', ...
      'n_bits', num2str(log2(vlen)), ...
      'Position', [205 44 260 66]);
    add_line(blk, 'Slice/1', 'bit_reverse/1');
 
    %pack if we can fit side by side and within one BRAM
    if can_pack == 1 && single_bram == 1, 
      pack = 'on'; 
    else 
      pack = 'off';
    end

    if strcmp(coeffs_bram, 'on'), bram = 'BRAM';
    else bram = 'distributed RAM';
    end
    
    table_bits = log2(length(Coeffs));

    %if can fit full cycle in BRAM, then store full cycle
    %using less logic, otherwise use more logic
    if strcmp(coeffs_bram, 'on'), 
      if single_bram == 1, store = '0';
      else store = '2';
      end
    else, %when using distributed RAM, use less storage 
          %TODO check how much resources this uses
      if table_bits <= 3, store = '0'; %force all values for small numbers
      else store = '1';
      end     
    end

    if strcmp(misc, 'on') || strcmp(dvalid, 'on'), cosin_misc = 'on';
    else, cosin_misc = 'off';
    end

    clog(['adding cosin block to ',blk], 'coeff_gen_init_debug');
    %cosin block
    reuse_block(blk, 'cosin', 'casper_library_downconverter/cosin', ...
      'output0', 'cos', 'output1', '-sin', 'fraction', '1', ...
      'table_bits', num2str(log2(length(Coeffs))), ...
      'n_bits', 'coeff_bit_width', 'bin_pt', 'coeff_bit_width-1', ...
      'bram_latency', 'bram_latency', 'add_latency', '1', ...
      'mux_latency', '1', 'neg_latency', '1', 'conv_latency', '1', ...
      'store', store, 'pack', pack, 'bram', bram, 'misc', cosin_misc, ...
      'Position', [280 23 345 147]);
    add_line(blk, 'bit_reverse/1', 'cosin/1');
    add_line(blk, 'cosin/1', 'ri_to_c/1');
    add_line(blk, 'cosin/2', 'ri_to_c/2');

    if strcmp(dvalid, 'on') && strcmp(misc, 'on'), 
      add_line(blk, 'Concat/1', 'cosin/2');

      %separate data valid from misco
      reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
          'nbits', '1', ...
          'mode', 'Upper Bit Location + Width', ...
          'bit1', '0', 'base1', 'MSB of Input', ...
          'Position', [395 191 440 219]);
      add_line(blk, 'cosin/3', 'Slice1/1');
      add_line(blk, 'Slice1/1', 'dvo/1');

      reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
          'mode', 'Two Bit Locations', ...
          'bit1', '-1', 'base1', 'MSB of Input', ...
          'bit0', '0', 'base0', 'LSB of Input', ...
          'Position', [395 241 440 269]);
      add_line(blk, 'cosin/3', 'Slice2/1');
      add_line(blk, 'Slice2/1', 'misco/1');

    elseif strcmp(dvalid, 'on') && strcmp(misc, 'off'),
      add_line(blk, 'dvi/1', 'cosin/2');
      add_line(blk, 'cosin/3', 'dvo/1');
    elseif strcmp(dvalid, 'off') && strcmp(misc, 'on'),
      add_line(blk, 'misci/1', 'cosin/2');
      add_line(blk, 'cosin/3', 'misco/1');
    end  

  else,
    %ROMS

    if( strcmp(coeffs_bram, 'on')),
        mem = 'Block RAM';
    else
        mem = 'Distributed memory';
    end
    real_coeffs = round( real(ActualCoeffs) * 2^(coeff_bit_width-2) ) / 2^(coeff_bit_width-2);
    imag_coeffs = round( imag(ActualCoeffs) * 2^(coeff_bit_width-2)  ) / 2^(coeff_bit_width-2);
    reuse_block(blk, 'ROM', 'xbsIndex_r4/ROM', ...
        'depth', num2str(length(ActualCoeffs)), 'initVector', mat2str(real_coeffs), ...
        'distributed_mem', mem, 'latency', 'bram_latency', ...
        'arith_type', 'Signed  (2''s comp)', 'n_bits', 'coeff_bit_width', ...
        'bin_pt', 'coeff_bit_width-1', 'Position', [210 30 260 82]);
    add_line(blk, 'Slice/1', 'ROM/1');
    add_line(blk, 'ROM/1','ri_to_c/1');

    reuse_block(blk, 'ROM1', 'xbsIndex_r4/ROM', ...
        'depth', num2str(length(ActualCoeffs)), 'initVector', mat2str(imag_coeffs), ...
        'distributed_mem', mem, 'latency', 'bram_latency', ...
        'arith_type', 'Signed  (2''s comp)', 'n_bits', 'coeff_bit_width', ...
        'bin_pt', 'coeff_bit_width-1', 'Position', [210 95 260 147]);
    add_line(blk, 'Slice/1', 'ROM1/1');
    add_line(blk, 'ROM1/1','ri_to_c/2');

    if strcmp(dvalid, 'on'),
      reuse_block(blk, 'dvalid', 'xbsIndex_r4/Delay', ...
        'latency', 'bram_latency', ...
        'Position', [220 195 250 215]);
      add_line(blk, 'dvi/1', 'dvalid/1');
      add_line(blk, 'dvalid/1', 'dvo/1');
    end

    if strcmp(misc, 'on')
      reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
        'latency', 'bram_latency', ...
        'Position', [220 244 250 266]);
      add_line(blk, 'misci/1','dmisc/1');
      add_line(blk, 'dmisc/1','misco/1');
    end

  end %willing and able
  
end %if length(ActualCoeffs)

clean_blocks(blk);

fmtstr = sprintf('%d @ (%d,%d)', length(ActualCoeffs), coeff_bit_width, coeff_bit_width-1);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting coeff_gen_init',{'trace', 'coeff_gen_init_debug'});
