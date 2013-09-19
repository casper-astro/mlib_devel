function delay_wideband_prog_init(blk, varargin)
% Initialize and configure the delay wideband programmable block .
% By Jason + Mekhala, mods by Andrew
%
% delay_wideband_prog_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Declare any default values for arguments you might like.

clog('Entering delay_wideband_prog_init','trace'); 
defaults = {'max_delay', 1024, 'n_inputs_bits', 2, 'bram_latency', 2, 'bram_type', 'Dual Port'};
 
% if parameter is changed then only it will redraw otherwise will exit
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('delay_wideband_prog_init post same_state','trace'); 
% Checks whether the block selected is correct with this called function.
check_mask_type(blk, 'delay_wideband_prog');
 
%Sets the variable to the sub-blocks (scripted ones), also checks whether
%to update or prevent from any update
munge_block(blk, varargin{:});
 
% sets the variable needed
max_delay = get_var('max_delay', 'defaults', defaults, varargin{:});
n_inputs_bits = get_var('n_inputs_bits', 'defaults', defaults, varargin{:});
ram_bits= ceil(log2(max_delay/(2^n_inputs_bits)));
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
bram_type = get_var('bram_type', 'defaults', defaults,varargin{:});
 
% Begin redrawing
delete_lines(blk);

% sync
reuse_block(blk,'sync', 'built-in/Inport',...
                    'Port', '1', 'Position',[15 178 45 192]) ;

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

reuse_block(blk,'sync_delay','xbsIndex_r4/Delay',...
            'Position',[300 699 340 741],...
            'latency',num2str(sync_latency));

reuse_block(blk,'sync_out', 'built-in/Outport',...
                    'Port', '1', 'Position',[1215 328 1245 342]);%[155 713 185 727]) ;

add_line(blk,'sync/1','sync_delay/1','autorouting','on');

% register delay value
reuse_block(blk,'delay','built-in/Inport',...
                    'Port', '2', 'Position',[15 178+100 45 192+100]) ;
reuse_block(blk,'en', 'built-in/Inport',...
                    'Port', '3', 'Position',[15 178+200 45 192+200]) ;

reuse_block(blk,'delay_reg','xbsIndex_r4/Register',...
            'Position',[75 219 110 241],...
            'en', 'on');

add_line(blk, 'delay/1', 'delay_reg/1', 'autorouting', 'on');

add_line(blk, 'en/1', 'delay_reg/2', 'autorouting', 'on');

%assume at least one input
reuse_block(blk,'data_in1', 'built-in/Inport',...
                    'Port', '4', 'Position',[785 178+300 815 192+300]) ;
reuse_block(blk,'data_out1','built-in/Outport',...
                    'Port', '2', 'Position',[1215 378 1245 392]);

%cut address for BRAM from delay
reuse_block(blk,'bram_rd_addrs','xbsIndex_r4/Slice',...
            'Position',[400 282 425 308],...
            'mode', 'Lower Bit Location + Width',...
            'nbits', num2str(ram_bits),...
            'bit0', num2str(n_inputs_bits),...
            'base0', 'LSB of Input');
 
% Topmost Bram block

