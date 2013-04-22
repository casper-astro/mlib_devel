
function bus_scale_init(blk, varargin)

  clog('entering bus_scale_init', 'trace');
  
  defaults = { ...
    'n_bits_in',  [9 9 9 9],  'bin_pt_in',       8 , 'type_in', 1,  'cmplx', 'off', ...
    'scale_factor', -1, 'misc', 'on', ...
  };  
  
  check_mask_type(blk, 'bus_scale');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 50;

  port_w = 30; port_d = 14;
  bus_expand_w = 50;
  bus_create_w = 50;
  scale_w = 50; scale_d = 60;
  del_w = 30; del_d = 20;

  n_bits_in       = get_var('n_bits_in', 'defaults', defaults, varargin{:});
  bin_pt_in       = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  type_in         = get_var('type_in', 'defaults', defaults, varargin{:});
  cmplx           = get_var('cmplx', 'defaults', defaults, varargin{:});
  scale_factor    = get_var('scale_factor', 'defaults', defaults, varargin{:});
  misc            = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);
  
 %default state, do nothing 
  if isempty(n_bits_in),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_scale_init','trace');
    error('exiting bus_scale_init');
    return;
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % check input lists for consistency %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  lenbi = length(n_bits_in); lenpi = length(bin_pt_in); lenti = length(type_in); lensf = length(scale_factor);
  i = [lenbi, lenpi, lenti, lensf];  
  unique_i = unique(i);
  compi = unique_i(length(unique_i));
  
  too_many_i = length(unique_i) > 2;
  conflict_i = (length(unique_i) == 2) && (unique_i(1) ~= 1);
  if too_many_i | conflict_i,
    error('conflicting component number for input bus');
    clog('conflicting component number for input bus', 'error');
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % autocomplete input lists where necessary %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  comp = compi;

  %replicate items if needed for a input
  n_bits_in      = repmat(n_bits_in, 1, compi/lenbi); 
  bin_pt_in      = repmat(bin_pt_in, 1, compi/lenpi); 
  type_in        = repmat(type_in, 1, compi/lenti);   
  scale_factor   = repmat(scale_factor, 1, compi/lensf);   

  %if complex we need to double down on some of these
  if strcmp(cmplx, 'on'),
    compi        = compi*2;
    n_bits_in    = reshape([n_bits_in; n_bits_in], 1, compi); 
    bin_pt_in    = reshape([bin_pt_in; bin_pt_in], 1, compi); 
    type_in      = reshape([type_in; type_in], 1, compi);   
    scale_factor = reshape([scale_factor; scale_factor], 1, compi);   
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % at this point all input, output lists should match %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  clog(['n_bits_in = ',mat2str(n_bits_in)],'bus_scale_init_debug');
  clog(['compi = ',num2str(compi)],'bus_scale_init_debug');

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos + scale_d*compi/2;
  reuse_block(blk, 'din', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + scale_d*compi/2;
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%
  % bus expand %
  %%%%%%%%%%%%%%
  
  ypos_tmp = ypos + scale_d*compi/2; %reset ypos

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
    'Position', [xpos-bus_expand_w/2 ypos_tmp-scale_d*compi/2 xpos+bus_expand_w/2 ypos_tmp+scale_d*compi/2]);
  add_line(blk, 'din/1', 'debus/1');
  ypos_tmp = ypos_tmp + scale_d*(compi/2) + yinc;
  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%%
  % scale layer %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos; %reset ypos 

  for index = 1:compi,
    scale_name = ['scale',num2str(index)];
    reuse_block(blk, scale_name, 'xbsIndex_r4/Scale', ...
      'scale_factor', num2str(scale_factor(index)), ...
      'Position', [xpos-scale_w/2 ypos_tmp xpos+scale_w/2 ypos_tmp+scale_d-20]);
    ypos_tmp = ypos_tmp + scale_d;

    add_line(blk, ['debus/',num2str(index)], [scale_name,'/1']);
  end
 
  %%%%%%%%%%%%%%%%%%%%
  % create bus again %
  %%%%%%%%%%%%%%%%%%%%
 
  ypos_tmp = ypos + scale_d*compi/2;
  xpos = xpos + xinc + bus_expand_w/2;

  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(compi), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-scale_d*compi/2 xpos+bus_create_w/2 ypos_tmp+scale_d*compi/2]);
  
  for index = 1:compi,
    add_line(blk, ['scale',num2str(index),'/1'], ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%%
  % output port/s %
  %%%%%%%%%%%%%%%%%

  ypos_tmp = ypos + scale_d*compi/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['dout/1']);
  
  ypos_tmp = ypos + yinc + scale_d*compi;  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'misci/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_scale_init','trace');

end %function bus_scale_init
