function bus_negate_init(blk, varargin)

  clog('entering bus_negate_init', 'trace');
  
  defaults = { ...
    'n_bits_in',  [8 8 8], 'bin_pt_in', 8 , 'cmplx', 'off', ...
    'overflow', 1 , 'misc', 'off', 'latency', 2, ...
  };  
  
  check_mask_type(blk, 'bus_negate');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  bus_expand_w = 50;
  bus_create_w = 50;
  neg_w = 50; neg_d = 60;
  del_w = 30; del_d = 20;

  n_bits_in       = get_var('n_bits_in', 'defaults', defaults, varargin{:});
  bin_pt_in       = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  cmplx           = get_var('cmplx', 'defaults', defaults, varargin{:});
  overflow        = get_var('overflow', 'defaults', defaults, varargin{:});
  latency         = get_var('latency', 'defaults', defaults, varargin{:});
  misc            = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);
  
 %default state, do nothing 
  if n_bits_in == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_negate_init','trace');
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % check input lists for consistency %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  lenbi = length(n_bits_in); lenpi = length(bin_pt_in);
  i = [lenbi, lenpi];  
  unique_i = unique(i);
  compi = unique_i(length(unique_i));

  leno = length(overflow);
  o = [leno];
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

  %if complex we need to double down on some of these
  if strcmp(cmplx, 'on'),
    compi        = compi*2;
    n_bits_in    = reshape([n_bits_in; n_bits_in], 1, compi); 
    bin_pt_in    = reshape([bin_pt_in; bin_pt_in], 1, compi); 
  end
  
  %replicate items if needed for output
  compo         = comp;
  overflow      = repmat(overflow, 1, comp/leno);
  
  if strcmp(cmplx, 'on'),
    compo       = comp*2;
    overflow    = reshape([overflow; overflow], 1, compo);        
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all input, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_in = ',mat2str(n_bits_in)],'bus_negate_init_debug');
  clog(['overflow = ',mat2str(overflow)],'bus_negate_init_debug');
  clog(['compi = ',num2str(compi), ' compo = ', num2str(compo)],'bus_negate_init_debug');

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + neg_d*compi/2;
  reuse_block(blk, 'din', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + neg_d*compi/2;
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + neg_d*compi/2; %reset ypos

  outputWidth           = mat2str(n_bits_in);
  outputBinaryPt        = mat2str(bin_pt_in);
  outputArithmeticType  = ['ones(1,',num2str(compi),')'];

  reuse_block(blk, 'debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-neg_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+neg_d*compi/2]);
  add_line(blk, 'din/1', 'debus/1');
  ypos_tmp = ypos_tmp + neg_d*(compi/2) + yinc;
  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%%%%
  % negate layer %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  for index = 1:compo,
    switch overflow(index),
      case 0,
        of = 'Wrap';
      case 1,
        of = 'Saturate';
      case 2,
        of = 'Flag as error';
    end  

    neg_name = ['neg',num2str(index)];

    position = [xpos-neg_w/2 ypos_tmp xpos+neg_w/2 ypos_tmp+neg_d-20];

    reuse_block(blk, neg_name, 'xbsIndex_r4/Negate', ...
      'precision', 'User Defined', ...
      'n_bits', num2str(n_bits_in(index)), 'bin_pt', num2str(bin_pt_in(index)), ...
      'arith_type', 'Signed', ...
      'overflow', of, 'quantization', 'Truncate', 'latency', 'latency', ...  
      'Position', position);

    ypos_tmp = ypos_tmp + neg_d;

    add_line(blk, ['debus/',num2str(index)], [neg_name,'/1']);
  end
 
  ypos_tmp = ypos + yinc + neg_d*compi;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', 'latency', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
    ypos_tmp = ypos_tmp + neg_d;
  end
 
  %%%%%%%%%%%%%%%%%%%%
  % create bus again %
  %%%%%%%%%%%%%%%%%%%%
 
  ypos_tmp = ypos + neg_d*compo/2;
  xpos = xpos + xinc + bus_expand_w/2;

  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compo), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-neg_d*compo/2 xpos+bus_create_w/2 ypos_tmp+neg_d*compo/2]);
  
  for index = 1:compo,
    add_line(blk, ['neg',num2str(index),'/1'], ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + neg_d*compo/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['dout/1']);
  
  ypos_tmp = ypos_tmp + yinc + neg_d*compo/2;
  
  port_no = 1;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', num2str(port_no + 1), ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_negate_init','trace');

end %function bus_negate_init
