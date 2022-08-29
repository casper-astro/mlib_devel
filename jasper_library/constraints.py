import logging
logger = logging.getLogger('jasper.toolflow.constraints')

class PortConstraint(object):
    """
    A class to facilitate constructing abstracted port constraints.
    
    Eg, adc_data[7:0] <=> zdok0[7:0]
    which can later be translated into physical constraints by providing
    information about a target platform.

    This assigns the port LOC and voltage constraints to user_const.xdc, for example:

    ``PortConstraint('A', 'A')`` is translated to ``set_property PACKAGE_PIN BC27 [get_ports A]`` and
    ``set_property IOSTANDARD LVCMOS18 [A]`` in the xdc file. The
    "BC27" LOC and "LVCMOS18" is determined by the platform yaml file, which contains all the platform top level
    ports and LOC assignments.
    """
    def __init__(self, portname, iogroup, port_index=[], iogroup_index=[0], loc=None, iostd=None, drive_strength=None, diff_term=None):
        """
        Construct a PortConstraint instance.

        :param portname: The name (in verilog) of the port
        :type portname: str
        :param port_index: Specify an offset of the port index to attach to iogroup[index]. This feature was added so that
            we can do (eg.) myport[3:0] <=> gpioA[3:0], myport[7:4] <=> gpioB[3:0]
        :type port_index: int
        :param iogroup: The abstract name of the ports physical connection (eg. zdok0, zdok1, gpioa)
        :type iogroup: str
        :param iogroup_index: The index of the abstract name to which the HDL port should connect
        :type iogroup_index: int or list
        :param loc: Specify a loc to construct a physical constraint, forgoing the abstract names. Experimental.
        :type loc: list
        :param iostd: Specify an iostd to construct a physical constraint, forgoing the abstract names. Experimental.
        :type loc: list
        :param drive_strength: Specify a drive strength to construct a physical constraint, forgoing the abstract names. Experimental.
        :type loc: list of ints
        :param diff_term: specify the use of internal 100 ohm termination for lvds pins. set to `TERM_100` or `TERM_NONE` (default). Experimental.
        :type diff_term: list of str
        """
        logger.debug('new PortConstraint:')
        logger.debug('  portname: %s'%portname)
        logger.debug('  iogroup: %s'%iogroup)
        logger.debug('  port_index: %s'%port_index)
        logger.debug('  iogroup_index: %s'%iogroup_index)
        logger.debug('  loc: %s'%loc)
        logger.debug('  iostd: %s'%iostd)
        logger.debug('  drive_strength: %s'%drive_strength)
        logger.debug('  diff_term: %s'%diff_term)

        if port_index == []:
            self.is_vector = False
        else:
            self.is_vector = True

        # In Python3  range(x,y) returns a range instance, not a list.
        # Deal with that here so the user doesn't have to
        if isinstance(port_index, range): port_index = list(port_index)
        if isinstance(iogroup_index, range): iogroup_index = list(iogroup_index)
        if isinstance(loc, range): loc = list(loc)
        if isinstance(iostd, range): iostd = list(iostd)
        if isinstance(drive_strength, range): drive_strength = list(drive_strength)
        if isinstance(diff_term, range): diff_term = list(diff_term)

        if type(port_index) != list: port_index = [port_index]
        if type(iogroup_index) != list: iogroup_index = [iogroup_index]
        if type(loc) != list: loc = [loc]
        if type(iostd) != list: iostd = [iostd]
        if type(drive_strength) != list: drive_strength = [drive_strength]
        if type(diff_term) != list: diff_term = [diff_term]

        self.portname = portname.strip(' ') #clear out whitespace
        self.port_index = port_index
        self.iogroup = iogroup.strip(' ') 
        self.iogroup_index = iogroup_index
        self.loc = loc
        self.iostd = iostd
        self.drive_strength = drive_strength
        self.width = len(iogroup_index)
        self.diff_term = diff_term

        if (port_index != []) and (len(port_index) != len(iogroup_index)):
            raise ValueError("Tried to constrain a multidimensional signal with iogroup with different dimensions!")

        if self.loc == [None]:
            self.loc *= self.width
        elif len(self.loc) != self.width:
            raise ValueError("Tried to constrain a multidimensional signal with a list of LOCs with different dimensions!")

        if len(self.iostd) == 1:
            self.iostd *= self.width
        elif len(self.iostd) != self.width:
            raise ValueError("Tried to constrain a multidimensional signal with a list of IOSTDs with different dimensions!")

        if len(self.drive_strength) == 1:
            self.drive_strength *= self.width
        elif len(self.drive_strength) != self.width:
            raise ValueError("Tried to constrain a multidimensional signal with a list of drive strengths with different dimensions!")

        if len(self.diff_term) == 1:
            self.diff_term *= self.width
        elif len(self.diff_term) != self.width:
            raise ValueError("Tried to constrain a multidimensional signal with a list of differential terminations with different dimensions!")


    def __str__(self):
        """
        A user friendly string representation
        """
        return self.portname

    def gen_physical_const(self, platform):
        """
        Set the LOC and IOSTDs of an abstract constraint for a given platform.

        :param platform: The platform instance against which to evaluate the constraint(s).
        :type platform: Platform
        """
        logger.debug('Attempting to get physical constraints for port %s on %s '%(self.portname, self.iogroup))
        pins = platform.get_pins(self.iogroup, index=self.iogroup_index)
        for i in range(self.width):
            if self.loc[i] is None:
                logger.debug('Setting pin loc: %s %s'%(self.portname, pins[i].loc))
                self.loc[i] = pins[i].loc
            if self.iostd[i] is None:
                logger.debug('Setting pin iostd: %s %s'%(self.portname, pins[i].iostd))
                self.iostd[i] = pins[i].iostd
            if self.drive_strength[i] is None:
                logger.debug('Setting pin drive_strength: %s %s'%(self.portname, pins[i].drive_strength))
                self.drive_strength[i] = pins[i].drive_strength
         
