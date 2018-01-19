import yaml

class Castro(object):
    '''
    Stores complete generic structure design information
    '''
    def __init__(self, design_name, src_files, ips=[], mm_slaves=[], temp_fpga_model=''):
        # the version of this class
        self.version = '0.0.0'
        # the name of the design
        self.design_name = design_name
        # a list of all hdl files used in the design
        self.src_files = src_files
        # a list of all IPs, a list of {path, name, vendor, library, version} dictionaries pairs
        self.ips = ips
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
    def __init__(self, platform_name='', fpga_manufacturer='', fpga_model='', synth_tool='', pin_map=[],
                 vendor_constraints_files='', pin_constraints=[], clk_constraints=[], gen_clk_constraints=[],
                 clk_grp_constraints=[], input_delay_constraints = [], output_delay_constraints=[],
                 max_delay_constraints=[], min_delay_constraints=[], multi_cycle_constraints =[],
                 false_path_constraints=[], raw_constraints=[], temp_fpga_model='', temp_quartus_qsf_files=[]):
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
        # a list of pin constraint objects
        self.pin_constraints = pin_constraints # The top level entity I/O ports (note: @ASTRON these match the symbolic FPGA pin names)
        # a list of clock constraint objects
        self.clk_constraints = clk_constraints
        # a list of generate clock constraint objects
        self.gen_clk_constraints = gen_clk_constraints
        # a list of clock group constraint objects
        self.clk_grp_constraints = clk_grp_constraints
        # a list of input delay constraint objects
        self.input_delay_constraints = input_delay_constraints
        # a list of output delay constraint objects
        self.output_delay_constraints = output_delay_constraints
        # a list of output delay constraint objects
        self.max_delay_constraints = max_delay_constraints
        # a list of output delay constraint objects
        self.min_delay_constraints = min_delay_constraints
        # a list of false path constraint objects
        self.false_path_constraints = false_path_constraints
        # a list of multi cycle constraint objects
        self.multi_cycle_constraints = multi_cycle_constraints
        # a list of raw_constraint objects
        self.raw_constraints = raw_constraints
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
    def __init__(self, portname, period_ns, freq_mhz=100, clkname=None, waveform_min_ns=None, waveform_max_ns=None, port_en=True, virtual_en=False):
        # clock port name
        self.portname = portname
        # clock frequency in MHz
        self.freq_mhz = freq_mhz
        # clock period in nano seconds
        self.period_ns = period_ns
        # Clock name
        self.clkname = clkname
        # Duty Cycle Waveform minimum in nano seconds
        self.waveform_min_ns = waveform_min_ns
        # Duty Cycle Waveform maximum in nano seconds
        self.waveform_max_ns = waveform_max_ns
        # Parameter to determine if clock source is get_ports or get_pins
        self.port_en = port_en
        # Parameter to determine if virtual clock is being used
        self.virtual_en = virtual_en


class GenClkConstraint(object):
    '''
    Class to hold a generated clock constraint.
    '''
    def __init__(self, pinname, clkname=None, divide_by=None, clksource=None):
        # generated clock signal
        self.pinname = pinname
        # clock name
        self.clkname = clkname
        # clock division value based on clock source (self.signal = self.clksource/self.divide_by)
        self.divide_by = divide_by
        # clock source
        self.clksource = clksource

class ClkGrpConstraint(object):
    '''
    Class to hold a clock group constraint.
    '''
    def __init__(self, clknamegrp1=None, clknamegrp2=None, clkdomaintype=None):
        #Clock name group 1
        self.clknamegrp1 = clknamegrp1
        #Clock name group 2
        self.clknamegrp2 = clknamegrp2
        #Clock domain relationship e.g. asynchronous
        self.clkdomaintype = clkdomaintype

class InDelayConstraint(object):
    '''
    Class to hold an Input Delay constraint.
    '''
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
        #Clock reference name
        self.clkname = clkname
        #constraint type - setup/hold (max/min)
        self.consttype = consttype
        #constraint input delay in ns (Tco)
        self.constdelay_ns = constdelay_ns
        #determines whether another constraint needs to be added on top of an existing constraint
        self.add_delay_en = add_delay_en
        #The name of the port that the constraint is applied to
        self.portname = portname

class OutDelayConstraint(object):
    '''
    Class to hold an Output Delay constraint.
    '''
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
        #Clock reference name
        self.clkname = clkname
        #constraint type - setup/hold (max/min)
        self.consttype = consttype
        #constraint output delay in ns (Tsu/Th)
        self.constdelay_ns = constdelay_ns
        #determines whether another constraint needs to be added on top of an existing constraint
        self.add_delay_en = add_delay_en
        #The name of the port that the constraint is applied to
        self.portname = portname

class MaxDelayConstraint(object):
    '''
    Class to hold a Max Delay constraint.
    '''
    def __init__(self, sourcepath=None, destpath=None, constdelay_ns=None):
        #False path source path
        self.sourcepath = sourcepath
        #False path dest path
        self.destpath = destpath
        #constraint output delay in ns (Tsu/Th)
        self.constdelay_ns = constdelay_ns

class MinDelayConstraint(object):
    '''
    Class to hold a Min Delay constraint.
    '''
    def __init__(self, sourcepath=None, destpath=None, constdelay_ns=None):
        #False path source path
        self.sourcepath = sourcepath
        #False path dest path
        self.destpath = destpath
        #constraint output delay in ns (Tsu/Th)
        self.constdelay_ns = constdelay_ns

class FalsePthConstraint(object):
    '''
    Class to hold a false path constraint.
    '''
    def __init__(self, sourcepath=None, destpath=None):
        #False path source path
        self.sourcepath = sourcepath
        #False path dest path
        self.destpath = destpath

class MultiCycConstraint(object):
    '''
    Class to hold a multi cycle constraint.
    '''
    def __init__(self, multicycletype=None, sourcepath=None, destpath=None, multicycledelay=None):
        #Multi cycle type (setup or hold)
        self.multicycletype = multicycletype
        #Multi cycle source path
        self.sourcepath = sourcepath
        #Multi cycle dest path
        self.destpath = destpath
        #Multi cycle delay (cycles)
        self.multicycledelay = multicycledelay


class RawConstraint(object):
    '''
    Class to hold raw constraints. These are really against
    the spirit of castro, since they are tool-specific.
    But, being pragmatic, sometimes they are necessary to
    encode simple constraints, for highly technology-specific features.
    The contents of these is not defined by castro.
    '''
    def __init__(self, raw):
        # raw constraint
        self.raw = raw
