import os
from .yellow_block import YellowBlock

class ltc2308(YellowBlock):
    """
    Instantiates adc_ltc2308_fifo (external ADC interface + FIFO),
    clocks it from the platform PLL clock (sys_clk), and pushes the
    Scilab/Xcos 'channel' parameter down to the HDL via DEFAULT_CH.
    """

    def initialize(self):
        hdl_source = os.path.join(os.getenv('MLIB_DEVEL_PATH'), 'scilab_library', 'hdl_sources', 'ltc2308')

        # Sources for the ADC block (outside Platform Designer)
        self.add_source(os.path.join(hdl_source, 'adc_ltc2308_fifo.v'))
        self.add_source(os.path.join(hdl_source, 'adc_ltc2308.v'))
        self.add_source(os.path.join(hdl_source, 'adc_data_fifo.v'))

        # Pull parameters from the jasper config (strings are common)
        # Your block_config has keys: name, fullpath, tag, sample_rate, channel
        try:
            self.channel = int(self.channel)   # framework typically sets attributes from keys
        except Exception:
            self.channel = 0

        # Clamp for safety (LTC2308 channels are 0..7)
        if self.channel < 0:
            self.channel = 0
        if self.channel > 7:
            self.channel = 7

    def modify_top(self, top):
        """
        Hook the ADC block to:
          - sys_clk (PLL-derived 40 MHz in your de10nano.py)
          - reset using ~sys_rst (since your module wants reset_n)
          - ADC pins exported at top level: ADC_CONVST/SCK/SDI/SDO

        NOTE: The Avalon slave interface is left as ?tie-offs? here.
        Once you drop in your AXI-Lite <-> Avalon bridge, replace the
        tie-offs with the bridge signals.
        """

        inst_name = f"{self.fullpath.replace('/','_')}_adc"

        # Create the instance. In jasper this is usually get_instance(module, inst).
        u = top.get_instance('adc_ltc2308_fifo', inst_name)

        # Set the HDL parameter to your chosen channel
        # (Most jasper backends support add_parameter(name, value))
        u.add_parameter('DEFAULT_CH', self.channel)
        # Clock/reset: module expects active-low reset_n
        u.add_port('slave_clk',      'sys_clk',     dir='in')
        u.add_port('slave_reset_n',  '~sys_rst',    dir='in')

        # --- Avalon slave port tie-offs (replace later with your bridge) ---
        # Your HDL uses active-low read/write/chipselect names.
        u.add_port('slave_chipselect_n', "1'b1",     dir='in')
        u.add_port('slave_addr',         "1'b0",     dir='in',  width=1)
        u.add_port('slave_read_n',       "1'b1",     dir='in')
        u.add_port('slave_wrtie_n',      "1'b1",     dir='in')
        u.add_port('slave_wriredata',    "16'd0",    dir='in',  width=16)

        # Read data bus (even if unused now, wire it so the port list matches)
        # If your toolflow requires signals (not open outputs), declare one.
        top.add_signal(f"{inst_name}_readdata", width=16)
        u.add_port('slave_readdata', f"{inst_name}_readdata", dir='out', width=16)

        # --- ADC physical pins ---
        # These names assume you exported these pins in your platform/top template.
        # If your platform uses different names, change the RHS nets accordingly.
        top.add_port('ADC_CONVST', 'ADC_CONVST', dir='out')
        top.add_port('ADC_SCK',    'ADC_SCK',    dir='out')
        top.add_port('ADC_SDI',    'ADC_SDI',    dir='out')
        top.add_port('ADC_SDO',    'ADC_SDO',    dir='in')
