% Create a tree of adders.
%
% adder_tree_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% n_inputs = Number of inputs
% latency = Latency per adder

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function adder_tree_init(blk,varargin)

clog('entering adder_tree_init', 'trace');
check_mask_type(blk, 'adder_tree');

defaults = {'n_inputs', 3, 'latency', 1, 'first_stage_hdl', 'off', 'adder_imp', 'Fabric'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('adder_tree_init: post same_state', 'trace');
munge_block(blk, varargin{:});

n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
latency = get_var('latency', 'defaults', defaults, varargin{:});
first_stage_hdl = get_var('first_stage_hdl', 'defaults', defaults, varargin{:});
adder_imp = get_var('adder_imp', 'defaults', defaults, varargin{:});

hw_selection = adder_imp;

if strcmp(adder_imp,'on'), 
  first_stage_hdl = 'on'; 
end
if strcmp(adder_imp, 'Behavioral'),
  behavioral = 'on';
  hw_selection = 'Fabric';
else, 
  behavioral = 'off';
end

stages = ceil(log2(n_inputs));

delete_lines(blk);

% Take care of sync
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 10 60 25], 'Port', '1');
reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', ...
    'latency', num2str(stages*latency), 'reg_retiming', 'on', ...
    'Position', [30+50 10 60+50 40]);
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [30+(stages+1)*100 10 60+(stages+1)*100 25], ...
    'Port', '1');
add_line(blk, 'sync/1', 'sync_delay/1');
add_line(blk, 'sync_delay/1', 'sync_out/1');

% Take care of adder tree
for i=1:n_inputs,
    reuse_block(blk, ['din',num2str(i)], 'built-in/inport', 'Position', [30 i*40+20 60 35+40*i]);
end
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [30+(stages+1)*100 40 60+(stages+1)*100 55]);

% If nothing to add, connect in to out
if stages==0
    add_line(blk,'din1/1','dout/1');
else
    % Make adder tree
    cur_n = n_inputs;
    stage = 0;
    blk_cnt = 0;
    blks = {};
    while cur_n > 1,
        n_adds = floor(cur_n / 2);
        n_dlys = mod(cur_n, 2);
        cur_n = n_adds + n_dlys;
        prev_blks = blks;
        blks = {};
        stage = stage + 1;
        for j=1:cur_n,
            blk_cnt = blk_cnt + 1;
            if j <= n_adds,
                addr = ['addr',num2str(blk_cnt)];
                blks{j} = addr;
                reuse_block(blk, addr, 'xbsIndex_r4/AddSub', ...
                    'latency', num2str(latency), ...
                    'use_behavioral_HDL', behavioral, 'hw_selection', hw_selection, ...
                    'pipelined', 'on', 'use_rpm', 'on', ...
                    'Position', [30+stage*100 j*80-40 70+stage*100 j*80+20]);
                if stage == 1,
		    set_param([blk,'/',addr], 'use_behavioral_HDL', first_stage_hdl);
                    add_line(blk,['din',num2str((j*2-1)),'/1'],[addr,'/1']);
                    add_line(blk,['din',num2str((j*2)),'/1'],[addr,'/2']);
                else,
                    add_line(blk,[prev_blks{2*j-1},'/1'],[addr,'/1']);
                    add_line(blk,[prev_blks{2*j},'/1'],[addr,'/2']);
                end
            else,
                dly = ['dly',num2str(blk_cnt)];
                blks{j} = dly;
                reuse_block(blk, dly, 'xbsIndex_r4/Delay', ...
                    'latency', num2str(latency), ...
                    'reg_retiming', 'on', ...
                    'Position', [30+stage*100 j*80-40 70+stage*100 j*80+20]);
                if stage == 1,
                    add_line(blk,['din',num2str((j*2-1)),'/1'],[dly,'/1']);
                else,
                    add_line(blk,[prev_blks{2*j-1},'/1'],[dly,'/1']);
                end
            end
        end
    end
    add_line(blk,[blks{1},'/1'],['dout/1']);
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('latency %d',stages*latency);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting adder_tree_init', 'trace');
