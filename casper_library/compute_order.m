% Computes the cyclic order of a permutation
function rv = compute_order(map)
order = 1;
for i=1:length(map),
    j = -1;
    cur_order = 1;
    while j+1 ~= i,
        if j < 0,
            j = map(i);
        else,
            j = map(j+1);
            cur_order = cur_order + 1;
        end
    end
    order = lcm(order, cur_order);
end
    
rv = order;
    