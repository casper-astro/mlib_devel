function [ret] = fixpnt(num, bitw, bpnt)
ret = round(num * 2^bpnt);
if (ret > 2^(bitw - 1) - 1),
    ret = 2^(bitw - 1) - 1;
end
if (ret < - 2^(bitw - 1)),
    ret = - 2^(bitw - 1);
end
ret = ret/2^bpnt;