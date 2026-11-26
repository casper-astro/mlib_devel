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
        # data is a dict, and 'name' is the port_name
        # rename the 'name' to the scope name
        self.logger.info('Rename the port name to %s'%self.name)
        data['name'] = self.name
        # the number format the scope shows the signal in; written into
        # casper_simulation.json with the data (see sim_guis/scope_gui)
        data['format'] = self.number_format()
        return data

    def number_format(self):
        """{'arith_type': 'unsigned' | 'signed', 'bin_pt': int} from the
        block's parameters; a block saved before they existed (or with an
        invalid value) is shown as unsigned, binary point 0."""
        arith = str(self.val.get('arith_type', 'Unsigned')).strip().lower()
        if arith not in ('unsigned', 'signed'):
            self.logger.warning('scope %s: arith_type %r is not Unsigned or Signed, using Unsigned'
                                % (self.name, self.val.get('arith_type')))
            arith = 'unsigned'
        try:
            bin_pt = int(float(self.val.get('bin_pt', 0)))
        except ValueError:
            self.logger.warning('scope %s: bin_pt %r is not a number, using 0'
                                % (self.name, self.val.get('bin_pt')))
            bin_pt = 0
        return {'arith_type': arith, 'bin_pt': max(bin_pt, 0)}
    
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