class ClockConstraint(object):
    """
    A clock constraint -- simply holds the name of the clock
    signal, clock name, whether clock source is get_ports or get_pins, whether a virtual clock, waveform parameters for
    duty cycle and the corresponding clock freq and period.

    This assigns the clock timing constraint on the clock port in user_const.xdc, for example:

    ``ClockConstraint('A','A', period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))``
    is translated to ``create_clock -period 6.400 -name A -waveform {0.000 3.200} [get_ports {A}]`` in the xdc file. 

    This tells Vivado which ports should be clocks.
    """
    def __init__(self, signal=None, name=None, freq=None, period=None, port_en=True, virtual_en=False, waveform_min=0., waveform_max=None):
        """
        Construct a ClockConstraint instance.

        :param signal: The signal name of the clock port
        :type signal: str
        :param name: The name of the clock
        :type name: str
        :param freq: The clock frequency in MHz (no need to specify period if the frequency is specified)
        :type freq: float
        :param period: The period of the clock in ns (no need to specify frequency if the period is specified)
        :type period: float
        :param port_en: If True then the clock port is enabled. If False then the clock port is bypassed for the case of
            a virtual clock.
        :type port_en: boolean
        :param virtual_en: This is set to True when using a virtual clock, otherwise it is False.
        :type virtual_en: bool
        :param waveform_min: This parameter is used to determine the duty cycle of the clock in ns. Typically 0ns.
        :type waveform_min: float
        :param waveform_max: This parameter is used to determine the duty cycle of the clock in ns. Typically half the
            period of the clock for a 50% duty cycle.
        :type waveform_max: float
        """
        logger.debug('New clock constraint')
        logger.debug('clock signal: %s'%signal)
        logger.debug('name: %s'%name)
        logger.debug('freq: %s'%freq)
        logger.debug('period: %s'%period)
        logger.debug('port_en: %s'%port_en)
        logger.debug('waveform_min: %s'%waveform_min)
        logger.debug('waveform_max: %s'%waveform_max)
        logger.debug('virtual_en: %s' % virtual_en)
        self.signal = signal
        self.name = name or signal + '_CLK'
        if not (bool(freq) ^ bool(period)):
            raise ValueError('Enter one of either freq or period')
        self.freq = float(freq or 1000./period)
        self.period = float(period or 1000./freq)
        self.port_en = port_en
        self.waveform_min = float(waveform_min)
        if waveform_max is not None:
            self.waveform_max = float(waveform_max)
        else:
            self.waveform_max = self.period / 2.
        self.virtual_en = virtual_en

