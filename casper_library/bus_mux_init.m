function bus_mux_init(blk, varargin)

  clog('entering bus_mux_init', 'trace');
  defaults = {'n_bits', [8 8 8 8 8 8 8 8 8 8 8 8 8 ], 'mux_latency', 1, 'cmplx', 'on', 'misc', 'on'};
  
  check_mask_type(blk, 'bus_mux');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 60;

  port_w = 30; port_d = 14;
  muxi_d = 30;
  bus_expand_w = 50;
  bus_compress_w = 50;
  mux_w = 50;
  del_w = 30; del_d = 20;

  n_bits        = get_var('n_bits', 'defaults', defaults, varargin{:});
  mux_latency   = get_var('mux_latency', 'defaults', defaults, varargin{:});
  misc          = get_var('misc', 'defaults', defaults, varargin{:});
  cmplx         = get_var('cmplx', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if isempty(n_bits),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_mux_init','trace');
    return;
  end
  
  len = length(n_bits);
  if strcmp(cmplx, 'on'), n_bits = 2*n_bits; end

  
  %input ports
  ypos_tmp = ypos;  
  reuse_block(blk, 'sel', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  
  ypos_tmp = ypos_tmp + muxi_d*len/2 + yinc;
  reuse_block(blk, 'in', 'built-in/inport', ...
    'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + muxi_d*len/2;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '3', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  xpos = xpos + xinc + port_w/2;  
  ypos_tmp = ypos + muxi_d*len/2 + yinc; %reset ypos

  %data bus expand
  reuse_block(blk, 'expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', ['[',num2str(n_bits),']'], ...
    'outputBinaryPt', ['[',num2str(zeros(1, length(n_bits))),']'], ...
    'outputArithmeticType', ['[',num2str(zeros(1, length(n_bits))),']'], ...
    'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-muxi_d*len/2 xpos+bus_expand_w/2 ypos_tmp+muxi_d*len/2]);
  add_line(blk, 'in/1', 'expand/1');
  ypos_tmp = ypos_tmp + muxi_d*len + yinc;

  xpos = xpos + xinc + bus_expand_w/2;

  ypos_tmp = ypos + (muxi_d+1)*len/2 - muxi_d + yinc; %reset ypos
  %mux
  reuse_block(blk, 'mux', 'xbsIndex_r4/Mux', ...
    'inputs', num2str(len), 'latency', 'mux_latency', ...
    'Position', [xpos-mux_w/2 ypos_tmp-((muxi_d+1)*len/2)-port_d/2 xpos+mux_w/2 ypos_tmp+((muxi_d+1)*len/2)+port_d/2]);
  add_line(blk, 'sel/1', 'mux/1');
  for index = 1:len,
    add_line(blk, ['expand/',num2str(index)], ['mux/',num2str(index+1)]);
  end
  ypos_tmp = ypos + yinc*2 + muxi_d*len;
  
  if strcmp(misc, 'on'),
    reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
      'latency', 'mux_latency', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    add_line(blk, 'misci/1', 'dmisc/1');
  end
 
  %output port/s
  ypos_tmp = ypos + yinc + muxi_d*len/2 - muxi_d;
  xpos = xpos + xinc + bus_compress_w/2;
  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['mux/1'], ['out/1']);
  ypos_tmp = ypos + yinc*2 + muxi_d*len;  

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'dmisc/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_mux_init','trace');

end %function bus_register


