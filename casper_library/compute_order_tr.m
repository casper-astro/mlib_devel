function order = compute_order_eff(rowLength, colLength);

order = 1; 
rowBits = log2(rowLength);
colBits = log2(colLength);
numBits = rowBits + colBits;
vec = [1:numBits];
temp = [vec(numBits-rowBits+1:numBits) vec(1:colBits)];

while not(all(temp==vec))
        order = order+1;
        temp = [temp(numBits-rowBits+1:numBits) temp(1:colBits)];
end
    