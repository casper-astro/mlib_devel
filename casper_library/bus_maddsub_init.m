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

function bus_maddsub_init(blk, varargin)
  log_group = 'bus_maddsub_init_debug';

  clog('entering bus_maddsub_init', {log_group, 'trace'});
  
  defaults = { ...
    'n_bits_a', [8 8 8 8],  'bin_pt_a', 3, 'type_a', 1, 'cmplx_a', 'off', ...
    'n_bits_b', [4],        'bin_pt_b', 3, 'type_b', 1, 'replicate_ab', 'on', ...
    'mult_latency', 3, ...
    'multiplier_implementation', 'behavioral HDL', ... 'embedded multiplier core' 'standard core' ...
    'opmode', 'Addition', ...
    'n_bits_c', [4 4 4 4],  'bin_pt_c', 3, 'type_c', 1, 'replicate_c', 'off', ...
    'add_implementation', 'fabric core', ... 'behavioral HDL' 'DSP48 core'
    'add_latency', 1, 'async_add', 'on', 'align_c', 'off', ...
    'n_bits_out', 12, 'bin_pt_out', 7, 'type_out', 1, ...
    'quantization', 0, 'overflow', 0, 'max_fanout', 2};
  
  check_mask_type(blk, 'bus_maddsub');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  rep_w = 50; rep_d = 30;
  bus_expand_w = 50;
  bus_create_w = 50;
  mult_w = 50; mult_d = 60;
  add_w = 50; add_d = 60;
  del_w = 30; del_d = 20;

  n_bits_a                   = get_var('n_bits_a', 'defaults', defaults, varargin{:});
  bin_pt_a                   = get_var('bin_pt_a', 'defaults', defaults, varargin{:});
  type_a                     = get_var('type_a', 'defaults', defaults, varargin{:});
  cmplx_a                    = get_var('cmplx_a', 'defaults', defaults, varargin{:});
  n_bits_b                   = get_var('n_bits_b', 'defaults', defaults, varargin{:});
  bin_pt_b                   = get_var('bin_pt_b', 'defaults', defaults, varargin{:});
  type_b                     = get_var('type_b', 'defaults', defaults, varargin{:});
  mult_latency               = get_var('mult_latency', 'defaults', defaults, varargin{:});
  multiplier_implementation  = get_var('multiplier_implementation', 'defaults', defaults, varargin{:});
  replicate_ab               = get_var('replicate_ab', 'defaults', defaults, varargin{:});
  opmode                     = get_var('opmode', 'defaults', defaults, varargin{:});
  n_bits_c                   = get_var('n_bits_c', 'defaults', defaults, varargin{:});
  bin_pt_c                   = get_var('bin_pt_c', 'defaults', defaults, varargin{:});
  type_c                     = get_var('type_c', 'defaults', defaults, varargin{:});
  add_implementation         = get_var('add_implementation', 'defaults', defaults, varargin{:});
  add_latency                = get_var('add_latency', 'defaults', defaults, varargin{:});
  async_add                  = get_var('async_add', 'defaults', defaults, varargin{:});
  align_c                    = get_var('align_c', 'defaults', defaults, varargin{:});
  replicate_c                = get_var('replicate_c', 'defaults', defaults, varargin{:});
  n_bits_out                 = get_var('n_bits_out', 'defaults', defaults, varargin{:});
  bin_pt_out                 = get_var('bin_pt_out', 'defaults', defaults, varargin{:});
  type_out                   = get_var('type_out', 'defaults', defaults, varargin{:});
  quantization               = get_var('quantization', 'defaults', defaults, varargin{:});
  overflow                   = get_var('overflow', 'defaults', defaults, varargin{:});
  max_fanout                 = get_var('max_fanout', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if (~isempty(find([n_bits_a, n_bits_b, n_bits_c] == 0, 1)))
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_maddsub_init', {'trace', log_group});
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%
  % parameter checking %
  %%%%%%%%%%%%%%%%%%%%%%

  if max_fanout < 1
    clog('Maximum fanout must be 1 or greater', {'error', log_group});
    error('Maximum fanout must be 1 or greater');
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % check input lists for consistency %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  lenba = length(n_bits_a); lenpa = length(bin_pt_a); lenta = length(type_a);
  a = [lenba, lenpa, lenta];  
  unique_a = unique(a);
  compa = unique_a(length(unique_a));

  lenbb = length(n_bits_b); lenpb = length(bin_pt_b); lentb = length(type_b);
  b = [lenbb, lenpb, lentb];  
  unique_b = unique(b);
  compb = unique_b(length(unique_b));

  lenbc = length(n_bits_c); lenpc = length(bin_pt_c); lentc = length(type_c);
  c = [lenbc, lenpc, lentc];  
  unique_c = unique(c);
  compc = unique_c(length(unique_c));

  lenbo = length(n_bits_out); lenpo = length(bin_pt_out); lento = length(type_out); 
  lenq = length(quantization); leno = length(overflow);
  o = [lenbo, lenpo, lento, lenq, leno];
  unique_o = unique(o);
  compo = unique_o(length(unique_o));

  too_many_a = length(unique_a) > 2;
  conflict_a = (length(unique_a) == 2) && (unique_a(1) ~= 1);
  if too_many_a || conflict_a
    clog('conflicting component number for bus a', {'error', log_group});
    error('conflicting component number for bus a');
  end

  too_many_b = length(unique_b) > 2;
  conflict_b = (length(unique_b) == 2) && (unique_b(1) ~= 1);
  if too_many_b || conflict_b
    clog('conflicting component number for bus b', {'error', log_group});
    error('conflicting component number for bus b');
  end

  too_many_c = length(unique_c) > 2;
  conflict_c = (length(unique_c) == 2) && (unique_c(1) ~= 1);
  if too_many_c || conflict_c
    clog('conflicting component number for bus c', {'error', log_group});
    error('conflicting component number for bus c');
  end

  too_many_o = length(unique_o) > 2;
  conflict_o = (length(unique_o) == 2) && (unique_o(1) ~= 1);
  if too_many_o || conflict_o
    clog('conflicting component number for output bus', {'error', log_group});
    error('conflicting component number for output bus');
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % autocomplete input lists where necessary %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  comp = max([compa, compb, compc]);

  %replicate items if needed for a input
  n_bits_a      = repmat(n_bits_a, 1, compa/lenba); 
  bin_pt_a      = repmat(bin_pt_a, 1, compa/lenpa); 
  type_a        = repmat(type_a, 1, compa/lenta);   
  
  %replicate items if needed for b input
  n_bits_b      = repmat(n_bits_b, 1, compb/lenbb); 
  bin_pt_b      = repmat(bin_pt_b, 1, compb/lenpb);
  type_b        = repmat(type_b, 1, compb/lentb);
  
  %replicate items if needed for c input
  n_bits_c      = repmat(n_bits_c, 1, compc/lenbc); 
  bin_pt_c      = repmat(bin_pt_c, 1, compc/lenpc);
  type_c        = repmat(type_c, 1, compc/lentc);
 
  %replicate items if needed for output
  compo         = comp;
  n_bits_out    = repmat(n_bits_out, 1, comp/lenbo);
  bin_pt_out    = repmat(bin_pt_out, 1, comp/lenpo);
  type_out      = repmat(type_out, 1, comp/lento);
  overflow      = repmat(overflow, 1, comp/leno);
  quantization  = repmat(quantization, 1, comp/lenq);
  
  %%%%%%%%%%%%%%%%%%
  % fanout control %
  %%%%%%%%%%%%%%%%%%

  fa = compo/compa;   
  max_fanouta = max_fanout; 
  dupa = ceil(fa/max_fanouta); 
  compa = compa*dupa; type_a = repmat(type_a, 1, dupa) ;
  n_bits_a = repmat(n_bits_a, 1, dupa); bin_pt_a = repmat(bin_pt_a, 1, dupa);  
  a_src = repmat([1:compa], 1, ceil(compo/compa));

  fb = compo/compb;
  max_fanoutb = max_fanout; 
  dupb = ceil(fb/max_fanoutb);
  compb = compb*dupb; type_b = repmat(type_b, 1, dupb) ;
  n_bits_b = repmat(n_bits_b, 1, dupb); bin_pt_b = repmat(bin_pt_b, 1, dupb); 
  if strcmp(cmplx_a, 'on')
    b_src = repmat(reshape([1:compb; 1:compb], 1, compb*2), 1, ceil(compo/(compb*2)));
  else
    b_src = repmat(1:compb, 1, ceil(compo/compb));
  end  

  fc = compo/compc;
  max_fanoutc = max_fanout; 
  dupc = ceil(fc/max_fanoutc);
  compc = compc*dupc; type_c = repmat(type_c, 1, dupc) ;
  n_bits_c = repmat(n_bits_c, 1, dupc); bin_pt_c = repmat(bin_pt_c, 1, dupc); 
  c_src = repmat([1:compc], 1, ceil(compo/compc));
 
  %required fanout of en
  fanout = ceil(comp/max_fanout);
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all a, b, c, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_a = ', mat2str(n_bits_a)], log_group);
  clog(['n_bits_b = ', mat2str(n_bits_b)], log_group);
  clog(['n_bits_c = ', mat2str(n_bits_c)], log_group);
  clog(['n_bits_out = ', mat2str(n_bits_out)], log_group);
  clog(['bin_pt_out = ', mat2str(bin_pt_out)], log_group);
  clog(['type_out = ', mat2str(type_out)], log_group);
  clog(['overflow = ', mat2str(overflow)], log_group);
  clog(['quantization = ', mat2str(quantization)], log_group);
  clog(['duplication factors => a: ', num2str(dupa),' b: ', num2str(dupb),' c: ', num2str(dupc)], log_group);
  clog(['compa = ', num2str(compa), ' compb = ', num2str(compb), ' compc = ', num2str(compc),' compo = ', num2str(compo)], log_group);
  clog(['connection vector for port a = ', mat2str(a_src)], log_group);
  clog(['connection vector for port b = ', mat2str(b_src)], log_group);
  clog(['connection vector for port c = ', mat2str(c_src)], log_group);

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compa/2;
  reuse_block(blk, 'a', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + mult_d*(compa/2 + compb/2);
  
  reuse_block(blk, 'b', 'built-in/inport', ...
    'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + mult_d*(compb/2 + compc/2);
  
  reuse_block(blk, 'c', 'built-in/inport', ...
    'Port', '3', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + mult_d*(compc/2);

  port_offset = 4;
  if strcmp(async_add, 'on')
    ypos_tmp = ypos_tmp + yinc + mult_d*fanout;
    reuse_block(blk, 'en', 'built-in/inport', ...
      'Port', num2str(port_offset), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + yinc;
    port_offset = port_offset + 1;
  end

  xpos = xpos + xinc + port_w/2 + rep_w/2;  

  %%%%%%%%%%%%%%%%%%%%%%%%%%%
  % a,b replication control %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compa/2;

  %replicate busses

  if strcmp(replicate_ab, 'on')
    reuse_block(blk, 'repa', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(dupa), 'latency', '1', 'misc', 'off', ... 
      'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
    add_line(blk, 'a/1', 'repa/1'); 
  end

  ypos_tmp = ypos_tmp + yinc + mult_d*(compa/2 + compb/2);
  
  if strcmp(replicate_ab, 'on')
    reuse_block(blk, 'repb', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(dupb), 'latency', '1', 'misc', 'off', ...
      'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
    add_line(blk, 'b/1', 'repb/1'); 
  end 
  
  ypos_tmp = ypos_tmp + yinc + mult_d*(compb/2 + compc/2);

  ypos_tmp = ypos_tmp + 2*yinc + mult_d*(compc/2 + fanout);
  
  xpos = xpos + xinc + rep_w/2 + bus_expand_w/2;

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + mult_d*compa/2; %reset ypos

  outputWidth           = mat2str(n_bits_a);
  outputBinaryPt        = mat2str(bin_pt_a);
  outputArithmeticType  = mat2str(type_a);

  reuse_block(blk, 'a_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*compa/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*compa/2]);
  if strcmp(replicate_ab, 'on'), add_line(blk, 'repa/1', 'a_debus/1');
  else, add_line(blk, 'a/1', 'a_debus/1');
  end
  ypos_tmp = ypos_tmp + mult_d*(compa/2+compb/2) + yinc;
  
  outputWidth           = mat2str(n_bits_b);
  outputBinaryPt        = mat2str(bin_pt_b);
  outputArithmeticType  = mat2str(type_b);
  
  reuse_block(blk, 'b_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*compb/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*compb/2]);
  if strcmp(replicate_ab, 'on'), add_line(blk, 'repb/1', 'b_debus/1');
  else, add_line(blk, 'b/1', 'b_debus/1');
  end
  ypos_tmp = ypos_tmp + mult_d*(compb/2+compc/2) + yinc;
  
  ypos_tmp = ypos_tmp + mult_d*(compc/2 + fanout/2)+ yinc;

  xpos = xpos + xinc + bus_expand_w/2 + mult_w/2;  

  %%%%%%%%%%%%%%%%%%
  % multiplication %
  %%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  if strcmp(replicate_ab, 'on'), latency = mult_latency - 1;
  else, latency = mult_latency;
  end

  for index = 1:compo
    clog([num2str(index),': type = ', num2str(type_out(index)), ...
    ' quantization = ', num2str(quantization(index)), ...
    ' overflow = ', num2str(overflow(index))], log_group);
    switch type_out(index)
      case 0
        arith_type = 'Unsigned';
      case 1
        arith_type = 'Signed';
      otherwise
        clog(['unknown arithmetic type ', num2str(arith_type)], {'error', log_group});
        error(['bus_mult_init: unknown arithmetic type ', num2str(arith_type)]);
    end
    switch quantization(index)
      case 0
        quant = 'Truncate';
      case 1
        quant = 'Round  (unbiased: +/- Inf)';
    end  
    switch overflow(index)
      case 0
        of = 'Wrap';
      case 1
        of = 'Saturate';
      case 2
        of = 'Flag as error';
    end  
    clog(['output ', num2str(index),': (', num2str(n_bits_out(index)), ' ', ...
      num2str(bin_pt_out(index)),') ', arith_type,' ', quant,' ', of], ...
      log_group); 

    mult_name = ['mult', num2str(index)]; 
    clog(['drawing ',mult_name], log_group);
   
                                          %standard multiplication 
    if strcmp(multiplier_implementation, 'behavioral HDL')
      use_behavioral_HDL = 'on';
      use_embedded = 'off';
    else
      use_behavioral_HDL = 'off';
      if strcmp(multiplier_implementation, 'embedded multiplier core')
        use_embedded = 'on';
      elseif strcmp(multiplier_implementation, 'standard core')
        use_embedded = 'off';
      end
    end

    reuse_block(blk, mult_name, 'xbsIndex_r4/Mult', ...
      'latency', num2str(latency), 'precision', 'Full', ...
      'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
      'Position', [xpos-mult_w/2 ypos_tmp xpos+mult_w/2 ypos_tmp+mult_d-20]);
    
    ypos_tmp = ypos_tmp + mult_d;
    clog('done', log_group);
 
    add_line(blk, ['a_debus/', num2str(a_src(index))], [mult_name, '/1']);
    add_line(blk, ['b_debus/', num2str(b_src(index))], [mult_name, '/2']);
  end %for

  ypos_tmp = ypos + mult_d*(compb+compa+compc+fanout) + 4*yinc;
  
  if strcmp(async_add, 'on')
    %en 
    reuse_block(blk, 'den0', 'xbsIndex_r4/Delay', ...
      'latency', num2str(mult_latency-1), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'en/1', 'den0/1');
  end 
  
  xpos = xpos + xinc + mult_w/2 + rep_w/2;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % replication of enable for add/sub %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  ypos_tmp = ypos + yinc*2 + mult_d*(compa+compb+compc/2);

  if strcmp(replicate_c, 'on')
    latency = 1;
    reuse_block(blk, 'repc', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(dupc), 'latency', '1', 'misc', 'off', ...
      'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
    add_line(blk, 'c/1', 'repc/1'); 
  end 

  ypos_tmp = ypos_tmp + yinc + mult_d*compc/2;
  
  if strcmp(async_add, 'on')
    ypos_tmp = ypos_tmp + mult_d*fanout/2;

    reuse_block(blk, 'repen1', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(fanout), 'latency', num2str(mult_latency), 'misc', 'off', ...
      'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
    add_line(blk, 'en/1', 'repen1/1'); 
    
    ypos_tmp = ypos_tmp + yinc + mult_d*fanout/2;

    %en 
    reuse_block(blk, 'den1', 'xbsIndex_r4/Delay', ...
      'latency', '1', 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'den0/1', 'den1/1');
  end 
  
  xpos = xpos + xinc + rep_w/2 + bus_expand_w/2;
  
  %%%%%%%%%%%%%%%%%%%%
  % debus for addsub %
  %%%%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*(compa + compb + compc/2) + yinc*2;

  outputWidth           = mat2str(n_bits_c);
  outputBinaryPt        = mat2str(bin_pt_c);
  outputArithmeticType  = mat2str(type_c);
  
  reuse_block(blk, 'c_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*compc/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*compc/2]);
  if strcmp(replicate_c, 'on'), add_line(blk, 'repc/1', 'c_debus/1');
  else, add_line(blk, 'c/1', 'c_debus/1');
  end
  
  ypos_tmp = ypos_tmp + mult_d*compc/2 + yinc;

  if strcmp(async_add, 'on')
    ypos_tmp = ypos_tmp + mult_d*fanout/2;

    reuse_block(blk, 'en_debus1', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', ...
      'outputNum', num2str(fanout), ...
      'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
      'show_format', 'on', 'outputToWorkspace', 'off', ...
      'variablePrefix', '', 'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*fanout/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*fanout/2]);

    add_line(blk, 'repen1/1', 'en_debus1/1');
  end %if
  
  xpos = xpos + xinc + bus_expand_w/2 + add_w/2;
  
  %%%%%%%%%%%%%%%%%%%%%%%%
  % addition/subtraction %
  %%%%%%%%%%%%%%%%%%%%%%%%

  %addsub
  ypos_tmp = ypos; %reset ypos 

  clog(['making ', num2str(compo),' AddSubs'], log_group);

  for index = 1:compo
    switch type_out(index)
      case 0
        arith_type = 'Unsigned';
      case 1
        arith_type = 'Signed';
    end
    switch quantization(index)
      case 0
        quant = 'Truncate';
      case 1
        quant = 'Round  (unbiased: +/- Inf)';
    end  
    switch overflow(index)
      case 0
        of = 'Wrap';
      case 1
        of = 'Saturate';
      case 2
        of = 'Flag as error';
    end  
    if strcmp(opmode, 'Addition')
      symbol = '+';
    else
      symbol = '-';
    end  
        
    clog(['output ', num2str(index),': ', ... 
      ' a[', num2str(a_src(index)),'] ',symbol,' b[', num2str(b_src(index)),'] = ', ...
      '(', num2str(n_bits_out(index)), ' ', num2str(bin_pt_out(index)),') ' ...
      ,arith_type,' ', quant,' ', of], log_group); 

    if strcmp(add_implementation, 'behavioral HDL')
      use_behavioral_HDL = 'on';
      hw_selection = 'Fabric';
    elseif strcmp(add_implementation, 'fabric core')
      use_behavioral_HDL = 'off';
      hw_selection = 'Fabric';
    elseif strcmp(add_implementation, 'DSP48 core')
      use_behavioral_HDL = 'off';
      hw_selection = 'DSP48';
    end

    add_name = ['addsub', num2str(index)]; 
    
    reuse_block(blk, add_name, 'xbsIndex_r4/AddSub', ...
      'mode', opmode, 'latency', num2str(add_latency), ...
      'en', async_add, 'precision', 'User Defined', ...
      'n_bits', num2str(n_bits_out(index)), 'bin_pt', num2str(bin_pt_out(index)), ...  
      'arith_type', arith_type, 'quantization', quant, 'overflow', of, ... 
      'pipelined', 'on', 'use_behavioral_HDL', use_behavioral_HDL, 'hw_selection', hw_selection, ... 
      'Position', [xpos-add_w/2 ypos_tmp xpos+add_w/2 ypos_tmp+add_d-20]);
    ypos_tmp = ypos_tmp + add_d;
  
    mult_name = ['mult', num2str(index)]; 
    add_line(blk, [mult_name, '/1'], [add_name,'/1']);
    add_line(blk, ['c_debus/', num2str(c_src(index))], [add_name,'/2']);

    if strcmp(async_add, 'on')
      add_line(blk, ['en_debus1/', num2str(floor((index-1)/max_fanout)+1)], [add_name,'/3']);
    end

  end %for

  ypos_tmp = ypos + mult_d*(compa+compb+compc+fanout) + yinc*4;

  if strcmp(async_add, 'on')
    %en 
    reuse_block(blk, 'den2', 'xbsIndex_r4/Delay', ...
      'latency', num2str(add_latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'den1/1', 'den2/1');
  end 

  xpos = xpos + xinc + add_w/2 + bus_create_w/2;

  %%%%%%%%%%%%%%
  % bus create %
  %%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compo/2; %reset ypos

  if strcmp(opmode, 'Addition'), op = '+';
  else, op = '-';
  end

  reuse_block(blk, ['a*b', op, 'c_bussify'], 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compo), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-mult_d*compo/2 xpos+bus_create_w/2 ypos_tmp+mult_d*compo/2]);
  
  for index = 1:compo, add_line(blk, ['addsub', num2str(index),'/1'], ['a*b', op, 'c_bussify/', num2str(index)]); end

  xpos = xpos + xinc + bus_create_w/2 + port_w/2;

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compo/2;
  reuse_block(blk, ['a*b', op, 'c'], 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['a*b', op, 'c_bussify/1'], ['a*b', op, 'c/1']);

  ypos_tmp = ypos + mult_d*(compb+compa+compc+fanout) + 4*yinc;

  if strcmp(async_add, 'on')
    reuse_block(blk, 'dvalid', 'built-in/outport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    add_line(blk, 'den2/1', 'dvalid/1');
  end 
 
  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_maddsub_init', {'trace', log_group});

end %function bus_maddsub_init

