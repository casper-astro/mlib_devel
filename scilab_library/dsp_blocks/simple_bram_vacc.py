import os, sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

module_libs = {}
module_libs['casper_misc_lib'] = []
module_libs['common_pkg_lib'] = []
module_libs['common_components_lib'] = []
module_libs['casper_adder_lib'] = []
module_libs['casper_counter_lib'] = []
module_libs['xil_defaultlib'] = []
module_libs['casper_ram_lib'] = []
module_libs['technology_lib'] = []
module_libs['casper_delay_lib'] = []
module_libs['ip_xpm_ram_lib'] = []
module_libs['ip_stratixiv_ram_lib'] = []

class simple_bram_vacc(DSPBlock):
    
    def family_to_tech_select(self, family: str) -> str:
        f = (family or "").lower()
        if "versal" in f:
            return "c_tech_versal"
        if any(x in f for x in ["cyclone", "stratix", "arria", "agilex", "max 10", "altera"]):
            return "c_tech_stratixiv"
        return "c_tech_xpm"

    def get_platform_family(self) -> str:
        """
        Best-effort lookup for the target FPGA family.
        Adjust this if the platform object stores family somewhere else.
        """
        # Common possibilities in CASPER-style platform objects:
        for attr in ("family", "fpga_family", "device_family"):
            if hasattr(self.platform, attr):
                val = getattr(self.platform, attr)
                if val:
                    return str(val)

        # Some flows keep metadata in a conf dict
        conf = getattr(self.platform, "conf", None)
        if isinstance(conf, dict):
            for key in ("family", "fpga_family", "device_family"):
                if conf.get(key):
                    return str(conf[key])

        return ""

    def add_vhdl_source(self, libname: str, path: str):
        self.add_source(path)
        module_libs[libname].append(path)

    def initialize(self):
        family = self.get_platform_family()
        tech = self.family_to_tech_select(family)
        jasper_backend = os.environ.get("JASPER_BACKEND", "").lower()
        is_intel = (jasper_backend == "quartus")
        self.is_intel = is_intel

        for k in module_libs:
            module_libs[k].clear()

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/misc/c_to_ri.vhd'))
        module_libs['casper_misc_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/misc/c_to_ri.vhd'))

        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/float_pkg_c.vhd'))
        #module_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_pkg/float_pkg_c.vhd'))

        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/fixed_float_types_c.vhd'))
        module_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_pkg/fixed_float_types_c.vhd'))

        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/fixed_pkg_c.vhd'))
        module_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_pkg/fixed_pkg_c.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_pipeline.vhd'))
        module_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_components/common_pipeline.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_adder/common_add_sub.vhd'))
        module_libs['casper_adder_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_adder/common_add_sub.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_async.vhd'))
        module_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_components/common_async.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_areset.vhd'))
        module_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_components/common_areset.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_bit_delay.vhd'))
        module_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_components/common_bit_delay.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_counter/common_counter.vhd'))
        module_libs['casper_counter_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_counter/common_counter.vhd'))

        # free_run_down_counter.vhd
        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_counter/free_run_counter.vhd'))
        module_libs['casper_counter_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_counter/free_run_counter.vhd'))
        # free_run_up_counter
        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_counter/free_run_up_counter.vhd'))
        #module_libs['casper_counter_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_counter/free_run_up_counter.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_accumulators/simple_bram_vacc.vhd'))
        module_libs['xil_defaultlib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_accumulators/simple_bram_vacc.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_components/common_delay.vhd'))
        module_libs['common_components_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_components/common_delay.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'hdl_sources/edge_detect_new/edge_detect_new.v'))
        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/misc/edge_detect.vhd'))
        module_libs['casper_misc_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/misc/edge_detect.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/misc/pulse_ext.vhd'))
        module_libs['casper_misc_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/misc/pulse_ext.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_pkg.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/common_ram_pkg.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/technology/technology_select_pkg.vhd'))
        module_libs['technology_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/technology/technology_select_pkg.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/tech_memory_component_pkg.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/tech_memory_ram_crw_crw.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/tech_memory_ram_cr_cw.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_crw_crw.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/common_ram_crw_crw.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_rw_rw.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/common_ram_rw_rw.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_ram/common_ram_r_w.vhd'))
        module_libs['casper_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_ram/common_ram_r_w.vhd'))

        self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/casper_delay/delay_bram.vhd'))
        module_libs['casper_delay_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/casper_delay/delay_bram.vhd'))

        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/common_pkg/common_pkg.vhd'))
        module_libs['common_pkg_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/common_pkg/common_pkg.vhd'))

        # Vendor RAM wrappers: choose based on family
        if tech == "c_tech_stratixiv":
            module_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_cr_cw.vhd'))
            module_libs['ip_stratixiv_ram_lib'].append(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crw_crw.vhd'))

            #self.add_vhdl_source('ip_stratixiv_ram_lib','casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_cr_cw.vhd')
            #self.add_vhdl_source('ip_stratixiv_ram_lib','casper_dspdevel/ip_stratixiv/ram/ip_stratixiv_ram_crw_crw.vhd')
        else:
            self.add_vhdl_source('ip_xpm_ram_lib','casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd')
            self.add_vhdl_source('ip_xpm_ram_lib','casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd')

        #self.add_vhdl_source('xil_defaultlib', 'casper_dspdevel/casper_accumulators/simple_bram_vacc.vhd')


        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd'))
        #module_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_cr_cw.vhd'))

        #self.add_source(os.path.join(self.hdl_root_scilab, 'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd'))
        #module_libs['ip_xpm_ram_lib'].append(os.path.join(self.hdl_root_scilab,'casper_dspdevel/ip_xpm/ram/ip_xpm_ram_crw_crw.vhd'))

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'simple_bram_vacc'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("g_vector_length", self.vector_len)
        inst.add_parameter("g_output_type",  "\"%s\"" %self.output_type)
        inst.add_parameter("g_bit_w", self.out_bitwidth)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('ce', '1', parent_port=False, width=1, dir='in')
        inst.add_port('new_acc', self.fullname+'_new_acc', parent_port=False, width=1, dir='in')
        inst.add_port('din', self.fullname+'_din', parent_port=False, width=self.in_bitwidth, dir='in')
        inst.add_port('dout', self.fullname+'_dout', parent_port=False, width=self.out_bitwidth, dir='out')
        inst.add_port('valid', self.fullname+'_valid', parent_port=False, width=1, dir='out')
    
    def gen_tcl_cmds(self):
        tcl_cmds = []

        for k in module_libs.keys():
            for f in module_libs[k]:
                f_parts = f.split('/')

                if self.is_intel:
                    if os.path.isabs(f):
                        full_path = f
                    else:
                        full_path = os.path.abspath(os.path.join(self.hdl_root_scilab, f))
                    print(f"[simple_bram_vacc quartus] lib={k} file={full_path}")
                    tcl_cmds.append(f'set_global_assignment -name VHDL_FILE "{full_path}" -library {k}\n')
                else:
                    tcl_cmds.append('update_compile_order -fileset sources_1\n')
                    tcl_cmds.append('set_property LIBRARY %s [get_files %s/dspproj/dspproj.srcs/sources_1/imports/%s/%s]\n' % (k, self.builddir, f_parts[-2], f_parts[-1]))
        return {'pre_synth': tcl_cmds}