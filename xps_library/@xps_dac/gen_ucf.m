function str = gen_ucf(blk_obj)
dac_str = blk_obj.dac_str;

str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));

str = [str, 'NET  "',simulink_name,'/',simulink_name,'/dsp_clk_0"    PERIOD = ',num2str(1000/blk_obj.dac_clk_rate*4),'ns;\n'];
