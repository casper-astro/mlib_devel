function varargin = make_varargin(blk)
    msknames = get_param(blk, 'MaskNames');
    varargin = cell(1, length(msknames)*2);
    for ctr = 1 : length(msknames),
        pos = ((ctr-1)*2)+1;
        varargin(pos) = msknames(ctr);
        eval_val = eval_param(blk, msknames{ctr});
        varargin(pos+1) = {eval_val};
        %varargin(pos+1) = {get_param(blk, msknames{ctr})};
    end
end