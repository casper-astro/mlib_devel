function str = gen_ucf(blk_obj)
   
str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));

%str = [str, 'NET  "',simulink_name,'/',simulink_name,'/dsp_clk_0"    PERIOD = ',num2str(1000/blk_obj.dac_clk_rate*4),'ns;\n'];
%str = [str, 'NET  "',simulink_name,'/',simulink_name,'/dac0_clk"    PERIOD = ',num2str(2*1000/blk_obj.dac_clk_rate),'ns;\n'];
