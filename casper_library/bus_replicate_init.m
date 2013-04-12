function bus_replicate_init(blk, varargin)

  clog('entering bus_replicate_init', 'trace');
  defaults = {'replication', 8, 'misc', 'on'};
  
  check_mask_type(blk, 'bus_replicate');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 60;

  port_w = 30; port_d = 14;
  bus_create_w = 50;

  replication   = get_var('replication', 'defaults', defaults, varargin{:});
  misc          = get_var('misc', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if replication == 0 || isempty(replication),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_replicate_init','trace');
    return;
  end

  %%%%%%%%%%%%%%%  
  % input ports %
  %%%%%%%%%%%%%%%

  ypos_tmp = ypos;  
  reuse_block(blk, 'in', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + replication*port_d + yinc;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%
  % create bus %
  %%%%%%%%%%%%%%

  ypos_tmp = ypos;
  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(replication), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp xpos+bus_create_w/2 ypos_tmp+replication*port_d]);
  
  for index = 1:replication,
    add_line(blk, ['in/1'], ['bussify/',num2str(index)]);
  end
 
  %%%%%%%%%%%%%%%%% 
  % output port/s %
  %%%%%%%%%%%%%%%%%
  
  ypos_tmp = ypos;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['out/1']);
  ypos_tmp = ypos + yinc + replication*port_d;  

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, 'misci/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_replicate_init','trace');

end %function bus_replicate_init


