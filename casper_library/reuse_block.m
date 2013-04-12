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

% Wrap whole function in try/catch
try

existing_blk = find_system(blk, 'LookUnderMasks', 'all', 'FollowLinks','on', ...
  'SearchDepth', 1, 'Name', name);

% add block straight away if does not yet exist
if isempty(existing_blk),
  add_block(refblk, [blk,'/',name], 'Name', name, varargin{:});

%if the block with that name does exist
else,

  %check Link status
  link_status = get_param(existing_blk, 'StaticLinkStatus');
 
  %inactive link (link disabled but not broken) so get AncestorBlock
  if strcmp(link_status, 'inactive'),
    source = get_param(existing_blk, 'AncestorBlock');
  %resolved link (link in place) so get ReferenceBlock
  elseif strcmp(link_status, 'resolved'),
    source = get_param(existing_blk, 'ReferenceBlock'); 
  
  %no link (broken link, never existed, or built-in) so get block type 
  elseif strcmp(link_status, 'none'),

    block_type = get_param(existing_blk, 'BlockType');
    %if unlinked and not built-in then force replacement
    if strcmp(block_type, 'SubSystem') || strcmp(block_type, 'S-Function'),
      source = '';
    else
      %assuming built-in
      source = strcat('built-in/',block_type);
    end
  else
    source = '';
  end

  % If source is a cell, take its first element so we can log it
  if iscell(source)
    % TODO Warn if length(source) > 1?
    source = source{1};
  end
  
  % Do case-insensitive string comparison
  if strcmpi(source, refblk),
    msg = sprintf('%s is already a "%s" so just setting parameters', name, source);
    clog(msg, 'reuse_block_debug');
    set_param([blk,'/',name], varargin{:});
  else,
    msg = sprintf('%s is a "%s" but want "%s" so replacing', name, source, refblk);
    clog(msg, 'reuse_block_debug');
    delete_block([blk,'/',name]);
    add_block(refblk, [blk,'/',name], 'Name', name, varargin{:});
  end
end % if isempty(existing_blk)
catch ex
    dump_and_rethrow(ex)
end % try/catch
end % function
