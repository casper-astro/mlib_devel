from yellow_block import YellowBlock
from yellow_block_typecodes import *

class AXI4LiteInterconnect(YellowBlock):
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
        top.axi4lite_compute(self.plat.mmbus_base_address, self.plat.mmbus_address_alignment)

        self.axi4lite_devices = top.axi4lite_devices
        self.n_axi4lite_slaves = top.n_axi4lite_slaves
        self.n_axi4lite_interfaces = top.n_axi4lite_interfaces
        self.axi4lite_ids = top.axi4lite_ids

        # instantiate wrapper and add relevant ports
        # expose AXI4-Lite interface to connected to processor

        for dev in self.axi4lite_devices:
            # add all software registers to one memory mapped AXI4-Lite interface
            if dev.typecode == TYPECODE_SWREG:
                print(dev.regname)

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        return tcl_cmds