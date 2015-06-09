import yaml
import os

class Platform(object):
    '''
    A class encapsulating information about an FPGA platform.
    '''
    @staticmethod
    def get_loader(name):
        if name.startswith('SNAP'):
            return SnapPlatform()
        elif name.startswith('KC705'):
            return KC705Platform()
        elif name.startswith('ROACH2'):
            return Roach2Platform()
        elif name.startswith('ROACH'):
            return RoachPlatform()
        else:
            raise Exception('Unsupported hardware platform!')

    def __init__(self, name):
        '''
        Constructor. This method will build the platform called <name>,
        scraping details from a yaml configuration file called
        <MLIB_DEVEL_PATH>/jasper_library/platforms/name.yaml
        '''
        platdir = os.environ['MLIB_DEVEL_PATH'] + '/jasper_library/platforms'
        conffile = platdir + '/%s.yaml'%name.lower()
        if not os.path.isfile(conffile):
            raise RuntimeError("Couldn't find platform configuration file %s"%conffile)

        with open(conffile, 'r') as fh:
            self.conf = yaml.load(fh.read())

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

    def add_pins(self, name, iostd, loc):
        '''
        Add a pin to the platform. Generally for use in constructors
        of Platform subclasses.

        :param name: Abstract pin name. Eg., 'zdok0'
        :type name: str
        :param iostd: IO Standard of the pin. Eg., 'LVDS'. Assumes all pins added have the same iostd.
        :type iostd: str
        :param locs: Physical location of the pin. Eg., 'AC12'. Can be a string or a list, if the name refers to a bank of pins
        :type locs: str, list of str
        '''
        if not self._pins.has_key('name'):
            self._pins[name] = []

        if not isinstance(loc,list):
            loc = [loc]
        
        self._pins[name] += [Pin(iostd, l) for l in loc]

    def get_pins(self, name, index=[0]):
        '''
        Return a list of pin objects based on index input.
        If index is integer, return single element

        :param name: Abstract pin name, eg. zdok0
        :type name: str
        :param index: Index of the pin, if the name refers to a bank. Can be None (single pin), integer, or list of pin indices.
        :type index: int,list
        '''

        if type(index) is not list: index = [index]
        try:
            return [self._pins[name][i] for i in index]
        except KeyError:
            raise KeyError("No pin named %s"%name)
        except IndexError:
            raise IndexError("Pin named %s does not have indices %s"%(name, index))


class Pin(object):
    '''
    A simple class to hold the IO standard and LOCs
    of FPGA pins.
    '''
    def __init__(self, iostd, loc):
        '''
        iostd should be a string e.g. 'LVDS'
        locs should be string indicating a pin number.
        e.g. 'A21'.
        '''
        self.iostd = iostd
        self.loc = loc

