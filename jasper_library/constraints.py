class PortConstraint(object):
     def __init__(self, portname=None, iogroup=None, index=None, loc=None, iostd=None):
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
         print self.iogroup, self.index
         pins = platform.get_pin(self.iogroup, index=self.index)
         if type(pins) is list:
             print pins[0].loc
             if self.loc is None:
                 self.loc = [pin.loc for pin in pins]
             if self.iostd is None:
                 self.iostd = [pin.iostd for pin in pins]
         else:
             if self.loc is None:
                 self.loc = pins.loc
             if self.iostd is None:
                 self.iostd = pins.iostd
         
        


