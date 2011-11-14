function xeng_init(blk, varargin)
% Initialize and configure the windowed CASPER X Engine with configurable output demux.
%

% Declare any default values for arguments you might like.
defaults = {'n_ants',8,'n_bits',4,'use_ded_mult', 1, 'use_bram_delay', 1, 'demux_factor', '1', 'n_bits', 4, ...
    'add_latency', 1, 'mult_latency', 1, 'bram_latency', 2, 'acc_len',128};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'xeng');
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
demux_factor = eval(get_var('demux_factor', 'defaults', defaults, varargin{:}));


fix_pnt_pos = (n_bits-1)*2;
xeng_delay = add_latency + mult_latency + acc_len + floor(n_ants/2 + 1) + 1;
bit_growth = ceil(log2(acc_len));
ant_bits = ceil(log2(n_ants));
n_bits_xeng_out = (2*n_bits + 1 + bit_growth);
n_bits_scaled_out = 2^(ceil(log2(n_bits_xeng_out)));


if n_ants < 4,
    warndlg('X engine is not designed to work with less than 4 antennas. Defaulting to 4.');
    warning('X Engine is not designed to work with less than 4 antennas. Defaulting to 4.');
    set_param(blk, 'n_ants', '4');
    n_ants=4;
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

if (mod(n_ants,2) ~= 0)
    warndlg(sprintf('X engine is not tested for non-2^N antennas. YMMV.'));
    warning('X engine is not tested for non-2^N antennas. YMMV.');
end

%fprintf('variables all done\n');

% Begin redrawing
%================

delete_lines(blk);

% Add taps
x = 275;

reuse_block(blk, 'auto_tap', 'casper_library_correlator/auto_tap',...
                'Position',[135, 51, 230, 169], ...
                'n_ants',num2str(n_ants), ...                            
                'n_bits',num2str(n_bits), ...
                'acc_len',num2str(acc_len), ...
                'add_latency',num2str(add_latency), ...
                'mult_latency',num2str(mult_latency), ...
                'bram_latency',num2str(bram_latency), ...
            	'use_bram_delay', num2str(use_bram_delay));
            
for i=1:floor(n_ants/2),
        name = ['baseline_tap', num2str(i)];
        reuse_block(blk, name, 'casper_library_correlator/baseline_tap', ...
            'n_ants',num2str(n_ants), ...            
            'n_bits',num2str(n_bits), ...
            'acc_len',num2str(acc_len), ...
            'add_latency',num2str(add_latency), ...
            'mult_latency',num2str(mult_latency), ...
            'bram_latency',num2str(bram_latency), ...
            'ant_sep', num2str(i), 'Position', [x, 52, x+95, 168], ...
            'use_bram_delay', num2str(use_bram_delay));
        x = x + 135;
end

% Add Misc static blocks
reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', 'Position', [15,89,85,121],...
            'const','0',...
            'arith_type','Unsigned',...
            'n_bits',sprintf('%d',8 * n_bits_xeng_out));
        
reuse_block(blk, 'sample_and_hold1', 'casper_library_misc/sample_and_hold', 'Position', [140,255,180,315],...
            'period',sprintf('%d',n_ants * acc_len));

reuse_block(blk, 'sample_and_hold2', 'casper_library_misc/sample_and_hold', 'Position', [x + 100,190,x+140,250],...
            'period',sprintf('%d',n_ants * acc_len));

reuse_block(blk, 'sample_and_hold3', 'casper_library_misc/sample_and_hold', 'Position', [x + 250,190,x+290,250],...
            'period',sprintf('%d',n_ants * acc_len));

reuse_block(blk, 'delay', 'xbsIndex_r4/Delay','Position', [x + 350, 220, x + 380, 230],...
            'reg_retiming','on',...
            'latency','1');

reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', 'Position', [15,124,85,156],...
            'const','0',...
            'arith_type','Boolean',...
            'n_bits','1');
        
            
reuse_block(blk, 'window_delay', 'casper_library_delays/window_delay',...
            'Position', [135, 200, x-135+95, 230], ...
            'delay',num2str(xeng_delay));
        

% Add ending terminators
reuse_block(blk, 'Term1', 'built-in/Terminator', 'Position', [x, 25, x + 20, 45]);
reuse_block(blk, 'Term2', 'built-in/Terminator', 'Position', [x, 65, x + 20, 85]);
reuse_block(blk, 'Term3', 'built-in/Terminator', 'Position', [x, 130, x + 20, 150]);
     
% Set output port positions
reuse_block(blk, 'acc', 'built-in/outport','Position', [x + 400, 100, x + 430, 114]);
reuse_block(blk, 'valid', 'built-in/outport','Position', [x + 400, 130, x + 430, 144]);
reuse_block(blk, 'sync_out', 'built-in/outport','Position', [x + 400, 160, x + 430, 174]);
reuse_block(blk, 'mcnt_out', 'built-in/outport','Position', [x + 400, 190, x + 430, 204]);

% Set input port positions
reuse_block(blk, 'sync_in', 'built-in/inport','Position', [55,178,85,192]);
reuse_block(blk, 'ant', 'built-in/inport','Position', [55,53,85,67]);
reuse_block(blk, 'window_valid', 'built-in/inport','Position', [55,223,85,237]);
reuse_block(blk, 'mcnt_in', 'built-in/inport','Position', [55,293,85,307]);


