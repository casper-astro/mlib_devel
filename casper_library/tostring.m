function string = tostring( something )
    
if isa(something, 'char'), 
%    disp('string')
    string = something;
    return;
end
%disp('not string');
if isa(something, 'numeric'), 
    string = mat2str(something);
    return;
end
disp('tostring:Data passed not string or number')
    
    
    
