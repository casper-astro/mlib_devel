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
    'in_latency', 0, ...
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
  in_latency                = get_var('in_latency','defaults',defaults,varargin{:});
  conjugated                = get_var('conjugated','defaults',defaults,varargin{:});
  async                     = get_var('async','defaults',defaults,varargin{:});
  pipelined_enable          = get_var('pipelined_enable','defaults',defaults,varargin{:});
  multiplier_implementation = get_var('multiplier_implementation','defaults',defaults,varargin{:});

  delete_lines(blk);

  if n_bits_a == 0 || n_bits_b == 0
    clean_blocks(blk);
    set_param(blk,'AttributesFormatString','');
    save_state(blk, 'defaults', defaults, varargin{:});
    return;
  end

  if (n_bits_a < bin_pt_a)
      errordlg('Number of bits for a input must be greater than binary point position.'); return; end
  if (n_bits_b < bin_pt_b)
      errordlg('Number of bits for b input must be greater than binary point position.'); return; end
  if (n_bits_ab < bin_pt_ab)
      errordlg('Number of bits for ab input must be greater than binary point position.'); return; end

  %ports

  reuse_block(blk, 'a', 'built-in/Inport', 'Port', '1', 'Position', [5 148 35 162]);
  reuse_block(blk, 'b', 'built-in/Inport', 'Port', '2', 'Position', [5 333 35 347]);
 
  if strcmp(async, 'on')
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '3', 'Position', [5 478 35 492]);
  end 
 
  %replication layer
 
  if strcmp(async, 'off') || strcmp(pipelined_enable, 'on'), latency = in_latency;
  else, latency = 0;
  end
 
  reuse_block(blk, 'a_replicate', 'casper_library_bus/bus_replicate', ...
      'replication', '2', 'latency', num2str(latency), 'misc', 'off', ...
      'Position', [90 143 125 167]);
  add_line(blk, 'a/1', 'a_replicate/1'); 
 
  reuse_block(blk, 'b_replicate', 'casper_library_bus/bus_replicate', ...
      'replication', '2', 'latency', num2str(latency), 'misc', 'off', ...
      'Position', [90 328 125 352]);
  add_line(blk, 'b/1', 'b_replicate/1'); 

  if strcmp(async, 'on')
    reuse_block(blk, 'en_replicate0', 'casper_library_bus/bus_replicate', ...
        'replication', '5', 'latency', num2str(latency), 'misc', 'off', ...
        'Position', [90 473 125 497]);
    add_line(blk, 'en/1', 'en_replicate0/1'); 

    reuse_block(blk, 'en_expand0', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', 'outputNum', '5', ...
        'outputWidth', mat2str(ones(1, 5)), 'outputBinaryPt', mat2str(zeros(1, 5)), ...
        'outputArithmeticType', mat2str(2*ones(1, 5)), ...
        'Position', [180 436 230 534]);
    add_line(blk, 'en_replicate0/1', 'en_expand0/1'); 
  end 

  %bus_expand layer
  
  reuse_block(blk, 'a_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', '4', ...
      'outputWidth', mat2str(repmat(n_bits_a, 1, 4)), ...
      'outputBinaryPt', mat2str(repmat(bin_pt_a, 1, 4)), ...
      'outputArithmeticType', mat2str(ones(1,4)), ...
      'Position', [180 106 230 199]);
  add_line(blk, 'a_replicate/1', 'a_expand/1'); 
  
  reuse_block(blk, 'b_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', '4', ...
      'outputWidth', mat2str(repmat(n_bits_b, 1, 4)), ...
      'outputBinaryPt', mat2str(repmat(bin_pt_b, 1, 4)), ...
      'outputArithmeticType', mat2str(ones(1,4)), ...
      'Position', [180 291 230 384]);
  add_line(blk, 'b_replicate/1', 'b_expand/1'); 
  
  %multipliers

  if strcmp(multiplier_implementation, 'behavioral HDL')
    use_behavioral_HDL = 'on';
    use_embedded = 'off';
  else
    use_behavioral_HDL = 'off';
    if strcmp(multiplier_implementation, 'embedded multiplier core')
      use_embedded = 'on';
    elseif strcmp(multiplier_implementation, 'standard core')
      use_embedded = 'off';
    else
    end
  end

  reuse_block(blk, 'rere', 'xbsIndex_r4/Mult', ...
    'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
    'en', async, 'latency', num2str(mult_latency), 'precision', 'Full', ...
    'Position', [290 102 340 153]);
  add_line(blk, 'a_expand/1', 'rere/1');
  add_line(blk, 'b_expand/1', 'rere/2');

  reuse_block(blk, 'imim', 'xbsIndex_r4/Mult', ...
    'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
    'en', async, 'latency', num2str(mult_latency), 'precision', 'Full', ...
    'Position', [290 172 340 223]);
  add_line(blk, 'a_expand/2', 'imim/1');
  add_line(blk, 'b_expand/2', 'imim/2');

  reuse_block(blk, 'imre', 'xbsIndex_r4/Mult', ...
    'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
    'en', async, 'latency', num2str(mult_latency), 'precision', 'Full', ...
    'Position', [290 267 340 318]);
  add_line(blk, 'a_expand/4', 'imre/1');
  add_line(blk, 'b_expand/3', 'imre/2');

  reuse_block(blk, 'reim', 'xbsIndex_r4/Mult', ...
    'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
    'en', async, 'latency', num2str(mult_latency), 'precision', 'Full', ...
    'Position', [290 337 340 388]);
  add_line(blk, 'a_expand/3', 'reim/1');
  add_line(blk, 'b_expand/4', 'reim/2');

  if strcmp(async, 'on')
    add_line(blk, 'en_expand0/1', 'rere/3');
    add_line(blk, 'en_expand0/2', 'imim/3');
    add_line(blk, 'en_expand0/3', 'imre/3');
    add_line(blk, 'en_expand0/4', 'reim/3');

    if strcmp(pipelined_enable, 'on'), latency = mult_latency;
    else, latency = 0;
    end

    reuse_block(blk, 'en_replicate1', 'casper_library_bus/bus_replicate', ...
        'replication', '3', 'latency', num2str(latency), 'misc', 'off', ...
        'Position', [295 523 330 547]);
    add_line(blk, 'en_expand0/5', 'en_replicate1/1');

    reuse_block(blk, 'en_expand1', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', 'outputNum', '3', ...
        'outputWidth', mat2str(ones(1, 3)), 'outputBinaryPt', mat2str(zeros(1, 3)), ...
        'outputArithmeticType', mat2str(2*ones(1, 3)), ...
        'Position', [355 499 405 571]);
    add_line(blk, 'en_replicate1/1', 'en_expand1/1'); 
  end

  %add/subs
  reuse_block(blk, 'addsub_re', 'xbsIndex_r4/AddSub', ...
    'en', async, 'use_behavioral_HDL', 'on', 'pipelined', 'on', ...
    'latency', num2str(add_latency), 'use_rpm', 'on', 'precision', 'Full', ...
    'Position', [445 94 495 236]);
  add_line(blk, 'rere/1', 'addsub_re/1');
  add_line(blk, 'imim/1', 'addsub_re/2');

  reuse_block(blk, 'addsub_im', 'xbsIndex_r4/AddSub', ...
    'en', async, 'use_behavioral_HDL', 'on', 'pipelined', 'on', ...
    'latency', num2str(add_latency), 'use_rpm', 'on', 'precision', 'Full', ...
    'Position', [445 259 495 401]);
  add_line(blk, 'imre/1', 'addsub_im/1');
  add_line(blk, 'reim/1', 'addsub_im/2');

  % Set conjugation mode.
  if strcmp(conjugated, 'on')
    set_param([blk, '/addsub_re'], 'mode', 'Addition');
    set_param([blk, '/addsub_im'], 'mode', 'Subtraction');
  else
    set_param([blk, '/addsub_re'], 'mode', 'Subtraction');
    set_param([blk, '/addsub_im'], 'mode', 'Addition');
  end
  
  if strcmp(async, 'on')
    add_line(blk, 'en_expand1/1', 'addsub_re/3');
    add_line(blk, 'en_expand1/2', 'addsub_im/3');

    if strcmp(pipelined_enable, 'on')
      latency = add_latency;
      replication = 3;
    else
      latency = 0;
      replication = 2;
    end

    reuse_block(blk, 'en_replicate2', 'casper_library_bus/bus_replicate', ...
        'replication', '3', 'latency', num2str(latency), 'misc', 'off', ...
        'Position', [450 548 485 572]);
    add_line(blk, 'en_expand1/3', 'en_replicate2/1');

    reuse_block(blk, 'en_expand2', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', 'outputNum', num2str(replication), ...
        'outputWidth', mat2str(ones(1, replication)), 'outputBinaryPt', mat2str(zeros(1, replication)), ...
        'outputArithmeticType', mat2str(2*ones(1, replication)), ...
        'Position', [515 524 565 596]);
    add_line(blk, 'en_replicate2/1', 'en_expand2/1'); 
  end
 
