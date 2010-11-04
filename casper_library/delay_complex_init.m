function delay_complex_init(blk, varargin)
% Initialize and configure a complex delay block.
%
% x_engine_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% delay = The number of samples to delay the signal by.
% n_bits = The bit width of a single real sample.
% bin_pt = The position of the binary point in a real sample.
% use_bram = 1 -> Delay in BRAM, 0 -> Delay in slices
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {'n_bits', 18, 'bin_pt', 17, 'use_bram', 0, 'bram_latency', 2};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'delay_complex');
munge_block(blk, varargin{:});

delay = get_var('delay', 'defaults', defaults, varargin{:});
n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});
use_bram = get_var('use_bram', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

if use_bram,
    replace_block(blk,'Name','delay1','casper_library_delays/delay_bram','noprompt');
    replace_block(blk,'Name','delay2','casper_library_delays/delay_bram','noprompt');
    set_param([blk,'/delay1'],'LinkStatus','inactive');
    set_param([blk,'/delay2'],'LinkStatus','inactive');
    set_param([blk,'/delay1'],'DelayLen','delay');
    set_param([blk,'/delay2'],'DelayLen','delay');
    set_param([blk,'/delay1'],'bram_latency','bram_latency');
    set_param([blk,'/delay2'],'bram_latency','bram_latency');
    
    delay_type = 'delay_bram';
else,
    replace_block(blk,'Name','delay1','casper_library_delays/delay_slr','noprompt');
    replace_block(blk,'Name','delay2','casper_library_delays/delay_slr','noprompt');
    set_param([blk,'/delay1'],'LinkStatus','inactive');
    set_param([blk,'/delay2'],'LinkStatus','inactive');
    set_param([blk,'/delay1'],'DelayLen','delay');
    set_param([blk,'/delay2'],'DelayLen','delay');
    delay_type = 'delay_slr';
end

set_param([blk,'/c_to_ri'], 'n_bits', num2str(n_bits), 'bin_pt', num2str(bin_pt));

% Set attribute format string (block annotation)
annotation=sprintf('depth = %d\n%s', delay, delay_type);
set_param(blk,'AttributesFormatString',annotation);
save_state(blk, 'defaults', defaults, varargin{:});
