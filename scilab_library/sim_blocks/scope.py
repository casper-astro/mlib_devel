from .sim_block import SimBlock
import numpy as np
import logging
from matplotlib import pyplot as plt
class scope(SimBlock):
    def __init__(self, blk):
        """
        The input parameters are the data width and data length.
        """
        super().__init__(blk)
        self.logger = logging.getLogger('jasper-sim.sim_block.scope')
        self.simdata = 0
        self.length = 0
    
    def get_sim_data(self):
        """
        Get the simulation data.
        """
        r = SimBlock._parse_sim_file(self.vcdfile)
        self.logger.info('Getting simulation data for port %s' % self.port_name)
        data = SimBlock._get_sim_data_by_port_name(r, self.port_name)
        # data is a list, and each element is also a list,
        # which contains the time and the value.
        # We only need the value.
        data = data['data']
        self.simdata = np.zeros(SimBlock.sim_length + 1)
        # filled is the tag to indicate if the data is filled
        filled = np.zeros(SimBlock.sim_length + 1)
        for d in data:
            # the timescale for the simulation data is 1ns/1ps,
            # so the unit is ps, and the clk rising edge is at 500ps, 1500ps, 2500ps, ...
            t = int((d[0] + 500)/1000)
            # if the sim data is just 1 bit, it won't have the 'b' prefix
            if len(d[1]) == 1:
                s = d[1][0]
            else:
                s = d[1][1:]
            try:
                self.simdata[t] = int(s,2)
            except:
                # TODO: for the unknown value, can we set it to 0?
                self.simdata[t] = 0
            filled[t] = 1
        # fill the empty data
        for i in range(SimBlock.sim_length + 1):
            if filled[i] == 0:
                self.simdata[i] = self.simdata[i-1]
                filled[i] = 1
        # convert the data type
        dtype = self.val['dtype']
        self.simdata = self.simdata.astype(dtype)
        return self.simdata
    
    def plot_sim_data(self):
        self.logger.info('Plotting simulation data for  %s' % self.name)
        self.length = SimBlock.sim_length
        r = self.simdata
        # plot the data
        fig = plt.figure()
        subfig = fig.add_subplot(111)
        subfig.plot(r)
        subfig.set_title(self.name)
        subfig.set_xlabel('Time/ns')
        subfig.set_ylabel('Value')
        subfig.grid(True)
        subfig.legend()
        plt.show()