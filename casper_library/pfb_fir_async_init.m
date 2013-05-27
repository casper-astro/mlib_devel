%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.
%   %
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

function pfb_fir_async_init(blk, varargin)
% Initialize and configure the Polyphase Filter Bank.
%
% pfb_fir_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% pfb_bits = The size of the PFB
% total_taps = Total number of taps in the PFB
% window_type = The type of windowing function to use.
% simul_bits = The number of parallel inputs
% make_biplex = Double up the PFB to feed a biplex FFT
% data_in_bits = Input Bitwidth
% data_out_bits = Output Bitwidth (0 == as needed)
% coeff_bits = Bitwidth of Coefficients.
% coeffs_in_distmem = Implement coefficients in distributed memory
% add_latency = Latency through each adder.
% mult_latency = Latency through each multiplier
% bram_latency = Latency through each BRAM.
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'
% fwidth = Scaling of the width of each PFB channel
% coeffs_share = Both polarizations will share coefficients.
% async = Should the PFB take a data valid signal so it can function asynchronously?

clog('entering pfb_fir_async_init','trace');

autoroute = 'off';

% Declare any default values for arguments you might like.
defaults = {'pfb_bits', 5, 'total_taps', 2, ...
    'window_type', 'hamming', 'simul_bits', 1, 'make_biplex', 'off', ...
    'data_in_bits', 8, 'data_out_bits', 0, 'coeff_bits', 18, ...
    'coeffs_in_distmem', 'off', 'add_latency', 1, 'mult_latency', 2, ...
    'bram_latency', 2, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'fwidth', 1, 'mult_spec', [2 2], ...
    'coeffs_share', 'off', 'async', 'off'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('pfb_fir_async_init post same_state','trace');
check_mask_type(blk, 'pfb_fir_async');
munge_block(blk, varargin{:});

pfb_bits = get_var('pfb_bits', 'defaults', defaults, varargin{:});
total_taps = get_var('total_taps', 'defaults', defaults, varargin{:});
window_type = get_var('window_type', 'defaults', defaults, varargin{:});
simul_bits = get_var('simul_bits', 'defaults', defaults, varargin{:});
make_biplex = get_var('make_biplex', 'defaults', defaults, varargin{:});
data_in_bits = get_var('data_in_bits', 'defaults', defaults, varargin{:});
data_out_bits = get_var('data_out_bits', 'defaults', defaults, varargin{:});
coeff_bits = get_var('coeff_bits', 'defaults', defaults, varargin{:});
coeffs_in_distmem = get_var('coeffs_in_distmem', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
fan_latency = get_var('fan_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
fwidth = get_var('fwidth', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
coeffs_share = get_var('coeffs_share', 'defaults', defaults, varargin{:});
async = get_var('async', 'defaults', defaults, varargin{:});
debug_mode = get_var('debug_mode', 'defaults', defaults, varargin{:});

% check the multiplier specifications first off
tap_multipliers = multiplier_specification(mult_spec, total_taps, blk);

% async?
make_async = false;
if strcmp(async, 'on'),
    make_async = true;
end

% share coeffs in a 2-pol setup?
pols = 1;
share_coefficients = false;
if strcmp(make_biplex, 'on'),
    pols = 2;
    if strcmp(coeffs_share, 'on')
        share_coefficients = true;
    end
end

% Compute the maximum gain through all of the 2^pfb_bits sub-filters.  This is
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
all_coeffs = pfb_coeff_gen_calc(pfb_bits, total_taps, window_type, simul_bits, 0, fwidth, -1, false);
% Rearrange into matrix with 2^pfb_bits rows and total_taps columns.
% Each row contains coefficients for one sub-filter.
all_filters = reshape(all_coeffs, 2^pfb_bits, total_taps);
% Compute max gain
% NB: sum rows, not columns!
max_gain = max(sum(abs(all_filters), 2));
% Compute bit growth (make sure it is non-negative)
bit_growth = max(0, nextpow2(max_gain));
% Compute adder output width and binary point.  We know that the adders in the
% adder tree need to have (bit_growth+1) non-fractional bits to accommodate the
% maximum gain.  The products from the taps will have
% (data_in_bits+coeff_bits-2) fractional bits.  We will preserve them through
% the adder tree.
adder_bin_pt_out = data_in_bits + coeff_bits - 2;
adder_n_bits_out = bit_growth + 1 + adder_bin_pt_out;

% If data_out_bits is 0, set it to accomodate bit growth in the
% non-fractional part and full-precision of the fractional part.
if data_out_bits == 0
    data_out_bits = adder_n_bits_out;
end

delete_lines(blk);

% Add ports
clog('adding inports and outports', 'pfb_fir_init_debug');
portnum = 1;
reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [150*(total_taps+3) 50*portnum 150*(total_taps+3)+30 50*portnum+15], 'Port', num2str(portnum));
if make_async,
    portnum = 2;
    reuse_block(blk, 'dv', 'built-in/inport', ...
        'Position', [0 50*portnum 30 50*portnum+15], 'Port', num2str(portnum));
    reuse_block(blk, 'dv_out', 'built-in/outport', ...
        'Position', [150*(total_taps+3) 50*portnum 150*(total_taps+3)+30 50*portnum+15], 'Port', num2str(portnum));
    reuse_block(blk, 'dv_delay', 'xbsIndex_r4/Delay', ...
                'latency', 'bram_latency+1', 'Position', [75 50*portnum 100 50*portnum+15]);
    add_line(blk, 'dv/1', 'dv_delay/1', 'autorouting', autoroute);
end
for p=1:pols,
    for n=1:2^simul_bits,
        portnum = portnum + 1;
        in_name = ['pol',num2str(p),'_in',num2str(n)];
        out_name = ['pol',num2str(p),'_out',num2str(n)];
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Position', [0 150*portnum 30 150*portnum+15], 'Port', num2str(portnum));
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Position', [150*(total_taps+3) 150*portnum 150*(total_taps+3)+30 150*portnum+15], 'Port', num2str(portnum));
    end
end

% add the coefficient generators - one per port
portnum = 0;
x_size = 100;
y_size = 100;
for p = 1 : pols,
    for n = 1 : 2^simul_bits,
        portnum = portnum + 1;
        in_name = ['pol',num2str(p),'_in',num2str(n)];
        if (p == 2) && (share_coefficients == true)
            blk_name = [in_name,'_delay'];
            reuse_block(blk, blk_name, 'xbsIndex_r4/Delay', ...
                'latency', 'bram_latency+1+fan_latency', 'Position', [150 150*portnum 150+x_size 150*portnum+y_size]);
            add_line(blk, [in_name,'/1'], [blk_name,'/1'], 'autorouting', autoroute);
        else
            blk_name = [in_name,'_coeffs'];
            reuse_block(blk, blk_name, 'casper_library_pfbs/pfb_coeff_gen', ...
                'PFBSize', tostring(pfb_bits), 'CoeffBitWidth', tostring(coeff_bits), ...
                'TotalTaps', tostring(total_taps), ...
                'CoeffDistMem', coeffs_in_distmem, ...
                'WindowType', window_type, ...
                'n_inputs', tostring(simul_bits), ...
                'nput', num2str(n-1), ...
                'Position', [150 150*portnum 150+x_size 150*portnum+y_size]);
            propagate_vars([blk,'/',blk_name], 'defaults', defaults, varargin{:});
            add_line(blk, [in_name,'/1'], [blk_name,'/1'], 'autorouting', autoroute);
            add_line(blk, 'sync/1', [blk_name,'/2'], 'autorouting', autoroute);
        end
    end
end
        
% Add taps and lines
portnum = 0;
for p = 1:pols,
    for n = 1:2^simul_bits,
        portnum = portnum + 1;
        in_name = ['pol',num2str(p),'_in',num2str(n)];
        out_name = ['pol',num2str(p),'_out',num2str(n)];
        clog(['adding taps for pol ', num2str(p), ' input ',num2str(n)], 'pfb_fir_init_debug');
        for t = 1:total_taps,
            % not last tap
            if t ~= total_taps,
                blk_name = [in_name, '_tap', tostring(t)];
                reuse_block(blk, blk_name, 'casper_library_pfbs/tap_async', ...
                    'use_hdl', tap_multipliers(t).use_hdl, 'use_embedded', tap_multipliers(t).use_embedded,...
                    'this_tap',tostring(t),...
                    'Position', [150*(t+1) 150*portnum 150*(t+1)+x_size 150*portnum+y_size]);
                propagate_vars([blk,'/',blk_name],'defaults', defaults, varargin{:});
                if t == 1,
                    if (p == 2) && (share_coefficients == true)
                        src_block = [strrep(in_name,'pol2','pol1'),'_coeffs'];
                        data_source = [in_name,'_delay/1'];
                    else
                        src_block = [in_name,'_coeffs'];
                        data_source = [src_block,'/1'];
                    end
                    add_line(blk, data_source, [blk_name,'/1'], 'autorouting', autoroute);
                    add_line(blk, 'pol1_in1_coeffs/2', [blk_name,'/2'], 'autorouting', autoroute);
                    add_line(blk, [src_block,'/3'], [blk_name,'/3'], 'autorouting', autoroute);
                    if make_async,
                        add_line(blk, 'dv_delay/1', [blk_name,'/4'], 'autorouting', autoroute);
                    end
                end
            else
                blk_name = [in_name,'_last_tap'];
                reuse_block(blk, blk_name, 'casper_library_pfbs/last_tap_async', ...
                    'use_hdl', tap_multipliers(t).use_hdl, 'use_embedded', tap_multipliers(t).use_embedded,...
                    'input_num', num2str(portnum), ...
                    'Position', [150*(t+1) 150*portnum 150*(t+1)+x_size 150*portnum+y_size]);
                propagate_vars([blk,'/',blk_name],'defaults', defaults, varargin{:});
                % Update innards of the adder trees using our knowledge of
                % maximum bit growth.  This uses knowledge of the
                % implementation of the "last_tap" block.  This defeats the
                % benefits of encapsulation, but the alternative is to make the
                % underlying adder_tree block smarter and then make every block
                % that encapsulates or uses an adder_tree smarter.  Forcing
                % such a global change for one or two specific cases seems a
                % greater evil, IMHO.
                pfb_add_tree = sprintf('%s/%s/pfb_add_tree_async', blk, blk_name);
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
                    % than data_in_bits, but we want to keep the same number of
                    % non-fractional bits, so we must scale by 2^(-bit_growth).
                    set_param(sprintf('%s/scale%d', pfb_add_tree, k), ...
                        'scale_factor', tostring(-bit_growth));
                    % Because we have handled bit growth for maximum gain,
                    % there can be no overflow so the convert blocks can be set
                    % to "Wrap" to avoid unnecessary logic.  If data_out_bits is
                    % greater than adder_bin_pt_out, set their quantization to
                    % "Truncate" since there is no need to quantize.
                    if data_out_bits > adder_bin_pt_out
                        conv_quant = 'Truncate';
                    else
                        conv_quant = quantization;
                    end
                    set_param(sprintf('%s/convert%d', pfb_add_tree, k), ...
                        'overflow', 'Wrap', 'quantization', conv_quant);
                end
                % join dataout, dv and sync
                add_line(blk, [blk_name,'/1'], [out_name,'/1'], 'autorouting', autoroute);
                if n==1 && p==1
                    add_line(blk, [blk_name,'/2'], 'sync_out/1', 'autorouting', autoroute);
                    add_line(blk, [blk_name,'/3'], 'dv_out/1', 'autorouting', autoroute);
                end
            end
            % join all the taps together
            if t > 1
                for ctr = 1 : 5,
                    add_line(blk, [in_name, '_tap', tostring(t-1), '/', tostring(ctr)], [blk_name, '/', tostring(ctr)], 'autorouting', autoroute);
                end
            end
        end
    end
end

% the sync generate block
delete_line(blk, ['pol1_in1_tap', tostring(total_taps-1), '/2'], 'pol1_in1_last_tap/2');
add_line(blk, 'sync_generate/1', 'pol1_in1_last_tap/2', 'autorouting', autoroute);
add_line(blk, 'pol1_in1_coeffs/2', 'sync_generate/1', 'autorouting', autoroute);
add_line(blk, 'dv_delay/1', 'sync_generate/2', 'autorouting', autoroute);

% add the adder trees
%portnum = 0;
%for p = 1 : pols,
%    for n = 1 : 2^simul_bits,
%        tree_name = ['adder', tostring(n), tostring(p)];
%        reuse_block(blk, tree_name, 'casper_library_pfbs/pfb_add_tree', ...
%            'use_hdl', tostring(use_hdl), 'use_embedded', tostring(use_embedded),...
%            'Position', [150*(total_taps+2) 150*portnum 150*(total_taps+2)+x_size 150*portnum+y_size]);
%        %propagate_vars([blk,'/',blk_name],'defaults', defaults,
%        %varargin{:});
%        add_line(blk, [tree_name, '/1'], ['pol',tostring(p),'_out',tostring(n),'/1'], 'autorouting', autoroute);
%    end
%end

clean_blocks(blk);

debug_string = '';
if strcmp(debug_mode, 'on'),
    debug_string = '\n-*-*-*-*-*-*-*-\nDEBUG MODE!!\n-*-*-*-*-*-*-*-';
end
fmtstr = [sprintf('taps=%d, add_latency=%d\nmax scale %.3f', ...
  total_taps, add_latency, max_gain*2^-bit_growth), debug_string];
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting pfb_fir_init','trace');
