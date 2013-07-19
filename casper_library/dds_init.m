% dds_init(blk, varargin)
%
% blk = The block to initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% freq_div = The (power of 2) denominator of the mixing frequency.
% freq = The numerator of the mixing frequency
% num_lo = The number of parallel streams provided
% n_bits = The bitwidth of samples out
% latency = The latency of sine/cos lookup table

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

function dds_init(blk,varargin)

% Declare any default values for arguments you might like.
defaults = {'num_lo', 1, 'n_bits', 8, 'latency', 2};
check_mask_type(blk, 'dds');
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});

freq_div = get_var('freq_div','defaults', defaults, varargin{:});
freq = get_var('freq','defaults', defaults, varargin{:});
num_lo = get_var('num_lo','defaults', defaults, varargin{:});
n_bits = get_var('n_bits','defaults', defaults, varargin{:});
latency = get_var('latency','defaults', defaults, varargin{:});

delete_lines(blk);

%default for storing in the library
if num_lo == 0,
  clean_blocks(blk);
  set_param(blk,'AttributesFormatString','');
  save_state(blk, 'defaults', defaults, varargin{:});  
  return; 
end

counter_width = log2(freq_div);
counter_step = mod(num_lo*freq,freq_div);

if num_lo < 1 || log2(num_lo) ~= round(log2(num_lo))
    error_string = 'The number of parallel LOs must be a power of 2 no less than 1';
    errordlg(error_string);
end
if freq < 0 || freq ~= round(freq)
    error_string = 'The frequency factor must be a positive integer';
    errordlg(error_string);
end

if freq_div <= 0 || freq_div < num_lo || freq_div ~= round(freq_div) || freq_div/num_lo ~= round(freq_div/num_lo) || log2(freq_div) ~= round(log2(freq_div))
    error_string = 'The frequency factor must be a positive power of 2 integer multiples of the number of LOs';
    errordlg(error_string);
end

for i = 0 : num_lo - 1,
    sin_name = ['sin',num2str(i)];
    cos_name = ['cos',num2str(i)];
    % Add ports
    reuse_block(blk, sin_name, 'built-in/outport', 'Position', [175 45+i*100 205 60+100*i]);
    reuse_block(blk, cos_name, 'built-in/outport', 'Position', [175 70+i*100 205 85+100*i]);
    % Add LOs
    if counter_step == 0,
        lo_name = ['lo_const',num2str(i)];
        reuse_block(blk, lo_name, 'casper_library_downconverter/lo_const', 'Position', [100 i*100+50 140 i*100+90], ...
            'n_bits', num2str(n_bits), 'phase', num2str(2*pi*freq*i/freq_div));
    else
        lo_name = ['lo_osc',num2str(i)];
        reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 100 60 115]);
        reuse_block(blk, lo_name, 'casper_library_downconverter/lo_osc', 'Position', [100 i*100+50 140 i*100+90], ...
            'n_bits', num2str(n_bits), 'latency', num2str(latency), ...
            'counter_width', num2str(counter_width), 'counter_start', num2str(mod(i*freq,freq_div)), ...
            'counter_step', num2str(counter_step));
         add_line(blk,['sync','/1'],[lo_name,'/1']);
    end
    add_line(blk,[lo_name,'/1'],[sin_name,'/1']);
    add_line(blk,[lo_name,'/2'],[cos_name,'/1']);  
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('lo at -%d/%d',freq, freq_div);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});   
