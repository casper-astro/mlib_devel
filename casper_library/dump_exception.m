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

function dump_exception(ex)

  persistent last_dumped;

  % An empty ex means to clear last_dumped
  if isempty(ex)
    last_dumped = [];
  % Do not re-dump ex if it has already been dumped
  elseif ~isa(last_dumped, 'MException') || last_dumped ~= ex
    last_dumped = ex;
    fprintf('%s: %s\n', ex.identifier, ex.message);
    stack = ex.stack;
    for k=1:length(stack)
      fprintf('Backtrace %d: <a href="matlab: opentoline(''%s'',%d,0)">%s:%d</a>\n', ...
          k, stack(k).file, stack(k).line, stack(k).name, stack(k).line);
    end
  end
end
