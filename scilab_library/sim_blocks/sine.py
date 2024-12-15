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

        t = np.arange(0, self.length, 1)
        data = np.round(amp*np.sin(np.pi*2*freq/fs*t + phase))
        # TODO: the max bit width in numpy is 64.
        #       how to handle the data width larger than 64?
        data = data.astype(np.int64)
        # write the data into a file
        filename = self.dir + '/' + self.name + '.dat'
        # np.savetxt(filename, np.abs(data), fmt='%032x')
        with open(filename, 'w') as f:
            for d in data:
                # Convert the original code into the complement code
                # TODO: if the output data is unsigned, we don't need to convert it.
                b = np.binary_repr(d, width=output_width)
                f.write(b + '\n')

