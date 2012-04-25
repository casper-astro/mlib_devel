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
% async = Run the block in asynchronous mode.
% debug_mode = Draw and set up the block up in debug mode.

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

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'pfb_coeff_gen');
munge_block(blk, varargin{:});

PFBSize = get_var('PFBSize', 'defaults', defaults, varargin{:});
CoeffBitWidth = get_var('CoeffBitWidth', 'defaults', defaults, varargin{:});
TotalTaps = get_var('TotalTaps', 'defaults', defaults, varargin{:});
CoeffDistMem = get_var('CoeffDistMem', 'defaults', defaults, varargin{:});
WindowType = get_var('WindowType', 'defaults', defaults, varargin{:});
%bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
nput = get_var('nput', 'defaults', defaults, varargin{:});
fwidth = get_var('fwidth', 'defaults', defaults, varargin{:});
async = get_var('async', 'defaults', defaults, varargin{:});
debug_mode = get_var('debug_mode', 'defaults', defaults, varargin{:});

asyncmode = false;
if strcmp(async, 'on'),
    asyncmode = true;
end

% Set coefficient vector
try
	window('hamming', 1024);
catch err
    errmsg = 'pfb_coeff_gen_init: Signal Processing Library absent or not working correctly';
	disp(errmsg);
	error(errmsg);
end
%alltaps = TotalTaps*2^PFBSize;
%windowval = transpose(window(WindowType, alltaps));
%total_coeffs = windowval .* sinc(fwidth*([0:alltaps-1]/(2^PFBSize)-TotalTaps/2));
%for i=1:alltaps/2^n_inputs,
%    buf(i)=total_coeffs((i-1)*2^n_inputs + nput + 1);
%end

delete_lines(blk);

% Add ports
reuse_block(blk, 'din',     'built-in/inport',  'Position', getsize(1, 1, 1),    'Port', '1');
reuse_block(blk, 'sync',    'built-in/inport',  'Position', getsize(2, 1, 1),     'Port', '2');
reuse_block(blk, 'dout',    'built-in/outport', 'Position', getsize(1, 7, 1),    'Port', '1');
reuse_block(blk, 'syncout', 'built-in/outport', 'Position', getsize(2, 7, 1),    'Port', '2');
reuse_block(blk, 'coeff',   'built-in/outport', 'Position', getsize(5, 7, 1),  'Port', '3');

% Add static blocks
reuse_block(blk, 'delay_sync', 'xbsIndex_r4/Delay', ...
    'latency', 'bram_latency+1', 'Position', getsize(2, 2, 2));
reuse_block(blk, 'delay_din', 'xbsIndex_r4/Delay', ...
    'latency', 'bram_latency+1', 'Position', getsize(1, 2, 2));
reuse_block(blk, 'addr_ctr', 'xbsIndex_r4/Counter', ...
    'cnt_type', 'Free Running', 'n_bits', tostring(PFBSize-n_inputs), 'arith_type', 'Unsigned', ...
    'rst', 'on', 'explicit_period', 'on', 'Position', getsize(4, 2, 3));
reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', ...
    'num_inputs', tostring(TotalTaps), 'Position', getsize(5, 5, [50, TotalTaps * 60]));
reuse_block(blk, 'Register', 'xbsIndex_r4/Register', ...
    'Position', getsize(5, 6, 2));

add_line(blk, 'din/1',          'delay_din/1');
add_line(blk, 'delay_din/1',    'dout/1');
add_line(blk, 'sync/1',         'addr_ctr/1');
add_line(blk, 'sync/1',         'delay_sync/1');
add_line(blk, 'delay_sync/1',   'syncout/1');
add_line(blk, 'Concat/1',       'Register/1');
add_line(blk, 'Register/1',     'coeff/1');

