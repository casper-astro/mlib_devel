% Create a snap block for capturing snapshots in various interesting ways.
%
% snapshot_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% nsamples = size of buffer (2^nsamples)
% data_width = the data width [8, 16, 32, 64, 128] 
% use_dsp48 = Use DSP48s to implement counters
% circap = support continual capture after trigger until stop seen
% offset = support delaying capture for configurable number of samples
% value = capture value on input port at same time as data capture starts

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Meerkat telescope project                                                 %
%   http://www.kat.ac.za                                                      %
%   Copyright 2011 Andrew Martens                                             %
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

function snapshot_init(blk,varargin)

clog('entering snapshot_init', 'trace');
check_mask_type(blk, 'snapshot');
munge_block(blk, varargin{:});
defaults = {'storage', 'bram', 'dram_dimm', '1', 'dram_clock', '200', ...
  'nsamples', 10, 'data_width', '32',  'offset', 'on', ...
  'circap', 'on', 'value', 'off','use_dsp48', 'on'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('snapshot_init: post same_state', 'trace');

storage = get_var('storage', 'defaults', defaults, varargin{:});
dram_dimm = eval(get_var('dram_dimm', 'defaults', defaults, varargin{:}));
dram_clock = eval(get_var('dram_clock', 'defaults', defaults, varargin{:}));
nsamples = get_var('nsamples', 'defaults', defaults, varargin{:});
data_width = eval(get_var('data_width', 'defaults', defaults, varargin{:})); %value in drop down list
use_dsp48 = get_var('use_dsp48', 'defaults', defaults, varargin{:});
circap = get_var('circap', 'defaults', defaults, varargin{:});
offset = get_var('offset', 'defaults', defaults, varargin{:});
value = get_var('value', 'defaults', defaults, varargin{:});

%we double path width and decimate rate for DRAM
if strcmp(storage,'dram'),
  nsamples = nsamples - 1;
  data_width = 128;
end

if strcmp(storage,'dram') && ((log2(data_width/8) + nsamples + 1) > 31),
  errordlg('snapshot does not support capture of more than 1Gbytes using DRAM');
end

% useful constants
if strcmp(circap,'on'), circ = 1; else circ = 0; end
if strcmp(offset,'on'), off = 1; else off = 0; end
if strcmp(value,'on'), val = 1; else val = 0; end

delete_lines(blk);

% do the info blocks first
reuse_block(blk, 'storage',             'casper_library_misc/info_block', 'info', storage,                  'Position', [0,0,50,30]);
reuse_block(blk, 'dram_dimm',           'casper_library_misc/info_block', 'info', num2str(dram_dimm),       'Position', [0,0,50,30]);
reuse_block(blk, 'dram_clock',          'casper_library_misc/info_block', 'info', num2str(dram_clock),      'Position', [0,0,50,30]);
reuse_block(blk, 'length',              'casper_library_misc/info_block', 'info', num2str(pow2(nsamples)),  'Position', [0,0,50,30]);
reuse_block(blk, 'data_width',          'casper_library_misc/info_block', 'info', num2str(data_width),      'Position', [0,0,50,30]);
reuse_block(blk, 'start_offset',        'casper_library_misc/info_block', 'info', offset,                   'Position', [0,0,50,30]);
reuse_block(blk, 'circular_capture',    'casper_library_misc/info_block', 'info', circap,                   'Position', [0,0,50,30]);
reuse_block(blk, 'extra_value',         'casper_library_misc/info_block', 'info', value,                    'Position', [0,0,50,30]);
reuse_block(blk, 'use_dsp48',           'casper_library_misc/info_block', 'info', use_dsp48,                'Position', [0,0,50,30]);

% basic input ports
reuse_block(blk, 'din', 'built-in/inport', 'Position', [180 122 210 138], 'Port', '1');
reuse_block(blk, 'ri', 'xbsIndex_r4/Reinterpret', ...
  'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
  'force_bin_pt', 'on', 'bin_pt', '0', ...
  'Position', [240 122 300 138]); 
add_line(blk, 'din/1', 'ri/1');
reuse_block(blk, 'cast', 'xbsIndex_r4/Convert', ...
  'arith_type', 'Unsigned', 'n_bits', num2str(data_width), ...
  'bin_pt', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
  'Position', [335 122 365 138]); 
add_line(blk, 'ri/1', 'cast/1');
reuse_block(blk, 'trig', 'built-in/inport', 'Position', [250 202 280 218], 'Port', '3');
reuse_block(blk, 'we', 'built-in/inport', 'Position', [250 162 280 178], 'Port', '2');

% basic_ctrl
clog('basic_ctrl block', 'snapshot_init_detailed_trace');

if strcmp(storage,'dram'), 
  dram = 'on'; 
  word_size = 144;
else
  dram = 'off';
  word_size = data_width;
end

reuse_block(blk, 'basic_ctrl', 'casper_library_scopes/snapshot/basic_ctrl', ...
  'dram', dram, 'data_width', num2str(word_size), ...
  'Position', [395 73 455 307]);
add_line(blk, 'cast/1', 'basic_ctrl/2');
add_line(blk, 'we/1', 'basic_ctrl/3');
add_line(blk, 'trig/1', 'basic_ctrl/4');

if circ == 1
  reuse_block(blk, 'stop', 'built-in/inport', 'Position', [250 282 280 298], 'Port', '4');
  add_line(blk, 'stop/1', 'basic_ctrl/6');
else
% constant so that always stop
  reuse_block(blk, 'never', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
    'Position', [250 282 280 298]);
  add_line(blk, 'never/1', 'basic_ctrl/6');
end  

% ctrl reg
reuse_block(blk, 'const0', 'built-in/Constant', 'Value', '0', 'Position', [180 240 200 260]);
reuse_block(blk, 'ctrl', 'xps_library/software register', ...
  'io_dir', 'From Processor', 'arith_type1', 'Unsigned', ...
  'Position', [215 235 315 265]);
add_line(blk, 'const0/1', 'ctrl/1');
add_line(blk, 'ctrl/1', 'basic_ctrl/5');

% delay_block
if off == 1,
  clog('delay block', 'snapshot_init_detailed_trace');
  
  % offset register
  reuse_block(blk, 'const1', 'built-in/Constant', 'Value', '10', 'Position', [180 320 200 340]);
  reuse_block(blk, 'trig_offset', 'xps_library/software register', ...
    'io_dir', 'From Processor', 'arith_type1', 'Unsigned', ...
    'Position', [215 314 315 346]);
  add_line(blk, 'const1/1', 'trig_offset/1');

  % block doing delay
  reuse_block(blk, 'delay', 'casper_library_scopes/snapshot/delay', ...
    'word_size', num2str(data_width/8), 'use_dsp48', use_dsp48, 'Position', [530 66 590 354]);

  add_line(blk, 'basic_ctrl/1', 'delay/1'); %vin
  add_line(blk, 'basic_ctrl/2', 'delay/2'); %din
  add_line(blk, 'basic_ctrl/3', 'delay/3'); %we
  add_line(blk, 'basic_ctrl/4', 'delay/4'); %goi
  add_line(blk, 'basic_ctrl/5', 'delay/5'); %stopi 
  add_line(blk, 'basic_ctrl/6', 'delay/6'); %init  
  add_line(blk, 'trig_offset/1', 'delay/7'); %delay

else
    % don't really have anything to do if no offset 
end

% stop_gen block

reuse_block(blk, 'g_tr_en_cnt', 'built-in/Terminator', ...
  'Position', [1030 367 1045 383]);

if circ == 1,
  clog('stop_gen block', 'snapshot_init_detailed_trace');

  reuse_block(blk, 'stop_gen', 'casper_library_scopes/snapshot/stop_gen', ...
    'Position', [650 67 710 403]);
  
  %join with delay or basic_ctrl
  if off == 1, src = 'delay'; else src = 'basic_ctrl'; end 
  
  add_line(blk, [src,'/1'], 'stop_gen/1'); %vin
  add_line(blk, [src,'/2'], 'stop_gen/2'); %din
  add_line(blk, [src,'/3'], 'stop_gen/3'); %we
  add_line(blk, [src,'/4'], 'stop_gen/4'); %go
  add_line(blk, [src,'/5'], 'stop_gen/5'); %stop
  add_line(blk, [src,'/6'], 'stop_gen/6'); %init
  
  add_line(blk, 'ctrl/1', 'stop_gen/7'); %circ bit

  %tr_en_cnt register 
  reuse_block(blk, 'tr_en_cnt', 'xps_library/software register', ...
    'io_dir', 'To Processor', 'arith_type1', 'Unsigned', ...
    'Position', [905 360 1005 390]);

  add_line(blk, 'tr_en_cnt/1', 'g_tr_en_cnt/1');

else

end

%add_gen block

% address counter must be full 32 for circular capture
% as used to track offset into vector
if circ == 1,
  as = '32';
else
  as = [num2str(nsamples),'+',num2str(log2(data_width/8)),'+1'];
end

%if using DRAM, write twice per address
if strcmp(storage,'dram'),
  burst_size = 1;
else
  burst_size = 0;
end
clog('add_gen block', 'snapshot_init_detailed_trace');
reuse_block(blk, 'add_gen', 'casper_library_scopes/snapshot/add_gen', ...
  'nsamples', num2str(nsamples), 'counter_size', as, 'burst_size', num2str(burst_size), ...
  'increment', num2str(data_width/8), 'use_dsp48', use_dsp48, ...
  'Position', [770 71 830 404]);
% join to stop_gen block
if circ == 1,
  src = 'stop_gen';
% join add_gen to: delay block
elseif off == 1, 
  src = 'delay';
% or basic block
else
  src = 'basic_ctrl';
end

add_line(blk, [src,'/1'], 'add_gen/1'); %vin 
add_line(blk, [src,'/2'], 'add_gen/2'); %din 
add_line(blk, [src,'/3'], 'add_gen/3'); %we 
add_line(blk, [src,'/4'], 'add_gen/4'); %go  
add_line(blk, [src,'/5'], 'add_gen/5'); %cont 
add_line(blk, [src,'/6'], 'add_gen/6'); %init 

% status registers
reuse_block(blk, 'status', 'xps_library/software register', ...
  'io_dir', 'To Processor', 'arith_type1', 'Unsigned', ...
  'Position', [905 305 1005 335]);
add_line(blk, 'add_gen/5', 'status/1');
reuse_block(blk, 'gstatus', 'built-in/Terminator', ...
  'Position', [1030 312 1045 328]);
add_line(blk, 'status/1', 'gstatus/1');

%value in 
reuse_block(blk, 'gval', 'built-in/Terminator', ...
  'Position', [1030 92 1045 108]);
if val == 1,
  clog('value in', 'snapshot_init_detailed_trace');
  reuse_block(blk, 'vin', 'built-in/inport', 'Position', [180 82 210 98], 'Port', num2str(3+circ+1));
  add_line(blk, 'vin/1', 'basic_ctrl/1');

  % register
  reuse_block(blk, 'val', 'xps_library/software register', ...
    'io_dir', 'To Processor', 'arith_type1', 'Unsigned', ...
    'Position', [905 85 1005 115]);

  add_line(blk, 'add_gen/1', 'val/1');
  add_line(blk,'val/1', 'gval/1'); 
else %connect constant and terminate output
  
  reuse_block(blk, 'vin_const', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
    'Position', [250 82 280 98]);
  add_line(blk, 'vin_const/1', 'basic_ctrl/1');
  add_line(blk, 'add_gen/1', 'gval/1');
end

if circ == 1,
  add_line(blk, 'add_gen/6', 'tr_en_cnt/1');
else
  add_line(blk, 'add_gen/6', 'g_tr_en_cnt/1');
end

%storage
clog('storage', 'snapshot_init_detailed_trace');
reuse_block(blk, 'add_del', 'xbsIndex_r4/Delay', ...
  'latency', '1', 'Position', [880 145 905 165]);
add_line(blk, 'add_gen/2', 'add_del/1'); %add
reuse_block(blk, 'dat_del', 'xbsIndex_r4/Delay', ...
  'latency', '1', 'Position', [880 200 905 220]);
add_line(blk, 'add_gen/3', 'dat_del/1'); %data
reuse_block(blk, 'we_del', 'xbsIndex_r4/Delay', ...
  'latency', '1', 'Position', [880 255 905 275]);
add_line(blk, 'add_gen/4', 'we_del/1'); %we

if strcmp(storage, 'dram'),
  %DRAM block
  reuse_block(blk, 'dram', 'xps_library/dram', ...
    'dimm', num2str(dram_dimm), 'ip_clock', num2str(dram_clock), ...
    'disable_tag', 'on', 'use_sniffer', 'on', ...
    'Position', [1110 108 1190 377]);
  
  %inputs
  reuse_block(blk, 'rst', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
    'Position', [1075 112 1090 128]);
  add_line(blk, 'rst/1', 'dram/1');
  add_line(blk, 'add_del/1', 'dram/2');
  add_line(blk, 'dat_del/1', 'dram/3');
  %wr_be
  reuse_block(blk, 'w_all', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Unsigned', 'const', '2^18-1', ... 
    'n_bits', '18', 'bin_pt', '0', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [1045 217 1090 233]);
  add_line(blk, 'w_all/1', 'dram/4');
  %RWn
  reuse_block(blk, 'write', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Unsigned', 'const', '0', ... 
    'n_bits', '1', 'bin_pt', '0', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [1075 252 1090 268]);
  add_line(blk, 'write/1', 'dram/5');
  %cmd_tag
  reuse_block(blk, 'tag', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Unsigned', 'const', '0', ... 
    'n_bits', '32', 'bin_pt', '0', ...
    'explicit_period', 'on', 'period', '1', ...
    'Position', [1075 287 1090 303]);
  add_line(blk, 'tag/1', 'dram/6');
  %cmd_valid
  add_line(blk, 'we_del/1', 'dram/7');
  %rd_ack
  reuse_block(blk, 'always', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'const', '1', ... 
    'explicit_period', 'on', 'period', '1', ...
    'Position', [1075 357 1090 373]);
  add_line(blk, 'always/1', 'dram/8');

  %terminate outputs
  reuse_block(blk, 'gcmd_ack', 'built-in/Terminator', ...
    'Position', [1215 127 1230 143]);
  add_line(blk, 'dram/1', 'gcmd_ack/1');
  reuse_block(blk, 'gdout', 'built-in/Terminator', ...
    'Position', [1215 182 1230 198]);
  add_line(blk, 'dram/2', 'gdout/1');
  reuse_block(blk, 'grd_tag', 'built-in/Terminator', ...
    'Position', [1215 237 1230 253]);
  add_line(blk, 'dram/3', 'grd_tag/1');
  reuse_block(blk, 'grd_valid', 'built-in/Terminator', ...
    'Position', [1215 292 1230 308]);
  add_line(blk, 'dram/4', 'grd_valid/1');
  reuse_block(blk, 'ready', 'built-in/outport', ...
    'Port', '1', 'Position', [1210 347 1240 363]);
  add_line(blk, 'dram/5', 'ready/1');

else
  % shared BRAM
  reuse_block(blk, 'bram', 'xps_library/Shared BRAM', ...
    'data_width', num2str(data_width), 'addr_width', num2str(nsamples), ...
    'Position', [930 129 1005 291]);
  add_line(blk, 'add_del/1', 'bram/1');
  add_line(blk, 'dat_del/1', 'bram/2');
  add_line(blk, 'we_del/1', 'bram/3');

  reuse_block(blk, 'gbram', 'built-in/Terminator', ...
    'Position', [1030 202 1045 218]);
  add_line(blk, 'bram/1', 'gbram/1');
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('');
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting snapshot_init', 'trace');
