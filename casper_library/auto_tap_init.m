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

defaults = {
    'n_ants'            '4' , ...
    'n_bits'            '4' , ...
    'acc_len'           '32', ...
    'add_latency'       '1' , ...
    'mult_latency'      '2' , ...
    'bram_latency'      '2' , ...
    'mult_type'         '1' , ...
    'use_bram_delay'    '1' , ...
};

if same_state(blk, varargin{:}), return, end
check_mask_type(blk, 'auto_tap');
munge_block(blk, varargin{:});
mult_type = eval(get_var('mult_type', 'defaults', defaults, varargin{:}));
use_bram_delay = eval(get_var('use_bram_delay', 'defaults', defaults, varargin{:}));

bram_latency=eval(get_var('bram_latency', 'defaults', defaults, varargin{:}));
mult_latency=eval(get_var('mult_latency', 'defaults', defaults, varargin{:}));
add_latency=eval(get_var('add_latency', 'defaults', defaults, varargin{:}));
n_bits = eval(get_var('n_bits', 'defaults', defaults, varargin{:}));
acc_len= eval(get_var('acc_len', 'defaults', defaults, varargin{:}));
n_ants= eval(get_var('n_ants', 'defaults', defaults, varargin{:}));
%fprintf('%s',mult_latency)
%fprintf('%i',mult_latency)
%return

fix_pnt_pos = (n_bits-1)*2;
bit_growth = ceil(log2(acc_len));
ant_bits = ceil(log2(n_ants));
n_bits_out = (2*n_bits + 1 + bit_growth);

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
else
    set_param([blk,'/dual_pol_cmac'],'multiplier_implementation','behavioral HDL');
end

delay_value = (acc_len-1) * ceil(n_ants/2) + ceil(n_ants/2) - floor(n_ants/2);
if use_bram_delay,
    replace_block(blk, 'Name', 'delay', 'casper_library_delays/delay_bram', 'noprompt');
else
    replace_block(blk, 'Name', 'delay', 'casper_library_delays/delay_slr', 'noprompt');
end
set_param([blk, '/delay'], 'LinkStatus', 'inactive');
set_param([blk, '/delay'], 'DelayLen', num2str(delay_value));
if use_bram_delay,
    set_param([blk, '/delay'], 'bram_latency', num2str(bram_latency));
end
set_param([blk, '/sync_delay'], 'DelayLen', num2str(add_latency + mult_latency + acc_len + floor(n_ants/2 + 1) + 1));

%set_param([blk,'/Counter'],'cnt_type','Count Limited');    
%set_param([blk,'/Counter'],'cnt_to',num2str(acc_len-1));    
%set_param([blk,'/Counter'],'n_bits',num2str(n_bits));

%set_param([blk,'/Constant1'],'n_bits',num2str(n_bits));
%set_param([blk,'/Delay'],'latency',num2str(add_latency + mult_latency - 1));

% multipliers = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'masktype', 'Xilinx Multiplier');
% for i=1:length(multipliers),
%     if use_ded_mult,
%         set_param(multipliers{i}, 'use_embedded', 'on');
%     else,
%         set_param(multipliers{i}, 'use_embedded', 'off');
%     end
% end

fmtstr = sprintf('mult_typ=%d, del_typ=%d', mult_type,use_bram_delay);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, varargin{:});