last_baseline_tap = ['baseline_tap', num2str(floor(n_ants/2))];

if (n_ants == 4)
    reuse_block(blk, 'xeng_descramble_4ant', 'casper_library_correlator/xeng_descramble_4ant', ...
        'Position', [x + 100, 105, x + 200, 163], ...
        'n_bits', sprintf('%d',n_bits), ...
        'demux_factor', sprintf('%d',demux_factor),...
        'acc_len', sprintf('%d',acc_len));
    
    add_line(blk, [last_baseline_tap, '/4'], 'xeng_descramble_4ant/1','autorouting', 'on');
    add_line(blk, [last_baseline_tap, '/5'], 'xeng_descramble_4ant/2', 'autorouting', 'on');
    add_line(blk, [last_baseline_tap, '/7'], 'xeng_descramble_4ant/3', 'autorouting', 'on');
    add_line(blk, 'window_delay/1', 'xeng_descramble_4ant/4', 'autorouting', 'on');
    
    add_line(blk, 'xeng_descramble_4ant/1', 'acc/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble_4ant/2', 'valid/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble_4ant/3', 'sync_out/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble_4ant/3', 'sample_and_hold3/1', 'autorouting', 'on');
    

    
elseif (n_ants >=6)
    reuse_block(blk, 'xeng_descramble', 'casper_library_correlator/xeng_descramble', ...
        'Position', [x + 100, 105, x + 200, 163], ...
        'num_ants', sprintf('%d',n_ants), ...
        'n_bits', sprintf('%d',n_bits), ...
        'demux_factor', sprintf('%d',demux_factor),...
        'acc_len', sprintf('%d',acc_len));
    add_line(blk, 'xeng_descramble/1', 'acc/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble/2', 'valid/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble/3', 'sync_out/1', 'autorouting', 'on');
    add_line(blk, 'xeng_descramble/3', 'sample_and_hold3/1', 'autorouting', 'on');
    
    add_line(blk, [last_baseline_tap, '/4'], 'xeng_descramble/1','autorouting', 'on');
    add_line(blk, [last_baseline_tap, '/5'], 'xeng_descramble/2', 'autorouting', 'on');
    add_line(blk, [last_baseline_tap, '/7'], 'xeng_descramble/3', 'autorouting', 'on');
    add_line(blk, 'window_delay/1', 'xeng_descramble/4', 'autorouting', 'on');

else 
    errordlg('Internal X engine fault. 5 antennas a special case; not supported.');
    error('Internal X engine fault. 5 antennas a special case; not supported.');
end


% Add lines
%==========
add_line(blk, 'ant/1', 'auto_tap/1', 'autorouting', 'on');
add_line(blk, 'ant/1', 'auto_tap/2', 'autorouting', 'on');
add_line(blk, 'Constant/1', 'auto_tap/4', 'autorouting', 'on');
add_line(blk, 'Constant1/1', 'auto_tap/5', 'autorouting', 'on');
add_line(blk, 'sync_in/1', 'auto_tap/6', 'autorouting', 'on');
add_line(blk, 'window_valid/1', 'window_delay/1', 'autorouting', 'on');

add_line(blk, 'sync_in/1', 'sample_and_hold1/1', 'autorouting', 'on');

add_line(blk, 'mcnt_in/1', 'sample_and_hold1/2', 'autorouting', 'on');
add_line(blk, 'sample_and_hold1/1', 'sample_and_hold2/2', 'autorouting', 'on');
add_line(blk, 'sample_and_hold2/1', 'sample_and_hold3/2', 'autorouting', 'on');
add_line(blk, 'sample_and_hold3/1', 'delay/1', 'autorouting', 'on');
add_line(blk, 'delay/1', 'mcnt_out/1', 'autorouting', 'on');

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

add_line(blk, [last_baseline_tap, '/1'], 'auto_tap/3', 'autorouting', 'on');
add_line(blk, [last_baseline_tap, '/2'], 'Term1/1', 'autorouting', 'on');
add_line(blk, [last_baseline_tap, '/3'], 'Term2/1', 'autorouting', 'on');
add_line(blk, [last_baseline_tap, '/6'], 'Term3/1', 'autorouting', 'on');
add_line(blk, [last_baseline_tap, '/7'], 'sample_and_hold2/1', 'autorouting', 'on');

% SETUP multipliers
if length(use_ded_mult)==1
    set_param([blk, '/auto_tap'], 'use_ded_mult', num2str(use_ded_mult));
    for i=1:floor(n_ants/2),
        name = ['/baseline_tap', num2str(i)];
        set_param([blk, name], 'use_ded_mult', num2str(use_ded_mult));    
    end
elseif length(use_ded_mult)==floor(n_ants/2)+1
    set_param([blk, '/auto_tap'], 'use_ded_mult', num2str(use_ded_mult(1)));
    for i=1:floor(n_ants/2),
        name = ['/baseline_tap', num2str(i)];
        set_param([blk, name], 'use_ded_mult', num2str(use_ded_mult(i+1)));
    end
end


clean_blocks(blk);

fmtstr = sprintf('n_ant=%d, bits=%d, mult=%s, bram=%d', n_ants, n_bits, num2str(use_ded_mult), use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
