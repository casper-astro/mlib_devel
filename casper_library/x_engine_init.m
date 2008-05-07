function x_engine_init(blk, varargin)
% Initialize and configure the CASPER X Engine.
%
% x_engine_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% n_ants = The number of antennas which are being cross-correlated.
% acc_len = The number of cycles which a multiply is accumulated before
% being output.
% use_ded_mult = Use dedicated cores for multiplying (otherwise, use
% slices).
% use_bram_delay = Implement the stage delay (acc_len) in a BRAM delay.
% n_bits = The number of bits per input sample.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {'use_ded_mult', 1, 'use_bram_delay', 1, 'n_bits', 4, ...
    'add_latency', 1, 'mult_latency', 1, 'bram_latency', 2};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'x_engine');
munge_block(blk, varargin{:});

n_ants = get_var('n_ants', 'defaults', defaults, varargin{:});
acc_len = get_var('acc_len', 'defaults', defaults, varargin{:});
use_ded_mult = get_var('use_ded_mult', 'defaults', defaults, varargin{:});
use_bram_delay = get_var('use_bram_delay', 'defaults', defaults, varargin{:});
n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

if n_ants < 2,
    error('X Engine must have at least 2 antennas.');
    set_param(blk, 'n_ants', '2');
    n_ants = 2;
end

if floor(n_ants/2 + 1) >= acc_len,
    error('X Engine Accumulation length must be > floor(n_ants/2 + 1)');
end

if length(use_ded_mult) ~= floor(n_ants/2)+1 && length(use_ded_mult) ~= 1,
    error('Number of multiplier types must be 1 or floor(n_ants/2)+1');
end    

% Begin redrawing
delete_lines(blk);
% Add taps
x = 275;
if length(use_ded_mult)==1
    set_param([blk, '/auto_tap'], 'use_ded_mult', num2str(use_ded_mult));
    for i=1:floor(n_ants/2),
        name = ['baseline_tap', num2str(i)];
        reuse_block(blk, name, 'casper_library/Correlator/baseline_tap', ...
            'ant_sep', num2str(i), 'Position', [x, 52, x+95, 168], ...
            'use_ded_mult', num2str(use_ded_mult), 'use_bram_delay', num2str(use_bram_delay));
        x = x + 135;
    end
elseif length(use_ded_mult)==floor(n_ants/2)+1
    set_param([blk, '/auto_tap'], 'use_ded_mult', num2str(use_ded_mult(1)));
    for i=1:floor(n_ants/2),
        name = ['baseline_tap', num2str(i)];
        reuse_block(blk, name, 'casper_library/Correlator/baseline_tap', ...
            'ant_sep', num2str(i), 'Position', [x, 52, x+95, 168], ...
            'use_ded_mult', num2str(use_ded_mult(i+1)), 'use_bram_delay', num2str(use_bram_delay));
        x = x + 135;
    end
end

% Add ending terminators
reuse_block(blk, 'Term1', 'built-in/Terminator', 'Position', [x, 25, x + 20, 45]);
reuse_block(blk, 'Term2', 'built-in/Terminator', 'Position', [x, 65, x + 20, 85]);
reuse_block(blk, 'Term3', 'built-in/Terminator', 'Position', [x, 105, x + 20, 125]);
% Set port positions
set_param([blk, '/acc'], 'Position', [x, 160, x + 30, 174]);
set_param([blk, '/valid'], 'Position', [x, 190, x + 30, 204]);
set_param([blk, '/sync_out'], 'Position', [x, 220, x + 30, 234]);
% Add lines
add_line(blk, 'ant/1', 'auto_tap/1', 'autorouting', 'on');
add_line(blk, 'ant/1', 'auto_tap/2', 'autorouting', 'on');
add_line(blk, 'Constant/1', 'auto_tap/4', 'autorouting', 'on');
add_line(blk, 'Constant1/1', 'auto_tap/5', 'autorouting', 'on');
add_line(blk, 'sync_in/1', 'auto_tap/6', 'autorouting', 'on');
for i=1:floor(n_ants / 2)
    if i == 1
        prevblk = 'auto_tap';
    else
        prevblk = ['baseline_tap', num2str(i-1)];
    end
    thisblk = ['baseline_tap', num2str(i)];
    add_line(blk, [prevblk, '/1'], [thisblk, '/1'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/2'], [thisblk, '/2'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/3'], [thisblk, '/3'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/4'], [thisblk, '/4'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/5'], [thisblk, '/5'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/6'], [thisblk, '/6'], 'autorouting', 'on');
    add_line(blk, [prevblk, '/7'], [thisblk, '/7'], 'autorouting', 'on');
end
i = floor(n_ants / 2);
thisblk = ['baseline_tap', num2str(i)];
add_line(blk, [thisblk, '/1'], 'auto_tap/3', 'autorouting', 'on');
add_line(blk, [thisblk, '/2'], 'Term1/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/3'], 'Term2/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/4'], 'acc/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/5'], 'valid/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/6'], 'Term3/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/7'], 'sync_out/1', 'autorouting', 'on');

clean_blocks(blk);

fmtstr = sprintf('n_ant=%d, mult=%s, bram=%d', n_ants, num2str(use_ded_mult), use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
