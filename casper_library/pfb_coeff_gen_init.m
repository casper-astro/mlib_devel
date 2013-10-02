% Initialize and configure the Polyphase Filter Bank coefficient generator.
%
% pfb_coeff_gen_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% PFBSize = Size of the FFT (2^FFTSize points).
% CoeffBitWidth = Bit width of coefficients.
% TotalTaps = Total number of taps in the PFB
% CoeffDistMem = Implement coefficients in distributed memory
% WindowType = The type of windowing function to use.
% bram_latency = The latency of BRAM in the system.
% n_inputs = Number of parallel input streams
% nput = Which input this is (of the n_inputs parallel).
% fwidth = The scaling of the bin width (1 is normal).
% debug_mode = true or false, is the block being used in debug mode or not. Changes the coefficients.

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

function pfb_coeff_gen_init(blk, varargin)

% declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'pfb_coeff_gen');
munge_block(blk, varargin{:});

PFBSize         = get_var('PFBSize', 'defaults', defaults, varargin{:});
CoeffBitWidth   = get_var('CoeffBitWidth', 'defaults', defaults, varargin{:});
TotalTaps       = get_var('TotalTaps', 'defaults', defaults, varargin{:});
CoeffDistMem    = get_var('CoeffDistMem', 'defaults', defaults, varargin{:});
WindowType      = get_var('WindowType', 'defaults', defaults, varargin{:});
bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
fan_latency     = get_var('fan_latency', 'defaults', defaults, varargin{:});
n_inputs        = get_var('n_inputs', 'defaults', defaults, varargin{:});
nput            = get_var('nput', 'defaults', defaults, varargin{:});
fwidth          = get_var('fwidth', 'defaults', defaults, varargin{:});
debug_mode      = get_var('debug_mode', 'defaults', defaults, varargin{:});

% Set coefficient vector
try
	window('hamming',1024);
catch
	disp('pfb_coeff_gen_init:Signal Processing Library absent or not working correctly');
	error('pfb_coeff_gen_init:Signal Processing Library absent or not working correctly');
end
%alltaps = TotalTaps*2^PFBSize;
%windowval = transpose(window(WindowType, alltaps));
%total_coeffs = windowval .* sinc(fwidth*([0:alltaps-1]/(2^PFBSize)-TotalTaps/2));
%for i=1:alltaps/2^n_inputs,
%    buf(i)=total_coeffs((i-1)*2^n_inputs + nput + 1);
%end

delete_lines(blk);

% Add Ports
reuse_block(blk, 'din', 'built-in/inport', 'Position', [235 28 265 42], 'Port', '1');
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 93 45 107], 'Port', '2');
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [360 28 390 42], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [130 28 160 42], 'Port', '2');
reuse_block(blk, 'coeff', 'built-in/outport', 'Position', [500 343 530 357], 'Port', '3');

% Add Static Blocks
reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay', ...
    'latency', 'bram_latency+1+fan_latency', 'Position', [65 12 110 58]);
reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Free Running', 'n_bits', tostring(PFBSize-n_inputs), 'arith_type', 'Unsigned', ...
    'rst', 'on', 'explicit_period', 'on', 'Position', [65 75 115 125]);
reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', ...
    'latency', 'bram_latency+1+fan_latency', 'Position', [290 12 335 58]);
reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', ...
    'num_inputs', tostring(TotalTaps), 'Position', [360 97 415 643]);
reuse_block(blk, 'Register', 'xbsIndex_r4/Register', ...
    'Position', [435 325 480 375]);

add_line(blk, 'din/1', 'Delay1/1');
add_line(blk, 'Delay1/1', 'dout/1');
add_line(blk, 'sync/1', 'Counter/1');
add_line(blk, 'sync/1', 'Delay/1');
add_line(blk, 'Delay/1', 'sync_out/1');
add_line(blk, 'Concat/1', 'Register/1');
add_line(blk, 'Register/1', 'coeff/1');

% Add Dynamic Blocks
for a=1:TotalTaps,
    dblkname = ['fan_delay', tostring(a)];
    reuse_block(blk, dblkname, 'xbsIndex_r4/Delay', ...
    'latency', 'fan_latency', 'Position', [150 65*(a-1)+74 180 65*(a-1)+126]);
    add_line(blk, 'Counter/1', [dblkname, '/1']);
    
    if strcmp(debug_mode, 'on'),
        atype = 'Unsigned';
        binpt = '0';
        debug_option = 'true';
    else
        atype = 'Signed  (2''s comp)';
        binpt = tostring(CoeffBitWidth-1);
        debug_option = 'false';
    end
    vector_str = ['pfb_coeff_gen_calc(', tostring(PFBSize), ', ', ...
        tostring(TotalTaps), ',''', tostring(WindowType), ''',', ...
        tostring(n_inputs), ', ', tostring(nput), ',', ...
        tostring(fwidth), ',', tostring(a), ',', debug_option, ')'];
    blkname = ['ROM', tostring(a)];
    reuse_block(blk, blkname, 'xbsIndex_r4/ROM', ...
        'depth', tostring(2^(PFBSize-n_inputs)), 'initVector', vector_str, 'arith_type', atype, ...
        'n_bits', tostring(CoeffBitWidth), 'bin_pt', binpt, ...
        'latency', 'bram_latency', 'use_rpm','on', 'Position', [200 65*(a-1)+74 250 65*(a-1)+126]);

    add_line(blk, [dblkname, '/1'], [blkname, '/1']);
    reintname = ['Reinterpret', tostring(a)];
    reuse_block(blk, reintname, 'xbsIndex_r4/Reinterpret', 'force_arith_type', 'On', ...
        'force_bin_pt','On',...
        'Position', [270 65*(a-1)+84 310 65*(a-1)+116]);
    set_param([blk,'/',reintname],'arith_type','Unsigned','bin_pt','0');
    add_line(blk, [blkname, '/1'], [reintname, '/1']);
    add_line(blk, [reintname, '/1'], ['Concat/', tostring(a)]);
end

% Set coefficient ROMs to use distribute memory (or not).
for a=1:TotalTaps,
    blkname = ['ROM', tostring(a)];
    if strcmp(CoeffDistMem, 'on'),
        set_param([blk,'/',blkname], 'distributed_mem', 'Distributed memory');
    else
        set_param([blk,'/',blkname], 'distributed_mem', 'Block RAM');
    end
end

clean_blocks(blk);

fmtstr = sprintf('PFBSize=%d, n_inputs=%d,\ntaps=%d, input=%d', PFBSize, n_inputs, TotalTaps, nput);
if strcmp(debug_mode, 'on'),
    fmtstr = [fmtstr, '\nDEBUG MODE!'];
end
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});


