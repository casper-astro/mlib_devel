class PortConstraint(object):
     '''
     A class to facilitate constructing abstracted port constraints.
     Eg, adc_data[7:0] <=> zdok0[7:0]
     which can later be translated into physical constraints by providing
     information about a target platform.
     '''
     def __init__(self, portname=None, iogroup=None, index=None, loc=None, iostd=None):
         '''
         Construct a PortConstraint instance.

         :param portname: The name (in verilog) of the port
         :type portname: str
         :param iogroup: The abstract name of the ports physical connection (eg. zdok0, zdok1, gpioa)
         :type iogroup: str
         :param index: The index of the abstract name to which the HDL port should connect
         :type index: int or list
         :param loc: Specify a loc to construct a physical constraint, forgoing the abstract names. Experimental.
         :type loc: list
         :param iostd: Specify an iostd to construct a physical constraint, forgoing the abstract names. Experimental.
         :type loc: list
         '''
         self.portname = portname
         self.iogroup = iogroup 
         self.index = index
         self.loc = loc
         self.iostd = iostd
         if loc is not None:
             if isinstance(index, list):
                 if not isinstance(loc,list):
                     raise ValueError("Tried to constrain a multidimensional signal with a single LOC!")
                 elif len(loc) != len(index):
                     raise ValueError("Tried to constrain a multidimensional signal with a list of LOCs with different dimensions!")

         if iostd is not None:
             if isinstance(index, list):
                 if not isinstance(iostd,list):
                     self.iostd = [iostd]*len(index)
                 elif len(iostd) != len(index):
                     raise ValueError("Tried to constrain a multidimensional signal with a list of IOSTDs with different dimensions!")

         if index is None:
             self.width = 1
         else:
             self.width = len(index)

     def gen_physical_const(self,platform):
         '''
         Set the loc and iostds of an abstract constraint for a given platform.

         :param platform: The platform instance against which to evaluate the constraint(s).
         :type platform: Platform
         '''
         pins = platform.get_pin(self.iogroup, index=self.index)
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
         
        


