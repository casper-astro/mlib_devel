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

  fprintf('searching for CASPER blocks in %s...', sys);

  ref_blks = find_system(sys, 'RegExp', 'on', varargin{:}, ...
      'ReferenceBlock', '(casper|xps)_library');

  %fprintf('found %d blocks with ReferenceBlock\n', length(ref_blks));
  %for k = 1:length(ref_blks)
  %  fprintf('  %3d %s\n', k, ref_blks{k});
  %end
  
  anc_blks = find_system(sys, 'RegExp', 'on', varargin{:}, ...
      'AncestorBlock', '(casper|xps)_library');

  %fprintf('found %d blocks with AncestorBlock\n', length(anc_blks));
  %for k = 1:length(anc_blks)
  %  fprintf('  %3d %s\n', k, anc_blks{k});
  %end

  blks = sort([ref_blks; anc_blks]);

  fprintf('found %d\n', length(blks));

  for k = 1:length(blks)
    fprintf('updating block %s...\n', blks{k});
    update_casper_block(blks{k});
  end

  % Don't show done message for zero blocks
  if length(blks) > 0
    fprintf('done updating %d blocks in %s\n', length(blks), sys);
  end

  % Now look for masked subsystems that are not linked to a library and recurse
  % into them.
  subs = find_system(sys, ...
      'BlockType',  'SubSystem', ...
      'Mask',       'on', ...
      'LinkStatus', 'none');

  for k=1:length(subs)
    % Don't recurse self!
    if ~strcmp(sys, subs{k})
      % Turn off this sub-block's mask so that our not-looking-under-masks
      % find_system call will search in/under this block.
      set_param(subs{k}, 'Mask', 'off');

      % Update
      update_casper_blocks(subs{k}, varargin{:});

      % Turn this sub-block's mask back on
      set_param(subs{k}, 'Mask', 'on');
    end
  end
end
