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

function reuse_block(blk, name, refblk, varargin)
% Instantiate a block named 'name' from library template 'refblk', 
% if no such block already exists.  Otherwise, just configure that
% block with any parameter, value pairs provided in varargin.
% If refblk is has an '_init' function, this may still need to be
% called after this function is called.
%
% reuse_block(blk, name, refblk, varargin)
%
% blk = the overarching system
% name = the name of the block to instantiate
% refblk = the library block to instantiate
% varargin = {'varname', 'value', ...} pairs

existing_blk = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', ...
    'SearchDepth', 1, 'Name', name);
if isempty(existing_blk)
    add_block(refblk, [blk,'/',name], 'Name', name, varargin{:});
else
    set_param([blk,'/',name], varargin{:});
end

