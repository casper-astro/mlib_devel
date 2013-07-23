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

% Validate that no parameters values are empty (but empty "defaults" is OK)
for j = 1:length(varargin)/2,
  if isempty(varargin{j*2}) && ~strcmp('defaults', varargin{j*2-1})
    link = sprintf('<a href="matlab:hilite_system(''%s'')">%s</a>', ...
        blk, blk);
    ex = MException('casper:emptyMaskParamError', ...
        'Parameter %s of %s is empty in same_state!', varargin{j*2-1}, link);
    % We use dump_and_rethrow instead of just throw because chances are that
    % this is running inside a mask init callback which will silently ignore
    % the exception and abort the mask init callback.  Using dump_and_rethrow
    % means that the user will be alerted to this error condition even if the
    % caller ignores it.
    dump_and_rethrow(ex);
  end
end

try
    match = getfield( get_param(blk,'UserData'), 'state') == hashcell(varargin);
catch
    match = 0;
end

%forces update of mask
%backpopulate_mask(blk,varargin{:});

