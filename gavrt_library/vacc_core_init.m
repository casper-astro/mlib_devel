function vacc_core_init(blk, varargin)
% 2008.02.25 - Added mux_latency
%veclen
%arith_type
%out_bit_width
%out_bin_pt
%add_latency
%bram_latency

defaults = {};
disp('hi from vacc_core_init')
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'vacc_core');
munge_block(blk, varargin{:});
veclen = get_var('veclen', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});
out_bit_width = get_var('out_bit_width', 'defaults', defaults, varargin{:});
out_bin_pt = get_var('out_bin_pt', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
mux_latency = get_var('mux_latency', 'defaults', defaults, varargin{:});

atypes = {'Unsigned', 'Signed  (2''s comp)'};    %arith_types lookup table
if isempty(find(arith_type == [0,1])),
    errordlg('Vacc Core: Arithmetic Type must be 0 or 1')
end
%Calculate parameters for BRAM delay
delay = veclen - add_latency - mux_latency;
bram_latency = eval(bram_latency);
delay_bits = max(nextpow2(delay), 2);
%num2str(delay - bram_latency - 1)

set_param([blk, '/Mux'], 'latency', num2str(mux_latency));

adder = [blk, '/Adder'];
set_param(adder,'arith_type', char(atypes(arith_type+1)));
set_param(adder,'n_bits', num2str(out_bit_width));
set_param(adder,'bin_pt', num2str(out_bin_pt));
set_param(adder,'latency', num2str(add_latency));

%disp('setting up counter')
a = delay - bram_latency - 1;
counter = [blk, '/Counter'];
set_param(counter, 'n_bits', num2str(delay_bits), 'cnt_to', num2str(a));
%set_param(counter, 'cnt_to', num2str(a));

%disp('setting up bram')
bram = [blk, '/BRAM'];
set_param(bram, 'depth', num2str(2^delay_bits));
set_param(bram, 'latency', num2str(bram_latency));

save_state(blk, 'defaults', defaults, varargin{:});