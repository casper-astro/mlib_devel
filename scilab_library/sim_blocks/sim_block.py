import numpy as np
import logging
import os
from pyDigitalWaveTools.vcd.parser import VcdParser

"""
The SimData class is used to generate the simulation data.
We will have different kinds of simulation blocks, including constant, sine wave, white noise...
"""
class SimBlock(object):
    # This is a class attributes, which will be used by all the instances of the class
    sim_length = 1000
    # If we found a sim instance, the sim_instance will be set to True. 
    sim_instance = False

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
        self.port_width = blk['port']['width']
        self.port_name = blk['port']['name']
        self.name = blk['name']
        self.dir = blk['dir']
        self.val = blk['val']
        # check if the dir exists
        # if not, create the dir
        if not os.path.exists(self.dir):
            os.makedirs(self.dir)
        self.vcdfile = self.dir + '/' +'simulation.vcd'
    
    @staticmethod
    def _parse_sim_file(vcdfile):
        """
        Description:
            Parse the simulation file, which should be a vcd file.
        Input:
            vcdfile(str): the vcd file name.
        Output:
            r(dict): simulation data.
        """
        with open(vcdfile) as vf:
            vcd = VcdParser()
            vcd.parse(vf)
            r = vcd.scope.toJson()
        return r
    
    @staticmethod
    def _get_sim_data_by_port_name(dic, name):
        """
        Get the val by name from the dict generated from simulation.vcd.
        """
        val = None
        if dic['name'] == name:
            val = dic
        elif 'children' in dic.keys():
            for child in dic['children']:
                val = SimBlock._get_sim_data_by_port_name(child, name)
                if val != None:
                    break
        return val

    def gen_sim_data(self):
        """
        Generate the simulation data.
        """
        pass
       
    def get_sim_data(self):
        """
        Get the simulation data.
        """
        pass

    def plot_sim_data(self):
        """
        Plot the simulation data.
        """
        pass
