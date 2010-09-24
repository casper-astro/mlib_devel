function superslice_init(blk, varargin)
%slices

defaults = {};
%disp('hi from superslice')
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'superslice');
munge_block(blk, varargin{:});

slices = get_var('slices', 'defaults', defaults, varargin{:});
slices = eval(slices);
nslices = length(slices);

delete_lines(blk);

reuse_block(blk, 'In', 'built-in/inport', 'Position', [100 50 130 70]);

thisbit = 0;
for j = nslices:-1:1,
    k = nslices - j + 1;
    lastbit = thisbit;
    if slices(j) == -1,
        reuse_block(blk, ['Slice', num2str(j)], 'xbsIndex_r4/Slice', ...
            'mode', 'Lower Bit Location + Width', 'nbits', num2str(1), 'bit0', num2str(thisbit), ...
            'boolean_output', 'on', 'Position', [200 50+j*100 250 100+j*100]);
        thisbit = thisbit + 1;
    else
        reuse_block(blk, ['Slice', num2str(j)], 'xbsIndex_r4/Slice', ...
            'mode', 'Lower Bit Location + Width', 'nbits', num2str(slices(j)), 'bit0', num2str(thisbit), ...
            'boolean_output', 'off', 'Position', [200 50+j*100 250 100+j*100]);
        thisbit = thisbit + slices(j);
    end
    add_line(blk, 'In/1', ['Slice', num2str(j), '/1']);
end

% This ugly second for loop ensures that the output ports are in a pretty
% order. Reusing outputs without cleaning can rearange things and make them ugly.
clean_blocks(blk);
thisbit = sum(abs(slices))-1;
for j = 1:nslices,
    k = nslices - j + 1;
    lastbit = thisbit;
    if slices(j) == -1,
        thisbit = thisbit - 1;
    else
        thisbit = thisbit - slices(j);
    end
    if abs(slices(j)) == 1,
        outlabel = ['[', num2str(lastbit), ']'];
    else,
        outlabel = ['[', num2str(lastbit), ':', num2str(thisbit+1),']'];
    end
    reuse_block(blk, outlabel, 'built-in/outport', ...
        'Position', [400 50+j*100 430 70+j*100]);
    add_line(blk, ['Slice', num2str(j), '/1'], [outlabel, '/1']);
end


save_state(blk, 'defaults', defaults, varargin{:});