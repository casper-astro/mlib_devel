function finedelay_fstop_prog_cordic_init(blk, varargin)
% Initialize and configure the Fine Delay + Fringe Stop block using CORDIC
% SysGen block to make it compatible with Virtex5 FPGA.
% Mekhala, GMRT, India.
%
% %
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Declare any default values for arguments you might like.
 
defaults = {'n_input',2,'fft_len',1024,'fft_bits',18,'theta_bits',20,'theta_binary_bits',17,'stages',9,'fft_cycle_bits',17,'sync_period',134217728};
 
% if parameter is changed then only it will redraw otherwise will exit
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
 
% Checks whether the block selected is correct with this called function.
check_mask_type(blk, 'finedelay_fstop_prog_cordic');
 
%Sets the variable to the sub-blocks (scripted ones), also checks whether
%to update or prevent from any update
munge_block(blk, varargin{:});
 
% sets the variable needed
n_input = get_var ('n_input','defaults', defaults, varargin{:});
fft_len = get_var('fft_len', 'defaults', defaults, varargin{:});
fft_bits = get_var('fft_bits', 'defaults', defaults, varargin{:});
theta_bits= get_var('theta_bits', 'defaults', defaults, varargin{:});
theta_binary_bits = get_var('theta_binary_bits', 'defaults', defaults,varargin{:});
stages = get_var('stages', 'defaults', defaults,varargin{:});
fft_cycle_bits = get_var('fft_cycle_bits', 'defaults', defaults,varargin{:});
sync_period = get_var('sync_period', 'defaults', defaults,varargin{:}); 

% Begin redrawing
 
delete_lines(blk);
 
% % Drawing the fixed blocks in the design.Includes the sync delays at the top
 
     reuse_block(blk,'sync_delay1','casper_library_delays/sync_delay',...
                'DelayLen', '7', ...
                'Position',[430 50 475 80]);
   
    reuse_block(blk,'sync_delay2','casper_library_delays/sync_delay',...
                'DelayLen', '2', ...
                'Position',[625 50 670 80]);
            
    reuse_block(blk,'sync_delay3','casper_library_delays/sync_delay',...
                'DelayLen', '12', ...
                'Position',[695 50 740 80]);
            
    reuse_block(blk,'sync_delay4','casper_library_delays/sync_delay',...
                'DelayLen', '1', ...
                'Position',[795 50 840 80]);
            
    reuse_block(blk,'sync_delay5','casper_library_delays/sync_delay',...
                'DelayLen', '2', ...
                'Position',[950 50 995 80]);
    
