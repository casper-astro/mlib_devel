
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
zdok_rev = str2num(get_param(blk_name,'zdok_rev'));
board_count = get_param(blk_name,'board_count'); % Number of ADC boards
s.num_units = 4*str2num(board_count);            % Number of ADC chips
s.fabric_mhz = get(xsg_obj,'clk_rate');
s.line_mhz = 2 * s.fabric_mhz;
% Default num_clocks to board_count (i.e. one clock per board)
num_clocks = str2num(board_count);
% If zdok_rev is 1, we have one clock per chip
if zdok_rev == 1
  num_clocks = s.num_units;
end

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

% Miscellaneous UCF related items
if zdok_rev == 1
  %b = set(b,'line_clk_index',3);
  s.line_clk_index = 3;

  % Control singal pins for zdok revision 1 are the same for both ROACH2
  % revisions because the control signals went via GPIO headers and ribbon
  % cables to ADC baords.

  % Control signal pins for ADC in ZDOK 0
  s.pin_csn1   = 'LOC = F16  | IOSTANDARD = LVCMOS15';
  s.pin_csn2   = 'LOC = H18  | IOSTANDARD = LVCMOS15';
  s.pin_csn3   = 'LOC = N20  | IOSTANDARD = LVCMOS15';
  s.pin_csn4   = 'LOC = N19  | IOSTANDARD = LVCMOS15';
  s.pin_sdata0 = 'LOC = K30  | IOSTANDARD = LVCMOS15';
  s.pin_sclk0  = 'LOC = M28  | IOSTANDARD = LVCMOS15';
  % Control signal pins for ADC in ZDOK 1
  s.pin_csn5   = 'LOC = H30  | IOSTANDARD = LVCMOS15';
  s.pin_csn6   = 'LOC = L30  | IOSTANDARD = LVCMOS15';
  s.pin_csn7   = 'LOC = AG33 | IOSTANDARD = LVCMOS15';
  s.pin_csn8   = 'LOC = AF32 | IOSTANDARD = LVCMOS15';
  s.pin_sdata1 = 'LOC = H31  | IOSTANDARD = LVCMOS15';
  s.pin_sclk1  = 'LOC = G31  | IOSTANDARD = LVCMOS15';

else % ZDOK revision 2
  %b = set(b,'line_clk_index',0);
  s.line_clk_index = 0;

  % Control singal pins for zdok revision 2 are different for ROACH2 rev 1 and
  % rev 2 because they go through the ZDOK connectors now.  Set them all for
  % ROACH2 rev2, then tweak the ones that need changing for ROACH2 rev 1.

  % Control signal pins for ZDOK 0
  s.pin_csn1   = 'LOC = R29  | IOSTANDARD = LVCMOS25';
  s.pin_csn2   = 'LOC = P28  | IOSTANDARD = LVCMOS25';
  s.pin_csn3   = 'LOC = N31  | IOSTANDARD = LVCMOS25'; % Rev 1: M32
  s.pin_csn4   = 'LOC = N28  | IOSTANDARD = LVCMOS25';
  s.pin_sdata0 = 'LOC = R28  | IOSTANDARD = LVCMOS25';
  s.pin_sclk0  = 'LOC = M31  | IOSTANDARD = LVCMOS25'; % Rev 1: M33
  % Control signal pins for ZDOK 1
  s.pin_csn5   = 'LOC = Y35  | IOSTANDARD = LVCMOS25';
  s.pin_csn6   = 'LOC = Y32  | IOSTANDARD = LVCMOS25';
  s.pin_csn7   = 'LOC = Y37  | IOSTANDARD = LVCMOS25';
  s.pin_csn8   = 'LOC = AA32 | IOSTANDARD = LVCMOS25';
  s.pin_sdata1 = 'LOC = AA35 | IOSTANDARD = LVCMOS25';
  s.pin_sclk1  = 'LOC = W37  | IOSTANDARD = LVCMOS25';

  % Tweak pins for ROACH2 Revision 1
  if strcmp(s.roach2_rev,'1')
    s.pin_csn3  = 'LOC = M32  | IOSTANDARD = LVCMOS25';
    s.pin_sclk0 = 'LOC = M33  | IOSTANDARD = LVCMOS25';
  end
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
parameters.G_ZDOK_REV   = num2str(zdok_rev);
parameters.G_NUM_UNITS  = num2str(s.num_units);
parameters.G_NUM_CLOCKS = num2str(num_clocks);
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
misc_ports.zdok_rev   = {2 'out' 'adc16_zdok_rev'};
misc_ports.num_units  = {4 'out' 'adc16_num_units'};

