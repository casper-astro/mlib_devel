function b = xps_adc5g(blk_obj)
% Block object description for the ASIA 5GSps ADC

fprintf('Creating block object: xps_adc5g\n')

% Make sure this is an XPS object
if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

% Then check that it's the right type
if ~strcmp(get(blk_obj,'type'),'xps_adc5g')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

% Get the mask parameters we need to know
demux = get_param(blk_name, 'demux');
adc_brd = get_param(blk_name, 'adc_brd');
test_ramp = get_param(blk_name, 'test_ramp');
input_mode = get_param(blk_name, 'input_mode');

% Retrieve block configuration parameters and set derivatives
s.demux = demux;
s.input_mode = input_mode;
if strcmp(input_mode, 'One-channel -- A') && strcmp(demux, '1:1')
    mode = 0;
    s.mode = 'MODE_ACHAN_DMUX1';
elseif strcmp(input_mode, 'One-channel -- A') && strcmp(demux, '1:2')
    mode = 0;
    s.mode = 'MODE_ACHAN_DMUX2';
elseif strcmp(input_mode, 'One-channel -- C') && strcmp(demux, '1:1')
    mode = 0;
    s.mode = 'MODE_CCHAN_DMUX1';
elseif strcmp(input_mode, 'One-channel -- C') && strcmp(demux, '1:2')
    mode = 0;
    s.mode = 'MODE_CCHAN_DMUX2';
elseif strcmp(input_mode, 'Two-channel -- A&C') && strcmp(demux, '1:1')
    mode = 1;
    s.mode = 'MODE_2CHAN_DMUX1';
elseif strcmp(input_mode, 'Two-channel -- A&C') && strcmp(demux, '1:2')
    mode = 1;
    s.mode = 'MODE_2CHAN_DMUX2';
end
s.test_ramp = test_ramp;
if strcmp(test_ramp, 'on')
    s.mode = 'MODE_TEST_RAMP';
end

s.hw_sys = get(xsg_obj,'hw_sys');
s.using_ctrl = strcmp( get_param(blk_name, 'using_ctrl'), 'on' );
actual_adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
if strcmp(demux, '1:1')
    s.adc_clk_rate = actual_adc_clk_rate/4;
    s.sysclk_rate = s.adc_clk_rate/2;
elseif strcmp(demux, '1:2')
    s.adc_clk_rate = actual_adc_clk_rate/8;
    s.sysclk_rate = s.adc_clk_rate;
else
    error(['Demux of ', demux, ' not supported!']);
end
if strcmp(adc_brd, 'ZDOK 0')
    s.use_adc0 = 1;
    s.use_adc1 = 0;
elseif strcmp(adc_brd, 'ZDOK 1')
    s.use_adc0 = 0;
    s.use_adc1 = 1;
else
    error(['ADC port ', adc_brd, ' is unsupported!']);
end
if s.use_adc0
    s.hw_adc = 'adc0';
    s.adc_str = 'adc0';
end;
if s.use_adc1 
    s.hw_adc = 'adc1';
    s.adc_str = 'adc1';
end;

% Set the PLL parameters optimally
switch s.hw_sys
    % These values are described in the Virtex-5
    % FPGA User Guide, in the section discussing how
    % to determine the M and D values for the PLL
    % All swictching values are for V5 -1 speed grade
    case 'ROACH'        
        f_pfdmax = 449; % MHz
        f_pfdmin = 19; % MHz
        f_vcomax = 1000; % MHz
        f_vcomin = 400; % MHz
        m_allowed = 1:64;
        d_allowed = 1:52;
        o0_allowed = 1:128;
        o1_allowed = 1:128;
        r_allowed = 1:1;
        o0_prec = 1;
    case 'ROACH2'
        f_pfdmax = 450; % MHz, for bandwidth set to HIGH
        f_pfdmin = 135; % MHz, for bandwidth set to HIGH
        f_vcomax = 1200; % MHz
        f_vcomin = 600; % MHz
        m_allowed = 5:64;
        d_allowed = 1:80;
        o0_allowed = 2:128;
        o1_allowed = 1:128;
        r_allowed = 1:8;
        o0_prec = 0.125;
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end

