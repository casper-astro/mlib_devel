% dec_fir_async_init(blk)
%
% blk = The block to initialize.
%
% The script will pull the required variables from the block mask.
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
%                                                                             % 
%   Copyright (C) 2010 Billy Mallard                                          %
%                                                                             % 
%   Karoo Array Telescope Project                                             % 
%   http://www.kat.ac.za                                                      % 
%   Copyright (C) 2011 Andrew Martens                                         %
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

function dec_fir_async_init(blk)
clog('entering dec_fir_async_init', 'trace');

debug_fullscale_output = false;

varargin = make_varargin(blk);

% Declare any default values for arguments you might like.
% Added defaults and fixed the quatization default for 10.1 tools AWL
defaults = {'n_inputs', 1, 'output_width', 8, 'output_bp', 7, ...
    'coeff', 0.1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'add_latency', 1, 'mult_latency', 2, 'conv_latency', 2, ...
    'lshift', 1, ...
    'coeff_bit_width', 25, 'coeff_bin_pt', 24, ...
    'absorb_adders', 'on', 'adder_imp', 'DSP48', ...
    'async', 'off', 'bus_input', 'off', 'input_width', 16, ...
    'input_bp', 0, 'input_type', 'Unsigned'};

check_mask_type(blk, 'dec_fir_async');
if same_state(blk, 'defaults', defaults, varargin{:}),
    clog('dec_fir_async_init same state', 'trace');
    return;
end
clog('dec_fir_init post same_state', 'trace');
munge_block(blk, varargin{:});

n_inputs = get_var('n_inputs','defaults', defaults, varargin{:});
coeff = get_var('coeff', 'defaults', defaults, varargin{:});
output_width = get_var('output_width', 'defaults', defaults, varargin{:});
output_bp = get_var('output_bp', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
coeff_bin_pt = get_var('coeff_bin_pt', 'defaults', defaults, varargin{:}); 
lshift = get_var('lshift', 'defaults', defaults, varargin{:}); 
absorb_adders = get_var('absorb_adders', 'defaults', defaults, varargin{:});
adder_imp = get_var('adder_imp', 'defaults', defaults, varargin{:});
async_ops = strcmp('on', get_var('async','defaults', defaults, varargin{:}));
bus_input = strcmp('on', get_var('bus_input','defaults', defaults, varargin{:}));
input_width = get_var('input_width','defaults', defaults, varargin{:});
input_bp = get_var('input_bp','defaults', defaults, varargin{:});
input_type = get_var('input_type','defaults', defaults, varargin{:});

% async_ops = true;
% bus_input = false;

% default library state
if n_inputs == 0,
  clog('no inputs, clearing dec_fir_async block', 'trace');
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk,'AttributesFormatString','');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting dec_fir_async_init', 'trace');
  return;
end

% round coefficients to make sure rounding error doesn't prevent us from
% detecting symmetric coefficients
coeff_round = round(coeff * 1e16) * 1e-16;

% check that the number of inputs and coefficients are compatible
if mod(length(coeff) / n_inputs, 1) ~= 0,
    error_string = sprintf('The number of coefficients (%d) must be integer multiples of the number of inputs (%d).', length(coeff), n_inputs);
    clog(error_string, 'error');
    errordlg(error_string);
end

% how many tap-groups/columns do we need? are the coeffs symmetrical?
num_fir_col = length(coeff) / n_inputs;
coeff_sym = false;
fir_col_type = 'fir_col_async';
if mod(length(coeff),2) == 0 && mod(num_fir_col, 2)==0 
  if coeff_round(1:length(coeff)/2) == coeff_round(length(coeff):-1:length(coeff)/2+1),
    num_fir_col = num_fir_col / 2;
    coeff_sym = true;
  end
end

delete_lines(blk);

% sync in
sync_latency = mult_latency + (ceil(log2(n_inputs))*add_latency) + conv_latency;
if coeff_sym,
    % y(n) = sum(aix(n-i)) for i=0:N. sync is thus related to x(0)
    sync_latency = add_latency + sync_latency;
