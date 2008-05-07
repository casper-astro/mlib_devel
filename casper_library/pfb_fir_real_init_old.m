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

function pfb_fir_real_init(blk, varargin)
% Initialize and configure the Real Polyphase Filter Bank.
%
% pfb_fir_real_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% PFBSize = The size of the PFB
% TotalTaps = Total number of taps in the PFB
% WindowType = The type of windowing function to use.
% n_inputs = The number of parallel inputs
% MakeBiplex = Double up the PFB to feed a biplex FFT
% BitWidthIn = Input Bitwidth
% BitWidthOut = Output Bitwidth
% CoeffBitWidth = Bitwidth of Coefficients.
% CoeffDistMem = Implement coefficients in distributed memory
% add_latency = Latency through each adder.
% mult_latency = Latency through each multiplier
% bram_latency = Latency through each BRAM.
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'
% fwidth = Scaling of the width of each PFB channel

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'pfb_fir_real');
munge_block(blk, varargin{:});

PFBSize = get_var('PFBSize', 'defaults', defaults, varargin{:});
TotalTaps = get_var('TotalTaps', 'defaults', defaults, varargin{:});
WindowType = get_var('WindowType', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
MakeBiplex = get_var('MakeBiplex', 'defaults', defaults, varargin{:});
BitWidthIn = get_var('BitWidthIn', 'defaults', defaults, varargin{:});
BitWidthOut = get_var('BitWidthOut', 'defaults', defaults, varargin{:});
CoeffBitWidth = get_var('CoeffBitWidth', 'defaults', defaults, varargin{:});
CoeffDistMem = get_var('CoeffDistMem', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
fwidth = get_var('fwidth', 'defaults', defaults, varargin{:});

if MakeBiplex, pols = 2;
else, pols = 1;
end

delete_lines(blk);

% Add ports
portnum = 1;
reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [150*(TotalTaps+1) 50*portnum 150*(TotalTaps+1)+30 50*portnum+15], 'Port', num2str(portnum));
for p=1:pols,
    for i=1:2^n_inputs,
        portnum = portnum + 1; % Skip one to allow sync & sync_out to be 1
        in_name = ['pol',num2str(p),'_in',num2str(i)];
        out_name = ['pol',num2str(p),'_out',num2str(i)];
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Position', [150*(TotalTaps+1) 50*portnum 150*(TotalTaps+1)+30 50*portnum+15], 'Port', num2str(portnum));
    end
end

% Add Blocks
portnum = 0;
for p=1:pols,
    for i=1:2^n_inputs,
        portnum = portnum + 1;
        for t=1:TotalTaps,
            if t==1,
                src_blk = 'casper_library/PFBs/first_tap_real';
                name = ['pol',num2str(p),'_in',num2str(i),'_first_tap'];
            elseif t==TotalTaps,
                src_blk = 'casper_library/PFBs/last_tap_real';
                name = ['pol',num2str(p),'_in',num2str(i),'_last_tap'];
            else,
                src_blk = 'casper_library/PFBs/tap_real';
                name = ['pol',num2str(p),'_in',num2str(i),'_tap',num2str(t)];
            end
            reuse_block(blk, name, src_blk, ...
                'Position', [150*t 50*portnum 150*t+100 50*portnum+30]);
            propagate_vars([blk,'/',name],'defaults', defaults, varargin{:});
            if t==1,
                set_param([blk,'/',name], 'nput', num2str(i-1));
            end
        end
    end
end

% Add Lines
for p=1:pols,
    for i=1:2^n_inputs,
        for t=1:TotalTaps,
            in_name = ['pol',num2str(p),'_in',num2str(i)];
            out_name = ['pol',num2str(p),'_out',num2str(i)];
            if t==1,
                blk_name = ['pol',num2str(p),'_in',num2str(i),'_first_tap'];
                add_line(blk, [in_name,'/1'], [blk_name,'/1']);
                add_line(blk, 'sync/1', [blk_name,'/2']);
            elseif t==TotalTaps,
                blk_name = ['pol',num2str(p),'_in',num2str(i),'_last_tap'];
                if t==2,
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(i),'_first_tap'];
                else,
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(i),'_tap',num2str(t-1)];
                end
                for n=1:4, add_line(blk, [prev_blk_name,'/',num2str(n)], [blk_name,'/',num2str(n)]);
                end
                add_line(blk, [blk_name,'/1'], [out_name,'/1']);
                if i==1 && p==1, add_line(blk, [blk_name,'/2'], 'sync_out/1');
                end
            else,
                blk_name = ['pol',num2str(p),'_in',num2str(i),'_tap',num2str(t)];
                if t==2,
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(i),'_first_tap'];
                else,
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(i),'_tap',num2str(t-1)];
                end
                for n=1:4, add_line(blk, [prev_blk_name,'/',num2str(n)], [blk_name,'/',num2str(n)]);
                end
            end
        end
    end
end


clean_blocks(blk);

fmtstr = sprintf('taps=%d, add_latency=%d', TotalTaps, add_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
