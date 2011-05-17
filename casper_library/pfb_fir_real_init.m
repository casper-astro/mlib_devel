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
% BitWidthOut = Output Bitwidth (0 == as needed)
% CoeffBitWidth = Bitwidth of Coefficients.
% CoeffDistMem = Implement coefficients in distributed memory
% add_latency = Latency through each adder.
% mult_latency = Latency through each multiplier
% bram_latency = Latency through each BRAM.
% conv_latency = Latency through the convert (cast) blocks. Essential if you're doing saturate/rouding logic.
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'
% fwidth = Scaling of the width of each PFB channel

clog('entering pfb_fir_real_init','trace');
% Declare any default values for arguments you might like.
defaults = {'PFBSize', 5, 'TotalTaps', 2, ...
    'WindowType', 'hamming', 'n_inputs', 1, 'MakeBiplex', 0, ...
    'BitWidthIn', 8, 'BitWidthOut', 0, 'CoeffBitWidth', 18, ...
    'CoeffDistMem', 0, 'add_latency', 1, 'mult_latency', 2, ...
    'bram_latency', 2, 'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'fwidth', 1, 'specify_mult', 'off', 'mult_spec', [2 2], ...
    'adder_folding', 'on', 'adder_imp', 'Fabric'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('pfb_fir_real_init post same_state','trace');
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
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
fwidth = get_var('fwidth', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
adder_folding = get_var('adder_folding', 'defaults', defaults, varargin{:});
adder_imp = get_var('adder_imp', 'defaults', defaults, varargin{:});

if strcmp(specify_mult, 'on') && length(mult_spec) ~= TotalTaps
    clog('Multiplier specification vector not the same as the number of taps','error');
    error('Multiplier specification vector not the same as the number of taps');
    return
end

if MakeBiplex, pols = 2;
else pols = 1;
end

% Compute the maximum gain through all of the 2^PFBSize sub-filters.  This is
% used to determine how much bit growth is really needed.  The gain of each
% filter is the sum of the absolute values of its coefficients.  The maximum of
% these gains sets the upper bound on bit growth through the pfb_fir.  The
% products, partial sums, and final sum throughout the pfb_fir (including the
% adder tree) need not accomodate any more bit growth than the absolute maximum
% gain requires, provided that any "overflow" is ignored (i.e. set to "Wrap").
% This works thanks to the wonders of modulo math.  Note that the "gain" for
% typical signals will be different (less) than the absolute maximum gain of
% each filter.  For Gaussian noise, the gain of a filter is the square root of
% the sum of the squares of the coefficients (aka root-sum-squares or RSS).

% Get all coefficients of the pfb_fir in one vector (by passing -1 for a)
all_coeffs = pfb_coeff_gen_calc(PFBSize, TotalTaps, WindowType, n_inputs, 0, fwidth, -1);
% Rearrange into matrix with 2^PFBSize rows and TotalTaps columns.
% Each row contains coefficients for one sub-filter.
all_filters = reshape(all_coeffs, 2^PFBSize, TotalTaps);
% Compute max gain (make sure it is at least 1).
% NB: sum rows, not columns!
max_gain = max(sum(abs(all_filters), 2));
if max_gain < 1; max_gain = 1; end
% Compute bit growth
bit_growth = nextpow2(max_gain);
% Compute adder output width and binary point.  We know that the adders in the
% adder tree need to have (bit_growth+1) non-fractional bits to accommodate the
% maximum gain.  The products from the taps will have
% (BitWidthIn+CoeffBitWidth-2) fractional bits.  We will preserve them through
% the adder tree.
adder_bin_pt_out = BitWidthIn+CoeffBitWidth-2;
adder_n_bits_out = bit_growth + 1 + adder_bin_pt_out;

% If BitWidthOut is 0, set it to accomodate bit growth in the
% non-fractional part and full-precision of the fractional part.
if BitWidthOut == 0
    BitWidthOut = adder_n_bits_out;
end

delete_lines(blk);

clog('adding inports and outports','pfb_fir_real_init_debug');

% Add ports
portnum = 1;
reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [0 50 30 50+15], 'Port', num2str(portnum));
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [150*(TotalTaps+4) 50*portnum*TotalTaps 150*(TotalTaps+4)+30 50*portnum*TotalTaps+15], 'Port', num2str(portnum));
for p=1:pols,
    for n=1:2^n_inputs,
        portnum = portnum + 1; % Skip one to allow sync & sync_out to be 1
        in_name = ['pol',tostring(p),'_in',tostring(n)];
        out_name = ['pol',tostring(p),'_out',tostring(n)];
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Position', [0 50*portnum*TotalTaps 30 50*portnum*TotalTaps+15], 'Port', tostring(portnum));
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Position', [150*(TotalTaps+4) 50*portnum*TotalTaps 150*(TotalTaps+4)+30 50*portnum*TotalTaps+15], 'Port', tostring(portnum));
    end
