import os
from .yellow_block import YellowBlock
from constraints import RawConstraint

class ltc2308(YellowBlock):
    def initialize(self):
        hdl_source = os.path.join(
            os.getenv('MLIB_DEVEL_PATH'),
            'scilab_library',
            'hdl_sources',
            'ltc2308'
        )

        self.add_source(os.path.join(hdl_source, 'adc_ltc2308_stream.v'))
        self.add_source(os.path.join(hdl_source, 'adc_ltc2308.v'))
        self.add_source(os.path.join(hdl_source, 'adc_ltc2308_pll_40mhz.v'))

        try:
            self.channel = int(self.channel)
        except Exception:
            self.channel = 0

        self.channel = max(0, min(7, self.channel))

        try:
            self.fft_length = int(self.fft_length)
        except Exception:
            self.fft_length = 1024

        try:
            self.out_width = int(self.out_width)
        except Exception:
            self.out_width = 18

    def modify_top(self, top):
        inst_name = f"{self.fullpath.replace('/','_')}_adc"
        signal_base = self.fullname
        user_clk_sig = 'user_clk' if top.does_signal_exist('user_clk') else 'sys_clk'

        top.add_signal(f'{signal_base}_adc_clk')
        top.add_signal(f'{signal_base}_pll_locked')
        top.add_signal(f'{signal_base}_stream_rst_n')

        pll = top.get_instance('adc_ltc2308_pll_40mhz', f'{inst_name}_pll')
        pll.add_port('refclk', 'fpga_clk1_50', dir='in')
        pll.add_port('rst', "1'b0", dir='in')
        pll.add_port('outclk_0', f'{signal_base}_adc_clk', dir='out')
        pll.add_port('locked', f'{signal_base}_pll_locked', dir='out')

        top.add_raw_string(
            f"assign {signal_base}_stream_rst_n = {signal_base}_rst_n & {signal_base}_pll_locked;\n"
        )

        u = top.get_instance('adc_ltc2308_stream', inst_name)

        # Parameters
        u.add_parameter('DEFAULT_CH', self.channel)
        u.add_parameter('FRAME_LEN', self.fft_length)
        u.add_parameter('OUT_W', self.out_width)
        u.add_parameter('CENTER_DATA', 1)

        # Internal clock and CASPER-managed control signals
        u.add_port('clk', user_clk_sig, dir='in')
        u.add_port('adc_clk', f'{signal_base}_adc_clk', dir='in')
        u.add_port('rst_n', f'{signal_base}_stream_rst_n', dir='in')
        u.add_port('enable', f'{signal_base}_enable', dir='in')

        # Stream outputs
        u.add_port('sample_data',  f'{signal_base}_sample_data',  dir='out', width=self.out_width)
        u.add_port('sample_valid', f'{signal_base}_sample_valid', dir='out', width=1)
        u.add_port('sample_sync',  f'{signal_base}_sample_sync',  dir='out', width=8)

        # ADC physical pins
        top.add_port('ADC_CONVST', 'ADC_CONVST', dir='out')
        top.add_port('ADC_SCK',    'ADC_SCK',    dir='out')
        top.add_port('ADC_SDI',    'ADC_SDI',    dir='out')
        top.add_port('ADC_SDO',    'ADC_SDO',    dir='in')

        u.add_port('ADC_CONVST', 'ADC_CONVST', dir='out', parent_sig=False)
        u.add_port('ADC_SCK',    'ADC_SCK',    dir='out', parent_sig=False)
        u.add_port('ADC_SDI',    'ADC_SDI',    dir='out', parent_sig=False)
        u.add_port('ADC_SDO',    'ADC_SDO',    dir='in', parent_sig=False)

    def gen_constraints(self):
        return [
            RawConstraint('set_location_assignment PIN_U9 -to ADC_CONVST\n'),
            RawConstraint('set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_CONVST\n'),
            RawConstraint('set_location_assignment PIN_V10 -to ADC_SCK\n'),
            RawConstraint('set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SCK\n'),
            RawConstraint('set_location_assignment PIN_AC4 -to ADC_SDI\n'),
            RawConstraint('set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SDI\n'),
            RawConstraint('set_location_assignment PIN_AD4 -to ADC_SDO\n'),
            RawConstraint('set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_SDO\n'),
        ]
