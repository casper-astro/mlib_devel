function revision_control_init(blk, varargin)

check_mask_type(blk, 'revision_control');

defaults = {};
munge_block(blk, varargin{:});
error_on_norcs = get_var('error_on_norcs', 'defaults', defaults, varargin{:});
error_on_dirty = get_var('error_on_dirty', 'defaults', defaults, varargin{:});

got_rcs = 0;
dirty = 0;
lib_dirty = 0;
rcs = 0;
lib_rcs = 0;

path = which(gcs);

% First try tortoiseSVN
[r,m] = system(sprintf('%s %s', 'SubWCRev.exe', path));
if (r == 0) %success
    if (~isempty(regexp(m,'Local modifications'))) % we have local mods
        dirty = 1;
    end

    temp=regexp(m,'Updated to revision (?<rev>\d+)','tokens');
    if (~isempty(temp))
        rcs = str2num(temp{1}{1});
        got_rcs = 1;
    else 
        temp=regexp(m,'Last committed at revision (?<rev>\d+)','tokens');
        if (~isempty(temp))
            rcs = str2num(temp{1}{1});
            got_rcs = 1;
        end
    end    
else % if that failed try straight 'svn'
    [r,m] = system(sprintf('%s %s', 'svn info', path));
    if (r == 0)
        temp=regexp(m,'Revision: (?<rev>\d+)','tokens');
        if (~isempty(temp))
            rcs = str2num(temp{1}{1});
            got_rcs = 1;
        end
    end
    [r,m] = system(sprintf('%s %s', 'svn status 2>/dev/null | grep ''^[AMD]'' | wc -l', path));
    if (r==0)
        if (str2num(m) > 0)
            dirty = 1;
        end
    end
end

if (got_rcs == 0)
    disp('Warning: could not establish version for user design in revision control system');
end

set_param([blk, '/const_uptodate'], 'const', num2str(dirty));
set_param([blk, '/const_rcs'], 'const', num2str(rcs));

if( got_rcs == 0 && strcmp(error_on_norcs, 'on') == 1)
    error('Failed to retrieve revision control information for user design');
end

if (dirty == 1 && strcmp(error_on_dirty, 'on') == 1)
    error('Files in revision control system out-of-date for user design');
end

path = getenv('MLIB_ROOT');
got_rcs = 0;

% First try tortoiseSVN
[r,m] = system(sprintf('%s %s', 'SubWCRev.exe', path));
if (r == 0) %success
    if (~isempty(regexp(m,'Local modifications'))) % we have local mods
        lib_dirty = 1;
    end
    temp=regexp(m,'Updated to revision (?<rev>\d+)','tokens');
    if (~isempty(temp))
        lib_rcs = str2num(temp{1}{1});
        got_rcs = 1;
    else 
        temp=regexp(m,'Last committed at revision (?<rev>\d+)','tokens');
        if (~isempty(temp))
            lib_rcs = str2num(temp{1}{1});
            got_rcs = 1;
        end
    end
else % if that failed try straight 'svn'
    [r,m] = system(sprintf('%s %s', 'svn info', path));
    if (r == 0)
        temp=regexp(m,'Revision: (?<rev>\d+)','tokens');
        if (~isempty(temp))
            lib_rcs = str2num(temp{1}{1});
            got_rcs = 1;
        end
    end
    [r,m] = system(sprintf('%s %s', 'svn status 2>/dev/null | grep ''^[AMD]'' | wc -l', path));
    if (r==0)
        if (str2num(m) > 0)
            lib_dirty = 1;
        end
    end
end

if (got_rcs == 0)
    disp('Warning: could not establish version for libraries in revision control system');
end
    
set_param([blk, '/const_lib_uptodate'], 'const', num2str(lib_dirty));
set_param([blk, '/const_lib_rcs'], 'const', num2str(lib_rcs));

if ((~got_rcs) && strcmp(error_on_norcs, 'on') == 1)
    error('Failed to retrieve revision control information for libraries');
end

if (lib_dirty ~=0 && strcmp(error_on_dirty, 'on') == 1)
    error('Files in revision control system out-of-date for user design');
end


