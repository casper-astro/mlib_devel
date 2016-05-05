import yaml

class Castro(object):
    '''
    Stores complete generic structure design information
    '''
    def __init__(self, design_name, src_files, mm_slaves=[], temp_fpga_model=''):
        # the version of this class
        self.version = '0.0.0'
        # the name of the design
        self.design_name = design_name
        # a list of all hdl files used in the design
        self.src_files = src_files
        # a list of mm_slave objects
        self.mm_slaves = mm_slaves

    def dump(self, filename):
        '''
        saves this class object to a yaml file
        '''
        with open(filename, 'w') as fh:
            fh.write(yaml.dump(self))

    @staticmethod
    def load(filename):
        '''
        loads this class object from a yaml file and assert that it is of type Castro
        '''
        with open(filename, 'r') as fh:
            c = yaml.load(fh)
            assert isinstance(c, Castro)
            return c

class Synthesis(object):
    '''
    A class to specify all the synthesis specific attributes of the design
    '''
    def __init__(self, platform_name='', fpga_manufacturer='', fpga_model='', synth_tool='', pin_map=[], vendor_constraints_files='', pin_constraints=[], clk_constraints=[], temp_fpga_model='', temp_quartus_qsf_files=[]): 
        # name of the platform Roach, Snap, Uniboard, ..
        self.platform_name = platform_name  # Roach, Snap, UniBoard, ..
        # name of the fpga manufacturer Xilinx/Altera
        self.fpga_manufacturer = fpga_manufacturer
        # model number of the fpga including speed grade?
        self.fpga_model = fpga_model
        # tool to use for synthesis
        self.synth_tool = synth_tool
        # symbolic names for the FPGA pins
        self.pin_map = pin_map # Symbolic names for the FPGA pins
        # a list of vendor specific constraints files (timing, area or pin)
        self.vendor_constraints_files = vendor_constraints_files
        # a list of pin_constraint objects
        self.pin_constraints = pin_constraints # The top level entity I/O ports (note: @ASTRON these match the symbolic FPGA pin names)
        # a list of clk_constraint objects
        self.clk_constraints = clk_constraints
        # Temporary attribs required for RadioHDL backend. 
        self.temp_fpga_model = temp_fpga_model
        self.temp_quartus_qsf_files = temp_quartus_qsf_files

    def resolve_constraint(self, constraint):
        """
        Ensure constraint targets existing platform constraints
        """
        pass

class mm_slave(object):
    """
    JASPER: A list of elements of this class gets merged with the bitsream
    """
    def __init__(self, name, mode, base_address, span):
        self.name = name
        self.mode = mode # Two bits indicate RD,WR
        self.base_address = base_address # Bytes
        self.span = span # Bytes
        self.high_address = base_address+span

class PinConstraint(object):
    '''
    Class to hold a pin constraint
    '''
    def __init__(self, portname, symbolic_name, portname_indices=None, symbolic_indices=None, location='', drive_strength=0, slew_rate=0, io_standard='', termination=''):
        # toplevel portname
        self.portname = portname # HDL Top level entity port name
        # symbolic name for a pin
        self.symbolic_name = symbolic_name # Symbolic FPGA pint name (@ASTRON this matches self.portname)
        # port indice/s, if the port is a vector
        self.portname_indices = portname_indices
        # sybolic name indice/s, if the port is a vector
        self.symbolic_indices = symbolic_indices
        # pin physical location e.g. YE33
        self.location = location
        # pin drive strength
        self.drive_strength = drive_strength
        # pin slew rate
        self.slew_rate = slew_rate
        # pin io standard
        self.io_standard = io_standard
        # pin termination
        self.termination = termination

class ClkConstraint(object):
    '''
    Class to hold a clock constraint
    '''
    def __init__(self, portname, period_ns, freq_mhz=100):
        # clock port name
        self.portname = portname
        # clock frequency in MHz
        self.freq_mhz = freq_mhz
        # clock period in nano seconds
        self.period_ns = period_ns
