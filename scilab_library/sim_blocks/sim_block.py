import numpy as np
import logging
import os

"""
The SimData class is used to generate the simulation data.
We will have different kinds of simulation blocks, including constant, sine wave, white noise...
"""
class SimBlock(object):
    def make_block(blk):
        """
        Make a block from a dictionary.
        """
        # import the class file
        clsfile = __import__(__package__ + '.' + blk['tag'])
        # get the module from the class file
        cls = clsfile.__getattribute__(blk['tag'])
        # get the class from the module
        cls = cls.__getattribute__(blk['tag'])
        # create an instance of the class
        return cls(blk)
        

    def __init__(self, blk):
        """
        The each block has its own parameters.
        """
        self.logger = logging.getLogger('jasper-sim.sim_block')
        self.width = blk['port']['width']
        self.name = blk['name']
        self.dir = blk['dir']
        self.val = blk['val']
        # check if the dir exists
        # if not, create the dir
        if not os.path.exists(self.dir):
            os.makedirs(self.dir)
    
    def gen_sim_data(self):
        """
        Generate the simulation data.
        """
        pass
       
    def show_sim_data(self):
        """
        Show the simulation data.
        """
        pass