if zdok_rev == 2
  misc_ports.clk_frame_p = {num_clocks 'in' 'net_gnd'};
  misc_ports.clk_frame_n = {num_clocks 'in' 'net_gnd'};
end

b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct();
ucf_constraints_lvds = struct( ...
    'IOSTANDARD', 'LVDS_25', ...
    'DIFF_TERM', 'TRUE');

% Setup pins_1 and pins_2 for roach2 (rev2) zdok0 and zdok1
% "...pins_1" are for zdok revision 1
% "...pins_2" are for zdok revision 2

r2_zdok0_clk_p_pins_1 = {'R28', 'H39', 'J42', 'P30'};
r2_zdok0_clk_n_pins_1 = {'R29', 'H38', 'K42', 'P31'};

r2_zdok0_frm_p_pins_1 = {'P27', 'G34', 'F39', 'B37'};
r2_zdok0_frm_n_pins_1 = {'R27', 'H34', 'G39', 'A37'};

r2_zdok0_ser_a_p_pins_1 = {
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

r2_zdok0_ser_a_n_pins_1 = {
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

r2_zdok0_ser_b_p_pins_1 = {
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

r2_zdok0_ser_b_n_pins_1 = {
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

r2_zdok1_clk_p_pins_1 = {'AA35', 'V34', 'W30', 'AE30'};
r2_zdok1_clk_n_pins_1 = {'Y35',  'U34', 'V30', 'AF30'};

r2_zdok1_frm_p_pins_1 = {'AA34', 'U37', 'T39', 'N40'};
r2_zdok1_frm_n_pins_1 = {'Y34',  'U38', 'R38', 'N41'};

r2_zdok1_ser_a_p_pins_1 = {
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

r2_zdok1_ser_a_n_pins_1 = {
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

r2_zdok1_ser_b_p_pins_1 = {
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

r2_zdok1_ser_b_n_pins_1 = {
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

r2_zdok0_clk_p_pins_2 = {'P30'};
r2_zdok0_clk_n_pins_2 = {'P31'};

%r2_zdok0_frm_p_pins_2 = {};
%r2_zdok0_frm_n_pins_2 = {};

r2_zdok0_ser_a_p_pins_2 = {
  'K39',
  'J40',
  'N29',
  'L35',
  'G37',
  'H39',
  'G34',
  'K38',
  'F35',
  'B39',
  'F37',
  'H36',
  'B41',
  'J42',
  'E39',
  'B38',
};

r2_zdok0_ser_a_n_pins_2 = {
  'K40',
  'J41',
  'N30',
  'L36',
  'G38',
  'H38',
  'H34',
  'J38',
  'F36',
  'C39',
  'E37',
  'G36',
  'B42',
  'K42',
  'E38',
  'A39',
};

r2_zdok0_ser_b_p_pins_2 = {
  'L34', % rev1: K37
  'K35',
  'K33',
  'J37',
  'F39',
  'G41',
  'H40',
  'J35',
  'C40',
  'F40',
  'E42',
  'D40',
  'B37',
  'A40',
  'D38',
  'D42',
};

r2_zdok0_ser_b_n_pins_2 = {
  'M34', % rev1: L37
  'K34',
  'K32',
  'J36',
  'G39',
  'G42',
  'H41',
  'H35',
  'C41',
  'F41',
  'F42',
  'E40',
  'A37',
  'A41',
  'C38',
  'D41',
};

r2_zdok1_clk_p_pins_2 = {'AE30'};
r2_zdok1_clk_n_pins_2 = {'AF30'};

%r2_zdok1_frm_p_pins_2 = {};
%r2_zdok1_frm_n_pins_2 = {};

r2_zdok1_ser_a_p_pins_2 = {
  'V41',
  'Y40',
  'W36',
  'W35',
  'U36',
  'V34',
  'U37',
  'V38',
  'M36', % rev1: N36
  'P36',
  'P42',
  'R35',
  'L41',
  'W30',
  'N36', % rev1: M31
  'M41',
};

r2_zdok1_ser_a_n_pins_2 = {
  'W41',
  'Y39',
  'V36',
  'V35',
  'T36',
  'U34',
  'U38',
  'W38',
  'M37', % rev1: P37
  'P35',
  'R42',
  'R34',
  'L42',
  'V30',
  'P37', % rev1: N31
  'M42',
};

r2_zdok1_ser_b_p_pins_2 = {
  'V40',
  'U32',
  'V33',
  'W42',
  'T39',
  'R37',
  'U39',
  'U42',
  'R39',
  'R40',
  'T41',
  'T34',
  'N40',
  'M38',
  'N38',
  'P40',
};

r2_zdok1_ser_b_n_pins_2 = {
  'W40',
  'U33',
  'W33',
  'Y42',
  'R38',
  'T37',
  'V39',
  'U41',
  'P38',
  'T40',
  'T42',
  'T35',
  'N41',
  'M39',
  'N39',
  'P41',
};

% Tweak pins for ROACH2 Revision 1
if strcmp(s.roach2_rev,'1')
  % ZDOK revision 1
  r2_zdok0_ser_a_p_pins_1{3} = 'L34';
  r2_zdok0_ser_a_n_pins_1{3} = 'M34';

  r2_zdok0_ser_b_p_pins_1{2} = 'M36';
  r2_zdok0_ser_b_n_pins_1{2} = 'M37';

  r2_zdok0_ser_b_p_pins_1{3} = 'M33';
  r2_zdok0_ser_b_n_pins_1{3} = 'M32';

  r2_zdok0_ser_b_p_pins_1{6} = 'K37';
  r2_zdok0_ser_b_n_pins_1{6} = 'L37';

  r2_zdok1_ser_a_p_pins_1{15} = 'N36';
  r2_zdok1_ser_a_n_pins_1{15} = 'P37';

  r2_zdok1_ser_b_p_pins_1{15} = 'M31';
  r2_zdok1_ser_b_n_pins_1{15} = 'N31';

  % ZDOK revision 2
  r2_zdok0_ser_b_p_pins_2{1} = 'K37';
  r2_zdok0_ser_b_n_pins_2{1} = 'L37';

  r2_zdok1_ser_a_p_pins_2{9} = 'N36';
  r2_zdok1_ser_a_n_pins_2{9} = 'P37';

  r2_zdok1_ser_1_p_pins_2{15} = 'M31';
  r2_zdok1_ser_1_n_pins_2{15} = 'N31';
end

% TODO Select roach1 or roach2 and zdok0 or zdok1, but for now only roach2 zdok0
if zdok_rev == 1
  zdok0_clock_p_str = sprintf('''%s'',', r2_zdok0_clk_p_pins_1{:});
  zdok0_clock_n_str = sprintf('''%s'',', r2_zdok0_clk_n_pins_1{:});
  zdok0_frame_p_str = sprintf('''%s'',', r2_zdok0_frm_p_pins_1{:});
  zdok0_frame_n_str = sprintf('''%s'',', r2_zdok0_frm_n_pins_1{:});
  zdok0_ser_a_p_str = sprintf('''%s'',', r2_zdok0_ser_a_p_pins_1{:});
  zdok0_ser_a_n_str = sprintf('''%s'',', r2_zdok0_ser_a_n_pins_1{:});
  zdok0_ser_b_p_str = sprintf('''%s'',', r2_zdok0_ser_b_p_pins_1{:});
  zdok0_ser_b_n_str = sprintf('''%s'',', r2_zdok0_ser_b_n_pins_1{:});

  zdok1_clock_p_str = sprintf('''%s'',', r2_zdok1_clk_p_pins_1{:});
  zdok1_clock_n_str = sprintf('''%s'',', r2_zdok1_clk_n_pins_1{:});
  zdok1_frame_p_str = sprintf('''%s'',', r2_zdok1_frm_p_pins_1{:});
  zdok1_frame_n_str = sprintf('''%s'',', r2_zdok1_frm_n_pins_1{:});
  zdok1_ser_a_p_str = sprintf('''%s'',', r2_zdok1_ser_a_p_pins_1{:});
  zdok1_ser_a_n_str = sprintf('''%s'',', r2_zdok1_ser_a_n_pins_1{:});
  zdok1_ser_b_p_str = sprintf('''%s'',', r2_zdok1_ser_b_p_pins_1{:});
  zdok1_ser_b_n_str = sprintf('''%s'',', r2_zdok1_ser_b_n_pins_1{:});
else
  zdok0_clock_p_str = sprintf('''%s'',', r2_zdok0_clk_p_pins_2{:});
  zdok0_clock_n_str = sprintf('''%s'',', r2_zdok0_clk_n_pins_2{:});
  zdok0_frame_p_str = ',';
  zdok0_frame_n_str = ',';
  zdok0_ser_a_p_str = sprintf('''%s'',', r2_zdok0_ser_a_p_pins_2{:});
  zdok0_ser_a_n_str = sprintf('''%s'',', r2_zdok0_ser_a_n_pins_2{:});
  zdok0_ser_b_p_str = sprintf('''%s'',', r2_zdok0_ser_b_p_pins_2{:});
  zdok0_ser_b_n_str = sprintf('''%s'',', r2_zdok0_ser_b_n_pins_2{:});

  zdok1_clock_p_str = sprintf('''%s'',', r2_zdok1_clk_p_pins_2{:});
  zdok1_clock_n_str = sprintf('''%s'',', r2_zdok1_clk_n_pins_2{:});
  zdok1_frame_p_str = ',';
  zdok1_frame_n_str = ',';
  zdok1_ser_a_p_str = sprintf('''%s'',', r2_zdok1_ser_a_p_pins_2{:});
  zdok1_ser_a_n_str = sprintf('''%s'',', r2_zdok1_ser_a_n_pins_2{:});
  zdok1_ser_b_p_str = sprintf('''%s'',', r2_zdok1_ser_b_p_pins_2{:});
  zdok1_ser_b_n_str = sprintf('''%s'',', r2_zdok1_ser_b_n_pins_2{:});
end

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

ext_ports.clk_line_p = {num_clocks 'in'  'adc16_clk_line_p'  clock_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.clk_line_n = {num_clocks 'in'  'adc16_clk_line_n'  clock_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };

if zdok_rev == 1
  ext_ports.clk_frame_p = {s.num_units 'in'  'adc16_clk_frame_p' frame_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
  ext_ports.clk_frame_n = {s.num_units 'in'  'adc16_clk_frame_n' frame_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
end

ext_ports.ser_a_p    = {4*s.num_units 'in'  'adc16_ser_a_p'     ser_a_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_a_n    = {4*s.num_units 'in'  'adc16_ser_a_n'     ser_a_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_p    = {4*s.num_units 'in'  'adc16_ser_b_p'     ser_b_p_str  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_n    = {4*s.num_units 'in'  'adc16_ser_b_n'     ser_b_n_str  'vector=true'  mhs_constraints ucf_constraints_lvds };

b = set(b,'ext_ports',ext_ports);
