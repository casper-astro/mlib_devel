% Break input bus into divisions and reorder as specified.
%
% munge_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% divisions = number of divisions
% div_size = size in bits of each division
% order = ouput order of divisions (referenced to input order)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   MeerKAT Radio Telescope Project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2010 Andrew Martens (meerKAT)                               %
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

function munge_init(blk,varargin)

clog('entering munge_init', 'trace');
check_mask_type(blk, 'munge');

defaults = {'divisions', 1, 'div_size', 0, 'order', 0};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('munge_init: post same_state', 'trace');
munge_block(blk, varargin{:});

divisions = get_var('divisions', 'defaults', defaults, varargin{:});
div_size = get_var('div_size', 'defaults', defaults, varargin{:});
order = get_var('order', 'defaults', defaults, varargin{:});

if divisions > 1 && div_size < 1,
  errordlg(['Divisions must have non-zero size']);
  return;
end

if (divisions > 1) && (length(unique(order)) ~= divisions ||...
        ~isempty(find(order < 0)) || ...
        ~isempty(find(order > divisions-1))),
    errordlg(['Order elements must be unique in range 0->',num2str(divisions-1)]);
    return;
end

delete_lines(blk);

ytick = 20;
%input 
reuse_block(blk, 'din', 'built-in/inport', 'Position', [40 10+ytick*(divisions+1)/2 70 30+ytick*(divisions+1)/2], 'Port', '1');
%output
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [670 10+ytick*(divisions+1)/2 700 30+ytick*(divisions+1)/2], 'Port', '1');

if divisions < 2,
  add_line(blk, 'din/1', 'dout/1');
else
  %reinterpret
  reuse_block(blk, 'reinterpret', 'xbsIndex_r4/Reinterpret', ...
    'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
    'force_bin_pt', 'on', 'bin_pt', '0', ...
    'Position', [95 12+ytick*(divisions+1)/2 160 28+ytick*(divisions+1)/2]);
  add_line(blk, 'din/1', 'reinterpret/1');

  %bus expand
  reuse_block(blk, 'split', 'casper_library_flow_control/bus_expand', ...
    'outputNum', num2str(divisions), 'outputWidth', num2str(div_size), ...
    'outputBinaryPt', '0', 'outputArithmeticType', 'Unsigned', ...
    'outputToWorkSpace', 'off', ...
    'Position', [190 10 270 30+ytick*divisions]);
  add_line(blk, 'reinterpret/1', 'split/1');

  %bus create
  reuse_block(blk, 'join', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(divisions), ...
    'Position', [550 10 630 30+ytick*divisions]);
  add_line(blk, 'join/1', 'dout/1');

  %join
  for div = 1:divisions,
    add_line(blk, ['split/',num2str(order(div)+1)], ['join/',num2str(div)]);
  end  
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('[%s]\n%d bits',num2str(order),div_size);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting munge_init', 'trace');

