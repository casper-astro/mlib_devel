function  remove_stray_lines( sys )
%REMOVE_STRAY_LINES Removes stray lines from given simulink system

lines = get_param(sys, 'Lines');
for k=1:length(lines),
    if lines(k).SrcBlock == -1,
        delete_line( lines(k).Handle );
        fprintf('Deleting stray line\n');
    end
end

end

