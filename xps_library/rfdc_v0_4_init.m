function rfdc_v0_4_init(blk, varargin)
% Initialize and configure the RFDC

defaults = {...
            'sys_config', '1 ADC CORE',...
            'adc_sample_rate', '2048',...
            'mts_mode','Non-MTS'};

% Check to see if mask parameters have changed
if same_state(blk, 'gcb', gcb, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'rfdc');
%munge_block(blk, varargin{:});

sys_config              = get_var('sys_config', 'defaults', defaults, varargin{:}); 
adc_sample_rate         = get_var('adc_sample_rate', 'defaults', defaults, varargin{:});
mts_mode                = get_var('mts_mode', 'defaults', defaults, varargin{:});
%get the blk path
blk_dir         = fileparts(blk);
zcu111_blk      = [blk_dir, '/ZCU111'];
%change clk_rate in ZCU111 yellow block, which is based on adc_sample_rate
try
    if(adc_sample_rate == 1) %1-2048
        set_param(zcu111_blk,'clk_rate','256');
    elseif(adc_sample_rate == 2) %2-4096 
        set_param(zcu111_blk,'clk_rate','512');
    end
catch
end

% find out all the blocks in the design
gateway_ins     = find_system(blk, 'FollowLinks', 'on', 'LookUnderMasks', 'all',     'MaskType', 'Xilinx Gateway In Block');
gateway_outs    = find_system(blk, 'FollowLinks', 'on', 'LookUnderMasks', 'all',     'MaskType', 'Xilinx Gateway Out Block');
sim_in          = find_system(blk, 'FollowLinks', 'on', 'LookUnderMasks', 'all',     'BlockType','Inport');
sim_out         = find_system(blk, 'FollowLinks', 'on', 'LookUnderMasks', 'all',     'BlockType','Outport');

if(length(gateway_ins)==2^(sys_config))
    return;
end

%delete all the lines and blocks,and will re draw them later
delete_lines(blk);



for i=1:length(gateway_ins)
   delete_block(gateway_ins(i)) 
end

for i=1:length(gateway_outs)
    delete_block(gateway_outs(i))
end

for i=1:length(sim_in)
    delete_block(sim_in(i))
end

for i=1:length(sim_out)
    delete_block(sim_out(i))
end


%now, let's re-draw the lines and blocks we need
%The number of xilinx gate in and out needed depends on sys_config
curr_x = 100;
curr_y = 0;
for i=1:2^(sys_config-1)
    adc_do_gw_in_name = clear_name([gcb, '_', 'adc',num2str(i-1),'_','dout']);
    adc_di_inport_name = clear_name(['adc',num2str(i-1),'_in','_sim']);
    adc_do_outport_name = clear_name(['adc',num2str(i-1),'_dout']);
    %add a inport for adc
    add_block('built-in/inport', [blk,'/',adc_di_inport_name],...
              'Name', adc_di_inport_name,...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+30 curr_y+116+60])
    
    curr_x = curr_x + 200;
    %add a gateway in
    add_block('xbsIndex_r4/Gateway In',[blk,'/',adc_do_gw_in_name],...
              'Name',adc_do_gw_in_name,...
              'arith_type', 'Unsigned',...  
              'n_bits','128',...
              'bin_pt', '0',...
              'overflow', 'Wrap',...
              'quantization', 'Truncate',...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+60 curr_y+116+60])
    curr_x = curr_x + 200;
    %add a outport for adc
    add_block('built-in/outport', [blk,'/',adc_do_outport_name],...
              'Name', adc_do_outport_name,...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+30 curr_y+116+60])
    curr_x = curr_x - 400;
    curr_y = curr_y + 60;
    %connect them
    add_line(blk, [adc_di_inport_name, '/1'],...
                  [adc_do_gw_in_name, '/1']);
    add_line(blk, [adc_do_gw_in_name, '/1'],...
                  [adc_do_outport_name, '/1']);   
    %add sync port
    adc_sync_gw_in_name = clear_name([gcb, '_', 'adc',num2str(i-1),'_','sync']);
    adc_sync_inport_sim_name = clear_name(['adc',num2str(i-1),'_sync_in','_sim']);
    adc_sync_ouport_sim_name = clear_name(['adc',num2str(i-1),'_sync_out']);
    %add a inport for adc
    add_block('built-in/inport', [blk,'/',adc_sync_inport_sim_name],...
              'Name', adc_sync_inport_sim_name,...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+30 curr_y+116+60])
    
    curr_x = curr_x + 200;
    %add a gateway in
    add_block('xbsIndex_r4/Gateway In',[blk,'/',adc_sync_gw_in_name],...
              'Name',adc_sync_gw_in_name,...
              'arith_type', 'Boolean',...  
              'n_bits','1',...
              'bin_pt', '0',...
              'overflow', 'Wrap',...
              'quantization', 'Truncate',...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+60 curr_y+116+60])
    curr_x = curr_x + 200;
    %add a outport for adc
    add_block('built-in/outport', [blk,'/',adc_sync_ouport_sim_name],...
              'Name', adc_sync_ouport_sim_name,...
              'Position',[curr_x curr_y+100+60,...
                          curr_x+30 curr_y+116+60])
    curr_x = curr_x - 400;
    curr_y = curr_y + 60;
    %connect them
    add_line(blk, [adc_sync_inport_sim_name, '/1'],...
                  [adc_sync_gw_in_name, '/1']);
    add_line(blk, [adc_sync_gw_in_name, '/1'],...
                  [adc_sync_ouport_sim_name, '/1']);   
end

end
