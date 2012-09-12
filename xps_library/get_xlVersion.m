function argout=get_xlVersion(arg)
% GET_XLVERSION Return Xilinx System Generator version.
%   get_xlVersion parses the Matlab VER function to return a string value
%   for the System Generator version.
%
%   get_xlVersion('FULL') returns the full version including build number.

lump_versions = ver;

xsgVer = '';
xsgRel = '';

    for n=1:length(lump_versions)
        cur_toolbox = lump_versions(n);

        if strcmp(cur_toolbox.Name, 'Xilinx System Generator')
            xsgVer = cur_toolbox.Version;
            xsgRel = cur_toolbox.Release;
        end
    end

    if nargin > 0 && strcmpi(arg, 'full')
        toks=regexp(xsgRel, 'build\s*(\d+)', 'tokens');
        argout = xsgVer;
        %argout = [xsgVer, '.', toks{1}{1}];
    else
        argout = xsgVer;
    end

return
