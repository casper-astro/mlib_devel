function sync_gen_init(blk, varargin)
%disp('Running mask script for block: sync_gen')
defaults = {};

if same_state(blk, 'defaults', defaults, varargin{:}), 
    return, 
end
check_mask_type(blk, 'sync_gen');
munge_block(blk, varargin{:});

sim_acc_len = get_var('sim_acc_len', 'defaults', defaults, varargin{:});
fft_size = get_var('fft_size', 'defaults', defaults, varargin{:});
fft_simult_inputs = get_var('fft_simult_inputs', 'defaults', defaults, varargin{:});
pfb_fir_taps = get_var('pfb_fir_taps', 'defaults', defaults, varargin{:});
reorder_vec = get_var('reorder_vec', 'defaults', defaults, varargin{:});
scale = get_var('scale','defaults',defaults,varargin{:});

if pfb_fir_taps < 1,
    errordlg('Sync Generator: pfb_fir length must be >= 1')
end

% delete_lines(blk);

% Calculate the LCM( FFT reorder delays )
lcm_reorder = 1;
for i=1:length(reorder_vec),
    lcm_reorder = lcm(lcm_reorder, reorder_vec(i));
end

sim_sync_period = scale * sim_acc_len * pfb_fir_taps * fft_size * lcm_reorder / fft_simult_inputs;
% fprintf( 'Simulation sync period set to %d\n', sim_sync_period );
% gen_sync_period = gen_acc_len * pfb_fir_taps * fft_size * lcm_reorder / fft_simult_inputs;
% fprintf('Gen params: acc len: %d, taps: %d, fft_size: %d, lcm: %d, fft_simult: %d\n', gen_acc_len, pfb_fir_taps, fft_size, lcm_reorder, fft_simult_inputs);
% fprintf( 'Generation sync period set to %d\n', gen_sync_period );

% Set to (sim_sync_period-2) since counter starts at 0, and comparator has one clock cycle latency
set_param([blk, '/sync_period_const'], 'const', num2str(sim_sync_period-2));

% % Update parameters
% reuse_block( blk, 'sim_sync_period', 'xbsBasic_r4/Constant', 'Position', [385, 123, 510, 147], 'n_bits', num2str(32), 'bin_pt', num2str(0), 'const', num2str(sim_sync_period));
% % disp('first addline done')
% %reuse_block( blk, 'gen_sync_period_const', 'xps_library/software_register', 'Position', [385, 168, 510, 192]); %, 'io_dir', 'From Processor'
% 
% 
% if use_soft_reg == 0
%     %add_block( 'xbsBasic_r4/Constant', [blk, '/gen_sync_period'], 'COPYOPTION','DUPLICATE', 'Position', [385, 168, 510, 192], 'n_bits', num2str(32), 'bin_pt', num2str(0), 'const', num2str(gen_sync_period))
%     %delete_block( [blk, '/gen_sync_period']);
% %     disp('gen_sync_period block deleted')
% %     reuse_block( blk, 'gen_sync_period', 'xbsBasic_r4/Constant', ...
% %         'Position', [385, 168, 510, 192], 'n_bits', num2str(32), 'bin_pt', num2str(0), 'const', num2str(gen_sync_period));
% %     disp('Using constant not software reg')
%     reuse_block( blk, 'gen_sync_period_const', 'xbsBasic_r4/Constant', ...
%         'Position', [385, 168, 510, 192], 'n_bits', num2str(32), 'bin_pt', num2str(0), 'const', num2str(gen_sync_period));
% 
%     add_line(blk, 'gen_sync_period_const/1', 'sim_mux/2', 'AUTOROUTING', 'ON');
% elseif use_soft_reg == 1,
% %     disp('Using software reg, not constant')
% %     delete_block( [blk, '/gen_sync_period']);
% %     reuse_block( blk, 'gen_sync_period', 'xps_library/software_register', 'Position', [385, 168, 510, 192]); %, 'io_dir', 'From Processor'
%     reuse_block( blk, 'sim_input_dummy', 'built-in/Constant', 'Position', [330, 170, 360, 200]);
%     reuse_block( blk, 'gen_sync_period_soft', 'xps_library/software_register', 'Position', [385, 168, 510, 192], 'io_dir', 'From Processor'); 
%     add_line(blk, 'sim_input_dummy/1', 'gen_sync_period_soft/1', 'AUTOROUTING', 'ON');
% 
%     add_line(blk, 'gen_sync_period_soft/1', 'sim_mux/2', 'AUTOROUTING', 'ON');
% end
% 
% 
% % Static lines, always present
% add_line(blk, 'sim_sync_period/1', 'sim_mux/1', 'AUTOROUTING', 'ON');
% 
% add_line(blk, 'Constant/1', 'sync/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'sync/1', 'posedge3/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'posedge3/1', 'Slice2/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'Slice2/1', 'Logical1/2', 'AUTOROUTING', 'ON');
% add_line(blk, 'Logical1/1', 'Counter3/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'Counter3/1', 'Relational/2', 'AUTOROUTING', 'ON');
% add_line(blk, 'Relational/1', 'Logical/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'Slice2/1', 'Logical/2', 'AUTOROUTING', 'ON');
% add_line(blk, 'Logical/1', 'posedge1/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'posedge1/1', 'sync_out/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'Relational/1', 'Logical1/1', 'AUTOROUTING', 'ON');
% add_line(blk, 'sim_mux/1', 'Relational/1', 'AUTOROUTING', 'ON');


% Remove stray wires and unused blocks
clean_blocks(blk);

% Display the simulation sync period under the block.
fmtstr = sprintf('sim_sync_period=%d ',sim_sync_period);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save the state of the block
save_state(blk, 'defaults', defaults, varargin{:});
