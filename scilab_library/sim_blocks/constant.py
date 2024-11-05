from .sim_block import SimBlock
import numpy as np

class constant(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        self.width = blk['port']['width']
        # TODO: we need the length parameter from the block in scilab.
        try:
            self.length = blk['length']
        except:
            self.length = 1000
        
    def gen_sim_data(self):
        """
        Generate the constant data.
        """
        self.data = np.ones(self.length) * 2**self.width/2
        return self.data