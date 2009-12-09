function revision_control_init(blk, varargin)

disp('entering');
check_mask_type(blk, 'revision_control');

defaults = {};
error_on_norcs = get_var('error_on_norcs', 'defaults', defaults, varargin{:});
error_on_dirty = get_var('error_on_dirty', 'defaults', defaults, varargin{:});

got_lib_rcs = 0;
got_usr_rcs = 0;
usr_dirty = 0;
lib_dirty = 0;
usr_rcs = 0;
lib_rcs = 0;

% First try tortoiseSVN
path = which(gcs);

[usr_r,usr_rev] = system(sprintf('%s %s', 'SubWCRev.exe', path));

if (usr_r == 0) %success
    if (~isempty(regexp(usr_rev,'Local modifications'))) % we have local mods
        usr_dirty = 1;
    end

    temp=regexp(usr_rev,'Updated to revision (?<rev>\d+)','tokens');
    if (~isempty(temp))
        usr_rcs = str2num(temp{1}{1});
        got_usr_rcs = 1;
    else 
        temp=regexp(usr_rev,'Last committed at revision (?<rev>\d+)','tokens');
        if (~isempty(temp))
            usr_rcs = str2num(temp{1}{1});
            got_usr_rcs = 1;
        end
    end    
else % if that failed try straight 'svn'
    [usr_r,usr_rev] = system(sprintf('%s %s', 'svn info', path));
    if (usr_r == 0)
        temp=regexp(usr_rev,'Revision: (?<rev>\d+)','tokens');
        if (~isempty(temp))
            usr_rcs = str2num(temp{1}{1});
            got_usr_rcs = 1;
        end
    end
    [usr_r,usr_rev] = system(sprintf('%s %s', 'svn status 2>/dev/null | grep ''^[AMD]'' | wc -l', path));
    if (usr_r==0)
        if (str2num(usr_rev) > 0)
            usr_dirty = 1;
        end
    end
end

path = getenv('MLIB_ROOT');

% First try tortoiseSVN
[lib_r,lib_rev] = system(sprintf('%s %s', 'SubWCRev.exe', path));

if (lib_r == 0) %success
    if (~isempty(regexp(lib_rev ,'Local modifications'))) % we have local mods
        lib_dirty = 1;
    end
    temp=regexp(lib_rev ,'Updated to revision (?<rev>\d+)','tokens');
    if (~isempty(temp))
        lib_rcs = str2num(temp{1}{1});
        got_lib_rcs = 1;
    else 
        temp=regexp(lib_rev ,'Last committed at revision (?<rev>\d+)','tokens');
        if (~isempty(temp))
            lib_rcs = str2num(temp{1}{1});
            got_lib_rcs = 1;
        end
    end
else % if that failed try straight 'svn'
    [lib_r,lib_rev] = system(sprintf('%s %s', 'svn info', path));
    if (lib_r == 0)
        temp=regexp(lib_rev ,'Revision: (?<rev>\d+)','tokens');
        if (~isempty(temp))
            lib_rcs = str2num(temp{1}{1});
            got_lib_rcs = 1;
        end
    end
    [lib_r,lib_rev] = system(sprintf('%s %s', 'svn status 2>/dev/null | grep ''^[AMD]'' | wc -l', path));
    if (lib_r==0)
        if (str2num(lib_rev) > 0)
            lib_dirty = 1;
        end
    end
end

vec = {varargin{:}, 'usr_rev', usr_rcs, 'usr_dirty', usr_dirty, 'lib_rev', lib_rcs, 'lib_dirty', lib_dirty};

if same_state(blk, 'defaults', defaults, vec{:}), return, end
%disp('munging');
munge_block(blk, vec{:});
%disp('got_usr_rcs');
if (got_usr_rcs == 0)
    disp('Warning: could not establish version for user design in revision control system');
end

%disp('usr_dirty');
set_param([blk, '/const_uptodate'], 'const', num2str(usr_dirty));
%disp('usr_rcs');
set_param([blk, '/const_rcs'], 'const', num2str(usr_rcs));

%disp('lib');
if (got_lib_rcs == 0)
    disp('Warning: could not establish version for libraries in revision control system');
end
%disp('lib_dirty');    
set_param([blk, '/const_lib_uptodate'], 'const', num2str(lib_dirty));
%disp('lib_rcs');
set_param([blk, '/const_lib_rcs'], 'const', num2str(lib_rcs));

%disp('saving state');
save_state(blk, 'defaults', defaults, vec{:});

if ( got_lib_rcs == 0  && strcmp(error_on_norcs, 'on') == 1)
    error('Failed to retrieve revision control information for libraries');
end
if ( got_usr_rcs == 0  && strcmp(error_on_norcs, 'on') == 1)
    error('Failed to retrieve revision control information for user design');
end

%disp('lib dirty');
if (lib_dirty == 1 && strcmp(error_on_dirty, 'on') == 1)
    error('Files in revision control system out-of-date for libraries');
end
%disp('usr dirty');
if (usr_dirty == 1 && strcmp(error_on_dirty, 'on') == 1)
    error('Files in revision control system out-of-date for user design');
end

disp('exiting');
