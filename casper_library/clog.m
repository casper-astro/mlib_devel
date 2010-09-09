% Output logging information depending on current logging strategy. 
%
% clog(msg, group)
% 
% msg = text msg to display
% group = logging group
%
% All log messages contained in the groups specified by casper_log_groups in your
% Workspace will be displayed. If casper_log_groups is not defined, no log messages
% will be displayed.
% 
% Pre-defined groups; 
% 'all': allows all log entries to be displayed 
% '<file_name>_debug': low-level debugging log entries for specific file
% 'trace': used to trace flow through files
% 'error': errors
%  
% e.g casper_log_groups='trace' - only 'trace' messages will be displayed
% e.g casper_log_groups={'all'} - log messages from any group will be dispalyed
% e.g casper_log_groups={'trace', 'error', 'adder_tree_init_debug'} - 'trace', 'error' 
% and messages from the 'adder_tree_init_debug groups will be displayed (where debug
% messages in 'adder_tree_init.m' are defined as belonging to the 'adder_tree_init_debug'
% group

function clog(msg, group)
%default names of workspace log-level related variables
sys_log_groups_var = 'casper_log_groups';
%sys_log_file_var = 'casper_log_file'; %TODO output to file 

% if a log level variable of the specified name does not exist in the base 
% workspace exit immediately
if evalin('base', ['exist(''',sys_log_groups_var,''')']) == 0 return; end
sys_log_groups = evalin('base',sys_log_groups_var);

% display if the group specified exists in the sys_log_level array
loc_all = strmatch('all', sys_log_groups, 'exact');
loc = strmatch(group, sys_log_groups, 'exact');
if ~(isempty(loc) && isempty(loc_all)), 
    disp([group,': ',msg]);
end
