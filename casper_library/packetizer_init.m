function packetizer_init(blk, varargin)

defaults = {};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
disp('Running mask script for block: packetizer')
check_mask_type(blk, 'packetizer');
munge_block(blk, varargin{:});

sout_width = get_var('sout_width', 'defaults', defaults, varargin{:});
pin_width = get_var('pin_width', 'defaults', defaults, varargin{:});
fifo_depth = get_var('fifo_depth', 'defaults', defaults, varargin{:});
total_words = get_var('total_words', 'defaults', defaults, varargin{:});
words_per_cycle = pin_width/sout_width;

if ~(mod(pin_width, sout_width) == 0)
    errordlg('This block currently only supports integer word serialization')
end

% Set Sub-block Parameters
%=========================
% total words/words per cycle in the fsm
set_param([blk, '/control_fsm'], 'defparams', ['{''data_per_word'',', num2str(words_per_cycle-1) ', ''n_words'', ' num2str(total_words-1), ' }']);

% data_counter/shift_counter width
set_param([blk, '/shift_counter'], 'n_bits', num2str( ceil(log2(words_per_cycle-1))+1 ) );
set_param([blk, '/data_counter'], 'n_bits', num2str( ceil(log2(total_words-1))+1) );

% set fifo depth
set_param([blk, '/data_buffer'], 'depth', fifo_depth);

% set parameters in 'parallel_to_serial_converter'
set_param([blk, '/parallel_to_serial_converter'], 'sout_width', num2str(sout_width));
set_param([blk, '/parallel_to_serial_converter'], 'pin_width', num2str(pin_width));

clean_blocks(blk);
fmtstr = sprintf('Parallel Input Width: %d\nSerial Output Width: %d', pin_width, sout_width);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});