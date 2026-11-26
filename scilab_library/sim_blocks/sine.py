from .sim_block import SimBlock
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
        amp = int(self.val['amplitude'])
        self.logger.info('The amplitude is %d' % amp)
        freq = float(self.val['frequency'])
        self.logger.info('The frequency is %f' % freq)
        phase = float(self.val['phase'])
        self.logger.info('The phase is %f' % phase)
        fs = float(self.val['sampling_rate'])
        self.logger.info('The sampling rate is %f' % fs)
        output_width = int(self.val['output_bit_width'])
        self.logger.info('The output bit width is %d' % output_width)
        # blocks saved before arith_type existed are signed
        arith_type = self.val.get('arith_type', 'signed').strip().lower()
        if arith_type not in ('signed', 'unsigned'):
            raise ValueError('sine %s: arith_type must be signed or unsigned, got %r'
                             % (self.name, self.val['arith_type']))
        self.logger.info('The arithmetic type is %s' % arith_type)

        t = np.arange(0, self.length, 1)
        data = np.round(amp*np.sin(np.pi*2*freq/fs*t + phase))
        # signed: two's complement around 0;
        # unsigned: offset binary, i.e. the sine around mid-scale 2^(width-1)
        offset = 0 if arith_type == 'signed' else 2**(output_width-1)
        lo, hi = -2**(output_width-1) + offset, 2**(output_width-1) - 1 + offset
        words = [int(d) + offset for d in data]
        if min(words) < lo or max(words) > hi:
            raise ValueError('sine %s: amplitude %d does not fit in %d %s bits'
                             % (self.name, amp, output_width, arith_type))
        # write the data into a file
        filename = self.dir + '/' + self.name + '.dat'
        mask = 2**output_width - 1
        with open(filename, 'w') as f:
            for w in words:
                f.write(format(w & mask, '0%db' % output_width) + '\n')