% Determine optimal M and D values
optimum_found = 0;
for r=r_allowed
  pll_freq = s.adc_clk_rate/r;

  % Determine the possible ranges for M and D
  d_min = ceil(pll_freq/f_pfdmax);
  d_max = floor(pll_freq/f_pfdmin);
  m_min = max(m_allowed(1), d_min*ceil(f_vcomin/pll_freq));
  m_max = floor((d_max*f_vcomax)/pll_freq);

  for d=d_min:d_max
    pfd_freq = pll_freq/d;
    for m=m_min:m_max
        vco_freq = pfd_freq*m;
        o0 = vco_freq/s.adc_clk_rate;
        o1 = vco_freq/s.sysclk_rate;
        %disp(sprintf('%d %d %d %f %f %f %f', r, d, m, pfd_freq, vco_freq, o0, o1));
	if (mod(o0, o0_prec)==0) && (mod(o1, 1)==0) 
	  if (m<m_allowed(1)) || (m>m_allowed(end))
	    %disp('m outside range');
	    continue
	  elseif (d<d_allowed(1)) || (d>d_allowed(end))
	    %disp('d outside range');
	    continue
	  elseif (o0<o0_allowed(1)) || (o0>o0_allowed(end))
	    %disp('o0 outside range');
	    continue
	  elseif (o1<o1_allowed(1)) || (o1>o1_allowed(end))
	    %disp('o1 outside range');
	    continue
	  elseif (pfd_freq<f_pfdmin) || (pfd_freq>f_pfdmax)
	    %disp('pfd freq outside range');
	    continue
	  elseif (vco_freq<f_vcomin) || (vco_freq>f_vcomax)
	    %disp('vco freq outside range');
	    continue
	  elseif (strcmp(s.hw_sys, 'ROACH2') && s.adc_clk_rate>315.0 && (d==3 || d==4))
	    % Special case here for ROACH2
	    %disp('adc_clk>315 and d is either 3 or 4');
	    continue
	  else
	    % Finally, we've found it!
	    pll_m = m;
	    pll_d = d;
	    pll_o0 = o0;
	    pll_o1 = o1;
	    bufr_div = r;
	    vco_final = vco_freq;
	    pfd_final = pfd_freq;
	    pll_final = pll_freq;
	    optimum_found = 1;
	    break
	  end
        end
    end
    if optimum_found
      break
    end
  end
end

% Couldn't find ideal solution so GTFO
if ~optimum_found
    error(['An optimum PLL solution is not available!']);
end

% Fix a special case for Virtex-6: if the MMCM input clock is >= 315 MHz
% and the DIVCLK_DIVIDE value is 3 or 4, then we need to multipliy both 
% DIVCLK_DIVIDE and CLKFBOUT_MULT by two. 
% See: http://www.xilinx.com/support/answers/38133.htm
% switch s.hw_sys
%     case 'ROACH2'
%         if s.adc_clk_rate>315.0 && (pll_d==3 || pll_d==4)
%             pll_d = pll_d * 2;
%             pll_m = pll_m * 2;
%         end
% end

% Print some useful debuging information
disp(['ADC5G: requested sys_clk rate of ', num2str(s.sysclk_rate, '%.4f')]);
disp(['ADC5G:   with an adc_clk rate of ', num2str(s.adc_clk_rate, '%.4f')]);
disp(['ADC5G:     with an CLKIN rate of ', num2str(pll_final, '%.4f')]);
disp(['ADC5G: ', s.adc_str, ': Chosen M = ', num2str(pll_m, '%d')]);
disp(['ADC5G: ', s.adc_str, ': Chosen D = ', num2str(pll_d, '%d')]);
disp(['ADC5G: ', s.adc_str, ': Chosen D0 = ', num2str(pll_o0, '%d')]);
disp(['ADC5G: ', s.adc_str, ': Chosen D1 = ', num2str(pll_o1, '%d')]);
disp(['ADC5G: ', s.adc_str, ': VCO Freq. = ', num2str(vco_final, '%.4f')]);
disp(['ADC5G: ', s.adc_str, ': PFD Freq. = ', num2str(pfd_final, '%.4f')]);

% Set UCF constraints depending on which CASPER board we're on
switch s.hw_sys
    case 'ROACH'
        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25',...
            'PERIOD', [num2str(1000/s.adc_clk_rate, '%.4f'),' ns'],...
            'DIFF_TERM', 'TRUE');
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25',...
            'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
        ucf_constraints_single = struct('IOSTANDARD', 'LVCMOS25');
    % end case 'ROACH'
    case 'ROACH2'
        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25',...
            'PERIOD', [num2str(1000/s.adc_clk_rate),' ns'],...
            'DIFF_TERM', 'TRUE');
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25',...
            'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
        ucf_constraints_single = struct('IOSTANDARD', 'LVCMOS25');
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

% Get the class of the object
b = class(s,'xps_adc5g', blk_obj);

% Set the appropriate PCORE to use
if strcmp(demux, '1:1')
    b = set(b, 'ip_name', 'adc5g_dmux1_interface');
elseif strcmp(demux, '1:2')
    b = set(b, 'ip_name', 'adc5g_dmux2_interface');
else
    error(['Unsupported demux ', demux]);
end

% Set the version of the PCORE
switch s.hw_sys
    case 'ROACH'
        b = set(b, 'ip_version', '1.00.a');
    case 'ROACH2'
        b = set(b, 'ip_version', '1.00.a');