class GenClockConstraint(object):
    """
    A clock generation constraint -- simply holds the name of the clock
    signal, clock name, clock source and divide by value.

    This assigns the generated clock timing constraint on a non global clock port in user_const.xdc, for example:

    ``GenClockConstraint(signal='sub/Q', name='sub/CLK', divide_by=16, clock_source='sub/C')``
    is translated to ``create_generated_clock -name sub/CLK -source [get_pins {sub/C}] -divide_by 16
    [get_pins {sub/Q}]`` in the xdc file. 
    
    This constraint is used to assign a clock to signals that are not inferred by Vivado naturally and should be.
    """
    def __init__(self, signal, name=None, divide_by=None, clock_source=None):
        """
        Construct a GenClockConstraint instance.

        :param signal: The signal name that is required to be a clock
        :type signal: str
        :param name: The name of the generated clock
        :type name: str
        :param divide_by: The value to divide the clock_source by in order to determine the clock frequency of the
            generated clock in MHz
        :type divide_by: int
        :param clock_source: This is the clock source (input) of the generated clock. The clock_source and the
            divide_by value determined the generated clock out frequency in MHz:
            generated clock in MHz = clock_source*divide_by
        :type clock_source: str
        """

        logger.debug('New Generated clock constraint')
        logger.debug('clock signal: %s'%signal)
        logger.debug('name: %s'%name)
        logger.debug('divide_by: %s'%divide_by)
        logger.debug('clock source: %s'%clock_source)
        self.signal = signal
        self.name = name or signal + '_CLK'
        self.divide_by = int(divide_by)
        self.clock_source = clock_source

class ClockGroupConstraint(object):
    """
    A clock group constraint -- simply holds the name of both clock domains and the domain relationship e.g. asynchronous

    This assigns the clock group timing constraint on two or more clock groups in user_const.xdc, for example:

    ``ClockGroupConstraint('A', 'B', 'asynchronous')`` is translated to
    ``set_clock_groups -asynchronous -group [get_clocks A] -group [get_clocks B]`` in the xdc file. 
    
    This constraint is used to cut the clock relationship between two or more clock groups.
    """
    def __init__(self, clock_name_group_1=None, clock_name_group_2=None, clock_domain_relationship=None):
        """
        Construct a ClockGroupConstraint instance.

        :param clock_name_group_1: The clock name of the first group e.g. the clock port name or virtual clock name
        :type clock_name_group_1: str
        :param clock_name_group_2: The clock name of the second group e.g. the clock port name or virtual clock name
        :type clock_name_group_2: str
        :param clock_domain_relationship: This specifies the relationship between the two clock name groups. Typically
            this is set to ``asynchronous`` which tells the Vivado timing analyzer to ignore the timing relationship
            between these two clock domains, as the clocks are asynchronous.
        :type clock_domain_relationship: str
        """

        logger.debug('New clock group constraint')
        logger.debug('clock name group 1: %s'%clock_name_group_1)
        logger.debug('clock name group 2: %s'%clock_name_group_2)
        logger.debug('clock domain relationship: %s'%clock_domain_relationship)
        self.clock_name_group_1 = clock_name_group_1
        self.clock_name_group_2 = clock_name_group_2
        self.clock_domain_relationship = clock_domain_relationship