end
% if delay is greater than 17*3 then might as well use logic as using more than 3 SRL16s and sync_delay uses approx 3 (2 comparators, one counter) 
if sync_latency > 17*3,
    sync_delay_block = 'casper_library_delays/sync_delay';
    parm_name = 'DelayLen';
else 
    sync_delay_block = 'xbsIndex_r4/Delay';
    parm_name = 'latency';
end
reuse_block(blk, 'sync_in', 'built-in/inport', ...
    'Position', [0 20 30 36], 'Port', '1');
reuse_block(blk, 'sync_delay', sync_delay_block, ...
    'Position', [60 8 100 48], ...
    parm_name, num2str(sync_latency));
% reuse_block(blk, 'sync_goto', 'built-in/goto', ...
%         'GotoTag', 'sync_in', 'showname', showname, ...
%         'Position', [130, 20, 130+sizex_goto, 20+sizey_goto]);
add_line(blk, 'sync_in/1', 'sync_delay/1');
% add_line(blk, 'sync_delay/1', 'sync_goto/1');

% dv in
dv_latency = sync_latency + (ceil(log2(num_fir_col))*add_latency);
data_port_start = 2;
if async_ops,
    if bus_input,
        ypos = 200;
    else
        ypos = n_inputs*60 + 300;
    end
    data_port_start = 3;
    reuse_block(blk, 'dv_in', 'built-in/inport', ...
        'Position', [0 ypos 30 ypos+16], 'Port', '2');
    reuse_block(blk, 'dv_delay', 'xbsIndex_r4/Delay', ...
        'Position', [60 ypos-8 100 ypos+32], ...
        'latency', num2str(dv_latency));
    reuse_block(blk, 'dv_out', 'built-in/outport', ...
        'Position', [120 ypos 150 ypos+16], 'Port', '3');
    add_line(blk, 'dv_in/1', 'dv_delay/1');
    add_line(blk, 'dv_delay/1', 'dv_out/1');
%     reuse_block(blk, 'dv_goto', 'built-in/goto', ...
%             'GotoTag', 'dv_in', 'showname', showname, ...
%             'Position', [60, 50, 60+sizex_goto, 50+sizey_goto]);
%     add_line(blk, 'dv_in/1', 'dv_goto/1');
end

% data bus in
if bus_input,
    reuse_block(blk, 'dbus_in', 'built-in/inport', ...
        'Position', [0 100 30 116], 'Port', num2str(data_port_start));
%     reuse_block(blk, 'dbus_goto', 'built-in/goto', ...
%             'GotoTag', 'dbus_in', 'showname', showname, ...
%             'Position', [60, 100, 60+sizex_goto, 100+sizey_goto]);
%     add_line(blk, 'dbus_in/1', 'dbus_goto/1');
else
    for ctr = 1:n_inputs,
        port_start = data_port_start + ((ctr-1)*2);
        reuse_block(blk, ['real',num2str(ctr)], 'built-in/inport', ...
            'Position', [0 90*ctr 30 90*ctr+15], 'Port', num2str(port_start));
        reuse_block(blk, ['imag',num2str(ctr)], 'built-in/inport', ...
            'Position', [0 90*ctr+45 30 90*ctr+60], 'Port', num2str(port_start+1));
    end
end

% if we have only one input stream, then first stage of adders
% after multipliers are these adder_trees (otherwise inside cols)
if n_inputs == 1,
  first_stage_hdl_external = absorb_adders;  
else
  first_stage_hdl_external = 'off';
end

reuse_block(blk, 'real_sum', 'casper_library_misc/adder_tree', ...
    'Position', [200*num_fir_col+400 300 200*num_fir_col+460 num_fir_col*10+350], ...
    'n_inputs',num2str(num_fir_col),'latency',num2str(add_latency), ...
    'adder_imp', adder_imp, 'first_stage_hdl', first_stage_hdl_external);
reuse_block(blk, 'imag_sum', 'casper_library_misc/adder_tree', ...
    'Position', [200*num_fir_col+400 num_fir_col*10+400 200*num_fir_col+460 num_fir_col*20+450], ...
    'n_inputs',num2str(num_fir_col),'latency',num2str(add_latency), ...
    'adder_imp', adder_imp, 'first_stage_hdl', first_stage_hdl_external);

