%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   SKASA                                                                     %
%   www.kat.ac.za                                                             %
%   Copyright (C) Andrew Martens 2013                                         %
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

function delay_srl_init(blk, varargin)

  clog('entering delay_srl_init', {'trace', 'delay_srl_init_debug'});

  % Set default vararg values.
  defaults = { ...
    'DelayLen', 1, ...
    'async', 'off', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'delay_srl');
  munge_block(blk, varargin{:});

  % Retrieve values from mask fields.
  DelayLen = get_var('DelayLen', 'defaults', defaults, varargin{:});
  async = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default setup for library
  if DelayLen < 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting delay_srl_init',{'trace','delay_srl_init_debug'});
    return;
  end

  if (DelayLen > 0),
      ff_delay = 1;
      srl_delay = DelayLen - 1;
  else
      ff_delay = 0;
      srl_delay = 0;
  end

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/Inport', 'Port', '1', 'Position', [25 92 55 108]);
  
    %terminate if no delay
    if ~(DelayLen > 0), 
      reuse_block(blk, 'arnold', 'built-in/Terminator', 'Position', [80 90 100 110]);
      add_line(blk, 'en/1', 'arnold/1');
    end
  end

  reuse_block(blk, 'in', 'built-in/Inport', 'Port', '1', 'Position', [25 38 55 52]);
  prev_blk = 'in';  

  if ff_delay > 0,
    reuse_block(blk, 'delay_ff', 'xbsIndex_r4/Delay', ...
      'en', async, 'latency', num2str(ff_delay), 'Position', [80 22 125 68]);
    add_line(blk, [prev_blk,'/1'], 'delay_ff/1');
    prev_blk = 'delay_ff';

    if strcmp(async,  'on'), add_line(blk, 'en/1', 'delay_ff/2'); 
    end
  end

  if srl_delay > 0,
    reuse_block(blk, 'delay_sr', 'xbsIndex_r4/Delay', ...
      'en', async, 'latency', num2str(srl_delay), 'Position', [150 22 195 68]);
    add_line(blk, [prev_blk,'/1'], 'delay_sr/1');
    prev_blk = 'delay_sr';
    
    if strcmp(async,  'on'), add_line(blk, 'en/1', 'delay_sr/2'); 
    end
  end

  reuse_block(blk, 'out', 'built-in/Outport', 'Port', '1', 'Position', [220 38 250 52]);
  add_line(blk, [prev_blk,'/1'], 'out/1');

  % Delete all unconnected blocks.
  clean_blocks(blk);

  % Save block state to stop repeated init script runs.
  save_state(blk, 'defaults', defaults, varargin{:});
end % delay_srl_init
