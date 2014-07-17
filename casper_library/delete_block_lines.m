function delete_block_lines(block)
try
    % Bail out if block does not exist
    if ~block_exists(block)
        return;
    end
    ph = get_param(block, 'PortHandles');
    for op = 1 : length(ph.Outport),
        line = get_param(ph.Outport(op), 'Line');
        if line > -1,
            delete_line(line);
        end
    end
    for op = 1 : length(ph.Inport),
        line = get_param(ph.Inport(op), 'Line');
        if line > -1,
            delete_line(line);
        end
    end
catch ex
    dump_and_rethrow(ex);
end
end
