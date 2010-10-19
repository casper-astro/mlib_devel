function str = gen_ucf(blk_obj)
    % Not sure what dac_str is for.
%dac_str = blk_obj.dac_str;

str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));

%str = [str, 'NET  "',simulink_name,'/',simulink_name,'/dsp_clk_0"    PERIOD = ',num2str(1000/blk_obj.dac_clk_rate*4),'ns;\n'];

    % The dac_clk_rate must be converted from MHz to GHz, then inverted for
    % the period.  Also, the external clock given to the DAC is converted
    % to half the rate when it passes to the zdok.  Therefore, the
    % dac_clk_rate is half the external clock provided by the user.
%str = [str, 'NET  "',simulink_name,'/',simulink_name,'/dac0_clk"    PERIOD = ',num2str(2*1000/blk_obj.dac_clk_rate),'ns;\n'];
