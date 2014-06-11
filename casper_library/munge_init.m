% Break input bus into divisions and reorder as specified.
%
% munge_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% divisions       = number of divisions
% div_size        = size in bits of each division
% order           = ouput order of divisions (referenced to input order)
% arith_type_out  = reinterpret resultant vector
% bin_pt_out      = output binary point

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
log_group = 'munge_init_debug';

clog('entering munge_init', {log_group, 'trace'});
check_mask_type(blk, 'munge');

defaults = {'divisions', 4, 'div_size', [32 0 16 16], 'order', [3 0 1 2], 'arith_type_out', 'Unsigned', 'bin_pt_out', 0};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('munge_init: post same_state', {log_group, 'trace'});
munge_block(blk, varargin{:});

divisions       = get_var('divisions', 'defaults', defaults, varargin{:});
div_size        = get_var('div_size', 'defaults', defaults, varargin{:});
output_order    = get_var('order', 'defaults', defaults, varargin{:});
arith_type_out  = get_var('arith_type_out', 'defaults', defaults, varargin{:});
bin_pt_out      = get_var('bin_pt_out', 'defaults', defaults, varargin{:});

%default empty state
if divisions < 1,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk,'AttributesFormatString','');
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  clog('exiting munge_init', {log_group, 'trace'});
  return;
end

if divisions > 1 && length(find(div_size >= 1)) == 0,
  clog(['Some divisions must have non-zero size'], {log_group, 'error'});
  error(['Some divisions must have non-zero size']);
  return;
end

if length(div_size) ~= 1 && length(div_size) ~= divisions,
  clog(['Reported number of divisions, ',num2str(divisions),' does not match division description length ',num2str(length(div_size))], {log_group, 'error'});
  error(['Reported number of divisions, ',num2str(divisions),' does not match division description length ',num2str(length(div_size))]);
  return;
end

if length(find(output_order < 0)) ~= 0 || ... 
  length(find(output_order > divisions-1)) ~= 0,
  clog(['Output order elements must be in range 0->',num2str(divisions-1)], {log_group, 'error'});
  error(['Output order elements must be in range 0->',num2str(divisions-1)]);
  return;
end

%remove 0 division sizes from div_size
nzero_i       = find(div_size ~= 0);
div_size_mod  = div_size(nzero_i);
divisions_mod = length(div_size_mod);

%adjust output_order based on zeros found in div_size
zero_i = find(div_size == 0);
output_order_mod = output_order;
for n = 1:length(zero_i),
  indices = find(output_order >= (zero_i(n) - 1));
  if ~isempty(indices), 
    output_order_mod(indices) = output_order_mod(indices) - 1;
  end %if
end %for
for m = 1:length(zero_i),
  indices = find(output_order == (zero_i(m)-1));
  output_order_mod(indices) = [];
end

%calculate resultant word size
n_bits_out = 0;
for index = 1:length(output_order_mod),
  if length(div_size_mod) == 1,
    n_bits_out = n_bits_out+div_size_mod*(output_order_mod(index)+1);
  else
    n_bits_out = n_bits_out+div_size_mod(output_order_mod(index)+1);
  end
end

if n_bits_out < bin_pt_out,
  clog(['binary point position ',num2str(bin_pt_out),' greater than number of bits ',num2str(n_bits_out)], {log_group, 'error'});
  error(['binary point position ',num2str(bin_pt_out),' greater than number of bits ',num2str(n_bits_out)]);
  return;
end

delete_lines(blk);

ytick = 20;

if length(div_size_mod) == 1,
  mode =  'divisions of equal size';
  inputNum = divisions_mod;
else,
  mode = 'divisions of arbitrary size';
  inputNum = length(output_order_mod);
end

%input 
reuse_block(blk, 'din', 'built-in/inport', 'Position', [40 10+ytick*(divisions_mod+1)/2 70 30+ytick*(divisions_mod+1)/2], 'Port', '1');
%output
reuse_block(blk, 'reinterpret_out', 'xbsIndex_r4/Reinterpret', ...
  'force_arith_type', 'on', 'arith_type', arith_type_out, ...
  'force_bin_pt', 'on', 'bin_pt', mat2str(bin_pt_out), ...
  'Position', [655 10+ytick*(inputNum+1)/2 710 30+ytick*(inputNum+1)/2]);
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [780 10+ytick*(inputNum+1)/2 810 30+ytick*(inputNum+1)/2], 'Port', '1');
add_line(blk, 'reinterpret_out/1', 'dout/1');

if divisions < 2,
  add_line(blk, 'din/1', 'reinterpret_out/1');
else
  %reinterpret
  reuse_block(blk, 'reinterpret', 'xbsIndex_r4/Reinterpret', ...
    'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
    'force_bin_pt', 'on', 'bin_pt', '0', ...
    'Position', [95 12+ytick*(divisions_mod+1)/2 160 28+ytick*(divisions_mod+1)/2]);
  add_line(blk, 'din/1', 'reinterpret/1');

  %bus expand
  reuse_block(blk, 'split', 'casper_library_flow_control/bus_expand', ...
    'mode', mode, ...
    'outputNum', num2str(divisions_mod), ...
    'outputWidth', mat2str(div_size_mod), ...
    'outputBinaryPt', mat2str(zeros(1, divisions_mod)), ...
    'outputArithmeticType', mat2str(zeros(1, divisions_mod)), ...
    'outputToWorkSpace', 'off', ...
    'Position', [190 10 270 30+ytick*divisions_mod]);
  add_line(blk, 'reinterpret/1', 'split/1');

  %bus create
  reuse_block(blk, 'join', 'casper_library_flow_control/bus_create', ...
    'inputNum', num2str(inputNum), ...
    'Position', [550 10 630 30+ytick*inputNum]);
  add_line(blk, 'join/1', 'reinterpret_out/1');

  %join
  for div = 1:length(output_order_mod),
    add_line(blk, ['split/',num2str(output_order_mod(div)+1)], ['join/',num2str(div)]);
  end  
end %if

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('split:%s\njoin:%s\n%s [%d,%d]',mat2str(div_size), mat2str(output_order), arith_type_out, n_bits_out, bin_pt_out);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting munge_init', {log_group, 'trace'});

