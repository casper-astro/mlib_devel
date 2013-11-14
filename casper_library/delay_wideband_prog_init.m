% Initialize and configure the delay wideband programmable block .
% By Jason + Mekhala, mods by Andrew
%
% delay_wideband_prog_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Declare any default values for arguments you might like.

function delay_wideband_prog_init(blk, varargin)

log_group = 'delay_wideband_prog_init_debug';

clog('entering delay_wideband_prog_init', {log_group, 'trace'}); 
defaults = { ...
  'max_delay', 1024, ...
  'n_inputs_bits', 2, ...
  'bram_latency', 2, ...
  'bram_type', 'Dual Port', ...
  'async', 'off'};
 
% if parameter is changed then only it will redraw otherwise will exit
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

% Checks whether the block selected is correct with this called function.
check_mask_type(blk, 'delay_wideband_prog');
 
%Sets the variable to the sub-blocks (scripted ones), also checks whether
%to update or prevent from any update
munge_block(blk, varargin{:});
 
% sets the variable needed
max_delay         = get_var('max_delay', 'defaults', defaults, varargin{:});
n_inputs_bits     = get_var('n_inputs_bits', 'defaults', defaults, varargin{:});
ram_bits          = ceil(log2(max_delay/(2^n_inputs_bits)));
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
bram_type         = get_var('bram_type', 'defaults', defaults,varargin{:});
async             = get_var('async', 'defaults', defaults,varargin{:});

if strcmp(async, 'on') && strcmp(bram_type, 'Single Port'),
  clog('Delays must be implemented in dual port memories when in asynchronous mode', {log_group, 'error'}); 
  error('Delays must be implemented in dual port memories when in asynchronous mode in the delay_wideband_prog block'); 
end
 
% Begin redrawing
delete_lines(blk);

if (max_delay == 0),
  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:}); 
  clog('exiting delay_wideband_prog_init', {log_group, 'trace'});
  return;
end

% delay sync to compensate for delays
% through BRAMs as well as for delay offset added
% when using single port RAMs
if strcmp(bram_type, 'Single Port'),
  latency = bram_latency + 2;
  sync_latency = latency + (bram_latency+1)*2^n_inputs_bits;
else
  latency = bram_latency + 1;
  sync_latency = latency;
end

% sync
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [15 218 45 232]) ;

if strcmp(async, 'on'),
  % en
  y = 230 + (2^n_inputs_bits)*70;
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', num2str(1 + 2^n_inputs_bits), ...
    'Position',[15 y+28 45 y+42]);
  reuse_block(blk, 'en_delay0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'Position', [565 y+21 605 y+49], 'latency', '0');
  add_line(blk, 'en/1', 'en_delay0/1');
  reuse_block(blk, 'en_delay1', 'xbsIndex_r4/Delay', ...
    'Position', [705 y+21 745 y+49], 'latency', num2str(sync_latency), 'reg_retiming', 'on');
  add_line(blk, 'en_delay0/1', 'en_delay1/1');
  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', num2str(1 + 2^n_inputs_bits), ...
    'Position', [975 y+28 1005 y+42]);
end

reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
  'Position', [705 211 745 239], 'latency', num2str(sync_latency));

reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [975 158 1005 172]);
add_line(blk, 'sync/1', 'sync_delay/1');

% register delay value
reuse_block(blk, 'delay', 'built-in/Inport', 'Port', '2', 'Position', [15 273 45 287]) ;
reuse_block(blk, 'ld_delay', 'built-in/Inport', 'Port', '3', 'Position', [15 303 45 317]) ;

reuse_block(blk, 'delay_reg', 'xbsIndex_r4/Register', 'Position',[105 266 160 324], 'en', 'on');

add_line(blk, 'delay/1', 'delay_reg/1', 'autorouting', 'on');

add_line(blk, 'ld_delay/1', 'delay_reg/2', 'autorouting', 'on');

%cut address for BRAM from delay
reuse_block(blk, 'bram_rd_addrs', 'xbsIndex_r4/Slice', ...
  'Position', [420 282 450 308], ...
  'mode', 'Lower Bit Location + Width', ...
  'nbits', num2str(ram_bits), ...
  'bit0', num2str(n_inputs_bits), ...
  'base0', 'LSB of Input');
 
