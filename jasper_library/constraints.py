import logging
logger = logging.getLogger('jasper.toolflow.constraints')

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

         self.portname = portname
         self.port_index = port_index
         self.iogroup = iogroup 
         self.iogroup_index = iogroup_index
         self.loc = loc
         self.iostd = iostd
         self.width = len(iogroup_index)

         if (port_index != []) and (len(port_index) != len(iogroup_index)):
             raise ValueError("Tried to constrain a multidimensional signal with iogroup  with different dimensions!")

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
    signal and the corresponding clock freq and period.
    '''
    def __init__(self, signal, name=None, freq=None, period=None):
        logger.debug('New clock constraint')
        logger.debug('  clock signal: %s'%signal)
        logger.debug('  name: %s'%name)
        logger.debug('  freq: %s'%freq)
        logger.debug('  period: %s'%period)
        self.signal = signal
        self.name = name or signal
        if not (bool(freq) ^ bool(period)):
            raise ValueError('Enter one of either freq or period')

        self.freq = float(freq or 1000./period)
        self.period = float(period or 1000./freq)

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



