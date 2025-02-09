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

class wbfft(DSPBlock):
    def initialize(self):
        # create the hdl wrapper directory
        self.create_hdl_dir()
        # add the source files
        self.add_source('casper_dspdevel/common_pkg/fixed_float_types_c.vhd')
        wbfft_libs['common_pkg_lib'].append('casper_dspdevel/common_pkg/fixed_float_types_c.vhd')
        self.add_source('casper_dspdevel/common_pkg/fixed_pkg_c.vhd')
        wbfft_libs['common_pkg_lib'].append('casper_dspdevel/common_pkg/fixed_pkg_c.vhd')
        self.add_source('casper_dspdevel/common_pkg/common_pkg.vhd')
        wbfft_libs['common_pkg_lib'].append('casper_dspdevel/common_pkg/common_pkg.vhd')
        self.add_source('casper_dspdevel/common_components/common_pipeline.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_pipeline.vhd')
        self.add_source('casper_dspdevel/casper_adder/common_add_sub.vhd')
        wbfft_libs['casper_adder_lib'].append('casper_dspdevel/casper_adder/common_add_sub.vhd')
        self.add_source('casper_dspdevel/common_components/common_async.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_async.vhd')
        self.add_source('casper_dspdevel/common_components/common_areset.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_areset.vhd')
        self.add_source('casper_dspdevel/common_components/common_bit_delay.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_bit_delay.vhd')
        self.add_source('casper_dspdevel/common_components/common_pipeline_sl.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_pipeline_sl.vhd')
        self.add_source('casper_dspdevel/casper_multiplier/tech_mult_component.vhd')
        wbfft_libs['casper_multiplier_lib'].append('casper_dspdevel/casper_multiplier/tech_mult_component.vhd')
        self.add_source('casper_dspdevel/casper_multiplier/tech_agilex_versal_cmult.vhd')
        wbfft_libs['casper_multiplier_lib'].append('casper_dspdevel/casper_multiplier/tech_agilex_versal_cmult.vhd')
        self.add_source('casper_dspdevel/technology/technology_select_pkg.vhd')
        wbfft_libs['technology_lib'].append('casper_dspdevel/technology/technology_select_pkg.vhd')
        self.add_source('casper_dspdevel/casper_multiplier/tech_complex_mult.vhd')
        wbfft_libs['casper_multiplier_lib'].append('casper_dspdevel/casper_multiplier/tech_complex_mult.vhd')
        self.add_source('casper_dspdevel/casper_multiplier/common_complex_mult.vhd')
        wbfft_libs['casper_multiplier_lib'].append('casper_dspdevel/casper_multiplier/common_complex_mult.vhd')
        self.add_source('casper_dspdevel/casper_counter/common_counter.vhd')
        wbfft_libs['casper_counter_lib'].append('casper_dspdevel/casper_counter/common_counter.vhd')
        self.add_source('casper_dspdevel/common_components/common_delay.vhd')
        wbfft_libs['common_components_lib'].append('casper_dspdevel/common_components/common_delay.vhd')
        self.add_source('casper_dspdevel/casper_fifo/common_rl_decrease.vhd')
        wbfft_libs['casper_fifo_lib'].append('casper_dspdevel/casper_fifo/common_rl_decrease.vhd')
        self.add_source('casper_dspdevel/casper_fifo/common_fifo_rd.vhd')
        wbfft_libs['casper_fifo_lib'].append('casper_dspdevel/casper_fifo/common_fifo_rd.vhd')
        self.add_source('casper_dspdevel/casper_fifo/tech_fifo_component_pkg.vhd')
        wbfft_libs['casper_fifo_lib'].append('casper_dspdevel/casper_fifo/tech_fifo_component_pkg.vhd')
        self.add_source('casper_dspdevel/casper_fifo/tech_fifo_sc.vhd')
        wbfft_libs['casper_fifo_lib'].append('casper_dspdevel/casper_fifo/tech_fifo_sc.vhd')
        self.add_source('casper_dspdevel/casper_fifo/common_fifo_sc.vhd')
        wbfft_libs['casper_fifo_lib'].append('casper_dspdevel/casper_fifo/common_fifo_sc.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_ram_pkg.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_ram_pkg.vhd')
        self.add_source('casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd')
        self.add_source('casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd')
        self.add_source('casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_ram_crw_crw.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_ram_crw_crw.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_paged_ram_crw_crw.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_paged_ram_crw_crw.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_paged_ram_rw_rw.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_paged_ram_rw_rw.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_paged_ram_r_w.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_paged_ram_r_w.vhd')
        self.add_source('casper_dspdevel/casper_requantize/common_round.vhd')
        wbfft_libs['casper_requantize_lib'].append('casper_dspdevel/casper_requantize/common_round.vhd')
        self.add_source('casper_dspdevel/casper_requantize/common_resize.vhd')
        wbfft_libs['casper_requantize_lib'].append('casper_dspdevel/casper_requantize/common_resize.vhd')
        self.add_source('casper_dspdevel/casper_requantize/common_requantize.vhd')
        wbfft_libs['casper_requantize_lib'].append('casper_dspdevel/casper_requantize/common_requantize.vhd')
        self.add_source('casper_dspdevel/casper_ram/tech_memory_rom_r_r.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/tech_memory_rom_r_r.vhd')
        self.add_source('casper_dspdevel/casper_ram/tech_memory_rom_r.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/tech_memory_rom_r.vhd')
        self.add_source('casper_dspdevel/casper_ram/common_rom_r_r.vhd')
        wbfft_libs['casper_ram_lib'].append('casper_dspdevel/casper_ram/common_rom_r_r.vhd')
        self.add_source('casper_dspdevel/common_pkg/common_str_pkg.vhd')
        wbfft_libs['common_pkg_lib'].append('casper_dspdevel/common_pkg/common_str_pkg.vhd')
        self.add_source('casper_dspdevel/casper_multiplexer/common_zip.vhd')
        wbfft_libs['casper_multiplexer_lib'].append('casper_dspdevel/casper_multiplexer/common_zip.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_gnrcs_intrfcs_pkg.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_gnrcs_intrfcs_pkg.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/twiddlesPkg.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/twiddlesPkg.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoSDFPkg.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoSDFPkg.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoBF.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoBF.vhd')
        self.add_source('casper_dspdevel/casper_requantize/r_shift_requantize.vhd')
        wbfft_libs['casper_requantize_lib'].append('casper_dspdevel/casper_requantize/r_shift_requantize.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoWMul.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoWMul.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_r2_bf_par.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_r2_bf_par.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_r2_par.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_r2_par.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoBFStage.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoBFStage.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoWeights.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoWeights.vhd')
        self.add_source('casper_dspdevel/r2sdf_fft/rTwoSDFStage.vhd')
        wbfft_libs['r2sdf_fft_lib'].append('casper_dspdevel/r2sdf_fft/rTwoSDFStage.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_sepa.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_sepa.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_reorder_sepa_pipe.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_reorder_sepa_pipe.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_r2_pipe.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_r2_pipe.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_sepa_wide.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_sepa_wide.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_r2_wide.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_r2_wide.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_wide_unit_control.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_wide_unit_control.vhd')
        self.add_source('casper_dspdevel/casper_wb_fft/fft_wide_unit.vhd')
        wbfft_libs['casper_wb_fft_lib'].append('casper_dspdevel/casper_wb_fft/fft_wide_unit.vhd')
        self.add_source('casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_3dsp.vhd')
        wbfft_libs['ip_xpm_mult_lib'].append('casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_3dsp.vhd')
        self.add_source('casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_4dsp.vhd')
        wbfft_libs['ip_xpm_mult_lib'].append('casper_dspdevel/ip_xpm/mult/ip_cmult_rtl_4dsp.vhd')
        self.add_source('casper_dspdevel/ip_xpm/fifo/ip_xilinx_fifo_sc.vhd')
        wbfft_libs['ip_xpm_fifo_lib'].append('casper_dspdevel/ip_xpm/fifo/ip_xilinx_fifo_sc.vhd')
        self.add_source('casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd')
        wbfft_libs['ip_xpm_ram_lib'].append('casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd')
        self.add_source('casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd')
        wbfft_libs['ip_xpm_ram_lib'].append('casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd')
        self.add_source('casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r.vhd')
        wbfft_libs['ip_xpm_ram_lib'].append('casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r.vhd')
        self.add_source('casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r_r.vhd')
        wbfft_libs['ip_xpm_ram_lib'].append('casper_dspdevel/ip_xpm/ram/ip_xpm_rom_r_r.vhd')
        # add the generated wrapper
        self.add_source(self.hdl_wrapper_dir + "/casper_wideband_fft.vhd")
        # generate twiddle coefficients
        # delete the twids dir, if it exists
        if os.path.exists(self.hdl_wrapper_dir + "/twids"):
            os.system(f"rm -rf {self.hdl_wrapper_dir}/twids")
        # the twids dir will be created automatically
        self._generate_twids(self.hdl_root + "/casper_dspdevel/wrappers/simulink/sdf_fft_twid_create.py")
        # generate hdl wrapper
        self._generate_vhdl_wrapper()

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
        inst.add_parameter("use_variant", self.use_variant)
        inst.add_parameter("use_dsp", self.use_dsp)
        inst.add_parameter("ovflw_behav", self.ovflw_behav)
        inst.add_parameter("use_round", self.use_round)
        inst.add_parameter("ram_primitive", self.ram_primitive)
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
                tcl_cmds.append('update_compile_order -fileset sources_1\n')
                tcl_cmds.append('set_property LIBRARY %s [get_files %s/f]\n'%(k, self.hdl_root))
        return {'pre_synth': tcl_cmds}

    def _generate_vhdl_wrapper(self):
        # this piece of code is terriable!
        # we need to think about how to improve it!
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
        use_reorder    : boolean; -- = false for bit-reversed output, true for normal output
        use_fft_shift  : boolean; -- = false for [0, pos, neg] bin frequencies order, true for [neg, 0, pos] bin frequencies order in case of complex input
        use_separate   : boolean; -- = false for complex input, true for two real inputs
        alt_output     : boolean;
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
        guard_enable   : boolean; -- = true when input needs guarding, false when input requires no guarding but scaling must be
                                --   skipped at the last stage(s) compensate for input guard (used in wb fft with pipe fft section
                                --   doing the input guard and par fft section doing the output compensation)
        pipe_reo_in_place : boolean;
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
        vhdl_template += "    ".join(f"out_im_{i}       : in std_logic_vector(out_dat_w-1 downto 0);\n    out_re_{i}       : in std_logic_vector(out_dat_w-1 downto 0);\n" for i in range(wb_factor))
        vhdl_template += f"""
    );
end entity wideband_fft_top;

architecture rtl of wideband_fft_top is
    constant round_mode : t_rounding_mode := t_rounding_mode'val(use_round);
    constant cc_fft : t_fft := (use_reorder,use_fft_shift,use_separate,0,wb_factor,nof_points,in_dat_w,out_dat_w,out_gain_w,stage_dat_w,twiddle_dat_w,max_addr_w,guard_w,guard_enable, 56, 2, pipe_reo_in_place);
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
            g_alt_output        => alt_output,
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
        otheroutprtmap: for k in 0 to wb_factor-1 generate
            out_sync    <=out_fft_sosi_arr(k).sync;
            out_valid   <=out_fft_sosi_arr(k).valid;
        end generate;
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
        vendor = self.vendor
        python_cmd = f"python3 {script} -o {twids_dir} -g 1 -p {nof_points} -w {wb_factor} -c {twid_dat_w} -v {vendor} -V 0"
        os.system(python_cmd)