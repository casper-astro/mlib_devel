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
    
    def get_sim_data(self):
        """
        Get the simulation data.
        """
        r = SimBlock._parse_sim_file(self.vcdfile)
        self.logger.info('Getting simulation data for port %s' % self.port_name)
        self.simdata = SimBlock._get_val_by_name(r, self.port_name)
        return self.simdata
    
    def plot_sim_data(self):
        self.logger.info('Plotting simulation data for  %s' % self.name)
        data = self.simdata['data']
        # data is a list, and each element is also a list,
        # which contains the time and the value.
        # We only need the value.
        r = []
        for d in data:
            try:
                r.append(int(d[1][1:],2))
            except:
                # TODO: for the unknown value, can we set it to 0?
                r.append(0)
        # if the data length is less than 1000, extend the last value to 1000
        if len(r) < 1000:
            r = np.append(r, np.ones(1000-len(r))*r[-1])
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