% simulates a generic CASPER-style ADC
%
% function adc_common(blk, varargin) 
%
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Collaboration for Astronomy Signal Processing and Electronics Research    %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2010 Andrew Martens SKA/SA                                  %
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

function [yoffset] = adc_common(blk, varargin)

  clog('adc_common: entering','trace');

  defaults = {'in', 1, 'out', 8, 'bits', 8, 'adc_interleave', 'off', ...
    'xoff', 0, 'xtick', 120, 'yoff', 10, 'ytick', 80, ... 
    'or_support', 'on', 'sync_support', 'on', 'dv_support', 'on', ...
    'or_per_input', 1};

  in = get_var('in', 'defaults', defaults, varargin{:});
  out = get_var('out', 'defaults', defaults, varargin{:});
  bits = get_var('bits', 'defaults', defaults, varargin{:});
  adc_interleave = get_var('adc_interleave', 'defaults', defaults, varargin{:});
  or_support = get_var('or_support', 'defaults', defaults, varargin{:});
  sync_support = get_var('sync_support', 'defaults', defaults, varargin{:});
  dv_support = get_var('dv_support', 'defaults', defaults, varargin{:});
  or_per_input = get_var('or_per_input', 'defaults', defaults, varargin{:});
  xoff = get_var('xoff', 'defaults', defaults, varargin{:});
  xtick = get_var('xtick', 'defaults', defaults, varargin{:});
  yoff = get_var('yoff', 'defaults', defaults, varargin{:});
  ytick = get_var('ytick', 'defaults', defaults, varargin{:});

  clog(['in: ',num2str(in),' out: ',num2str(out),' bits: ',num2str(bits),' adc_interleave: ',adc_interleave, ...
    ' or_support: ',or_support,' sync_support: ',sync_support,' dv_support: ',dv_support,' or_per_input: ',num2str(or_per_input)], 'adc_common_debug');

  %useful derivatives
  if strcmp(adc_interleave,'on'), il = 1; else, il = 0; end
  if strcmp(or_support,'on'), of = 1; else, of = 0; end
  if strcmp(sync_support,'on'), sync = 1; else, sync = 0; end
  if strcmp(dv_support,'on'), dv = 1; else, dv = 0; end

  %constants used in spacing blocks
%  xtick = 120; 
%  ytick = 40+5*(of*out); 
%  yoff = 0; %for relative positions  

  %data input ports
