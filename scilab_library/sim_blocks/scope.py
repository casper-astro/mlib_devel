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
        self.simdata = []
        for d in data:
            try:
                self.simdata.append(int(d[1][1:],2))
            except:
                # TODO: for the unknown value, can we set it to 0?
                self.simdata.append(0)
        self.length = SimBlock.sim_length
        # if the data length is less than 1000, extend the last value to 1000
        if len(self.simdata) < self.length:
            self.simdata = np.append(self.simdata, np.ones(self.length - len(self.simdata))*self.simdata[-1])
        else:
            self.simdata = np.array(self.simdata)
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