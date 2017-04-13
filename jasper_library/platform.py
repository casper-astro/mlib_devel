import yaml
import os


class Platform(object):
    """
    A class encapsulating information about an FPGA platform.
    """

    def __init__(self, name):
        """
        Constructor. This method will build the platform called <name>,
        scraping details from a yaml configuration file called
        <MLIB_DEVEL_PATH>/jasper_library/platforms/name.yaml
        """
        platdir = os.environ['MLIB_DEVEL_PATH'] + '/jasper_library/platforms'
        conffile = platdir + '/%s.yaml' % name.lower()
        print conffile
        if not os.path.isfile(conffile):
            raise RuntimeError('Couldn\'t find platform configuration file '
                               '%s' % conffile)

        with open(conffile, 'r') as fh:
            self.conf = yaml.load(fh.read())

        print self.conf
        #: A dictionary of pin names associated with the platform.
        self._pins = {}
        for pinname, val in self.conf['pins'].iteritems():
            self.add_pins(pinname, val.get('iostd', None), val.get('loc', None))
        #: A list of resources present on a platform to facilitate
        #: simple drc checking. Eg. ['qdr0', 'sysclk2x']
        self.provides = self.conf.get('provides', [])
        #: A list of source files/directories required to compile
        #: the template top.v (does NOT include top.v itself)
        self.sources = self.conf.get('sources', [])
        #: A list of constraint files/directories required to compile
        #: the template top.v 
        self.consts = self.conf.get('constraints', [])
        #: FPGA manufacturer
        self.manufacturer = self.conf.get('manufacturer', [])
        #: Platform name. Eg, ROACH, SNAP, etc.
        self.name = self.conf['name']
        #: FPGA model. Should be the full version ready to pass to the
        #: vendor tools. Eg., xc7k325tffg900-2
        self.fpga = self.conf['fpga']
        #: backend target -- used to decide what compiler to use
        self.backend_target = self.conf['backend_target']
        self.user_clk_rate = 100
        self.user_clk = 'user_clk'
        #: project mode -- used to decide what Vivado compiler project
        # mode to use
        #: Default set to true, so project mode is enabled by default (not
        # read from YAML file, As it is up to the user to select which
        # mode must be used)
        self.project_mode = True
        #: This represents the DSP wishbone base address - useful if certain
        # base addresses are important
        try:
            self.dsp_wb_base_address = self.conf['dsp_wb_base_address']
        except KeyError:
            self.dsp_wb_base_address = 0x00010000
        #: This represents the DSP wishbone base address alignment
        try:
            self.dsp_wb_base_address_alignment = \
                self.conf['dsp_wb_base_address_alignment']
        except KeyError:
            self.dsp_wb_base_address_alignment = 4

    def add_pins(self, name, iostd, loc):
        """
        Add a pin to the platform. Generally for use in constructors
        of Platform subclasses.

        :param name: Abstract pin name. Eg., 'zdok0'
        :type name: str
        :param iostd: IO Standard of the pin. Eg., 'LVDS'. Assumes all pins 
            added have the same iostd.
        :type iostd: str
        :param loc: Physical location of the pin. Eg., 'AC12'. Can be a 
            string or a list, if the name
        refers to a bank of pins
        :type loc: str, list of str
        """
        if 'name' not in self._pins:
            self._pins[name] = []

        if not isinstance(loc, list):
            loc = [loc]
        
        self._pins[name] += [Pin(iostd, l) for l in loc]

    def get_pins(self, name, index=None):
        """
        Return a list of pin objects based on index input.
        If index is integer, return single element

        :param name: Abstract pin name, eg. zdok0
        :type name: str
        :param index: Index of the pin, if the name refers to a bank. 
            Can be None (single pin), integer, or list of pin indices.
        :type index: int,list
        """
        if index is None:
            index = [0]
        if type(index) is not list:
            index = [index]
        try:
            return [self._pins[name][i] for i in index]
        except KeyError:
            raise KeyError('No pin named %s' % name)
        except IndexError:
            raise IndexError('Pin named %s does not have indices '
                             '%s' % (name, index))


class Pin(object):
    """
    A simple class to hold the IO standard and LOCs
    of FPGA pins.
    """
    def __init__(self, iostd, loc):
        """
        iostd should be a string e.g. 'LVDS'
        loc should be string indicating a pin number.
        e.g. 'A21'.
        """
        self.iostd = iostd
        self.loc = loc

# end