% async mode?
if asyncmode,
    set_param([blk,'/addr_ctr'], 'en', 'on');
    reuse_block(blk, 'dv',      'built-in/inport',  'Position', getsize(3, 1, 1),    'Port', '3');
    reuse_block(blk, 'dvout',   'built-in/outport', 'Position', getsize(3, 7, 1),  'Port', '4');
    reuse_block(blk, 'delay_dv', 'xbsIndex_r4/Delay', 'latency', 'bram_latency+1', 'Position', getsize(3, 2, 2));
    add_line(blk, 'dv/1',          'delay_dv/1');
    add_line(blk, 'delay_dv/1',    'dvout/1');
    add_line(blk, 'dv/1',          'addr_ctr/2');
else
    set_param([blk,'/addr_ctr'], 'en', 'off');
end

% Add dynamic blocks
startrow = 4;
for tap = 1 : TotalTaps,
    romname = ['ROM', tostring(TotalTaps + 1 - tap)];
    reintname = ['Reinterpret', tostring(TotalTaps + 1 - tap)];
    %coeff_vector = pfb_coeff_gen_calc(window_function, pfb_bits, pfb_taps, tap_num, par_bits, input_num, bin_scaling, debug)
    if strcmp(debug_mode, 'on'),
        vecstr = ['pfb_coeff_gen_calc(''', tostring(WindowType), ''', ', tostring(PFBSize), ', ', ...
            tostring(TotalTaps), ', ', tostring(tap-1), ', ', ...
            tostring(n_inputs), ', ', tostring(nput), ', ', ...
            tostring(fwidth), ', 1)'];
        atype = 'Unsigned';
        binpt = '0';
    else
        vecstr = ['pfb_coeff_gen_calc(''', tostring(WindowType), ''', ', tostring(PFBSize), ', ', ...
            tostring(TotalTaps), ', ', tostring(tap-1), ', ', ...
            tostring(n_inputs), ', ', tostring(nput), ', ', ...
            tostring(fwidth), ', 0)'];
        atype = 'Signed  (2''s comp)';
        binpt = tostring(CoeffBitWidth - 1);
    end
    %v = mat2str(buf((tap-1)*2^(PFBSize-n_inputs)+1 : tap*2^(PFBSize-n_inputs)))
    reuse_block(blk, romname, 'xbsIndex_r4/ROM', ...
        'depth', tostring(2^(PFBSize-n_inputs)), 'initVector', vecstr, 'arith_type', atype, ...
        'n_bits', tostring(CoeffBitWidth), 'bin_pt', binpt, ...
        'latency', 'bram_latency', 'use_rpm','on', 'Position', getsize(startrow + tap - 1, 3, 2));
    add_line(blk, 'addr_ctr/1', [romname, '/1']);
    reuse_block(blk, reintname, 'xbsIndex_r4/Reinterpret', 'force_arith_type', 'On', ...
        'force_bin_pt','On',...
        'Position', getsize(startrow + tap - 1, 4, 2));
    set_param([blk,'/',reintname],'arith_type','Unsigned','bin_pt','0');
    add_line(blk, [romname, '/1'], [reintname, '/1']);
    add_line(blk, [reintname, '/1'], ['Concat/', tostring(tap)]);
    
    % set coefficient ROM to use distribute memory (or not).
    if strcmp(CoeffDistMem, 'on'),
        set_param([blk, '/', romname], 'distributed_mem', 'Distributed memory');
    else
        set_param([blk, '/', romname], 'distributed_mem', 'Block RAM');
    end
end

clean_blocks(blk);

fmtstr = sprintf('PFBSize=%d, n_inputs=%d,\ntaps=%d, input=%d', PFBSize, n_inputs, TotalTaps, nput);
if strcmp(debug_mode, 'on'),
    fmtstr = [fmtstr, '\nDEBUG MODE!'];
end
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});

function rv = getsize(row, col, s)
    xs = [30, 50, 60];
    ys = [15, 30, 50];
    cols = 30:90:1000;
    rows = 30:90:1000;
    ss = size(s);
    if ss(2) == 1,
        xss = xs(s);
        yss = ys(s);
    else
        xss = s(1);
        yss = s(2);
    end
    rv = [cols(col) rows(row)-(yss/2) cols(col)+xss rows(row)+(yss/2)];
    return
