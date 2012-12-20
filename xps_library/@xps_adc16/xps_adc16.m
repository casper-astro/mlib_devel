
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
s.hw_adc = lower(get_param(blk_name,'adc_brd'));
s.num_inputs = 16;     % TODO Get from mask
s.sample_mhz = 200; % TODO Get from mask

% Validate hw_sys and hw_adc
switch s.hw_sys
    case {'ROACH2','ROACH'}
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end
    
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end 

% Validate num_inputs and sample_mhz
s.line_mhz = 2 * s.sample_mhz; % default is value for 16 input mode
switch s.num_inputs
    case 16
        if s.sample_mhz> 250
            error('Max sample rate with 16 inputs is 250 MHz');
        end
    % TODO Support additional operating modes
    %case 8
    %    % OK
    %case 4
    %    % OK
    otherwise
        error(['Unsupported number of inputs: ',s.num_inputs]);
end

b = class(s,'xps_adc16',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc16_interface');
switch s.hw_sys
  case {'ROACH', 'ROACH2'},
    b = set(b, 'ip_version', '1.00.a');
end

b = set(b, 'opb0_devices',1); %controller

% Tells which other PCORES are needed for this block
supp_ip_names    = {'', 'opb_adc16_controller'};
supp_ip_versions = {'','1.00.a'};
b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% ports

%b = set(b,'ports', ports);

% misc ports

misc_ports.fabric_clk = {1 'out'  'adc0_clk'};

misc_ports.reset            = {1 'in'  [s.adc_str,'_reset']};
misc_ports.iserdes_bitslip  = {4 'in'  [s.adc_str,'_iserdes_bitslip']};

misc_ports.delay_rst        = {16 'in'  [s.adc_str,'_delay_rst']};
misc_ports.delay_tap   = {5 'in'  [s.adc_str,'_delay_tap']};

misc_ports.snap_req  = {1 'in'  [s.adc_str,'_snap_req']};
misc_ports.snap_we   = {1 'out' [inst_name,'_snap_we']};
misc_ports.snap_addr = {10 'out' [inst_name,'_snap_addr']};

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

ext_ports.clk_line_p = {4 'in'  [s.adc_str,'_clk_line_p']  '{''R28'',''H39'',''J42'',''P30''}'  'vector=true'  mhs_constraints ucf_constraints_clk };
ext_ports.clk_line_n = {4 'in'  [s.adc_str,'_clk_line_n']  '{''R29'',''H38'',''K42'',''P31''}'  'vector=true'  mhs_constraints ucf_constraints_clk };
ext_ports.ser_a_p    = {16 'in'  [s.adc_str,'_ser_a_p']  '{''J37'',''L35'',''L34'',''L31'',''J35'',''K38'',''K39'',''N29'',''F40'',''E42'',''H36'',''D40'',''B38'',''D38'',''F35'',''B39''}'  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_a_n    = {16 'in'  [s.adc_str,'_ser_a_n']  '{''J36'',''L36'',''M34'',''L32'',''H35'',''J38'',''K40'',''N30'',''F41'',''F42'',''G36'',''E40'',''A39'',''C38'',''F36'',''C39''}'  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_p    = {16 'in'  [s.adc_str,'_ser_b_p']  '{''K33'',''M36'',''M33'',''N28'',''H40'',''K37'',''K35'',''J40'',''C40'',''F37'',''G41'',''G37'',''B41'',''A40'',''E39'',''D42''}'  'vector=true'  mhs_constraints ucf_constraints_lvds };
ext_ports.ser_b_n    = {16 'in'  [s.adc_str,'_ser_b_n']  '{''K32'',''M37'',''M32'',''P28'',''H41'',''L37'',''K34'',''J41'',''C41'',''E37'',''G42'',''G38'',''B42'',''A41'',''E38'',''D41''}'  'vector=true'  mhs_constraints ucf_constraints_lvds };

b = set(b,'ext_ports',ext_ports);
