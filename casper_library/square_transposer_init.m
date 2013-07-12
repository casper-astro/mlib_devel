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

function square_transposer_init(blk, varargin)
% Initialize and configure the square transposer.
%
% square_transposer_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% n_inputs = The number of inputs to be transposed.

% Declare any default values for arguments you might like.

defaults = { ...
  'n_inputs', 1, ...
  'async', 'on', ...
};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'square_transposer');
munge_block(blk, varargin{:});

n_inputs  = get_var('n_inputs', 'defaults', defaults, varargin{:});
async     = get_var('async', 'defaults', defaults, varargin{:});

ytick = 50;

if n_inputs < 0,
    error('Number of inputs must be 2^0 or greater.');
end

delete_lines(blk);

if n_inputs == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  return;
end

% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 103 45 117], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [415 58 445 72], 'Port', '1');

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/inport', 'Port', num2str(2+2^n_inputs), ...
    'Position', [15 ((2^n_inputs)+1)*ytick+153 45 167+ytick*((2^n_inputs)+1)]);
  reuse_block(blk, 'dvalid', 'built-in/outport', 'Port', num2str(2+2^n_inputs), ...
    'Position', [415 113+((2^n_inputs)*ytick) 445 127+(ytick*(2^n_inputs))]);
end

for p=0:2^n_inputs-1,
    reuse_block(blk, ['in',num2str(p)], 'built-in/inport', 'Port', num2str(2+p),...
      'Position', [15 (p*ytick)+153 45 167+(ytick*p)]);
    reuse_block(blk, ['out',num2str(p)], 'built-in/outport', 'Port', num2str(2+p),...
      'Position', [415 113+(p*ytick) 445 127+(ytick*p)]);
end

% Add blocks
reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'Position', [180 44 220 76], 'cnt_type', 'Free Running', 'n_bits', 'n_inputs', ...
    'arith_type', 'Unsigned', 'rst', 'on', 'en', async, 'operation', 'Down');
add_line(blk, 'sync/1', 'counter/1');

reuse_block(blk, 'dsync', 'casper_library_delays/delay_slr', ...
    'DelayLen', num2str(2^n_inputs - 1), 'async', async, 'Position', [370 52 400 78]);
add_line(blk, 'dsync/1', 'sync_out/1');

reuse_block(blk, 'barrel_switcher', 'casper_library_reorder/barrel_switcher', ...
    'async', async, 'n_inputs', num2str(n_inputs), 'Position', [245 22 305 22+(2^n_inputs+2)*ytick]);
add_line(blk, 'sync/1', 'barrel_switcher/2');
add_line(blk, 'counter/1', 'barrel_switcher/1');
add_line(blk, 'barrel_switcher/1', 'dsync/1');

for q=0:2^n_inputs-1,
  dport = mod(2^n_inputs - q, 2^n_inputs) + 3;
  if q ~= 0,
    df = ['df', num2str(q)];
    reuse_block(blk, df, 'casper_library_delays/delay_slr', ...
        'DelayLen', num2str(q), 'async', async,  'Position', [70 (q*ytick)+148 100 (q*ytick)+172]);
    add_line(blk, ['in', num2str(q),'/1'], [df,'/1']);
    add_line(blk, [df, '/1'], ['barrel_switcher/', num2str(dport)]);
    
    if strcmp(async, 'on'), add_line(blk, 'en/1', [df,'/2']);
    end 

  else,
    add_line(blk, ['in', num2str(q), '/1'], ['barrel_switcher/', num2str(dport)]);
  end
  if (2^n_inputs)-(q+1) ~= 0,
    db = ['db', num2str(q)];
    reuse_block(blk, db, 'casper_library_delays/delay_slr', ...
        'DelayLen', num2str((2^n_inputs)-(q+1)), 'async', async, 'Position', [370 (q*ytick)+108 400 (q*ytick)+132]);
    add_line(blk, ['barrel_switcher/',num2str(q+2)], [db,'/1']);
    add_line(blk, [db,'/1'], ['out',num2str(q),'/1']);
    if strcmp(async, 'on'), add_line(blk, ['barrel_switcher/',num2str(2^n_inputs+2)], [db,'/2']);
    end 
  else,
    add_line(blk, ['barrel_switcher/',num2str(q+2)], ['out',num2str(q),'/1']);
  end
end

if strcmp(async, 'on'),
  add_line(blk, 'en/1', 'counter/2');
  add_line(blk, 'en/1', ['barrel_switcher/',num2str(2^n_inputs+3)]);
  add_line(blk, ['barrel_switcher/',num2str(2^n_inputs+2)], 'dvalid/1');
  add_line(blk, ['barrel_switcher/',num2str(2^n_inputs+2)], 'dsync/2');
end

clean_blocks(blk);

fmtstr = sprintf('n_inputs=%d', n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
