% fir_col_init(blk, varargin)
%
% blk = The block to initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% n_inputs = The number of parallel input samples.
% coeff = The FIR coefficients, top-to-bottom.
% add_latency = The latency of adders.
% mult_latency = The latency of multipliers.
% coeff_bit_width = The number of bits used for coefficients
% coeff_bin_pt = The number of fractional bits in the coefficients
% first_stage_hdl = Whether to implement the first stage in adder trees
%   as behavioral HDL so that adders are absorbed into DSP slices used for
%   multipliers where this is possible.
% adder_imp = adder implementation (Fabric, behavioral HDL, DSP48)

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

function fir_col_init(blk,varargin)

clog('entering fir_col_init', 'trace');

% Declare any default values for arguments you might like.
defaults = {'n_inputs', 1, 'coeff', 0.1, 'add_latency', 2, 'mult_latency', 3, ...
    'coeff_bit_width', 25, 'coeff_bin_pt', 24, ...
    'first_stage_hdl', 'off', 'adder_imp', 'Fabric'};

check_mask_type(blk, 'fir_col');
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fir_col_init post same_state', 'trace');
munge_block(blk, varargin{:});
n_inputs = get_var('n_inputs','defaults', defaults, varargin{:});
coeff = get_var('coeff','defaults', defaults, varargin{:});
add_latency = get_var('add_latency','defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency','defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width','defaults', defaults, varargin{:});
coeff_bin_pt = get_var('coeff_bin_pt','defaults', defaults, varargin{:});
first_stage_hdl = get_var('first_stage_hdl','defaults', defaults, varargin{:});
adder_imp = get_var('adder_imp','defaults', defaults, varargin{:});

delete_lines(blk);

%default library state
if n_inputs == 0,
  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fir_col_init', 'trace');
  return;
end

if length(coeff) ~= n_inputs,
  clog('number of coefficients must be the same as the number of inputs', {'fir_col_init_debug', 'error'});
  error('number of coefficients must be the same as the number of inputs');
end

for i=1:n_inputs,
    reuse_block(blk, ['real',num2str(i)], 'built-in/inport', 'Position', [30 i*80 60 15+80*i]);
    reuse_block(blk, ['imag',num2str(i)], 'built-in/inport', 'Position', [30 i*80+30 60 45+80*i]);
    reuse_block(blk, ['fir_tap',num2str(i)], 'casper_library_downconverter/fir_tap', ...
        'Position', [180 i*160-70 230 50+160*i], 'latency', num2str(mult_latency), ...
        'factor',num2str(coeff(i)), 'coeff_bit_width', num2str(coeff_bit_width), ...
	'coeff_bin_pt', num2str(coeff_bin_pt));
    reuse_block(blk, ['real_out',num2str(i)], 'built-in/outport', 'Position', [350 i*80 380 15+80*i], 'Port', num2str(2*i-1));
    reuse_block(blk, ['imag_out',num2str(i)], 'built-in/outport', 'Position', [350 i*80+30 380 45+80*i], 'Port', num2str(2*i));
end

reuse_block(blk, 'real_sum', 'built-in/outport', 'Position', [600 10+20*n_inputs 630 30+20*n_inputs], 'Port', num2str(2*n_inputs+1));
reuse_block(blk, 'imag_sum', 'built-in/outport', 'Position', [600 110+20*n_inputs 630 130+20*n_inputs], 'Port', num2str(2*n_inputs+2));

if n_inputs > 1,
    reuse_block(blk, 'adder_tree1', 'casper_library_misc/adder_tree', ...
        'Position', [500 100 550 100+20*n_inputs], 'n_inputs', num2str(n_inputs),...
        'latency', num2str(add_latency), 'first_stage_hdl', first_stage_hdl, 'adder_imp', adder_imp);
    reuse_block(blk, 'adder_tree2', 'casper_library_misc/adder_tree', ...
        'Position', [500 200+20*n_inputs 550 200+20*n_inputs+20*n_inputs], 'n_inputs', num2str(n_inputs),...
        'latency', num2str(add_latency), 'first_stage_hdl', first_stage_hdl, 'adder_imp', adder_imp);
    reuse_block(blk, 'c1', 'xbsIndex_r4/Constant', ...
        'explicit_period', 'on', 'Position', [450 100 480 110]);
    reuse_block(blk, 'c2', 'xbsIndex_r4/Constant', ...
        'explicit_period', 'on', 'Position', [450 200+20*n_inputs 480 210+20*n_inputs]);
    reuse_block(blk, 'term1','built-in/Terminator', 'Position', [600 100 615 115]);	
    add_line(blk, 'adder_tree1/1', 'term1/1');
    reuse_block(blk, 'term2','built-in/Terminator', 'Position', [600 200+20*n_inputs 615 215+20*n_inputs]);	
    add_line(blk, 'adder_tree2/1', 'term2/1');

    add_line(blk, 'c1/1', 'adder_tree1/1');
    add_line(blk, 'c2/1', 'adder_tree2/1');
    add_line(blk,'adder_tree1/2','real_sum/1');
    add_line(blk,'adder_tree2/2','imag_sum/1');
end

for i=1:n_inputs,
    add_line(blk,['real',num2str(i),'/1'],['fir_tap',num2str(i),'/1']);
    add_line(blk,['imag',num2str(i),'/1'],['fir_tap',num2str(i),'/2']);
    add_line(blk,['fir_tap',num2str(i),'/1'],['real_out',num2str(i),'/1']);
    add_line(blk,['fir_tap',num2str(i),'/2'],['imag_out',num2str(i),'/1']);
    if n_inputs > 1
        add_line(blk,['fir_tap',num2str(i),'/3'],['adder_tree1/',num2str(i+1)]);
        add_line(blk,['fir_tap',num2str(i),'/4'],['adder_tree2/',num2str(i+1)]);
    else
        add_line(blk,['fir_tap',num2str(i),'/3'],['real_sum/1']);
        add_line(blk,['fir_tap',num2str(i),'/4'],['imag_sum/1']);
    end
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting fir_col_init', 'trace');
