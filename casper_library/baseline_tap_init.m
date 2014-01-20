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
defaults={
    'n_ants'            '4' ,...
    'ant_sep'           '1' ,...
    'n_bits'            '4' ,...
    'acc_len'           '32',...
    'add_latency'       '1' ,...
    'mult_latency'      '2' ,...
    'bram_latency'      '2' ,...
    'mult_type'         '1' ,...
    'use_bram_delay'    '1' ,...
};

if same_state(blk, varargin{:}), return, end
check_mask_type(blk, 'baseline_tap');
munge_block(blk, varargin{:});
ant_sep = eval(get_var('ant_sep', varargin{:}));
mult_type = eval(get_var('mult_type', 'defaults', defaults, varargin{:}));
use_bram_delay = eval(get_var('use_bram_delay', 'defaults', defaults, varargin{:}));
bram_latency=eval(get_var('bram_latency', 'defaults', defaults, varargin{:}));
mult_latency=eval(get_var('mult_latency', 'defaults', defaults, varargin{:}));
add_latency=eval(get_var('add_latency', 'defaults', defaults, varargin{:}));
n_bits = eval(get_var('n_bits', 'defaults', defaults, varargin{:}));
bram_latency=eval(get_var('bram_latency', 'defaults', defaults, varargin{:}));
mult_latency=eval(get_var('mult_latency', 'defaults', defaults, varargin{:}));
add_latency=eval(get_var('add_latency', 'defaults', defaults, varargin{:}));
n_bits = eval(get_var('n_bits', 'defaults', defaults, varargin{:}));
acc_len= eval(get_var('acc_len', 'defaults', defaults, varargin{:}));
n_ants= eval(get_var('n_ants', 'defaults', defaults, varargin{:}));

fix_pnt_pos = (n_bits-1)*2;
bit_growth = ceil(log2(acc_len));
ant_bits = ceil(log2(n_ants));
n_bits_out = (2*n_bits + 1 + bit_growth);

% Configure all multipliers in this block to use dedicated multipliers 
%(or not)
reuse_block(blk,'dual_pol_cmac','casper_library_correlator/dual_pol_cmac',...
            'mult_latency',num2str(mult_latency),...            
            'add_latency',num2str(add_latency),...
            'acc_len',num2str(acc_len),...
            'n_bits_in',num2str(n_bits),...
            'bin_pt_in',num2str(n_bits-1),...
            'LinkStatus','inactive');

if mult_type==2,
    set_param([blk,'/dual_pol_cmac'],'multiplier_implementation','standard core');
elseif mult_type==1,
    set_param([blk,'/dual_pol_cmac'],'multiplier_implementation','embedded multiplier core');
else,
    set_param([blk,'/dual_pol_cmac'],'multiplier_implementation','behavioral HDL');
end


%   if mult_type==2,
%        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
%            'casper_library_multipliers/cmult_4bit_br*','noprompt');
%    elseif mult_type==1,
%        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
%            'casper_library_multipliers/cmult_4bit_em*','noprompt');
%    else,
%        replace_block(get_param(multipliers{i},'Parent'),'Name',get_param(multipliers{i},'Name'),...
%            'casper_library_multipliers/cmult_4bit_sl*','noprompt');
%    end
%end

% Configure the delay to use bram or slrs
if use_bram_delay,
    replace_block(blk,'Name','delay','casper_library_delays/delay_bram','noprompt');
    set_param([blk,'/delay'],'LinkStatus','inactive');    
    set_param([blk,'/delay'],'DelayLen','acc_len');
    set_param([blk,'/delay'],'bram_latency','bram_latency');
else,
    replace_block(blk,'Name','delay','casper_library_delays/delay_slr','noprompt');
    set_param([blk,'/delay'],'LinkStatus','inactive');    
    set_param([blk,'/delay'],'DelayLen','acc_len');    
end


fmtstr = sprintf('ant_sep=%d, mult=%d, bram=%d', ant_sep, mult_type, use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, varargin{:});

