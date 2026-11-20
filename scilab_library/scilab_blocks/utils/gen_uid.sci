function [uid] = gen_uid(obj)
    // we get the uid from ibj.model.uid, but it contains '-' and ':'.
    // so we get rid of the '-' and ':' here.
    x = strsubst(obj.model.uid, '-', '');
    uid = strsubst(x, ':', '');
endfunction