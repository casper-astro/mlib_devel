%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

myname = gcb;
%set_param(myname, 'LinkStatus', 'inactive');

try
    set_param([myname,'/0'],'Name', 'o0');
    set_param([myname,'/1'],'Name', 'o1');
    set_param([myname,'/2'],'Name', 'o2');
    set_param([myname,'/3'],'Name', 'o3');
    set_param([myname,'/4'],'Name', 'o4');
    set_param([myname,'/5'],'Name', 'o5');
    set_param([myname,'/6'],'Name', 'o6');
    set_param([myname,'/7'],'Name', 'o7');

    set_param([myname,'/outofrange0'],'Name', 'outofrange0');
    set_param([myname,'/outofrange1'],'Name', 'outofrange1');
    set_param([myname,'/outofrange2'],'Name', 'outofrange2');
    set_param([myname,'/outofrange3'],'Name', 'outofrange3');
    set_param([myname,'/outofrange4'],'Name', 'outofrange0');
    set_param([myname,'/outofrange5'],'Name', 'outofrange1');
    set_param([myname,'/outofrange6'],'Name', 'outofrange2');
    set_param([myname,'/outofrange7'],'Name', 'outofrange3');

    set_param([myname,'/o0'],'Port', '1');
    set_param([myname,'/o1'],'Port', '2');
    set_param([myname,'/o2'],'Port', '3');
    set_param([myname,'/o3'],'Port', '4');
    set_param([myname,'/o4'],'Port', '5');
    set_param([myname,'/o5'],'Port', '6');
    set_param([myname,'/o6'],'Port', '7');
    set_param([myname,'/o7'],'Port', '8');

    set_param([myname,'/outofrange0'],'Port', '9');
    set_param([myname,'/outofrange1'],'Port', '10');
    set_param([myname,'/outofrange2'],'Port', '11');
    set_param([myname,'/outofrange3'],'Port', '12');
    set_param([myname,'/outofrange4'],'Port', '13');
    set_param([myname,'/outofrange5'],'Port', '14');
    set_param([myname,'/outofrange6'],'Port', '15');
    set_param([myname,'/outofrange7'],'Port', '16');

    set_param([myname,'/Downsamplei0'],'N','8');
    set_param([myname,'/Downsamplei1'],'N','8');
    set_param([myname,'/Downsamplei2'],'N','8');
    set_param([myname,'/Downsamplei3'],'N','8');
    set_param([myname,'/Downsampleq0'],'N','8');
    set_param([myname,'/Downsampleq1'],'N','8');
    set_param([myname,'/Downsampleq2'],'N','8');
    set_param([myname,'/Downsampleq3'],'N','8');

    set_param([myname,'/Downsamplesync'],'N','8');


    set_param([myname,'/Downsamplei0'],'phase','1');
    set_param([myname,'/Downsamplei1'],'phase','3');
    set_param([myname,'/Downsamplei2'],'phase','5');
    set_param([myname,'/Downsamplei3'],'phase','7');
    set_param([myname,'/Downsampleq0'],'phase','0');
    set_param([myname,'/Downsampleq1'],'phase','2');
    set_param([myname,'/Downsampleq2'],'phase','4');
    set_param([myname,'/Downsampleq3'],'phase','6');

    set_param([myname,'/Downsamplesync'],'phase','0');


    set_param([myname,'/delayi0'],'NumDelays','1');

    delete_line(myname,'sim_i/1','gain_i/1');
    delete_line(myname,'gain_i/1','bias_i/1');
    delete_line(myname,'bias_i/1','Downsamplei0/1');
    delete_line(myname,'bias_i/1','Downsamplei1/1');
    delete_line(myname,'bias_i/1','Downsamplei2/1');
    delete_line(myname,'bias_i/1','Downsamplei3/1');

    delete_line(myname,'sim_q/1','gain_q/1');
    delete_line(myname,'gain_q/1','bias_q/1');
    delete_line(myname,'bias_q/1','Downsampleq0/1');
    delete_line(myname,'bias_q/1','Downsampleq1/1');
    delete_line(myname,'bias_q/1','Downsampleq2/1');
    delete_line(myname,'bias_q/1','Downsampleq3/1');

    delete_block([myname,'/sim_i']);
    delete_block([myname,'/gain_i']);
    delete_block([myname,'/bias_i']);
    delete_block([myname,'/sim_q']);
    delete_block([myname,'/gain_q']);
    delete_block([myname,'/bias_q']);

    add_block(['built-in/inport'],[myname,'/sim_in'],'Position', [15 383 45 397],   'Port', '1');
    add_block(['built-in/gain'],  [myname,'/gain'],  'Position', [95 380 125 400],  'Gain', '127.5');
    add_block(['built-in/bias'],  [myname,'/bias'],  'Position', [165 380 195 400], 'Bias', '127.5');

    add_line(myname,'sim_in/1','gain/1');
    add_line(myname,'gain/1','bias/1');
    add_line(myname,'bias/1','Downsamplei0/1');
    add_line(myname,'bias/1','Downsamplei1/1');
    add_line(myname,'bias/1','Downsamplei2/1');
    add_line(myname,'bias/1','Downsamplei3/1');
    add_line(myname,'bias/1','Downsampleq0/1');
    add_line(myname,'bias/1','Downsampleq1/1');
    add_line(myname,'bias/1','Downsampleq2/1');
    add_line(myname,'bias/1','Downsampleq3/1');

    set_param([myname,'/sim_in'],'SampleTime','sample_period/8');
    set_param([myname,'/sim_sync'],'SampleTime','sample_period/8');
end % try


gateway_ins = find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for n = 1:length(gateway_ins)
    gw = gateway_ins{n};
    if regexp(get_param(gw,'Name'),'(user_data\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_data\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_outofrange\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_outofrange\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_sync)$')
        toks = regexp(get_param(gw,'Name'),'(user_sync)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_data_valid)$')
        toks = regexp(get_param(gw,'Name'),'(user_data_valid)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end    
end % for n = 1:length(gateway_ins)

gateway_outs = find_system(gcb,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(user_bist)$')
        toks = regexp(get_param(gw,'Name'),'(user_bist)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_asyncrst)$')
        toks = regexp(get_param(gw,'Name'),'(user_asyncrst)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end