if strcmp(bram_type, 'Single Port'),

  % When using single-port BRAMs, a delay offset must added due to limitations in the delay_bram_prog

  reuse_block(blk, 'delay_offset', 'xbsIndex_r4/Constant', ...
    'Position', [230 333 255 357], ...
    'const', num2str((bram_latency+1)*2^n_inputs_bits), ...  
    'arith_type', 'Unsigned', ...
    'n_bits', num2str(ceil(log2(max_delay))), ...
    'bin_pt', '0', ...
    'explicit_period', 'on', ...
    'period', '1');
          
  reuse_block(blk, 'delay_adder', 'xbsIndex_r4/AddSub', ...
    'Position', [310 266 345 319], ...
    'latency', '1', 'mode', 'Addition');
  add_line(blk, 'delay_offset/1', 'delay_adder/2', 'autorouting', 'on');
  add_line(blk, 'delay_adder/1', 'bram_rd_addrs/1', 'autorouting', 'on');

  % This offset must be removed from the max possible delay value (and we force the value to clip at
  % this lower value) to prevent wrapping when this offset is added
  
  reuse_block(blk, 'max_delay', 'xbsIndex_r4/Constant',...
    'Position', [115 230 145 250],...
    'const', num2str((2^ram_bits * 2^n_inputs_bits)-((bram_latency+1)*2^n_inputs_bits) - 1),...
    'arith_type', 'Unsigned',...
    'n_bits', num2str(ceil(log2(max_delay))),...
    'bin_pt', '0',...
    'explicit_period', 'on',...
    'period', '1');

  reuse_block(blk, 'max_delay_chk', 'xbsIndex_r4/Relational', ...
    'latency', '1', 'Position', [185 234 225 276], 'mode', 'a<=b');
  add_line(blk, 'delay_reg/1', 'max_delay_chk/1', 'autorouting', 'on');
  add_line(blk, 'max_delay/1', 'max_delay_chk/2', 'autorouting', 'on');
   
  reuse_block (blk,'mux_delay','xbsIndex_r4/Mux', 'Position', [250 245 275 315], 'inputs', '2');
  add_line(blk, 'mux_delay/1', 'delay_adder/1', 'autorouting', 'on');
  add_line(blk, 'max_delay_chk/1', 'mux_delay/1', 'autorouting', 'on');
  add_line(blk, 'max_delay/1', 'mux_delay/2', 'autorouting', 'on');

  add_line(blk, 'delay_reg/1', 'mux_delay/3', 'autorouting', 'on');
else
  add_line(blk, 'delay_reg/1', 'bram_rd_addrs/1', 'autorouting', 'on');
end

