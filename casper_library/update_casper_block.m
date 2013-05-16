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
    src = get_param(oldblk, 'AncestorBlock');

  % Resolved link (link in place) so get ReferenceBlock
  elseif strcmp(link_status, 'resolved'),
    src = get_param(oldblk, 'ReferenceBlock'); 
  
  % Else, not supported
  else
    fprintf('%s is not a linked library block\n', name);
    return;
  end

  % Special handling for deprecated "edge" blocks
  switch src
  case {'casper_library_misc/edge', ...
        'casper_library_misc/negedge', ...
        'casper_library_misc/posedge'}
    % Get mask params for edge_detect block
    switch src
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

  % Make sure src's block diagram is loaded
  src_bd = regexprep(src, '/.*', '');
  if ~bdIsLoaded(src_bd)
    fprintf('loading library %s\n', src_bd);
    load_system(src_bd);
  end

  % Add new block
  newblk = [oldblk, '__tmp__'];
  add_block(src, newblk);

  % Disable mask init script (assuming block supports same_state)
  set_param(newblk, 'UserData', 'force_same_state');

  % Get old and new mask names
  oldblk_mask_names = get_param(oldblk, 'MaskNames');
  newblk_mask_names = get_param(newblk, 'MaskNames');

  % Save warning backtrace state then disable backtrace
  bt_state = warning('query', 'backtrace');
  warning off backtrace;

  % Try to populate newblk's mask parameters from oldblk
  for k = 1:length(newblk_mask_names)
    % If oldblk has the same mask parameter name
    if find(strcmp(oldblk_mask_names, newblk_mask_names{k}))
      % Copy mask parameter from oldblk to newblk
      set_param(newblk, newblk_mask_names{k}, ...
          get_param(oldblk, newblk_mask_names{k}));
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

  % Re-enable mask init scripts by copying old block's UserData.
  % If the user data is a structure with "state" and "parameters" fields,
  % then set the state field to empty array to ensure mask init script runs.
  ud = get_param(oldblk, 'UserData');
  if isfield(ud, 'state') && isfield(ud, 'parameters')
    ud.state = [];
  end
  set_param(newblk, 'UserData', ud);

  % If block has at least one mask parameter,
  if ~isempty(newblk_mask_names)
    % Kick off mask init script by setting first mask parameter to itself
    set_param(newblk, newblk_mask_names{1}, ...
        get_param(newblk, newblk_mask_names{1}));
  end

  % Get position of oldblk, delete it, move newblk into its place, and rename.
  % Some blocks (e.g. software register blocks) need to be resized to get port
  % spacing correct so that's why we set position multiple times.
  p = get_param(oldblk, 'position');
  o = get_param(oldblk, 'orientation');
  delete_block(oldblk);
  set_param(newblk, ...
      'orientation', o, ...
      'position', p, ...
      'position', p + [0, -1, 0, 1], ...
      'position', p);
  set_param(newblk, 'name', regexprep(oldblk, '.*/', ''));
end
