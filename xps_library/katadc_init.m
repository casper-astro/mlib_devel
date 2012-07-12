% katadc initialisation script 
%
% function katadc_init(blk, varargin) 
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telescope Project                                             %
%   www.ska.ac.za                                                             %
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

function katadc_init(blk, varargin)

  clog('katadc_init: pre same_state','trace');

  defaults = {'adc_brd', 'adc0', 'adc_interleave', 'off', 'bypass_auto', 'off', ...
    'en_gain', 'on', 'adc_clk_rate', 800, 'sample_period', 1};
  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  clog('katadc_init: post same_state','trace');

  check_mask_type(blk, 'katadc');
  munge_block(blk, varargin{:});
  delete_lines(blk);

  adc_interleave = get_var('adc_interleave', 'defaults', defaults, varargin{:});

  %generic ADC parameters
  if strcmp(adc_interleave, 'on'), 
    or_per_input = 2;
    in = 1;
    out = 8;
    il = 1;
  else, 
    or_per_input = 1;
    in = 2;
    out = 4;
    il = 0;
  end
  bits = 8;
  or_support = 'on'; or = 1;
  sync_support = 'on'; sync = 1;
  dv_support = 'on'; dv = 1;
  xtick = 120; 
  ytick = 40+5*(or*out); 
 
  clog('katadc_init: drawing common adc','trace');

  yoff = adc_common(blk, 'in', in, 'out', out, 'bits', bits, 'or_per_input', or_per_input, ...
    'xoff', 0, 'xtick', xtick, 'yoff', 0, 'ytick', ytick, ...
    'adc_interleave', adc_interleave, 'or_support', ...
    or_support, 'sync_support', sync_support, 'dv_support', dv_support);
  
  clog('katadc_init: done drawing common adc','trace');

  %%%% Rename generic ports to specific KATADC names %%%%%
  for input = 0:1,
    if strcmp(adc_interleave, 'off'), 
        if input == 0, 
            label = 'i';
        else, 
            label = 'q';
        end
    else,
        if input == 0, 
            label = 'q';
        else, 
            label = 'i';
        end
    end
    for offset = 0:3,
      name = clear_name([blk, '_user_data', num2str(input*4+offset)]);
      new_name = clear_name([blk, '_user_data', label, num2str(offset)]);
      old_port =  find_system(blk, 'lookUnderMasks', 'all', 'Name', new_name);
      if ~isempty(old_port),  
        delete_block(old_port{1});
      end
      port =  find_system(blk, 'lookUnderMasks', 'all', 'Name', name);
      if isempty(port), 
        clog(['katadc_init: missing data port: ', blk, '_user_data', num2str(input*4+offset)],'error');
        disp(['katadc_init: missing data port: ', blk, '_user_data', num2str(input*4+offset)]);
      else 
        set_param(port{1}, 'Name', new_name);
      end
    end
  end
 
  %%%% KATADC specific ports %%%%
  
  reuse_block(blk, 'trigger', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Unsigned', 'const', '1', 'n_bits', '1', 'bin_pt', '0', ...
    'Position', [xtick*4-15 ytick*yoff-7.5 xtick*4+15 ytick*yoff+7.5]);

  reuse_block(blk, 'en0', 'built-in/inport', 'Port', num2str(4-il+1), ... 
    'Position', [xtick*1-15 ytick*(yoff+1)-7.5 xtick*1+15 ytick*(yoff+1)+7.5]);
  reuse_block(blk, 'slc0', 'xbsIndex_r4/Slice', 'nbits', '1', 'mode', ...
    'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of input', ...
    'Position', [xtick*2-15 ytick*(yoff+1)-7.5 xtick*2+15 ytick*(yoff+1)+7.5]);
  add_line(blk, 'en0/1', 'slc0/1');
  
  reuse_block(blk, 'atten0', 'built-in/inport', 'Port', num2str(4-il+2), ...
    'Position', [xtick*1-15 ytick*(yoff+2)-7.5 xtick*1+15 ytick*(yoff+2)+7.5]);
  reuse_block(blk, 'slc1', 'xbsIndex_r4/Slice', ...
    'nbits', '6', 'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of input', ...
    'Position', [xtick*2-15 ytick*(yoff+2)-7.5 xtick*2+15 ytick*(yoff+2)+7.5]);
  add_line(blk, 'atten0/1', 'slc1/1');
  reuse_block(blk, 'inv0', 'xbsIndex_r4/Inverter', ...
    'Position', [xtick*3-15 ytick*(yoff+2)-7.5 xtick*3+15 ytick*(yoff+2)+7.5]);
  add_line(blk, 'slc1/1', 'inv0/1'); 

  %use input ports for non-interleaved mode, otherwise disable input with max attenuation on 'q' input
  if il == 0,
    en1_name = 'en1';
    atten1_name = 'atten1';
    reuse_block(blk, en1_name, 'built-in/inport', 'Port', num2str(4-il+3), ...
      'Position', [xtick*1-15 ytick*(yoff+3)-7.5 xtick*1+15 ytick*(yoff+3)+7.5]);
    reuse_block(blk, atten1_name, 'built-in/inport', 'Port', num2str(4-il+4), ...
      'Position', [xtick*1-15 ytick*(yoff+4)-7.5 xtick*1+15 ytick*(yoff+4)+7.5]);
  else
    en1_name = 'en0';
    atten1_name = 'atten0';
  end
 
  reuse_block(blk, 'slc2', 'xbsIndex_r4/Slice', ...
    'nbits', '1', 'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of input', ...
    'Position', [xtick*2-15 ytick*(yoff+3)-7.5 xtick*2+15 ytick*(yoff+3)+7.5]);
  add_line(blk, [en1_name,'/1'], 'slc2/1');
  reuse_block(blk, 'slc3', 'xbsIndex_r4/Slice', ...
    'nbits', '6', 'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of input', ...
    'Position', [xtick*2-15 ytick*(yoff+4)-7.5 xtick*2+15 ytick*(yoff+4)+7.5]);
  add_line(blk, [atten1_name,'/1'], 'slc3/1');
  reuse_block(blk, 'inv1', 'xbsIndex_r4/Inverter', ...
    'Position', [xtick*3-15 ytick*(yoff+4)-7.5 xtick*3+15 ytick*(yoff+4)+7.5]);
  add_line(blk, 'slc3/1', 'inv1/1'); 
   
  %concat block 
  reuse_block(blk, 'con', 'xbsIndex_r4/Concat', ...
    'num_inputs', '5', 'Position', [xtick*5-15 ytick*yoff-25 xtick*5+15 ytick*(yoff+4)+25]);
  add_line(blk, 'trigger/1', 'con/1');
  add_line(blk, 'slc0/1', 'con/4');
  add_line(blk, 'inv0/1', 'con/5');
  add_line(blk, 'slc2/1', 'con/2');
  add_line(blk, 'inv1/1', 'con/3');
  
  %trigger constant, combined with 0 initial value here forces load after reset
  reuse_block(blk, 'reg', 'xbsIndex_r4/Register', ...
    'init', '0', 'Position', [xtick*6-25 ytick*(yoff+2)-20 xtick*6+25 ytick*(yoff+2)+20]);
  add_line(blk, 'con/1', 'reg/1');
  
  reuse_block(blk, 'changed', 'xbsIndex_r4/Relational', 'mode', 'a!=b', 'latency', '1', ...
    'Position', [xtick*6-25 ytick*(yoff+3)-10 xtick*6+25 ytick*(yoff+4)+10]);
  add_line(blk, 'con/1', 'changed/2', 'autorouting', 'on');
  add_line(blk, 'reg/1', 'changed/1', 'autorouting', 'on');

  reuse_block(blk, 'slc4', 'xbsIndex_r4/Slice', ...
    'nbits', '14', 'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of input', ... 
    'Position', [xtick*7-15 ytick*(yoff+2)-7.5 xtick*7+15 ytick*(yoff+2)+7.5]);
  add_line(blk, 'reg/1', 'slc4/1');
  
  reuse_block(blk, 'cast0', 'xbsIndex_r4/Convert', ...
    'arith_type', 'Unsigned', 'n_bits', '14', 'bin_pt', '0', ...
    'Position', [xtick*8-25 ytick*(yoff+2)-20 xtick*8+25 ytick*(yoff+2)+20]);
  add_line(blk, 'slc4/1', 'cast0/1');
  
  gw = clear_name([blk, '_gain_value']);
  reuse_block(blk, gw, 'xbsIndex_r4/Gateway Out', ...
    'Position', [xtick*9-20 ytick*(yoff+2)-10 xtick*9+20 ytick*(yoff+2)+10]);
  add_line(blk, 'cast0/1', [gw,'/1']);

  reuse_block(blk, 'cast1', 'xbsIndex_r4/Convert', 'arith_type', 'Boolean', ...
    'Position', [xtick*8-25 ytick*(yoff+4)-20 xtick*8+25 ytick*(yoff+4)+20]);
  add_line(blk, 'changed/1', 'cast1/1');

  gw = clear_name([blk, '_gain_load']);
  reuse_block(blk, gw, 'xbsIndex_r4/Gateway Out', ...
    'Position', [xtick*9-20 ytick*(yoff+4)-10 xtick*9+20 ytick*(yoff+4)+10]);
  add_line(blk, 'cast1/1', [gw,'/1']);

  %%%%

  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

  clog('katadc_init: exiting','trace');

end
