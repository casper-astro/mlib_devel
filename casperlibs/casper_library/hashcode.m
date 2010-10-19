%Generates 32-bit hash from character array
%
%hash = hashcode(str)
%
%str = character array

function hash = hashcode(str)
    str = uint32(str(:))';
    hash = uint32(1234);
    for c = str
        hash = mod(hash*31 + c, 2^27);
    end
end
