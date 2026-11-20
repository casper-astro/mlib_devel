/*
checks that depend on jasper.json already existing -- these run AFTER
collect_block_info(fn) has been called, since jasper.json is where
they get their information from. Add future post-collect checks here,
following the same pattern as check_bit_width:
1. every link's src/dst port widths must match.
*/
function [validation] = post_validate_design(fn)
    bw_msg = check_bit_width(fn);

    if bw_msg == '' then
        validation = 'ok';
    else
        validation = ascii(10) + '**************Validation Failed**************';
        validation = validation + ascii(10) + bw_msg;
        validation = validation + ascii(10) + '*********************************************';
        validation = validation + ascii(10);
    end
endfunction
