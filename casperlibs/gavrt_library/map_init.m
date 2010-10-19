function map_init(blk, varargin)
% Reimplementation of the map block from the pink CASPER blockset,
% originally by Aaron Parsons
% Uses espresso.exe for logic reduction.
% Functionality tested Sept. 25, 2008 by Glenn Jones
% Arguments:
% map: vector representing the permutation
% latency: latency for logic implementation


defaults = {};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
%disp('map_init')
check_mask_type(blk, 'map');
munge_block(blk, varargin{:});
map = get_var('map', 'defaults', defaults, varargin{:});
latency = get_var('latency', 'defaults', defaults, varargin{:});

n_bits = log2(length(map));

delete_lines(blk);

reuse_block(blk, 'din', 'built-in/inport', 'Position', [15 123 45 137], 'Port', '1');
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [500 123 520 137], 'Port', '1');

if n_bits < 1,
    add_line(blk,['din/1'],['dout/1']);
elseif n_bits == 1,
    if all(map == [0 1]),       %all necessary to check equality of vectors
        add_line(blk,['din/1'],['dout/1']);
    else,
        reuse_block(blk, 'Not', 'xbsIndex_r4/Inverter', ...
            'latency', 'latency', 'Position', [100 100 140 140]);
        add_line(blk,['din/1'],['Not/1']);
        add_line(blk,['Not/1'],['dout/1']);
    end
else,
    reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', ...
        'Position',[300 100 400 100+n_bits*20],'num_inputs',num2str(n_bits));  
    reuse_block(blk, 'Uncram', 'gavrt_library/uncram', ...
        'num_slice', num2str(n_bits), 'slice_width', '1', ...
        'bin_pt', '0', 'arith_type', '0', ...
        'Position', [80 40 110 500]);
    for i=0:n_bits-1,
        espresso_input = ['.i ',num2str(n_bits),'\n.o 1\n'];
        mapbits = bitget(map, i+1);
        % Create file for espresso to reduce the logic of
        for j=0:2^n_bits-1,
            espresso_input = [espresso_input, dec2bin(j, n_bits), ' ', dec2bin(mapbits(j+1)), '\n'];
        end
        espresso_input = [espresso_input, '.e\n'];
        fid = fopen('espresso_in.tmp', 'w');
        fprintf(fid, espresso_input);
        fclose(fid);
        dos('espresso.exe espresso_in.tmp > espresso_out.tmp');
        lgc = '';
        fid = fopen('espresso_out.tmp', 'r');
        % Translate espresso output into matlab logic string
        while 1,
            tline = fgetl(fid);
            if ~ischar(tline), break, end
            if ~strncmp(tline, '.', 1),
                if length(lgc) > 0,
                    lgc = [lgc, '|'];
                end
                tok = strtok(tline);
                lgc = [lgc, '('];
                expr = '';
                toklen = length(tok);
                for j=1:toklen,
                    inname = sprintf('%02d',toklen-j);
                    if strcmp(tok(j), '0'),
                        if length(expr) > 0,
                            expr = [expr, '&'];
                        end
                        expr = [expr, '~in',inname];
                    elseif strcmp(tok(j), '1'),
                        if length(expr) > 0,
                            expr = [expr, '&'];
                        end
                        expr = [expr, 'in', inname];
                    end
                end
                lgc = [lgc, expr, ')'];
            end
        end
        fclose(fid);
        dos('del espresso_in.tmp');
        dos('del espresso_out.tmp');
        % Idiocy to force the number of ports of expr block to be
        % n_bits
        for j=1:n_bits,
            inname = sprintf('%02d',j-1);
            lgc = [lgc, '|(in',inname,'&~in',inname,')'];
        end
        % End idiocy
        reuse_block(blk, ['expr',num2str(i)], 'xbsIndex_r4/Expression', ...
            'Position', [200 100+i*40 240 120+i*40], 'latency', num2str(latency), ...
            'expression', lgc);
    end
    for i=0:n_bits-1,
        for j=0:n_bits-1,
            add_line(blk, ['Uncram/',num2str(n_bits-j)], ['expr',num2str(i),'/',num2str(j+1)]);
        end
        add_line(blk,['expr',num2str(i),'/1'],['Concat/',num2str(n_bits-i)]);
    end
    add_line(blk, 'din/1','Uncram/1');
    add_line(blk,'Concat/1','dout/1');
end
clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});