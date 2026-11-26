from .sim_block import SimBlock
import numpy as np
import logging
class constant(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        super().__init__(blk)
        self.logger = logging.getLogger('jasper-sim.sim_block.constant')
        self.length = 0

    def gen_sim_data(self):
        """
        Generate the constant data, and write it into a file.
        """
        # before we run the gen_sim_data, 
        # the SimBlock.sim_length should be set in the sim.__init__ function.
        self.length = SimBlock.sim_length
        self.logger.info('Generating constant data under %s/%s.dat' %(self.dir,self.name))
        self.logger.info('The data length is %d' % self.length)
        value = float(self.val['val'])
        bitwidth = int(self.val['bitwidth'])
        bin_pt = int(self.val.get('bin_pt', 0))
        self.logger.info('The constant value is %s (bitwidth %d, bin_pt %d)' % (value, bitwidth, bin_pt))
        # fixed point: the word is value * 2^bin_pt, rounded to the nearest integer
        word = int(round(value * 2**bin_pt))
        # a negative value is written as its two's complement (signed),
        # a positive one may use all bitwidth bits (unsigned)
        if word < -2**(bitwidth-1) or word >= 2**bitwidth:
            raise ValueError('sim_constant %s: value %s with bin_pt %d does not fit in %d bits'
                             % (self.name, self.val['val'], bin_pt, bitwidth))
        b = format(word & (2**bitwidth - 1), '0%db' % bitwidth)
        # write the data into a file
        filename = self.dir + '/' + self.name + '.dat'
        with open(filename, 'w') as f:
            for _ in range(self.length):
                f.write(b + '\n')
        