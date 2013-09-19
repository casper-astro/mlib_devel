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

% Function for setting one or more mask parameters.  This updates the
% block's MaskValues parameter.  Unlike using set_param, this does NOT trigger
% the mask init script and can be used to set mask parameters from within a
% mask init script (e.g. to replace a placeholder value with a calculated
% value).  Note that param_names and param_values must both be strings OR both
% be cell arrays of equal length.
%
% Typical usage:
%
%    % Passing strings (sets latency=1 in mask)
%    set_mask_params(gcb, 'latency', '1');
%
%    % Passing cells (sets latency=1 and n_inputs=4 in mask)
%    set_mask_params(gcb, {'latency', 'n_inputs'}, {'1', '4'})

function params = set_mask_params(blk, param_names, param_values)
  
  % Make sure we are working with cells
  if ~iscell(param_names)
    param_names = {param_names};
  end

  if ~iscell(param_values)
    param_values = {param_values};
  end

  % Make sure lengths agree
  if length(param_names) ~= length(param_values)
    error('param_names and param_values must have same length');
  end

  % Get mask names and values
  mask_names  = get_param(blk, 'MaskNames');
  mask_values = get_param(blk, 'MaskValues');

  % For each parameter being set
  for param_idx = 1:length(param_names)
    % Find its index in the mask
    mask_idx = find(strcmp(mask_names, param_names{param_idx}));
    if mask_idx
      % If found, update mask_values with new value
      mask_values{mask_idx} = param_values{param_idx};
    end
  end

  % Store updated mask_values
  set_param(blk, 'MaskValues', mask_values);
end
