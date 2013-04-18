function bus_replicate_init(blk, varargin)

  clog('entering bus_replicate_init', 'trace');
  defaults = {'replication', 8, 'latency', 0, 'misc', 'on'};
  
  check_mask_type(blk, 'bus_replicate');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 60;

  port_w = 30; port_d = 14;
  del_w = 30; del_d = 20;
  bus_create_w = 50;
  yinc = 20;

  replication   = get_var('replication', 'defaults', defaults, varargin{:});
  latency       = get_var('latency', 'defaults', defaults, varargin{:});
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

  ypos_tmp = ypos + (yinc*replication)/2;  
  reuse_block(blk, 'in', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + (replication*yinc)/2;

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end
  xpos = xpos + xinc;  

  %%%%%%%%%%%%%%%%%%%%%%%%%%% 
  % delay layer if required %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%

  ypos_tmp = ypos;
  if latency > 0,
    for index = 1:replication,
      dname = ['din', num2str(index)];
      reuse_block(blk, dname, 'casper_library_delays/pipeline', ...
	'latency', 'latency', 'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
      
      ypos_tmp = ypos_tmp + yinc;
      add_line(blk, 'in/1', [dname,'/1']);    
    end %for
   
    ypos_tmp = ypos + yinc + replication*yinc;
    if strcmp(misc, 'on'), 
      reuse_block(blk, 'dmisc', 'xbsIndex_r4/Delay', ...
	'latency', 'latency', 'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
      add_line(blk, 'misci/1', 'dmisc/1');    
    end

    xpos = xpos + xinc;
  end %if

  %%%%%%%%%%%%%%
  % create bus %
  %%%%%%%%%%%%%%

  ypos_tmp = ypos;
  reuse_block(blk, 'bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(replication), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp xpos+bus_create_w/2 ypos_tmp+replication*yinc]);
  
  for index = 1:replication,
    if latency > 0, 
      dsrc = ['din',num2str(index),'/1'];
      msrc = ['dmisc/1'];
    else, 
      dsrc = 'in/1';
      msrc = 'misci/1';
    end

    add_line(blk, dsrc, ['bussify/',num2str(index)]);
  end

  %%%%%%%%%%%%%%%%% 
  % output port/s %
  %%%%%%%%%%%%%%%%%
  
  ypos_tmp = ypos + replication*yinc/2;
  xpos = xpos + xinc + bus_create_w/2;
  reuse_block(blk, 'out', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  add_line(blk, ['bussify/1'], ['out/1']);
  ypos_tmp = ypos_tmp + yinc + replication*yinc/2;  

  if strcmp(misc, 'on'),
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', '2', ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);

    add_line(blk, msrc, 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_replicate_init','trace');

end %function bus_replicate_init


