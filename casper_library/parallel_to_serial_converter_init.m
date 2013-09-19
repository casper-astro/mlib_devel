function parallel_to_serial_converter_init(blk, varargin)

clog('parallel_to_serial_converter_init: pre same_state', 'trace');

defaults = {};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('parallel_to_serial_converter_init: post same_state', 'trace');

check_mask_type(blk, 'parallel_to_serial_converter');
munge_block(blk, varargin{:});

pin_width = get_var('pin_width', 'defaults', defaults, varargin{:});
sout_width = get_var('sout_width', 'defaults', defaults, varargin{:});

num_shifter_units = pin_width / sout_width;

if (mod(pin_width,sout_width) ~= 0 || num_shifter_units < 2)
    errordlg('Incompatible data widths');
end

delete_lines(blk);

% Update Static Blocks
%set_param([blk, '/DinDelay'], 'reg_retiming', 'off');

add_line(blk, 'ld/1', 'Logical/1');
add_line(blk, 'shift/1', 'Logical/2');

for k = 1:num_shifter_units,
    % add the block
    new_blk_name = ['shifter_unit',num2str(k)];
    reuse_block(blk, new_blk_name, 'casper_library_flow_control/shifter_unit', ...
        'data_width', num2str(sout_width), 'pin_offset', num2str((k-1)*sout_width), 'Position', [220 + (k-1)*200, 26, 280 + (k-1)*200, 74] );
    add_line(blk, 'ld/1', [new_blk_name, '/1']); % add the select line
    
    % connect the 'prev' input
    if (k == 1)
        add_line(blk, 'filler/1', [new_blk_name, '/2']);
    else
        add_line(blk, ['shifter_unit',num2str(k-1),'/1'], [new_blk_name, '/2']);
    end
    
    % connect the 'pin' input
    add_line(blk, 'pin/1', [new_blk_name,'/3']);
    
    % connect the 'reg_en' inputp
    add_line(blk, 'Logical/1', [new_blk_name,'/4']);
    
    % if the block is the last one, then connect the output to sout and
    % move sout
    if (k == num_shifter_units)
        add_line(blk, [new_blk_name, '/1'], 'sout/1');        
        set_param([blk, '/sout'], 'Position', [220 + k*200, 26, 280+k*200, 74]);
    end
end




clean_blocks(blk);
fmtstr = '';
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('parallel_to_serial_converter_init: exiting', 'trace');