%  xoff = 0;

  yw = 3+or_per_input;  
  yoff = yoff+1+dv+sync*out;
  
  clog('doing data','adc_common_detailed_trace');
  yoff = yoff + 1;
  for d = 0:in-1

    reuse_block(blk, ['sim_data',num2str(d)], 'built-in/inport', 'Port', num2str(d+1), ...
      'Position', [xtick-15 ytick*yoff-7.5 xtick+15 ytick*yoff+7.5]);

    %gain
    clog('doing gain and offset','adc_common_detailed_trace');
    reuse_block(blk, ['gain',num2str(d)], 'built-in/gain', 'Gain', num2str((2^bits-1)/2) , 'SampleTime', '-1', ...
      'Position', [xtick*2-15 ytick*yoff-10 xtick*2+15 ytick*yoff+10]);
    add_line(blk, ['sim_data', num2str(d), '/1'], ['gain',num2str(d),'/1']);
    
    %bias
    reuse_block(blk, ['bias',num2str(d)], 'built-in/bias', 'Bias', num2str((2^bits-1)/2) , ...
      'SaturateOnIntegerOverflow', 'on', ...
      'Position', [xtick*3-15 ytick*yoff-10 xtick*3+15 ytick*yoff+10]);
    add_line(blk, ['gain', num2str(d), '/1'], ['bias',num2str(d),'/1']);

    %down sample 
    clog('down sampling','adc_common_detailed_trace');
    for ds = 0:out-1,

      %downsampler
      clog(['downsampler_',num2str(d),'_ds',num2str(ds)],'adc_common_detailed_trace');
      reuse_block(blk, ['d',num2str(d),'_ds',num2str(ds)], 'dspsigops/Downsample', ...
        'N', num2str(out), 'phase', num2str(ds), ...
        'Position', [xtick*4-20 ytick*yoff-10 xtick*4+20 ytick*yoff+10]);
      % Try to set options required for Downsample block of newer DSP blockset
      % versions, but not available in older versions.
      try
        set_param([blk, '/d',num2str(d),'_ds',num2str(ds)], ...
          'InputProcessing', 'Elements as channels (sample based)', ...
          'RateOptions', 'Allow multirate processing');
      catch
      end;

      clog(['downsampler_',num2str(d),'_ds',num2str(ds),' line'],'adc_common_detailed_trace');
      add_line(blk, ['bias',num2str(d),'/1'], ['d',num2str(d),'_ds',num2str(ds),'/1']);

      %delay
      clog(['delay_',num2str(d),'_del',num2str(ds)],'adc_common_detailed_trace');
      
      if ds == 0, NumDelays = 2; else, NumDelays = 1; end

      reuse_block(blk, ['d',num2str(d),'_del',num2str(ds)], 'simulink/Discrete/Integer Delay', ...
        'NumDelays', num2str(NumDelays), 'samptime', '-1', ...
        'Position', [xtick*5-20 ytick*yoff-10 xtick*5+20 ytick*yoff+10]);
      add_line(blk,['d',num2str(d),'_ds',num2str(ds),'/1'], ['d',num2str(d),'_del',num2str(ds),'/1']);

      %input gateways for data
      clog(['data gateway ',num2str(d*out+ds)],'adc_common_detailed_trace');
      %gateway
      if il == 1, %need to generate name as though from interleaved ADC
        d_index = d*out+floor(ds/2) + (out/2)*rem(ds,2);
      else
        d_index = d*out+ds;
      end
      name = clear_name([blk, '_user_data', num2str(d_index)]);
      reuse_block(blk, name, 'xbsIndex_r4/Gateway In', ...
        'arith_type', 'Unsigned', 'n_bits', num2str(bits), 'bin_pt', '0', ...  
        'Position', [xtick*8-20 ytick*yoff-10 xtick*8+20 ytick*yoff+10]);
      add_line(blk,['d',num2str(d),'_del',num2str(ds),'/1'], [name,'/1']);

      %convert to two's complement
      clog(['two''s complement ',num2str(d*out+ds)],'adc_common_detailed_trace');
      blk_name = ['sign',num2str(d),'_',num2str(ds)];
      reuse_block(blk, blk_name, 'xbsIndex_r4/Slice', ...
        'nbits', '1', 'mode', 'Upper Bit Location + Width', 'bit0', '0', 'base0', 'MSB of Input', ... 
        'Position', [xtick*9-15 ytick*yoff-7.5 xtick*9+15 ytick*yoff+7.5]);
      add_line(blk, [name,'/1'], [blk_name, '/1']); 
      prev = blk_name;
      inv_name = ['inv',num2str(d),'_',num2str(ds)];
      reuse_block(blk, inv_name, 'xbsIndex_r4/Inverter', ...
        'latency', '0', ... 
        'Position', [xtick*10-15 ytick*yoff-7.5 xtick*10+15 ytick*yoff+7.5]);
      add_line(blk, [prev,'/1'], [inv_name, '/1']); 
      
      blk_name = ['val',num2str(d),'_',num2str(ds)];
      reuse_block(blk, blk_name, 'xbsIndex_r4/Slice', ...
        'nbits', num2str(bits-1), 'mode', 'Lower Bit Location + Width', 'bit1', '0', 'base1', 'LSB of Input', ... 
        'Position', [xtick*9-15 ytick*(yoff+1)-7.5 xtick*9+15 ytick*(yoff+1)+7.5]);
      add_line(blk, [name,'/1'], [blk_name, '/1']); 
      prev = blk_name;
      
      blk_name = ['concat',num2str(d),'_',num2str(ds)];
      reuse_block(blk, blk_name, 'xbsIndex_r4/Concat', ...
        'num_inputs', '2', ...
        'Position', [xtick*11-15 ytick*yoff-15 xtick*11+15 ytick*yoff+15]);
      add_line(blk, [inv_name,'/1'], [blk_name, '/1']); 
      add_line(blk, [prev,'/1'], [blk_name, '/2']); 
      prev = blk_name;
      
      blk_name = ['reinterpret',num2str(d),'_',num2str(ds)];
      reuse_block(blk, blk_name, 'xbsIndex_r4/Reinterpret', ...
        'force_arith_type', 'on', 'arith_type', 'Signed  (2''s comp)', 'force_bin_pt', 'on', 'bin_pt', num2str(bits-1), ...
        'Position', [xtick*12-30 ytick*yoff-7.5 xtick*12+30 ytick*yoff+7.5]);
      add_line(blk, [prev,'/1'], [blk_name, '/1']); 
      prev = blk_name;

      %output ports
      clog(['data output port ',num2str(d*out+ds)],'adc_common_detailed_trace');
      %output
      reuse_block(blk, ['data',num2str(d),'_',num2str(ds)], 'built-in/outport', 'Port', num2str(d*(out+of*or_per_input)+ds+1), ...
        'Position', [xtick*13-15 ytick*yoff-7.5 xtick*13+15 ytick*yoff+7.5]);
      add_line(blk, [prev,'/1'], ['data',num2str(d),'_',num2str(ds),'/1']);
      
      %overflow detection
      if of == 1,
        clog('overflow','adc_common_detailed_trace');
        blk_name = ['lt',num2str(d),'_',num2str(ds)]; 
        reuse_block(blk, blk_name, 'simulink/Logic and Bit Operations/Compare To Constant', ...
          'relop', '<', 'const', '0', 'LogicOutDataTypeMode', 'boolean', ...
          'Position', [xtick*6-15 ytick*(yoff+1)-15 xtick*6+15 ytick*(yoff+1)+15]);
        add_line(blk, ['d',num2str(d),'_del',num2str(ds),'/1'], [blk_name,'/1']);
    
        blk_name = ['gt',num2str(d),'_',num2str(ds)]; 
        reuse_block(blk, blk_name, 'simulink/Logic and Bit Operations/Compare To Constant', ...
          'relop', '>', 'const', num2str((2^bits)-1), 'LogicOutDataTypeMode', 'boolean', ...
          'Position', [xtick*6-15 ytick*(yoff+2)-15 xtick*6+15 ytick*(yoff+2)+15]);
        add_line(blk, ['d',num2str(d),'_del',num2str(ds),'/1'], [blk_name,'/1']);

        if ds == out-1,
          or_name = ['logical',num2str(d)];
          reuse_block(blk, or_name, 'built-in/Logical Operator', ...
            'Inputs', num2str(out*2), 'Operator', 'OR', ...
            'Position', [xtick*7-15 ytick*(yoff+2)-15 xtick*7+15 ytick*(yoff+2)+15]);
          for ofn = 0:out-1
            add_line(blk, ['lt',num2str(d),'_',num2str(ofn),'/1'],[or_name,'/',num2str(ofn*2+1)]);
            add_line(blk, ['gt',num2str(d),'_',num2str(ofn),'/1'],[or_name,'/',num2str(ofn*2+2)]);
          end

          for of_port = 0:or_per_input-1,
            gw = clear_name([blk, '_user_outofrange', num2str(d*or_per_input+of_port)]);
            reuse_block(blk, gw, 'xbsIndex_r4/Gateway In', ...
              'arith_type', 'Boolean', ...  
              'Position', [xtick*8-20 ytick*(yoff+of_port+2)-10 xtick*8+20 ytick*(yoff+of_port+2)+10]);
            add_line(blk,[or_name,'/1'], [gw,'/1']);
            
            clog(['out of range output port ',num2str(d*or_per_input+of_port),' at ',num2str(d*(out+or_per_input)+out+of_port+1)],'adc_common_detailed_trace');
            reuse_block(blk, ['or',num2str(d*or_per_input+of_port)], 'built-in/outport', 'Port', num2str(d*(out+or_per_input)+out+of_port+1), ...
              'Position', [xtick*13-15 ytick*(yoff+2+of_port)-7.5 xtick*13+15 ytick*(yoff+2+of_port)+7.5]);
            add_line(blk, [gw,'/1'], ['or',num2str(d*or_per_input+of_port),'/1']);
          end
        end 
      end %if of
      
      yoff = yoff + yw;
    end %for ds
  end %for d

  clog(['sync '],'adc_common_detailed_trace');
  
  %sync support
  if sync == 1,
    reuse_block(blk, ['sim_sync'], 'built-in/inport', 'Port', num2str(in+1), 'Position', [xtick-15 ytick*(1+dv)-7.5 xtick+15 ytick*(dv+1)+7.5]);
    for ds = 0:out/(2^il)-1,
      reuse_block(blk, ['sync_ds',num2str(ds)], 'dspsigops/Downsample', ...
        'N', num2str(out), 'phase', num2str(ds*(2^il)), ...
        'Position', [xtick*4-20 ytick*(dv+1+ds)-10 xtick*4+20 ytick*(dv+1+ds)+10]);
      % Try to set options required for Downsample block of newer DSP blockset
      % versions, but not available in older versions.
      try
        set_param([blk, '/sync_ds',num2str(ds)], ...
          'InputProcessing', 'Elements as channels (sample based)', ...
          'RateOptions', 'Allow multirate processing');
      catch
      end;
      add_line(blk,'sim_sync/1', ['sync_ds',num2str(ds),'/1']);

      %delay
      if ds == 0, NumDelays = 2; else, NumDelays = 1; end
      reuse_block(blk, ['sync_del',num2str(ds)], 'simulink/Discrete/Integer Delay', ...
        'NumDelays', num2str(NumDelays), 'samptime', '-1', ...
        'Position', [xtick*5-20 ytick*(dv+1+ds)-10 xtick*5+20 ytick*(dv+1+ds)+10]);
      add_line(blk,['sync_ds',num2str(ds),'/1'], ['sync_del',num2str(ds),'/1']);
      
      %gateway
      name = clear_name([blk, '_user_sync', num2str(ds)]);
      reuse_block(blk, name, 'xbsIndex_r4/Gateway In', ...
        'arith_type', 'Boolean', ...  
        'Position', [xtick*8-20 ytick*(dv+1+ds)-10 xtick*8+20 ytick*(dv+1+ds)+10]);
      add_line(blk,['sync_del',num2str(ds),'/1'], [name,'/1']);

      %output
      clog(['doing sync ', num2str(ds),' at ',num2str((in*out)+(of*in*or_per_input)+(ds+1))],'adc_common_detailed_trace');
      reuse_block(blk, ['sync',num2str(ds)], 'built-in/outport', 'Port', num2str((in*out)+(of*in*or_per_input)+(ds+1)), ...
        'Position', [xtick*11-15 ytick*(dv+1+ds)-7.5 xtick*11+15 ytick*(dv+1+ds)+7.5]);
      add_line(blk, [name,'/1'], ['sync',num2str(ds),'/1']);
    end
  end
  
  clog('data valid','adc_common_detailed_trace');
  
  if dv == 1, 
    %data valid support
    clog('doing data_valid','adc_common_detailed_trace');
    reuse_block(blk, 'sim_data_valid', 'built-in/inport', 'Port', num2str(in+sync+1), 'Position', [xtick*1-15 ytick-7.5 xtick*1+15 ytick+7.5]);
    name = clear_name([blk, '_user_data_valid']);
    reuse_block(blk, name, 'xbsIndex_r4/Gateway In', ...
      'arith_type', 'Boolean', ...
      'Position', [xtick*8-20 ytick-10 xtick*8+20 ytick+10 ]);
    add_line(blk,'sim_data_valid/1', [name,'/1']);
    reuse_block(blk, 'data_valid', 'built-in/outport', 'Port', num2str(out*in+out/(2^il)*sync+(of*in*or_per_input)+1),...
      'Position', [xtick*11-15 ytick-7.5 xtick*11+15 ytick+7.5]);
      add_line(blk, [name,'/1'], 'data_valid/1');
  end

  yoffset = yoff+1; 
  
  clog('adc_common: exiting','trace');

end
