% Initialize and configure the reorder block.
%
% reorder_init(blk, varargin)
%
% blk = The block to be initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% map = The desired output order.
% map_latency = The latency of the map block.
% bram_latency = The latency of buffer BRAM blocks.
% n_inputs = The number of parallel inputs to be reordered.
% double_buffer = Whether to use two buffers to reorder data (instead of
%                 doing it in-place).
% bram_map = Whether to use BlockRAM for address mapping (instead of
%            distributed RAM.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
%                                                                             %
%   Meerkat Radio Telescope Project                                           %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2011, 2013 Andrew Martens                                   %
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

function reorder_init(blk, varargin)

log_group = 'reorder_init_debug';

clog('entering reorder_init', {log_group, 'trace'});
% Declare any default values for arguments you might like.
defaults = { ...
  'map', [0 7 1 3 2 5 6 4], ...
  'n_bits', 0, ...
  'map_latency', 2, ...
  'bram_latency', 1, ...
  'fanout_latency', 0, ...
  'n_inputs', 1, ...
  'double_buffer', 0, ...
  'software_controlled', 'off', ...
  'bram_map', 'on'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

check_mask_type(blk, 'reorder');
munge_block(blk, varargin{:});

map             = get_var('map', 'defaults', defaults, varargin{:});
n_bits          = get_var('n_bits', 'defaults', defaults, varargin{:});
map_latency     = get_var('map_latency', 'defaults', defaults, varargin{:});
bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
fanout_latency  = get_var('fanout_latency', 'defaults', defaults, varargin{:});
n_inputs        = get_var('n_inputs', 'defaults', defaults, varargin{:});
double_buffer   = get_var('double_buffer', 'defaults', defaults, varargin{:});
bram_map        = get_var('bram_map', 'defaults', defaults, varargin{:});
software_controlled = get_var('software_controlled', 'defaults', defaults, varargin{:});
mux_latency     = 1;

yinc = 20;

delete_lines(blk);

if isempty(map),
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting reorder_init', {log_group, 'trace'});
  return;
end %if

map_length = length(map);
map_bits = ceil(log2(map_length));
if strcmp('on', software_controlled),
    double_buffer = 1;
    map_latency = 3; %turn on full shared bram pipeline options
end
if double_buffer == 1, order = 2;
else, order = compute_order(map);
end
order_bits = ceil(log2(order));

if (strcmp('on',bram_map)), map_memory_type = 'Block RAM';
else, map_memory_type = 'Distributed memory';
end

% if we are using BRAM for mapping then we need to optimise for Speed, otherwise want to optimise Space as
% distributed RAM inherently fast
if strcmp(bram_map, 'on'), optimize = 'Speed';
else, optimize = 'Area';
end

if (double_buffer < 0 || double_buffer > 1) ,
  clog('Double Buffer must be 0 or 1', {log_group, 'error'});
  error('Double Buffer must be 0 or 1');
end

% Non-power-of-two maps could be supported by adding a counter an a
% comparitor, rather than grouping the map and address count into one
% counter.
if 2^map_bits ~= map_length,
    clog('Reorder currently only supports maps which are 2^? long.', {log_group, 'error'})
    error('Reorder currently only supports maps which are 2^? long.')
end

% make fanout as low as possible (2)
rep_latency = log2(n_inputs);

% en stuff
% delays on way into buffer depend on double buffering 
if double_buffer == 0, 
  if order == 2, pre_delay = map_latency + mux_latency; 
  else, pre_delay = 1 + mux_latency + map_latency;
  end
else, pre_delay = map_latency;
end

reuse_block(blk, 'en', 'built-in/inport', 'Position', [25   43    55   57], 'Port', '2');
reuse_block(blk, 'delay_we0', 'xbsIndex_r4/Delay', ...
  'reg_retiming', 'off', 'latency', num2str(pre_delay+rep_latency), 'Position', [305 40 345 60]);
add_line(blk, 'en/1', 'delay_we0/1');
reuse_block(blk, 'delay_we1', 'xbsIndex_r4/Delay', ...
  'reg_retiming', 'off', 'latency', num2str(pre_delay+rep_latency), 'Position', [305 80 345 100]);
add_line(blk, 'en/1', 'delay_we1/1');
reuse_block(blk, 'delay_we2', 'xbsIndex_r4/Delay', ...
  'reg_retiming', 'off', 'latency', num2str(pre_delay), 'Position', [305 120 345 140]);
add_line(blk, 'en/1', 'delay_we2/1');
reuse_block(blk, 'delay_valid', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'Position', [860  80  900  100], 'latency', num2str(bram_latency+(double_buffer*2)+fanout_latency));
add_line(blk, 'delay_we1/1', 'delay_valid/1');
reuse_block(blk, 'valid', 'built-in/outport', 'Position', [965   82   995   98], 'Port', '2');
add_line(blk, 'delay_valid/1', 'valid/1');

reuse_block(blk, 'we_replicate', 'casper_library_bus/bus_replicate', ...
    'latency', num2str(rep_latency), 'replication', num2str(n_inputs), 'misc', 'off', ...
    'Position', [490 119 530 141]);
add_line(blk, 'delay_we2/1', 'we_replicate/1');

reuse_block(blk, 'we_expand', 'casper_library_flow_control/bus_expand', ...
    'mode', 'divisions of equal size', 'outputNum', num2str(n_inputs), ...
    'outputWidth', '1', 'outputBinaryPt', '0', 'outputArithmeticType', '2', ...
    'Position', [585 119 635 119+(yinc*n_inputs)]);
add_line(blk, 'we_replicate/1', 'we_expand/1');

% sync stuff
% delay value here is time into BRAM + time for one vector + time out of BRAM
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [25    3    55    17], 'Port', '1');
reuse_block(blk, 'pre_sync_delay', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'off', 'Position', [305 0 345 20], 'latency', num2str(pre_delay+rep_latency));
add_line(blk, 'sync/1', 'pre_sync_delay/1');
reuse_block(blk, 'or', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', 'Position', [375 19 400 46]);
add_line(blk, 'delay_we0/1', 'or/2');
add_line(blk, 'pre_sync_delay/1', 'or/1');
reuse_block(blk, 'sync_delay_en', 'casper_library_delays/sync_delay_en', ...
    'Position', [530 5 690 25], 'DelayLen', num2str(map_length));
add_line(blk, 'or/1', 'sync_delay_en/2');
add_line(blk, 'pre_sync_delay/1', 'sync_delay_en/1');
reuse_block(blk, 'post_sync_delay', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'Position', [860  5  900  25], 'latency', num2str(bram_latency+(double_buffer*2)+fanout_latency));
add_line(blk, 'sync_delay_en/1', 'post_sync_delay/1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [965   7   995   23], 'Port', '1');
add_line(blk, 'post_sync_delay/1', 'sync_out/1');

base = 160 + (n_inputs-1)*yinc;

%Ports
for cnt=1:n_inputs,
  % Ports
  reuse_block(blk, ['din', num2str(cnt-1)], 'built-in/inport', ...
      'Position', [680    base+80*(cnt-1)+43   710    base+80*(cnt-1)+57], 'Port', num2str(2+cnt));
  reuse_block(blk, ['delay_din', num2str(cnt-1)], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'Position', [760    base+80*(cnt-1)+40    800    base+80*(cnt-1)+60], 'latency', num2str(pre_delay+rep_latency));
  add_line(blk, ['din', num2str(cnt-1),'/1'], ['delay_din', num2str(cnt-1),'/1']);
  reuse_block(blk, ['dout', num2str(cnt-1)], 'built-in/outport', ...
      'Position', [965    base+80*(cnt-1)+43   995    base+80*(cnt-1)+57], 'Port', num2str(2+cnt));
end %for

if order ~= 1,
  if order == 2,
    reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
        'Position', [95   base   145   base+55], 'n_bits', num2str(map_bits + order_bits), 'cnt_type', 'Free Running', ...
        'use_behavioral_HDL', 'off', 'implementation', 'Fabric', 'arith_type', 'Unsigned', ...
        'en', 'on', 'rst', 'on');
    add_line(blk, 'sync/1', 'Counter/1');
    add_line(blk, 'en/1', 'Counter/2');

    reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
        'Position', [170   base+35   200  base+55], 'mode', 'Lower Bit Location + Width', ...
        'nbits', num2str(map_bits));
    add_line(blk, 'Counter/1', 'Slice2/1');

    if double_buffer == 0, latency = (order-1)*map_latency;
    else, latency = (order-1)*map_latency + rep_latency;
    end 
    reuse_block(blk, 'delay_sel', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    base    345    base+20], 'latency', num2str(latency));
    reuse_block(blk, 'delay_d0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    base+35    345    base+55], 'latency', num2str(latency));
    add_line(blk, 'Slice2/1', 'delay_d0/1');

  end %if order == 2

  reuse_block(blk, 'addr_replicate', 'casper_library_bus/bus_replicate', ...
      'latency', num2str(rep_latency), 'replication', num2str(n_inputs), 'misc', 'off', ...
      'Position', [490 base 530 base+22]);

  reuse_block(blk, 'addr_expand', 'casper_library_flow_control/bus_expand', ...
      'mode', 'divisions of equal size', 'outputNum', num2str(n_inputs), ...
      'outputWidth', num2str(map_bits), 'outputBinaryPt', '0', 'outputArithmeticType', '0', ...
      'Position', [585 base 635 base+(yinc*n_inputs)]);
  add_line(blk, 'addr_replicate/1', 'addr_expand/1');
end %if order

% Special case for reorder of order 1 (just delay)
if order == 1,
    for cnt=1:n_inputs,
        % Delays
        reuse_block(blk, ['delay_din_bram', num2str(cnt-1)], 'casper_library_delays/delay_bram_en_plus', ...
            'DelayLen', 'length(map)', 'bram_latency', 'bram_latency+fanout_latency', ...
            'Position', [850    base+80*(cnt-1)+40    915    base+80*(cnt-1)+60]);

        % Wires
        add_line(blk, ['delay_din', num2str(cnt-1),'/1'], ['delay_din_bram', num2str(cnt-1),'/1']);
        add_line(blk, ['delay_din_bram', num2str(cnt-1),'/1'], ['dout', num2str(cnt-1),'/1']);
        add_line(blk, ['we_expand/',num2str(cnt)], ['delay_din_bram', num2str(cnt-1),'/2']);
    end %for
% Case for order != 1, single-buffered

elseif double_buffer == 0,

  % Add Dynamic Blocks and wires
  for cnt=1:n_inputs,
          
          % BRAMS
          bram_name = ['buf', num2str(cnt-1)];
          % if we dont specify a valid bit width, use generic BRAMs
          if n_bits == 0,
            reuse_block(blk, bram_name, 'xbsIndex_r4/Single Port RAM', ...
                'depth', num2str(2^map_bits), 'optimize', 'Speed', ...
                'write_mode', 'Read Before Write', 'latency', num2str(bram_latency+fanout_latency), ...
                'Position', [845    base+80*(cnt-1)-17+40   910   base+80*(cnt-1)+77]);
          else, %otherwise use brams that help reduce fanout
            m = floor(n_bits/64);
            n_bits_in = ['[repmat(64, 1, ', num2str(m),')]'];

            if m ~= (n_bits/64), 
              n = m+1;
              n_bits_in = ['[', n_bits_in, ', ', num2str(n_bits - (m*64)),']'];
            else,
              n = m;
            end
            bin_pts = ['[zeros(1, ', num2str(n),')]'];
            init_vector = ['[zeros(', num2str(2^map_bits), ',', num2str(n), ')]'];

            reuse_block(blk, bram_name, 'casper_library_bus/bus_single_port_ram', ...
              'n_bits', n_bits_in, 'bin_pts', bin_pts, 'init_vector', init_vector, ...
              'max_fanout', '1', 'mem_type', 'Block RAM', 'bram_optimization', 'Speed', ...
              'async', 'off', 'misc', 'off', ...
              'bram_latency', num2str(bram_latency), 'fan_latency', num2str(fanout_latency), ...
              'addr_register', 'on', 'addr_implementation', 'core', ...
              'din_register', 'on', 'din_implementation', 'behavioral', ...
              'we_register', 'on', 'we_implementation', 'core', ...
              'en_register', 'off', 'en_implementation', 'behavioral', ...
              'Position', [845    base+80*(cnt-1)-17+40   910   base+80*(cnt-1)+77]);
          end
          add_line(blk, ['we_expand/',num2str(cnt)], [bram_name,'/3']);
          add_line(blk, ['addr_expand/',num2str(cnt)], [bram_name,'/1']);
          add_line(blk, ['delay_din',num2str(cnt-1),'/1'], [bram_name,'/2']);
          add_line(blk, [bram_name,'/1'], ['dout',num2str(cnt-1),'/1']);
  end

  %special case for order of 2 
  if order == 2,
    reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
        'Position', [170   base   200   base+20], 'mode', 'Upper Bit Location + Width', ...
        'nbits', num2str(order_bits));
    add_line(blk, 'Counter/1', 'Slice1/1');
    add_line(blk, 'Slice1/1', 'delay_sel/1');

    reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', ...
        'Position', [415    base   440    base+10+20*order], 'inputs', num2str(order), 'latency', num2str(mux_latency));
    add_line(blk, 'delay_sel/1', 'Mux/1');
    add_line(blk, 'delay_d0/1', 'Mux/2');
    add_line(blk, 'Mux/1', 'addr_replicate/1');

    % Add Maps
    for cnt=1:order-1,
        mapname = ['map', num2str(cnt)];
        reuse_block(blk, mapname, 'xbsIndex_r4/ROM', ...
            'depth', num2str(map_length), 'initVector', 'map', 'latency', num2str(map_latency), ...
            'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', 'optimize', optimize, ...
            'distributed_mem', map_memory_type, 'Position', [230  base+50*cnt+35   270    base+50*cnt+55]);
        reuse_block(blk, ['delay_',mapname], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
            'Position', [305   base+50*cnt+35    345   base+50*cnt+55], 'latency', [num2str((order-(cnt+1))*map_latency)]);
    end

    for cnt=1:order-1,
        mapname = ['map',num2str(cnt)];
        prevmapname = ['map',num2str(cnt-1)];
        if cnt == 1,
            add_line(blk, 'Slice2/1', 'map1/1');
        else,
            add_line(blk, [prevmapname,'/1'], [mapname,'/1'], 'autorouting', 'on');
        end
        add_line(blk, [mapname,'/1'], ['delay_',mapname,'/1']);
        add_line(blk, ['delay_',mapname,'/1'], ['Mux/',num2str(cnt+2)]);
    end %for

  % for order greater than 2, we use a more optimal bram configuration
  else,
    reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
      'n_bits', num2str(map_bits), 'cnt_type', 'Free Running', ...
      'use_behavioral_HDL', 'off', 'implementation', 'Fabric', 'arith_type', 'Unsigned', 'en', 'on', 'rst', 'on', ...
      'Position', [80  base+300   120   base+340]);
    add_line(blk, 'sync/1', 'Counter/1');
    add_line(blk, 'en/1', 'Counter/2');
    
    % logic to cater for resyncing
    reuse_block(blk, 'dsync', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', 'latency', '1', 'Position', [85 base+50 115 base+70]);
    add_line(blk, 'sync/1', 'dsync/1');
  
    reuse_block(blk, 'msb', 'xbsIndex_r4/Slice', 'boolean_output', 'on', ...
        'Position', [135   base+65   160   base+85], 'mode', 'Upper Bit Location + Width', 'nbits', '1');
    add_line(blk, 'Counter/1', 'msb/1');
    
    reuse_block(blk, 'edge_detect', 'casper_library_misc/edge_detect', ...
        'edge', 'Falling', 'polarity', 'Active High', 'Position', [185   base+65   230   base+85]);
    add_line(blk, 'msb/1', 'edge_detect/1');
    
    reuse_block(blk, 'map_src', 'xbsIndex_r4/Register', ...
        'en', 'on', 'rst', 'on', 'Position', [265   base+40   305   base+80]);
    add_line(blk, 'edge_detect/1', 'map_src/1');
    add_line(blk, 'dsync/1', 'map_src/2');
    add_line(blk, 'edge_detect/1', 'map_src/3');
    
    reuse_block(blk, 'dmap_src', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', num2str(map_latency), ...
      'Position', [330 base+50 370 base+70]);
    add_line(blk, 'map_src/1', 'dmap_src/1');

    reuse_block(blk, 'map_mux', 'xbsIndex_r4/Mux', 'latency', num2str(mux_latency), 'inputs', '2', ...
      'Position', [440 base+176 470 base+264]);
    add_line(blk, 'dmap_src/1', 'map_mux/1');
    add_line(blk, 'map_mux/1', 'addr_replicate/1');

    % lookup of current map  
    reuse_block(blk, 'daddr0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', 'Position', [265 base+310 300 base+330]);
    add_line(blk, 'Counter/1', 'daddr0/1');
   
    % memory holding current map 
    reuse_block(blk, 'current_map', 'casper_library_bus/bus_dual_port_ram', ...
      'n_bits', num2str(map_bits), ...
      'bin_pts', '0', ...
      'init_vector', ['[0:',num2str((2^map_bits)-1),']'''], ...
      'max_fanout', '1', ...
      'mem_type', map_memory_type, 'bram_optimization', 'Speed', ...
      'async_a', 'off', 'async_b', 'off', 'misc', 'off', ...
      'bram_latency', num2str(map_latency), ...
      'fan_latency', num2str(1 + map_latency + 1), ...
      'addra_register', 'on', 'addra_implementation', 'core', ...
      'dina_register', 'off', 'dina_implementation', 'behavioral', ...
      'wea_register', 'on', 'wea_implementation', 'core', ...
      'addrb_register', 'off', 'addra_implementation', 'behavioral', ...
      'dinb_register', 'off', 'dinb_implementation', 'behavioral', ...
      'web_register', 'off', 'web_implementation', 'behavioral', ...
      'Position', [320 base+150 380 base+280]);
  
    add_line(blk, 'daddr0/1', 'current_map/4');
    add_line(blk, 'current_map/2', 'map_mux/3');
   
    reuse_block(blk, 'term', 'built-in/Terminator', 'Position', [395 base+175 415 base+195]);
    add_line(blk, 'current_map/1', 'term/1');

    if strcmp(bram_map, 'on'),
      reuse_block(blk, 'blank', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', ...
        'explicit_period', 'on', 'period', '1', 'Position', [240 base+237 255 base+253]);
      add_line(blk, 'blank/1', 'current_map/5'); 
      
      reuse_block(blk, 'never', 'xbsIndex_r4/Constant', ...
        'const', '0', 'arith_type', 'Boolean', 'explicit_period', 'on', 'period', '1', ...
        'Position', [265 base+257 280 base+273]);
      add_line(blk, 'never/1', 'current_map/6'); 
    end
 
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', 'reg_retiming', 'off', ...
      'latency', num2str(1 + map_latency), ...
      'Position', [265 base+400 385 base+420]);
    add_line(blk, 'en/1', 'den/1');
    add_line(blk, 'den/1', 'current_map/3', 'autorouting', 'on');   
 
    reuse_block(blk, 'daddr1', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', num2str(map_latency), ...
      'Position', [320 base+310 380 base+330]);
    add_line(blk, 'daddr0/1', 'daddr1/1');
    add_line(blk, 'daddr1/1', 'map_mux/2');
    add_line(blk, 'daddr1/1', 'current_map/1', 'autorouting', 'on');

    % memory holding change to current map
    reuse_block(blk, 'map_mod', 'xbsIndex_r4/ROM', ...
      'depth', num2str(map_length), 'initVector', 'map', 'latency', num2str(map_latency), ...
      'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', 'optimize', optimize, ...
      'distributed_mem', map_memory_type, 'Position', [520  base+194   570    base+246]);
    add_line(blk, 'map_mux/1', 'map_mod/1');

    reuse_block(blk, 'dnew_map', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
      'latency', '1', 'Position', [620 base+210 645 base+230]);
    add_line(blk, 'map_mod/1', 'dnew_map/1');
    add_line(blk, 'dnew_map/1', 'current_map/2', 'autorouting', 'on');

  end %if order == 2

