% Saves blk's new state and parameters.
%
% save_state(blk,varargin)
%
% blk = The block to check
% varargin = The things to compare.
%
% The block's UserData 'state' parameter is updated with the contents of the hash of
% varargin, and the parameters saved in the 'parameters' struct.
% the block's UserDataPersistent parameter is set to 'on'.

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

function save_state(blk,varargin)

%check varargin contains even number of variables
if( mod(length(varargin),2) ~= 0 ) disp('save_state.m: Non-even parameter list'); return; end;
	
struct.state = hashcell(varargin);
struct.parameters = [];
%construct struct of parameter values and validate that none are empty
for j = 1:length(varargin)/2,
	struct.parameters = setfield( struct.parameters, varargin{j*2-1}, varargin{j*2} );
  if isempty(varargin{j*2})
    link = sprintf('<a href="matlab:hilite_system(''%s'')">%s</a>', ...
        blk, blk);
    ex = MException('casper:emptyMaskParamError', ...
        'Parameter %s of %s is empty in save_state!', varargin{j*2-1}, link);
    % We use dump_and_rethrow instead of just throw because chances are that
    % this is running inside a mask init callback which will silently ignore
    % the exception and abort the mask init callback.  Using dump_and_rethrow
    % means that the user will be alerted to this error condition even if the
    % caller ignores it.
    dump_and_rethrow(ex);
  end
end

set_param(blk,'UserData',struct);
set_param(blk,'UserDataPersistent','on');
backpopulate_mask(blk,varargin{:});

