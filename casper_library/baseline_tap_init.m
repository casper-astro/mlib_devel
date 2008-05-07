function baseline_tap_init(blk, varargin)
% Initialize and configure a baseline_tap block in the CASPER X Engine.
%
% baseline_tap_init(blk, varargin)
%
% blk = The baseline_tap block
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% ant_sep = The separation in time of antennae data which are to be
% cross-multiplied.
% use_ded_mult = Use dedicated cores for multiplying (otherwise, use
% slices).
% use_bram_delay = Implement the stage delay (acc_len) in a BRAM delay.

if same_state(blk, varargin{:}), return, end
check_mask_type(blk, 'baseline_tap');
munge_block(blk, varargin{:});
ant_sep = get_var('ant_sep', varargin{:});
mult_type = get_var('use_ded_mult', varargin{:});
use_bram_delay = get_var('use_bram_delay', varargin{:});

% Configure all multipliers in this block to use dedicated multipliers 
%(or not)
multipliers = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'masktype', 'cmult*');
for i=1:length(multipliers),
   if mult_type==2,
       set_param(multipliers{i}, 'BlockChoice', 'cmult_4bit_br*');
   elseif mult_type==1,
       set_param(multipliers{i}, 'BlockChoice', 'cmult_4bit_em*');
   else
       set_param(multipliers{i}, 'BlockChoice', 'cmult_4bit_sl*');
   end
end

% Configure the delay to use bram or slrs
if use_bram_delay,
    delay_type = 'delay_bram';
else,
    delay_type = 'delay_slr';
end
set_param([blk,'/delay'], 'BlockChoice', delay_type);

fmtstr = sprintf('ant_sep=%d, mult=%d, bram=%d', ant_sep, mult_type, use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, varargin{:});

