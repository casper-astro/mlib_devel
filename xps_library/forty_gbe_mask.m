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

% Create yellow block(s) supporting upto 4x 40GbE links.
% Amit Bansod, abansod@bansod.org


function forty_gbe_mask(blk)

    function add_line_s(sys, srcprt, dstprt)
        try
            add_line(sys, srcprt, dstprt);
        catch
            % pass
        end
    end

    function delete_block_s(blockname)
        try
            delete_block(blockname);
        catch
            % pass
        end
    end

    function delete_block_lines_s(blockname)
        try
            delete_block_lines(blockname);
        catch
            % pass
        end
    end

clog('entering forge_gbe', 'trace');

cursys = blk;
set_param(cursys, 'LinkStatus', 'inactive');

try
    num_qsfp_ports = str2num(get_param(cursys, 'port'));
catch
    num_qsfp_ports = 1;
end

% Delete all wires.
delete_lines(blk);

% rename gateways
% gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', ...
%     'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');


% initialize gateways based on number of QSFP Ports
gateway_ins = { {clear_name([cursys, '_led_up']);'Boolean';'1'}; ...
                {clear_name([cursys, '_led_tx']);'Boolean';'1'}; ...
                {clear_name([cursys, '_tx_afull']);'Boolean';'1'}; ...
                {clear_name([cursys, '_tx_overflow']);'Boolean';'1'}; ...
                {clear_name([cursys, '_led_rx']);'Boolean';'1'}; ...
                {clear_name([cursys, '_rx_valid']);'Unsigned';'4'}; ...
                {clear_name([cursys, '_rx_data']);'Unsigned';'256'}; ...
                {clear_name([cursys, '_rx_source_ip']);'Unsigned';'32'}; ...
                {clear_name([cursys, '_rx_source_port']);'Unsigned';'16'}; ...
                {clear_name([cursys, '_rx_dest_ip']);'Unsigned';'32'}; ...
                {clear_name([cursys, '_rx_dest_port']);'Unsigned';'16'}; ...
                {clear_name([cursys, '_rx_end_of_frame']);'Boolean';'1'}; 
                {clear_name([cursys, '_rx_bad_frame']);'Boolean';'1'}; ...
                {clear_name([cursys, '_rx_overrun']);'Boolean';'1'}; ...
                };

