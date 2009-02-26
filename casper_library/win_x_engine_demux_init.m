function win_x_engine_demux_init(blk, varargin)
% Initialize and configure the windowed CASPER X Engine with configurable output demux.
%

% Declare any default values for arguments you might like.
defaults = {'use_ded_mult', 1, 'use_bram_delay', 1, 'demux_factor', 4, 'n_bits', 4, ...
    'add_latency', 1, 'mult_latency', 1, 'bram_latency', 2};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'win_x_engine_demux');
munge_block(blk, varargin{:});

%fprintf('starting variables processing\n');

n_ants = get_var('n_ants', 'defaults', defaults, varargin{:});
acc_len = get_var('acc_len', 'defaults', defaults, varargin{:});
use_ded_mult = get_var('use_ded_mult', 'defaults', defaults, varargin{:});
use_bram_delay = get_var('use_bram_delay', 'defaults', defaults, varargin{:});
n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
demux_factor = get_var('demux_factor', 'defaults', defaults, varargin{:});

xeng_delay = add_latency + mult_latency + acc_len + floor(n_ants/2 + 1) + 1;
bit_growth = ceil(log2(acc_len));
ant_bits = ceil(log2(n_ants));
n_bits_xeng_out = (2*n_bits + 1 + bit_growth);
n_bits_scaled_out = 2^(ceil(log2(n_bits_xeng_out)))

if n_ants < 2,
    errordlg('X engine ERR: X Engine must have at least 2 antennas.');
    error('X Engine must have at least 2 antennas.');
    set_param(blk, 'n_ants', '2');
    n_ants = 2;
end

if floor(n_ants/2 + 1) >= acc_len,
    errordlg(sprintf('X engine ERR: X Engine Accumulation length must be > floor(n_ants/2 + 1)=%i',floor(n_ants/2 + 1)));
    error(sprintf('X Engine Accumulation length must be > floor(n_ants/2 + 1)=%i',floor(n_ants/2 + 1)));
    set_param(blk, 'acc_len', sprintf('%i',floor(n_ants/2 + 1)));
    acc_len = floor(n_ants/2 + 1);
end

if length(use_ded_mult) ~= floor(n_ants/2)+1 && length(use_ded_mult) ~= 1,
    errordlg(sprintf('X engine ERR: Number of multiplier types must be 1 or floor(n_ants/2)+1 = %i',floor(n_ants/2 + 1)));
    error(sprintf('X engine ERR: Number of multiplier types must be 1 or floor(n_ants/2)+1 = %i',floor(n_ants/2 + 1)));
    set_param(blk,'use_ded_mult','1');
    use_ded_mult=1;
    
end    

%fprintf('variables all done\n');

% Begin redrawing
%================

delete_lines(blk);

% Add taps
x = 275;
if length(use_ded_mult)==1
    reuse_block(blk, 'auto_tap', 'casper_library/Correlator/auto_tap',...
                'Position',[135, 51, 230, 169],...
                'use_ded_mult', num2str(use_ded_mult));
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

% Add Misc static blocks

reuse_block(blk, 'x_cast', 'casper_library/Correlator/x_cast', 'Position', [x + 100, 100, x + 150, 125]);
reuse_block(blk, 'xeng_mask_demux', 'casper_library/Correlator/xeng_mask_demux', 'Position', [x + 200, 105, x + 300, 163]);
reuse_block(blk, 'xeng_conj_fix', 'casper_library/Correlator/xeng_conj_fix', 'Position', [x + 350, 105, x + 450, 163]);

reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', 'Position', [15,89,85,121],...
            'const','0',...
            'arith_type','Unsigned',...
            'n_bits',sprintf('%d',8 * n_bits_xeng_out));
        
reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', 'Position', [15,124,85,156],...
            'const','0',...
            'arith_type','Boolean',...
            'n_bits','1');
        
reuse_block(blk, 'Logical', 'xbsIndex_r4/Logical', 'Position', [x + 50, 130, x + 80, 150],...
                'latency','0',...
                'logical_function','AND');
            
reuse_block(blk, 'window_delay', 'casper_library/Delays/window_delay',...
            'Position', [135, 200, x-135+95, 230], ...
            'delay',num2str(xeng_delay));
        