end

% Add Blocks
portnum = 0;
for p=1:pols,
    for n=1:2^n_inputs,
        portnum = portnum + 1;

        clog(['adding taps for pol ',num2str(p),' input ',num2str(n)],'pfb_fir_real_init_debug');

        for t=1:TotalTaps,
            use_hdl = 'on';
            use_embedded = 'off';
            if( strcmp(specify_mult,'on') )
                if( mult_spec(t) == 0 ),
                    use_embedded = 'off';
                elseif( mult_spec(t) == 2);
                    use_hdl = 'on';
                    use_embedded = 'off';
                end
            end

            if t==1,
                src_blk = 'casper_library_pfbs/first_tap_real';
                name = ['pol',tostring(p),'_in',tostring(n),'_first_tap'];
                reuse_block(blk, name, src_blk, ...
                    'use_hdl', tostring(use_hdl), 'use_embedded', tostring(use_embedded), ...
                    'Position', [150*t 50*portnum*TotalTaps 150*t+100 50*portnum*TotalTaps+30]);
                propagate_vars([blk,'/',name],'defaults', defaults, varargin{:});
            elseif t==TotalTaps,
                src_blk = 'casper_library_pfbs/last_tap_real';
                name = ['pol',tostring(p),'_in',tostring(n),'_last_tap'];
                reuse_block(blk, name, src_blk, ...
                    'use_hdl', tostring(use_hdl), 'use_embedded', tostring(use_embedded), ...
                    'Position', [150*t 50*portnum*TotalTaps 150*t+100 50*portnum*TotalTaps+30]);
                propagate_vars([blk,'/',name],'defaults', defaults, varargin{:});
            else
                src_blk = 'casper_library_pfbs/tap_real';
                name = ['pol',tostring(p),'_in',tostring(n),'_tap',tostring(t)];
                reuse_block(blk, name, src_blk, ...
                   'use_hdl', tostring(use_hdl), 'use_embedded', tostring(use_embedded), ...
                    'bram_latency', tostring(bram_latency), ...
                    'mult_latency', tostring(mult_latency), ...
                     'data_width', tostring(BitWidthIn), ...
                    'coeff_width', tostring(CoeffBitWidth), ...
                    'coeff_frac_width', tostring(CoeffBitWidth-1), ...
                    'delay', tostring(2^(PFBSize-n_inputs)), ...
                    'Position', [150*t 50*portnum*TotalTaps 150*t+100 50*portnum*TotalTaps+30]);
            end
