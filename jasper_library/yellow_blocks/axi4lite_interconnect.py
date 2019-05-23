from yellow_block import YellowBlock
from yellow_block_typecodes import *

class axi4lite_interconnect(YellowBlock):
    """
    Yellow block class to incorporate Oxford's python code to generate 
    AXI4-Lite VHDL register interfaces from a XML memory map specification.

    Obtained from: https://bitbucket.org/ricch/xml2vhdl/src/master/

    .. warning:: 

        This yellow block class must be after all other yellow blocks!
    """
    def initialize(self):
        self.platform_support = 'all'
        self.add_source('axi4_lite')

    def modify_top(self,top):
        # Make a memory map for all axi4lite interfaces/slaves
        top.axi4lite_memory_map(self.platform.mmbus_base_address, self.platform.mmbus_address_alignment)
        self.memory_map = top.memory_map

        # instantiate wrapper and add relevant ports
        # expose AXI4-Lite interface to connected to processor

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        return tcl_cmds