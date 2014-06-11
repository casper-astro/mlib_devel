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
function x64_adc_mask(blk, varargin)

check_mask_type(blk, 'x64_adc');
myname = blk;
use_spi = get_var('spi', varargin{:});

munge_block(myname);


% create SPI ports if interface enabled
if use_spi == 1
   % try
        add_block(['built-in/inport'],[myname,'/sdata'],'Position', [510 190 540 210],   'Port', '19');
        add_block(['built-in/inport'],[myname,'/spi_strb' ],'Position', [510 270 540 290],   'Port', '20');

        add_block(['xbsIndex_r4/Gateway Out'],[myname,'/user_sdata' ],'Position', [705 190 765 210]);
        add_block(['xbsIndex_r4/Gateway Out'],[myname,'/user_spi_strb'  ],'Position', [705 270 765 290]);

        add_block(['xbsIndex_r4/Convert'],[myname,'/sdata_conv' ],'Position', [595 185 640 215], ...
        'arith_type', 'Unsigned', 'n_bits', '8', 'bin_pt', '0');
        add_block(['xbsIndex_r4/Convert'],[myname,'/spi_strb_conv'  ],'Position', [595 265 640 295], ...
        'arith_type', 'Unsigned', 'n_bits', '1', 'bin_pt', '0');

        add_block(['built-in/terminator'],[myname,'/sdata_term'],'Position', [845 190 865 210]);
        add_block(['built-in/terminator'],[myname,'/spi_strb_term' ],'Position', [845 270 865 290]);

        add_line(myname,'sdata/1','sdata_conv/1');
        add_line(myname,'spi_strb/1' ,'spi_strb_conv/1');

        add_line(myname,'sdata_conv/1','user_sdata/1');
        add_line(myname,'spi_strb_conv/1' ,'user_spi_strb/1');

        add_line(myname,'user_sdata/1','sdata_term/1');
        add_line(myname,'user_spi_strb/1' ,'spi_strb_term/1');
    %end

else %delete the SPI ports
    try
        delete_line(myname, 'sdata/1', 'sdata_conv/1');
        delete_line(myname, 'spi_strb/1' , 'spi_strb_conv/1');
        
        delete_line(myname, 'sdata_conv/1', [strrep([myname, '_user_sdata'], '/', '_'), '/1']);
        delete_line(myname, 'spi_strb_conv/1', [strrep([myname, '_user_spi_strb'], '/', '_'), '/1']);
        
        delete_line(myname, [strrep([myname, '_user_sdata'], '/', '_'), '/1'], 'sdata_term/1');
        delete_line(myname, [strrep([myname, '_user_spi_strb'], '/', '_'), '/1'], 'spi_strb_term/1');
    end
    try
        delete_block([myname,'/sdata']);
        delete_block([myname,'/spi_strb']);

        delete_block([myname,'/user_sdata']);
        delete_block([myname,'/user_spi_strb']);

        delete_block([myname,'/sdata_conv']);
        delete_block([myname,'/spi_strb_conv']);

        delete_block([myname,'/sdata_term']);
        delete_block([myname,'/spi_strb_term']);
    end
end

clean_blocks(myname);

% relabel the gateway ins...
gateway_ins = find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for n = 1:length(gateway_ins)
    gw = gateway_ins{n};
    if regexp(get_param(gw,'Name'),'(user_data\d+)$')
        toks = regexp(get_param(gw,'Name'),'(user_data\d+)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_chan_sync)$')
        toks = regexp(get_param(gw,'Name'),'(user_chan_sync)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end 

% relabel the gateway outs...
gateway_outs = find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway Out Block');
for n = 1:length(gateway_outs)
    gw = gateway_outs{n};
    if regexp(get_param(gw,'Name'),'(user_rst)$')
        toks = regexp(get_param(gw,'Name'),'(user_rst)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_sdata)$')
        toks = regexp(get_param(gw,'Name'),'(user_sdata)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(user_spi_strb)$')
        toks = regexp(get_param(gw,'Name'),'(user_spi_strb)$','tokens');
        set_param(gw,'Name',clear_name([gcb,'_',toks{1}{1}]));
    else
        error(['Unknown gateway name: ',gw]);
    end
end

