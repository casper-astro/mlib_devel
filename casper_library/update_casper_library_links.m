%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu/                                               %
%   Copyright (C) 2013 David MacMahon                                         %
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

function update_casper_library_links(varargin)

  % Regexp for blacklisted blocks (e.g. script generated or xBlock based
  % blocks)
  persistent blacklist_re;
  if ~iscell(blacklist_re)
    blacklist_re = { ...
      '^casper_library_bus$', ...
      '^casper_library_multipliers/complex_conj/' ...
    };
  end

  if nargin == 0
    % No arguments given, use all open or loaded CASPER library block diagrams
    sys = find_system( ...
      'RegExp', 'on', ...
      'Type', 'block_diagram', ...
      'Name', '(casper|xps)_library');
  elseif nargin == 1
    % Handle single cell array arguments
    sys = varargin{1};
  else
    sys = varargin;
  end

  if ~iscell(sys)
    sys = {sys};
  end

  linked_blks = {};
  for k=1:length(sys)
    % Ignore this block if it has been blacklisted
    if any(cell2mat(regexp(sys{k}, blacklist_re)))
      continue;
    end

    % If this block has been linked
    if strcmp(get_param(sys{k}, 'Type'), 'block') ...
    && ~strcmp(get_param(sys{k}, 'StaticLinkStatus'), 'none')
      % Use ^ and $ anchors to blacklist this specific block
      % (so we don't see it again)
      blacklist_re{end+1} = sprintf('^%s$', sys{k});
      % If this block is linked, blacklist sub-blocks and ignore this one
      if ~strcmp(get_param(sys{k}, 'StaticLinkStatus'), 'none')
        blacklist_re{end+1} = sprintf('^%s/', sys{k});
      end
      continue;
    end

    % Make sure sys{k}'s block diagram is loaded
    bd = regexprep(sys{k}, '/.*', '');
    if ~bdIsLoaded(bd)
      fprintf(2, 'loading library %s\n', bd);
      load_system(bd);
    end

    % Find blocks that have inactive link to a CASPER block
    inactive_links = find_system(sys{k}, 'FollowLinks', 'off', ...
      'LookUnderMasks','all', 'RegExp', 'on', ...
      'StaticLinkStatus', 'inactive', ...
      'AncenstorBlock','(casper|xps)_library');

    % Find blocks that have resolved link to a CASPER block
    resolved_links = find_system(sys{k}, 'FollowLinks', 'off', ...
      'LookUnderMasks','all', 'RegExp', 'on', ...
      'StaticLinkStatus', 'resolved', ...
      'ReferenceBlock','(casper|xps)_library');

    % Concatentate the two lists onto linked_blks
    linked_blks = [linked_blks; resolved_links; inactive_links];
  end

  % Sort linked_blks and remove duplicates
  linked_blks = unique(sort(linked_blks));

  % For each linked block, find its source block
  for k=1:length(linked_blks)
    % Skip if blacklisted
    if any(cell2mat(regexp(linked_blks{k}, blacklist_re)))
      continue;
    else
      % Make sure we skip this block if we see it again
      blacklist_re{end+1} = sprintf('^%s$', linked_blks{k});
    end

    link_status = get_param(linked_blks{k}, 'StaticLinkStatus');
    if strcmp(link_status, 'inactive'),
      source = get_param(linked_blks{k}, 'AncestorBlock');
    elseif strcmp(link_status, 'resolved'),
      source = get_param(linked_blks{k}, 'ReferenceBlock'); 
    else
      % Should "never" happen
      continue;
    end

    % Make sure any links in the source block have been updated
    update_casper_library_links(source);

    % Make sure linked block's block diagram is unlocked
    set_param(bdroot(linked_blks{k}), 'Lock', 'off');

    % Update linked block
    fprintf(1, 'updating %s (linked to %s)\n', linked_blks{k}, source);
    update_casper_block(linked_blks{k});
  end

end % function
