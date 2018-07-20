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

function bus_single_port_ram_init(blk, varargin)
  log_group = 'bus_single_port_ram_init_debug';

  clog('entering bus_single_port_ram_init', {'trace', log_group});
  
  defaults = { ...
    'n_bits', 36, 'bin_pts', 0, ...
    'init_vector', zeros(8192,1), ...
    'max_fanout', 1, 'mem_type', 'Distributed memory', ...
    'bram_optimization', 'Speed', ...  %'Speed', 'Area' 
    'async', 'off', 'misc', 'off', ...
    'bram_latency', 1, 'fan_latency', 0, ...
    'addr_register', 'on', 'addr_implementation', 'behavioral', ...
    'din_register', 'on', 'din_implementation', 'behavioral', ...
    'we_register', 'on', 'we_implementation', 'behavioral', ...
    'en_register', 'on', 'en_implementation', 'behavioral', ...
  };  
  
  check_mask_type(blk, 'bus_single_port_ram');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  xpos = 50; xinc = 80;
  ypos = 50; yinc = 20;

  port_w = 30; port_d = 14;
  rep_w = 50; rep_d = 30;
  bus_expand_w = 60; bus_expand_d = 10;
  bus_create_w = 60; bus_create_d = 10;
  bram_w = 50; bram_d = 40;
  del_w = 30; del_d = 20;

  maxy = 2^13; %Simulink limit

  n_bits                    = get_var('n_bits', 'defaults', defaults, varargin{:});
  bin_pts                   = get_var('bin_pts', 'defaults', defaults, varargin{:});
  init_vector               = get_var('init_vector', 'defaults', defaults, varargin{:});
  bram_latency              = get_var('bram_latency', 'defaults', defaults, varargin{:});
  mem_type                  = get_var('mem_type', 'defaults', defaults, varargin{:});
  bram_optimization         = get_var('bram_optimization', 'defaults', defaults, varargin{:});
  misc                      = get_var('misc', 'defaults', defaults, varargin{:});
  async                     = get_var('async', 'defaults', defaults, varargin{:});
  max_fanout                = get_var('max_fanout', 'defaults', defaults, varargin{:});
  fan_latency               = get_var('fan_latency', 'defaults', defaults, varargin{:});
  addr_register             = get_var('addr_register', 'defaults', defaults, varargin{:});
  addr_implementation       = get_var('addr_implementation', 'defaults', defaults, varargin{:});
  din_register              = get_var('din_register', 'defaults', defaults, varargin{:});
  din_implementation        = get_var('din_implementation', 'defaults', defaults, varargin{:});
  we_register               = get_var('we_register', 'defaults', defaults, varargin{:});
  we_implementation         = get_var('we_implementation', 'defaults', defaults, varargin{:});
  en_register               = get_var('en_register', 'defaults', defaults, varargin{:});
  en_implementation         = get_var('en_implementation', 'defaults', defaults, varargin{:});

  delete_lines(blk);
 
  %default state, do nothing 
  if (n_bits(1) == 0),
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting bus_single_port_ram_init', {'trace', log_group});
    return;
  end

  [riv, civ]  = size(init_vector);
  [rnb, cnb]  = size(n_bits);
  [rbp, cbp]  = size(bin_pts);

  if (cnb ~= 1 && cbp ~= 1) && ((civ ~= cnb) || (civ ~= cbp)),
    clog('The number of columns in initialisation vector must match the number of values in binary point and number of bits parameter specifications', {'error', log_group});
    error('The number of columns in initialisation vector must match the number of values in binary point and number of bits parameter specifications');
  end

  %%%%%%%%%%%%%%%
  % input ports %
  %%%%%%%%%%%%%%%

  %The calculations below anticipate how BRAMs are to be configured by the Xilinx tools
  %(as detailed in UG190), explicitly generates these, and attempts to control fanout into
  %these
 
  %if optimizing for Area, do the best we can minimising fanout while still using whole BRAMs
  %fanout for very deep BRAMs will be large
  %TODO this should depend on FPGA architecture, assuming V5 or V6
  if strcmp(bram_optimization, 'Area'), 
    if      (riv >= 2^11), max_word_size = 9;
    elseif  (riv >= 2^10), max_word_size = 18;
    else,                  max_word_size = 36;
    end
  %if optimising for Speed, keep splitting word size even if wasting BRAM resources
  else, 
    if      (riv >= 2^14), max_word_size = 1;
    elseif  (riv >= 2^13), max_word_size = 2;
    elseif  (riv >= 2^12), max_word_size = 4;
    elseif  (riv >= 2^11), max_word_size = 9;
    elseif  (riv >= 2^10), max_word_size = 18;
    else,                  max_word_size = 36;
    end
  end
 
  ctiv = 0;

  while (ctiv == 0) || ((ctiv * bram_d) > maxy),

    %if we are going to go beyond Xilinx bounds, double the word width
    if (ctiv * bram_d) > maxy,
      clog(['doubling word size from ', num2str(max_word_size), ' to make space'], log_group);
      if      (max_word_size == 1), max_word_size = 2;
      elseif  (max_word_size == 2), max_word_size = 4;
      elseif  (max_word_size == 4), max_word_size = 9;
      elseif  (max_word_size == 9), max_word_size = 18;
      else,                         max_word_size = 36;
      end %if
    end %if
 
    % translate initialisation matrix based on architecture 
    [translated_init_vecs, result] = doubles2unsigned(init_vector, n_bits, bin_pts, max_word_size);
    if result ~= 0,
      clog('error translating initialisation matrix', {'error', log_group});
      error('error translating initialisation matrix');
    end %if
  
    [rtiv, ctiv] = size(translated_init_vecs);
  end %while

  clog([num2str(ctiv), ' brams required'], log_group);

  replication = ceil(ctiv/max_fanout);
  clog(['replication factor of ', num2str(replication), ' required'], log_group);

  if (cnb == 1),
    n_bits  = repmat(n_bits, 1, civ);
    bin_pts = repmat(bin_pts, 1, civ);
  end %if

  ypos_tmp  = ypos;
  
  ypos_tmp  = ypos_tmp + bus_expand_d*replication/2;
  reuse_block(blk, 'addr', 'built-in/inport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp  = ypos_tmp + yinc + bus_expand_d*replication/2;

  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
  reuse_block(blk, 'din', 'built-in/inport', ...
    'Port', '2', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp  = ypos_tmp + yinc + bus_expand_d*ctiv/2;
 
  ypos_tmp  = ypos_tmp + bus_expand_d*replication/2;
  reuse_block(blk, 'we', 'built-in/inport', ...
    'Port', '3', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp  = ypos_tmp + yinc + bus_expand_d*replication/2;

  port_index = 4;
  % asynchronous A port
  if strcmp(async, 'on'),
    ypos_tmp  = ypos_tmp + bus_expand_d*replication/2;
    reuse_block(blk, 'en', 'built-in/inport', ...
      'Port', num2str(port_index), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + yinc + bus_expand_d*replication/2;
    port_index = port_index + 1;
  end

  %misc port
  if strcmp(misc, 'on'),
    reuse_block(blk, 'misci', 'built-in/inport', ...
      'Port', num2str(port_index), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  end

  xpos      = xpos + xinc + port_w/2;  

  %%%%%%%%%%%%%%%%%%%%
  % replicate inputs %
  %%%%%%%%%%%%%%%%%%%%

  xpos = xpos + rep_w/2;

  ypos_tmp  = ypos; %reset ypos

  % replicate addr
  if strcmp(addr_register, 'on'), latency = fan_latency;
  else, latency = 0;
  end
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
  reuse_block(blk, 'rep_addr', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(replication), 'latency', num2str(latency), 'misc', 'off', ...
    'implementation', addr_implementation, ... 
    'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
  add_line(blk, 'addr/1', 'rep_addr/1');
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;

  % delay din
  if strcmp(din_register, 'on'), latency = fan_latency;
  else, latency = 0;
  end
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
  if strcmp(din_implementation, 'core'), reg_retiming = 'off';
  else, reg_retiming = 'on';
  end

  reuse_block(blk, 'ddin', 'xbsIndex_r4/Delay', ...
    'latency', num2str(latency), 'reg_retiming', reg_retiming, ...
    'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
  add_line(blk, ['din/1'], 'ddin/1');
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;

  % replicate we
  if strcmp(we_register, 'on'), latency = fan_latency;
  else, latency = 0;
  end
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
  reuse_block(blk, 'rep_we', 'casper_library_bus/bus_replicate', ...
    'replication', num2str(replication), 'latency', num2str(latency), 'misc', 'off', ... 
    'implementation', we_implementation, ... 
    'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
  add_line(blk, 'we/1', 'rep_we/1'); 
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;

  if strcmp(async, 'on'),
    if strcmp(en_register, 'on'), latency = fan_latency;
    else, latency = 0;
    end
    % replicate en
    ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
    reuse_block(blk, 'rep_en', 'casper_library_bus/bus_replicate', ...
      'replication', num2str(replication), 'latency', num2str(latency), 'misc', 'off', ... 
      'implementation', en_implementation, ... 
      'Position', [xpos-rep_w/2 ypos_tmp-rep_d/2 xpos+rep_w/2 ypos_tmp+rep_d/2]);
    add_line(blk, 'en/1', 'rep_en/1'); 
    ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;
  end

  xpos = xpos + xinc + rep_w/2;
  
  %%%%%%%%%%%%%%%%
  % debus inputs %
  %%%%%%%%%%%%%%%%
  
  xpos = xpos + bus_expand_w/2;
 
  % debus addra
  ypos_tmp  = ypos + bus_expand_d*ctiv/2;
  reuse_block(blk, 'debus_addr', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(replication), ...
    'outputWidth', mat2str(repmat(ceil(log2(rtiv)), 1, replication)), ...
    'outputBinaryPt', mat2str(zeros(1, replication)), ...
    'outputArithmeticType', mat2str(zeros(1,replication)), 'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-bus_expand_d*ctiv/2 xpos+bus_expand_w/2 ypos_tmp+bus_expand_d*ctiv/2]);
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;
  add_line(blk, 'rep_addr/1', 'debus_addr/1');
  
  % debus din
  ypos_tmp        = ypos_tmp + bus_expand_d*ctiv/2;
  total_bits      = sum(n_bits);
  extra           = mod(total_bits, max_word_size);
  main            = repmat(max_word_size, 1, floor(total_bits/max_word_size));
  outputWidth     = [main];
  if (extra ~= 0), 
    outputWidth = [extra, outputWidth];   
  end

  reuse_block(blk, 'debus_din', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of arbitrary size', ...
    'outputWidth', mat2str(outputWidth), 'outputBinaryPt', mat2str(zeros(1, ctiv)), ...
    'outputArithmeticType', mat2str(zeros(1,ctiv)), 'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-bus_expand_d*ctiv/2 xpos+bus_expand_w/2 ypos_tmp+bus_expand_d*ctiv/2]);
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;
  add_line(blk, 'ddin/1', 'debus_din/1');

  % debus we
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
  reuse_block(blk, 'debus_we', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(replication), ...
    'outputWidth', mat2str(ones(1, replication)), ...
    'outputBinaryPt', mat2str(zeros(1, replication)), ...
    'outputArithmeticType', mat2str(repmat(2,1,replication)), 'show_format', 'on', 'outputToWorkspace', 'off', ...
    'variablePrefix', '', 'outputToModelAsWell', 'on', ...
    'Position', [xpos-bus_expand_w/2 ypos_tmp-bus_expand_d*ctiv/2 xpos+bus_expand_w/2 ypos_tmp+bus_expand_d*ctiv/2]);
  ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;
  add_line(blk, 'rep_we/1', 'debus_we/1');

  if strcmp(async, 'on'),
    % debus ena 
    ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2;
    reuse_block(blk, 'debus_en', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', num2str(replication), ...
      'outputWidth', mat2str(ones(1, replication)), 'outputBinaryPt', mat2str(zeros(1, replication)), ...
      'outputArithmeticType', mat2str(repmat(2,1,replication)), ...
      'show_format', 'on', 'outputToWorkspace', 'off', 'variablePrefix', '', 'outputToModelAsWell', 'on', ...
      'Position', [xpos-bus_expand_w/2 ypos_tmp-bus_expand_d*ctiv/2 xpos+bus_expand_w/2 ypos_tmp+bus_expand_d*ctiv/2]);
    ypos_tmp  = ypos_tmp + bus_expand_d*ctiv/2 + yinc;
    add_line(blk, 'rep_en/1', 'debus_en/1');
  end 
 
  if strcmp(misc, 'on'),
    % delay misc
    ypos_tmp = ypos_tmp + del_d/2;
    reuse_block(blk, 'dmisc0', 'xbsIndex_r4/Delay', ...
      'latency', num2str(fan_latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    ypos_tmp = ypos_tmp + del_d/2 + yinc;
    add_line(blk, 'misci/1', 'dmisc0/1');
  end

  xpos = xpos + xinc + bus_expand_w/2;

  %%%%%%%%%%%%%%
  % bram layer %
  %%%%%%%%%%%%%%
  
  ypos_tmp  = ypos;
  xpos      = xpos + xinc + bram_w/2;

  for bram_index = 1:ctiv,

    % bram self

    % because the string version of the initVector could be too long (Matlab has upper limits on the length of strings), 
    % we save the values in the UserData parameter of the ram block (available on all Simulink blocks it seems)
    % and then reference that value from the mask
    % (It seems that when copying Xilinx blocks this parameter is not preserved and the block must be redrawn to 
    % get the values back)

    initVector = translated_init_vecs(:, bram_index)';
    UserData = struct('initVector', double(initVector));

    ypos_tmp  = ypos_tmp + bram_d/2; 
    bram_name = ['bram', num2str(bram_index-1)];
    clog(['adding ', bram_name], log_group);
    reuse_block(blk, bram_name, 'xbsIndex_r4/Single Port RAM', ...
      'UserData', UserData, 'UserDataPersistent', 'on', ...
      'depth', num2str(rtiv), 'write_mode', 'Read Before Write', 'en', async, 'optimize', bram_optimization, ...
      'distributed_mem', mem_type, 'latency', num2str(bram_latency), ...
      'Position', [xpos-bram_w/2 ypos_tmp-bram_d/2 xpos+bram_w/2 ypos_tmp+bram_d/2]);
    clog(['done adding ', bram_name], 'bus_single_port_ram_init_desperate_debug');
    clog(['setting initVector of ', bram_name], 'bus_single_port_ram_init_desperate_debug');
    set_param([blk, '/', bram_name], 'initVector', 'getfield(get_param(gcb, ''UserData''), ''initVector'')');
    clog(['done setting initVector of ', bram_name], 'bus_single_port_ram_init_desperate_debug');

    ypos_tmp  = ypos_tmp + yinc + bram_d/2; 
   
    % bram connections to replication and debus blocks
    rep_index = mod(bram_index-1, replication) + 1; %replicated index to use
    add_line(blk, ['debus_addr/', num2str(rep_index)], [bram_name, '/1']);
    add_line(blk, ['debus_din/', num2str(bram_index)], [bram_name, '/2']);
    add_line(blk, ['debus_we/', num2str(rep_index)], [bram_name, '/3']);

    if strcmp(async, 'on'), 
      add_line(blk, ['debus_en/', num2str(rep_index)], [bram_name, '/4']);
    end %if 

  end %for 

  % delay for enables and misc

  if strcmp(async, 'on'),
    ypos_tmp = ypos_tmp + del_d/2;
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
      'latency', num2str(bram_latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    ypos_tmp = ypos_tmp + yinc + del_d/2;
    add_line(blk, ['debus_en/',num2str(replication)], 'den/1');
  end;
  
  if strcmp(misc, 'on'),
    ypos_tmp = ypos_tmp + del_d/2;
    reuse_block(blk, 'dmisc1', 'xbsIndex_r4/Delay', ...
      'latency', num2str(bram_latency), 'reg_retiming', 'on', ...
      'Position', [xpos-del_w/2 ypos_tmp-del_d/2 xpos+del_w/2 ypos_tmp+del_d/2]);
    ypos_tmp = ypos_tmp + yinc + del_d/2;
    add_line(blk, 'dmisc0/1', 'dmisc1/1');
  end %if
   
  xpos = xpos + xinc + bram_w/2;

  %%%%%%%%%%%%%%%%%%%%%%%%%%
  % recombine bram outputs %
  %%%%%%%%%%%%%%%%%%%%%%%%%%

  xpos      = xpos + bus_create_w/2;
  ypos_tmp  = ypos; 
 
  ypos_tmp = ypos_tmp + bus_create_d*ctiv/2; 
  reuse_block(blk, 'din_bussify', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(ctiv), ...
    'Position', [xpos-bus_create_w/2 ypos_tmp-bus_create_d*ctiv/2 xpos+bus_create_w/2 ypos_tmp+bus_create_d*ctiv/2]);
  ypos_tmp = ypos_tmp + yinc + bus_create_d*ctiv/2; 
 
  for index = 1:ctiv,
    add_line(blk, ['bram',num2str(index-1),'/1'], ['din_bussify', '/', num2str(index)]); 
  end %for

  xpos = xpos + xinc + bus_create_w/2;

  %%%%%%%%%%%%%%%%
  % output ports %
  %%%%%%%%%%%%%%%%

  xpos      = xpos + port_w/2;
  ypos_tmp  = ypos; 
 
  ypos_tmp = ypos_tmp + bus_create_d*ctiv/2; 
  reuse_block(blk, 'dout', 'built-in/outport', ...
    'Port', '1', 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
  ypos_tmp = ypos_tmp + yinc + bus_create_d*ctiv/2; 
  add_line(blk, 'din_bussify/1', 'dout/1');

  port_index = 2;
  if strcmp(async, 'on'),
    ypos_tmp  = ypos_tmp + port_d/2;
    reuse_block(blk, 'dvalid', 'built-in/outport', ...
      'Port', num2str(port_index), 'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp = ypos_tmp + yinc + port_d/2;  
    port_index = port_index + 1;
    add_line(blk, 'den/1', 'dvalid/1');
  end
  
  if strcmp(misc, 'on'),
    ypos_tmp  = ypos_tmp + port_d/2;
    reuse_block(blk, 'misco', 'built-in/outport', ...
      'Port', num2str(port_index), ... 
      'Position', [xpos-port_w/2 ypos_tmp-port_d/2 xpos+port_w/2 ypos_tmp+port_d/2]);
    ypos_tmp  = ypos_tmp + yinc + port_d/2;

    add_line(blk, 'dmisc1/1', 'misco/1');
  end

  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('exiting bus_single_port_ram_init', {'trace', log_group});

end %function bus_single_port_ram_init
