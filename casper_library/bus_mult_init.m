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

function bus_mult_init(blk, varargin)

  clog('entering bus_mult_init', 'trace');
  
  defaults = { ...
    'n_bits_a', 0,  'bin_pt_a',     4,   'type_a',   1, 'cmplx_a', 'off', ...
    'n_bits_b', [4],  'bin_pt_b',     3,   'type_b',   1, 'cmplx_b', 'on', ...
    'n_bits_out', 12 ,  'bin_pt_out',   7,   'type_out', 1, ...
    'overflow', 0,      'quantization', 0,   'misc', 'on', ...
    'mult_latency', 3,  'add_latency', 1 , 'conv_latency', 1, ...
    'max_fanout', 2, 'fan_latency', 0, ...
    'multiplier_implementation', 'behavioral HDL', ... 'embedded multiplier core' 'standard core' ...
  };  
  
  check_mask_type(blk, 'bus_mult');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  rep_w = 50; rep_d = 30;
  bus_expand_w = 50;
  bus_create_w = 50;
  mult_w = 50; mult_d = 60;
  del_w = 30; del_d = 20;

  n_bits_a                   = get_var('n_bits_a', 'defaults', defaults, varargin{:});
  bin_pt_a                   = get_var('bin_pt_a', 'defaults', defaults, varargin{:});
  type_a                     = get_var('type_a', 'defaults', defaults, varargin{:});
  cmplx_a                    = get_var('cmplx_a', 'defaults', defaults, varargin{:});
  n_bits_b                   = get_var('n_bits_b', 'defaults', defaults, varargin{:});
  bin_pt_b                   = get_var('bin_pt_b', 'defaults', defaults, varargin{:});
  type_b                     = get_var('type_b', 'defaults', defaults, varargin{:});
  cmplx_b                    = get_var('cmplx_b', 'defaults', defaults, varargin{:});
  n_bits_out                 = get_var('n_bits_out', 'defaults', defaults, varargin{:});
  bin_pt_out                 = get_var('bin_pt_out', 'defaults', defaults, varargin{:});
  type_out                   = get_var('type_out', 'defaults', defaults, varargin{:});
  overflow                   = get_var('overflow', 'defaults', defaults, varargin{:});
  quantization               = get_var('quantization', 'defaults', defaults, varargin{:});
  mult_latency               = get_var('mult_latency', 'defaults', defaults, varargin{:});
  add_latency                = get_var('add_latency', 'defaults', defaults, varargin{:});
  conv_latency               = get_var('conv_latency', 'defaults', defaults, varargin{:});
  max_fanout                 = get_var('max_fanout', 'defaults', defaults, varargin{:});
  fan_latency                = get_var('fan_latency', 'defaults', defaults, varargin{:});
  misc                       = get_var('misc', 'defaults', defaults, varargin{:});
  multiplier_implementation  = get_var('multiplier_implementation', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if (n_bits_a == 0 | n_bits_b == 0),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_mult_init','trace');
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%
  % parameter checking %
  %%%%%%%%%%%%%%%%%%%%%%

  if (strcmp(cmplx_a, 'on') || strcmp(cmplx_b, 'on')) && max_fanout < 2,
    clog('Complex multiplication without fanout of at least 2 is impossible','error');
    error('Complex multiplication without fanout of at least 2 is impossible');
  end

  if max_fanout < 1,
    clog('Maximum fanout must be 1 or greater','error');
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

  lenbo = length(n_bits_out); lenpo = length(bin_pt_out); lento = length(type_out); 
  lenq = length(quantization); leno = length(overflow);
  o = [lenbo, lenpo, lento, lenq, leno];
  unique_o = unique(o);
  compo = unique_o(length(unique_o));

  too_many_a = length(unique_a) > 2;
  conflict_a = (length(unique_a) == 2) && (unique_a(1) ~= 1);
  if too_many_a | conflict_a,
    error('conflicting component number for bus a');
    clog('conflicting component number for bus a', 'error');
  end

  too_many_b = length(unique_b) > 2;
  conflict_b = (length(unique_b) == 2) && (unique_b(1) ~= 1);
  if too_many_b | conflict_b,
    error('conflicting component number for bus b');
    clog('conflicting component number for bus b', 'error');
  end

  too_many_o = length(unique_o) > 2;
  conflict_o = (length(unique_o) == 2) && (unique_o(1) ~= 1);
  if too_many_o | conflict_o,
    error('conflicting component number for output bus');
    clog('conflicting component number for output bus', 'error');
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % autocomplete input lists where necessary %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  comp = max(compa, compb);

  %replicate items if needed for a input
  n_bits_a      = repmat(n_bits_a, 1, compa/lenba); 
  bin_pt_a      = repmat(bin_pt_a, 1, compa/lenpa); 
  type_a        = repmat(type_a, 1, compa/lenta);   

  %if complex we need to double down on some of these
  if strcmp(cmplx_a, 'on'),
    if ~strcmp(cmplx_b, 'on'),
      compa       = compa*2;
      n_bits_a    = reshape([n_bits_a; n_bits_a], 1, compa); 
      bin_pt_a    = reshape([bin_pt_a; bin_pt_a], 1, compa); 
      type_a      = reshape([type_a; type_a], 1, compa);   
    end 
  end
  
  %replicate items if needed for b input
  n_bits_b      = repmat(n_bits_b, 1, compb/lenbb); 
  bin_pt_b      = repmat(bin_pt_b, 1, compb/lenpb);
  type_b        = repmat(type_b, 1, compb/lentb);
  
  if strcmp(cmplx_b, 'on'), 
    if ~strcmp(cmplx_a, 'on'), %if only one input complex, then double number outputs
      compb       = compb*2;
      n_bits_b    = reshape([n_bits_b; n_bits_b], 1, compb); 
      bin_pt_b    = reshape([bin_pt_b; bin_pt_b], 1, compb); 
      type_b      = reshape([type_b; type_b], 1, compb);     
    end
  end

  %replicate items if needed for output
  compo         = comp;
  n_bits_out    = repmat(n_bits_out, 1, comp/lenbo);
  bin_pt_out    = repmat(bin_pt_out, 1, comp/lenpo);
  type_out      = repmat(type_out, 1, comp/lento);
  overflow      = repmat(overflow, 1, comp/leno);
  quantization  = repmat(quantization, 1, comp/lenq);
  
  if (strcmp(cmplx_b, 'on') & ~strcmp(cmplx_a, 'on')) || (strcmp(cmplx_a, 'on') & ~strcmp(cmplx_b, 'on')),
    compo       = comp*2;
    n_bits_out  = reshape([n_bits_out; n_bits_out], 1, compo);    
    bin_pt_out  = reshape([bin_pt_out; bin_pt_out], 1, compo);    
    type_out    = reshape([type_out; type_out], 1, compo);         
    overflow    = reshape([overflow; overflow], 1, compo);        
    quantization= reshape([quantization; quantization], 1, compo); 
  end

  %%%%%%%%%%%%%%%%%%
  % fanout control %
  %%%%%%%%%%%%%%%%%%

  fa = compo/compa; fb = compo/compb;
  if strcmp(cmplx_a, 'on'), 
    fa = fa*2;
    %if complex, fanout can only be a multiple of 2 (on the conservative side)
    max_fanouta = max(1, floor(max_fanout/2)*2); 
  else,
    max_fanouta = max_fanout; 
  end
  if strcmp(cmplx_b, 'on'), 
    fb = fb*2; 
    %if complex, fanout can only be a multiple of 2 (on the conservative side)
    max_fanoutb = max(1, floor(max_fanout/2)*2); 
  else
    max_fanoutb = max_fanout; 
  end
  dupa = ceil(fa/max_fanouta); dupb = ceil(fb/max_fanoutb);

  %change constants to cater for fanout 
  compa = compa*dupa; type_a = repmat(type_a, 1, dupa) ;
  n_bits_a = repmat(n_bits_a, 1, dupa); bin_pt_a = repmat(bin_pt_a, 1, dupa);  

  compb = compb*dupb; type_b = repmat(type_b, 1, dupb) ;
  n_bits_b = repmat(n_bits_b, 1, dupb); bin_pt_b = repmat(bin_pt_b, 1, dupb); 

  %initial connection vector
  if strcmp(cmplx_b, 'on') && ~strcmp(cmplx_a,'on'), 
    a_src = reshape(repmat([1:compa], ceil(compo/compa), 1), 1, ceil(compo/compa)*compa);
  else,
    a_src = repmat([1:compa], 1, ceil(compo/compa));
  end
  
  if strcmp(cmplx_a, 'on') && ~strcmp(cmplx_b,'on'), 
    b_src = reshape(repmat([1:compb], ceil(compo/compb), 1), 1, ceil(compo/compb)*compb);
  else,
    b_src = repmat([1:compb], 1, ceil(compo/compb));
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all a, b, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_a = ',mat2str(n_bits_a)],'bus_mult_init_debug');
  clog(['n_bits_b = ',mat2str(n_bits_b)],'bus_mult_init_debug');
  clog(['n_bits_out = ',mat2str(n_bits_out)],'bus_mult_init_debug');
  clog(['bin_pt_out = ',mat2str(bin_pt_out)],'bus_mult_init_debug');
  clog(['type_out = ',mat2str(type_out)],'bus_mult_init_debug');
  clog(['overflow = ',mat2str(overflow)],'bus_mult_init_debug');
  clog(['quantization = ',mat2str(quantization)],'bus_mult_init_debug');
  clog(['duplication factors => a: ',num2str(dupa),' b: ',num2str(dupb)],'bus_mult_init_debug');
  clog(['compa = ',num2str(compa), ' compb = ',num2str(compb), ' compo = ', num2str(compo)],'bus_mult_init_debug');
  clog(['connection vector for port a = ',mat2str(a_src)],'bus_mult_init_debug');
  clog(['connection vector for port b = ',mat2str(b_src)],'bus_mult_init_debug');

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compa/2;
  reuse_block(blk, 'a', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + mult_d*(compa/2 + compb/2);
  
  reuse_block(blk, 'b', 'built-in/inport', ...
    'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + mult_d*compb/2;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '3', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%%%%%
  % fanout control %
  %%%%%%%%%%%%%%%%%%

  %if dupa > 1 || dupb > 1, dup_latency = fan_latency; else dup_latency = 0; end
  dup_latency = fan_latency;

  ypos_tmp = ypos + mult_d*compa/2;

  %replicate busses
  reuse_block(blk, 'repa', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(dupa), 'latency', num2str(dup_latency), 'misc', 'off', ... 
    'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
  add_line(blk, 'a/1', 'repa/1'); 

  ypos_tmp = ypos_tmp + yinc + mult_d*(compa/2 + compb/2);
  
  reuse_block(blk, 'repb', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(dupb), 'latency', num2str(dup_latency), 'misc', 'off', ...
    'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
  add_line(blk, 'b/1', 'repb/1'); 
  
  xpos = xpos + xinc + rep_d;

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + mult_d*compa/2; %reset ypos

  if strcmp(cmplx_a, 'on') && strcmp(cmplx_b, 'on'),
    outputWidth           = mat2str(n_bits_a*2);
    outputBinaryPt        = mat2str(0*bin_pt_a);
    outputArithmeticType  = mat2str(0*type_a);  
  else
    outputWidth           = mat2str(n_bits_a);
    outputBinaryPt        = mat2str(bin_pt_a);
    outputArithmeticType  = mat2str(type_a);
  end

  reuse_block(blk, 'a_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*compa/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*compa/2]);
  add_line(blk, 'repa/1', 'a_debus/1');
  ypos_tmp = ypos_tmp + mult_d*(compa/2+compb/2) + yinc;
  
  if strcmp(cmplx_a, 'on') && strcmp(cmplx_b, 'on'),
    outputWidth           = mat2str(n_bits_b*2);
    outputBinaryPt        = mat2str(0*bin_pt_b);
    outputArithmeticType  = mat2str(0*type_b);  
  else
    outputWidth           = mat2str(n_bits_b);
    outputBinaryPt        = mat2str(bin_pt_b);
    outputArithmeticType  = mat2str(type_b);
  end
  
  reuse_block(blk, 'b_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-mult_d*compb/2 xpos+bus_expand_w/2 ypos_tmp+mult_d*compb/2]);
  add_line(blk, 'repb/1', 'b_debus/1');
  ypos_tmp = ypos_tmp + mult_d*compa + yinc;

  %%%%%%%%%%%%%%%%%%
  % multiplication %
  %%%%%%%%%%%%%%%%%%

  xpos = xpos + xinc + mult_w/2;  
  ypos_tmp = ypos; %reset ypos 

  for index = 1:compo,
    clog([num2str(index),': type= ', num2str(type_out(index)), ...
    ' quantization= ', num2str(quantization(index)), ...
    ' overflow= ',num2str(overflow(index))],'bus_mult_init_debug');
    switch type_out(index),
      case 0,
        arith_type = 'Unsigned';
      case 1,
        arith_type = 'Signed';
      otherwise,
        clog(['unknown arithmetic type ',num2str(arith_type)], 'error');
        error(['bus_mult_init: unknown arithmetic type ',num2str(arith_type)]);
    end
    switch quantization(index),
      case 0,
        quant = 'Truncate';
      case 1,
        quant = 'Round  (unbiased: +/- Inf)';
    end  
    switch overflow(index),
      case 0,
        of = 'Wrap';
      case 1,
        of = 'Saturate';
      case 2,
        of = 'Flag as error';
    end  
    clog(['output ',num2str(index),': (',num2str(n_bits_out(index)), ' ', ...
      num2str(bin_pt_out(index)),') ', arith_type,' ',quant,' ', of], ...
      'bus_mult_init_debug'); 

    mult_name = ['mult',num2str(index)]; 
    clog(['drawing ',mult_name], 'bus_mult_init_debug');
   
    if strcmp(cmplx_a, 'on') && strcmp(cmplx_b, 'on'), %need complex multiplication
      reuse_block(blk, mult_name, 'casper_library_multipliers/cmult',  ...
        'n_bits_a', num2str(n_bits_a(a_src(index))), 'bin_pt_a', num2str(bin_pt_a(a_src(index))), ...
        'n_bits_b', num2str(n_bits_b(b_src(index))), 'bin_pt_b', num2str(bin_pt_b(b_src(index))), ...
        'n_bits_ab', num2str(n_bits_out(index)), 'bin_pt_ab', num2str(bin_pt_out(index)), ...
        'quantization', quant, 'overflow', of, 'conjugated', 'off', ...
        'multiplier_implementation', multiplier_implementation, ...
        'mult_latency', 'mult_latency', 'add_latency', 'add_latency', 'conv_latency', 'conv_latency', ...
        'Position', [xpos-mult_w/2 ypos_tmp xpos+mult_w/2 ypos_tmp+mult_d-20] );
    else,  
                                            %standard multiplication 
      if strcmp(multiplier_implementation, 'behavioral HDL'),
        use_behavioral_HDL = 'on';
        use_embedded = 'off';
      else
        use_behavioral_HDL = 'off';
        if strcmp(multiplier_implementation, 'embedded multiplier core'),
          use_embedded = 'on';
        elseif strcmp(multiplier_implementation, 'standard core'),
          use_embedded = 'off';
        else,
        end
      end
      reuse_block(blk, mult_name, 'xbsIndex_r4/Mult', ...
        'latency', 'mult_latency', 'precision', 'User Defined', ...
        'n_bits', num2str(n_bits_out(index)), 'bin_pt', num2str(bin_pt_out(index)), ...  
        'arith_type', arith_type, 'quantization', quant, 'overflow', of, ... 
        'use_behavioral_HDL', use_behavioral_HDL, 'use_embedded', use_embedded, ...
        'Position', [xpos-mult_w/2 ypos_tmp xpos+mult_w/2 ypos_tmp+mult_d-20]);
    end
    ypos_tmp = ypos_tmp + mult_d;
    clog(['done'], 'bus_mult_init_debug');
 
    add_line(blk, ['a_debus/',num2str(a_src(index))], [mult_name,'/1']);
    add_line(blk, ['b_debus/',num2str(b_src(index))], [mult_name,'/2']);
  end %for

  ypos_tmp = ypos + mult_d*(compb+compa) + 2*yinc;
  if strcmp(misc, 'on'),
    if strcmp(cmplx_a, 'on') && strcmp(cmplx_b, 'on'),
      latency = ['mult_latency+add_latency+conv_latency+fan_latency'];
    else,
      latency = ['mult_latency+fan_latency'];
    end

    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', latency, 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
  end
  xpos = xpos + xinc + mult_d/2;

  %%%%%%%%%%%%%%
  % bus create %
  %%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compo/2; %reset ypos
 
  reuse_block(blk, 'a*b_bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compo), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-mult_d*compo/2 xpos+bus_create_w/2 ypos_tmp+mult_d*compo/2]);
  
  for index = 1:compo, add_line(blk, ['mult',num2str(index),'/1'], ['a*b_bussify/',num2str(index)]); end

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + mult_d*compo/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'a*b', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['a*b_bussify/1'], ['a*b/1']);
  ypos_tmp = ypos_tmp + yinc + port_d;  

  ypos_tmp = ypos + mult_d*(compb+compa) + 2*yinc;
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end
  
  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_mult_init','trace');

end %function bus_mult_init

