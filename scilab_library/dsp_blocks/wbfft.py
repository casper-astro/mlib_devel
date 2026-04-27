import sys, os, math
from .dsp_block import DSPBlock
from verilog import VerilogModule
from glob import glob

# TODO: we may need to improve this piece of code
wbfft_libs = {}
wbfft_libs['common_pkg_lib'] = []
wbfft_libs['common_components_lib'] = []
wbfft_libs['casper_adder_lib'] = []
wbfft_libs['casper_multiplier_lib'] = []
wbfft_libs['technology_lib'] = []
wbfft_libs['casper_counter_lib'] = []
wbfft_libs['casper_fifo_lib'] = []
wbfft_libs['casper_ram_lib'] = []
wbfft_libs['casper_requantize_lib'] = []
wbfft_libs['casper_multiplexer_lib'] = []
wbfft_libs['casper_wb_fft_lib'] = []
wbfft_libs['r2sdf_fft_lib'] = []
wbfft_libs['ip_xpm_mult_lib'] = []
wbfft_libs['ip_xpm_fifo_lib'] = []
wbfft_libs['ip_xpm_ram_lib'] = []
wbfft_libs['ip_stratixiv_mult_lib'] = []
wbfft_libs['ip_stratixiv_ram_lib'] = []
wbfft_libs['ip_stratixiv_fifo_lib'] = []

