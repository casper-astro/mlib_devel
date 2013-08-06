%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2013 David MacMahon
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

% This function updates casper_library and xps_library blocks in sys using the
% most recent library versions.  Mask parameters are copied over whenever
% possible.  If sys is a block diagram and is not a library, its solver
% parameters are updated using xlConfigureSolver.
%
% varargin is for experts only!  It can be used to specify extra options to
% find_system.
function update_casper_blocks(sys, varargin)

  % Clear last dumped exception to ensure that all exceptions are shown.
  dump_exception([]);

  % For now, we require that sys is either an unlinked subsytem or a
  % block_diagram
  type = get_param(sys,'Type');
  if strcmpi(type, 'block')
    % Make sure it is subsystem that is not linked to a library
    block_type = get_param(sys,'BlockType');
    if ~strcmpi(block_type, 'SubSystem')
      error('Block %s is not a SubSystem', sys);
    end
    link_status = get_param(sys,'LinkStatus');
    if ~strcmpi(link_status, 'none')
      error('SubSystem block %s appears to be linked to a library', sys);
    end
  elseif strcmpi(type, 'block_diagram')
    % If it is not a library
    if strcmpi(get_param(sys, 'LibraryType'), 'None')
      fprintf('configuring solver for block diagram %s...\n', sys);
      xlConfigureSolver(sys);
    end
  else
    error('%s is not a block diagram or a block', sys);
  end

  fprintf('searching for CASPER blocks to update in %s...', sys);

  ref_blks = find_system(sys, ...
      'RegExp', 'on', ...
      'LookUnderMasks', 'all', ...
      'FollowLinks', 'off', ...
      varargin{:}, ...
      'ReferenceBlock', '(casper|xps)_library');

  %fprintf('found %d blocks with ReferenceBlock\n', length(ref_blks));
  %for k = 1:length(ref_blks)
  %  fprintf('  %3d %s\n', k, ref_blks{k});
  %end
  
  anc_blks = find_system(sys, ...
      'RegExp', 'on', ...
      'LookUnderMasks', 'all', ...
      'FollowLinks', 'off', ...
      varargin{:}, ...
      'AncestorBlock', '(casper|xps)_library');

  %fprintf('found %d blocks with AncestorBlock\n', length(anc_blks));
  %for k = 1:length(anc_blks)
  %  fprintf('  %3d %s\n', k, anc_blks{k});
  %end

  % Concatenate the lists of blocks then sort.  Sorting the list optimizes the
  % culling process that follows.
  blks = sort([ref_blks; anc_blks]);

  % Even though we say "FollowLinks=off", find_system will still search through
  % block's with disabled links.  To make sure we don't update blocks inside
  % subsystems with disabled links, we need to cull the list of blocks.  For
  % each block found, we remove any blocks that start with "block_name/".
  keepers = ones(size(blks));
  for k = 1:length(blks)
    % If this block has not yet been culled, cull its sub-blocks.  (If it has
    % already been culled, then its sub-blocks have also been culled already.)
    if keepers(k)
      pattern = ['^', blks{k}, '/'];
      keepers(find(cellfun('length', regexp(blks, pattern)))) = 0;
    end
  end
  blks = blks(find(keepers));

  fprintf('found %d\n', length(blks));

  for k = 1:length(blks)
    fprintf('updating block %s...\n', blks{k});
    update_casper_block(blks{k});
  end

  % Don't show done message for zero blocks
  if length(blks) > 0
    fprintf('done updating %d blocks in %s\n', length(blks), sys);
  end
end
