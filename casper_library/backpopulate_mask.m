% Rewrites mask parameters as strings if short enough, otherwise call to extract.
%
% backpopulate_mask( blk, varargin )
%
% blk - The block whose mask will be modified
% varargin - {'var', 'value', ...} pairs
%
% Cycles through the list of mask parameter variable names. Appends a new cell
% with the variable value (extracted from varargin) as a string to a cell array if
% value short enough, otherwise a call to its value in 'UserData'. Overwrites the
% 'MaskValues' parameter with this new cell array. Essentially converts any pointers
% or references to strings in the mask.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons,                         %
%   Copyright (C) 2008 Andrew Martens                                         %
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


function backpopulate_mask(blk,varargin)

try
  % Match mask names to {variables, values} in varargin
  masknames = get_param(blk, 'MaskNames');
  mv = {};
  for i=1:length(masknames),

      varname = masknames{i};
      value = get_var(varname, varargin{:});

      if isnan(value),
      	error(['No value specified for ',varname]);
      end

     %if parameter too large
      if( length(tostring(value)) > 100 ),
      	mv{i} = ['getfield( getfield( get_param( gcb,''UserData'' ), ''parameters''),''',varname,''')'];
      else
      	mv{i} = tostring(value);
      end

  end
 
  %Back populate mask parameter values
  set_param(blk,'MaskValues',mv);       % This call echos blk name if mv contains a matrix ???
catch ex
  dump_and_rethrow(ex);
end
