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

function pfb_fir_init(blk, varargin)
% Initialize and configure the Polyphase Filter Bank.
%
% pfb_fir_init(blk, varargin)
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
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'
% fwidth = Scaling of the width of each PFB channel
% coeffs_share = Both polarizations will share coefficients.

clog('entering pfb_fir_init','trace');

% Declare any default values for arguments you might like.
defaults = {'PFBSize', 5, 'TotalTaps', 2, ...
    'WindowType', 'hamming', 'n_inputs', 1, 'MakeBiplex', 'off', ...
    'BitWidthIn', 8, 'BitWidthOut', 0, 'CoeffBitWidth', 18, ...
    'CoeffDistMem', 'off', 'add_latency', 1, 'mult_latency', 2, ...
    'bram_latency', 2, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'fwidth', 1, 'mult_spec', [2 2], ...
    'coeffs_share', 'off', 'coeffs_fold', 'off'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('pfb_fir_init post same_state','trace');
check_mask_type(blk, 'pfb_fir');
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
fan_latency = get_var('fan_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
fwidth = get_var('fwidth', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
coeffs_share = get_var('coeffs_share', 'defaults', defaults, varargin{:});

% check the multiplier specifications first off
tap_multipliers = multiplier_specification(mult_spec, TotalTaps, blk);

% share coeffs in a 2-pol setup?
pols = 1;
share_coefficients = false;
if strcmp(MakeBiplex, 'on'),
    pols = 2;
    if strcmp(coeffs_share, 'on')
        share_coefficients = true;
    end
end

% Compute the maximum gain through all of the 2^PFBSize sub-filters.  This is
% used to determine how much bit growth is really needed.  The maximum gain of
% each filter is the sum of the absolute values of its coefficients.  The
% maximum of these gains sets the upper bound on bit growth through the
% pfb_fir.  The products, partial sums, and final sum throughout the pfb_fir
% (including the adder tree) need not accomodate any more bit growth than the
% absolute maximum gain requires, provided that any "overflow" is ignored (i.e.
% set to "Wrap").  This works thanks to the wonders of modulo math.  Note that
% the "gain" for typical signals will be different (less) than the absolute
% maximum gain of each filter.  For Gaussian noise, the gain of a filter is the
% square root of the sum of the squares of the coefficients (aka
% root-sum-squares or RSS).

% Get all coefficients of the pfb_fir in one vector (by passing -1 for a)
all_coeffs = pfb_coeff_gen_calc(PFBSize, TotalTaps, WindowType, n_inputs, 0, fwidth, -1, false);
% Rearrange into matrix with 2^PFBSize rows and TotalTaps columns.
% Each row contains coefficients for one sub-filter.
all_filters = reshape(all_coeffs, 2^PFBSize, TotalTaps);
% Compute max gain
% NB: sum rows, not columns!
max_gain = max(sum(abs(all_filters), 2));
% Compute bit growth (make sure it is non-negative)
bit_growth = max(0, nextpow2(max_gain));
% Compute adder output width and binary point.  We know that the adders in the
% adder tree need to have (bit_growth+1) non-fractional bits to accommodate the
% maximum gain.  The products from the taps will have
% (BitWidthIn+CoeffBitWidth-2) fractional bits.  We will preserve them through
% the adder tree.
adder_bin_pt_out = BitWidthIn + CoeffBitWidth - 2;
adder_n_bits_out = bit_growth + 1 + adder_bin_pt_out;

% If BitWidthOut is 0, set it to accomodate bit growth in the
% non-fractional part and full-precision of the fractional part.
if BitWidthOut == 0
    BitWidthOut = adder_n_bits_out;
end

delete_lines(blk);

% Add ports
clog('adding inports and outports', 'pfb_fir_init_debug');
portnum = 1;
reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [150*(TotalTaps+2) 50*portnum 150*(TotalTaps+2)+30 50*portnum+15], 'Port', num2str(portnum));
for p=1:pols,
    for n=1:2^n_inputs,
        portnum = portnum + 1; % Skip one to allow sync & sync_out to be 1
        in_name = ['pol',num2str(p),'_in',num2str(n)];
        out_name = ['pol',num2str(p),'_out',num2str(n)];
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Position', [150*(TotalTaps+2) 50*portnum 150*(TotalTaps+2)+30 50*portnum+15], 'Port', num2str(portnum));
    end
end

% Add blocks and Lines
portnum = 0;
for p=1:pols,
    for n=1:2^n_inputs,
        portnum = portnum + 1;
        in_name = ['pol',num2str(p),'_in',num2str(n)];
        out_name = ['pol',num2str(p),'_out',num2str(n)];
        
        % add the coefficient generators
        if (p == 2) && (share_coefficients == true)
            blk_name = [in_name,'_delay'];
            reuse_block(blk, blk_name, 'xbsIndex_r4/Delay', ...
                'latency', 'bram_latency+1+fan_latency', 'Position', [150 50*portnum 150+100 50*portnum+30]);
            add_line(blk, [in_name,'/1'], [blk_name,'/1']);
        else
            blk_name = [in_name,'_coeffs'];
            reuse_block(blk, blk_name, 'casper_library_pfbs/pfb_coeff_gen', ...
                'nput', num2str(n-1), 'CoeffDistMem', CoeffDistMem, 'Position', [150 50*portnum 150+100 50*portnum+30]);
            propagate_vars([blk,'/',blk_name], 'defaults', defaults, varargin{:});
            add_line(blk, [in_name,'/1'], [blk_name,'/1']);
            add_line(blk, 'sync/1', [blk_name,'/2']);  
        end

        clog(['adding taps for pol ', num2str(p), ' input ',num2str(n)], 'pfb_fir_init_debug');
        for t = 1:TotalTaps,
            % first tap
            if t==1,
                blk_name = [in_name,'_first_tap'];
                reuse_block(blk, blk_name, 'casper_library_pfbs/first_tap', ...
                    'use_hdl', tap_multipliers(t).use_hdl, 'use_embedded', tap_multipliers(t).use_embedded,...
                    'Position', [150*(t+1) 50*portnum 150*(t+1)+100 50*portnum+30]);
                propagate_vars([blk,'/',blk_name],'defaults', defaults, varargin{:});
                if (p == 2) && (share_coefficients == true)
                    src_block = [strrep(in_name,'pol2','pol1'),'_coeffs'];
                    data_source = [in_name,'_delay/1'];
                else
                    src_block = [in_name,'_coeffs'];
                    data_source = [src_block,'/1'];
                end
                add_line(blk, data_source, [blk_name,'/1']);
                add_line(blk, 'pol1_in1_coeffs/2', [blk_name,'/2']);
                add_line(blk, [src_block,'/3'], [blk_name,'/3']);
            % last tap
            elseif t==TotalTaps,
                blk_name = [in_name,'_last_tap'];
                reuse_block(blk, blk_name, 'casper_library_pfbs/last_tap', ...
                    'use_hdl', tap_multipliers(t).use_hdl, 'use_embedded', tap_multipliers(t).use_embedded,...
                    'Position', [150*(t+1) 50*portnum 150*(t+1)+100 50*portnum+30]);
                propagate_vars([blk,'/',blk_name],'defaults', defaults, varargin{:});
                % Update innards of the adder trees using our knowledge of
                % maximum bit growth.  This uses knowledge of the
                % implementation of the "last_tap" block.  This defeats the
                % benefits of encapsulation, but the alternative is to make the
                % underlying adder_tree block smarter and then make every block
                % that encapsulates or uses an adder_tree smarter.  Forcing
                % such a global change for one or two specific cases seems a
                % greater evil, IMHO.
                pfb_add_tree = sprintf('%s/%s/pfb_add_tree', blk, blk_name);
                for k=1:2
                    % Update adder blocks in the adder trees using our
                    % knowledge of maximum bit growth.
                    adders = find_system( ...
                        sprintf('%s/adder_tree%d', pfb_add_tree, k), ...
                        'LookUnderMasks','all', 'FollowLinks','on', ...
                        'SearchDepth',1, 'RegExp','on', 'Name','^addr');
                    for kk=1:length(adders)
                        set_param(adders{kk}, ...
                            'precision', 'User Defined', ...
                            'arith_type', 'Signed  (2''s comp)', ...
                            'n_bits', tostring(adder_n_bits_out), ...
                            'bin_pt', tostring(adder_bin_pt_out), ...
                            'quantization', 'Truncate', ...
                            'overflow', 'Wrap');
                    end
                    % Adder tree output has bit_growth more non-fractional bits
                    % than BitWidthIn, but we want to keep the same number of
                    % non-fractional bits, so we must scale by 2^(-bit_growth).
                    set_param(sprintf('%s/scale%d', pfb_add_tree, k), ...
                        'scale_factor', tostring(-bit_growth));
                    % Because we have handled bit growth for maximum gain,
                    % there can be no overflow so the convert blocks can be set
                    % to "Wrap" to avoid unnecessary logic.  If BitWidthOut is
                    % greater than adder_bin_pt_out, set their quantization to
                    % "Truncate" since there is no need to quantize.
                    if BitWidthOut > adder_bin_pt_out
                        conv_quant = 'Truncate';
                    else
                        conv_quant = quantization;
                    end
                    set_param(sprintf('%s/convert%d', pfb_add_tree, k), ...
                        'overflow', 'Wrap', 'quantization', conv_quant);
                end
                if t==2
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(n),'_first_tap'];
                else
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(n),'_tap',num2str(t-1)];
                end
                for nn=1:4
                    add_line(blk, [prev_blk_name,'/',num2str(nn)], [blk_name,'/',num2str(nn)]);
                end
                add_line(blk, [blk_name,'/1'], [out_name,'/1']);
                if n==1 && p==1
                    add_line(blk, [blk_name,'/2'], 'sync_out/1');
                end
            % intermediary taps
            else
                blk_name = ['pol',num2str(p),'_in',num2str(n),'_tap',num2str(t)];
                reuse_block(blk, blk_name, 'casper_library_pfbs/tap', ...
                    'use_hdl', tap_multipliers(t).use_hdl, 'use_embedded', tap_multipliers(t).use_embedded,...
                    'mult_latency',tostring(mult_latency), 'coeff_width', tostring(CoeffBitWidth), ...
                    'coeff_frac_width',tostring(CoeffBitWidth-1), 'delay', tostring(2^(PFBSize-n_inputs)), ...
                    'data_width',tostring(BitWidthIn), 'bram_latency', tostring(bram_latency), ...
                    'Position', [150*(t+1) 50*portnum 150*(t+1)+100 50*portnum+30]);
                if t==2,
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(n),'_first_tap'];
                else
                    prev_blk_name = ['pol',num2str(p),'_in',num2str(n),'_tap',num2str(t-1)];
                end
                for nn=1:4
                    add_line(blk, [prev_blk_name,'/',num2str(nn)], [blk_name,'/',num2str(nn)]);
                end
            end
        end
    end
end

clean_blocks(blk);

fmtstr = sprintf('taps=%d, add_latency=%d\nmax scale %.3f', ...
  TotalTaps, add_latency, max_gain*2^-bit_growth);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting pfb_fir_init','trace');