class InputDelayConstraint(object):
    """
    An input delay constraint - simply holds the name of the reference clock, constraint type (min or max), constraint
    delay value (ns), whether an existing constraint exists and a new one needs to be added and the port name that the
    constraint applies to.

    This assigns the clock input delay timing constraint in user_const.xdc, for example:
    ``InputDelayConstraint(clkname='A', consttype='min', constdelay_ns=1.0, add_delay_en=True, portname='B')`` is
    translated to
    ``set_input_delay -clock [get_clocks A] -min -add_delay 1.000 [get_ports {B}]`` in the xdc file. 
    
    This constraint is used to assign input constraints referenced to the clock.
    """
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
        """
        Construct a InputDelayConstraint instance.

        :param clkname: The clock name which the port name is referenced to
        :type clkname: str
        :param consttype: This is constraint type: either be a ``min`` (hold) or ``max`` (setup).
        :type consttype: str
        :param constdelay_ns: This is the constraint delay in ns - takes into account the Tco, clock skew and board
            delay.
        :type constdelay_ns: float
        :param add_delay_en: If more than one constraint is needed on the portname then this is True, else set it to
            False.
        :type add_delay_en: bool
        :param portname: The port name of the signal that needs to be constrained.
        :type portname: str
        """

        logger.debug('New input delay constraint')
        logger.debug('clock name: %s'%clkname)
        logger.debug('constraint type: %s'%consttype)
        logger.debug('constraint delay: %s'%constdelay_ns)
        logger.debug('add delay enabled: %s'%add_delay_en)
        logger.debug('port name: %s'%portname)
        self.clkname = clkname
        self.consttype = consttype
        self.constdelay_ns = constdelay_ns
        self.add_delay_en = add_delay_en
        self.portname = portname

class OutputDelayConstraint(object):
    """
    An output delay constraint - simply holds the name of the reference clock, constraint type (min or max), constraint
    delay value (ns), whether an existing constraint exists and a new one needs to be added and the port name that the
    constraint applies to.

    This assigns the clock output delay timing constraint in user_const.xdc, for example:

    ``OutputDelayConstraint(clkname='A', consttype='min', constdelay_ns=1.0, add_delay_en=True, portname='B')`` is
    translated to
    ``set_output_delay -clock [get_clocks A] -min -add_delay 1.000 [get_ports {B}]`` in the xdc file. 
    
    This constraint is used to assign output constraints referenced to the clock.
    """
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
        """
        Construct a OutputDelayConstraint instance.

        :param clkname: The clock name which the port name is referenced to
        :type clkname: str
        :param consttype: This is constraint type: either be a ``min`` (hold) or ``max`` (setup).
        :type consttype: str
        :param constdelay_ns: This is the constraint delay in ns - takes into account the Tsu, Th, clock skew and board
            delay.
        :type constdelay_ns: float
        :param add_delay_en: If more than one constraint is needed on the portname then this is True, else set it to
            False.
        :type add_delay_en: bool
        :param portname: The port name of the signal that needs to be constrained.
        :type portname: str
        """

        logger.debug('New output delay constraint')
        logger.debug('clock name: %s'%clkname)
        logger.debug('constraint type: %s'%consttype)
        logger.debug('constraint delay: %s'%constdelay_ns)
        logger.debug('add delay enabled: %s'%add_delay_en)
        logger.debug('port name: %s'%portname)
        self.clkname = clkname
        self.consttype = consttype
        self.constdelay_ns = constdelay_ns
        self.add_delay_en = add_delay_en
        self.portname = portname

