% Determines if a block's state matches the arguments.
%
% blk = The block to check
% varargin = A cell array of things to compare.
%
% The compares the block's UserData parameter with the contents of
% varargin.  If they match, this function returns true.  If they do not
% match, this function returns false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function match = same_state(blk,varargin)

match = 0;
try
    % Recognize 'force_same_state' to mean always return true.  Utility scripts
    % such as update_block can use this to defer running the mask
    % initialization script.
    user_data = get_param(blk,'UserData');
    if strcmp(user_data, 'force_same_state') ...
    || getfield(user_data, 'state') == hashcell(varargin)
      match = 1;
    end
catch
end