% the tap columns
for ctr = 1:num_fir_col,
    blk_name = [fir_col_type, num2str(ctr)];
    prev_blk_name = [fir_col_type, num2str(ctr-1)];
    
    symmet_str = 'off';
    async_str = 'off';
    binput_str = 'off';
    if coeff_sym,
        symmet_str = 'on';
    end
    if async_ops,
        async_str = 'on';
    end
    if bus_input,
        binput_str = 'on';
    end
    reuse_block(blk, blk_name, ['casper_library_downconverter/', fir_col_type], ...
        'Position', [200*ctr+200 50 200*ctr+300 250], 'n_inputs', num2str(n_inputs),...
        'coeff', ['[',num2str(coeff(ctr*n_inputs:-1:(ctr-1)*n_inputs+1)),']'],...
        'mult_latency', num2str(mult_latency), 'add_latency', num2str(add_latency), ...
        'coeff_bit_width', num2str(coeff_bit_width), 'coeff_bin_pt', num2str(coeff_bin_pt), ...
        'adder_imp', adder_imp, 'first_stage_hdl', absorb_adders, ...
        'async', async_str, 'dbl', symmet_str, 'bus_input', binput_str, ...
        'input_width', num2str(input_width), 'input_bp', num2str(input_bp), 'input_type', input_type);
    if bus_input,
        if ctr == 1,
            add_line(blk, 'dbus_in/1', [blk_name, '/1']);
        else
            add_line(blk, [prev_blk_name, '/1'], [blk_name, '/1']);
        end
        if coeff_sym,
            add_line(blk, [blk_name, '/3'], ['real_sum/', num2str(ctr+1)]);
            add_line(blk, [blk_name, '/4'], ['imag_sum/', num2str(ctr+1)]);
        else
            add_line(blk, [blk_name, '/2'], ['real_sum/', num2str(ctr+1)]);
            add_line(blk, [blk_name, '/3'], ['imag_sum/', num2str(ctr+1)]);
        end
        if async_ops,
            if coeff_sym,
                add_line(blk, 'dv_in/1', [blk_name, '/3']);
            else
                add_line(blk, 'dv_in/1', [blk_name, '/2']);
            end
        end
    else
        if ctr == 1,
            for ctr2 = 1:n_inputs,
                add_line(blk, ['real', num2str(ctr2), '/1'], [blk_name, '/', num2str(2*ctr2-1)]);
                add_line(blk, ['imag', num2str(ctr2), '/1'], [blk_name, '/', num2str(2*ctr2)]);
            end
        else
            for ctr2 = 1:n_inputs,
                add_line(blk, [prev_blk_name, '/', num2str(ctr2*2-1)], [blk_name, '/', num2str(ctr2*2-1)]);
                add_line(blk, [prev_blk_name, '/', num2str(ctr2*2)],   [blk_name, '/', num2str(ctr2*2)]);
            end
        end
        if coeff_sym,
            add_line(blk, [blk_name, '/', num2str(n_inputs*4+1)], ['real_sum/', num2str(ctr+1)]);
            add_line(blk, [blk_name, '/', num2str(n_inputs*4+2)], ['imag_sum/', num2str(ctr+1)]);
        else
            add_line(blk, [blk_name, '/', num2str(n_inputs*2+1)], ['real_sum/', num2str(ctr+1)]);
            add_line(blk, [blk_name, '/', num2str(n_inputs*2+2)], ['imag_sum/', num2str(ctr+1)]);
        end
        if async_ops,
            if coeff_sym,
                add_line(blk, 'dv_in/1', [blk_name, '/', num2str(n_inputs*4+1)]);
            else
                add_line(blk, 'dv_in/1', [blk_name, '/', num2str(n_inputs*2+1)]);
            end
        end
    end
end

reuse_block(blk, 'shift1', 'xbsIndex_r4/Shift', ...
    'shift_dir', 'Left', 'shift_bits', num2str(lshift), ...
    'Position', [200*num_fir_col+500 300 200*num_fir_col+530 315]);
reuse_block(blk, 'shift2', 'xbsIndex_r4/Shift', ...
    'shift_dir', 'Left', 'shift_bits', num2str(lshift), ...
    'Position', [200*num_fir_col+500 500 200*num_fir_col+530 515]);