if strcmp(bram_type,'Single Port'),
  reuse_block(blk,'delay_sp','casper_library_delays/delay_bram_prog',...
           'MaxDelay',num2str(ram_bits),...
           'bram_latency',num2str(bram_latency),...
           'Position',[845 265 885 305]);

  add_line(blk, 'data_in1/1', 'delay_sp/1', 'autorouting', 'on');
  add_line(blk, 'bram_rd_addrs/1', 'delay_sp/2', 'autorouting', 'on');

  % When using single-port BRAMs, a delay offset must added due to limitations in the delay_bram_prog

  reuse_block(blk,'delay_offset','xbsIndex_r4/Constant',...
          'Position',[240 391 255 409],...
          'const',num2str((bram_latency+1)*2^n_inputs_bits),...  % 'const',num2str((bram_latency+1)),...
          'arith_type', 'Unsigned',...
          'n_bits', num2str(ceil(log2(max_delay))),...
          'bin_pt', '0',...
          'explicit_period','on',...
          'period','1');
          
  reuse_block(blk,'delay_adder','xbsIndex_r4/AddSub',...
         'Position',[310 297 345 328],...
         'latency','1',...
         'mode', 'Addition');
  add_line(blk, 'delay_offset/1', 'delay_adder/2', 'autorouting', 'on');
  add_line(blk, 'delay_adder/1', 'bram_rd_addrs/1', 'autorouting', 'on');

  % This offset must be removed from the max possible delay value (and we force the value to clip at
  % this lower value) to prevent wrapping when this offset is added
  
  reuse_block(blk,'max_delay','xbsIndex_r4/Constant',...
         'Position',[80 265 110 285],...
         'const',num2str((2^ram_bits * 2^n_inputs_bits)-((bram_latency+1)*2^n_inputs_bits) - 1),...
         'arith_type','Unsigned',...
         'n_bits',num2str(ceil(log2(max_delay))),...
         'bin_pt', '0',...
         'explicit_period','on',...
         'period','1');

  reuse_block(blk,'max_delay_chk','xbsIndex_r4/Relational',...
              'latency', '1', ...
              'Position',[170 244 210 286],...
               'mode', 'a<=b');
  add_line(blk, 'delay_reg/1', 'max_delay_chk/1', 'autorouting', 'on');
  add_line(blk, 'max_delay/1', 'max_delay_chk/2', 'autorouting', 'on');
   
  reuse_block (blk,'mux_delay','xbsIndex_r4/Mux',...
               'Position',[240 245 270 365],...
               'inputs', '2');
  add_line(blk, 'mux_delay/1', 'delay_adder/1', 'autorouting', 'on');
  add_line(blk, 'max_delay_chk/1', 'mux_delay/1', 'autorouting', 'on');
  add_line(blk, 'max_delay/1', 'mux_delay/2', 'autorouting', 'on');

  add_line(blk, 'delay_reg/1', 'mux_delay/3', 'autorouting', 'on');
      


else
  add_line(blk, 'delay_reg/1', 'bram_rd_addrs/1', 'autorouting', 'on');

  reuse_block(blk,'delay_dp','casper_library_delays/delay_bram_prog_dp',...
           'ram_bits',num2str(ram_bits),...
           'bram_latency',num2str(bram_latency),...
           'Position',[845 265 885 305]);
 
  add_line(blk, 'data_in1/1', 'delay_dp/1', 'autorouting', 'on');
  add_line(blk, 'bram_rd_addrs/1', 'delay_dp/2', 'autorouting', 'on');

end

if n_inputs_bits<=0,
   if (strcmp(bram_type,'Single Port'))
      add_line(blk, 'delay_sp/1', 'data_out1/1','autorouting', 'on');
   else
      add_line(blk, 'delay_dp/1', 'data_out1/1','autorouting', 'on');
   end
   add_line(blk,'sync_delay/1','sync_out/1','autorouting','on');

