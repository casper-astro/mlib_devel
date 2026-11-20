/*
check that fn (the design file path passed to jasper()/pre_validate_design())
is safe to use with Scilab's own path functions.

Scilab has no shell in front of it, so it never expands "~" or resolves a
relative path the way a user might expect -- and its own builtin path
functions (fileparts/isdir/mkdir/toJSON) disagree with each other about
what to do with a path that isn't already absolute (confirmed by direct
testing: mkdir()/isdir() silently resolve "~" to the wrong directory,
while toJSON() silently writes nothing at all, with no error either way).
So instead of letting a bad path fail somewhere deep and confusing (or,
worse, silently write bconfig files to the wrong place), reject it here
with a clear message.

Returns '' if fn is valid. Otherwise returns a human-readable message
explaining what's wrong.
*/
function [msg] = check_valid_filename(fn)
    msg = '';
    if part(fn, 1) == '~' then
        msg = sprintf('Invalid file path: ''%s''', fn);
        msg = msg + ascii(10) + '''~'' is not expanded by Scilab -- there''s no shell in front of it to do that.';
        msg = msg + ascii(10) + 'Please use the real absolute path instead, e.g. ''/home/<user>/...''.';
        return;
    end
    if part(fn, 1) <> '/' then
        msg = sprintf('Invalid file path: ''%s''', fn);
        msg = msg + ascii(10) + 'Please use an absolute path (starting with /), not a relative one.';
        return;
    end
    if ~isfile(fn) then
        msg = sprintf('File not found: ''%s''.', fn);
        return;
    end
endfunction
