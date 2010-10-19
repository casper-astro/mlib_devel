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

gw_name = [clear_name(gcb),'_TRIG0'];
gw = find_system(gcb, 'FollowLinks','on','LookUnderMasks','all','SearchDepth',1, 'ReferenceBlock', 'xbsIndex_r3/Gateway Out');
set_param(gw{1},'name',gw_name);
arith_type = get_param(gcb,'arith_type');
bitwidth = get_param(gcb, 'bitwidth');
bin_pt = get_param(gcb, 'bin_pt');
if (str2num(bitwidth) > 256) || (str2num(bitwidth) < 1)
	errordlg('The probe input bitwidth must be between 1 and 256');
end

conv = find_system(gcb, 'FollowLinks','on','LookUnderMasks','all','SearchDepth',1, 'ReferenceBlock', 'xbsIndex_r3/Convert');
set_param(conv{1}, 'arith_type', arith_type);
set_param(conv{1}, 'n_bits', bitwidth);
set_param(conv{1}, 'bin_pt', bin_pt);

if str2num(get_param(gcb,'ila_number')) ~= 0
	errordlg('Due to current implementation limitations in EDK 7.1, you can only use one probe in a design and it has to have the ILA number 0');
end
