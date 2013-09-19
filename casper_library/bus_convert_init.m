
function bus_convert_init(blk, varargin)

  clog('entering bus_convert_init', 'trace');
  
  defaults = { ...
    'n_bits_in',  [8 8 8],  'bin_pt_in',       8 , 'type_in', 1,  'cmplx', 'off', ...
    'n_bits_out',      8 ,  'bin_pt_out',      4 , 'type_out', 1, ...
    'overflow', 1 , 'quantization', 1,   'misc', 'on', 'latency', 2, 'of', 'on', ...
  };  
  
  check_mask_type(blk, 'bus_convert');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  bus_expand_w = 50;
  bus_create_w = 50;
  convert_w = 50; convert_d = 60;
  del_w = 30; del_d = 20;

  n_bits_in       = get_var('n_bits_in', 'defaults', defaults, varargin{:});
  bin_pt_in       = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  type_in         = get_var('type_in', 'defaults', defaults, varargin{:});
  cmplx           = get_var('cmplx', 'defaults', defaults, varargin{:});
  n_bits_out      = get_var('n_bits_out', 'defaults', defaults, varargin{:});
  bin_pt_out      = get_var('bin_pt_out', 'defaults', defaults, varargin{:});
  type_out        = get_var('type_out', 'defaults', defaults, varargin{:});
  overflow        = get_var('overflow', 'defaults', defaults, varargin{:});
  quantization    = get_var('quantization', 'defaults', defaults, varargin{:});
  latency         = get_var('latency', 'defaults', defaults, varargin{:});
  misc            = get_var('misc', 'defaults', defaults, varargin{:});
  of              = get_var('of', 'defaults', defaults, varargin{:});

  delete_lines(blk);
  
 %default state, do nothing 
  if isempty(n_bits_in),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_convert_init','trace');
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % check input lists for consistency %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  lenbi = length(n_bits_in); lenpi = length(bin_pt_in); lenti = length(type_in);
  i = [lenbi, lenpi, lenti];  
  unique_i = unique(i);
  compi = unique_i(length(unique_i));

  lenbo = length(n_bits_out); lenpo = length(bin_pt_out); lento = length(type_out); 
  lenq = length(quantization); leno = length(overflow);
  o = [lenbo, lenpo, lento, lenq, leno];
  unique_o = unique(o);
  compo = unique_o(length(unique_o));

  too_many_i = length(unique_i) > 2;
  conflict_i = (length(unique_i) == 2) && (unique_i(1) ~= 1);
  if too_many_i | conflict_i,
    error('conflicting component number for input bus');
    clog('conflicting component number for input bus', 'error');
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
  comp = compi;

  %replicate items if needed for a input
  n_bits_in      = repmat(n_bits_in, 1, compi/lenbi); 
  bin_pt_in      = repmat(bin_pt_in, 1, compi/lenpi); 
  type_in        = repmat(type_in, 1, compi/lenti);   

  %if complex we need to double down on some of these
  if strcmp(cmplx, 'on'),
    compi        = compi*2;
    n_bits_in    = reshape([n_bits_in; n_bits_in], 1, compi); 
    bin_pt_in    = reshape([bin_pt_in; bin_pt_in], 1, compi); 
    type_in      = reshape([type_in; type_in], 1, compi);   
  end
  
  %replicate items if needed for output
  compo         = comp;
  n_bits_out    = repmat(n_bits_out, 1, comp/lenbo);
  bin_pt_out    = repmat(bin_pt_out, 1, comp/lenpo);
  type_out      = repmat(type_out, 1, comp/lento);
  overflow      = repmat(overflow, 1, comp/leno);
  quantization  = repmat(quantization, 1, comp/lenq);
  
  if strcmp(cmplx, 'on'),
    compo       = comp*2;
    n_bits_out  = reshape([n_bits_out; n_bits_out], 1, compo);    
    bin_pt_out  = reshape([bin_pt_out; bin_pt_out], 1, compo);    
    type_out    = reshape([type_out; type_out], 1, compo);         
    overflow    = reshape([overflow; overflow], 1, compo);        
    quantization= reshape([quantization; quantization], 1, compo); 
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all input, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_in = ',mat2str(n_bits_in)],'bus_convert_init_debug');
  clog(['n_bits_out = ',mat2str(n_bits_out)],'bus_convert_init_debug');
  clog(['bin_pt_out = ',mat2str(bin_pt_out)],'bus_convert_init_debug');
  clog(['type_out = ',mat2str(type_out)],'bus_convert_init_debug');
  clog(['overflow = ',mat2str(overflow)],'bus_convert_init_debug');
  clog(['quantization = ',mat2str(quantization)],'bus_convert_init_debug');
  clog(['compi = ',num2str(compi), ' compo = ', num2str(compo)],'bus_convert_init_debug');

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + convert_d*compi/2;
  reuse_block(blk, 'din', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + convert_d*compi/2;
  
  %space for of_bussify
  if strcmp(of, 'on'), ypos_tmp = ypos_tmp + yinc + convert_d*compi; end
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + convert_d*compi/2; %reset ypos

  outputWidth           = mat2str(n_bits_in);
  outputBinaryPt        = mat2str(bin_pt_in);
  outputArithmeticType  = mat2str(type_in);

  reuse_block(blk, 'debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-convert_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+convert_d*compi/2]);
  add_line(blk, 'din/1', 'debus/1');
  ypos_tmp = ypos_tmp + convert_d*(compi/2) + yinc;
  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%%%%
  % convert layer %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  for index = 1:compo,
    switch type_out(index),
      case 0,
        arith_type = 'Unsigned';
      case 1,
        arith_type = 'Signed';
      otherwise,
        clog(['unknown arithmetic type ',num2str(arith_type)], 'error');
        error(['bus_convert_init: unknown arithmetic type ',num2str(arith_type)]);
    end
    switch quantization(index),
      case 0,
        quant = 'Truncate';
      case 1,
        quant = 'Round  (unbiased: +/- Inf)';
      case 2,
        quant = 'Round  (unbiased: Even Values)';
    end  
    switch overflow(index),
      case 0,
        oflow = 'Wrap';
      case 1,
        oflow = 'Saturate';
      case 2,
        oflow = 'Flag as error';
    end  
    bits_in = n_bits_in(index); pt_in = bin_pt_in(index);
    bits_out = n_bits_out(index); pt_out = bin_pt_out(index);

    clog(['output ',num2str(index), ...
      ': (', num2str(bits_in), ' ', num2str(pt_in),') => ', ... 
      '(', num2str(bits_out), ' ', num2str(pt_out),') ', ... 
      arith_type,' ',quant,' ', oflow], ...
      'bus_convert_init_debug'); 

    conv_name = ['conv',num2str(index)];

    position = [xpos-convert_w/2 ypos_tmp xpos+convert_w/2 ypos_tmp+convert_d-20];

    %casper convert blocks don't support increasing binary points
    if strcmp(of, 'on'),
      reuse_block(blk, conv_name, 'casper_library_misc/convert_of', ...
        'bit_width_i', num2str(bits_in), 'binary_point_i', num2str(pt_in), ... 
        'bit_width_o', num2str(bits_out), 'binary_point_o', num2str(pt_out), ... 
        'latency', 'latency', 'overflow', oflow, 'quantization', quant, ...
        'Position', position);
    else,
      %CASPER converts can't increase binary points so use generic Xilinx
      if pt_out > pt_in,
        reuse_block(blk, conv_name, 'xbsIndex_r4/Convert', ...
          'arith_type', 'Signed  (2''s comp)', ...
          'n_bits', num2str(bits_out), 'bin_pt', num2str(pt_out), ... 
          'latency', 'latency', 'overflow', oflow, 'quantization', quant, ...
          'Position', position);
      else,
        reuse_block(blk, conv_name, 'casper_library_misc/convert', ...
          'bin_pt_in', num2str(pt_in), ...
          'n_bits_out', num2str(bits_out), 'bin_pt_out', num2str(pt_out), ...
          'overflow', oflow, 'quantization', quant, 'latency', 'latency', ...  
          'Position', position);
      end
    end

    ypos_tmp = ypos_tmp + convert_d;

    add_line(blk, ['debus/',num2str(index)], [conv_name,'/1']);
  end
 
  ypos_tmp = ypos + yinc + convert_d*compi;

  %space for of_bussify
  if strcmp(of, 'on'), ypos_tmp = ypos_tmp + yinc + convert_d*compi; end

  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', 'latency', 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
    ypos_tmp = ypos_tmp + convert_d;
  end
 
  %%%%%%%%%%%%%%%%%%%%
  % create bus again %
  %%%%%%%%%%%%%%%%%%%%
 
  ypos_tmp = ypos + convert_d*compo/2;
  xpos = xpos + xinc + bus_expand_w/2;

  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compo), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-convert_d*compo/2 xpos+bus_create_w/2 ypos_tmp+convert_d*compo/2]);
  
  for index = 1:compo,
    add_line(blk, ['conv',num2str(index),'/1'], ['bussify/',num2str(index)]);
  end

  if strcmp(of, 'on'),
    ypos_tmp = ypos_tmp + yinc + compo*convert_d;
    reuse_block(blk, 'of_bussify', 'casper_library_flow_control/bus_create', ...
      'inputNum', num2str(compo), ...
      'Position', [xpos-bus_create_w/2 ypos_tmp-convert_d*compo/2 xpos+bus_create_w/2 ypos_tmp+convert_d*compo/2]);
  
    for index = 1:compo,
      add_line(blk, ['conv',num2str(index),'/2'], ['of_bussify/',num2str(index)]);
    end
  end

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + convert_d*compo/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['dout/1']);
  
  ypos_tmp = ypos_tmp + yinc + convert_d*compo/2;
  
  port_no = 1;
  if strcmp(of, 'on'), 
    ypos_tmp = ypos_tmp + convert_d*compo/2;
    reuse_block(blk, 'overflow', 'built-in/outport', ...
      'Port', num2str(port_no+1), ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'of_bussify/1', 'overflow/1');
    ypos_tmp = ypos_tmp + yinc + convert_d*compo/2;
    port_no = port_no + 1;
  end

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', num2str(port_no + 1), ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_convert_init','trace');

end %function bus_convert_init
