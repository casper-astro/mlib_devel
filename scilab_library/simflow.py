import json
import logging
from sim_blocks.sim_block import SimBlock
"""
This class generates a simulation object,
 that can be used for casper simulations.
"""
class SIMflow(object):
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
        self.sim_blocks=[]
        self.sim_objs=[]

    def _get_blk_by_id(self, id):
        """
        Get the block information by the blk id.
        """
        self.logger.info('-- Getting block information for blk id: %d' % id)
        blk_objs = []
        for k,v in self.sim_info.items():
            if k.startswith('blk'):
                if v['tag'].startswith('scilab-blk') == False:
                    blk_objs.append(v)
        for blk in blk_objs:
            if blk['blkid'] == id:
                return blk
        self.logger.error('Block not found for blk id: %d' % id)
            
    def _get_port_by_id(self, id, blk_type):
        """
        Get the port information by the blk id.
        If the blk_type is 'dst', we need to get the dst port;
        otherwise, we need to get the src port.
        """
        self.logger.info('-- Getting port information for blk id: %d , blk type: %s' % (id, blk_type))
        port = {}
        link_objs = self.ip_core_info['link_info']
        for link in link_objs:
            if blk_type == 'dst':
                if link['src_blk_id'] == id:
                    # If the blk is a dst blk, we need to find the 
                    # same blk in src blk field in link objs,
                    # then we need to put the dst port info in the port dict.
                    # It means the sim block should connec to this port.
                    port['name'] = link['dst_port_name']
                    port['width'] = link['dst_port_width']
            elif blk_type == 'src':
                if link['dst_blk_id'] == id:
                    port['name'] = link['src_port_name']
                    port['width'] = link['src_port_width']
        self.logger.info('---- Port Name: %s, Width: %s' % (port['name'], port['width']))
        return port
                    
    def get_ip_core_info(self):
        """
        Get the IP core info from the jasper.json.
        We need port name and width information for the IP core.
        """
        self.logger.info('-- Getting IP core information')
        # get the ip core name
        self.ip_core['name'] = self.ip_core_info['project']['filename'].split('/')[-1].split('.')[0] + '_ip'
        # log it
        self.logger.info('IP Core Name: %s' % self.ip_core['name'])
        # get the input ports and output ports info
        self.ip_core['iports'] = []
        self.ip_core['oports'] = []
        link_objs = self.ip_core_info['link_info']
        port = {}
        for link in link_objs:
            if link['link_type'] == 'xps_dsp':
                # this is an input port for the IP core
                port['name'] = link['dst_port_name']
                port['width'] = link['dst_port_width']
                self.ip_core['iports'].append(port) 
                # log it
                self.logger.info('-- Input port: %s, Width: %s' % (link['dst_port_name'], link['dst_port_width']))
            elif link['link_type'] == 'dsp_xps':
                # this is an output port for the IP core
                port['name'] = link['src_port_name']
                port['width'] = link['src_port_width']
                self.ip_core['oports'].append(port)
                # log it
                self.logger.info('-- Output port: %s, Width: %s' % (link['src_port_name'], link['src_port_width']))

    def get_sim_info(self):
        """
        Get simulation block information from the jasper.sim file.
        We need to figure out each simulation block is connected to which IP core port.
        """
        self.logger.info('Getting simulation blocks information')
        sim_link_objs = self.sim_info['link_info']
        for slink in sim_link_objs:
            if slink['link_type'].startswith('sim_'):
                # this should be a source sim block, like a signal generator
                # TODO: is it possible to connect a source sim block ot a dsp block??
                dst_blk_id = slink['dst_blk_id']
                src_blk_id = slink['src_blk_id']
                port = self._get_port_by_id(dst_blk_id, 'dst')
                sim_blk_name = slink['src_blk_name']
                # TODO: we may need to collect more info for the sim blocks.
                sim_blk = {}
                sim_blk['name'] = sim_blk_name
                sim_blk['port'] = port
                blk = self._get_blk_by_id(src_blk_id)
                sim_blk['tag'] = blk['tag']
                self.sim_blocks.append(sim_blk)
                # log it
                self.logger.info('-- Sim Block: %s, Port: %s, Tag: %s' % (sim_blk_name, port['name'], sim_blk['tag']))
            if slink['link_type'].endswith('_sim'):
                # this should be a destination sim block, like a scope
                src_blk_id = slink['src_blk_id']
                dst_blk_id = slink['dst_blk_id']
                port = self._get_port_by_id(src_blk_id, 'src')
                sim_blk_name = slink['dst_blk_name']
                sim_blk = {}
                sim_blk['name'] = sim_blk_name
                sim_blk['port'] = port
                blk = self._get_blk_by_id(dst_blk_id)
                sim_blk['tag'] = blk['tag']
                self.sim_blocks.append(sim_blk)
                # log it
                self.logger.info('-- Sim Block: %s, Port: %s, Tag: %s' % (sim_blk_name, port['name'], sim_blk['tag']))
    
    def gen_sim_objs(self):
        """
        Generate the simulation data for the casper simulation.
        sim_blk_info is a dict with the sim block name, port name and width.
        """
        for sim_block in self.sim_blocks:
            self.logger.info('Creating simulation obj: %s' % sim_block['tag'])
            self.sim_objs.append(SimBlock.make_block(sim_block))