if n_inputs_bits > 0, 
  reuse_block(blk, 'barrel_switcher', 'casper_library_reorder/barrel_switcher', ...
    'async', async, 'n_inputs', num2str(n_inputs_bits), ...
    'Position', [825 127 910 127+(62*(2+2^n_inputs_bits))]);
  add_line(blk, 'sync_delay/1', 'barrel_switcher/2');
  add_line(blk, 'barrel_switcher/1', 'sync_out/1');

  if strcmp(async, 'on'),
    add_line(blk, 'en_delay1/1', ['barrel_switcher/', num2str(3 + 2^n_inputs_bits)]);
    add_line(blk, ['barrel_switcher/', num2str(2 + 2^n_inputs_bits)], 'dvalid/1');
  end

  %slice out amount of rotation in barrel shifter from delay value
  reuse_block(blk, 'shift_sel', 'xbsIndex_r4/Slice', ...
    'mode', 'Lower Bit Location + Width', ...
    'nbits', num2str(n_inputs_bits), ...
    'bit0', '0', 'base0', 'LSB of Input', ...
    'Position', [190 153 220 177]);
  
  if strcmp(bram_type, 'Single Port')
    add_line(blk, 'delay_adder/1', 'shift_sel/1', 'autorouting', 'on');
  else
    add_line(blk, 'delay_reg/1', 'shift_sel/1');
  end

  %delay shift value to match delay latency through delay brams
  reuse_block(blk, 'delay_sel', 'xbsIndex_r4/Delay', 'latency', num2str(latency), ...
    'reg_retiming', 'on', 'Position', [705 152 745 178]);
  add_line(blk, 'shift_sel/1', 'delay_sel/1');
  add_line(blk, 'delay_sel/1', 'barrel_switcher/1');

  y = 230;
  for n=0:((2^n_inputs_bits)-1),
    name = ['data_out', num2str(n)];
    reuse_block(blk, name, 'built-in/Outport', 'Port', num2str(n+2), 'Position', [975 y+3 1005 y+17]); 
    add_line(blk, ['barrel_switcher/', num2str((2^n_inputs_bits)-n+1)], [name,'/1']);  
    y=y+70;
  end

  y = 260;
  for n=0:(2^n_inputs_bits)-1,
    in_name = ['data_in', num2str(n)];
    reuse_block(blk, in_name, 'built-in/Inport', 'Port', num2str(n+4), 'Position', [570 y+8 600 y+22]) ;        

    % delay brams
    if strcmp(bram_type, 'Single Port'),
      delay_name = ['delay_sp', num2str(n)];
      reuse_block(blk, delay_name, 'casper_library_delays/delay_bram_prog', ...
        'Position', [705 y+5 745 y+45], ...
        'MaxDelay', num2str(ram_bits), ...
        'bram_latency', num2str(bram_latency));
    else
      delay_name = ['delay_dp', num2str(n)];
      reuse_block(blk, delay_name, 'casper_library_delays/delay_bram_prog_dp', ...
        'Position',[705 y+5 745 y+45], ...
        'ram_bits', num2str(ram_bits), 'async', async, ...
        'bram_latency', num2str(bram_latency));
    end
    add_line(blk, [in_name, '/1'], [delay_name, '/1']); 
    add_line(blk, [delay_name, '/1'], ['barrel_switcher/', num2str((2^n_inputs_bits)-n+2)]); 

    if strcmp(async, 'on'), add_line(blk, 'en_delay0/1', [delay_name, '/3']); 
    end
 
    if n > 0, 
      name = ['Constant', num2str(n)];
      reuse_block(blk, name, 'xbsIndex_r4/Constant',...
        'Position', [295 y+41 310 y+59],...
        'const', num2str(2^n_inputs_bits-1-n),...
        'arith_type', 'Unsigned',...
        'n_bits', num2str(n_inputs_bits),...
        'bin_pt', '0',...
        'explicit_period', 'on',...
        'period', '1' );            
            
      name = ['Relational', num2str(n)];
      reuse_block(blk, name, 'xbsIndex_r4/Relational', ...
         'Position', [335 y+35 380 y+55], ...
         'latency', '0', 'mode', 'a>b');
      add_line(blk, 'shift_sel/1', ['Relational', num2str(n),'/1']);
      add_line(blk, ['Constant', num2str(n),'/1'], ['Relational', num2str(n), '/2']);
             
      name = ['Convert', num2str(n)];
      reuse_block(blk, name, 'xbsIndex_r4/Convert', ...
        'Position', [420 y+35 450 y+55], ...
        'arith_type', 'Unsigned', 'n_bits', '1', 'bin_pt', '0') ; 
      add_line(blk, ['Relational', num2str(n), '/1'], ['Convert', num2str(n), '/1']);

      add_name = ['AddSub', num2str(n)];
      reuse_block(blk, add_name, 'xbsIndex_r4/AddSub', ...
        'Position', [515 y+17 550 y+53], ...
        'mode', 'Addition', 'arith_type', 'Unsigned', ...
        'n_bits', num2str(ram_bits), ...
        'bin_pt', '0', 'quantization', 'Truncate', ...
        'overflow', 'Wrap', 'latency', '0');
      add_line(blk, 'bram_rd_addrs/1', [add_name, '/1']);
      add_line(blk, ['Convert', num2str(n), '/1'], [add_name, '/2']);
      add_line(blk, [add_name, '/1'], [delay_name, '/2']);
    else,
      add_line(blk, 'bram_rd_addrs/1', [delay_name, '/2']);
    end %if

    y=y+60;
  end %for       
else,
  if strcmp(bram_type, 'Single Port'), add_line(blk, 'delay_sp/1', 'data_out0/1');
  else, add_line(blk, 'delay_dp/1', 'data_out0/1');
  end
  add_line(blk, 'sync_delay/1', 'sync_out/1');
  
  if strcmp(async, 'on'), add_line(blk, 'en_delay/1', 'dvalid/1');
  end
end

clean_blocks(blk);
 
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting delay_wideband_prog_init', {log_group, 'trace'}); 