reuse_block(blk, 'convert1', 'xbsIndex_r4/Convert', ...
    'Position', [200*num_fir_col+560 300 200*num_fir_col+590 315], ...
    'n_bits', num2str(output_width), 'bin_pt', num2str(output_bp), 'arith_type', 'Signed  (2''s comp)', ...
    'latency', num2str(conv_latency), 'quantization', quantization);
reuse_block(blk, 'convert2', 'xbsIndex_r4/Convert', ...
    'Position', [200*num_fir_col+560 500 200*num_fir_col+590 515], ...
    'n_bits', num2str(output_width), 'bin_pt', num2str(output_bp), 'arith_type', 'Signed  (2''s comp)', ...
    'latency', num2str(conv_latency), 'quantization', quantization);

reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
    'Position', [200*num_fir_col+620 400 200*num_fir_col+650 430]);

reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [200*num_fir_col+500 250 200*num_fir_col+530 265], 'Port', '1');
reuse_block(blk, 'dout', 'built-in/outport', ...
    'Position', [200*num_fir_col+680 400 200*num_fir_col+710 415], 'Port', '2');

add_line(blk, 'real_sum/2',     'shift1/1');
add_line(blk, 'imag_sum/2',     'shift2/1');
add_line(blk, 'shift1/1',       'convert1/1');
add_line(blk, 'shift2/1',       'convert2/1');
add_line(blk, 'convert1/1',     'ri_to_c/1');
add_line(blk, 'convert2/1',     'ri_to_c/2');
add_line(blk, 'ri_to_c/1',      'dout/1');
add_line(blk, 'sync_delay/1',   'real_sum/1');
add_line(blk, 'sync_delay/1',   'imag_sum/1');
add_line(blk, 'real_sum/1',     'sync_out/1');

% backward links for symmetric coefficients
if coeff_sym,
    if bus_input,
        for ctr = 2:num_fir_col,
            blk_name = [fir_col_type, num2str(ctr)];
            prev_blk_name = [fir_col_type, num2str(ctr-1)];
            add_line(blk, [blk_name, '/2'], [prev_blk_name, '/2']);
        end
        % and the last one feeds back to itself
        blk_name = [fir_col_type, num2str(num_fir_col)];
        add_line(blk, [blk_name, '/1'], [blk_name, '/2']);
    else
        for ctr = 1:num_fir_col,
            if ctr ~= 1
                blk_name = [fir_col_type,num2str(ctr)];
                prev_blk_name = [fir_col_type,num2str(ctr-1)];
                for ctr2=1:n_inputs,
                    add_line(blk, [blk_name,'/', num2str(2*n_inputs+ctr2*2-1)], [prev_blk_name, '/', num2str(2*n_inputs+ctr2*2-1)]);
                    add_line(blk, [blk_name,'/', num2str(2*n_inputs+ctr2*2)],   [prev_blk_name, '/', num2str(2*n_inputs+ctr2*2)]);
                end
            end
        end
        for ctr = 1:n_inputs,
            blk_name = [fir_col_type, num2str(num_fir_col)];
            add_line(blk,[blk_name, '/', num2str(ctr*2-1)], [blk_name, '/', num2str(2*n_inputs+ctr*2-1)]);
            add_line(blk,[blk_name, '/', num2str(ctr*2)],   [blk_name, '/', num2str(2*n_inputs+ctr*2)]);
        end
    end
end

if debug_fullscale_output,
    if async_ops,
        portnum = 4;
    else
        portnum = 3;
    end
    reuse_block(blk, 'real_fs', 'built-in/outport', ...
        'Position', [200*num_fir_col+680 370 200*num_fir_col+710 385], 'Port', num2str(portnum));
    reuse_block(blk, 'imag_fs', 'built-in/outport', ...
        'Position', [200*num_fir_col+680 430 200*num_fir_col+710 445], 'Port', num2str(portnum+1));
    add_line(blk,'real_sum/2','real_fs/1');
    add_line(blk,'imag_sum/2','imag_fs/1');
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('%d taps\n%d_%d r/i', length(coeff), output_width, output_bp);
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting dec_fir_async_init', 'trace');
