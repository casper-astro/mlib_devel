function bus_accumulator_init(blk, varargin)

  clog('entering bus_accumulator_init', 'trace');
  defaults = {'reset', 'on', 'enable', 'on', ...
    'n_bits_in', [8 8 8 8], 'bin_pt_in', 0, 'type_in', 1, 'cmplx', 'off', ...
    'n_bits_out', 16, 'overflow', 1, ...
    'misc', 'on'};
  
  check_mask_type(blk, 'bus_accumulator');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  bus_expand_w = 50;
  bus_compress_w = 50;
  acc_w = 50; acc_d = 60;
  del_w = 30; del_d = 20;

  reset       = get_var('reset', 'defaults', defaults, varargin{:});
  enable      = get_var('enable', 'defaults', defaults, varargin{:});
  cmplx       = get_var('cmplx', 'defaults', defaults, varargin{:});
  n_bits_in   = get_var('n_bits_in', 'defaults', defaults, varargin{:});
  bin_pt_in   = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  type_in     = get_var('type_in', 'defaults', defaults, varargin{:});
  cmplx       = get_var('cmplx', 'defaults', defaults, varargin{:});
  n_bits_out  = get_var('n_bits_out', 'defaults', defaults, varargin{:});
  overflow    = get_var('overflow', 'defaults', defaults, varargin{:});
  misc        = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if isempty(n_bits_in),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_accumulator_init','trace');
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % check input lists for consistency %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  lenbi = length(n_bits_in); lenpi = length(bin_pt_in); lenti = length(type_in);
  i = [lenbi, lenpi, lenti];  
  unique_i = unique(i);
  compi = unique_i(length(unique_i));

  lenbo = length(n_bits_out);  
  leno = length(overflow);
  o = [lenbo, leno];
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
  overflow      = repmat(overflow, 1, comp/leno);
  
  if strcmp(cmplx, 'on'),
    compo       = comp*2;
    n_bits_out  = reshape([n_bits_out; n_bits_out], 1, compo);    
    overflow    = reshape([overflow; overflow], 1, compo);        
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all input, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_in = ',mat2str(n_bits_in)],'bus_accumulator_init_debug');
  clog(['bin_pt_in = ',mat2str(bin_pt_in)],'bus_accumulator_init_debug');
  clog(['type_in = ',mat2str(type_in)],'bus_accumulator_init_debug');
  clog(['n_bits_out = ',mat2str(n_bits_out)],'bus_accumulator_init_debug');
  clog(['overflow = ',mat2str(overflow)],'bus_accumulator_init_debug');
  clog(['compi = ',num2str(compi), ' compo = ', num2str(compo)],'bus_accumulator_init_debug');

  %%%%%%%%%%%%%%
  %input ports %
  %%%%%%%%%%%%%%

  port_no = 1;
  ypos_tmp = ypos + acc_d*compi/2;
  reuse_block(blk, 'din', 'built-in/inport', ...
    'Port', num2str(port_no), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + acc_d*compi;
  port_no = port_no + 1;

  if strcmp(reset, 'on'),
    reuse_block(blk, 'rst', 'built-in/inport', ...
      'Port', num2str(port_no), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + yinc + acc_d*compi;
    port_no = port_no + 1;
  end

  if strcmp(enable, 'on'),
    reuse_block(blk, 'en', 'built-in/inport', ...
      'Port', num2str(port_no), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + yinc + acc_d*compi;
    port_no = port_no + 1;
  end

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', num2str(port_no), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  xpos = xpos + xinc + port_w/2;  
  ypos_tmp = ypos + acc_d*compi/2; %reset ypos
  
  %%%%%%%%%%%%%%%%%%%
  % split busses up %
  %%%%%%%%%%%%%%%%%%%

  outputWidth           = mat2str(n_bits_in);
  outputBinaryPt        = mat2str(bin_pt_in);
  outputArithmeticType  = mat2str(type_in);

  ypos_tmp = ypos + acc_d*compi/2;
  reuse_block(blk, 'debus', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', outputWidth, ...
    'outputBinaryPt', outputBinaryPt, ...
    'outputArithmeticType', outputArithmeticType, ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-acc_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+acc_d*compi/2]);
  
  add_line(blk, 'din/1', 'debus/1');
  ypos_tmp = ypos_tmp + acc_d*compi + yinc;

  if strcmp(cmplx, 'on'),
    outputNum = num2str(compi/2);
  else  
    outputNum = num2str(compi);
  end
  
  %reset bus expand
  if strcmp(reset, 'on'),
    reuse_block(blk, 'rst_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', ...
      'outputNum', outputNum, ...
      'outputWidth', '1', 'outputBinaryPt', '0', ...
      'outputArithmeticType', '2', 'show_format', 'on', ...
      'outputToWorkspace', 'off', 'variablePrefix', '', ...
      'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-acc_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+acc_d*compi/2]);
    add_line(blk, 'rst/1', 'rst_expand/1');
    ypos_tmp = ypos_tmp + acc_d*compi + yinc;
  end

  %enable bus expand
  if strcmp(enable, 'on'),
    reuse_block(blk, 'en_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', ...
      'outputNum', outputNum, ...
      'outputWidth', '1', 'outputBinaryPt', '0', ...
      'outputArithmeticType', '2', 'show_format', 'on', ...
      'outputToWorkspace', 'off', 'variablePrefix', '', ...
      'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-acc_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+acc_d*compi/2]);
    add_line(blk, 'en/1', 'en_expand/1');
  end

  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%%%%%%%
  % accumulators
  %%%%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  %if complex, reset and enables shared by two accumulators
  if strcmp(cmplx, 'on'),
    div = 2;
  else
    div = 1;
  end

  for index = 1:compi,
    
    switch overflow(index),
      case 0,
        of = 'Wrap';
      case 1,
        of = 'Saturate';
      case 2,
        of = 'Flag as error';
    end  

    acc_name = ['acc',num2str(index)];
    reuse_block(blk, acc_name, 'xbsIndex_r4/Accumulator', ...
      'rst', reset, 'en', enable, 'hasbypass', reset, ...
      'overflow', of, 'n_bits', num2str(n_bits_out(index)), ... 
      'Position', [xpos-acc_w/2 ypos_tmp xpos+acc_w/2 ypos_tmp+acc_d-20]);
    ypos_tmp = ypos_tmp + acc_d;

    add_line(blk, ['debus/',num2str(index)], [acc_name,'/1']);
    if strcmp(reset, 'on'), add_line(blk, ['rst_expand/',num2str(ceil(index/div))], [acc_name,'/2']); end
    if strcmp(enable, 'on'), add_line(blk, ['en_expand/',num2str(ceil(index/div))],  [acc_name,'/3']); end
  end
 
  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', '1', ...
      'Position', [xpos-del_w/2 ypos+(((port_no-1)+1/2)*acc_d*compi)-del_d/2+(port_no-1)*yinc xpos+del_w/2 ypos+(((port_no-1)+1/2)*acc_d*compi)+(port_no-1)*yinc+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
    ypos_tmp = ypos_tmp + acc_d;
  end
 
  %%%%%%%%%%%%%%%%%%%
  %create bus again
  %%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + acc_d*compi/2;
  xpos = xpos + xinc + bus_expand_w/2;

  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compi), ...
    'Position', [xpos-bus_compress_w/2 ypos_tmp-acc_d*compi/2 xpos+bus_compress_w/2 ypos_tmp+acc_d*compi/2]);
  
  for index = 1:compi,
    add_line(blk, ['acc',num2str(index),'/1'], ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%
  %output port/s
  %%%%%%%%%%%%%%%%

  ypos_tmp = ypos + acc_d*compi/2;
  xpos = xpos + xinc + bus_compress_w/2;
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['dout/1']);
  ypos_tmp = ypos_tmp + yinc + port_d/2;  

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos+(((port_no-1)+1/2)*acc_d*compi)+((port_no-1)*yinc)-port_d/2 xpos+port_w/2 ypos+(((port_no-1)+1/2)*acc_d*compi)+((port_no-1)*yinc)+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_accumulator_init','trace');

end %function bus_accumulator


