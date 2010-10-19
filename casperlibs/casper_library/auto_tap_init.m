function auto_tap_init(blk, varargin)
% Initialize and configure a auto_tap block in the CASPER X Engine.
%
% auto_tap_init(blk, varargin)
%
% blk = The baseline_tap block
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% use_ded_mult = Use dedicated cores for multiplying (otherwise, use
% slices).

if same_state(blk, varargin{:}), return, end
check_mask_type(blk, 'auto_tap');
munge_block(blk, varargin{:});
use_ded_mult = get_var('use_ded_mult', varargin{:});
use_bram_delay = get_var('use_bram_delay', varargin{:});

% Configure all multipliers in this block to use dedicated multipliers 
%(or not)
multipliers = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on','Name', 'cmult*');
for i=1:length(multipliers),
    if use_ded_mult==2,
        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
            'casper_library_multipliers/cmult_4bit_br*','noprompt');
    elseif use_ded_mult==1,
        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
            'casper_library_multipliers/cmult_4bit_em*','noprompt');
    else,
        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
            'casper_library_multipliers/cmult_4bit_sl*','noprompt');
    end
    set_param(multipliers{i},'LinkStatus','inactive');
    set_param(multipliers{i},'mult_latency','mult_latency');
    set_param(multipliers{i},'add_latency','add_latency');
end

if use_bram_delay,
    replace_block(blk,'Name','delay','casper_library_delays/delay_bram','noprompt');
    set_param([blk,'/delay'],'LinkStatus','inactive');    
    set_param([blk,'/delay'],'DelayLen','(acc_len - 1)*ceil(n_ants/2) + ceil(n_ants/2)-floor(n_ants/2)');
    set_param([blk,'/delay'],'bram_latency','bram_latency');
else,
    replace_block(blk,'Name','delay','casper_library_delays/delay_slr','noprompt');
    set_param([blk,'/delay'],'LinkStatus','inactive');    
    set_param([blk,'/delay'],'DelayLen','(acc_len - 1)*ceil(n_ants/2) + ceil(n_ants/2)-floor(n_ants/2)');    
end

% multipliers = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'masktype', 'Xilinx Multiplier');
% for i=1:length(multipliers),
%     if use_ded_mult,
%         set_param(multipliers{i}, 'use_embedded', 'on');
%     else,
%         set_param(multipliers{i}, 'use_embedded', 'off');
%     end
% end

fmtstr = sprintf('mult=%d, delay=%d', use_ded_mult,use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, varargin{:});

