from .sim_block import SimBlock
from . import fixed_point
import numpy as np
import logging

class sine(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        super().__init__(blk)
        self.logger = logging.getLogger('jasper-sim.sim_block.sine')
        self.length = 0
    
    def gen_sim_data(self):
        """
        Generate the constant data, and write it into a file.
        """
        # before we run the gen_sim_data, 
        # the SimBlock.sim_length should be set in the sim.__init__ function.
        self.length = SimBlock.sim_length
        self.logger.info('Generating sine wave data under %s/%s.dat' %(self.dir,self.name))
        self.logger.info('The data length is %d' % self.length)
        amp = float(self.val['amplitude'])
        self.logger.info('The amplitude is %g' % amp)
        freq = float(self.val['frequency'])
        self.logger.info('The frequency is %f' % freq)
        phase = float(self.val['phase'])
        self.logger.info('The phase is %f' % phase)
        fs = float(self.val['sampling_rate'])
        self.logger.info('The sampling rate is %f' % fs)
        output_width = int(self.val['output_bit_width'])
        self.logger.info('The output bit width is %d' % output_width)
        # blocks saved before arith_type / bin_pt existed are signed, integer
        arith_type = self.val.get('arith_type', 'signed').strip().lower()
        if arith_type not in fixed_point.ARITH_TYPES:
            raise ValueError('sine %s: arith_type must be signed or unsigned, got %r'
                             % (self.name, self.val['arith_type']))
        bin_pt = int(float(self.val.get('bin_pt', 0)))
        self.logger.info('The arithmetic type is %s, binary point %d' % (arith_type, bin_pt))

        t = np.arange(0, self.length, 1)
        data = amp*np.sin(np.pi*2*freq/fs*t + phase)
        # the amplitude is a real value, i.e. amp * 2^bin_pt in words;
        # signed: two's complement around 0, unsigned: offset binary, the
        # sine around mid-scale 2^(width-1)
        words = fixed_point.quantize(data, output_width, bin_pt, 'signed',
                                     what='sine %s: amplitude %g' % (self.name, amp))
        if arith_type == 'unsigned':
            words = [w + 2**(output_width-1) for w in words]
        fixed_point.write_dat(self.dir + '/' + self.name + '.dat', words, output_width)