%  %%%%%%%%%% Drawing the blocks which are replicated depending upon the
% %  %%%%%%%%%% number of inputs.
 y1 = 204;
 y2 = 331;
  for i=1:n_input
      
     name = ['Fine_del_sub_blk',num2str(i)];
     reuse_block(blk,name,'casper_library_delays/Fine_del_sub_blk',...
            'Position',[415 y1+((i-1)*465) 490 y2+((i-1)*465)],...
            'fft_len',num2str(fft_len),...
            'theta_bits',num2str(theta_bits) ,...
            'theta_binary_bits',num2str(theta_binary_bits));
        
     name = ['Fringe_sub_blk',num2str(i)];
     reuse_block(blk,name,'casper_library_delays/Fringe_sub_blk',...
            'Position',[415 y1+208+((i-1)*450) 490 y2+207+((i-1)*450)],...
            'fft_len',num2str(fft_len),...
            'theta_bits',num2str(theta_bits) ,...
            'theta_binary_bits',num2str(theta_binary_bits),...
            'fft_cycle_bits',num2str(fft_cycle_bits),...
            'sync_period',num2str(sync_period));
        
    name = ['Fract_Fringe_Adder', num2str(i)];
    reuse_block(blk,name,'xbsIndex_r4/AddSub',...
               'Position',[545 y1+142+((i-1)*465) 610 y2+68+((i-1)*465)],... 
               'mode', 'Addition',...
               'precision', 'User Defined',...
               'arith_type', 'Signed',...
               'n_bits', num2str(theta_bits),...
               'bin_pt', num2str(theta_binary_bits),...
               'quantization', 'Truncate',...
               'overflow', 'Wrap',...
               'latency', '2');        
  
    name = ['CORDIC_SINCOS', num2str(i)];
    reuse_block(blk,name,'xrbsMath_r4/CORDIC SINCOS',...
               'Position',[690 y1+143+((i-1)*468) 740 y2+62+((i-1)*468)],...
               'MaskSelfModifiable','on',...
               'stages',num2str(stages),... 
               'pe_nbits' ,num2str(theta_bits),...
               'pe_binpt',num2str(theta_binary_bits),...
               'pipeline_x',['ones(1,',num2str(stages),')']);   

    name = ['Datatype_Conv_Cos', num2str(i)];   
    reuse_block(blk,name,'casper_library_delays/Datatype_Conv_Cos',...
                'theta_binary_bits', num2str(theta_binary_bits),...
                'fft_bits',num2str(fft_bits),...
                'Position',[795 y1+106+((i-1)*455) 835 y2+39+((i-1)*455)]);
             
   name = ['Datatype_Conv_Sine', num2str(i)];   
   reuse_block(blk,name,'casper_library_delays/Datatype_Conv_Sine',...
                'theta_binary_bits', num2str(theta_binary_bits),...
                'fft_bits',num2str(fft_bits),...
                'Position',[795 y1+181+((i-1)*470) 835 y2+114+((i-1)*470)]);  
            
   name = ['Input_Del', num2str(i)];
   reuse_block(blk,name,'xbsIndex_r4/Delay',...
              'latency', '22',...
              'position',[975 y1+143+((i-1)*450) 1005 y2+42+((i-1)*450)]);
           
   name = ['c_to_ri', num2str(i)];
   reuse_block(blk,name,'casper_library_misc/c_to_ri',...
               'position',[1030 y1+139+((i-1)*450) 1055 y2+41+((i-1)*450)],...
               'n_bits', num2str(fft_bits),...
               'bin_pt',num2str(fft_bits-1));             
            
    name = ['cmult_4bit_em', num2str(i)];
    reuse_block(blk,name,'casper_library_multipliers/cmult_4bit_em',...
                'Position',[1105 y1+136+((i-1)*450) 1150 y2+74+((i-1)*450)],... 
                'mult_latency', '2',...
                'add_latency', '0') ; 
            
    name = ['Convert', num2str(i*2)];
    reuse_block(blk,name,'xbsIndex_r4/Convert',...
                'Position',[1175 y1+141+((i-1)*450) 1220 y2+44+((i-1)*450)],...
                'arith_type', 'Signed',...
                'n_bits', 'fft_bits',...
                'bin_pt', 'fft_bits-1',...
                'latency', '0',...
                'ShowName', 'off') ;        
          
    name = ['Convert', num2str((i*2)+1)];
    reuse_block(blk,name,'xbsIndex_r4/Convert',...
                'Position',[1175 y1+171+((i-1)*450) 1220 y2+74+((i-1)*450)],...
                'arith_type', 'Signed',...
                'n_bits', 'fft_bits',...
                'bin_pt', 'fft_bits-1',...
                'latency', '0',...
                'ShowName', 'off') ;   
                
   name = ['ri_to_c', num2str(i)];
   reuse_block(blk,name,'casper_library_misc/ri_to_c',...
               'position',[1260 y1+139+((i-1)*450) 1295 y2+76+((i-1)*450)]);
                
   end

   
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%% Drawing Input Output ports
% % % 
% %  
reuse_block(blk,'sync','built-in/Inport',...
                    'Position',[15 58 45 72]) ;
 
reuse_block(blk,'sync_out','built-in/Outport',...
                    'Position',[1110 58 1140 72]);
 
 
reuse_block(blk,'theta_fract','built-in/Inport',...
                    'Position',[15 228 45 242]);
                 
reuse_block(blk,'en_theta_fs','built-in/Inport',...
                  'Position',[15   453    45   467]);
       
reuse_block(blk,'theta_fs','built-in/Inport',...
                'Position',[15 483 45 497]);  
            
reuse_block(blk,'fft_fs','built-in/Inport',...
                  'Position',[15 513 45 527]);
              
     
       
%                   
y1 = 353;
y2 = 367;
                  
 for i=1:n_input      
     name = ['pol',num2str(i-1),'_in'];
     reuse_block(blk,name,'built-in/Inport',...
                    'Position',[895 y1+((i-1)*450) 925 y2+((i-1)*450)]) ;
 end
 
  
 y1 = 367;
 y2 = 383;
 for i=1:n_input 
     name = ['out',num2str(i-1)];
     reuse_block(blk,name,'built-in/Outport',...
                    'Position',[1345 y1+((i-1)*450) 1375 y2+((i-1)*450)]);
 end
          

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % % Add lines
 add_line(blk, 'sync/1', 'sync_delay1/1', 'autorouting', 'on');
 add_line(blk, 'sync_delay1/1', 'sync_delay2/1', 'autorouting', 'on');
 add_line(blk, 'sync_delay2/1', 'sync_delay3/1', 'autorouting', 'on');
 add_line(blk, 'sync_delay3/1', 'sync_delay4/1', 'autorouting', 'on');
 add_line(blk, 'sync_delay4/1', 'sync_delay5/1', 'autorouting', 'on');
 add_line(blk, 'sync_delay5/1', 'sync_out/1', 'autorouting', 'on');
 
