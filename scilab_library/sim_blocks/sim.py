from .sim_block import SimBlock
import logging

class sim(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        self.logger = logging.getLogger('jasper-sim.sim_block.sim')
        self.name = blk['name']
        self.length = blk['sim_length']
        SimBlock.sim_length = blk['sim_length']
        SimBlock.sim_instance = True
        self.logger.info('The simulation length is %d' % SimBlock.sim_length)
    