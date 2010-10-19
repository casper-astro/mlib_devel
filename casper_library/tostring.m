%Designed to convert things into strings for populating mask text boxes.
%Works with 1D arrays (lists) and strings or single values.
% YMMV with multidimensional arrays or matrices.


function string = tostring( something, precision )

prec = 32;
if nargin > 1,
    if precision > 50,
	disp(['tostring: maximum precision when converting to string is 50 digits,',precision,' provided']);
	clog(['tostring: maximum precision when converting to string is 50 digits,',precision,' provided'], 'error');
    end
    prec = precision;
end
    
if isa(something, 'char'), 
    string = something;
    return;
end
if isa(something, 'numeric'), 
    if length(something)>1,
        string = ['[',num2str(something,prec),']'];
        return;
    else,
        string = num2str(something,prec);
        return;
    end
end

disp(['tostring: Data passed (', something, ') not numeric nor string']);
clog(['tostring: Data passed (', something, ') not numeric nor string'],'error')
    
