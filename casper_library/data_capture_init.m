function data_capture_init( blk, varargin )

clog('data_capture_init: pre same_state', 'trace');

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('data_capture_init: post same_state', 'trace');
check_mask_type(blk, 'data_capture');
munge_block(blk, varargin{:});

stream_name = get_var('stream_name', 'defaults', defaults, varargin{:});
nsimult_streams = get_var('nsimult_streams', 'defaults', defaults, varargin{:});

delete_lines(blk);

reuse_block(blk, 'ToWorkspace_valid', 'built-in/To Workspace', 'VariableName', [stream_name, '_valid'], 'Position', [240, 20, 300, 50] );
reuse_block(blk, 'valid', 'built-in/Inport', 'Position', [25, 28, 55, 42] );
reuse_block(blk, 'valid_out', 'built-in/Outport', 'Position', [425, 20, 455, 50]);
add_line(blk, 'valid/1', 'ToWorkspace_valid/1');    
add_line(blk, 'valid/1', 'valid_out/1');

% Position vector = [xleft ytop xright ybottom]
for i=0:nsimult_streams-1,
    substream_name = [stream_name, num2str(i)];
    reuse_block(blk, ['ToWorkspace_', substream_name], 'built-in/To Workspace', 'VariableName', substream_name, 'Position', [240, 100 + 100*i, 300, 130 + 100*i] ); %
    reuse_block(blk, substream_name, 'built-in/Inport', 'Position', [25, 108 + 100*i, 55, 122+100*i] );
    reuse_block(blk, [substream_name, '_o'], 'built-in/Outport', 'Position', [425, 108 + 100*i, 455, 122+100*i] );
    add_line(blk, [substream_name,'/1'], ['ToWorkspace_', substream_name, '/1']);
    add_line(blk, [substream_name,'/1'], [substream_name, '_o', '/1']);
end

clean_blocks(blk);
save_state(blk, 'defaults', defaults, varargin{:});
clog('data_capture_init: exiting', 'trace');
