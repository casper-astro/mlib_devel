import logging
logger = logging.getLogger('jasper.toolflow.constraints')

# Declaring Maximum packet size for upload_to_ram in casperfpga
# - This is
MAX_IMAGE_CHUNK_SIZE = 1988


class PortConstraint(object):
     '''
     A class to facilitate constructing abstracted port constraints.
     Eg, adc_data[7:0] <=> zdok0[7:0]
     which can later be translated into physical constraints by providing
     information about a target platform.
     '''
     def __init__(self, portname, iogroup, port_index=[], iogroup_index=[0], loc=None, iostd=None):
         '''
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
         '''
         logger.debug('new PortConstraint:')
         logger.debug('  portname: %s'%portname)
         logger.debug('  iogroup: %s'%iogroup)
         logger.debug('  port_index: %s'%port_index)
         logger.debug('  iogroup_index: %s'%iogroup_index)
         logger.debug('  loc: %s'%loc)
         logger.debug('  iostd: %s'%iostd)

         if port_index == []:
             self.is_vector = False
         else:
             self.is_vector = True

         if type(port_index) != list: port_index = [port_index]
         if type(iogroup_index) != list: iogroup_index = [iogroup_index]
         if type(loc) != list: loc = [loc]
         if type(iostd) != list: iostd = [iostd]

         self.portname = portname.strip(' ') #clear out whitespace
         self.port_index = port_index
         self.iogroup = iogroup.strip(' ') 
         self.iogroup_index = iogroup_index
         self.loc = loc
         self.iostd = iostd
         self.width = len(iogroup_index)

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

     def __str__(self):
         '''
         A user friendly string representation
         '''
         return self.portname

     def gen_physical_const(self,platform):
         '''
         Set the loc and iostds of an abstract constraint for a given platform.

         :param platform: The platform instance against which to evaluate the constraint(s).
         :type platform: Platform
         '''
         logger.debug('Attempting to get physical constraints for port %s on %s '%(self.portname, self.iogroup))
         pins = platform.get_pins(self.iogroup, index=self.iogroup_index)
         for i in range(self.width):
             if self.loc[i] is None:
                 logger.debug('Setting pin loc: %s %s'%(self.portname, pins[i].loc))
                 self.loc[i] = pins[i].loc
             if self.iostd[i] is None:
                 logger.debug('Setting pin iostd: %s %s'%(self.portname, pins[i].iostd))
                 self.iostd[i] = pins[i].iostd
         
class ClockConstraint(object):
    '''
    A clock constraint -- simply holds the name of the clock
    signal, clock name, whether clock source is get_ports or get_pins, whether a virtual clock, waveform parameters for
    duty cycle and the corresponding clock freq and period.
    '''
    def __init__(self, signal=None, name=None, freq=None, period=None, port_en=True, virtual_en=False, waveform_min=0., waveform_max=None):
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
    '''
    A clock generation constraint -- simply holds the name of the clock
    signal, clock name, clock source and divide by value.
    '''
    def __init__(self, signal, name=None, divide_by=None, clock_source=None):
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
    '''
    A clock group constraint -- simply holds the name of both clock domains and the domain relationship e.g. asynchronous
    '''
    def __init__(self, clock_name_group_1=None, clock_name_group_2=None, clock_domain_relationship=None):
        logger.debug('New clock group constraint')
        logger.debug('clock name group 1: %s'%clock_name_group_1)
        logger.debug('clock name group 2: %s'%clock_name_group_2)
        logger.debug('clock domain relationship: %s'%clock_domain_relationship)
        self.clock_name_group_1 = clock_name_group_1
        self.clock_name_group_2 = clock_name_group_2
        self.clock_domain_relationship = clock_domain_relationship

class InputDelayConstraint(object):
    '''
    An input delay constraint - simply holds the name of the reference clock, constraint type (min or max), constraint
    delay value (ns), whether an existing constraint exists and a new one needs to be added and the port name that the
    constraint applies to.
    '''
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
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
    '''
    An output delay constraint - simply holds the name of the reference clock, constraint type (min or max), constraint
    delay value (ns), whether an existing constraint exists and a new one needs to be added and the port name that the
    constraint applies to.
    '''
    def __init__(self, clkname=None, consttype=None, constdelay_ns=None, add_delay_en=None, portname=None ):
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
    '''
    A set max delay constraint - simply holds the source, destination paths and the constraint
    delay value (ns).
    '''
    def __init__(self, sourcepath=None, destpath=None , constdelay_ns=None):
        logger.debug('New set max delay constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        logger.debug('constraint delay: %s'%constdelay_ns)
        self.sourcepath = sourcepath
        self.destpath = destpath
        self.constdelay_ns = constdelay_ns

class MinDelayConstraint(object):
    '''
    A set min delay constraint - simply holds the source, destination paths and the constraint
    delay value (ns).
    '''
    def __init__(self, sourcepath=None, destpath=None , constdelay_ns=None):
        logger.debug('New set max delay constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        logger.debug('constraint delay: %s'%constdelay_ns)
        self.sourcepath = sourcepath
        self.destpath = destpath
        self.constdelay_ns = constdelay_ns

class FalsePathConstraint(object):
    '''
    A false path constraint - simply holds the source and destination paths.
    '''
    def __init__(self, sourcepath=None, destpath=None):
        logger.debug('New false path constraint')
        logger.debug('source path: %s'%sourcepath)
        logger.debug('destination path: %s'%destpath)
        self.sourcepath = sourcepath
        self.destpath = destpath

class MultiCycleConstraint(object):
    '''
    A multi cycle constraint - simply holds the multi cycle type (steup or hold), source, destination paths and
    multi cycle delay value in clock cycles.
    '''
    def __init__(self, multicycletype=None, sourcepath=None, destpath=None, multicycledelay=None):
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
    '''
    A class for raw constraints -- strings to be dumper unadulterated into a
    constraint file
    '''
    def __init__(self, const):
       if const.endswith('\n'):
           self.raw = const
       else:
           self.raw = const + '\n'



