function delete_block_lines(block, varargin)
% does the block exist?
if getSimulinkBlockHandle(block) == -1
    return
end
% carry on
numvarargs = length(varargin);
if numvarargs == 0
    dump_exception = true;
end
try
    ph = get_param(block, 'PortHandles');
    for op = 1 : length(ph.Outport)
        line = get_param(ph.Outport(op), 'Line');
        if line > -1
            delete_line(line);
        end
    end
    for op = 1 : length(ph.Inport)
        line = get_param(ph.Inport(op), 'Line');
        if line > -1
            delete_line(line);
        end
    end
catch ex
    if dump_exception
        dump_and_rethrow(ex);
    else
        rethrow(ex);
    end
end
end