else %(n_inputs_bits>0) 
  reuse_block(blk, 'barrel_switcher', 'casper_library_reorder/barrel_switcher',...
              'Position',[1055 275 1145 620],...
              'n_inputs',num2str(n_inputs_bits));
  add_line(blk, 'sync_delay/1', 'barrel_switcher/2', 'autorouting', 'on');
  add_line(blk,'barrel_switcher/1','sync_out/1','autorouting','on');
  add_line(blk, ['barrel_switcher/',num2str(2^n_inputs_bits+1)], 'data_out1/1','autorouting', 'on');

  %slice out amount of rotation in barrel shifter from delay value
  reuse_block(blk,'shift_sel','xbsIndex_r4/Slice',...
              'Position', [400 328 425 352],...
              'mode', 'Lower Bit Location + Width',...
              'nbits', num2str(n_inputs_bits),...
              'bit0', '0',...
              'base0', 'LSB of Input');
  
  if strcmp(bram_type, 'Single Port')
    add_line(blk, 'delay_sp/1',  ['barrel_switcher/',num2str((2^n_inputs_bits)+2)], 'autorouting', 'on');
    add_line(blk, 'delay_adder/1', 'shift_sel/1', 'autorouting', 'on');
  else
    add_line(blk, 'delay_dp/1',  ['barrel_switcher/',num2str((2^n_inputs_bits)+2)], 'autorouting', 'on');
    add_line(blk, 'delay_reg/1', 'shift_sel/1', 'autorouting', 'on');
  end

  %delay shift value to match delay latency through delay brams
  reuse_block(blk,'delay_sel','xbsIndex_r4/Delay',...
              'latency', num2str(latency),...
              'Position',[845 327 885 353]);
  add_line(blk, 'shift_sel/1',  'delay_sel/1', 'autorouting', 'on');
  add_line(blk, 'delay_sel/1',  'barrel_switcher/1', 'autorouting', 'on');

  y = 365;
  for i=1:((2^n_inputs_bits)-1),
    name = ['data_out', num2str(i+1)];
    reuse_block(blk,name,'built-in/Outport',...
              'Port', num2str(i+2), 'Position',[1215 y+88 1245 y+102]) ;   
    y=y+80;
  end
  y = 365;

  for i=1:((2^n_inputs_bits)-1),
         
    name = ['Constant',num2str(i)];
    reuse_block(blk,name,'xbsIndex_r4/Constant',...
              'Position',[485 y+36 500 y+54],...
              'const', num2str(2^n_inputs_bits-1-i),...
              'arith_type', 'Unsigned',...
              'n_bits', num2str(n_inputs_bits),...
              'bin_pt', '0',...
              'explicit_period', 'on',...
              'period', '1' );            
          
    name = ['Relational',num2str(i)];
    reuse_block(blk,name,'xbsIndex_r4/Relational',...
               'Position', [525 y+30 570 y+50], ...
               'latency','0',... 
               'mode','a>b');
    add_line(blk, 'shift_sel/1', ['Relational',num2str(i),'/1'], 'autorouting', 'on');
    add_line(blk, ['Constant',num2str(i),'/1'], ['Relational',num2str(i),'/2'], 'autorouting', 'on');
           
    name = ['Convert', num2str(i)];
    reuse_block(blk,name,'xbsIndex_r4/Convert',...
              'Position',[595 y+25 640 y+55],...
              'arith_type', 'Unsigned',...
              'n_bits', '1',...
              'bin_pt', '0') ; 
    add_line(blk, ['Relational',num2str(i),'/1'], ['Convert',num2str(i),'/1'], 'autorouting', 'on');

    name = ['AddSub', num2str(i)];
    reuse_block(blk,name,'xbsIndex_r4/AddSub',...
              'Position',[720 y+2 770 y+53],...
              'mode', 'Addition',...
              'arith_type', 'Unsigned',...
              'n_bits', num2str(ram_bits),...
              'bin_pt', '0',...
              'quantization', 'Truncate',...
              'overflow', 'Wrap',...
              'latency', '0');
    add_line(blk, ['Convert',num2str(i),'/1'], ['AddSub',num2str(i),'/2'], 'autorouting', 'on');
    add_line(blk, 'bram_rd_addrs/1', ['AddSub',num2str(i),'/1'], 'autorouting', 'on');

    name = ['data_in', num2str(i+1)];
    reuse_block(blk,name, 'built-in/Inport',...
              'Port', num2str(i+4),'Position',[785 y+3 815 y+17]) ;        

    % delay brams
    if strcmp(bram_type,'Single Port'),
      name = ['delay_sp', num2str(i)];
      reuse_block(blk, name, 'casper_library_delays/delay_bram_prog',...
              'Position',[845 y 885 y+40],...
              'MaxDelay',num2str(ram_bits),...
              'bram_latency',num2str(bram_latency));
      add_line(blk, ['AddSub',num2str(i),'/1'], [name,'/2'], 'autorouting', 'on');
      add_line(blk, ['data_in',num2str(i+1),'/1'],  [name,'/1'], 'autorouting', 'on');
      add_line(blk, [name,'/1'],  ['barrel_switcher/',num2str((2^n_inputs_bits)-i+2)], 'autorouting', 'on');
    else
      name = ['delay_dp', num2str(i)];
      reuse_block(blk, name, 'casper_library_delays/delay_bram_prog_dp',...
              'Position',[845 y 885 y+40],...
              'ram_bits',num2str(ram_bits),...
              'bram_latency',num2str(bram_latency));
      add_line(blk, ['AddSub',num2str(i),'/1'], [name,'/2'], 'autorouting', 'on');
      add_line(blk, ['data_in',num2str(i+1),'/1'],  [name,'/1'], 'autorouting', 'on');
      add_line(blk, [name,'/1'],  ['barrel_switcher/',num2str((2^n_inputs_bits)-i+2)], 'autorouting', 'on');
    end

    add_line(blk, ['barrel_switcher/',num2str(i+1)], ['data_out',num2str((2^n_inputs_bits)-i+1),'/1'],'autorouting', 'on');

    y=y+80;
         
  end
end

clean_blocks(blk);
 
%fmtstr = sprintf();
% Printing at the bottom of the block fmtstr = sprintf('Min
% Delay=%d',(n_inputs_bits + bram_latency+1); %
%set_param(blk, 'AttributesFormatString', fmtstr);
 
% Save all the variables just like global variables in C
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting delay_wideband_prog_init','trace'); 
