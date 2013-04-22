% Output logging information depending on current logging strategy. 
%
% clog(msg, groups)
% 
% msg = text msg to display
% groups = logging group/s
%
% All log messages contained in the groups specified by 'casper_log_groups' in your
% Workspace will be displayed if they are not in 'casper_nolog_groups'. If casper_log_groups 
% is not defined, no log messages will be displayed.
% 
% Pre-defined groups; 
% 'all': allows all log entries to be displayed 
% '<file_name>_debug': low-level debugging log entries for specific file
% 'trace': used to trace flow through files
% 'error': errors
%  
% e.g casper_log_groups='trace', casper_nolog_groups={} - only 'trace' messages will be displayed
% e.g casper_log_groups={'all'}, casper_nolog_groups='trace' - log messages from any group except 'trace' will be dispalyed
% e.g casper_log_groups={'trace', 'error', 'adder_tree_init_debug'}, casper_nolog_groups = {'snap_init_debug'} - 'trace', 'error' 
% and messages from the 'adder_tree_init_debug' groups will be displayed (where debug messages in 'adder_tree_init.m' are defined 
% as belonging to the 'adder_tree_init_debug' group. 'snap_init_debug' messages will not be displayed however.

function clog(msg, groups)
%default names of workspace log-level related variables
sys_log_groups_var = 'casper_log_groups';
sys_nolog_groups_var = 'casper_nolog_groups';
%sys_log_file_var = 'casper_log_file'; %TODO output to file 

if ~isa(groups,'cell'), groups = {groups}; end 

% if a log level variable of the specified name does not exist in the base 
% workspace exit immediately
if evalin('base', ['exist(''',sys_log_groups_var,''')']) == 0 return; end
sys_log_groups = evalin('base',sys_log_groups_var);
if ~isa(sys_log_groups,'cell'), sys_log_groups = {sys_log_groups}; end 

sys_nolog_groups = {};
if evalin('base', ['exist(''',sys_nolog_groups_var,''')']) ~= 0,
  sys_nolog_groups = evalin('base',sys_nolog_groups_var);
end
if ~isa(sys_nolog_groups,'cell'), sys_nolog_groups = {sys_nolog_groups}; end 

loc_all = strmatch('all', sys_log_groups, 'exact');
ex_loc = [];
loc = [];
% convert single element into cell array for comparison

group_string = [];
for n = 1:length(groups),
  group = groups{n};  

  %search for log group in log groups to exclude
  ex_loc = strmatch(group, sys_nolog_groups, 'exact');
  %bail out first time we find it in the list to exclude
  if ~isempty(ex_loc) break; end
 
  %search for log group in log groups to display
  if isempty(loc), loc = strmatch(group, sys_log_groups, 'exact'); end

  %generate group string as we go
  if n ~= 1, group_string = [group_string, ', ']; end
  group_string = [group_string, group];  
end

%check message for sanity
if ~isa(msg,'char'),
  if isa(msg, 'cell') && (length(msg) == 1) && (isa(msg{1}, 'char')),
    msg = msg{1};
  else,
    error('clog: Not passing char arrays as messages');
    return;
  end
end
 
%display if found in one of groups to include and not excluded
if ~(isempty(loc) && isempty(loc_all)) && isempty(ex_loc) , 
  disp([group_string,': ',msg]);
end