class SnapPlatform(Platform):
    def __init__(self):
        Platform.__init__(self)
        self.manufacturer = 'Xilinx'
        self.fpga= 'xc7k160tffg676-2'
        self.name = 'snap'
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270', 'wb_clk', 'zdok0']
        self.consts   = ['snap.xdc', 'snap.ucf']
        self.sources  = ['infrastructure', 'spi_wb_bridge',
                        'wbs_arbiter', 'sys_block']
        # pin constraints
        # You only need to include things here
        # which aren't defined by the base package
        self.add_pins('miso', 'LVCMOS25', 'AA27')
        self.add_pins('mosi', 'LVCMOS25', 'AB28')
        self.add_pins('sclk', 'LVCMOS25', 'AA25')
        self.add_pins('cs_n', 'LVCMOS25', 'AB25')
        self.add_pins('gpio_led4', 'LVCMOS25', 'F13')
        self.add_pins('led0', 'LVCMOS25', 'D13')
        zdok_pins = [
        'AA23',
        'AB24',
        'Y25',
        'Y26',
        'U24',
        'U25',
        'U19',
        'U20',
        'T24',
        'T25',
        'M21',
        'M22',
        'M24',
        'L24',
        'L22',
        'K22',
        'J24',
        'J25',
        'G25',
        'G26',
        'Y22',
        'AA22',
        'Y23',
        'AA24',
        'V23',
        'V24',
        'R22',
        'R23',
        'R21',
        'P21',
        'P23',
        'N23',
        'K25',
        'K26',
        'K23',
        'J23',
        'H21',
        'G21',
        'G22',
        'F23',
        'AE23',
        'AF23',
        'AC23',
        'AC24',
        'W23',
        'W24',
        'T22',
        'T23',
        'R18',
        'P18',
        'N18',
        'M19',
        'N19',
        'M20',
        'J21',
        'H22',
        'G24',
        'F24',
        'D23',
        'D24',
        'AE22',
        'AF22',
        'AB26',
        'AC26',
        'V21',
        'W21',
        'U17',
        'T17',
        'R16',
        'R17',
        'P19',
        'P20',
        'P16',
        'N17',
        'J26',
        'H26',
        'E25',
        'D25',
        'F22',
        'E23',
        ]
 
        self.add_pins('zdok0', 'LVCMOS25', zdok_pins)
 
        zdok_pins_p = [
        'AA23',
        'Y25',
        'U24',
        'U19',
        'T24',
        'M21',
        'M24',
        'L22',
        'J24',
        'G25',
        'Y22',
        'Y23',
        'V23',
        'R22',
        'R21',
        'P23',
        'K25',
        'K23',
        'H21',
        'G22',
        'E23',
        'AC23',
        'W23',
        'T22',
        'R18',
        'N18',
        'N19',
        'J21',
        'G24',
        'D23',
        'AE22',
        'AB26',
        'V21',
        'U17',
        'R16',
        'P19',
        'P16',
        'J26',
        'E25',
        'F22',
        ]
 
        zdok_pins_n = [
        'AB24',
        'Y26',
        'U25',
        'U20',
        'T25',
        'M22',
        'L24',
        'K22',
        'J25',
        'G26',
        'AA22',
        'AA24',
        'V24',
        'R23',
        'P21',
        'N23',
        'K26',
        'J23',
        'G21',
        'F23',
        'AF23',
        'AC24',
        'W24',
        'T23',
        'P18',
        'M19',
        'M20',
        'H22',
        'F24',
        'D24',
        'AF22',
        'AC26',
        'W21',
        'T17',
        'R17',
        'P20',
        'N17',
        'H26',
        'D25',
        'E23',
        ]
 
        self.add_pins('zdok0_p', 'LVDS_25', zdok_pins_p)
        self.add_pins('zdok0_n', 'LVDS_25', zdok_pins_n)
        self.add_pins('eth_clk_p', None, 'K6')
        self.add_pins('eth_clk_n', None, 'K5')
        self.add_pins('mgt_tx_p0', None, 'P2')
        self.add_pins('mgt_tx_n0', None, 'P1')
        self.add_pins('mgt_rx_p0', None, 'R4')
        self.add_pins('mgt_rx_n0', None, 'R3')

       
class KC705Platform(Platform):
    def __init__(self):
        Platform.__init__(self)
        self.manufacturer = 'xilinx'
        self.fpga= 'xc7k325tffg900-2'
        self.name = 'kc705'
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270', 'wb_clk']
        self.consts   = ['kc705.xdc', 'kc705.ucf']
        self.sources  = ['infrastructure', 'spi_wb_bridge',
                        'wbs_arbiter', 'sys_block']
        # pin constraints
        # You only need to include things here
        # which aren't defined by the base package
        self.add_pins('miso', 'LVCMOS25', 'AA27')
        self.add_pins('mosi', 'LVCMOS25', 'AB28')
        self.add_pins('sclk', 'LVCMOS25', 'AA25')
        self.add_pins('cs_n', 'LVCMOS25', 'AB25')
        self.add_pins('gpio_led4', 'LVCMOS25', 'AE26')
        self.add_pins('led', 'LVCMOS25', 'E18')

