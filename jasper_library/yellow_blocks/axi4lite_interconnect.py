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

        inst = top.get_instance(name=self.name, entity='axi4lite_interconnect')
        # instantiate axi4lite wrapper
        # clk and rst signals
        inst.add_port('axi4lite_aclk',    'sys_clk',              dir='out')
        inst.add_port('axi4lite_aresetn', 'peripheral_aresetn_0', dir='out')

        # axi4l miso signals
        inst.add_port('s_axi4lite_awready', 'M_AXI_awready', dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_wready',  'M_AXI_wready' , dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_bresp',   'M_AXI_bresp'  , dir='out', width=2,  parent_sig=False)
        inst.add_port('s_axi4lite_bvalid',  'M_AXI_bvalid' , dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_arready', 'M_AXI_arready', dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_rresp',   'M_AXI_rresp'  , dir='out', width=2,  parent_sig=False)
        inst.add_port('s_axi4lite_rdata',   'M_AXI_rdata'  , dir='out', width=32, parent_sig=False)
        inst.add_port('s_axi4lite_rvalid',  'M_AXI_rvalid' , dir='out', width=1,  parent_sig=False)

        # axi4l mosi signals
        inst.add_port('s_axi4lite_awaddr',  'M_AXI_awaddr',  dir='out', width=32, parent_sig=False)
        inst.add_port('s_axi4lite_awvalid', 'M_AXI_awvalid', dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_wdata',   'M_AXI_wdata',   dir='out', width=32, parent_sig=False)
        inst.add_port('s_axi4lite_wvalid',  'M_AXI_wvalid',  dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_wstrb',   'M_AXI_wstrb',   dir='out', width=4,  parent_sig=False)
        inst.add_port('s_axi4lite_araddr',  'M_AXI_araddr',  dir='out', width=32, parent_sig=False)
        inst.add_port('s_axi4lite_arvalid', 'M_AXI_arvalid', dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_rready',  'M_AXI_rready',  dir='out', width=1,  parent_sig=False)
        inst.add_port('s_axi4lite_bready',  'M_AXI_bready',  dir='out', width=1,  parent_sig=False)

        #self.design_name = self.fullname[:-1].strip(self.name)
        self.design_name = "test_red_pitaya"

        for key, val in self.memory_map.items():
            for reg in val["memory_map"]:
                if (reg.mode == "r"):
                    inst.add_port(key + '_' + reg.name,         self.design_name + '_' + reg.name + '_user_data_in', dir='out', width=32, parent_sig=True)
                    inst.add_port(key + '_' + reg.name + '_we', self.design_name + '_' + reg.name + '_we',            dir='out', width=1)
                if (reg.mode == "rw"):
                    inst.add_port(key + '_' + reg.name,         self.design_name + '_' + reg.name + '_user_data_out', dir='out', width=32, parent_sig=True)
                    inst.add_port(key + '_' + reg.name + '_re', self.design_name + '_' + reg.name + '_re',           dir='in' , width=1)


    def gen_tcl_cmds(self):
        print('axi4lite gen_tcl_cmds')
        print('=====================')
        #import IPython
        IPython.embed()
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_synth'] += ['add_files {/home/wnew/casper/mlib_devel_rp/jasper_library/hdl_sources/axi4_lite/axi4lite_slave_logic.vhd /home/wnew/casper/mlib_devel_rp/jasper_library/hdl_sources/axi4_lite/axi4lite_pkg.vhd']
        tcl_cmds['pre_synth'] += ['aet_property library work [get_files  {/home/wnew/casper/mlib_devel_rp/jasper_library/hdl_sources/axi4_lite/axi4lite_slave_logic.vhd /home/wnew/casper/mlib_devel_rp/jasper_library/hdl_sources/axi4_lite/axi4lite_pkg.vhd}]']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds


    # create axi4lite_wrapper vhdl module
    # this is a bit of an orphan classs as it has never been done before 
    # and I cant think where it should be located
    def gen_custom_hdl(self):

        axi4lite_wrapper = vhdlModule("axi4lite_wrapper")

        axi4lite_wrapper.add_library('ieee', ['std_logic_1164'])
        axi4lite_wrapper.add_library('work', ['axi4lite_pkg', 'axi4lite_axi4lite_ic_pkg', 'axi4lite_axi4lite_mmap_pkg'])
        axi4lite_wrapper.gen_file()

        # axi4l miso signals
        axi4lite_wrapper.add_port('s_axi4lite_awready', 'M_AXI_awready', dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wready',  'M_AXI_wready' , dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_bresp',   'M_AXI_bresp'  , dir='out', width=2,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_bvalid',  'M_AXI_bvalid' , dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_arready', 'M_AXI_arready', dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_rresp',   'M_AXI_rresp'  , dir='out', width=2,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_rdata',   'M_AXI_rdata'  , dir='out', width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_rvalid',  'M_AXI_rvalid' , dir='out', width=1,  parent_sig=False)

        # axi4l mosi signals
        axi4lite_wrapper.add_port('s_axi4lite_awaddr',  'M_AXI_awaddr',  dir='out', width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_awvalid', 'M_AXI_awvalid', dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wdata',   'M_AXI_wdata',   dir='out', width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wvalid',  'M_AXI_wvalid',  dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wstrb',   'M_AXI_wstrb',   dir='out', width=4,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_araddr',  'M_AXI_araddr',  dir='out', width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_arvalid', 'M_AXI_arvalid', dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_rready',  'M_AXI_rready',  dir='out', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_bready',  'M_AXI_bready',  dir='out', width=1,  parent_sig=False)

        #TODO: add breakout ports for the registers
        for key, val in self.memory_map.items():
            for reg in val["memory_map"]:
                if (reg.mode == "r"):
                    axi4lite_wrapper.add_port(key + '_' + reg.name,         self.design_name + '_' + reg.name + '_user_data_in',  dir='out', width=32, parent_sig=True)
                    axi4lite_wrapper.add_port(key + '_' + reg.name + '_we', self.design_name + '_' + reg.name + '_we',            dir='out', width=1)
                if (reg.mode == "rw"):
                    axi4lite_wrapper.add_port(key + '_' + reg.name,         self.design_name + '_' + reg.name + '_user_data_out', dir='out', width=32, parent_sig=True)
                    axi4lite_wrapper.add_port(key + '_' + reg.name + '_re', self.design_name + '_' + reg.name + '_re',            dir='in' , width=1)


        return {'axi4lite_wrapper', axi4lite_wrapper.get_code()}
        # instantiate wrapper and add relevant ports
        # expose AXI4-Lite interface to connected to processor



class vhdlModule(object):

    def __init__(self, name='', topfile=None, comment=''):
        self.name=name
        self.libraries = {}     # libraries used in the entity 
        self.library_text = ''
        self.parameters = {}    # top-level parameters
        self.localparams = {}   # top-level localparams
        self.signals = {}       # top-level wires
        self.instances = {}     # top-level instances
        self.assignments = {}   # top-level assign statements
        self.complete_text = ''

    def add_library(self, library, packages=[]):
        self.library_text += "library %s ;\n" %library
        for pkg in packages:
            self.library_text += "use %s.%s.all; \n" %(library, pkg)
        self.library_text += '\n'

    def add_port(self, name, type, dir, signal=None, parent_port=False, parent_sig=True, comment=None, **kwargs):
        pass

    def add_parameter(self, name, value, comment=None):
        pass

    def add_signal(self, signal, type, comment=None):
        pass

    def add_entity(self, name, comment=None):
        pass

    def add_instance(self, name, comment=None):
        pass

    def add_body(self, text, comment=None):
        pass

    def assign_signal(self, lhs, rhs, comment=None):
        pass

    def gen_file(self, filename='', output_dir=''):
        self.complete_text += self.library_text
        self.complete_text += 'entity %s is\n' %self.name
        self.complete_text += '\tport (\n'
        # TODO: add ports
        self.complete_text += '\t)\n'
        self.complete_text += 'end entity;\n'
        print self.complete_text
        if filename != '' and output_dir != '':
            # create file
            pass

    def gen_code(self):
        self.gen_file(self)
        return complete_text