%code below taken from original cmult_init script but unsure of what is supposed to happen 
%  % If overflow mode is "wrap", do the wrap for free in the multipliers
%  % and post-multiply adders to save bits.
%  wrapables={'rere', 'imim', 'imre', 'reim', 'addsub_re', 'addsub_im'};
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
%    for name=wrapables
%      set_param([blk, '/', name{1}], 'precision', 'Full');
%    end
%  end

  %convert
  reuse_block(blk, 'convert_re', 'xbsIndex_r4/Convert', ...
    'en', async, 'n_bits', num2str(n_bits_ab), 'bin_pt', num2str(bin_pt_ab), ...
    'quantization', quantization, 'overflow', overflow, 'pipeline', 'on', ...
    'latency', num2str(conv_latency), 'Position', [595 152 640 183]);
  add_line(blk, 'addsub_re/1', 'convert_re/1');

  reuse_block(blk, 'convert_im', 'xbsIndex_r4/Convert', ...
    'en', async, 'n_bits', num2str(n_bits_ab), 'bin_pt', num2str(bin_pt_ab), ...
    'quantization', quantization, 'overflow', overflow, 'pipeline', 'on', ...
     'latency', num2str(conv_latency), 'Position', [595 317 640 348]);
  add_line(blk,'addsub_im/1','convert_im/1');

  if strcmp(async, 'on')
    add_line(blk, 'en_expand2/1', 'convert_re/2');
    add_line(blk, 'en_expand2/2', 'convert_im/2');
    
    if strcmp(pipelined_enable, 'on')
      reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
        'latency', num2str(latency), 'reg_retiming', 'on', ...
        'Position', [600 574 635 596]);
      add_line(blk, 'en_expand2/3', 'den/1');
      latency = conv_latency;
    else
      latency = mult_latency + add_latency + conv_latency;
    end
  end

  % output ports

  reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
          'Position', [660 229 700 271]);
  set_param([blk, '/ri_to_c'], 'LinkStatus', 'inactive');
  add_line(blk,'convert_re/1','ri_to_c/1');
  add_line(blk,'convert_im/1','ri_to_c/2');

  reuse_block(blk, 'ab', 'built-in/Outport', ...
          'Port', '1', ...
          'Position', [745 243 775 257]);
  add_line(blk,'ri_to_c/1','ab/1');

  if strcmp(async, 'on') && strcmp(pipelined_enable, 'on')
    reuse_block(blk, 'dvalid', 'built-in/Outport', ...
      'Port', '2', ...
      'Position', [745 438 775 452]);
    add_line(blk, 'den/1', 'dvalid/1');
  end

  clean_blocks(blk);

  % Set attribute format string (block annotation)
  annotation=sprintf('%d_%d * %d_%d ==> %d_%d\n%s, %s\nLatency=%d', ...
    n_bits_a,bin_pt_a,n_bits_b,bin_pt_b,n_bits_ab,bin_pt_ab,quantization,overflow,latency);
  set_param(blk,'AttributesFormatString',annotation);

  % Save and back-populate mask parameter values
  save_state(blk, 'defaults', defaults, varargin{:});