for s=1:num_qsfp_ports
  for ctr = 1 : length(gateway_ins) 
      gw = gateway_ins{ctr}{1};
       type = gateway_ins{ctr}{2};
       bits = gateway_ins{ctr}{3};
        reuse_block(cursys, strcat(gw,num2str(s)), 'xbsBasic_r4/Gateway In', ...
            'arith_type', type, 'n_bits', bits, 'bin_pt', '0', ...
            'quantization', 'Truncate', 'overflow', 'Wrap', ...
            'Position', [900 (s*800)+127+(ctr*50) 1000 157+(s*800)+(ctr*50)]);
        reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_const'), 'simulink/Commonly Used Blocks/Constant', ...
            'Position', [850 (s*800)+127+(ctr*50) 875 157+(s*800)+(ctr*50)]);
         reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe'), 'casper_library_delays/pipeline', ...
            'latency', '3', 'Position', [1100 (s*800)+127+(ctr*50) 1150 157+(s*800)+(ctr*50)]);
         reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw)),num2str(s)), 'built-in/outport', 'Port', num2str(s*length(gateway_ins)), ...
            'Position', [1450 (s*800)+127+(ctr*50) 1500 157+(s*800)+(ctr*50)]);
        add_line(cursys,strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_const/1'),strcat(gw,num2str(s),'/1'));
        add_line(cursys,strcat(gw,num2str(s),'/1'), strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe/1'));
        add_line(cursys,strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe/1'),strcat(gw((length(cursys)+2):length(gw)),num2str(s),'/1'));
  end %for ctr
  reuse_block(cursys, strcat('rx_vld_bus',num2str(s)), 'casper_library_flow_control/bus_expand', ...
            'mode', 'divisions of equal size', 'outputNum', '4', 'outputWidth', '1', 'outputBinaryPt', '0', ...
            'outputArithmeticType', '2', ...
            'Position', [1650 (s*800)+127+50 1700 157+(s*800)+50]);
   reuse_block(cursys, strcat('rx_vld_or',num2str(s)), 'xbsIndex_r4/Logical', ...
            'logical_function', 'OR', ...
            'inputs', '4', 'Position', [1720 (s*800)+127 1730 157+(s*800)]);
   reuse_block(cursys, strcat('rx_vld_or_out_',num2str(s),'_pipe'), 'casper_library_delays/pipeline', ...
            'latency', '2', 'Position', [1750 (s*800)+127 1800 157+(s*800)]);
   reuse_block(cursys, strcat('rx_eof',num2str(s),'_pipe'), 'casper_library_delays/pipeline', ...
            'latency', '3', 'Position', [1750 (s*800)+177 1800 197+(s*800)]);
  add_line(cursys,strcat('rx_valid',num2str(s),'_pipe/1'),strcat('rx_vld_bus',num2str(s),'/1'));
  add_line(cursys,strcat('rx_vld_bus',num2str(s),'/1'),strcat('rx_vld_or',num2str(s),'/1'));
  add_line(cursys,strcat('rx_vld_bus',num2str(s),'/2'),strcat('rx_vld_or',num2str(s),'/2'));
  add_line(cursys,strcat('rx_vld_bus',num2str(s),'/3'),strcat('rx_vld_or',num2str(s),'/3'));
  add_line(cursys,strcat('rx_vld_bus',num2str(s),'/4'),strcat('rx_vld_or',num2str(s),'/4'));
  add_line(cursys,strcat('rx_vld_or',num2str(s),'/1'),strcat('rx_vld_or_out_',num2str(s),'_pipe/1'));
  add_line(cursys,strcat('rx_end_of_frame',num2str(s),'_pipe/1'),strcat('rx_eof',num2str(s),'_pipe/1'));
  
end %for s


% gateway_outs = find_system(cursys, 'searchdepth', 1, ...
%     'FollowLinks', 'on', 'lookundermasks', 'all', ...
%     'masktype', 'Xilinx Gateway Out Block');

% initialize gateways based on number of QSFP Ports
gateway_outs = { {clear_name([cursys, '_tx_valid']);'Boolean';'1'}; ...
                {clear_name([cursys, '_tx_end_of_frame']);'Boolean';'1'}; ...
                {clear_name([cursys, '_tx_data']);'Unsigned';'256'}; ...
                {clear_name([cursys, '_tx_dest_ip']);'Unsigned';'32'}; ...
                {clear_name([cursys, '_tx_dest_port']);'Unsigned';'16'}; ...
                {clear_name([cursys, '_rx_ack']);'Boolean';'1'}; ...
                {clear_name([cursys, '_rx_overrun_ack']);'Boolean';'1'}; ...
                };

            
for s=1:num_qsfp_ports
   for ctr = 1 : length(gateway_outs) 
       gw = gateway_outs{ctr}{1};
       type = gateway_outs{ctr}{2};
       bits = gateway_outs{ctr}{3};
          reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s)), 'built-in/inport', 'Port', num2str(s*length(gateway_outs)), ...
             'Position', [50 (s*800)+127+(ctr*50) 100 157+(s*800)+(ctr*50)]);
          reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_apipe'), 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [120 (s*800)+127+(ctr*50) 150 157+(s*800)+(ctr*50)]);
          reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_assert'), 'xbsBasic_r4/Assert', ...
               'assert_type', 'on', 'type_source', 'Explicitly', 'arith_type', type, 'n_bits', bits, 'bin_pt', '0', ...
              'assert_rate', 'on', 'rate_source', 'Explicitly', 'period', '1', 'output_port', 'on', ...
              'Position', [170 (s*800)+127+(ctr*50) 200 157+(s*800)+(ctr*50)]);
          reuse_block(cursys, strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe'), 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [220 (s*800)+127+(ctr*50) 250 157+(s*800)+(ctr*50)]);
          reuse_block(cursys, strcat(gw,num2str(s)), 'xbsBasic_r4/Gateway Out', ...
              'Position', [400 (s*800)+127+(ctr*50) 500 157+(s*800)+(ctr*50)]);
          reuse_block(cursys, strcat(num2str((s-1)*length(gateway_outs)+ctr),'_term'), 'built-in/Terminator', ...
             'Position', [520 (s*800)+132+(ctr*50) 535 162+(s*900)+(ctr*50)]);
          add_line(cursys,strcat(gw((length(cursys)+2):length(gw)),num2str(s),'/1'),strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_apipe/1'));
          add_line(cursys,strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_apipe/1'),strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_assert/1'));
          add_line(cursys,strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_assert/1'),strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe/1'));
          add_line(cursys,strcat(gw((length(cursys)+2):length(gw) ),num2str(s),'_pipe/1'),strcat(gw,num2str(s),'/1'));
          add_line(cursys,strcat(gw,num2str(s),'/1'),strcat(num2str((s-1)*length(gateway_outs)+ctr),'_term/1'));         
   end %for ctr
 end %for s



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% do debug counters and supporting logic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure the terminator and port are there
 reuse_block(cursys, 'debug_rst', 'built-in/inport', 'Port', num2str((num_qsfp_ports*length(gateway_outs))+1), ...
     'Position', [120   730   150   746]);
 reuse_block(cursys, 'term1', 'built-in/Terminator', ...
     'Position', [200   735   220   755]);
 add_line_s(cursys, 'debug_rst/1', 'term1/1');

