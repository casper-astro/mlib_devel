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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
%                                                                             %
%   MeerKAT Radio Telescope Project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2013 Andrew Martens (meerKAT)                               %
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

% Wrap whole function in try/catch
try

  existing_blks = find_system(blk, ...
    'lookUnderMasks', 'all', 'FollowLinks','on', ...
    'SearchDepth', 1, 'Name', name);

  % Just add block straight away if does not yet exist
  if isempty(existing_blks)
    add_block(refblk, [blk,'/',name], 'Name', name, varargin{:});
    % Done!
    return
  end

  % If find_system returned more than one block (should "never" happen, but
  % sometimes it does!)
  if length(existing_blks) > 1
    % Get their handles to see whether they are really the same block
    handles = cell(size(existing_blks));
    for k = 1:length(existing_blks)
      handles{k} = num2str(get_param(existing_blks{k}, 'Handle'));
    end

    % If more than one handle (should "really never" happen...)
    if length(unique(handles)) > 1
      error('casper:MultipleBlocksForName', ...
            'More than one block in "%s" has name "%s"', blk, name);
    end
  end

  % A block with that name does exist, so re-use it
  existing_blk = existing_blks{1};
  
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

    %if weird (subsystem or s-function not from library)   
    if strcmp(block_type, 'SubSystem') || strcmp(block_type, 'S-Function'),
      clog([name,': built-in/',block_type,' so forcing replacement'], 'reuse_block_debug');
      source = '';
    else
      %assuming built-in
      source = strcat('built-in/',block_type);
    end
  
  %implicit library block
  elseif strcmp(link_status, 'implicit'),
    
    anc_block = get_param(existing_blk, 'AncestorBlock');
    %we have a block in the library derived from another block
    if ~isempty(anc_block),
      source = anc_block;
    %we have a block without a source or built-in
    else,
      block_type = get_param(existing_blk, 'BlockType');

      %if weird (subsystem or s-function not from library)   
      if strcmp(block_type, 'SubSystem') || strcmp(block_type, 'S-Function'),
        clog([name,': built-in/',block_type,' so forcing replacement'], 'reuse_block_debug');
        source = '';
      else,
        %assuming built-in
        source = strcat('built-in/',block_type);
      end
    end  %if ~isempty
  else,
    clog([name,' not a library block and not built-in so force replace'], 'reuse_block_debug');
    source = '';
  end

  % If source is a cell, take its first element so we can log it
  if iscell(source)
    % TODO Warn if length(source) > 1?
    source = source{1};
  end

  % Change newlines in source to spaces
  source = strrep(source, char(10), ' ');
  
  % Do case-insensitive string comparison
  if strcmpi(source, refblk),
    msg = sprintf('%s is already a "%s" so just setting parameters', name, source);
    clog(msg, {'reuse_block_debug', 'reuse_block_reuse'});
    if ~isempty(varargin),
      set_param([blk,'/',name], varargin{:});
    end
  else,
    if evalin('base','exist(''casper_force_reuse_block'')') ...
    && evalin('base','casper_force_reuse_block')
      msg = sprintf('%s is a "%s" and want "%s" but reuse is being forced', name, source, refblk);
      % Log as reuse_block_replace even though reuse is being forced
      clog(msg, {'reuse_block_debug', 'reuse_block_replace'});
      set_param([blk,'/',name], varargin{:});
    else
      msg = sprintf('%s is a "%s" but want "%s" so replacing', name, source, refblk);
      clog(msg, {'reuse_block_debug', 'reuse_block_replace'});
      delete_block([blk,'/',name]);
      add_block(refblk, [blk,'/',name], 'Name', name, varargin{:});
    end
  end
catch ex
    dump_and_rethrow(ex)
end % try/catch
end % function
