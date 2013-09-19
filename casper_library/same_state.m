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

% Many mask initialization function call same_state early on to see whether the
% block's state has changed since the last time it was initialized.  Because
% same_state is called so early in the initialization process, it is a good
% place to check for illegitmately empty parameter values.  Some empty
% parameter values are legitimate, but an empty parameter value can also be
% indicative of an exception that was silently ignored by the mask when
% evaluating parameter strings.  same_state now checks for empty parameter
% values and thoroughly validates those that come from "evaulated" fields in
% the mask.

% Loop through all name/value pairs
for j = 1:length(varargin)/2
  param_value = varargin{2*j};
  % If this parameter value is empty
  if isempty(param_value)
    param_name = varargin{j*2-1};
    clog(sprintf('Checking empty value for parameter ''%s''...', param_name), ...
         'same_state_debug');
    % If it is an evaluated parameter
    mask_vars = get_param(blk, 'MaskVariables');
    pattern = sprintf('(^|;)%s=@', param_name);
    if regexp(mask_vars, pattern)
      clog('...it is an evaluated parameter', 'same_state_debug');
      % Get its string value
      param_str = get_param(blk, param_name);
      % If its string value is not empty
      if ~isempty(param_str)
        clog(sprintf('...trying to evaluate its non-empty string: "%s"', ...
                     param_str), 'same_state_debug');...
        try
          eval_val = eval_param(blk, param_name);
          clog('...its non-empty string eval''d OK', 'same_state_debug');
          % Raise exception if we did not also get an empty result
          if ~isempty(eval_val)
            link = sprintf('<a href="matlab:hilite_system(''%s'')">%s</a>', ...
                blk, blk);
            ex = MException('casper:emptyMaskParamError', ...
                'Parameter %s of %s is empty in same_state!', param_name, link);
            throw(ex);
          end
        catch ex
          % We really want to see this exception, even if its a duplicate of the
          % previous exception, so reset dump_exception before calling
          % dump_and_rethrow.
          dump_exception([]);
          dump_and_rethrow(ex);
        end % try/catch
      end % if non-empty param string
    end % if evaluated
    clog(sprintf('Empty value for parameter ''%s'' is OK.', param_name), ...
         'same_state_debug');
  end % if empty
end % name/value pair loop

% Determine whether the state has changed
try
    match = getfield( get_param(blk,'UserData'), 'state') == hashcell(varargin);
catch
    match = 0;
end