try
    debug_ctr_width = get_param(cursys, 'debug_ctr_width');
catch
    debug_ctr_width = '16';
end

% is this a recent version of the 40gbe block, with pipeline delays?
try
    test_name = [cursys, '/pipeline_led_up1_pipe'];
    get_param(test_name, 'Mask');
    pipe_no_pipe = 'pipeline';
catch
    pipe_no_pipe = cursys;
end


function draw_counter(sys, xpos, ypos, targetname, sourcename)
    ctr_name = [targetname, '_ctr'];
    delay_name = [targetname, '_del'];
    rst_pipe = [targetname,'_r_pipe'];
    ctr_pipe = [targetname,'_c_pipe'];
    delete_block_lines_s([sys, '/', targetname]);
    delete_block_lines_s([sys, '/', ctr_name]);
    delete_block_lines_s([sys, '/', delay_name]);
    delete_block_lines_s([sys, '/', ctr_pipe]);
    delete_block_lines_s([sys, '/', rst_pipe]);
    draw_block = false;
    try
        if ((strcmp(get_param(sys, 'debug_en_all'), 'on') == 1)) && ...
           (strcmp(get_param(sys, 'debug_dis_all'), 'on') == 0)
            draw_block = true;
        end
    catch
%         if strcmp(get_param(sys, targetname), 'on') == 1
%             draw_block = true;
%         end
    end
    if draw_block
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos+15 xpos+20 ypos+35]);
          reuse_block(sys, rst_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+60 ypos+15 xpos+100 ypos+35]);
        reuse_block(sys, targetname, 'xps_library/Memory/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+360 ypos xpos+410 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, ...
            'explicit_period', 'on', 'period', '1', ...
            'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+200 ypos xpos+250 ypos+45]);
         reuse_block(sys, ctr_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+300 ypos xpos+320 ypos+45]);
        add_line_s(sys, 'debug_rst/1', [delay_name, '/1']);
        add_line_s(sys, [delay_name, '/1'], [rst_pipe, '/1']);
        add_line_s(sys, [rst_pipe, '/1'], [ctr_name, '/1']);
        add_line_s(sys, [sourcename, '/1'], [ctr_name, '/2']);
        add_line_s(sys, [ctr_name, '/1'], [ctr_pipe, '/1']);
        add_line_s(sys, [ctr_pipe, '/1'], [targetname, '/1']);
    else
        delete_block_s([sys, '/', delay_name]);
        delete_block_s([sys, '/', targetname]);
        delete_block_s([sys, '/', ctr_name]);
        delete_block_s([sys, '/', ctr_pipe]);
        delete_block_s([sys, '/', rst_pipe]);
    end
end

