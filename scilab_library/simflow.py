import json
import logging
from sim_blocks.sim_block import SimBlock
import numpy as np
import os
from matplotlib import pyplot as plt

"""
This class generates a simulation object,
 that can be used for casper simulations.
"""
class SIMflow(object):
    def __init__(self, builddir, model_info_file='jasper.json'):
        """
        The input files are the jasper.json and jasper.sim files.
        In the jasper.json file, we have the IP core information.
        In the jasper.sim file, we have the simulation information.
        """
        self.logger = logging.getLogger('jasper-sim.simflow')
        self.builddir = builddir
        self.model_info = json.load(open(builddir+'/'+model_info_file))
        self.ip_core={}
        self.sim_blocks=[]
        self.sim_objs=[]
        self.simdata = []
                         
    def _get_sim_blk_by_name(self, blkname):
        """
        Get the simulation block information by the block name.
        """
        self.logger.info('Getting block information for blk name: %s' % blkname)
        sim_blocks = self.model_info['sim_blocks']
        blk_info = {}
        for block in sim_blocks:
            if block['name'] == blkname:
                for k,v in block.items():
                    # we already know the name
                    if k == 'name':
                        continue
                    # tag is important, so we move it out from the dict
                    if k == 'tag':
                        tag = v.split(':')[1]
                        continue
                    blk_info[k] = v
        return tag, blk_info
                    
            
    def _get_port_from_link_by_dst_blk_name(self, blkname):
        """
        Get the port information from the link dict by the dst blk name.
        Only one port should be found, as the dst block should only be driven by one blk.
        """
        self.logger.info('Searching src port information for blk : %s' % blkname)
        blk_name = 'src_blk_name'
        port_name = 'src_port_name'
        port_width = 'src_port_width'
        link_info = self.model_info['link_info']
        for link in link_info:
            if link[blk_name] == blkname:
                port = {}
                port['name'] = link[port_name]
                port['width'] = link[port_width]
                self.logger.info('Port Name: %s, Width: %s' % (port['name'], port['width']))
                return port

    def _get_port_from_link_by_src_blk_name(self, blkname):
        """
        Get the port information from the link dict by the src blk name.
        You may get more than one port, as the src block may drive more than one dst blocks.
        """
        self.logger.info('Searching dst port information for blk : %s' % blkname)
        blk_name = 'src_blk_name'
        port_name = 'src_port_name'
        port_width = 'src_port_width'
        port_list = []
        link_info = self.model_info['link_info']
        for link in link_info:
            if link[blk_name] == blkname:
                port = {}
                port['name'] = link[port_name]
                port['width'] = link[port_width]
                self.logger.info('Port Name: %s, Width: %s' % (port['name'], port['width']))
                port_list.append(port)
        return port_list

    def get_ip_core_info(self):
        """
        Get the IP core info from the jasper.json.
        We need port name and width information for the IP core.
        """
        self.logger.info('Getting IP core information')
        # get the ip core name
        self.ip_core['name'] = self.model_info['project']['filename'].split('/')[-1].split('.')[0] + '_core'
        # log it
        self.logger.info('IP Core Name: %s' % self.ip_core['name'])
        # get the input ports and output ports info
        self.ip_core['iports'] = {}
        self.ip_core['iports']['name'] = []
        self.ip_core['iports']['width'] = []
        self.ip_core['oports'] = {}
        self.ip_core['oports']['name'] = []
        self.ip_core['oports']['width'] = []
        link_objs = self.model_info['link_info']
        for link in link_objs:
            if link['link_type'] == 'xps_dsp':
                port = {}
                # this is an input port for the IP core
                port['name'] = link['src_port_name']
                port['width'] = link['src_port_width']
                if port['name'] not in self.ip_core['iports']['name']:
                    self.ip_core['iports']['name'].append(port['name'])
                    self.ip_core['iports']['width'].append(port['width'])
                # log it
                self.logger.info('Input port: %s, Width: %s' % (link['src_port_name'], link['src_port_width']))
            elif link['link_type'] == 'dsp_xps':
                port = {}
                # this is an output port for the IP core
                port['name'] = link['dst_port_name']
                port['width'] = link['dst_port_width']
                if port['name'] not in self.ip_core['oports']['name']:
                    self.ip_core['oports']['name'].append(port['name'])
                    self.ip_core['oports']['width'].append(port['width'])
                # log it
                self.logger.info('Output port: %s, Width: %s' % (link['dst_port_name'], link['dst_port_width']))

    def get_sim_info(self):
        """
        Get simulation block information from the jasper.sim file.
        We need to figure out each simulation block is connected to which IP core port.
        """
        self.logger.info('Getting simulation blocks information')
        sim_link_objs = self.model_info['link_info']
        # get the dir for the sim data file storage.
        sim_dir = self.builddir + '/simulation'
        for slink in sim_link_objs:
            if slink['link_type'].startswith('sim_'):
                # this should be a source sim block, like a signal generator
                # TODO: is it possible to connect a source sim block ot a dsp block??
                dst_blk_name = slink['dst_blk_name']
                port = self._get_port_from_link_by_dst_blk_name(dst_blk_name)
                sim_blk_name = slink['src_blk_name']
                # get the port info, which is from the IP core.
                # Here, we should know which IP core port the sim block is connected to.
                sim_blk = {}
                sim_blk['type'] = 'source'
                sim_blk['name'] = sim_blk_name
                sim_blk['port'] = port
                sim_blk['dir'] = sim_dir
                [tag, val] = self._get_sim_blk_by_name(sim_blk_name)
                sim_blk['tag'] = tag
                sim_blk['val'] = val
                self.sim_blocks.append(sim_blk)
                # log it
                self.logger.info('Sim Source Block: %s, Port: %s, Tag: %s' % (sim_blk_name, port['name'], sim_blk['tag']))
            if slink['link_type'].endswith('_sim'):
                # this should be a destination sim block, like a scope
                src_blk_name = slink['src_blk_name']
                # two possible cases: xps_sim and sim_xps
                if slink['link_type'] == 'xps_sim':
                    port_list = self._get_port_from_link_by_src_blk_name(src_blk_name)
                    # we may get more than one port.
                    # we just need to use the port, whose name is not the same as the dst port name.
                    port = {}
                    for p in port_list:
                        if p['name'] != slink['dst_port_name']:
                            port = p
                            break
                    if port is None:
                        self.logger.error('No port found for the destination sim block: %s' % slink['dst_blk_name'])
                        exit(1)
                elif slink['link_type'] == 'dsp_sim':
                    port = {}
                    port['name'] = slink['src_port_name']
                    port['width'] = slink['src_port_width']
                sim_blk_name = slink['dst_blk_name']
                sim_blk = {}
                sim_blk['type'] = 'destination'
                sim_blk['name'] = sim_blk_name
                sim_blk['port'] = port
                sim_blk['dir'] = sim_dir
                [tag, val] = self._get_sim_blk_by_name(sim_blk_name)
                sim_blk['tag'] = tag
                sim_blk['val'] = val
                self.sim_blocks.append(sim_blk)
                # log it
                self.logger.info('Sim Dest Block: %s, Port: %s, Tag: %s' % (sim_blk_name, port['name'], sim_blk['tag']))
        # sim:sim block is a very special block, as it's not connected to any blocks.
        # So we need to handle it separately.
        # TODO: we may need to improve this part.
        for blk in self.model_info['sim_blocks']:
            if blk['tag'] == 'sim:sim':
                sim_blk = {}
                sim_blk['name'] = blk['name']
                sim_blk['tag'] = blk['tag'].split(':')[1]
                sim_blk['sim_length'] = int(blk['sim_length'])
                sim_blk['type'] = None
                self.sim_blocks.append(sim_blk)
                self.logger.info('Sim Info Block: %s, Length: %d' % (sim_blk['name'], sim_blk['sim_length']))
    
    def gen_sim_objs(self):
        """
        Generate the simulation data for the casper simulation.
        sim_blk_info is a dict with the sim block name, port name and width.
        """
        for sim_block in self.sim_blocks:
            self.logger.info('Creating simulation obj: %s' % sim_block['tag'])
            self.sim_objs.append(SimBlock.make_block(sim_block))
        if SimBlock.sim_instance == False:
            self.logger.error('No simulation block found')
            exit(1)
    
    def gen_sim_data(self):
        """
        Generate the simulation data for the casper simulation.
        """
        self.logger.info('Generating simulation data')
        for sim_obj in self.sim_objs:
            sim_obj.gen_sim_data()

    def gen_testbench(self):
        """
        Generate the testbench for the casper simulation.
        """
        self.logger.info('Generating testbench')
        clk_period = 1.0
        tb = []
        tb.append('`timescale 1ns/1ps')
        tb.append('')
        tb.append('module %s_tb;' % self.ip_core['name'])
        tb.append('')
        tb.append('reg clk = 0;')
        tb.append('always #%f clk = ~clk;' % float(clk_period/2))
        # tb.append('integer i;')
        tb.append('')
        iport_num = len(self.ip_core['iports']['name'])
        oport_num = len(self.ip_core['oports']['name'])
        for i in range(iport_num):
            name = self.ip_core['iports']['name'][i]
            width = self.ip_core['iports']['width'][i]
            tb.append('reg [%d:0] %s;' % (width-1, name))
        for i in range(oport_num):
            name = self.ip_core['oports']['name'][i]
            width = self.ip_core['oports']['width'][i]
            tb.append('wire [%d:0] %s;' % (width-1, name))

        tb.append('')
        # read data from the simulation files, and use them as the input data
        sim_length = SimBlock.sim_length
        for sim_blk in self.sim_blocks:
            # we only need to do it for the source sim blocks.
            self.logger.info('Sim Block Type: %s' % sim_blk['type'])
            if sim_blk['type'] == 'source':
                self.logger.info('Reading data from %s/%s.dat' % (sim_blk['dir'], sim_blk['name']))
                tb.append('reg [%d:0] %s [0:%d];' % (sim_blk['port']['width']-1, sim_blk['name'], sim_length - 1))
                tb.append('initial begin')
                tb.append('  $readmemh("%s/%s.dat", %s);' % (sim_blk['dir'], sim_blk['name'], sim_blk['name']))
                tb.append('  for (integer i=0; i<%d; i=i+1) begin' % sim_length)
                tb.append('     #%d'%(clk_period/2))
                tb.append('     %s <= %s[i];' % (sim_blk['port']['name'], sim_blk['name']))
                tb.append('  end')
                tb.append('end')
                tb.append('')
        # instantiate the IP core
        tb.append('%s %s_inst(' % (self.ip_core['name'], self.ip_core['name']))
        tb.append('  .clk(clk),')
        for i in range(iport_num):
            name = self.ip_core['iports']['name'][i]
            tb.append('  .%s(%s),' % (name, name))
        for i in range(oport_num):
            name = self.ip_core['oports']['name'][i]
            tb.append('  .%s(%s),' % (name, name))
        tb[-1] = tb[-1][:-1]
        tb.append(');')
        tb.append('')
        tb.append('endmodule')
        # write the testbench into a file
        dir = self.model_info['project']['filename'].split('.')[0] + '/simulation'
        tb_filename = dir + '/' + self.ip_core['name'] + '_tb.v'
        self.logger.info('Writing testbench into %s' % tb_filename)
        with open(tb_filename, 'w') as f:
            for line in tb:
                f.write(line + '\n')

    def gen_sim_tcl(self):
        """
        Generate the simulation tcl file for the casper simulation.
        """
        self.logger.info('Generating simulation tcl file')
        tcl = []
        # add tcl commands to the tcl file
        tcl.append('open_project %s/dspproj/dspproj.xpr' % self.builddir)
        tcl.append('update_compile_order -fileset sources_1')
        tcl.append('set_property SOURCE_SET sources_1 [get_filesets sim_1]')
        tcl.append('add_files -fileset sim_1 -norecurse %s/simulation/%s_tb.v' % (self.builddir, self.ip_core['name']))
        tcl.append('update_compile_order -fileset sim_1')
        tcl.append('set_property top %s_tb [get_filesets sim_1]' % self.ip_core['name'])
        tcl.append('set_property top_lib xil_defaultlib [get_filesets sim_1]')
        tcl.append('update_compile_order -fileset sim_1')
        tcl.append('launch_simulation -mode behavioral')
        #tcl.append('open_vcd %s/simulation/%s_tb.vcd' % (self.builddir, self.ip_core['name']))
        tcl.append('open_vcd %s/simulation/simulation.vcd' % self.builddir)
        tcl.append('log_vcd /%s_tb/%s_inst/*' % (self.ip_core['name'],self.ip_core['name']))
        tcl.append('restart')
        # the time unit is 1ns 
        clk_period = 1.0
        sim_time = SimBlock.sim_length * clk_period
        tcl.append('run %s ns' % sim_time)
        tcl.append('close_vcd')
        tcl.append('close_sim')
        tcl.append('close_project')
        # write the tcl file into a file
        tcl_filename = self.builddir + '/simulation/simulation.tcl'
        self.logger.info('Writing tcl file into %s' % tcl_filename)
        with open(tcl_filename, 'w') as f:
            for line in tcl:
                f.write(line + '\n')
    
    def run_sim(self):
        """
        Run the simulation.
        """
        self.logger.info('Running simulation')
        os.system('cd %s; vivado -mode batch -source simulation/simulation.tcl  >/dev/null 2>&1' % self.builddir)
        self.logger.info('Simulation finished')
    
    def get_sim_data(self):
        """
        Get the simulation data.
        """
        self.logger.info('Getting simulation data')
        for sim_obj in self.sim_objs:
            self.logger.info('Getting simulation data for %s' % sim_obj.name)
            info = {}
            data = sim_obj.get_sim_data()
            # the source sim blocks(like constant) won't return the data, so the data will be None.
            # We don't need to store the data for the source sim blocks.
            if data is not None:
                info['name'] = sim_obj.name
                info['data'] = data
                self.simdata.append(info)
        # actually, we don't have to return the simdata, 
        # as we don't use the return data so far 
        return self.simdata
    
    def plot_sim_data(self):
        """
        Show the simulation data.
        """
        self.logger.info('Plotting simulation data')
        # for sim_obj in self.sim_objs:
        #     sim_obj.plot_sim_data()
        
        # As matplotlib will be blocked after we call plot_sim_data() first time,
        # we'are going to create plots here
        fig_num = len(self.simdata)
        fig = np.zeros(fig_num, dtype=object)
        subfig = np.zeros(fig_num, dtype=object)
        for i in range(fig_num):
            fig[i] = plt.figure()
            subfig[i] = fig[i].add_subplot(111)
            subfig[i].plot(self.simdata[i]['data'])
            subfig[i].set_title(self.simdata[i]['name'])
            subfig[i].set_xlabel('Time/ns')
            subfig[i].set_ylabel('Value')
            subfig[i].grid(True)
            subfig[i].legend()
        plt.show()