% case for order > 1, double-buffered
else, %TODO fanout for signals into wr_addr and rw_mode for many inputs not handled
    reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
        'Position', [170   base   200   base+20], 'mode', 'Upper Bit Location + Width', ...
        'nbits', '1');
    add_line(blk, 'Counter/1', 'Slice1/1');
    add_line(blk, 'Slice1/1', 'delay_sel/1');

    % Add Dynamic Blocks
    for cnt=1:n_inputs,
        % BRAMS
        reuse_block(blk, ['dbl_buffer',num2str(cnt-1)], 'casper_library_reorder/dbl_buffer', ...
            'Position', [845    base+80*(cnt-1)-17+40   910   base+80*(cnt-1)+77], 'depth', num2str(2^map_bits), ...
            'latency', num2str(bram_latency+fanout_latency));
    end

    % Add Maps
    mapname = 'map1';
    if strcmp('on', software_controlled),
        reuse_block(blk, mapname, 'xps_library/shared_bram', ...
            'addr_width', num2str(ceil(log2(map_length))), 'init_vals', 'map', 'reg_prim_output', 'on', ...
            'reg_core_output', 'on', 'addr_width', num2str(map_bits), 'data_width', '16', ...
            'arith_type', 'Unsigned', 'data_bin_pt', '0', 'Position', [230  base+15+70   300    base+70+70]);
        reuse_block(blk, 'never', 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [230-50  base+15+70+40   270-50    base+35+70+40]);
        reuse_block(blk, 'zero', 'xbsIndex_r4/Constant', ...
            'arith_type', 'Unsigned', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'n_bits', '16', 'bin_pt', '0', ...
            'Position', [230-50  base+15+70+20   270-50    base+35+70+20]);
        add_line(blk, 'never/1', [mapname '/3']);
        add_line(blk, 'zero/1', [mapname '/2']);
        reuse_block(blk, 'sw_bram_slice', 'xbsIndex_r4/Slice', ...
            'Position', [330  base+15+70+20   360    base+35+70+20], ...
            'boolean_output', 'off', 'nbits', num2str(map_bits), ...
            'mode', 'Lower Bit Location + Width', 'base0', 'LSB of Input', 'bit0', '0');
        add_line(blk, 'map1/1', 'sw_bram_slice/1');
        add_line(blk, 'sw_bram_slice/1', 'addr_replicate/1');
    else,
        reuse_block(blk, mapname, 'xbsIndex_r4/ROM', ...
            'depth', num2str(map_length), 'initVector', 'map', 'latency', num2str(map_latency), ...
            'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', ...
            'distributed_mem', map_memory_type, 'Position', [230  base+15+70   270    base+35+70]);
        add_line(blk, 'map1/1', 'addr_replicate/1');
    end
    add_line(blk, 'Slice2/1', 'map1/1');

    % Add dynamic wires
    for cnt=1:n_inputs
        bram_name = ['dbl_buffer',num2str(cnt-1)];
        add_line(blk, 'delay_d0/1', [bram_name,'/2']);
        add_line(blk, ['addr_expand/',num2str(cnt)], [bram_name,'/3']);
        add_line(blk, ['we_expand/',num2str(cnt)], [bram_name,'/5']);
        add_line(blk, 'delay_sel/1', [bram_name,'/1']);
        add_line(blk, ['delay_din',num2str(cnt-1),'/1'], [bram_name,'/4']);
        add_line(blk, [bram_name,'/1'], ['dout',num2str(cnt-1),'/1']);
    end
end

clean_blocks(blk);

fmtstr = sprintf('order=%d', order);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting reorder_init', {log_group, 'trace'});