class RoachPlatform(Platform):
    def __init__(self):
        Platform.__init__(self)
        self.manufacturer = 'xilinx'
        self.fpga= 'xc7k325tffg900-2'
        self.name = 'roach'
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270', 'wb_clk', 'zdok0', 'zdok1', 'gpioa', 'gpiob']
        self.sources  = ['infrastructure', 'spi_wb_bridge',
                        'wbs_arbiter', 'sys_block']
        led_pins = [
            'AP26',
            'AP25',
            'AL25',
            'AL24',
            ]
        self.add_pins('led', 'LVDS_25', led_pins)

        gpioa_pins = [
            'N33',
            'N34',
            'P34',
            'R33',
            'M33',
            'L33',
            'P32',
            'N32',
            ]
        self.add_pins('gpioa', 'LVDS_25', gpioa_pins)

        gpiob_pins = [
            'J7',
            'H7',
            'J9',
            'J10',
            'B27',
            'D24',
            'E24',
            'A26',
            ]
        self.add_pins('gpiob', 'LVDS_25', gpiob_pins)

        diff_gpio_pins = [
            'F17',
            'G17',
            'K17',
            'L17',
            'D16',
            'E16',
            'F16',
            'G16',
            'H16',
            'J16',
            'D15',
            'D14',
            'F15',
            'G15',
            'K16',
            'L16',
            'C13',
            'C14',
            'E14',
            'F14',
            ]
        self.add_pins('diff_gpio', 'LVDS_25', diff_gpio_pins)

        zdok0_p_pins = [
            'M31',
            'M28',
            'M25',
            'K28',
            'K24',
            'H29',
            'H28',
            'F31',
            'E28',
            'C32',
            'N27',
            'L29',
            'L25',
            'J30',
            'G33',
            'G30',
            'H25',
            'E29',
            'C34',
            'J20',
            'L34',
            'K33',
            'J32',
            'K27',
            'H30',
            'J24',
            'G27',
            'G25',
            'E26',
            'B32',
            'L30',
            'K31',
            'H34',
            'J27',
            'G32',
            'F33',
            'E32',
            'F25',
            'B33',
            'H19',
            ]
        self.add_pins('zdok0_p', 'LVDS_25', zdok0_p_pins)

        zdok0_n_pins = [
            'N30',
            'N28',
            'M26',
            'L28',
            'L24',
            'J29',
            'G28',
            'E31',
            'F28',
            'D32',
            'M27',
            'K29',
            'L26',
            'J31',
            'F34',
            'F30',
            'H24',
            'F29',
            'D34',
            'J21',
            'K34',
            'K32',
            'H33',
            'K26',
            'G31',
            'J25',
            'H27',
            'G26',
            'E27',
            'A33',
            'M30',
            'L31',
            'J34',
            'J26',
            'H32',
            'E34',
            'E33',
            'F26',
            'C33',
            'H20',
            ]
        self.add_pins('zdok0_n', 'LVDS_25', zdok0_n_pins)

        zdok1_p_pins = [
            'AN34',
            'AK29',
            'AJ31',
            'AJ32',
            'AH34',
            'AE27',
            'AD26',
            'AF34',
            'AD32',
            'AC34',
            'AJ25',
            'AL34',
            'AK34',
            'AG27',
            'AF29',
            'AG33',
            'AE29',
            'AD30',
            'AB27',
            'H17',
            'AN32',
            'AM33',
            'AH27',
            'AH29',
            'AF25',
            'AD24',
            'AE28',
            'AC25',
            'AC28',
            'AB30',
            'AK26',
            'AK28',
            'AJ30',
            'AF24',
            'AG28',
            'AG32',
            'AF31',
            'AF33',
            'AD31',
            'K17',
            ]
        self.add_pins('zdok1_p', 'LVDS_25', zdok1_p_pins)

        zdok1_n_pins = [
            'AN33',
            'AJ29',
            'AK31',
            'AK32',
            'AJ34',
            'AE26',
            'AD25',
            'AE34',
            'AE32',
            'AD34',
            'AH25',
            'AL33',
            'AK33',
            'AG26',
            'AF30',
            'AH33',
            'AD29',
            'AC29',
            'AC27',
            'H18',
            'AP32',
            'AM32',
            'AJ26',
            'AG30',
            'AF26',
            'AE24',
            'AF28',
            'AC24',
            'AD27',
            'AC30',
            'AJ27',
            'AK27',
            'AH30',
            'AG25',
            'AH28',
            'AH32',
            'AG31',
            'AE33',
            'AE31',
            'L18',
            ]
        self.add_pins('zdok1_n', 'LVDS_25', zdok1_n_pins)

        zdok0_pins = [
            'M31',
            'N30',
            'M28',
            'N28',
            'M25',
            'M26',
            'K28',
            'L28',
            'K24',
            'L24',
            'H29',
            'J29',
            'H28',
            'G28',
            'F31',
            'E31',
            'E28',
            'F28',
            'C32',
            'D32',
            'N27',
            'M27',
            'L29',
            'K29',
            'L25',
            'L26',
            'J30',
            'J31',
            'G33',
            'F34',
            'G30',
            'F30',
            'H25',
            'H24',
            'E29',
            'F29',
            'C34',
            'D34',
            'J20',
            'J21',
            'L34',
            'K34',
            'K33',
            'K32',
            'J32',
            'H33',
            'K27',
            'K26',
            'H30',
            'G31',
            'J24',
            'J25',
            'G27',
            'H27',
            'G25',
            'G26',
            'E26',
            'E27',
            'B32',
            'A33',
            'L30',
            'M30',
            'K31',
            'L31',
            'H34',
            'J34',
            'J27',
            'J26',
            'G32',
            'H32',
            'F33',
            'E34',
            'E32',
            'E33',
            'F25',
            'F26',
            'B33',
            'C33',
            'H19',
            'H20',
            ]
        self.add_pins('zdok0', 'LVDS_25', zdok0_pins)

        zdok1_pins = [
            'AN34',
            'AN33',
            'AK29',
            'AJ29',
            'AJ31',
            'AK31',
            'AJ32',
            'AK32',
            'AH34',
            'AJ34',
            'AE27',
            'AE26',
            'AD26',
            'AD25',
            'AF34',
            'AE34',
            'AD32',
            'AE32',
            'AC34',
            'AD34',
            'AJ25',
            'AH25',
            'AL34',
            'AL33',
            'AK34',
            'AK33',
            'AG27',
            'AG26',
            'AF29',
            'AF30',
            'AG33',
            'AH33',
            'AE29',
            'AD29',
            'AD30',
            'AC29',
            'AB27',
            'AC27',
            'H17',
            'H18',
            'AN32',
            'AP32',
            'AM33',
            'AM32',
            'AH27',
            'AJ26',
            'AH29',
            'AG30',
            'AF25',
            'AF26',
            'AD24',
            'AE24',
            'AE28',
            'AF28',
            'AC25',
            'AC24',
            'AC28',
            'AD27',
            'AB30',
            'AC30',
            'AK26',
            'AJ27',
            'AK28',
            'AK27',
            'AJ30',
            'AH30',
            'AF24',
            'AG25',
            'AG28',
            'AH28',
            'AG32',
            'AH32',
            'AF31',
            'AG31',
            'AF33',
            'AE33',
            'AD31',
            'AE31',
            'K17',
            'L18',
            ]
        self.add_pins('zdok1', 'LVDS_25', zdok1_pins)

        gpiob_oe_n_pins = [
            'AE14',
            ]
        self.add_pins('gpiob_oe_n', 'LVDS_25', gpiob_oe_n_pins)

        gpioa_oe_n_pins = [
            'AE18',
            ]
        self.add_pins('gpioa_oe_n', 'LVDS_25', gpioa_oe_n_pins)

        qsh_p_pins = [
            'AC33',
            'AA25',
            'AA29',
            'Y24',
            'Y27',
            'Y33',
            'W24',
            'W29',
            'W31',
            'V28',
            'V32',
            'U26',
            'U32',
            'T28',
            'T33',
            'R24',
            'R28',
            'P25',
            'N29',
            'L19',
            'AC32',
            'AB25',
            'AB28',
            'AB31',
            'AA34',
            'Y26',
            'Y28',
            'Y32',
            'W34',
            'V25',
            'V30',
            'U25',
            'U27',
            'U30',
            'U33',
            'T31',
            'R26',
            'P26',
            'N24',
            'K18',
            ]
        self.add_pins('qsh_p', 'LVDS_25', qsh_p_pins)

        qsh_n_pins = [
            'AB33',
            'AA26',
            'AA30',
            'AA24',
            'W27',
            'AA33',
            'V24',
            'V29',
            'Y31',
            'V27',
            'V33',
            'T26',
            'U31',
            'T29',
            'R34',
            'T24',
            'R29',
            'N25',
            'P29',
            'K19',
            'AB32',
            'AB26',
            'AA28',
            'AA31',
            'Y34',
            'W26',
            'Y29',
            'W32',
            'V34',
            'W25',
            'W30',
            'T25',
            'U28',
            'T30',
            'T34',
            'R31',
            'R27',
            'P27',
            'P24',
            'J19',
            ]
        self.add_pins('qsh_n', 'LVDS_25', qsh_n_pins)

        qsh_pins = [
            'AC33',
            'AB33',
            'AA25',
            'AA26',
            'AA29',
            'AA30',
            'Y24',
            'AA24',
            'Y27',
            'W27',
            'Y33',
            'AA33',
            'W24',
            'V24',
            'W29',
            'V29',
            'W31',
            'Y31',
            'V28',
            'V27',
            'V32',
            'V33',
            'U26',
            'T26',
            'U32',
            'U31',
            'T28',
            'T29',
            'T33',
            'R34',
            'R24',
            'T24',
            'R28',
            'R29',
            'P25',
            'N25',
            'N29',
            'P29',
            'L19',
            'K19',
            'AC32',
            'AB32',
            'AB25',
            'AB26',
            'AB28',
            'AA28',
            'AB31',
            'AA31',
            'AA34',
            'Y34',
            'Y26',
            'W26',
            'Y28',
            'Y29',
            'Y32',
            'W32',
            'W34',
            'V34',
            'V25',
            'W25',
            'V30',
            'W30',
            'U25',
            'T25',
            'U27',
            'U28',
            'U30',
            'T30',
            'U33',
            'T34',
            'T31',
            'R31',
            'R26',
            'R27',
            'P26',
            'P27',
            'N24',
            'P24',
            'K18',
            'J19',
            ]
        self.add_pins('qsh', 'LVDS_25', qsh_pins)

        aux0_clk_pins = [
            'G16',
            ]
        self.add_pins('aux0_clk', 'LVDS_25', aux0_clk_pins)

        aux1_clk_pins = [
            'H15',
            ]
        self.add_pins('aux1_clk', 'LVDS_25', aux1_clk_pins)

        
