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
        value = int(self.val['const_val'])
        self.logger.info('The constant value is %d' % value)
        data = np.ones(self.length).astype(np.uint32) * value
        # write the data into a file
        filename = self.dir + '/' + self.name + '.dat'
        np.savetxt(filename, data, fmt='%x')
        