function draw_errorcounter(sys, xpos, ypos, targetname, frame_len, sourceeof, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    nobad_name = [targetname, '_nobad'];
    errchk_name = [targetname, '_errchk'];
    delay_name = [targetname, '_del'];
    rst_pipe = [targetname,'_r_pipe'];
    ctr_pipe = [targetname,'_c_pipe'];
    vld_pipe = [targetname,'_v_pipe'];
    eof_pipe = [targetname,'_e_pipe'];
    bad_pipe = [targetname,'_b_pipe'];
    errchk_name_pipe = [targetname, '_errchk_pipe'];
    delete_block_lines_s([sys, '/', errchk_name]);
    delete_block_lines_s([sys, '/', nobad_name]);
    delete_block_lines_s([sys, '/', targetname]);
    delete_block_lines_s([sys, '/', ctr_name]);
    delete_block_lines_s([sys, '/', delay_name]);
    delete_block_lines_s([sys, '/', rst_pipe]);
    delete_block_lines_s([sys, '/', ctr_pipe]);
    delete_block_lines_s([sys, '/', vld_pipe]);
    delete_block_lines_s([sys, '/', eof_pipe]);
    delete_block_lines_s([sys, '/', bad_pipe]);
    delete_block_lines_s([sys, '/', errchk_name_pipe]);
    draw_block = false;
    try
        if ((strcmp(get_param(sys, 'debug_en_all'), 'on') == 1)) && ...
           (strcmp(get_param(sys, 'debug_dis_all'), 'on') == 0)
            draw_block = true;
        end
    catch
%         if strcmp(get_param(sys, targetname), 'on') == 1
%             draw_block = true;
%         end
    end
    if draw_block
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos xpos+20 ypos+25]);
          reuse_block(sys, rst_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+60 ypos-25 xpos+100 ypos]);
        reuse_block(sys, targetname, 'xps_library/Memory/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+360 ypos xpos+410 ypos+20]);
        reuse_block(sys, errchk_name, 'casper_library_communications/frame_len_checker', ...
            'frame_len', frame_len, ...
            'Position', [xpos-100, ypos, xpos, ypos+45]);
          reuse_block(sys, errchk_name_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+60 ypos+20 xpos+100 ypos+45]);
        set_param([sys, '/', errchk_name], 'LinkStatus', 'inactive');
        reuse_block(sys, nobad_name, 'xbsIndex_r4/Constant', ...
            'arith_type', 'boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [xpos-160 ypos+30 xpos-120 ypos+45]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+200 ypos xpos+250 ypos+45]);
         reuse_block(sys, ctr_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+300 ypos xpos+320 ypos+45]);
        reuse_block(sys, vld_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos-110 ypos+5 xpos-105 ypos+15]);
         reuse_block(sys, eof_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos-110 ypos+20 xpos-105 ypos+30]);
          reuse_block(sys, rst_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+60 ypos-25 xpos+100 ypos]);
          reuse_block(sys, bad_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position',  [xpos-110 ypos+35 xpos-105 ypos+45]);
        add_line_s(sys, [sourcevalid, '/1'], [vld_pipe, '/1']);
        add_line_s(sys, [vld_pipe, '/1'], [errchk_name, '/1']);
        add_line_s(sys, [sourceeof, '/1'], [eof_pipe, '/1']);
         add_line_s(sys, [eof_pipe, '/1'], [errchk_name, '/2']);
        add_line_s(sys, [nobad_name, '/1'], [bad_pipe, '/1']);
        add_line_s(sys, [bad_pipe, '/1'], [errchk_name, '/3']);
        add_line_s(sys, 'debug_rst/1', [delay_name, '/1']);
        add_line_s(sys, [delay_name, '/1'], [rst_pipe, '/1']);
        add_line_s(sys, [rst_pipe, '/1'], [ctr_name, '/1']);
        add_line_s(sys, [errchk_name, '/1'], [errchk_name_pipe, '/1']);
        add_line_s(sys, [errchk_name_pipe, '/1'], [ctr_name, '/2']);
        add_line_s(sys, [ctr_name, '/1'], [ctr_pipe, '/1']);
        add_line_s(sys, [ctr_pipe, '/1'], [targetname, '/1']);
    else
        delete_block_s([sys, '/', delay_name]);
        delete_block_s([sys, '/', errchk_name]);
        delete_block_s([sys, '/', nobad_name]);
        delete_block_s([sys, '/', targetname]);
        delete_block_s([sys, '/', ctr_name]);
        delete_block_s([sys, '/', rst_pipe]);
        delete_block_s([sys, '/', ctr_pipe]);
        delete_block_s([sys, '/', vld_pipe]);
        delete_block_s([sys, '/', eof_pipe]);
        delete_block_s([sys, '/', bad_pipe]);
        delete_block_s([sys, '/', errchk_name_pipe]);
    end
end

function draw_rxcounter(sys, xpos, ypos, targetname, sourceeof, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    and_name = [targetname, '_and'];
    ed_name = [targetname, '_ed'];
    delay_name = [targetname, '_del'];
    rst_pipe = [targetname,'_r_pipe'];
    ctr_pipe = [targetname,'_c_pipe'];
    vld_pipe = [targetname,'_v_pipe'];
    eof_pipe = [targetname,'_e_pipe'];
    draw_block = false;
    try
        if ((strcmp(get_param(sys, 'debug_en_all'), 'on') == 1)) && ...
           (strcmp(get_param(sys, 'debug_dis_all'), 'on') == 0)
            draw_block = true;
        end
    catch
%         if strcmp(get_param(sys, targetname), 'on') == 1
%             draw_block = true;
%         end
    end
    if draw_block
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos xpos+20 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/Memory/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+350 ypos xpos+400 ypos+20]);
        reuse_block(sys, vld_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+30 ypos xpos+40 ypos+45]);
         reuse_block(sys, eof_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+30 ypos+5 xpos+40 ypos+45+5]);
          reuse_block(sys, rst_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+10 ypos+5 xpos+20 ypos+40]);
        reuse_block(sys, and_name, 'xbsIndex_r4/Logical', ...
            'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
            'latency', '1', 'Position', [xpos+50 ypos xpos+100 ypos+45]);
        reuse_block(sys, ed_name, 'casper_library_misc/edge_detect', ...
            'edge', 'Rising', 'polarity', 'Active High', ...
            'Position', [xpos+150 ypos xpos+200 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+250 ypos xpos+300 ypos+45]);
         reuse_block(sys, ctr_pipe, 'casper_library_delays/pipeline', ...
             'latency', '3', 'Position', [xpos+320 ypos xpos+340 ypos+45]);
        add_line_s(sys, [sourceeof, '/1'], [vld_pipe, '/1']);
        add_line_s(sys, [vld_pipe, '/1'], [and_name, '/1']);
        add_line_s(sys, [sourcevalid, '/1'], [eof_pipe, '/1']);
        add_line_s(sys, [eof_pipe, '/1'], [and_name, '/2']);
        add_line_s(sys, [and_name, '/1'], [ed_name, '/1']);
        add_line_s(sys, 'debug_rst/1', [delay_name, '/1']);
        add_line_s(sys, [delay_name, '/1'], [rst_pipe, '/1']);
        add_line_s(sys, [rst_pipe, '/1'], [ctr_name, '/1']);
        add_line_s(sys, [ed_name, '/1'], [ctr_name, '/2']);
        add_line_s(sys, [ctr_name, '/1'], [ctr_pipe, '/1']);
        add_line_s(sys, [ctr_pipe, '/1'], [targetname, '/1']);
    else
        delete_block_lines_s([sys, '/', and_name]);
        delete_block_lines_s([sys, '/', ed_name]);
        delete_block_lines_s([sys, '/', targetname]);
        delete_block_lines_s([sys, '/', ctr_name]);
        delete_block_lines_s([sys, '/', delay_name]);
        delete_block_s([sys, '/', delay_name]);
        delete_block_s([sys, '/', and_name]);
        delete_block_s([sys, '/', ed_name]);
        delete_block_s([sys, '/', targetname]);
        delete_block_s([sys, '/', ctr_name]);
        delete_block_s([sys, '/', rst_pipe]);
        delete_block_s([sys, '/', ctr_pipe]);
        delete_block_s([sys, '/', vld_pipe]);
        delete_block_s([sys, '/', eof_pipe]);
    end
