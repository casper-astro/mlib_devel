from .sim_block import SimBlock
import numpy as np
#from matplotlib import pyplot as plt
class scope(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        super().__init__(blk)
    
    def show_sim_data(self):
        """
        Show the simulation data.
        """
        # TODO: show the simulation data
        pass
        