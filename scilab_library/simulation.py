import json
import logging
"""
This class generates a simulation object,
 that can be used for casper simulations.
"""
class simulation(object):
    def __init__(self, ip_core_json='jasper.json', sim_json='jasper.sim'):
        """
        The input files are the jasper.json and jasper.sim files.
        In the jasper.json file, we have the IP core information.
        In the jasper.sim file, we have the simulation information.
        """
        self.logger = logging.getLogger('jasper-sim.simulation')
        self.ip_core_info = json.load(open(ip_core_json))
        self.sim_info = json.load(open(sim_json))
        self.ip_core={}
        self.sim_blocks={}

    def get_ip_core_info(self):
        """
        Get the IP core info from the jasper.json.
        We need port name and width information for the IP core.
        """
        self.logger.info('Getting IP core information')
        # get the ip core name
        self.ip_core['name'] = self.ip_core_info['project']['filename'].split('/')[-1].split('.')[0] + '_ip'
        # log it
        self.logger.info('IP Core Name: %s' % self.ip_core['name'])
        # get the input ports and output ports info
        self.ip_core['iports'] = []
        self.ip_core['oports'] = []
        link_info = self.ip_core_info['link_info']
        port = {}
        for link in link_info:
            if link['link_type'] == 'xps_dsp':
                # this is an input port for the IP core
                port['name'] = link['dst_port_name']
                port['width'] = link['dst_port_width']
                self.ip_core['iports'].append(port) 
                # log it
                self.logger.info(' -- Input port: %s, Width: %s' % (link['dst_port_name'], link['dst_port_width']))
            elif link['link_type'] == 'dsp_xps':
                # this is an output port for the IP core
                port['name'] = link['src_port_name']
                port['width'] = link['src_port_width']
                self.ip_core['oports'].append(port)
                # log it
                self.logger.info(' -- Output port: %s, Width: %s' % (link['src_port_name'], link['src_port_width']))

    def get_sim_info(self):
        """
        Get simulation block information from the jasper.sim file.
        We need to figure out each simulation block is connected to which IP core port.
        """
        