class MaxDelayConstraint(object):
    """
    A set max delay constraint - simply holds the source, destination paths and the constraint
    delay value (ns).

    This assigns the max delay timing constraint in user_const.xdc, for example:
    ``MaxDelayConstraint(destpath='[get_ports {A}]', constdelay_ns=1.0)`` is translated to
    ``set_max_delay 1.0 -to [get_ports {A}]`` in the xdc file. 
    
    This constraint is used when there is no clock reference.
    """
    def __init__(self, sourcepath=None, destpath=None , constdelay_ns=None):
        """
        Construct a MaxDelayConstraint instance.

        :param sourcepath: The source path that the constraint is applied to - includes path and port names.
        :type sourcepath: str
        :param destpath: The destination path that the constraint is applied to  - includes path and port names.
        :type destpath: str
        :param constdelay_ns: This is the constraint delay in ns - takes into account the Tsu, clock skew and board
            delay.
        :type constdelay_ns: float
        """

        logger.debug('New set max delay constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        logger.debug('constraint delay: %s'%constdelay_ns)
        self.sourcepath = sourcepath
        self.destpath = destpath
        self.constdelay_ns = constdelay_ns

class MinDelayConstraint(object):
    """
    A set min delay constraint - simply holds the source, destination paths and the constraint
    delay value (ns).
 
    This assigns the min delay timing constraint in user_const.xdc, for example:

    ``MinDelayConstraint(destpath='[get_ports {A}]', constdelay_ns=1.0)`` is translated to
    ``set_min_delay 1.0 -to [get_ports {A}]`` in the xdc file. 
    
    This constraint is used when there is no clock reference.
    """
    def __init__(self, sourcepath=None, destpath=None , constdelay_ns=None):
        """
        Construct a MinDelayConstraint instance.

        :param sourcepath: The source path that the constraint is applied to - includes path and port names.
        :type sourcepath: str
        :param destpath: The destination path that the constraint is applied to  - includes path and port names.
        :type destpath: str
        :param constdelay_ns: This is the constraint delay in ns - takes into account the Th, clock skew and board
            delay.
        :type constdelay_ns: float
        """

        logger.debug('New set max delay constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        logger.debug('constraint delay: %s'%constdelay_ns)
        self.sourcepath = sourcepath
        self.destpath = destpath
        self.constdelay_ns = constdelay_ns

class FalsePathConstraint(object):
    """
    A false path constraint - simply holds the source and destination paths.

    This assigns the false path timing constraint in user_const.xdc, for example:
    
    ``FalsePathConstraint(destpath='[get_ports {A}]')`` is translated to
    ``set_false_path -to [get_ports {A}]`` in the xdc file. 
    
    Any path that appears in the FalsePathConstraint is ignored by the Vivado timing analyzer.
    """
    def __init__(self, sourcepath=None, destpath=None):
        """
        Construct a FalsePathConstraint instance.

        :param sourcepath: The source path that the constraint is applied to - includes path and port names.
        :type sourcepath: str
        :param destpath: The destination path that the constraint is applied to  - includes path and port names.
        :type destpath: str
        """

        logger.debug('New false path constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        self.sourcepath = sourcepath
        self.destpath = destpath

class MultiCycleConstraint(object):
    """
    A multi cycle constraint - simply holds the multi cycle type (steup or hold), source, destination paths and
    multi cycle delay value in clock cycles.

    This assigns the multicycle timing constraint in user_const.xdc, for example:

    ``MultiCycleConstraint(multicycletype='setup',sourcepath='get_clocks B', destpath='get_ports A', multicycledelay=4)``
    is translated to ``set_multicycle_path -setup -from [get_ports A] -to [get_clocks B] 4`` in the xdc file. 
    
    This tells the Vivado timing analyzer that the signal will take more than one clock cycle to propagate through the logic.
    """
    def __init__(self, multicycletype=None, sourcepath=None, destpath=None, multicycledelay=None):
        """
        Construct a MultiCycleConstraint instance.

        :param multicycletype: The type of multicycle constraint: either ``setup`` or ``hold``
        :type multicycletype: str
        :param sourcepath: The source path that the constraint is applied to - includes path and port names.
        :type sourcepath: str
        :param destpath: The destination path that the constraint is applied to  - includes path and port names.
        :type destpath: str
        :param multicycledelay: This represents the number of clock cycles to delay.
        :type multicycledelay: int
        """
        logger.debug('New Multi Cycle constraint')
        logger.debug('Multi cycle type: %s'%multicycletype)
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        logger.debug('multi cycle delay: %d' % multicycledelay)
        self.multicycletype = multicycletype
        self.sourcepath = sourcepath
        self.destpath = destpath
        self.multicycledelay = multicycledelay

class RawConstraint(object):
    """
    A class for raw constraints -- strings to be dumper unadulterated into a
    constraint file.

    This assigns any raw constraints (set_property, pblock etc) in user_const.xdc, for example:

    ``RawConstraint('set_property OFFCHIP_TERM NONE [get_ports A]')``
    is translated to ``set_property OFFCHIP_TERM NONE [get_ports A]`` in the xdc file. 
    
    Any constraint not handled in the above classes can be added using the raw constraints.
    """
    def __init__(self, const):

        """
        Construct a RawConstraint instance.

        :param const: This represents the path with port names that the constraint is applied to
        :type const: str
        """

        if const.endswith('\n'):
           self.raw = const
        else:
           self.raw = const + '\n'



