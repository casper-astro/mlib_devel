function result = bit_rev(v, size)
for i=1:length(v)
    result(i) = bit_reverse(v(i),size);
end