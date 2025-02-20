function [port_num] = add_rts_ports(gcb, gen, num_adc_slices, tiles, adc_slices, port_num)

  base_name = clear_name(gcb);
  xil_gw_out = 'xbsIndex_r4/Gateway Out';
  xil_gw_in= 'xbsIndex_r4/Gateway In';
  arith_type = 'Bool';
  n_bits = 1;
  bin_pt = 0;
  enabled_adc_per_tile = sum(adc_slices,2);

  % template of ports to add for each enabled tile and slice
  adc_rts_o = ["_over_range", "_over_threshold1", "_over_threshold2", "_over_voltage"];
  adc_rts_i = ["_pl_event", "_clear_or"];
  if gen > 1
    adc_rts_o(end+1) = "_cm_over_voltage";
    adc_rts_o(end+1) = "_cm_under_voltage";
    adc_rts_i(end+1) = "_clear_ov";
    % gen3 have only one instance per enabled tile of "_sync_out" as an
    % output and "_sysref_gate" as an input. Instead of append to rts_o/i we
    % just augment the number of ports and handle adding it separately.
    num_obus_ports = length(adc_rts_o)*enabled_adc_per_tile + 1;
    num_ibus_ports = length(adc_rts_i)*enabled_adc_per_tile + 1;
  else
    num_obus_ports = length(adc_rts_o)*enabled_adc_per_tile;
    num_ibus_ports = length(adc_rts_i)*enabled_adc_per_tile;
  end


  for t=224:227
    xpos_origin = 1000*(t-224) + 400;
    ypos_origin = 40;
    if tiles(t-223)
      % create a bus for each rts signal in a tile
      bus_name = ['adc', num2str(t-224), '_rts_signals'];
      bus_xpos = xpos_origin + 600;
      bus_ypos = ypos_origin;
      bus_pos = [bus_xpos, bus_ypos, bus_xpos+170, bus_ypos+50];

      reuse_block(gcb, bus_name, 'casper_library_flow_control/bus_create', ...
        'inputNum', num2str(num_obus_ports(t-223)), ...
        'Position', bus_pos);

      % ground simulation inputs
      % TODO could add inputs for simulation support. An implementation would look similar to how `sw_reg`
      % handles "from processor" sim inputs. Grounding for now is because it doesn't seem much use would
      % come from supporting simulation on these ports.
      gnd_xpos = xpos_origin + 250;
      gnd_ypos = ypos_origin;
      gnd_pos = [gnd_xpos, gnd_ypos, gnd_xpos+30, gnd_ypos+15];
      gnd_name = ['gnd_', 'adc', num2str(t-224), '_rts'];
      reuse_block(gcb, gnd_name, 'simulink/Commonly Used Blocks/Ground', ...
        'Position', gnd_pos);

      % expander for input signals
      expander_name = ['adc', num2str(t-224), '_rts_signal_expander'];
      exp_xpos = xpos_origin + 100;
      exp_ypos = ypos_origin + 200;
      expander_pos = [exp_xpos, exp_ypos, exp_xpos+170, exp_ypos+50];
      reuse_block(gcb, expander_name, 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', num2str(num_ibus_ports(t-223)), ...
        'outputWidth', '1', ...
        'outputBinaryPt', '0', ...
        'outputArithmeticType', '2', ...
        'Position', expander_pos);

      gw_xpos = xpos_origin + 400;
      gw_ypos = ypos_origin;
      bus_port_num = 1;
      exp_port_num = 1;
      for a = 0:(num_adc_slices-1)
        if adc_slices(t-223,a+1) % check if the slice is on
          for rts_port_idx = 1:length(adc_rts_o) % add gw for each rts signal, and connect to bus
            rts_port_suffix = adc_rts_o(rts_port_idx);
            gwname = [base_name, '_adc', num2str(t-224), num2str(a), char(rts_port_suffix)];
            gw_pos = [gw_xpos, gw_ypos, gw_xpos+70, gw_ypos+20];

            reuse_block(gcb, gwname, xil_gw_in, ...
              'arith_type', arith_type, ...
              'n_bits', num2str(n_bits), ...
              'bin_pt', num2str(bin_pt), ...
              'Position', gw_pos);

            add_line(gcb, [gnd_name, '/1'], [gwname, '/1']);
            add_line(gcb, [gwname, '/1'], [bus_name, '/', num2str(bus_port_num)]);

            gw_ypos = gw_ypos+80;
            bus_port_num = bus_port_num+1;
          end % rts_port_idx

          for rts_iport_idx = 1:length(adc_rts_i) % add gw for each input rts signal
            rts_port_suffix = adc_rts_i(rts_iport_idx);
            gwname = [base_name, '_adc', num2str(t-224), num2str(a), char(rts_port_suffix)];
            gw_pos = [gw_xpos, gw_ypos, gw_xpos+70, gw_ypos+20];

            reuse_block(gcb, gwname, xil_gw_out, ...
              'Position', gw_pos);

            % terminate simulation input signals
            term_pos = gw_pos + [90, 0, 95, 0];
            term_name = ['term_', 'adc', num2str(t-224), '_rts_',num2str(exp_port_num)];
            reuse_block(gcb, term_name, 'simulink/Commonly Used Blocks/Terminator', ...
              'Position', term_pos);

            add_line(gcb, [expander_name, '/', num2str(exp_port_num)], [gwname, '/1']);
            add_line(gcb, [gwname, '/1'], [term_name, '/1']);

            gw_ypos = gw_ypos+80;
            exp_port_num = exp_port_num+1;
          end % adc_rts_i ports
        end % adc slice is enabled
      end % a = adcs

      % add gen3 specific ports where there is to only be one per enabled tile
      if gen > 1
        % add sync out
        gwname = [base_name, '_adc', num2str(t-224), '_sync_out'];
        gw_pos = [gw_xpos, gw_ypos, gw_xpos+70, gw_ypos+20];

        reuse_block(gcb, gwname, xil_gw_in, ...
          'arith_type', arith_type, ...
          'n_bits', num2str(n_bits), ...
          'bin_pt', num2str(bin_pt), ...
          'Position', gw_pos);

        add_line(gcb, [gnd_name, '/1'], [gwname, '/1']);
        add_line(gcb, [gwname, '/1'], [bus_name, '/', num2str(bus_port_num)]);
        gw_ypos = gw_ypos+80;
        bus_port_num = bus_port_num+1;

        % add sysref gate
        gwname = [base_name, '_adc', num2str(t-224), '_sysref_gate'];
        gw_pos = [gw_xpos, gw_ypos, gw_xpos+70, gw_ypos+20];

        reuse_block(gcb, gwname, xil_gw_out, ...
          'Position', gw_pos);

        % terminate simulation input signals
        term_pos = gw_pos + [90, 0, 95, 0];
        term_name = ['term_', 'adc', num2str(t-224), '_rts_',num2str(exp_port_num)];
        reuse_block(gcb, term_name, 'simulink/Commonly Used Blocks/Terminator', ...
          'Position', term_pos);

        add_line(gcb, [expander_name, '/', num2str(exp_port_num)], [gwname, '/1']);
        add_line(gcb, [gwname, '/1'], [term_name, '/1']);

        gw_ypos = gw_ypos+80;
        exp_port_num = exp_port_num+1;
      end % gen > 1

      oport_xpos = xpos_origin + 800;
      oport_ypos = ypos_origin;
      oport_pos = [oport_xpos, oport_ypos, oport_xpos+30, oport_ypos+15];
      oport_name = ['adc', num2str(t-224), '_rts_out'];
      reuse_block(gcb, oport_name, 'built-in/outport', ...
        'Port', num2str(port_num), ...
        'Position', oport_pos);

      add_line(gcb, [bus_name, '/1'], [oport_name, '/1']);

      iport_xpos = xpos_origin;
      iport_ypos = ypos_origin + 200;
      iport_pos = [iport_xpos, iport_ypos, iport_xpos+30, iport_ypos+15];
      iport_name = ['adc', num2str(t-224), '_rts_in'];
      reuse_block(gcb, iport_name, 'built-in/inport', ...
        'Port', num2str(port_num), ...
        'Position', iport_pos);

      add_line(gcb, [iport_name, '/1'], [expander_name, '/1']);

      % increment global port number to return back to mask
      port_num = port_num+1;

    end % tile enabled
  end % t = tiles
end % function [] add_rts_ports

