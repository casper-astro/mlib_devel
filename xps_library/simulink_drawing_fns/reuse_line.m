function [  ] = reuse_line( mdl, oport, iport )
% REUSE_LINE
%     Same syntax as function add_line
%     Example usage:
%         add_line('mymodel','Sine Wave/1','Mux/1');
%        
%     Checks if a line between specified OPORT and IPORT is present.  
%     If a line is not present, then one is drawn

    try
        add_line(mdl, oport, iport);
    catch
        % line exists, do nothing
%         fprintf('Attempting to draw duplicate line\n');
    end

end

