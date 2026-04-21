loadXcosLibs;

mlib_dir = getenv("MLIB_DEVEL_PATH")
if part(mlib_dir, length(mlib_dir)) <> "/" then
    mlib_dir = mlib_dir + "/";
end

// load the scilab functions
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/debug_info.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/collect_block_info.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_tag.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_type.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_name.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_port_width.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_config.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/gen_all_blocks_config.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/gen_block_config.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_link_info_by_link_obj.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/search_for_real_src_blk.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_port_name.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_port_width_id.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/update_block_config.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_vals.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/get_block_vindex.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/jasper.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/jasper_frontend.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/jasper_simulation.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/run_simulation.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/utils/check_block_names.sci');

// TODO: load the xps and dsp blocks automatically
// all of the blocks in the scilab_library/casper_xps and 
// scilab_library/casper_dsp directories should be loaded autocaically

// add casper xps blocks
debug_info('------Loading CASPER XPS...------');
// load the xps blocks
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/rfsoc4x2.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/de10nano.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/gpio.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/swreg.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/rfdc.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/sbram.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/sbram_intel.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_xps/ltc2308.sci');
// create the blocks
rfsoc4x2_inst = rfsoc4x2("define");
de10nano_inst = de10nano("define");
gpio_inst = gpio("define");
swreg_out_inst = swreg("define");
rfdc_inst = rfdc("define");
sbram_inst = sbram("define");
sbram_intel_inst = sbram_intel("define");
ltc2308_inst = ltc2308("define");
// add the blocks to the palette
cur_dir = pwd();
xps_fig_dir = mlib_dir + '/scilab_library/scilab_blocks/casper_xps/figures/';
pal = xcosPal("CASPER XPS");
pal = xcosPalAddBlock(pal, rfsoc4x2_inst, xps_fig_dir + 'rfsoc4x2.png', xps_fig_dir + 'rfsoc4x2.png');
pal = xcosPalAddBlock(pal, de10nano_inst, xps_fig_dir + 'de10nano.png', xps_fig_dir + 'de10nano.png');

pal = xcosPalAddBlock(pal, gpio_inst);
pal = xcosPalAddBlock(pal, swreg_out_inst);
pal = xcosPalAddBlock(pal, rfdc_inst);
pal = xcosPalAddBlock(pal, sbram_inst);
pal = xcosPalAddBlock(pal, sbram_intel_inst, xps_fig_dir + 'simple_bram_intel.png', xps_fig_dir + 'simple_bram_intel.png');
pal = xcosPalAddBlock(pal, ltc2308_inst, cur_dir + '/scilab_library/scilab_blocks/casper_pd/figures/ltc2308.png', cur_dir + '/scilab_library/scilab_blocks/casper_pd/figures/ltc2308.png');
//pal = xcosPalAddBlock(pal, swreg_out_inst);
xcosPalAdd(pal);
debug_info('------ CASPER XPS loaded --------');

// add casper dsp blocks
debug_info('------Loading CASPER DSP...------');
// load the xps blocks
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/adder.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/edge_detect_new.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/counter.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/pulse_ext.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/slice.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/munge.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/wbfft.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/bus_expand.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/dsp_constant.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/delay.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/simple_bram_vacc.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/power_cal.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/operation.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_dsp/logic_not.sci');

// create the blocks
adder_inst = adder("define");
edge_detect_new_inst = edge_detect_new("define");
counter_inst = counter("define");
pulse_ext_inst = pulse_ext("define");
slice_inst = slice("define");
munge_inst = munge("define");
wbfft_inst = wbfft("define");
bus_expand_inst = bus_expand("define");
dsp_constant_inst = dsp_constant("define");
delay_inst = delay("define");
simple_bram_vacc_inst = simple_bram_vacc("define");
power_cal_inst = power_cal("define");
operation_inst = operation("define");
logic_not_inst = logic_not("define");
cur_dir = pwd();
dsp_fig_dir = cur_dir + '/scilab_library/scilab_blocks/casper_dsp/figures/';
pal = xcosPal("CASPER DSP");
pal = xcosPalAddBlock(pal, adder_inst);
pal = xcosPalAddBlock(pal, pulse_ext_inst);
pal = xcosPalAddBlock(pal, edge_detect_new_inst);
pal = xcosPalAddBlock(pal, counter_inst);
pal = xcosPalAddBlock(pal, slice_inst);
pal = xcosPalAddBlock(pal, munge_inst);
pal = xcosPalAddBlock(pal, wbfft_inst);
pal = xcosPalAddBlock(pal, bus_expand_inst);
pal = xcosPalAddBlock(pal, dsp_constant_inst);
pal = xcosPalAddBlock(pal, delay_inst);
pal = xcosPalAddBlock(pal, simple_bram_vacc_inst);
pal = xcosPalAddBlock(pal, power_cal_inst);
pal = xcosPalAddBlock(pal, operation_inst);
pal = xcosPalAddBlock(pal, logic_not_inst);

xcosPalAdd(pal);
debug_info('------ CASPER DSP loaded --------');



// add casper sim blocks
debug_info('------Loading CASPER SIM...------');
// load the xps blocks
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_sim/sim_constant.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_sim/scope.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_sim/sim.sci');
exec(mlib_dir + 'scilab_library/scilab_blocks/casper_sim/sine.sci');
// create the blocks
sim_constant_inst = sim_constant("define");
scope_inst = scope("define");
sim_inst = sim("define");  
sine_inst = sine("define");
cur_dir = pwd();
sim_fig_dir = cur_dir + '/scilab_library/scilab_blocks/casper_sim/figures/';
pal = xcosPal("CASPER SIM");
pal = xcosPalAddBlock(pal, sim_constant_inst, sim_fig_dir + 'constant.png', sim_fig_dir + 'constant.png');
pal = xcosPalAddBlock(pal, scope_inst, sim_fig_dir + 'scope.png', sim_fig_dir + 'scope.png');
pal = xcosPalAddBlock(pal, sine_inst, sim_fig_dir + 'sine.png', sim_fig_dir + 'sine.png');
pal = xcosPalAddBlock(pal, sim_inst, sim_fig_dir + 'sim.png', sim_fig_dir + 'sim.png');

xcosPalAdd(pal);
debug_info('------ CASPER SIM loaded --------');