class Roach2Platform(Platform):
    def __init__(self):
        Platform.__init__(self)
        self.manufacturer = 'xilinx'
        self.fpga= 'xc6vsx475tff1759-1'
        self.name = 'roach2'
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270', 'wb_clk']
        self.sources  = ['infrastructure', 'epb_infrastructure', 'epb_wb_bridge_reg',
                        'wbs_arbiter', 'sys_block']
        led_pins = [
            'G31',
            'H31',
            'AF32',
            'AG33',
            'L30',
            'H30',
            'M29',
            'J30',
            ]
        self.add_pins('led', 'LVCMOS15', led_pins)

        gpioa_pins = [
            'M28',
            'K30',
            'N19',
            'N20',
            'H18',
            'F16',
            'E29',
            'M27',
            ]
        self.add_pins('gpioa', 'LVCMOS15', gpioa_pins)

        zdok0_p_pins = [
            'P27',
            'M31',
            'L35',
            'K35',
            'J35',
            'G41',
            'H36',
            'B39',
            'B38',
            'B41',
            'R28',
            'M33',
            'N29',
            'L34',
            'G34',
            'F39',
            'F37',
            'D42',
            'A40',
            'J42',
            'N28',
            'K37',
            'K33',
            'K39',
            'H40',
            'G37',
            'E42',
            'C40',
            'E39',
            'B37',
            'L31',
            'J37',
            'J40',
            'K38',
            'H39',
            'D40',
            'F40',
            'F35',
            'D38',
            'P30',
            ]
        self.add_pins('zdok0_p', 'LVDS_25', zdok0_p_pins)

        zdok0_n_pins = [
            'R27',
            'N31',
            'L36',
            'K34',
            'H35',
            'G42',
            'G36',
            'C39',
            'A39',
            'B42',
            'R29',
            'M32',
            'N30',
            'M34',
            'H34',
            'G39',
            'E37',
            'D41',
            'A41',
            'K42',
            'P28',
            'L37',
            'K32',
            'K40',
            'H41',
            'G38',
            'F42',
            'C41',
            'E38',
            'A37',
            'L32',
            'J36',
            'J41',
            'J38',
            'H38',
            'E40',
            'F41',
            'F36',
            'C38',
            'P31',
            ]
        self.add_pins('zdok0_n', 'LVDS_25', zdok0_n_pins)

        zdok1_p_pins = [
            'AA34',
            'W37',
            'W35',
            'U32',
            'U42',
            'R37',
            'R35',
            'P36',
            'M41',
            'L41',
            'AA35',
            'W32',
            'W36',
            'V40',
            'U37',
            'T39',
            'P42',
            'P40',
            'M38',
            'W30',
            'AA32',
            'Y38',
            'V33',
            'V41',
            'U39',
            'U36',
            'T41',
            'R39',
            'N36',
            'N40',
            'AA36',
            'W42',
            'Y40',
            'V38',
            'V34',
            'T34',
            'R40',
            'M36',
            'N38',
            'AE30',
            ]
        self.add_pins('zdok1_p', 'LVDS_25', zdok1_p_pins)

        zdok1_n_pins = [
            'Y34',
            'Y37',
            'V35',
            'U33',
            'U41',
            'T37',
            'R34',
            'P35',
            'M42',
            'L42',
            'Y35',
            'Y33',
            'V36',
            'W40',
            'U38',
            'R38',
            'R42',
            'P41',
            'M39',
            'V30',
            'Y32',
            'AA39',
            'W33',
            'W41',
            'V39',
            'T36',
            'T42',
            'P38',
            'P37',
            'N41',
            'AA37',
            'Y42',
            'Y39',
            'W38',
            'U34',
            'T35',
            'T40',
            'M37',
            'N39',
            'AF30',
            ]
        self.add_pins('zdok1_n', 'LVDS_25', zdok1_n_pins)

        zdok0_pins = [
            'P27',
            'R27',
            'M31',
            'N31',
            'L35',
            'L36',
            'K35',
            'K34',
            'J35',
            'H35',
            'G41',
            'G42',
            'H36',
            'G36',
            'B39',
            'C39',
            'B38',
            'A39',
            'B41',
            'B42',
            'R28',
            'R29',
            'M33',
            'M32',
            'N29',
            'N30',
            'L34',
            'M34',
            'G34',
            'H34',
            'F39',
            'G39',
            'F37',
            'E37',
            'D42',
            'D41',
            'A40',
            'A41',
            'J42',
            'K42',
            'N28',
            'P28',
            'K37',
            'L37',
            'K33',
            'K32',
            'K39',
            'K40',
            'H40',
            'H41',
            'G37',
            'G38',
            'E42',
            'F42',
            'C40',
            'C41',
            'E39',
            'E38',
            'B37',
            'A37',
            'L31',
            'L32',
            'J37',
            'J36',
            'J40',
            'J41',
            'K38',
            'J38',
            'H39',
            'H38',
            'D40',
            'E40',
            'F40',
            'F41',
            'F35',
            'F36',
            'D38',
            'C38',
            'P30',
            'P31',
            ]
        self.add_pins('zdok0', 'LVCMOS25', zdok0_pins)

        zdok1_pins = [
            'AA34',
            'Y34',
            'W37',
            'Y37',
            'W35',
            'V35',
            'U32',
            'U33',
            'U42',
            'U41',
            'R37',
            'T37',
            'R35',
            'R34',
            'P36',
            'P35',
            'M41',
            'M42',
            'L41',
            'L42',
            'AA35',
            'Y35',
            'W32',
            'Y33',
            'W36',
            'V36',
            'V40',
            'W40',
            'U37',
            'U38',
            'T39',
            'R38',
            'P42',
            'R42',
            'P40',
            'P41',
            'M38',
            'M39',
            'W30',
            'V30',
            'AA32',
            'Y32',
            'Y38',
            'AA39',
            'V33',
            'W33',
            'V41',
            'W41',
            'U39',
            'V39',
            'U36',
            'T36',
            'T41',
            'T42',
            'R39',
            'P38',
            'N36',
            'P37',
            'N40',
            'N41',
            'AA36',
            'AA37',
            'W42',
            'Y42',
            'Y40',
            'Y39',
            'V38',
            'W38',
            'V34',
            'U34',
            'T34',
            'T35',
            'R40',
            'T40',
            'M36',
            'M37',
            'N38',
            'N39',
            'AE30',
            'AF30',
            ]
        self.add_pins('zdok1', 'LVCMOS25', zdok1_pins)

        aux_clk_pins = [
            'AV16',
            ]
        self.add_pins('aux_clk', 'LVCMOS', aux_clk_pins)

        sync_in_p_pins = [
            'BB16',
            ]
        self.add_pins('sync_in_p', 'LVDS_25', sync_in_p_pins)

        sync_in_n_pins = [
            'BB17',
            ]
        self.add_pins('sync_in_n', 'LVDS_25', sync_in_n_pins)

        sync_out_p_pins = [
            'BA16',
            ]
        self.add_pins('sync_out_p', 'LVDS_25', sync_out_p_pins)

        sync_out_n_pins = [
            'BA17',
            ]
        self.add_pins('sync_out_n', 'LVDS_25', sync_out_n_pins)

        mgt_gpio_pins = [
            'J16',
            'H20',
            'N18',
            'B16',
            'L29',
            'K29',
            'N15',
            'P16',
            'N16',
            'P17',
            'L15',
            'K19',
            ]
        self.add_pins('mgt_gpio', 'LVCMOS15', mgt_gpio_pins)

        xaui_refclk_p_pins = [
            'AT8',
            'AD8',
            'K8',
            ]
        self.add_pins('xaui_refclk_p', 'LVDS_25', xaui_refclk_p_pins)

        xaui_refclk_n_pins = [
            'AT7',
            'AD7',
            'K7',
            ]
        self.add_pins('xaui_refclk_n', 'LVDS_25', xaui_refclk_n_pins)

        mgt_tx_n_pins = [
            'AW2',
            'AY4',
            'BA2',
            'BB4',
            'AR2',
            'AT4',
            'AU2',
            'AV4',
            'AL2',
            'AM4',
            'AN2',
            'AP4',
            'AG2',
            'AH4',
            'AJ2',
            'AK4',
            'W2',
            'AA2',
            'AC2',
            'AE2',
            'P4',
            'R2',
            'T4',
            'U2',
            'K4',
            'L2',
            'M4',
            'N2',
            'F4',
            'G2',
            'H4',
            'J2',
            ]
        self.add_pins('mgt_tx_n', 'LVDS_25', mgt_tx_n_pins)

        mgt_tx_p_pins = [
            'AW1',
            'AY3',
            'BA1',
            'BB3',
            'AR1',
            'AT3',
            'AU1',
            'AV3',
            'AL1',
            'AM3',
            'AN1',
            'AP3',
            'AG1',
            'AH3',
            'AJ1',
            'AK3',
            'W1',
            'AA1',
            'AC1',
            'AE1',
            'P3',
            'R1',
            'T3',
            'U1',
            'K3',
            'L1',
            'M3',
            'N1',
            'F3',
            'G1',
            'H3',
            'J1',
            ]
        self.add_pins('mgt_tx_p', 'LVDS_25', mgt_tx_p_pins)

        mgt_rx_n_pins = [
            'AW6',
            'AY8',
            'BA6',
            'BB8',
            'AP8',
            'AR6',
            'AU6',
            'AV8',
            'AJ6',
            'AL6',
            'AM8',
            'AN6',
            'AD4',
            'AE6',
            'AF4',
            'AG6',
            'Y4',
            'AA6',
            'AB4',
            'AC6',
            'R6',
            'U6',
            'V4',
            'W6',
            'J6',
            'L6',
            'N6',
            'P8',
            'E6',
            'F8',
            'G6',
            'H8',
            ]
        self.add_pins('mgt_rx_n', 'LVDS_25', mgt_rx_n_pins)

        mgt_rx_p_pins = [
            'AW5',
            'AY7',
            'BA5',
            'BB7',
            'AP7',
            'AR5',
            'AU5',
            'AV7',
            'AJ5',
            'AL5',
            'AM7',
            'AN5',
            'AD3',
            'AE5',
            'AF3',
            'AG5',
            'Y3',
            'AA5',
            'AB3',
            'AC5',
            'R5',
            'U5',
            'V3',
            'W5',
            'J5',
            'L5',
            'N5',
            'P7',
            'E5',
            'F7',
            'G5',
            'H7',
            ]
        self.add_pins('mgt_rx_p', 'LVDS_25', mgt_rx_p_pins)
        
