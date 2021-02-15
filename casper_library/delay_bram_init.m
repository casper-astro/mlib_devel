function delay_bram_init(blk, varargin)

  clog('entering delay_bram_init', {'trace', 'delay_bram_init_debug'});

  % Increment block_version whenever implementation changes require that
  % existing blocks be redrawn.  Implementation changes may also warrant the
  % incrementing of block_version for clarity/consistency even though the
  % interface change itself may force existing blocks to be redrawn.
  defaults = { ...
    'DelayLen', 0, ...
    'bram_latency', 2, ...
    'use_dsp48', 'off', ...
    'async', 'off', ...
    'block_version', 1, ...
  };
  
  check_mask_type(blk, 'delay_bram');

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  munge_block(blk, varargin{:});

  DelayLen       = get_var('DelayLen', 'defaults', defaults, varargin{:});
  bram_latency   = get_var('bram_latency', 'defaults', defaults, varargin{:});
  use_dsp48      = get_var('use_dsp48', 'defaults', defaults, varargin{:});
  async          = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default state, do nothing 
  if DelayLen == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
    clog('exiting delay_bram_init',{'trace', 'delay_bram_init_debug'});
    return;
  end
  
  % Check delay is at least 2 greater than bram latency.
  % 1 greater is not allowed because it results in a counter
  % driving the bram with max value of zero.
  if (DelayLen <= bram_latency + 1)
    clog('delay value must be greater than BRAM Latency + 1',{'error', 'delay_bram_init_debug'});
    error('delay_bram_init: delay value must be greater than BRAM Latency + 1');
    error('delay_bram_init: delay value(%i) must be greater than BRAM Latency(%i) + 1', DelayLen, bram_latency);
  end
  
  %input ports

  reuse_block(blk, 'din', 'built-in/inport', 'Port', '1', ...
      'Position', [40 113 70 127]);

  %we input to ram either from port or constant

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/inport', 'Port', '2', ...
        'Position', [40 73 70 87]);
  else
    reuse_block(blk, 'constant', 'xbsIndex_r4/Constant', ...
        'arith_type', 'Boolean', 'const', '1', ...
        'explicit_period', 'on', 'period', '1', ...
        'Position', [95 148 130 172]);
  end
  
  if strcmp(use_dsp48,'on'), 
    use_rpm = 'on'; 
    use_hdl = 'off';
    implementation = 'DSP48';
  else 
    use_rpm = 'off';
    use_hdl = 'on';
    implementation = 'Fabric';
  end

  bitwidth = max(ceil(log2(DelayLen)), 2);
  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Count Limited', 'operation', 'Up', ...
    'cnt_to', 'DelayLen - bram_latency - 1', ...
    'start_count', '0' , 'cnt_by_val', '1', ...
    'en', async, 'use_behavioral_HDL', use_hdl, ...
    'n_bits', num2str(bitwidth), ...
    'bin_pt', '0', ... 
    'use_rpm', use_rpm, 'implementation', implementation, ...
    'Position', [95 64 130 96]);
  
%   reuse_block(blk, 'ram', 'xbsIndex_r4/Single Port RAM', ...
%     'depth', num2str(2^bitwidth), 'initVector', '0', ...
%     'distributed_mem', 'Block RAM', ...
%     'write_mode', 'Read before write', 'en', async, ...
%     'optimize', 'Area', 'latency', 'bram_latency', ...
%     'Position', [150 62 215 178]);
%   add_line(blk, 'counter/1', 'ram/1');
%   add_line(blk, 'din/1', 'ram/2');
% 
%   if strcmp(async,'on'),
%     add_line(blk, 'en/1', 'counter/1');
%     add_line(blk, 'en/1', 'ram/3');
%     add_line(blk, 'en/1', 'ram/4');
%   else
%     add_line(blk, 'constant/1', 'ram/3');
%   end
% 
%   reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', ...
%       'Position', [240 113 270 127]);
%   add_line(blk, 'ram/1', 'dout/1');

  % NOTE: The commented code above is the origional draw script. The code 
  % below is to implement a fix for the Xilinx SPRAM issue when the 'en' 
  % is used (seems to be ignored and data lateches regardless). This implements
  % a Xilinx recommended work-around until the issue is fixed in a later
  % release. Current issue is with Vivado 2019.1.

  % ------------------------  Start of Fix -------------------------------

  bram_latency_ram_only = 1;
  reuse_block(blk, 'ram', 'xbsIndex_r4/Single Port RAM', ...
    'depth', num2str(2^bitwidth), 'initVector', '0', ...
    'distributed_mem', 'Block RAM', ...
    'write_mode', 'Read before write', 'en', async, ...
    'optimize', 'Area', 'latency', num2str(bram_latency_ram_only), ...
    'Position', [150 62 215 178]);
  add_line(blk, 'counter/1', 'ram/1');
  add_line(blk, 'din/1', 'ram/2');

  if strcmp(async,'on'),
    add_line(blk, 'en/1', 'counter/1');
    add_line(blk, 'en/1', 'ram/3');
    add_line(blk, 'en/1', 'ram/4');
  else
    add_line(blk, 'constant/1', 'ram/3');
  end

  bram_latency_delays_only = bram_latency-1;
  
  pos_shift = 0;
  
  for d_num = 1:bram_latency_delays_only
     delay_num = ['d' num2str(d_num)];
     
     reuse_block(blk, delay_num, 'xbsIndex_r4/Delay', ...
        'Position', [(255 + pos_shift) 113 (285 + pos_shift) 137], ...
        'latency', '1', ...
        'en', async, ...
        'reg_retiming', 'on');
   
        if strcmp(async,'on'),
          add_line(blk, 'en/1', [delay_num '/2']);
        end   
        pos_shift = pos_shift + 50;
  end

  for d_num = 1:bram_latency_delays_only
    if d_num == 1
        add_line(blk, 'ram/1', 'd1/1');            
    else
        delay_num = ['d' num2str(d_num)];
        prev_delay_num = ['d' num2str(d_num-1)];
        add_line(blk, [prev_delay_num '/1'], [delay_num '/1']);   
    end  
    
    if d_num == bram_latency_delays_only
      reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', ...
          'Position', [(255 + pos_shift) 113 (285 + pos_shift) 127]);
      add_line(blk, [delay_num '/1'], 'dout/1');        
    end
        
  end


  
%   reuse_block(blk, 'd0', 'xbsIndex_r4/Delay', ...
%     'Position', [325 113 355 137], ...
%     'latency', '1', ...
%     'en', async, ...
%     'reg_retiming', 'on');
%   add_line(blk, 'ram/1', 'd0/1');
%   add_line(blk, 'en/1', 'd0/2');
  
%   reuse_block(blk, 'd1', 'xbsIndex_r4/Delay', ...
%     'Position', [375 113 405 137], ...
%     'latency', '1', ...
%     'en', async, ...
%     'reg_retiming', 'on');
%   add_line(blk, 'd0/1', 'd1/1');
%   add_line(blk, 'en/1', 'd1/2');
  
  
  


  % --------------------------  End of Fix -------------------------------

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting delay_bram_init', {'trace','delay_bram_init_debug'});

end %function
