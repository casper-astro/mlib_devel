/* update the specific key in the bconfig file */
function [] = update_bconfig(bconfigfn, key, val)
    bconfig = fromJSON(bconfigfn, 'file');
    bconfig('parameters')(key) = val;
    toJSON(bconfig, bconfigfn, 4);
end