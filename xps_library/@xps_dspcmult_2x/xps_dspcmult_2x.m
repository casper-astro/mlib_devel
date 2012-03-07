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

function b = xps_dspcmult_2x(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_DSPCMULT_2X class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_dspcmult_2x')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys  = get(xsg_obj,'hw_sys');

switch s.hw_sys
    case 'iBOB'
        error(['Unsupported hardwar system: ',s.hw_adc]);
    % end case 'iBOB'
    case 'ROACH'
    % end case 'ROACH'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_dspcmult_2x',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'dspcmult_2x');
switch s.hw_sys
    case 'ROACH'
        b = set(b, 'ip_version', '1.00.a');
end % switch s.hw_sys

% misc ports
misc_ports.dsp_clk     = {1 'in'  'dspmult_2x_clk'};
misc_ports.app_clk     = {1 'in'  get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);