end
% 
 for s=1:num_qsfp_ports
 
     % tx counter
     starty = 450 + s*460;
     draw_rxcounter(cursys, 400, starty, strcat('txctr',num2str(s)), strcat('tx_end_of_frame',num2str(s)), strcat('tx_valid',num2str(s)));

    % tx error counter
    starty = starty + 50;
    draw_errorcounter(cursys, 400, starty, strcat('txerrctr',num2str(s)), get_param(cursys, 'txerrctr_len'), strcat('tx_end_of_frame',num2str(s)), strcat('tx_valid',num2str(s)));

    % tx overflow counter
    starty = starty + 50;
    draw_counter(cursys, 400, starty, strcat('txofctr',num2str(s)), strcat('tx_overflow',num2str(s),'_pipe'));

    % tx full counter
    starty = starty + 50;
    draw_counter(cursys, 400, starty, strcat('txfullctr',num2str(s)),  strcat('tx_afull',num2str(s),'_pipe'));

    % tx valid counter
    starty = starty + 50;
    draw_counter(cursys, 400, starty, strcat('txvldctr',num2str(s)), strcat('tx_valid',num2str(s),'_pipe'));
% 
%     % draw all the tx registers
% 
    % rx counter
    starty = 130 + s*600;
    % draw_rxcounter(cursys, 1400, starty, 'rxctr', clear_name([cursys, '_rx_end_of_frame']), valid_source)
    draw_rxcounter(cursys, 1600, starty, strcat('rxctr',num2str(s)), strcat('rx_eof',num2str(s),'_pipe'), strcat('rx_vld_or_out_',num2str(s),'_pipe'));

    % rx error counter
    starty = starty + 100;
    % draw_errorcounter(cursys, 1400, starty, 'rxerrctr', get_param(cursys, 'rxerrctr_len'), clear_name([cursys, '_rx_end_of_frame']), valid_source);
    draw_errorcounter(cursys, 1800, starty, strcat('rxerrctr',num2str(s)), get_param(cursys, 'rxerrctr_len'), strcat('rx_eof',num2str(s),'_pipe'), strcat('rx_vld_or_out_',num2str(s),'_pipe'));

    % rx overflow counter
    starty = starty + 50;
    % draw_counter(cursys, 1400, starty, 'rxofctr', clear_name([cursys, '_rx_overrun']));
    draw_counter(cursys, 1800, starty, strcat('rxofctr',num2str(s)), strcat('rx_overrun',num2str(s),'_pipe'));

    % rx bad frame counter
    starty = starty + 50;
    % draw_counter(cursys, 1400, starty, 'rxbadctr', clear_name([cursys, '_rx_bad_frame']));
    draw_counter(cursys, 1800, starty, strcat('rxbadctr',num2str(s)), strcat('rx_bad_frame',num2str(s),'_pipe'));

    % rx valid counter
    starty = starty + 50;
    draw_counter(cursys, 1800, starty, strcat('rxvldctr',num2str(s)),  strcat('rx_vld_or_out_',num2str(s),'_pipe'));

    % rx eof counter
    starty = starty + 50;
    % draw_counter(cursys, 1400, starty, 'rxeofctr', clear_name([cursys, '_rx_end_of_frame']));
    draw_counter(cursys, 1800, starty, strcat('rxeofctr',num2str(s)), strcat('rx_end_of_frame',num2str(s),'_pipe'));

    %rx snapshot
    forty_gbe_mask_draw_rxsnap(cursys, num2str(s), strcat(num2str(s),'_pipe'),strcat('rx_vld_or_out_',num2str(s),'_pipe'));

    % tx snapshot
    %forty_gbe_mask_draw_txsnap(cursys, strcat('pipeline',num2str(s)));
end


% remove unconnected blocks
clean_blocks(cursys);
 
 try
     incoming_latency = eval(get_param(cursys, 'input_pipeline_delay'));
 catch
     incoming_latency = 0;
 end
 display_string = sprintf('incoming_latency=%i', incoming_latency);
 set_param(cursys, 'AttributesFormatString', display_string);
% 
% end
end
