% mixer_init(blk, varargin)
%
% blk = The block to initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% freq_div = The (power of 2) denominator of the mixing frequency.
% freq = The numerator of the mixing frequency
% nstreams = The number of parallel streams provided
% n_bits = The bitwidth of samples out
% bram_latency = The latency of sine/cos lookup table
% mult_latency = The latency of mixer multiplier

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

function mixer_init(blk, varargin)

% Declare any default values for arguments you might like.
defaults = {'n_bits', 8, 'bram_latency', 2, 'mult_latency', 3};
check_mask_type(blk, 'mixer');
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});
freq_div      = get_var('freq_div','defaults', defaults, varargin{:});
freq          = get_var('freq','defaults', defaults, varargin{:});
nstreams      = get_var('nstreams','defaults', defaults, varargin{:});
n_bits        = get_var('n_bits','defaults', defaults, varargin{:});
bram_latency  = get_var('bram_latency','defaults', defaults, varargin{:});
mult_latency  = get_var('mult_latency','defaults', defaults, varargin{:});

if nstreams == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk,'AttributesFormatString','');
  save_state(blk, 'defaults', defaults, varargin{:});
  return;
end

counter_step = mod(nstreams * freq, freq_div);

if log2(nstreams) ~= round(log2(nstreams)),
    error_string = 'The number of inputs must be a positive power of 2 integer';
    errordlg(error_string);
end

delete_lines(blk);

reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [50 20 80 35], 'Port', '1');
reuse_block(blk, 'delay', 'xbsIndex_r4/Delay', ...
    'latency', num2str(mult_latency), 'Position', [190 20 220 50]);
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [250 20 280 35], 'Port', '1');
add_line(blk, 'sync/1', 'delay/1');
add_line(blk, 'delay/1', 'sync_out/1');

reuse_block(blk, 'dds', 'casper_library_downconverter/dds', ...
    'Position', [20 100 80 100+30*nstreams], 'num_lo', num2str(nstreams), 'freq', num2str(freq),...
    'freq_div', num2str(freq_div), 'n_bits', num2str(n_bits), 'latency','2');

if counter_step ~= 0,
    add_line(blk, 'sync/1', 'dds/1')
end

for i=1:nstreams,
    rcmult = ['rcmult',num2str(i)];
    din = ['din',num2str(i)];
    real = ['real',num2str(i)];
    imag = ['imag',num2str(i)];
    reuse_block(blk, din, 'built-in/inport', ...
        'Position', [130 i*80-10 160 5+80*i], 'Port', num2str(i+1));
    reuse_block(blk, real, 'built-in/outport', ...
        'Position', [330 i*80-10 360 5+80*i], 'Port', num2str(2*i));
    reuse_block(blk, imag, 'built-in/outport', ...
        'Position', [330 i*80+25 360 40+80*i], 'Port', num2str(2*i+1));
    reuse_block(blk, rcmult, 'casper_library_downconverter/rcmult', ...
        'Position', [230 i*80-10 280 50+80*i], 'latency', num2str(mult_latency));
    add_line(blk,[din,'/1'],[rcmult,'/1']);
    add_line(blk,['dds/',num2str(i*2-1)],[rcmult,'/2']);
    add_line(blk,['dds/',num2str(i*2)],[rcmult,'/3']);
    add_line(blk, [rcmult,'/1'], [real,'/1']);
    add_line(blk, [rcmult,'/2'], [imag,'/1']);
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('lo at -%d/%d',freq, freq_div);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});
