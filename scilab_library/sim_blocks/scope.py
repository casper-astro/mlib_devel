from .sim_block import SimBlock
import numpy as np

class scope(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        self.width = blk['port']['width']
        #self.length = blk['length']
        