function [brn] = bit_reverse(n, bits)

brn = 0;
for i=1:bits,
   bit = bitget(n,i);
   brn = bitset(brn, (bits+1-i), bit);
end
