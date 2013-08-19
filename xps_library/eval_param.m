%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
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

function result = eval_param(blk,param_name)
param_str = get_param(blk,param_name);

% If it is empty or not an evaluated parameter, we're done!
mask_vars = get_param(blk, 'MaskVariables');
pattern = sprintf('(^|;)%s=@', param_name);
if isempty(param_str) || isempty(regexp(mask_vars, pattern))
  result = param_str;
  return;
end

try
    result = eval(param_str);
catch

	parents = {};
	parent = blk;
	while ~isempty(parent)
		parents = [{parent},parents];
		parent = get_param(parent,'parent');
	end

	for i=1:length(parents)
		parent = parents{i};
		if strcmp(get_param(parent,'type'),'block_diagram')
			ws = get_param(parent,'ModelWorkSpace');
			if ismethod(ws, 'whos')
				ws_arry = ws.whos;
				for i=1:length(ws_arry)
					ws_var = ws_arry(i);
						val = ws.evalin(ws_var.name);
					eval([ws_var.name,' = val;']);
				end
			end
		elseif strcmp(get_param(parent,'type'),'block')
			ws_arry = get_param(parent,'MaskWSVariables');
			for i=1:length(ws_arry)
			    eval([ws_arry(i).Name,' = ws_arry(i).Value;']);
			end
		else
			error('Unsupported block type');
		end
	end

	result = eval(param_str);

end
