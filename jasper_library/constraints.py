class PortConstraint(object):
     '''
     A class to facilitate constructing abstracted port constraints.
     Eg, adc_data[7:0] <=> zdok0[7:0]
     which can later be translated into physical constraints by providing
     information about a target platform.
     '''
     def __init__(self, portname, iogroup, port_index=0, iogroup_index=0, loc=None, iostd=None):
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
         self.portname = portname
         self.port_index = port_index
         self.iogroup = iogroup 
         self.iogroup_index = iogroup_index
         self.loc = loc
         self.iostd = iostd

         if not type(port_index) == type(iogroup_index):
             raise TypeError('port_index (%s) / iogroup_index (%s) type mismatch!'%(type(port_index), type(iogroup_index)))
         else:
             if isinstance(port_index,list):
                 self.is_vector = True
                 self.width = len(port_index)
                 if len(port_index) != len(iogroup_index):
                     raise ValueError("Tried to constrain a multidimensional signal with iogroup  with different dimensions!")
             else:
                 self.is_vector = False
                 self.width = 1


         if loc is not None:
             if self.is_vector:
                 try:
                     if len(loc) != len(port_index):
                         raise ValueError("Tried to constrain a multidimensional signal with a list of LOCs with different dimensions!")
                 except TypeError:
                     raise TypeError("Tried to constrain a mulidimensional signal with LOCs of type %s"%type(loc))


         if iostd is not None:
             if self.is_vector:
                 if not isinstance(iostd,list):
                     self.iostd = [iostd]*len(port_index)
                 elif len(iostd) != len(port_index):
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
         pins = platform.get_pin(self.iogroup, index=self.iogroup_index)
         if type(pins) is list:
             #if self.loc is None:
                 self.loc = [pin.loc for pin in pins]
             #if self.iostd is None:
                 self.iostd = [pin.iostd for pin in pins]
         else:
             #if self.loc is None:
                 self.loc = pins.loc
             #if self.iostd is None:
                 self.iostd = pins.iostd
         
class ClockConstraint(object):
    '''
    A clock constraint -- simply holds the name of the clock
    signal and the corresponding clock freq and period.
    '''
    def __init__(self, clocksig, name=None, freq=None, period=None):
        self.signal = clocksig
        self.name = name or clocksig
        if not (bool(freq) ^ bool(period)):
            raise ValueError('Enter one of either freq or period')

        self.freq = float(freq or 1000./period)
        self.period = float(period or 1000./freq)



