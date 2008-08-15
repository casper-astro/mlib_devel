%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006-2007 Terry Filiba, David MacMahon, Aaron Parsons       %
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

function propagate_vars(blk, varargin)
% Propagates values from varargin to parameters in blk of the same name. 
% If varname is not found, looks for 'defaults' and tries to find varname 
% in there.  
%
% value = get_var(varname, varargin)
%
% blk = the block to propagate to.
% varargin = {'varname', value, ...} pairs

params = fieldnames(get_param(blk, 'DialogParameters'));
% loop through the block parameters
for i=1:length(params),
    % find that parameter in the current block or defaults
    found = get_var(params{i},varargin{:});  
    % if parameter of the same name is found, copy
    if ~isnan(found),
    	set_param(blk, params{i}, tostring(found));
    end
end

