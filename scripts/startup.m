warning off Simulink:SL_LoadMdlParameterizedLink;

hostname = getenv('HOSTNAME');
mlib_mode = getenv('MLIB_MODE');

disp 'Running sysgen startup script...'
sysgen_startup;

root_path = '';
if strcmp(mlib_mode, '0')
        disp 'mlib_mode=0'
	root_path = '/designs/casper_git/mlib_devel/';
elseif strcmp('phaezar', getenv('HOSTNAME')) && strcmp(mlib_mode, '1')
        disp 'mlib_mode=1,m'
	root_path = '/designs/casper_git/sandbox/mlib_devel/';
elseif strcmp('maezar', getenv('HOSTNAME')) && strcmp(mlib_mode, '1')
        disp 'mlib_mode=1,p'
	root_path = '/designs/casper_git/ox_devel/mlib_devel/';
end

disp 'adding xps_library'
addpath(strcat(root_path,'xps_library'));

disp 'adding casper_library'
addpath(strcat(root_path,'casper_library'));

disp 'adding gavrt_library'
addpath(strcat(root_path,'gavrt_library'));

disp 'adding ox_lib'
if strcmp('phaezar', getenv('HOSTNAME'))
	addpath('/designs/casper_git/sandbox/mlib_devel/ox_library');
elseif strcmp('maezar', getenv('HOSTNAME'))
	addpath('/designs/casper_git/ox_devel/mlib_devel/ox_library');
end

disp 'adding fftt_lib'
if strcmp('phaezar', getenv('HOSTNAME'))
	disp '...skipping';
elseif strcmp('maezar', getenv('HOSTNAME'))
	addpath('/home/jack/MIT/fftt/fftt_library');
end
system_dependent('RemoteCWDPolicy','reload');
system_dependent('RemotePathPolicy','reload');

disp 'loading libraries'
disp ([10, 'Kernel panic - sync error'])
disp 'Critical Failure Imminent'
load_system('casper_library');
load_system('gavrt_library');
load_system('ox_lib');
load_system('xps_library');

if strcmp('maezar', getenv('HOSTNAME'))
	load_system('fftt_library');
end

disp ':-)'

disp 'starting simulink...'
simulink;
