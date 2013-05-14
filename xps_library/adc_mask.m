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

adc_interleave = get_param(myname, 'adc_interleave');

if strcmp(adc_interleave,'on')
    try
        set_param([myname,'/q0'],'Name', 'o0');
        set_param([myname,'/i0'],'Name', 'o1');
        set_param([myname,'/q1'],'Name', 'o2');
        set_param([myname,'/i1'],'Name', 'o3');
        set_param([myname,'/q2'],'Name', 'o4');
        set_param([myname,'/i2'],'Name', 'o5');
        set_param([myname,'/q3'],'Name', 'o6');
        set_param([myname,'/i3'],'Name', 'o7');

        set_param([myname,'/outofrangeq0'],'Name', 'outofrange0');
        set_param([myname,'/outofrangei0'],'Name', 'outofrange1');
        set_param([myname,'/outofrangeq1'],'Name', 'outofrange2');
        set_param([myname,'/outofrangei1'],'Name', 'outofrange3');

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

        set_param([myname,'/Downsamplei0'],'N','8');
        set_param([myname,'/Downsamplei1'],'N','8');
        set_param([myname,'/Downsamplei2'],'N','8');
        set_param([myname,'/Downsamplei3'],'N','8');
        set_param([myname,'/Downsampleq0'],'N','8');
        set_param([myname,'/Downsampleq1'],'N','8');
        set_param([myname,'/Downsampleq2'],'N','8');
        set_param([myname,'/Downsampleq3'],'N','8');

        set_param([myname,'/Downsamplesync0'],'N','8');
        set_param([myname,'/Downsamplesync1'],'N','8');
        set_param([myname,'/Downsamplesync2'],'N','8');
        set_param([myname,'/Downsamplesync3'],'N','8');

        set_param([myname,'/Downsamplei0'],'phase','1');
        set_param([myname,'/Downsamplei1'],'phase','3');
        set_param([myname,'/Downsamplei2'],'phase','5');
        set_param([myname,'/Downsamplei3'],'phase','7');
        set_param([myname,'/Downsampleq0'],'phase','0');
        set_param([myname,'/Downsampleq1'],'phase','2');
        set_param([myname,'/Downsampleq2'],'phase','4');
        set_param([myname,'/Downsampleq3'],'phase','6');

        set_param([myname,'/Downsamplesync0'],'phase','0');
        set_param([myname,'/Downsamplesync1'],'phase','2');
        set_param([myname,'/Downsamplesync2'],'phase','4');
        set_param([myname,'/Downsamplesync3'],'phase','6');

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
% end if strcmp(adc_interleave,'on')
else
    try
        set_param([myname,'/o0'],'Name', 'q0');
        set_param([myname,'/o1'],'Name', 'i0');
        set_param([myname,'/o2'],'Name', 'q1');
        set_param([myname,'/o3'],'Name', 'i1');
        set_param([myname,'/o4'],'Name', 'q2');
        set_param([myname,'/o5'],'Name', 'i2');
        set_param([myname,'/o6'],'Name', 'q3');
        set_param([myname,'/o7'],'Name', 'i3');

        set_param([myname,'/outofrange0'],'Name', 'outofrangeq0');
        set_param([myname,'/outofrange1'],'Name', 'outofrangei0');
        set_param([myname,'/outofrange2'],'Name', 'outofrangeq1');
        set_param([myname,'/outofrange3'],'Name', 'outofrangei1');

        set_param([myname,'/i0'],'Port', '1');
        set_param([myname,'/i1'],'Port', '2');
        set_param([myname,'/i2'],'Port', '3');
        set_param([myname,'/i3'],'Port', '4');
        set_param([myname,'/q0'],'Port', '5');
        set_param([myname,'/q1'],'Port', '6');
        set_param([myname,'/q2'],'Port', '7');
        set_param([myname,'/q3'],'Port', '8');

        set_param([myname,'/outofrangeq0'],'Port', '11');
        set_param([myname,'/outofrangei0'],'Port', '9');
        set_param([myname,'/outofrangeq1'],'Port', '12');
        set_param([myname,'/outofrangei1'],'Port', '10');

        set_param([myname,'/Downsamplei0'],'phase','0');
        set_param([myname,'/Downsamplei1'],'phase','1');
        set_param([myname,'/Downsamplei2'],'phase','2');
        set_param([myname,'/Downsamplei3'],'phase','3');
        set_param([myname,'/Downsampleq0'],'phase','0');
        set_param([myname,'/Downsampleq1'],'phase','1');
        set_param([myname,'/Downsampleq2'],'phase','2');
        set_param([myname,'/Downsampleq3'],'phase','3');

        set_param([myname,'/Downsamplesync0'],'phase','0');
        set_param([myname,'/Downsamplesync1'],'phase','1');
        set_param([myname,'/Downsamplesync2'],'phase','2');
        set_param([myname,'/Downsamplesync3'],'phase','3');

        set_param([myname,'/Downsamplei0'],'N','4');
        set_param([myname,'/Downsamplei1'],'N','4');
        set_param([myname,'/Downsamplei2'],'N','4');
        set_param([myname,'/Downsamplei3'],'N','4');
        set_param([myname,'/Downsampleq0'],'N','4');
        set_param([myname,'/Downsampleq1'],'N','4');
        set_param([myname,'/Downsampleq2'],'N','4');
        set_param([myname,'/Downsampleq3'],'N','4');

        set_param([myname,'/Downsamplesync0'],'N','4');
        set_param([myname,'/Downsamplesync1'],'N','4');
        set_param([myname,'/Downsamplesync2'],'N','4');
        set_param([myname,'/Downsamplesync3'],'N','4');

        set_param([myname,'/delayi0'],'NumDelays','2');

        delete_line(myname,'sim_in/1','gain/1');
        delete_line(myname,'gain/1','bias/1');
        delete_line(myname,'bias/1','Downsamplei0/1');
        delete_line(myname,'bias/1','Downsamplei1/1');
        delete_line(myname,'bias/1','Downsamplei2/1');
        delete_line(myname,'bias/1','Downsamplei3/1');
        delete_line(myname,'bias/1','Downsampleq0/1');
        delete_line(myname,'bias/1','Downsampleq1/1');
        delete_line(myname,'bias/1','Downsampleq2/1');
        delete_line(myname,'bias/1','Downsampleq3/1');

        delete_block([myname,'/sim_in']);
        delete_block([myname,'/gain']);
        delete_block([myname,'/bias']);

        add_block(['built-in/inport'],[myname,'/sim_i'], 'Position', [15 173 45 187],   'Port', '1');
        add_block(['built-in/gain'],  [myname,'/gain_i'],'Position', [95 170 125 190],  'Gain', '127.5');
        add_block(['built-in/bias'],  [myname,'/bias_i'],'Position', [165 170 195 190], 'Bias', '127.5');
        add_block(['built-in/inport'],[myname,'/sim_q'], 'Position', [15 598 45 612],   'Port', '2');
        add_block(['built-in/gain'],  [myname,'/gain_q'],'Position', [95 595 125 615],  'Gain', '127.5');
        add_block(['built-in/bias'],  [myname,'/bias_q'],'Position', [165 596 195 615], 'Bias', '127.5');

        add_line(myname,'sim_i/1','gain_i/1');
        add_line(myname,'gain_i/1','bias_i/1');
        add_line(myname,'bias_i/1','Downsamplei0/1');
        add_line(myname,'bias_i/1','Downsamplei1/1');
        add_line(myname,'bias_i/1','Downsamplei2/1');
        add_line(myname,'bias_i/1','Downsamplei3/1');
        add_line(myname,'sim_q/1','gain_q/1');
        add_line(myname,'gain_q/1','bias_q/1');
        add_line(myname,'bias_q/1','Downsampleq0/1');
        add_line(myname,'bias_q/1','Downsampleq1/1');
        add_line(myname,'bias_q/1','Downsampleq2/1');
        add_line(myname,'bias_q/1','Downsampleq3/1');

        set_param([myname,'/sim_i'],   'SampleTime','sample_period/4');
        set_param([myname,'/sim_q'],   'SampleTime','sample_period/4');
        set_param([myname,'/sim_sync'],'SampleTime','sample_period/4');
    end % try
end % if strcmp(adc_interleave,'on') else

% Try to set options required for Downsample block of newer DSP blockset
% versions, but not available in older versions.
for k=0:3
    try
        set_param([myname, '/Downsamplei',num2str(k)], ...
          'InputProcessing', 'Elements as channels (sample based)', ...
          'RateOptions', 'Allow multirate processing');
        set_param([myname, '/Downsampleq',num2str(k)], ...
          'InputProcessing', 'Elements as channels (sample based)', ...
          'RateOptions', 'Allow multirate processing');
        set_param([myname, '/Downsamplesync',num2str(k)], ...
          'InputProcessing', 'Elements as channels (sample based)', ...
          'RateOptions', 'Allow multirate processing');
    catch
        break;
    end
end

gateway_ins = find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for n = 1:length(gateway_ins)
    gw = gateway_ins{n};
    if regexp(get_param(gw,'Name'),'(user_data[iq]\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_data[iq]\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_outofrange[iq]\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_outofrange[iq]\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_sync\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_sync\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_data_valid)$')
        toks = regexp(get_param(gw,'Name'),'(user_data_valid)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unkown gateway name: ',gw]);
    end
end % for n = 1:length(gateway_ins)
