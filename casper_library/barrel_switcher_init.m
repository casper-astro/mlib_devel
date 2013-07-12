% Initialize and configure the barrel switcher.
%
% barrel_switcher_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% n_inputs = Number of inputs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
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

function barrel_switcher_init(blk, varargin)

  clog('entering barrel_switcher_init', {'trace', 'barrel_switcher_init_debug'});

  % Declare any default values for arguments you might like.
  defaults = { ...
    'n_inputs', 1, ...
    'async', 'off', ...
  };

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'barrel_switcher')
  munge_block(blk, varargin{:})

  n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
  async = get_var('async', 'defaults', defaults, varargin{:});

  delete_lines(blk);

  %default case for library storage
  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting barrel_switcher_init', {'trace', 'barrel_switcher_init_debug'});
    return;
  end

  reuse_block(blk, 'sel', 'built-in/inport', 'Position', [15 23 45 37], 'Port', '1');

  %
  % sync data path
  %

  reuse_block(blk, 'sync_in', 'built-in/inport',...
      'Position', [15 (2^n_inputs+1)*80+95 45 109+80*(2^n_inputs+1)], 'Port', '2');
  reuse_block(blk, 'sync_out', 'built-in/outport',...
      'Position', [135 (2^n_inputs+1)*80+95 165 109+80*(2^n_inputs+1)], 'Port', '1');
  reuse_block(blk, 'Delay_sync', 'xbsIndex_r4/Delay', ...
      'Position', [75 (2^n_inputs+1)*80+95 105 109+80*(2^n_inputs+1)], 'latency', num2str(n_inputs));
  add_line(blk, 'sync_in/1', 'Delay_sync/1');
  add_line(blk, 'Delay_sync/1', 'sync_out/1');

  %
  % muxes
  %

  for i=1:2^n_inputs,
      reuse_block(blk, ['In',num2str(i)], 'built-in/inport', 'Position', [15 i*80+95 45 109+80*i]);
      reuse_block(blk, ['Out',num2str(i)], 'built-in/outport', 'Position', [15+150*(n_inputs+1) 95+i*80 45+150*(n_inputs+1) 109+80*i]);
      for j=1:n_inputs,
          reuse_block(blk, ['Mux', num2str(10*i + j)], 'xbsIndex_r4/Mux', ...
              'latency', '1', 'Position', [15+150*j, 67+80*i, 40+150*j, 133+80*i]);
      end
  end
  for j=1:(n_inputs-1),
      reuse_block(blk, ['Delay', num2str(j)], 'xbsIndex_r4/Delay', ...
          'Position', [15+150*j 15 45+150*j 45]);
  end
  for j=1:n_inputs,
      reuse_block(blk, ['Slice', num2str(j)], 'xbsIndex_r4/Slice', ...
          'Position', [85+150*(j-1) 91 130+150*(j-1) 119], 'bit1', ['-', num2str(j-1)]);
  end
  add_line(blk, 'sel/1', 'Slice1/1');
  if n_inputs > 1, add_line(blk, 'sel/1', 'Delay1/1');
  end
  for j=1:(n_inputs-2),
      delayname = ['Delay', num2str(j)];
      nextdelay = ['Delay', num2str(j+1)];
      add_line(blk, [delayname, '/1'], [nextdelay, '/1']);
  end
  for j=1:(n_inputs-1),
      slicename = ['Slice', num2str(j+1)];
      delayname = ['Delay', num2str(j)];
      add_line(blk, [delayname, '/1'], [slicename, '/1']);
  end
  for j=1:n_inputs,
      slicename = ['Slice', num2str(j)];
      for i=1:2^n_inputs
          muxname = ['Mux', num2str(10*i + j)];
          add_line(blk, [slicename, '/1'], [muxname, '/1']);
      end
  end
  for i=1:2^n_inputs,
      iport = ['In', num2str(i)];
      oport = ['Out', num2str(i)];
      firstmux = ['Mux', num2str(10*i + 1)];
      if i > 2^n_inputs / 2
          swmux = ['Mux', num2str(10*(i-2^n_inputs/2) + 1)];
      else
          swmux = ['Mux', num2str(10*(i-2^n_inputs/2 + 2^n_inputs) + 1)];
      end
      lastmux = ['Mux', num2str(10*i + n_inputs)];
      add_line(blk, [iport, '/1'], [firstmux, '/2']);
      add_line(blk, [iport, '/1'], [swmux, '/3']);
      add_line(blk, [lastmux, '/1'], [oport, '/1']);
  end
  for i=1:2^n_inputs,
      for j=1:(n_inputs-1)
          muxname = ['Mux', num2str(10*i + j)];
          nextmuxname = ['Mux', num2str(10*i + j+1)];
          add_line(blk, [muxname, '/1'], [nextmuxname, '/2']);
          if i > 2^n_inputs / (2^(j+1))
              swmux = ['Mux', num2str(10*(i-2^n_inputs/(2^(j+1))) + j+1)];
          else
              swmux = ['Mux', num2str(10*(i-2^n_inputs/(2^(j+1)) + 2^n_inputs) + j+1)];
          end
          add_line(blk, [muxname, '/1'], [swmux, '/3']);
      end
  end

  %
  % data valid
  %

  if strcmp(async, 'on'),
    reuse_block(blk, 'en', 'built-in/inport',...
        'Position', [15 (2^n_inputs+2)*80+95 45 109+80*(2^n_inputs+2)], 'Port', num2str(2^n_inputs+3));
    reuse_block(blk, 'dvalid', 'built-in/outport',...
        'Position', [135 (2^n_inputs+2)*80+95 165 109+80*(2^n_inputs+2)], 'Port', num2str(2^n_inputs+2));
    reuse_block(blk, 'den', 'xbsIndex_r4/Delay', ...
        'Position', [75 (2^n_inputs+2)*80+95 105 109+80*(2^n_inputs+2)], 'latency', num2str(n_inputs));
    add_line(blk, 'en/1', 'den/1');
    add_line(blk, 'den/1', 'dvalid/1');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  
  clog('exiting barrel_switcher_init', {'trace', 'barrel_switcher_init_debug'});

end %function

