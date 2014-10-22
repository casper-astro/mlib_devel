function header_ids = spead_process_header_string(hdrstr)
    try
        header_ids = eval(hdrstr);
    catch
        hdrstr = strtrim(strrep(strrep(strrep(hdrstr, ',', ' '), '[', ''), ']', ''));
        while true,
            hdrstr = strrep(hdrstr, '  ', ' ');
            if isempty(strfind(hdrstr, '  ')),
                break
            end
        end
        header_ids = zeros(1, length(strfind(hdrstr, ' '))+1);
        for ctr = 1 : length(strfind(hdrstr, ' '))+1,
            [strnum, hdrstr] = strtok(hdrstr, ' ');
            try
                thisnum = eval(strnum);
            catch
                if isempty(strfind(strnum, '0x')),
                    error('Could not process header ID %s. Hex numbers are in the form 0x1234 and decimals 1234.', strnum);
                end
                thisnum = hex2dec(strrep(strnum, '0x', ''));
            end
            header_ids(ctr) = thisnum;
        end
    end
end
