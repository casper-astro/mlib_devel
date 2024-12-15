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
        amplitude = int(self.val['amplitude'])
        # TODO: the var name has to be changed, to make it clear
        amplitude = 2**(amplitude - 1) - 1
        self.logger.info('The amplitude is %d' % amplitude)
        frequency = float(self.val['frequency'])
        self.logger.info('The frequency is %f' % frequency)
        phase = float(self.val['phase'])
        self.logger.info('The phase is %f' % phase)
        sampling_rate = float(self.val['sampling_rate'])
        self.logger.info('The sampling rate is %f' % sampling_rate)

        t = np.arange(0, self.length, 1)
        data = np.round(amplitude*np.sin(np.pi*2*16/1024*t))
        data = data.astype(np.int64)
        # write the data into a file
        filename = self.dir + '/' + self.name + '.dat'
        np.savetxt(filename, np.abs(data), fmt='%032x')