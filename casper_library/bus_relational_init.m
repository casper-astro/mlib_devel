function bus_relational_init(blk, varargin)

  clog('entering bus_relational_init', 'trace');
  
  defaults = { ...
    'n_bits_a', [8 8] ,  'bin_pt_a',     [0],   'type_a',   1, ...
    'n_bits_b', [8]  ,  'bin_pt_b',     [0],   'type_b',   1, ...
    'mode', 'a=b', 'latency', 1, 'en', 'off', 'misc', 'off', ...
  };  
  
  check_mask_type(blk, 'bus_relational');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  bus_expand_w = 50;
  bus_create_w = 50;
  op_w = 50; op_d = 60;
  del_w = 30; del_d = 20;

  n_bits_a	    = get_var('n_bits_a', 'defaults', defaults, varargin{:});
  bin_pt_a	    = get_var('bin_pt_a', 'defaults', defaults, varargin{:});
  type_a	    = get_var('type_a', 'defaults', defaults, varargin{:});
  n_bits_b	    = get_var('n_bits_b', 'defaults', defaults, varargin{:});
  bin_pt_b	    = get_var('bin_pt_b', 'defaults', defaults, varargin{:});
  type_b	    = get_var('type_b', 'defaults', defaults, varargin{:});
  latency      	    = get_var('latency', 'defaults', defaults, varargin{:});
  misc         	    = get_var('misc', 'defaults', defaults, varargin{:});
  mode              = get_var('mode', 'defaults', defaults, varargin{:});
  en		    = get_var('en', 'defaults', defaults, varargin{:});
 
  delete_lines(blk);

  %default state, do nothing 
  if n_bits_a <= 0 | n_bits_b <= 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_relational_init','trace');
    return;
  end
 
  lenba = length(n_bits_a); lenpa = length(bin_pt_a); lenta = length(type_a);
  a = [lenba, lenpa, lenta];  

  lenbb = length(n_bits_b); lenpb = length(bin_pt_b); lentb = length(type_b);
  b = [lenbb, lenpb, lentb];  

  comps = unique([a, b]);
  %if have more than 2 unique components or have two but one isn't 1
  if ((length(comps) > 2) | (length(comps) == 2 && comps(1) ~= 1)),
    clog('conflicting component sizes','error');
    return;
  end

  %determine number of components from clues   
  compa = max(a); compb = max(b); comp = max(compa, compb);
  compen = comp;

  %replicate items if needed for a input
  n_bits_a    = repmat(n_bits_a, 1, compa/lenba);
  bin_pt_a    = repmat(bin_pt_a, 1, compa/lenpa);
  type_a      = repmat(type_a, 1, compa/lenta);
  
  %replicate items if needed for b input
  n_bits_b    = repmat(n_bits_b, 1, compb/lenbb);
  bin_pt_b    = repmat(bin_pt_b, 1, compb/lenpb);
  type_b      = repmat(type_b, 1, compb/lentb);

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + op_d*compa/2;
  reuse_block(blk, 'a', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + op_d*(compa/2 + compb/2);
  
  reuse_block(blk, 'b', 'built-in/inport', ...
    'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + op_d*compb/2;

  port_no = 2;
  if strcmp(en, 'on'),
    ypos_tmp = ypos_tmp + op_d*compen/2;
    reuse_block(blk, 'en', 'built-in/inport', ...
      'Port', num2str(port_no+1), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    port_no = port_no+1;
    ypos_tmp = ypos_tmp + yinc + op_d*compen/2;
  end

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', num2str(port_no+1), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%

  xpos = xpos + xinc + port_w/2;  
  ypos_tmp = ypos + op_d*compa/2; %reset ypos
  
  reuse_block(blk, 'a_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', ['[',num2str(n_bits_a),']'], ...
    'outputBinaryPt', ['[',num2str(bin_pt_a),']'], ...
    'outputArithmeticType', ['[',num2str(type_a),']'], ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-op_d*compa/2 xpos+bus_expand_w/2 ypos_tmp+op_d*compa/2]);

  add_line(blk, 'a/1', 'a_debus/1');
  ypos_tmp = ypos_tmp + op_d*(compa/2+compb/2) + yinc;
  
  reuse_block(blk, 'b_debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', ['[',num2str(n_bits_b),']'], ...
    'outputBinaryPt', ['[',num2str(bin_pt_b),']'], ...
    'outputArithmeticType', ['[',num2str(type_b),']'], ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-op_d*compb/2 xpos+bus_expand_w/2 ypos_tmp+op_d*compb/2]);
  add_line(blk, 'b/1', 'b_debus/1');
  ypos_tmp = ypos_tmp + op_d*compb/2 + yinc;

  if strcmp(en, 'on'),
    ypos_tmp = ypos_tmp + op_d*compen/2;
    reuse_block(blk, 'en_debus', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', ...
      'outputNum', num2str(compen), ...
      'outputWidth', '1', 'outputBinaryPt', '0', ...
      'outputArithmeticType', '2', 'show_format', 'on', ...
      'outputToWorkspace', 'off', 'variablePrefix', '', ...
      'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-op_d*compen/2 xpos+bus_expand_w/2 ypos_tmp+op_d*compen/2]);
    add_line(blk, 'en/1', 'en_debus/1');
    ypos_tmp = ypos_tmp + op_d*compen/2 + yinc;
  end %if

  xpos = xpos + xinc + op_w/2;  
  
  %%%%%%%%%%%%%
  % operation %
  %%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  %need operation per component
  a_src = repmat([1:compa], 1, comp/compa);
  b_src = repmat([1:compb], 1, comp/compb);
  en_src = repmat([1:compen], 1, comp/compen);

  clog(['making ',num2str(comp),' relational blocks'], 'bus_relational_init_debug');

  for index = 1:comp
    op_name = ['relational',num2str(index)]; 
    reuse_block(blk, op_name, 'xbsIndex_r4/Relational', ...
      'mode', mode, 'latency', num2str(latency), 'en', en, ...
      'Position', [xpos-op_w/2 ypos_tmp xpos+op_w/2 ypos_tmp+op_d-20]);
    ypos_tmp = ypos_tmp + op_d;
  
    add_line(blk, ['a_debus/',num2str(a_src(index))], [op_name,'/1']);
    add_line(blk, ['b_debus/',num2str(b_src(index))], [op_name,'/2']);

    if strcmp(en, 'on'), add_line(blk, ['en_debus/',num2str(en_src(index))], [op_name,'/3']); end

  end %for
  ypos_tmp = ypos + op_d*(compb+compa) + 2*yinc;
  if strcmp(en, 'on'), ypos_tmp = ypos_tmp + compen*op_d + yinc; end
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', num2str(latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
  end
  xpos = xpos + xinc + op_d/2;

  %%%%%%%%%%%%%%
  % create bus % 
  %%%%%%%%%%%%%%

  ypos_tmp = ypos + op_d*comp/2; %reset ypos
 
  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(comp), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-op_d*comp/2 xpos+bus_create_w/2 ypos_tmp+op_d*comp/2]);
  
  for index = 1:comp,
    add_line(blk, ['relational',num2str(index),'/1'], ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + op_d*comp/2;
  xpos = xpos + xinc + bus_create_w/2;
  name = mode;
  reuse_block(blk, name, 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], [name,'/1']);
  ypos_tmp = ypos_tmp + yinc + port_d;  

  ypos_tmp = ypos + op_d*(compb+compa) + 2*yinc;
  if strcmp(en, 'on'), ypos_tmp = ypos_tmp + compen*op_d + yinc; end
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end
  
  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_relational_init','trace');

end %function bus_relational_init