%            reuse_block(blk, name, src_blk, ...
%                'Position', [150*t 50*portnum 150*t+100 50*portnum+30]);
%            propagate_vars([blk,'/',name],'defaults', defaults, varargin{:});
            if t==1,
                set_param([blk,'/',name], 'nput', tostring(n-1));
            end
        end

        clog(['adder tree, scale and convert blocks for pol ',num2str(p),' input ',num2str(n)],'pfb_fir_real_init_debug');
        %add adder tree
        reuse_block(blk, ['adder_', tostring(p), '_' ,tostring(n)], 'casper_library_misc/adder_tree', ...
            'n_inputs', tostring(TotalTaps), 'latency', tostring(add_latency), ...
            'first_stage_hdl', adder_folding, 'adder_imp', adder_imp, ...
            'Position', [150*(TotalTaps+1) 50*portnum*TotalTaps 150*(TotalTaps+1)+100 50*(portnum+1)*TotalTaps-20]);

        % Update adder blocks in the adder tree using our knowledge of maximum
        % bit growth.
        adders = find_system([blk, '/adder_', tostring(p), '_' ,tostring(n)], ...
            'LookUnderMasks','all', 'FollowLinks','on', ...
            'SearchDepth',1, 'RegExp','on', 'Name','^addr');
        for k=1:length(adders)
            set_param(adders{k}, ...
                'precision', 'User Defined', ...
                'arith_type', 'Signed  (2''s comp)', ...
                'n_bits', tostring(adder_n_bits_out), ...
                'bin_pt', tostring(adder_bin_pt_out), ...
                'quantization', 'Truncate', ...
                'overflow', 'Wrap');
        end

        %add shift, convert blocks

        % Adder tree output has bit_growth more non-fractional bits than
        % BitWidthIn, but we want to keep the same number of non-fractional
        % bits, so we must scale by 2^(-bit_growth).
        scale_factor = -bit_growth;
        reuse_block(blk, ['scale_',tostring(p),'_',tostring(n)], 'xbsIndex_r4/Scale', ...
            'scale_factor', tostring(scale_factor), ...
            'Position', [150*(TotalTaps+2) 50*(portnum+1)*TotalTaps-50 150*(TotalTaps+2)+30 50*(portnum+1)*TotalTaps-25]);
        % Because we have handled bit growth for maximum gain, there can be no
        % overflow so it can be set to "Wrap" to avoid unnecessary logic.  If
        % BitWidthOut is greater than adder_bin_pt_out, set quantization to
        % "Truncate" since there is no need to quantize.
        if BitWidthOut > adder_bin_pt_out
            quantization = 'Truncate';
        end
        reuse_block(blk, ['convert_', tostring(p),'_', tostring(n)], 'xbsIndex_r4/Convert', ...
            'arith_type', 'Signed  (2''s comp)', 'n_bits', tostring(BitWidthOut), ...
            'bin_pt', tostring(BitWidthOut-1), 'quantization', quantization, ...
            'overflow', 'Wrap', 'latency', tostring(add_latency), ...
            'latency',tostring(conv_latency), 'pipeline', 'on', ...
            'Position', [150*(TotalTaps+2)+60 50*(portnum+1)*TotalTaps-50 150*(TotalTaps+2)+90 50*(portnum+1)*TotalTaps-25]);

    end
end

clog('joining inports to blocks','pfb_fir_real_init_debug');

for p=1:pols,
    for n=1:2^n_inputs,
        in_name = ['pol',tostring(p),'_in',tostring(n)];
        blk_name = ['pol',tostring(p),'_in',tostring(n),'_first_tap'];
        out_name = ['pol',tostring(p),'_out',tostring(n)];
        adder_name = ['adder_',tostring(p),'_',tostring(n)];
        convert_name = ['convert_',tostring(p), '_',tostring(n)];
        scale_name = ['scale_',tostring(p), '_',tostring(n)];

        add_line(blk, [in_name,'/1'], [blk_name,'/1']);
        add_line(blk, 'sync/1', [blk_name,'/2']);

        if n==1 && p==1,
            reuse_block(blk, 'delay1', 'xbsIndex_r4/Delay', ...
                'latency', tostring(conv_latency), ...
                'Position', [150*(TotalTaps+2)+60 50 150*(TotalTaps+2)+90 80]);
            add_line(blk, [adder_name,'/1'], 'delay1/1');
            add_line(blk, 'delay1/1', 'sync_out/1');
        end

        add_line(blk, [adder_name,'/2'], [scale_name,'/1']);
        add_line(blk, [scale_name,'/1'], [convert_name,'/1']);
        add_line(blk, [convert_name,'/1'], [out_name,'/1']);

    end
end

clog('joining blocks to outports','pfb_fir_real_init_debug');

% Add Lines
for p=1:pols,
    for n=1:2^n_inputs,
        adder_name = ['adder_',tostring(p),'_',tostring(n)];
        for t=2:TotalTaps,
            blk_name = ['pol',tostring(p),'_in',tostring(n),'_tap',tostring(t)];

            if t == TotalTaps,
                blk_name = ['pol',tostring(p),'_in',tostring(n),'_last_tap'];
                add_line(blk, [blk_name,'/2'], [adder_name,'/1']);
                add_line(blk, [blk_name,'/1'], [adder_name,'/',tostring(t+1)]);
            end

            if t==2,
                prev_blk_name = ['pol',tostring(p),'_in',tostring(n),'_first_tap'];
            else
                prev_blk_name = ['pol',tostring(p),'_in',tostring(n),'_tap',tostring(t-1)];
            end

            for port=1:3, add_line(blk, [prev_blk_name,'/',tostring(port)], [blk_name,'/',tostring(port)]);
            end
            add_line (blk, [prev_blk_name,'/4'],[adder_name,'/',tostring(t)]);
        end
    end
end


clean_blocks(blk);

fmtstr = sprintf('taps=%d, add_latency=%d', TotalTaps, add_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting pfb_fir_real_init','trace');