for i= 1: n_input
    
    add_line(blk, 'sync/1', ['Fine_del_sub_blk',num2str(i),'/2'], 'autorouting', 'on');
    add_line(blk, 'theta_fract/1', ['Fine_del_sub_blk',num2str(i),'/1'], 'autorouting', 'on');
   
    add_line(blk, 'sync/1', ['Fringe_sub_blk',num2str(i),'/1'], 'autorouting', 'on');
    add_line(blk, 'theta_fs/1',['Fringe_sub_blk',num2str(i),'/2'], 'autorouting', 'on');
    add_line(blk, 'en_theta_fs/1', ['Fringe_sub_blk',num2str(i),'/3'], 'autorouting', 'on');
    add_line(blk, 'fft_fs/1',['Fringe_sub_blk',num2str(i),'/4'], 'autorouting', 'on');

    
     add_line(blk,['Fine_del_sub_blk',num2str(i),'/1'],['Fract_Fringe_Adder',num2str(i),'/1'], 'autorouting', 'on');
     add_line(blk,['Fringe_sub_blk',num2str(i),'/1'],['Fract_Fringe_Adder',num2str(i),'/2'], 'autorouting', 'on');
     
     add_line(blk,['Fract_Fringe_Adder',num2str(i),'/1'],['CORDIC_SINCOS',num2str(i),'/1'], 'autorouting', 'on');
%      
     add_line(blk,['CORDIC_SINCOS',num2str(i),'/1'],['Datatype_Conv_Cos',num2str(i),'/1'], 'autorouting', 'on');
     add_line(blk,['CORDIC_SINCOS',num2str(i),'/2'],['Datatype_Conv_Sine',num2str(i),'/1'], 'autorouting', 'on');
      
     add_line(blk,['pol',num2str(i-1),'_in/1'],['Input_Del',num2str(i),'/1'], 'autorouting', 'on');
     add_line(blk,['Input_Del',num2str(i),'/1'], ['c_to_ri',num2str(i),'/1'],'autorouting', 'on');
 
     add_line(blk,['c_to_ri',num2str(i),'/1'],['cmult_4bit_em',num2str(i),'/1'],'autorouting', 'on');
     add_line(blk,['c_to_ri',num2str(i),'/2'],['cmult_4bit_em',num2str(i),'/2'],'autorouting', 'on');
     add_line(blk,['Datatype_Conv_Cos',num2str(i),'/1'],['cmult_4bit_em',num2str(i),'/3'],'autorouting', 'on');
     add_line(blk,['Datatype_Conv_Sine',num2str(i),'/1'],['cmult_4bit_em',num2str(i),'/4'],'autorouting', 'on');
  
     add_line(blk,['cmult_4bit_em',num2str(i),'/1'],['Convert',num2str(i*2),'/1'],'autorouting', 'on');
     add_line(blk,['cmult_4bit_em',num2str(i),'/2'],['Convert',num2str((i*2)+1),'/1'],'autorouting', 'on');
     
     add_line(blk,['Convert',num2str(i*2),'/1'],['ri_to_c',num2str(i),'/1'],'autorouting', 'on');
     add_line(blk,['Convert',num2str((i*2)+1),'/1'],['ri_to_c',num2str(i),'/2'],'autorouting', 'on');
     
     add_line(blk,['ri_to_c',num2str(i),'/1'],['out',num2str(i-1),'/1'],'autorouting', 'on');
 
end
 
%    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
clean_blocks(blk);

% fmtstr = sprintf('Min Delay=%d',(n_inputs_bits + bram_latency+1));
% Printing at the bottom of the block fmtstr = sprintf('Min
% Delay=%d',(n_inputs_bits + bram_latency+1); %
%set_param(blk, 'AttributesFormatString', fmtstr);
 
% Save all the variables just like global variables in C
 save_state(blk, 'defaults', defaults, varargin{:});
 

