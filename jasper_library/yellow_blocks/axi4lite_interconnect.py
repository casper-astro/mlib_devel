import math
from .yellow_block import YellowBlock
from .yellow_block_typecodes import *

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

        inst = top.get_instance(name=self.name, entity='axi4lite_ic_wrapper')
        # instantiate axi4lite wrapper
        # clk and rst signals
        inst.add_port('axi4lite_aclk',    'axil_clk',        dir='out')
        inst.add_port('axi4lite_aresetn', 'axil_rst_n',      dir='out')

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
        self.design_name = self.fullname.replace("_axi4lite_interconnect","")
        #self.design_name = "test_red_pitaya"

        for key, val in list(self.memory_map.items()):
            for reg in val["memory_map"]:
                if reg.ram == True:
                    inst.add_port('axi4lite_%s_%s_add'      %(key, reg.name), '%s_%s_addr'     %(self.design_name, reg.name), dir='in',  width=math.log10(reg.nbytes/4)/math.log10(2), parent_sig=True)
                    inst.add_port('axi4lite_%s_%s_data_in'  %(key, reg.name), '%s_%s_data_in'  %(self.design_name, reg.name), dir='in',  width=32,           parent_sig=True)
                    inst.add_port('axi4lite_%s_%s_data_out' %(key, reg.name), '%s_%s_data_out' %(self.design_name, reg.name), dir='out', width=32,           parent_sig=True)
                    inst.add_port('axi4lite_%s_%s_we'       %(key, reg.name), '%s_%s_we'       %(self.design_name, reg.name), dir='in',  width=1,            parent_sig=True)
                    inst.add_port('axi4lite_%s_%s_en'       %(key, reg.name), '1\'b1'                                       , dir='in',  width=1,            parent_sig=False, parent_port=False)
                    inst.add_port('axi4lite_%s_%s_clk'      %(key, reg.name), 'user_clk'                                    , dir='in',  width=1,            parent_sig=False, parent_port=False)
                else:
                    if (reg.mode == "r"):
                        inst.add_port('axi4lite_%s_%s_in'     %(key, reg.name), '%s_%s_in'     %(self.design_name, reg.name), dir='out', width=32, parent_sig=True)
                        inst.add_port('axi4lite_%s_%s_in_we'  %(key, reg.name), '%s_%s_in_we'  %(self.design_name, reg.name), dir='out', width=1)
                    if (reg.mode == "rw"):
                        inst.add_port('axi4lite_%s_%s_out'    %(key, reg.name), '%s_%s_out'    %(self.design_name, reg.name), dir='in', width=32, parent_sig=True)
                        inst.add_port('axi4lite_%s_%s_out_we' %(key, reg.name), '%s_%s_out_we' %(self.design_name, reg.name), dir='in', width=1)
           

    def gen_tcl_cmds(self):
        print('axi4lite gen_tcl_cmds')
        print('=====================')
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_synth'] += ['add_files {%s/axi4_lite/axi4lite_slave_logic.vhd %s/axi4_lite/axi4lite_pkg.vhd}' %(self.hdl_root, self.hdl_root)]
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds

    def add_build_dir_source(self):
        return [{'files':'xml2vhdl_hdl_output/', 'library':'xil_defaultlib'}]


    # create axi4lite_wrapper vhdl module
    # this is a bit of an orphan classs as it has never been done before 
    # and I cant think where it should be located
    def gen_custom_hdl(self):

        axi4lite_wrapper = vhdlModule("axi4lite_ic_wrapper")

        libs = ['axi4lite_pkg', 'axi4lite_axi4lite_top_ic_pkg', 'axi4lite_axi4lite_top_mmap_pkg']
        for key, val in list(self.memory_map.items()):
            libs.append('axi4lite_%s_pkg'%key)

        axi4lite_wrapper.add_library('ieee', ['std_logic_1164'])
        axi4lite_wrapper.add_library('xil_defaultlib', libs)
        axi4lite_wrapper.gen_file()
        
        # axi4lite clock and reset signals
        axi4lite_wrapper.add_port('axi4lite_aclk',    '', dir='in', width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('axi4lite_aresetn', '', dir='in', width=1,  parent_sig=False)

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
        axi4lite_wrapper.add_port('s_axi4lite_awaddr',  'M_AXI_awaddr',  dir='in',  width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_awvalid', 'M_AXI_awvalid', dir='in',  width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wdata',   'M_AXI_wdata',   dir='in',  width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wvalid',  'M_AXI_wvalid',  dir='in',  width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_wstrb',   'M_AXI_wstrb',   dir='in',  width=4,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_araddr',  'M_AXI_araddr',  dir='in',  width=32, parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_arvalid', 'M_AXI_arvalid', dir='in',  width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_rready',  'M_AXI_rready',  dir='in',  width=1,  parent_sig=False)
        axi4lite_wrapper.add_port('s_axi4lite_bready',  'M_AXI_bready',  dir='in',  width=1,  parent_sig=False)

        # breakout ports for the registers from the records
        for key, val in list(self.memory_map.items()):
            for reg in val["memory_map"]:
                if reg.ram==True:
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_add'      %(key, reg.name), '%s_%s_add'     %(self.design_name, reg.name), dir='in',  width=int(math.log10(reg.nbytes/4)/math.log10(2)), parent_sig=True)
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_data_in'  %(key, reg.name), '%s_%s_data_in'  %(self.design_name, reg.name), dir='in',  width=32,           parent_sig=True)
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_data_out' %(key, reg.name), '%s_%s_data_out' %(self.design_name, reg.name), dir='out', width=32,           parent_sig=True)
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_we'       %(key, reg.name), '%s_%s_we'       %(self.design_name, reg.name), dir='in',  width=1,            parent_sig=True)
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_en'       %(key, reg.name), '1\'b1'                                       , dir='in',  width=1,            parent_sig=False, parent_port=False)
                    axi4lite_wrapper.add_port('axi4lite_%s_%s_clk'      %(key, reg.name), 'user_clk'                                    , dir='in',  width=1,            parent_sig=False, parent_port=False)
                    pass
                else:
                    if (reg.mode == "rw"):
                        # add ports
                        axi4lite_wrapper.add_port('axi4lite_%s_%s_out'      %(key, reg.name), '%s_out_%s_user_data_in'    %(self.design_name, reg.name), dir='out', width=32, parent_sig=True)
                        axi4lite_wrapper.add_port('axi4lite_%s_%s_out_we'   %(key, reg.name), '%s_out_we_%s'              %(self.design_name, reg.name), dir='out',   width=1)
                        # add signals
                        axi4lite_wrapper.add_assign('axi4lite_%s_%s_out'    %(key, reg.name), 'axi4lite_%s_out.%s'    %(key, reg.name))
                        axi4lite_wrapper.add_assign('axi4lite_%s_%s_out_we' %(key, reg.name), 'axi4lite_%s_out_we.%s' %(key, reg.name))
                    if (reg.mode == "r"):
                        # add ports
                        axi4lite_wrapper.add_port('axi4lite_%s_%s_in'       %(key, reg.name), '%s_in_%s_user_data_in'    %(self.design_name, reg.name), dir='in', width=32, parent_sig=True)
                        axi4lite_wrapper.add_port('axi4lite_%s_%s_in_we'    %(key, reg.name), '%s_in_we_%s'              %(self.design_name, reg.name), dir='in',  width=1)
                        # add signals
                        axi4lite_wrapper.add_assign('axi4lite_%s_in.%s'     %(key, reg.name), 'axi4lite_%s_%s_in'     %(key, reg.name))
                        axi4lite_wrapper.add_assign('axi4lite_%s_in_we.%s'  %(key, reg.name), 'axi4lite_%s_%s_in_we'  %(key, reg.name))

        # add signals for the axi4lite interfaces
        axi4lite_wrapper.add_signal('axi4lite_mosi_arr', 't_axi4lite_mosi_arr(0 to c_axi4lite_mmap_nof_slave-1)')
        axi4lite_wrapper.add_signal('axi4lite_miso_arr', 't_axi4lite_miso_arr(0 to c_axi4lite_mmap_nof_slave-1)')
        axi4lite_wrapper.add_signal('axi4lite_mosi',     't_axi4lite_mosi')
        axi4lite_wrapper.add_signal('axi4lite_miso',     't_axi4lite_miso')

        for key, val in list(self.memory_map.items()):
            # for reg in val["memory_map"]:
            #     if reg.ram==True:
            if val['memory_map'][-1].ram==True:
                pass
            else:
                axi4lite_wrapper.add_signal('axi4lite_%s_in_we'  %key, 't_axi4lite_%s_decoded' %key)
                axi4lite_wrapper.add_signal('axi4lite_%s_in'     %key, 't_axi4lite_%s'         %key)
                axi4lite_wrapper.add_signal('axi4lite_%s_out_we' %key, 't_axi4lite_%s_decoded' %key)
                axi4lite_wrapper.add_signal('axi4lite_%s_out'    %key, 't_axi4lite_%s'         %key)

        # ports for interconnect instance
        self.ic_ports = []
        self.ic_ports.append(Port('axi4lite_aclk', 'axi4lite_aclk'))
        self.ic_ports.append(Port('axi4lite_aresetn', 'axi4lite_aresetn'))
        self.ic_ports.append(Port('axi4lite_mosi', 'axi4lite_mosi'))
        self.ic_ports.append(Port('axi4lite_mosi_arr', 'axi4lite_mosi_arr'))
        self.ic_ports.append(Port('axi4lite_miso', 'axi4lite_miso'))
        self.ic_ports.append(Port('axi4lite_miso_arr', 'axi4lite_miso_arr'))
        # add interconnect instance
        axi4lite_wrapper.add_instance('axi4lite_axi4lite_ic_inst', 'entity xil_defaultlib.axi4lite_axi4lite_top_ic', self.ic_ports)


        # ports for devices
        for key, val in list(self.memory_map.items()):
            #if reg.ram==True:
            if val['memory_map'][-1].ram==True:
                self.ic_ports = []
                self.ic_ports.append(Port('axi4lite_aclk',             'axi4lite_aclk'))
                self.ic_ports.append(Port('axi4lite_aresetn',          'axi4lite_aresetn'))
                self.ic_ports.append(Port('axi4lite_mosi',             'axi4lite_mosi_arr(axi4lite_mmap_get_id(id_%s))' %key))
                self.ic_ports.append(Port('axi4lite_miso',             'axi4lite_miso_arr(axi4lite_mmap_get_id(id_%s))' %key))
                self.ic_ports.append(Port('%s_%s_add'  %(key, key), 'axi4lite_%s_%s_add'                                %(key, key)))
                self.ic_ports.append(Port('%s_%s_wdat' %(key, key), 'axi4lite_%s_%s_data_in'                            %(key, key)))
                self.ic_ports.append(Port('%s_%s_rdat' %(key, key), 'axi4lite_%s_%s_data_out'                           %(key, key)))
                self.ic_ports.append(Port('%s_%s_clk'  %(key, key), 'axi4lite_%s_%s_clk'                                %(key, key)))
                self.ic_ports.append(Port('%s_%s_en'   %(key, key), 'axi4lite_%s_%s_en'                                 %(key, key)))
                self.ic_ports.append(Port('%s_%s_we'   %(key, key), 'axi4lite_%s_%s_we'                                 %(key, key)))

                # add interconnect instance
                axi4lite_wrapper.add_instance('axi4lite_%s_inst'%key, 'entity xil_defaultlib.axi4lite_%s'%key, self.ic_ports)
            else:
                self.ic_ports = []
                self.ic_ports.append(Port('axi4lite_aclk', 'axi4lite_aclk'))
                self.ic_ports.append(Port('axi4lite_aresetn', 'axi4lite_aresetn'))
                self.ic_ports.append(Port('axi4lite_mosi', 'axi4lite_mosi_arr(axi4lite_mmap_get_id(id_%s))'%key))
                self.ic_ports.append(Port('axi4lite_miso', 'axi4lite_miso_arr(axi4lite_mmap_get_id(id_%s))'%key))
                self.ic_ports.append(Port('axi4lite_%s_in_we'%key,  'axi4lite_%s_in_we'%key))
                self.ic_ports.append(Port('axi4lite_%s_in'%key,     'axi4lite_%s_in'%key))
                self.ic_ports.append(Port('axi4lite_%s_out_we'%key, 'axi4lite_%s_out_we'%key))
                self.ic_ports.append(Port('axi4lite_%s_out'%key,    'axi4lite_%s_out'%key))

                # add interconnect instance
                axi4lite_wrapper.add_instance('axi4lite_%s_inst'%key, 'entity xil_defaultlib.axi4lite_%s'%key, self.ic_ports)

        # TODO: only generate signals for in or out not both 
        # This should depend on the r/wr values of the registers
        # add assignments for axi4lite devices
        #for key, val in self.memory_map.items():
        #    for reg in val["memory_map"]:


        # add assignments
        axi4lite_wrapper.add_assign('s_axi4lite_arready',  'axi4lite_miso.arready')
        axi4lite_wrapper.add_assign('s_axi4lite_arready', 'axi4lite_miso.arready')
        axi4lite_wrapper.add_assign('s_axi4lite_awready', 'axi4lite_miso.awready')
        axi4lite_wrapper.add_assign('s_axi4lite_bresp', 'axi4lite_miso.bresp')
        axi4lite_wrapper.add_assign('s_axi4lite_bvalid', 'axi4lite_miso.bvalid')
        axi4lite_wrapper.add_assign('s_axi4lite_rdata', 'axi4lite_miso.rdata')
        axi4lite_wrapper.add_assign('s_axi4lite_rresp', 'axi4lite_miso.rresp')
        axi4lite_wrapper.add_assign('s_axi4lite_rvalid', 'axi4lite_miso.rvalid')
        axi4lite_wrapper.add_assign('s_axi4lite_wready', 'axi4lite_miso.wready')

        axi4lite_wrapper.add_assign('axi4lite_mosi.araddr', 's_axi4lite_araddr')
        axi4lite_wrapper.add_assign('axi4lite_mosi.arvalid', 's_axi4lite_arvalid')
        axi4lite_wrapper.add_assign('axi4lite_mosi.awaddr', 's_axi4lite_awaddr')
        axi4lite_wrapper.add_assign('axi4lite_mosi.awvalid', 's_axi4lite_awvalid')
        axi4lite_wrapper.add_assign('axi4lite_mosi.bready', 's_axi4lite_bready')
        axi4lite_wrapper.add_assign('axi4lite_mosi.rready', 's_axi4lite_rready') 
        axi4lite_wrapper.add_assign('axi4lite_mosi.wdata', 's_axi4lite_wdata')
        axi4lite_wrapper.add_assign('axi4lite_mosi.wstrb', 's_axi4lite_wstrb')  
        axi4lite_wrapper.add_assign('axi4lite_mosi.wvalid', 's_axi4lite_wvalid')  
        return {'axi4lite_ic_wrapper.vhdl': axi4lite_wrapper.gen_code()}
        # instantiate wrapper and add relevant ports
        # expose AXI4-Lite interface to connected to processor


class vhdlModule(object):

    def __init__(self, name='', topfile=None, comment=''):
        self.name=name
        self.libraries = {}     # libraries used in the entity 
        self.library_text = ''
        self.parameters = []    # top-level parameters
        self.ports = []         # top-level ports
        self.localparams = {}   # top-level localparams
        self.signals = []       # top-level wires
        self.instances = []     # top-level instances
        self.assigns = []       # top-level assign statements
        self.complete_text = ''

    def add_library(self, library, packages=[]):
        self.library_text += "library %s;\n" %library
        for pkg in packages:
            self.library_text += "use %s.%s.all;\n" %(library, pkg)
        self.library_text += '\n'

    def add_port(self, name, signal=None, dir='out', parent_port=False, parent_sig=True, comment=None, **kwargs):
        self.ports.append(Port(name, signal=signal, dir=dir, parent_port=parent_port, parent_sig=parent_sig, **kwargs))
        pass

    def add_parameter(self, name, value, comment=None):
        pass

    def add_signal(self, name, signal, comment=None):
        self.signals.append(Signal(name, signal))
        pass

    def add_assign(self, name, signal):
        self.assigns.append(Assign(name, signal))

    def add_entity(self, name, comment=None):
        pass

    def add_architecture(self, name, comment=None):
        pass

    def add_instance(self, name, type, ports=[], comment=None):
        self.instances.append(Instance(name, type, ports))

    def add_body(self, text, comment=None):
        pass

    def assign_signal(self, lhs, rhs, comment=None):
        pass

    def gen_file(self, filename='', output_dir=''):
        self.complete_text = self.library_text
        self.complete_text += 'entity %s is\n' %self.name
        self.complete_text += '\tport ('
        
        for port in self.ports:
            if port.width == 1:
                self.complete_text += '\n\t\t%s : %s std_logic;' %(port.name, port.dir)
            else:
                self.complete_text += '\n\t\t%s : %s std_logic_vector(%s downto 0);' %(port.name, port.dir, port.width-1)
        # remove the last semicolon
        self.complete_text = self.complete_text[:-1]
        
        self.complete_text += '\n\t);\n'
        self.complete_text += 'end entity;\n\n'
        self.complete_text += "architecture struct of %s is\n" %self.name
        
        for signal in self.signals:
            self.complete_text += '\n\t\tsignal %s : %s;' %(signal.name, signal.signal)
        # remove the last semicolon
        
        self.complete_text += '\nbegin\n\n'
        
        for instance in self.instances:
            self.complete_text += '\t%s: %s\n' %(instance.name, instance.type)
            self.complete_text += '\tport map('
            for port in instance.ports:
                self.complete_text += '\n\t\t%s => %s,'%(port.name, port.signal)
            # remove the last semicolon
            self.complete_text = self.complete_text[:-1]
            self.complete_text += '\n\t);\n\n'

        for assign in self.assigns:
            self.complete_text += '\n\t%s <= %s;' %(assign.name, assign.signal)
        
        self.complete_text += '\nend architecture;'


        #print self.complete_text
        if filename != '' and output_dir != '':
            # create file
            pass

    def gen_code(self):
        self.gen_file(self)
        return self.complete_text


class Instance(object):

    def __init__(self, name, type, ports=[]):
        self.name = name
        self.type = type
        self.ports = ports

class Assign(object):

    def __init__(self, name, signal=None):
        self.name = name
        self.signal = signal


class Port(object):
    """
    A simple class to hold port attributes. It is immutable, and will throw an error if
    multiple manipulation attempts are incompatible.
    """
    def __init__(self, name, signal=None, dir='out', parent_port=False, parent_sig=True, **kwargs):
        """
        Create a 'Port' instance.

        :param name: Name of the port
        :type port: String
        :param signal: Signal to which this port is attached
        :type signal: String
        :param parent_port: When module 'A' instantiates the module to which this port is attached, should this port be connected to a similar port on 'A'.
        :type parent_port: Boolean
        :param parent_sig: When module 'A' instantiates the module to which this port is attached, should 'A' also instantiate a signal matching the one connected to this port.
        :type parent_sig: Boolean
        :param **kwargs: Other keywords which should become attributes of this instance.

        """
        self.update_attrs(name, signal=signal, dir=dir, parent_port=parent_port, parent_sig=parent_sig, **kwargs)

    def update_attrs(self, name, signal=None, dir=dir, parent_port=False, parent_sig=True, **kwargs):
        """
        Update the attributes of this block.

        :param name: Name of the port
        :type port: String
        :param signal: Signal to which this port is attached
        :type signal: String
        :param parent_port: When module 'A' instantiates the module to which this port is attached, should this port be connected to a similar port on 'A'.
        :type parent_port: Boolean
        :param parent_sig: When module 'A' instantiates the module to which this port is attached, should 'A' also instantiate a signal matching the one connected to this port.
        :type parent_sig: Boolean
        :param **kwargs: Other keywords which should become attributes of this instance.
        """
        self.name = name.rstrip(' ')
        self.parent_sig = parent_sig and not parent_port
        self.dir =  dir
        self.parent_port = parent_port
        if type(signal) is str:
            signal.rstrip(' ')
        self.signal = signal
        for kw, val in list(kwargs.items()):
            self.__setattr__(kw, val)

class Parameter(object):
    """
    A simple class to hold parameter attributes. It is immutable, and will throw an error if
    its attributes are changed after being set.
    """
    def __init__(self, name, value, comment=None):
        """
        Create a 'Parameter' instance.

        :param name: Name of this parameter
        :type name: String
        :param value: Value this parameter should be set to.
        :type value: Varies
        :param comment: User-assisting comment string to attach to this parameter.
        :type comment: String
        """
        self.update_attrs(name, value=value, comment=comment)

    def update_attrs(self, name, value, comment=None):
        """
        Update the attributes of this block.

        :param name: Name of this parameter
        :type name: String
        :param value: Value this parameter should be set to.
        :type value: Varies
        :param comment: User-assisting comment string to attach to this parameter.
        :type comment: String
        """
        self.name = name.rstrip(' ')
        self.value = value
        if type(comment) is str:
            self.comment = comment.rstrip(' ')
        self.comment = comment

class Signal(object):
    """
    A simple class to hold signal attributes. It is immutable, and will throw an error if
    its attributes are changed after being set.
    """
    def __init__(self, name, signal='', width=0, **kwargs):
        """
        Create a 'Signal' instance.

        :param name: Name of this signal
        :type name: String
        :param signal: Name of this signal
        :type signal: String
        :param width: Bitwidth of this signal
        :type signal: Integer
        :param **kwargs: Other keywords which should become attributes of this instance.
        """
        self.update_attrs(name, signal, width=width, **kwargs)

    def update_attrs(self, name, signal, width=0, **kwargs):
        self.name  = name.rstrip(' ')
        self.width = width
        self.signal = signal
        for kw, val in list(kwargs.items()):
            self.__setattr__(kw, val)
