import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule
from glob import glob
import os
class munge(DSPBlock):
    def initialize(self):
        self.add_source('munge/munge.v')
        #self.add_source('munge/munge.vhd')
        #self.add_source('common_pkg/common_pkg.vhd')
        #self.add_source('common_pkg/fixed_float_types_c.vhd')
        #self.add_source('common_pkg/fixed_pkg_c.vhd')
        #self.add_source('common_pkg/*.vhd')
        #self.vhdl_lib = glob(self.hdl_root + '/common_pkg/*.vhd')  

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'munge'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("g_total_bits", self.total_bits)
        inst.add_parameter("g_number_of_divisions", self.divisions)
        inst.add_parameter("g_division_size_bits", self.size_bits)
        inst.add_parameter("g_packing_order", "%s"%self.packing_order)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('ce', '1', dir='in')
        inst.add_port('in', self.fullname+'_in', parent_port=False, width=self.total_bits, dir='in')
        inst.add_port('out', self.fullname+'_out', parent_port=False, width=self.total_bits, dir='out')

    def gen_tcl_cmds(self):
        # tcl_cmds = []
        # for f in self.vhdl_lib:
        #     f = f.split('/')[-1]
        #     tcl_cmds.append('set_property library common_pkg_lib [get_files /%s/dspproj/dspproj.srcs/sources_1/imports/common_pkg/%s]'%(self.fullpath, f))
        # tcl_cmds.append('update_compile_order -fileset sources_1')
        # tcl_cmds.append('set_property FILE_TYPE {VHDL 2008} [get_files *.vhd]')
        # return {'pre_synth': tcl_cmds}
        return {}