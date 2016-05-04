function [numios, current_names, current_widths, current_bins, current_types] = swreg_maskcheck(blk)
    %
    % Check a software register for correctly formatted bitfield options.
    %
    blktype = 1;
    fld_nms = 'names';
    fld_bps = 'bin_pts';
    fld_wid = 'bitwidths';
    fld_typ = 'arith_types';
    [numios, current_names, current_widths, current_bins, current_types] = bitfield_maskcheck(blk, blktype, fld_nms, fld_typ, fld_bps, fld_wid);    
end