% Add ending terminators
reuse_block(blk, 'Term1', 'built-in/Terminator', 'Position', [x, 25, x + 20, 45]);
reuse_block(blk, 'Term2', 'built-in/Terminator', 'Position', [x, 65, x + 20, 85]);
reuse_block(blk, 'Term3', 'built-in/Terminator', 'Position', [x, 130, x + 20, 150]);
     
% Set output port positions
reuse_block(blk, 'sync_out', 'built-in/outport','Position', [x + 500, 160, x + 530, 174]);
reuse_block(blk, 'acc', 'built-in/outport','Position', [x + 500, 100, x + 530, 114]);
reuse_block(blk, 'valid', 'built-in/outport','Position', [x + 500, 130, x + 530, 144]);

% Set input port positions
reuse_block(blk, 'sync_in', 'built-in/inport','Position', [55,178,85,192]);
reuse_block(blk, 'ant', 'built-in/inport','Position', [55,53,85,67]);
reuse_block(blk, 'window_valid', 'built-in/inport','Position', [55,223,85,237]);


% Add lines
%==========
add_line(blk, 'ant/1', 'auto_tap/1', 'autorouting', 'on');
add_line(blk, 'ant/1', 'auto_tap/2', 'autorouting', 'on');
add_line(blk, 'Constant/1', 'auto_tap/4', 'autorouting', 'on');
add_line(blk, 'Constant1/1', 'auto_tap/5', 'autorouting', 'on');
add_line(blk, 'sync_in/1', 'auto_tap/6', 'autorouting', 'on');
add_line(blk, 'window_valid/1', 'window_delay/1', 'autorouting', 'on');
add_line(blk, 'window_delay/1', 'Logical/2', 'autorouting', 'on');
add_line(blk, 'Logical/1', 'xeng_mask_demux/2', 'autorouting', 'on');
add_line(blk, 'x_cast/1', 'xeng_mask_demux/1', 'autorouting', 'on');

add_line(blk, 'xeng_mask_demux/1', 'xeng_conj_fix/1', 'autorouting', 'on');
add_line(blk, 'xeng_mask_demux/2', 'xeng_conj_fix/2', 'autorouting', 'on');
add_line(blk, 'xeng_mask_demux/3', 'xeng_conj_fix/3', 'autorouting', 'on');

add_line(blk, 'xeng_conj_fix/3', 'sync_out/1', 'autorouting', 'on');
add_line(blk, 'xeng_conj_fix/1', 'acc/1', 'autorouting', 'on');
add_line(blk, 'xeng_conj_fix/2', 'valid/1', 'autorouting', 'on');

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
add_line(blk, [thisblk, '/4'], 'x_cast/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/5'], 'Logical/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/6'], 'Term3/1', 'autorouting', 'on');
add_line(blk, [thisblk, '/7'], 'xeng_mask_demux/3', 'autorouting', 'on');

%fprintf('setting block parameters...\n');

% Set Params
set_param([blk, '/x_cast'], 'n_bits_in', sprintf('%d',n_bits_xeng_out));
set_param([blk, '/x_cast'], 'n_bits_out', sprintf('%d',n_bits_scaled_out));
set_param([blk, '/x_cast'], 'fix_pnt_pos', sprintf('%d',(n_bits-1)*2));
set_param([blk, '/xeng_mask_demux'], 'num_ants', sprintf('%d',n_ants));
set_param([blk, '/xeng_mask_demux'], 'n_bits_in', sprintf('%d',n_bits_scaled_out*8));
set_param([blk, '/xeng_mask_demux'], 'demux_factor', sprintf('%d',demux_factor));
set_param([blk, '/xeng_conj_fix'], 'n_bits_in', sprintf('%d',(n_bits_scaled_out*4)/demux_factor));
set_param([blk, '/xeng_conj_fix'], 'n_ants', sprintf('%d',n_ants));
set_param([blk, '/xeng_conj_fix'], 'demux_factor', sprintf('%d',demux_factor));

%fprintf('all variables set. \n cleanup starting...\n');

clean_blocks(blk);

fmtstr = sprintf('n_ant=%d, bits=%d, mult=%s, bram=%d', n_ants, n_bits, num2str(use_ded_mult), use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