end % switch s.hw_sys

b = set(b, 'opb0_devices', 1); %controller

% Tells which other PCORES are needed for this block
supp_ip_names    = {'', 'opb_adc5g_controller'};
supp_ip_versions = {'','1.00.a'};
b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% Add ports not explicitly provided in the yellow block
misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_dcm_reset']};
misc_ports.ctrl_clk_in     = {1 'in'  get(xsg_obj,'clk_src')};
misc_ports.ctrl_clk_out    = {1 'out' [s.adc_str,'_clk']};
misc_ports.ctrl_clk90_out  = {1 'out' [s.adc_str,'_clk90']};
misc_ports.ctrl_clk180_out = {1 'out' [s.adc_str,'_clk180']};
misc_ports.ctrl_clk270_out = {1 'out' [s.adc_str,'_clk270']};
misc_ports.ctrl_dcm_locked = {1 'out' [s.adc_str,'_dcm_locked']};
misc_ports.dcm_reset       = {1 'in'  [s.adc_str,'_dcm_reset']};
misc_ports.dcm_psdone      = {1 'out' [s.adc_str,'_psdone']};
misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
misc_ports.fifo_full_cnt   = {16 'out' [s.adc_str,'_fifo_full_cnt']};
misc_ports.fifo_empty_cnt  = {16 'out' [s.adc_str,'_fifo_empty_cnt']};
misc_ports.tap_rst         = {1 'in' [s.adc_str,'_tap_rst']};
misc_ports.datain_pin      = {5 'in' [s.adc_str,'_datain_pin']};
misc_ports.datain_tap      = {5 'in' [s.adc_str,'_datain_tap']};
b = set(b,'misc_ports',misc_ports);

% Set the MHS clock frequency
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ', num2str(s.adc_clk_rate*1e6));

adcport = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];
% Set external ports
ext_ports.adc_clk_p_i = {1 'in'  [s.adc_str,'clk_p']       ['{',adcport,'_p{[39]+1,:}}']              'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_clk_n_i = {1 'in'  [s.adc_str,'clk_n']       ['{',adcport,'_n{[39]+1,:}}']              'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_sync_p      = {1 'in'  [s.adc_str,'sync_p']      ['{',adcport,'_p{[38]+1,:}}']                 'vector=false'  struct() ucf_constraints_term };
ext_ports.adc_sync_n      = {1 'in'  [s.adc_str,'sync_n']      ['{',adcport,'_n{[38]+1,:}}']                 'vector=false'  struct() ucf_constraints_term };
ext_ports.adc_data0_p_i = {8 'in'  [s.adc_str,'data0_p_i']  ['{',adcport,'_p{[0 1 2 3 4 5 6 7]+1,:}}']         'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data0_n_i = {8 'in'  [s.adc_str,'data0_n_i']  ['{',adcport,'_n{[0 1 2 3 4 5 6 7]+1,:}}']         'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data1_p_i = {8 'in'  [s.adc_str,'data1_p_i']  ['{',adcport,'_p{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data1_n_i = {8 'in'  [s.adc_str,'data1_n_i']  ['{',adcport,'_n{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data2_p_i = {8 'in'  [s.adc_str,'data2_p_i']  ['{',adcport,'_p{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data2_n_i = {8 'in'  [s.adc_str,'data2_n_i']  ['{',adcport,'_n{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data3_p_i = {8 'in'  [s.adc_str,'data3_p_i']  ['{',adcport,'_p{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
ext_ports.adc_data3_n_i = {8 'in'  [s.adc_str,'data3_n_i']  ['{',adcport,'_n{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true'   struct() ucf_constraints_term };
b = set(b,'ext_ports',ext_ports);

% Finally set parameters and gtfo
parameters.CLKIN_PERIOD = num2str(1000/s.adc_clk_rate, '%.4f');
switch s.hw_sys
    case 'ROACH'
        parameters.PLL_M = num2str(pll_m, '%d');
        parameters.PLL_D = num2str(pll_d, '%d');
        parameters.PLL_O0 = num2str(pll_o0, '%d');
        parameters.PLL_O1 = num2str(pll_o1, '%d');
    case 'ROACH2'
        parameters.MMCM_M = num2str(pll_m, '%.4f');
        parameters.MMCM_D = num2str(pll_d, '%d');
        parameters.MMCM_O0 = num2str(pll_o0, '%.4f');
        parameters.MMCM_O1 = num2str(pll_o1, '%d');
	parameters.BUFR_DIV = num2str(bufr_div, '%d');
	parameters.BUFR_DIV_STR = num2str(bufr_div, '"%d"');
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end
parameters.USE_ADC0 = num2str(s.use_adc0);
parameters.USE_ADC1 = num2str(s.use_adc1);
parameters.MODE = num2str(mode);
b = set(b,'parameters',parameters);
