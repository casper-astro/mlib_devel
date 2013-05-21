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

% This function updates oldblk using the most recent library version.
% Mask parameters are copied over whenever possible.
function update_casper_block(oldblk)

  % Check link status
  link_status = get_param(oldblk, 'StaticLinkStatus');

  % Inactive link (link disabled but not broken) so get AncestorBlock
  if strcmp(link_status, 'inactive'),
    srcblk = get_param(oldblk, 'AncestorBlock');

  % Resolved link (link in place) so get ReferenceBlock
  elseif strcmp(link_status, 'resolved'),
    srcblk = get_param(oldblk, 'ReferenceBlock');

  % Else, not supported
  else
    fprintf('%s is not a linked library block\n', oldblk);
    return;
  end

  % Special handling for deprecated "edge" blocks
  switch srcblk
  case {'casper_library_misc/edge', ...
        'casper_library_misc/negedge', ...
        'casper_library_misc/posedge'}
    % Get mask params for edge_detect block
    switch srcblk
    case 'casper_library_misc/edge'
      params = {'edge', 'Both', 'polarity', 'Active High'};
    case 'casper_library_misc/negedge'
      params = {'edge', 'Falling', 'polarity', 'Active High'};
    case 'casper_library_misc/posedge'
      params = {'edge', 'Rising', 'polarity', 'Active High'};
    end
    % Make sure casper_library_misc block diagram is loaded
    if ~bdIsLoaded('casper_library_misc')
      fprintf('loading library casper_library_misc\n');
      load_system('casper_library_misc');
    end
    % Get position and orientation of oldblk
    p = get_param(oldblk, 'position');
    o = get_param(oldblk, 'orientation');
    % Delete oldblk
    delete_block(oldblk);
    % Add edge detect block using oldblk's name
    add_block('casper_library_misc/edge_detect', oldblk, ...
        'orientation', o, ...
        'position', p, ...
        params{:});
    % Done!
    return
  end % special deprecated handling

  % Make sure srcblk's block diagram is loaded
  srcblk_bd = regexprep(srcblk, '/.*', '');
  if ~bdIsLoaded(srcblk_bd)
    fprintf('loading library %s\n', srcblk_bd);
    load_system(srcblk_bd);
  end

  % Get old and new mask names
  oldblk_mask_names = get_param(oldblk, 'MaskNames');
  newblk_mask_names = get_param(srcblk, 'MaskNames');

  % Save warning backtrace state then disable backtrace
  bt_state = warning('query', 'backtrace');
  warning off backtrace;

  % Try to populate newblk's mask parameters from oldblk
  newblk_params = {};
  for k = 1:length(newblk_mask_names)
    % If oldblk has the same mask parameter name
    if find(strcmp(oldblk_mask_names, newblk_mask_names{k}))
      % Add to new block parameters
      newblk_params{end+1} = newblk_mask_names{k};
      newblk_params{end+1} = get_param(oldblk, newblk_mask_names{k});
    else
      type = get_param(oldblk, 'MaskType');
      if ~isempty(type)
        type = [type ' '];
      end
      link = sprintf('<a href="matlab:hilite_system(''%s'')">%s</a>', ...
          oldblk, oldblk);
      warning('old %sblock %s did not have mask parameter %s', ...
          type, link, newblk_mask_names{k});
    end
  end

  % Restore warning backtrace state
  warning(bt_state);

  % Get position and orientation of oldblk.
  p = get_param(oldblk, 'position');
  o = get_param(oldblk, 'orientation');
  % Delete old block
  delete_block(oldblk);
  % Re-add source block as oldblk, using new params.  Note that we position the
  % new block at (0,0) with size of (0,0) rather than at original position.
  % This prevents existing lines from connecting to unintended ports in the new
  % block before the mask init script runs, which might change the number of
  % ports and their position within the block.
  add_block(srcblk, oldblk, ...
      'position', [0,0,0,0], ...
      'orientation', o, ...
      newblk_params{:});
  % Set real position now that the block has redrawn itself.  Some blocks (e.g.
  % software register blocks) need to be resized to get port spacing correct so
  % that's why we set position multiple times.
  set_param(oldblk, ...
      'position', p, ...
      'position', p + [0, -1, 0, 1], ...
      'position', p);
end