class wbfft(DSPBlock):
    def initialize(self):
        # create the hdl wrapper directory
        self.create_hdl_dir()
        for k in wbfft_libs:
            wbfft_libs[k].clear()
        jasper_backend = os.environ.get("JASPER_BACKEND", "").lower()
        is_intel = (jasper_backend == "quartus")
        self.is_intel = is_intel
        self.vendor = "Altera" if is_intel else "Xilinx"
        print(f"[wbfft] JASPER_BACKEND={jasper_backend}, is_intel={is_intel}, vendor={self.vendor}")
        
        #self.add_source(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_pkg/fixed_float_types_c.vhd'))
        wbfft_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/fixed_float_types_c.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/fixed_pkg_c.vhd'))
        wbfft_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/fixed_pkg_c.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_pipeline.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_pipeline.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_adder/common_add_sub.vhd'))
        wbfft_libs['casper_adder_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_adder/common_add_sub.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_async.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_async.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_areset.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_areset.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_bit_delay.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_bit_delay.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_pipeline_sl.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_pipeline_sl.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_mult_component.vhd'))
        wbfft_libs['casper_multiplier_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_mult_component.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_agilex_versal_cmult.vhd'))
        wbfft_libs['casper_multiplier_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_agilex_versal_cmult.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/technology/technology_select_pkg.vhd'))
        self._generate_technology_select_pkg(self.family_to_tech_select(self.vendor))
        wbfft_libs['technology_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/technology/technology_select_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_complex_mult.vhd'))
        wbfft_libs['casper_multiplier_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/tech_complex_mult.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/common_complex_mult.vhd'))
        wbfft_libs['casper_multiplier_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplier/common_complex_mult.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_counter/common_counter.vhd'))
        wbfft_libs['casper_counter_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_counter/common_counter.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_delay.vhd'))
        wbfft_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_delay.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_rl_decrease.vhd'))
        wbfft_libs['casper_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_rl_decrease.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_fifo_rd.vhd'))
        wbfft_libs['casper_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_fifo_rd.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/tech_fifo_component_pkg.vhd'))
        wbfft_libs['casper_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/tech_fifo_component_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/tech_fifo_sc.vhd'))
        wbfft_libs['casper_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/tech_fifo_sc.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_fifo_sc.vhd'))
        wbfft_libs['casper_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_fifo/common_fifo_sc.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_pkg.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_crw_crw.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_crw_crw.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_crw_crw.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_crw_crw.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_rw_rw.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_rw_rw.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_r_w.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_paged_ram_r_w.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_round.vhd'))
        wbfft_libs['casper_requantize_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_round.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_resize.vhd'))
        wbfft_libs['casper_requantize_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_resize.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_requantize.vhd'))
        wbfft_libs['casper_requantize_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/common_requantize.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_rom_r_r.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_rom_r_r.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_rom_r.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_rom_r.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_rom_r_r.vhd'))
        wbfft_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_rom_r_r.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/common_str_pkg.vhd'))
        wbfft_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/common_str_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplexer/common_zip.vhd'))
        wbfft_libs['casper_multiplexer_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_multiplexer/common_zip.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_dp_pkg/dp_stream_pkg.vhd'))
        #wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_dp_pkg/dp_stream_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_gnrcs_intrfcs_pkg.vhd'))
        #wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_gnrcs_intrfcs_pkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/twiddlesPkg.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/twiddlesPkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoSDFPkg.vhd')
        #wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoSDFPkg.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoBF.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoBF.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/r_shift_requantize.vhd'))
        wbfft_libs['casper_requantize_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_requantize/r_shift_requantize.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoWMul.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoWMul.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_bf_par.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_bf_par.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_par.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_par.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoBFStage.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoBFStage.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoWeights.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoWeights.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoSDFStage.vhd'))
        wbfft_libs['r2sdf_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/r2sdf_fft/rTwoSDFStage.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_sepa.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_sepa.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_reorder_sepa_pipe.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_reorder_sepa_pipe.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_pipe.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_pipe.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_sepa_wide.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_sepa_wide.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_wide.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_r2_wide.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_wide_unit_control.vhd'))
        #wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_wide_unit_control.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_wide_unit.vhd'))
        wbfft_libs['casper_wb_fft_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_wb_fft/fft_wide_unit.vhd'))
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/common_pkg.vhd'))
        wbfft_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/common_pkg.vhd'))

        # ----------------------------
            # Vendor-specific sources
        # ----------------------------

        
        if is_intel:
            
            #mult
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_complex_mult_rtl.vhd'))
            wbfft_libs['ip_stratixiv_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_complex_mult_rtl.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_complex_mult.vhd'))
            wbfft_libs['ip_stratixiv_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_complex_mult.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_mult_add2_rtl.vhd'))
            wbfft_libs['ip_stratixiv_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_mult_add2_rtl.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_mult_add4_rtl.vhd'))
            wbfft_libs['ip_stratixiv_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/mult/ip_stratixiv_mult_add4_rtl.vhd'))

            # RAM

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_cr_cw.vhd'))
            wbfft_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_cr_cw.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crw_crw.vhd'))
            wbfft_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crw_crw.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crwk_crw.vhd'))
            wbfft_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crwk_crw.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_r_w.vhd'))
            wbfft_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_r_w.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_rom_r.vhd'))
            wbfft_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_rom_r.vhd'))

            

            # FIFO
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_dc_mixed_widths.vhd'))
            wbfft_libs['ip_stratixiv_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_dc_mixed_widths.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_dc.vhd'))
            wbfft_libs['ip_stratixiv_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_dc.vhd'))

            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_sc.vhd'))
            wbfft_libs['ip_stratixiv_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/fifo/ip_stratixiv_fifo_sc.vhd'))

        else:
            # add the source files
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_3dsp.vhd'))
            wbfft_libs['ip_xpm_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_3dsp.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_4dsp.vhd'))
            wbfft_libs['ip_xpm_mult_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_4dsp.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/fifo/ip_xilinx_fifo_sc.vhd'))
            wbfft_libs['ip_xpm_fifo_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/fifo/ip_xilinx_fifo_sc.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd'))
            wbfft_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd'))
            wbfft_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r.vhd'))
            wbfft_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r.vhd'))
            #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r_r.vhd'))
            wbfft_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r_r.vhd'))

        # generate twiddle coefficients
        # delete the twids dir, if it exists
        if os.path.exists(self.hdl_wrapper_dir + "/twids"):
            os.system(f"rm -rf {self.hdl_wrapper_dir}/twids")
        # the twids dir will be created automatically
        self._generate_twids(self.hdl_root_scilab + "/casper_dspdevel/wrappers/simulink/sdf_fft_twid_create.py")
        # generate hdl wrapper, and add it to the project
        self._generate_vhdl_wrapper()
        #wbfft_libs['casper_wb_fft_lib'].append(f'{self.hdl_wrapper_dir}/casper_wideband_fft.vhd')
        if  is_intel:
            wbfft_libs['casper_wb_fft_lib'].append(f'{self.hdl_wrapper_dir}/casper_wideband_fft.vhd')
        else:
            self.add_source(self.hdl_wrapper_dir + "/casper_wideband_fft.vhd")
        # generate fft_gnrcs_intrfcs_pkg, and add it to the project
        self._generate_fft_gnrcs_intrfcs_pkg()
        
        if is_intel:
            wbfft_libs['casper_wb_fft_lib'].append(f'{self.hdl_wrapper_dir}/fft_gnrcs_intrfcs_pkg.vhd')        
        else: 
            self.add_source(self.hdl_wrapper_dir + "/fft_gnrcs_intrfcs_pkg.vhd")
        # generate rTwoSDFPkg
        self._generate_rTwoSDFPkg()

        if is_intel:
            wbfft_libs['r2sdf_fft_lib'].append(f'{self.hdl_wrapper_dir}/rTwoSDFPkg.vhd')
        else:
            #wbfft_libs['r2sdf_fft_lib'].append(f'{self.hdl_wrapper_dir}/rTwoSDFPkg.vhd')
            self.add_source(f'{self.hdl_wrapper_dir}/rTwoSDFPkg.vhd')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'wideband_fft_top'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("use_reorder", self.use_reorder)
        inst.add_parameter("use_fft_shift", self.use_fft_shift)
        inst.add_parameter("use_separate", self.use_separate)
        inst.add_parameter("alt_output", self.alt_output)
        inst.add_parameter("wb_factor", self.wb_factor)
        inst.add_parameter("nof_points", self.nof_points)
        inst.add_parameter("in_dat_w", self.in_dat_w)
        inst.add_parameter("out_dat_w", self.out_dat_w)
        inst.add_parameter("out_gain_w", self.out_gain_w)
        inst.add_parameter("stage_dat_w", self.stage_dat_w)
        inst.add_parameter("twiddle_dat_w", self.twiddle_dat_w)
        inst.add_parameter("max_addr_w", self.max_addr_w)
        inst.add_parameter("guard_w", self.guard_w)
        inst.add_parameter("guard_enable", self.guard_enable)
        inst.add_parameter("pipe_reo_in_place", self.pipe_reo_in_place)
        # string type
        inst.add_parameter("use_variant", "\"%s\""%self.use_variant)
        # string type
        inst.add_parameter("use_dsp", "\"%s\""%self.use_dsp)
        # string type
        inst.add_parameter("ovflw_behav", "\"%s\""%self.ovflw_behav)
        inst.add_parameter("use_round", self.use_round)
        # string type
        inst.add_parameter("ram_primitive", "\"%s\""%self.ram_primitive)
        # add ports
        # input ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('ce', '1', dir='in')
        inst.add_port('in_sync', self.fullname+'_in_sync', width=1, dir='in')
        inst.add_port('in_valid', self.fullname+'_in_valid', width=1, dir='in')
        inst.add_port('in_shiftreg', self.fullname+'_in_shiftreg', width=int(math.log2(self.nof_points)), dir='in')
        for i in range(self.wb_factor):
            # smart github copilot knows what I want to do
            inst.add_port(f'in_im_{i}', f'{self.fullname}_in_im{i}', width=self.in_dat_w, dir='in')
            inst.add_port(f'in_re_{i}', f'{self.fullname}_in_re{i}', width=self.in_dat_w, dir='in')
        # output ports
        inst.add_port('out_ovflw', self.fullname+'_out_ovflw', width=int(math.log2(self.nof_points)), dir='out')
        inst.add_port('out_sync', self.fullname+'_out_sync', width=1, dir='out')
        inst.add_port('out_valid', self.fullname+'_out_valid', width=1, dir='out')
        for i in range(self.wb_factor):
            inst.add_port(f'out_im_{i}', f'{self.fullname}_out_im{i}', width=self.out_dat_w, dir='out')
            inst.add_port(f'out_re_{i}', f'{self.fullname}_out_re{i}', width=self.out_dat_w, dir='out')

    def gen_tcl_cmds(self):
        tcl_cmds = []

        for k in wbfft_libs.keys():
            for f in wbfft_libs[k]:
                # VHDL lib is a little annoying here...
                f_parts = f.split('/')
                if self.is_intel:
                    if os.path.isabs(f):
                        full_path = f
                    else:
                        full_path = os.path.abspath(os.path.join(self.hdl_root_scilab, f))

                    print(f"[wbfft quartus] lib={k} file={full_path}")
                    # Quartus: add the file and assign its VHDL library
                    #full_path = f"{self.builddir}/dspproj/dspproj.srcs/sources_1/imports/{f_parts[-2]}/{f_parts[-1]}"
                    tcl_cmds.append(f'set_global_assignment -name VHDL_FILE "{full_path}" -library {k}\n')
                else:
                    # Vivado
                    tcl_cmds.append('update_compile_order -fileset sources_1\n')
                    tcl_cmds.append('set_property LIBRARY %s [get_files %s/dspproj/dspproj.srcs/sources_1/imports/%s/%s]\n' % (k, self.builddir, f_parts[-2], f_parts[-1]))

        '''
        if self.is_intel:
            wrapper_path = os.path.abspath(
                os.path.join(self.builddir, "hdl_wrapper", "wbfft", "casper_wideband_fft.vhd")
            )
            print(f"[wbfft quartus] adding wrapper: {wrapper_path}")

            tcl_cmds.append(f'set_global_assignment -name VHDL_FILE "{wrapper_path}"\n')
        '''
        return {'pre_synth': tcl_cmds}

    def family_to_tech_select(self, family: str) -> str:
        f = family.lower()
        if "versal" in f:
            return "c_tech_versal"
        if any(x in f for x in ["cyclone", "stratix", "arria", "agilex", "max 10", "altera"]):
            return "c_tech_stratixiv"
        return "c_tech_xpm"

    def _generate_technology_select_pkg(self, tech_select: str):
        """
        Generate the technology_select_pkg VHDL file as a string.

        Parameters
        ----------
        tech_select : str
            One of:
                "c_tech_stratixiv"
                "c_tech_xpm"
                "c_tech_agilex"
                "c_tech_versal"
        """

        valid = {
            "c_tech_stratixiv",
            "c_tech_xpm",
            "c_tech_agilex",
            "c_tech_versal",
        }

        if tech_select not in valid:
            raise ValueError(f"Invalid tech_select: {tech_select}")

        hdl_design =  f"""-------------------------------------------------------------------------------
--
-- Copyright (C) 2014
-- ASTRON (Netherlands Institute for Radio Astronomy) <http://www.astron.nl/>
-- P.O.Box 2, 7990 AA Dwingeloo, The Netherlands
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-------------------------------------------------------------------------------

-- Purpose: Define default technology selection value for g_technology.
-- Description:
--   In case g_technology is not overruled by the application design then the
--   g_technology defaults to c_tech_select_default.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE technology_select_pkg IS
  -- Technology identifiers
  CONSTANT c_tech_stratixiv          : INTEGER := 0;   -- e.g. used on UniBoard1
  CONSTANT c_tech_xpm                : INTEGER := 1;   -- e.g. used for Xilinx in Casper
  CONSTANT c_tech_agilex             : INTEGER := 2;   -- For use with Intel AgileX
  constant c_tech_versal             : INTEGER := 3;   -- For use with Xilinx Versal

  --CONSTANT c_tech_select_default : INTEGER := c_tech_stratixiv;
  CONSTANT c_tech_select_default : INTEGER := {tech_select};
END technology_select_pkg;
"""
        with open(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/technology/technology_select_pkg.vhd'), "w", encoding="utf-8") as file:
            file.write(hdl_design)


    def _generate_vhdl_wrapper(self):
        # I really don't want to generate the vhdl code from python.
        # TODO: we may have two wideband fft blocks in the same desgin,
        #       these two blocks may have different parameters.
        wb_factor = self.wb_factor
        hdl_wrapper_dir = self.hdl_wrapper_dir
        twids_dir = self.hdl_wrapper_dir + "/twids"
        vhdl_template = f"""
library ieee,casper_wb_fft_lib, r2sdf_fft_lib, common_pkg_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use common_pkg_lib.common_pkg.all;
use casper_wb_fft_lib.fft_gnrcs_intrfcs_pkg.all;
use r2sdf_fft_lib.rTwoSDFPkg.all;
--Purpose: A Simulink necessary wrapper for the fft_wide_unit. Serves to expose all signals and generics individually.
entity wideband_fft_top is
	generic(
        use_reorder    : natural; -- = false for bit-reversed output, true for normal output
        use_fft_shift  : natural; -- = false for [0, pos, neg] bin frequencies order, true for [neg, 0, pos] bin frequencies order in case of complex input
        use_separate   : natural; -- = false for complex input, true for two real inputs
        alt_output     : natural;
        wb_factor      : natural; -- = default 1, wideband factor
        nof_points     : natural; -- = 1024, N point FFT
        in_dat_w       : natural; -- = 8,  number of input bits
        out_dat_w      : natural; -- = 13, number of output bits
        out_gain_w     : natural; -- = 0, output gain factor applied after the last stage output, before requantization to out_dat_w
        stage_dat_w    : natural; -- = 18, data width used between the stages(= DSP multiplier-width)
        twiddle_dat_w  : natural;  -- = 18, the twiddle coefficient data width
        max_addr_w     : natural;  -- = 8, ceoff address widths above which to implement in bram/ultraram
        guard_w        : natural; -- = 2, guard used to avoid overflow in first FFT stage, compensated in last guard_w nof FFT stages. 
                                --   on average the gain per stage is 2 so guard_w = 1, but the gain can be 1+sqrt(2) [Lyons section
                                --   12.3.2], therefore use input guard_w = 2.
        guard_enable   : natural; -- = true when input needs guarding, false when input requires no guarding but scaling must be
                                --   skipped at the last stage(s) compensate for input guard (used in wb fft with pipe fft section
                                --   doing the input guard and par fft section doing the output compensation)
        pipe_reo_in_place : natural;
        use_variant    : string;  -- = "4DSP" or "3DSP" for 3 or 4 mult cmult.
        use_dsp        : string;  -- = "yes" or "no"
        ovflw_behav    : string;  -- = "WRAP" or "SATURATE" will default to WRAP if invalid option used
        use_round      : natural;  -- = 0, 1, 2 - indices corresponding to the rounding modes in the common_pkg_lib
        ram_primitive  : string  -- = "auto", "distributed", "block" or "ultra" for RAM architecture
);
port(
    clk            : in std_logic;
    ce             : in std_logic;
    in_sync        : in std_logic:='0';
    in_valid       : in std_logic:='0';
    in_shiftreg    : in std_logic_vector(ceil_log2(nof_points)-1 DOWNTO 0);
    out_ovflw      : out std_logic_vector(ceil_log2(nof_points)-1 DOWNTO 0) := (others=>'0');
    out_sync       : out std_logic:='0';
    out_valid      : out std_logic:='0';
    """
        vhdl_template += "    ".join(f"in_im_{i}        : in std_logic_vector(in_dat_w-1 downto 0);\n    in_re_{i}        : in std_logic_vector(in_dat_w-1 downto 0);\n" for i in range(wb_factor))
        vhdl_template += "    "
        vhdl_template += "    ".join(f"out_im_{i}       : out std_logic_vector(out_dat_w-1 downto 0);\n    out_re_{i}       : out std_logic_vector(out_dat_w-1 downto 0);\n" for i in range(wb_factor - 1))
        vhdl_template += f"    out_im_{wb_factor-1}       : out std_logic_vector(out_dat_w-1 downto 0);\n    out_re_{wb_factor-1}       : out std_logic_vector(out_dat_w-1 downto 0)\n"

        vhdl_template += f"""
    );
end entity wideband_fft_top;

architecture rtl of wideband_fft_top is
    constant round_mode : t_rounding_mode := t_rounding_mode'val(use_round);
    constant c_use_reorder       : boolean := (use_reorder /= 0);
    constant c_use_fft_shift     : boolean := (use_fft_shift /= 0);
    constant c_use_separate      : boolean := (use_separate /= 0);
    constant c_alt_output        : boolean := (alt_output /= 0);
    constant c_guard_enable      : boolean := (guard_enable /= 0);
    constant c_pipe_reo_in_place : boolean := (pipe_reo_in_place /= 0);

    constant cc_fft : t_fft := (
        c_use_reorder,
        c_use_fft_shift,
        c_use_separate,
        0,
        wb_factor,
        nof_points,
        in_dat_w,
        out_dat_w,
        out_gain_w,
        stage_dat_w,
        twiddle_dat_w,
        max_addr_w,
        guard_w,
        c_guard_enable,
        56,
        2,
        c_pipe_reo_in_place
    );
    signal in_fft_sosi_arr : t_fft_sosi_arr_in(wb_factor - 1 downto 0);
    signal out_fft_sosi_arr : t_fft_sosi_arr_out(wb_factor - 1 downto 0);
    constant c_pft_pipeline : t_fft_pipeline := c_fft_pipeline;
    constant c_fft_pipeline : t_fft_pipeline := c_fft_pipeline;
begin
            fft_wide_unit : entity casper_wb_fft_lib.fft_wide_unit
        generic map(
            g_fft               => cc_fft,
            g_pft_pipeline      => c_pft_pipeline,
            g_fft_pipeline      => c_fft_pipeline,
            g_alt_output        => c_alt_output,
            g_use_variant       => use_variant,
            g_use_dsp           => use_dsp,
            g_ovflw_behav       => ovflw_behav,
            g_round             => round_mode,
            g_ram_primitive     => ram_primitive,
            g_twid_file_stem    => "{twids_dir}"
        )
        port map (
            clken               => ce,
            clk                 => clk,
            shiftreg            => in_shiftreg,
            ovflw               => out_ovflw,
            in_fft_sosi_arr     => in_fft_sosi_arr,
            out_fft_sosi_arr    => out_fft_sosi_arr
        );
        otherinprtmap: for j in 0 to wb_factor-1 generate
            in_fft_sosi_arr(j).sync     <= in_sync;
            in_fft_sosi_arr(j).valid    <= in_valid;
        end generate;
        -- fft_wide_unit replicates sync/valid across all lanes, so drive the
        -- scalar wrapper ports from one representative lane only.
        out_sync    <= out_fft_sosi_arr(0).sync;
        out_valid   <= out_fft_sosi_arr(0).valid;
"""
        vhdl_template += "        "
        vhdl_template += "        ".join(f"in_fft_sosi_arr({i}).re <= RESIZE_SVEC(in_re_{i}, in_fft_sosi_arr({i}).re'length);\n" for i in range(wb_factor))   
        vhdl_template += "        "
        vhdl_template += "        ".join(f"in_fft_sosi_arr({i}).im <= RESIZE_SVEC(in_im_{i}, in_fft_sosi_arr({i}).im'length);\n" for i in range(wb_factor)) 
        vhdl_template += "        "
        vhdl_template += "        ".join(f"out_re_{i} <= RESIZE_SVEC(out_fft_sosi_arr({i}).re,out_dat_w);\n" for i in range(wb_factor)) 
        vhdl_template += "        "
        vhdl_template += "        ".join(f"out_im_{i} <= RESIZE_SVEC(out_fft_sosi_arr({i}).im,out_dat_w);\n" for i in range(wb_factor)) 
        vhdl_template += f"""
end architecture rtl;
"""
        with open(hdl_wrapper_dir + "/casper_wideband_fft.vhd", "w", encoding="utf-8") as file:
            file.write(vhdl_template)

    def _generate_twids(self, script):
        # generate twids for the wideband fft
        # we call the script directly: casper_dspdevel/wrappers/simulink/sdf_fft_twid_create.py
        # TODO: we may need to improve this piece of code
        twids_dir = self.hdl_wrapper_dir
        nof_points = self.nof_points
        wb_factor = self.wb_factor
        twid_dat_w = self.twiddle_dat_w
        vendor = '1' if self.is_intel else 0
        python_cmd = f"python3 {script} -o {twids_dir} -g 1 -p {nof_points} -w {wb_factor} -c {twid_dat_w} -v {vendor} -V 0"
        os.system(python_cmd)

    def _generate_fft_gnrcs_intrfcs_pkg(self):
        # we have to modify some constant values in this file.
        # the reason is the default values can't be changed through generics.
        vhdl_template = f"""
LIBRARY IEEE, common_pkg_lib;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE common_pkg_lib.common_pkg.ALL;

PACKAGE fft_gnrcs_intrfcs_pkg IS
	--UPDATED BY MATLAB CODE GENERATION FOR SLV ARRAYS/INTERFACES:
	CONSTANT c_fft_in_dat_w    : natural := {self.in_dat_w};
	CONSTANT c_fft_out_dat_w   : natural := {self.out_dat_w};
	CONSTANT c_fft_stage_dat_w : natural := {self.stage_dat_w};

	--UPDATED THROUGH THE MATLAB CONFIG FOR FFT OPERATION:
	CONSTANT c_fft_use_reorder   : boolean := true; -- = false for bit-reversed output, true for normal output
	CONSTANT c_fft_use_fft_shift : boolean := false; -- = false for [0, pos, neg] bin frequencies order, true for [neg, 0, pos] bin frequencies order in case of complex input
	CONSTANT c_fft_use_separate  : boolean := true; -- = false for complex input, true for two real inputs
	CONSTANT c_fft_wb_factor     : natural := 8; -- = default 1, wideband factor",wb_factor);
	CONSTANT c_fft_nof_points    : natural := 1024; -- = 1024, N point FFT",nof_points);
	CONSTANT c_fft_nof_chan      : natural := 0; -- = default 0, defines the number of channels (=time-multiplexed input signals): nof channels = 2**nof_chan 
	CONSTANT c_fft_twiddle_dat_w : natural := 18; -- = 18, coefficient data width
	CONSTANT c_max_addr_w        : natural := 8; -- = 10, address width above which to store coeffients in bram/ultra 
	CONSTANT c_fft_out_gain_w    : natural := 0; -- = 0, output gain factor applied after the last stage output, before requantization to out_dat_w
	CONSTANT c_fft_guard_w       : natural := 2; -- = 2, guard used to avoid overflow in first FFT stage, compensated in last guard_w nof FFT stages. 
	--   on average the gain per stage is 2 so guard_w = 1, but the gain can be 1+sqrt(2) [Lyons section
	--   12.3.2], therefore use input guard_w = 2.
	CONSTANT c_fft_guard_enable  : boolean := true; -- = true when input needs guarding, false when input requires no guarding but scaling must be
	--   skipped at the last stage(s) compensate for input guard (used in wb fft with pipe fft section
	--   doing the input guard and par fft section doing the output compensation)
	CONSTANT c_pipe_reo_in_place : boolean := false;

	type t_fft is record
		use_reorder       : boolean;    -- = false for bit-reversed output, true for normal output
		use_fft_shift     : boolean;    -- = false for [0, pos, neg] bin frequencies order, true for [neg, 0, pos] bin frequencies order in case of complex input
		use_separate      : boolean;    -- = false for complex input, true for two real inputs
		nof_chan          : natural;    -- = default 0, defines the number of channels (=time-multiplexed input signals): nof channels = 2**nof_chan 
		wb_factor         : natural;    -- = default 1, wideband factor
		nof_points        : natural;    -- = 1024, N point FFT
		in_dat_w          : natural;    -- = 8,  number of input bits
		out_dat_w         : natural;    -- = 13, number of output bits
		out_gain_w        : natural;    -- = 0, output gain factor applied after the last stage output, before requantization to out_dat_w
		stage_dat_w       : natural;    -- = 18, data width used between the stages(= DSP multiplier-width)
		twiddle_dat_w     : natural;    -- = 18, data width of the twiddle coefficients in the FFT
		max_addr_w        : natural;    -- = 10, address width above which to store coeffients in bram/ultra 
		guard_w           : natural;    -- = 2, guard used to avoid overflow in first FFT stage, compensated in last guard_w nof FFT stages. 
		--   on average the gain per stage is 2 so guard_w = 1, but the gain can be 1+sqrt(2) [Lyons section
		--   12.3.2], therefore use input guard_w = 2.
		guard_enable      : boolean;    -- = true when input needs guarding, false when input requires no guarding but scaling must be
		--   skipped at the last stage(s) compensate for input guard (used in wb fft with pipe fft section
		--   doing the input guard and par fft section doing the output compensation)
		stat_data_w       : positive;   -- = 56
		stat_data_sz      : positive;   -- = 2
		pipe_reo_in_place : boolean;    -- = false for pipelined FFT reorder double buffer, true for single
	end record;

	constant c_fft : t_fft := (
		use_reorder       => true,
		use_fft_shift     => false,
		use_separate      => false,
		nof_chan          => 0,
		wb_factor         => c_fft_wb_factor,
		nof_points        => c_fft_nof_points,
		in_dat_w          => c_fft_in_dat_w,
		out_dat_w         => c_fft_out_dat_w,
		out_gain_w        => 0,
		stage_dat_w       => c_dsp_mult_w,
		twiddle_dat_w     => c_fft_twiddle_dat_w,
		max_addr_w        => c_max_addr_w,
		guard_w           => 2,
		guard_enable      => true,
		stat_data_w       => 56,
		stat_data_sz      => 2,
		pipe_reo_in_place => c_pipe_reo_in_place
	);

	-- Check consistancy of the FFT parameters
	function fft_r2_parameter_asserts(g_fft : t_fft) return boolean; -- the return value is void, because always true or abort due to failure

	--type t_fft_slv_arr_in IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(c_fft_in_dat_w-1 DOWNTO 0);
	--type t_fft_slv_arr_stg IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(c_fft_stage_dat_w-1 DOWNTO 0);
	--type t_fft_slv_arr_out IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(c_fft_out_dat_w-1 DOWNTO 0);

	--t_dp_sosi record
	TYPE t_fft_sosi_in IS RECORD        -- Source Out or Sink In
		sync  : STD_LOGIC;
		re    : STD_LOGIC_VECTOR(c_fft_in_dat_w - 1 DOWNTO 0); -- data
		im    : STD_LOGIC_VECTOR(c_fft_in_dat_w - 1 DOWNTO 0); -- data
		valid : STD_LOGIC;              -- ctrl
	END RECORD;

	--CONSTANT c_fft_sosi_rst_in : t_fft_sosi_in := ('0', (OTHERS=>'0'), std_logic_vector(to_unsigned(0,c_fft_sosi_rst_in.re'length)), std_logic_vector(to_unsigned(0,c_fft_sosi_rst_in.im'length)), '0', '0', '0', (OTHERS=>'0'), (OTHERS=>'0'), (OTHERS=>'0'));

	--t_dp_sosi record
	TYPE t_fft_sosi_out IS RECORD       -- Source Out or Sink In
		sync  : STD_LOGIC;
		re    : STD_LOGIC_VECTOR(c_fft_out_dat_w - 1 DOWNTO 0); -- data
		im    : STD_LOGIC_VECTOR(c_fft_out_dat_w - 1 DOWNTO 0); -- data
		valid : STD_LOGIC;              -- ctrl
	END RECORD;

	CONSTANT c_fft_sosi_rst_out : t_fft_sosi_out := ('0', (OTHERS => '0'), (OTHERS => '0'), '0');

	TYPE t_fft_sosi_arr_in IS ARRAY (INTEGER RANGE <>) OF t_fft_sosi_in;
	TYPE t_fft_sosi_arr_out IS ARRAY (INTEGER RANGE <>) OF t_fft_sosi_out;

	-- short hand to create an svec from integer of bit width in_dat_w
	function to_fft_in_svec(n : integer; width : integer) return std_logic_vector;
	function to_fft_stg_svec(n : integer; width : integer) return std_logic_vector;

	-- FFT shift swaps right and left half of bin axis to shift zero-frequency component to center of spectrum
	function fft_shift(bin : std_logic_vector) return std_logic_vector;
	function fft_shift(bin, w : natural) return natural;

	-- Calculate stage lengths for the pipelined and parallel FFT's separately.
	function fft_shiftreglen_pipe(wb_factor, pts : natural) return natural;
	function fft_shiftreglen_par(wb_factor, pts : natural) return natural;

END fft_gnrcs_intrfcs_pkg;

PACKAGE BODY fft_gnrcs_intrfcs_pkg is

	function fft_r2_parameter_asserts(g_fft : t_fft) return boolean is
	begin
		-- nof_points
		assert g_fft.nof_points = 2 ** true_log2(g_fft.nof_points) report "fft_r2: nof_points must be a power of 2" severity failure;
		-- wb_factor
		assert g_fft.wb_factor = 2 ** true_log2(g_fft.wb_factor) report "fft_r2: wb_factor must be a power of 2" severity failure;
		-- use_reorder
		if g_fft.use_reorder = false then
			assert g_fft.use_separate = false report "fft_r2 : without use_reorder there cannot be use_separate for two real inputs" severity failure;
			assert g_fft.use_fft_shift = false report "fft_r2 : without use_reorder there cannot be use_fft_shift for complex input" severity failure;
		end if;
		-- use_separate
		if g_fft.use_separate then
			assert g_fft.use_fft_shift = false report "fft_r2 : with use_separate there cannot be use_fft_shift for two real inputs" severity failure;
		end if;
		-- in_place
		if g_fft.pipe_reo_in_place then
			assert g_fft.nof_chan = 0 report "fft_r2 : can't use in place buffer with multiple channels in pipeline reorder" severity failure;
			assert g_fft.use_fft_shift = false report "fft_r2 : can't use in place buffer and use_fft_shift in pipeline reorder" severity failure;
		end if;
		return true;
	end;

	function to_fft_in_svec(n : integer; width : integer) return std_logic_vector is
	begin
		return RESIZE_SVEC(TO_SVEC(n, width), width);
	end;

	function to_fft_stg_svec(n : integer; width : integer) return std_logic_vector is
	begin
		return RESIZE_SVEC(TO_SVEC(n, width), width);
	end;

	function fft_shift(bin : std_logic_vector) return std_logic_vector is
		constant c_w   : natural                            := bin'length;
		variable v_bin : std_logic_vector(c_w - 1 downto 0) := bin;
	begin
		v_bin := bin;
		return not v_bin(c_w - 1) & v_bin(c_w - 2 downto 0); -- invert MSbit for fft_shift
	end;

	-- Calculate the length of the shiftregister and ovflw register for pipe fft
	function fft_shift(bin, w : natural) return natural is
	begin
		return TO_UINT(fft_shift(TO_UVEC(bin, w)));
	end;

	-- Functions for stage length calculations for wideband FFT
	function fft_shiftreglen_pipe(wb_factor, pts : natural) return natural is
		variable sr_len : natural;
	begin
		if (wb_factor = 1) then
			sr_len := ceil_log2(pts);
		elsif (wb_factor > 1 and wb_factor < pts) then
			sr_len := ceil_log2(pts / wb_factor);
		else
			sr_len := 0;
		end if;
		return sr_len;
	end;

	-- Calculate the length of the shiftregister and ovflw register for par fft
	function fft_shiftreglen_par(wb_factor, pts : natural) return natural is
		variable sr_len : natural;
	begin
		if (wb_factor = pts) then
			sr_len := ceil_log2(pts);
		elsif (wb_factor > 1 and wb_factor < pts) then
			sr_len := ceil_log2(wb_factor);
		else
			sr_len := 0;
		end if;
		return sr_len;
	end;

END fft_gnrcs_intrfcs_pkg;
        """
        with open(self.hdl_wrapper_dir + "/fft_gnrcs_intrfcs_pkg.vhd", "w", encoding="utf-8") as file:
            file.write(vhdl_template)

    def _generate_rTwoSDFPkg(self):
        # the same reason as above
        twids_dir = self.hdl_wrapper_dir + "/twids"
        vhdl_template = f"""
Library ieee, common_pkg_lib;
use IEEE.std_logic_1164.all;
use common_pkg_lib.common_pkg.all;

package rTwoSDFPkg is
constant c_twid_file_stem : string := "{twids_dir}";
-- Also used for other preallele and wideband FFT implementations (fft_lib)
type t_fft_pipeline is record
-- generics for rTwoSDFStage
stage_lat     : natural;        -- = 1
weight_lat    : natural;        -- = 2 -- this was changed from 1 to 2 for better timing on Ultrascale / Versal
mul_lat       : natural;        -- = 5 -- This was changed from (3+1) to 5 for better timing on Ultrascale/Versal
-- generics for rTwoBFStage
bf_lat        : natural;        -- = 1
-- generics for rTwoBF
bf_use_zdly   : natural;        -- = 1
bf_in_a_zdly  : natural;        -- = 0
bf_out_d_zdly : natural;        -- = 0
end record;
constant c_fft_pipeline : t_fft_pipeline := (1, 2, 5, 1, 1, 0, 1);

end package rTwoSDFPkg;

package body rTwoSDFPkg IS
end rTwoSDFPkg;
        """
        with open(self.hdl_wrapper_dir + "/rTwoSDFPkg.vhd", "w", encoding="utf-8") as file:
            file.write(vhdl_template)
