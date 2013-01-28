
function b = xps_adc16(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_adc16')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
inst_name = clear_name(blk_name);
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys = get(xsg_obj,'hw_sys');
s.roach2_rev = get_param(blk_name,'roach2_rev');
board_count = get_param(blk_name,'board_count'); % Number of ADC boards
s.num_units = 4*str2num(board_count);            % Number of ADC chips
s.fabric_mhz = get(xsg_obj,'clk_rate');
s.line_mhz = 2 * s.fabric_mhz;

% Validate hw_sys
switch s.hw_sys
    case {'ROACH2'} %,'ROACH'}
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end 

% Validate num_units
if s.num_units ~= 4 && s.num_units ~= 8
    error('Number of ADC16 boards must be 1 or 2');
end

% Validate fabric_mhz
if s.fabric_mhz> 250
    error('Max fabric clock rate with ADC16 is 250 MHz');
end

b = class(s,'xps_adc16',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc16_interface');
switch s.hw_sys
  case {'ROACH', 'ROACH2'},
    b = set(b, 'ip_version', '1.00.a');
end

b = set(b, 'opb0_devices', 1 + s.num_units); % controller plus snap BRAMs

% Tells which other PCORES are needed for this block
supp_ip_names    = {'', 'opb_adc16_controller'};
supp_ip_versions = {'','1.00.a'};
b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% These parameters become generics of the adc16_interface.  Even though we
% really want G_ROACH2_REV to be a generic of adc16_controller, that is not
% possible (at least to this yellow block developer) so we set them up as
% generics of the adc16_interface which simply outputs them to the
% adc16_controller (via wires in system.mhs).
parameters.G_ROACH2_REV = s.roach2_rev;
parameters.G_NUM_UNITS = num2str(s.num_units);
b = set(b,'parameters',parameters);

% ports

%b = set(b,'ports', ports);

% misc ports

misc_ports.fabric_clk     = {1 'out'  'adc0_clk'};
misc_ports.fabric_clk_90  = {1 'out'  'adc0_clk90'};
misc_ports.fabric_clk_180 = {1 'out'  'adc0_clk180'};
misc_ports.fabric_clk_270 = {1 'out'  'adc0_clk270'};

misc_ports.reset            = {1 'in'  'adc16_reset'};
misc_ports.iserdes_bitslip  = {8 'in'  'adc16_iserdes_bitslip'};

misc_ports.delay_rst   = {32 'in'  'adc16_delay_rst'};
misc_ports.delay_tap   = { 5 'in'  'adc16_delay_tap'};

misc_ports.snap_req  = { 1 'in'  'adc16_snap_req'};
misc_ports.snap_we   = { 1 'out' 'adc16_snap_we'};
misc_ports.snap_addr = {10 'out' 'adc16_snap_addr'};

misc_ports.locked     = {2 'out' 'adc16_locked'};
misc_ports.roach2_rev = {2 'out' 'adc16_roach2_rev'};
misc_ports.num_units  = {4 'out' 'adc16_num_units'};

b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct();
ucf_constraints_clk  = struct( ...
    'IOSTANDARD', 'LVDS_25', ...
    'DIFF_TERM', 'TRUE', ...
    'PERIOD', [num2str(1000/s.line_mhz), ' ns']);
ucf_constraints_lvds = struct( ...
    'IOSTANDARD', 'LVDS_25', ...
    'DIFF_TERM', 'TRUE');
ucf_constraints_standard = struct( ...
    'IOSTANDARD', 'LVCMOS15');

% Setup pins for roach2 (rev2) zdok0 and zdok1

r2_zdok0_clk_p_pins = {'R28', 'H39', 'J42', 'P30'};
r2_zdok0_clk_n_pins = {'R29', 'H38', 'K42', 'P31'};

r2_zdok0_frm_p_pins = {'P27', 'G34', 'F39', 'B37'};
r2_zdok0_frm_n_pins = {'R27', 'H34', 'G39', 'A37'};

r2_zdok0_ser_a_p_pins = {
  'J37',
  'L35',
  'K37', % rev1: L34
  'L31',
  'J35',
  'K38',
  'K39',
  'N29',
  'F40',
  'E42',
  'H36',
  'D40',
  'B38',
  'D38',
  'F35',
  'B39',
};

r2_zdok0_ser_a_n_pins = {
  'J36',
  'L36',
  'L37', % rev1: M34
  'L32',
  'H35',
  'J38',
  'K40',
  'N30',
  'F41',
  'F42',
  'G36',
  'E40',
  'A39',
  'C38',
  'F36',
  'C39',
};

r2_zdok0_ser_b_p_pins = {
  'K33',
  'M33', % rev1: M36
  'M31', % rev1: M33
  'N28',
  'H40',
  'L34', % rev1: K37
  'K35',
  'J40',
  'C40',
  'F37',
  'G41',
  'G37',
  'B41',
  'A40',
  'E39',
  'D42',
};

r2_zdok0_ser_b_n_pins = {
  'K32',
  'M32', % rev1: M37
  'N31', % rev1: M32
  'P28',
  'H41',
  'M34', % rev1: L37
  'K34',
  'J41',
  'C41',
  'E37',
  'G42',
  'G38',
  'B42',
  'A41',
  'E38',
  'D41',
};

r2_zdok1_clk_p_pins = {'AA35', 'V34', 'W30', 'AE30'};
r2_zdok1_clk_n_pins = {'Y35',  'U34', 'V30', 'AF30'};

r2_zdok1_frm_p_pins = {'AA34', 'U37', 'T39', 'N40'};
r2_zdok1_frm_n_pins = {'Y34',  'U38', 'R38', 'N41'};

r2_zdok1_ser_a_p_pins = {
  'W42',
  'W35',
  'Y38',
  'AA36',
  'U42',
  'V38',
  'V41',
  'W36',
  'R40',
  'T41',
  'R35',
  'T34',
  'M41',
  'N38',
  'M36', % rev1: N36
  'P36',
};

r2_zdok1_ser_a_n_pins = {
  'Y42',
  'V35',
  'AA39',
  'AA37',
  'U41',
  'W38',
  'W41',
  'V36',
  'T40',
  'T42',
  'R34',
  'T35',
  'M42',
  'N39',
  'M37', % rev1: P37
  'P35',
};

r2_zdok1_ser_b_p_pins = {
  'V33',
  'W32',
  'W37',
  'AA32',
  'U39',
  'V40',
  'U32',
  'Y40',
  'R39',
  'P42',
  'R37',
  'U36',
  'L41',
  'M38',
  'N36', % rev1: M31
  'P40',
};

r2_zdok1_ser_b_n_pins = {
  'W33',
  'Y33',
  'Y37',
  'Y32',
  'V39',
  'W40',
  'U33',
  'Y39',
  'P38',
  'R42',
  'T37',
  'T36',
  'L42',
  'M39',
  'P37', % rev1: N31
  'P41',
};

% Tweak pins for ROACH2 Revision 1
if strcmp(s.roach2_rev,'1')
  r2_zdok0_ser_a_p_pins{3} = 'L34';
  r2_zdok0_ser_a_n_pins{3} = 'M34';

  r2_zdok0_ser_b_p_pins{2} = 'M36';
  r2_zdok0_ser_b_n_pins{2} = 'M37';

  r2_zdok0_ser_b_p_pins{3} = 'M33';
  r2_zdok0_ser_b_n_pins{3} = 'M32';

  r2_zdok0_ser_b_p_pins{6} = 'K37';
  r2_zdok0_ser_b_n_pins{6} = 'L37';

  r2_zdok1_ser_a_p_pins{15} = 'N36';
  r2_zdok1_ser_a_n_pins{15} = 'P37';

  r2_zdok1_ser_b_p_pins{15} = 'M31';
  r2_zdok1_ser_b_n_pins{15} = 'N31';
end

% TODO Select roach1 or roach2 and zdok0 or zdok1, but for now only roach2 zdok0
zdok0_clock_p_str = sprintf('''%s'',', r2_zdok0_clk_p_pins{:});
zdok0_clock_n_str = sprintf('''%s'',', r2_zdok0_clk_n_pins{:});
zdok0_frame_p_str = sprintf('''%s'',', r2_zdok0_frm_p_pins{:});
zdok0_frame_n_str = sprintf('''%s'',', r2_zdok0_frm_n_pins{:});
zdok0_ser_a_p_str = sprintf('''%s'',', r2_zdok0_ser_a_p_pins{:});
zdok0_ser_a_n_str = sprintf('''%s'',', r2_zdok0_ser_a_n_pins{:});
zdok0_ser_b_p_str = sprintf('''%s'',', r2_zdok0_ser_b_p_pins{:});
zdok0_ser_b_n_str = sprintf('''%s'',', r2_zdok0_ser_b_n_pins{:});

zdok1_clock_p_str = sprintf('''%s'',', r2_zdok1_clk_p_pins{:});
zdok1_clock_n_str = sprintf('''%s'',', r2_zdok1_clk_n_pins{:});
zdok1_frame_p_str = sprintf('''%s'',', r2_zdok1_frm_p_pins{:});
zdok1_frame_n_str = sprintf('''%s'',', r2_zdok1_frm_n_pins{:});
zdok1_ser_a_p_str = sprintf('''%s'',', r2_zdok1_ser_a_p_pins{:});
zdok1_ser_a_n_str = sprintf('''%s'',', r2_zdok1_ser_a_n_pins{:});
zdok1_ser_b_p_str = sprintf('''%s'',', r2_zdok1_ser_b_p_pins{:});
zdok1_ser_b_n_str = sprintf('''%s'',', r2_zdok1_ser_b_n_pins{:});

if s.num_units == 4
  % Remove trainling comma from pin strings and surround with braces
  clock_p_str = ['{', zdok0_clock_p_str(1:end-1), '}'];
  clock_n_str = ['{', zdok0_clock_n_str(1:end-1), '}'];
  frame_p_str = ['{', zdok0_frame_p_str(1:end-1), '}'];
  frame_n_str = ['{', zdok0_frame_n_str(1:end-1), '}'];
  ser_a_p_str = ['{', zdok0_ser_a_p_str(1:end-1), '}'];
  ser_a_n_str = ['{', zdok0_ser_a_n_str(1:end-1), '}'];
  ser_b_p_str = ['{', zdok0_ser_b_p_str(1:end-1), '}'];
  ser_b_n_str = ['{', zdok0_ser_b_n_str(1:end-1), '}'];
else
  % Remove trainling comma from pin strings and surround with braces
  clock_p_str = ['{', zdok0_clock_p_str, zdok1_clock_p_str(1:end-1), '}'];
  clock_n_str = ['{', zdok0_clock_n_str, zdok1_clock_n_str(1:end-1), '}'];
  frame_p_str = ['{', zdok0_frame_p_str, zdok1_frame_p_str(1:end-1), '}'];
  frame_n_str = ['{', zdok0_frame_n_str, zdok1_frame_n_str(1:end-1), '}'];
  ser_a_p_str = ['{', zdok0_ser_a_p_str, zdok1_ser_a_p_str(1:end-1), '}'];
  ser_a_n_str = ['{', zdok0_ser_a_n_str, zdok1_ser_a_n_str(1:end-1), '}'];
  ser_b_p_str = ['{', zdok0_ser_b_p_str, zdok1_ser_b_p_str(1:end-1), '}'];
  ser_b_n_str = ['{', zdok0_ser_b_n_str, zdok1_ser_b_n_str(1:end-1), '}'];
end

ext_ports.clk_line_p = {  s.num_units 'in'  'adc16_clk_line_p'  clock_p_str  'vector=true'  mhs_constraints ucf_constraints_clk  };
ext_ports.clk_line_n = {  s.num_units 'in'  'adc16_clk_line_n'  clock_n_str  'vector=true'  mhs_constraints ucf_constraints_clk  };
ext_ports.clk_frame_p = { s.num_units 'in'  'adc16_clk_frame_p' frame_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.clk_frame_n = { s.num_units 'in'  'adc16_clk_frame_n' frame_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_a_p    = {4*s.num_units 'in'  'adc16_ser_a_p'     ser_a_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_a_n    = {4*s.num_units 'in'  'adc16_ser_a_n'     ser_a_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_p    = {4*s.num_units 'in'  'adc16_ser_b_p'     ser_b_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_n    = {4*s.num_units 'in'  'adc16_ser_b_n'     ser_b_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };

b = set(b,'ext_ports',ext_ports);
