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

function str = gen_ucf(blk_obj)

str = '';

hw_sys  = blk_obj.hw_sys;
app_clk = blk_obj.clk_src;
app_clk_rate = blk_obj.clk_rate;

if ~isempty(strmatch(app_clk, {'aux_clk', 'aux_clk2x', 'aux0_clk', 'aux1_clk', 'aux0_clk2x'}))

    toks = regexp(app_clk, '(.+_clk)2x', 'tokens');

    if isempty(toks)
        clk_rate_constraint = num2str(app_clk_rate);
        timespec_clk = app_clk;
    else
        clk_rate_constraint = num2str(app_clk_rate/2);
        timespec_clk = toks{1}{1};
    end % if isempty(toks)

    str = [str, '##############################################\n'];
    str = [str, '# External Clock constraints                 #\n'];
    str = [str, '##############################################\n'];
    str = [str, '\n'];
    str = [str, 'NET "', timespec_clk,'_p" TNM_NET = "', timespec_clk,'_p" ;\n'];

    str = [str, 'TIMESPEC "TS_', timespec_clk,'_p" = PERIOD "', timespec_clk, '_p" ', clk_rate_constraint,' MHz ;\n'];

    str = [str, '\n\n'];
end % if ~isempty(strmatch(app_clk, {'aux0_clk', 'aux1_clk', 'aux0_clk2x'}))

str = [str, gen_ucf(blk_obj.xps_block)];
