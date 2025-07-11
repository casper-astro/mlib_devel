import numpy as np
import logging
import os
import json

from io import StringIO
from datetime import datetime
from pyDigitalWaveTools.vcd.parser import VcdParser
from pyDigitalWaveTools.vcd.common import VCD_SIG_TYPE, VcdVarScope
from pyDigitalWaveTools.vcd.parser import VcdParser, VcdVarParsingInfo
from pyDigitalWaveTools.vcd.value_format import VcdBitsFormatter, LogValueFormatter
from pyDigitalWaveTools.vcd.writer import VcdWriter, VcdVarWritingScope

'''
Interal use in VcdWriter
'''
class MaskedValue():

    def __init__(self, val, vld_mask):
        self.val = val
        self.vld_mask = vld_mask

def _expand_vals(val, tick, nsamples):
    logger = logging.getLogger('jasper-sim.expand_vals')
    logger.info('expand vcd vals')
    tmp = np.zeros(nsamples, dtype=object)
    last_i = 0
    last_v = val[0][1]
    tmp[0] = last_v
    if len(val) == 1:
        tmp[1:] = dout[0]
    else:
        for d in val[1:]:
            cur_i = d[0]//tick
            tmp[last_i + 1: cur_i] = tmp[last_i]
            tmp[cur_i] = d[1]
            last_i = cur_i
    tmp[last_i:nsamples] = tmp[last_i]
    dout = []
    for i in range(nsamples):
        dout.append((i*tick, tmp[i]))
    return dout

"""
The SimDataWriter is a base class
"""
class SimDataGUI(object):
    def __init__(self, data, nsamples, tick, filename):
        self.data = data
        self.tick = tick
        self.filename = filename
        self.nsamples = nsamples
    
    def WriteSimData(self):
        '''
        Write Sim data into file.
        '''
        pass

    def ShowSimData(self):
        '''
        Show Sim data.
        '''
        pass

"""
The VcdWriter class implments some methods for the vcd file generation.
"""
class CasperGTKWave(SimDataGUI):
    def __init__(self, data, nsamples, tick=500, filename='casper_simulation.vcd'):
        super().__init__(data, nsamples, tick, filename)
        self.logger = logging.getLogger('jasper-sim.sim_gtkwave')
        self.logger.info('nsamples is %d'%nsamples)
        self.logger.info('tick is %d'%tick)

    def get_val_mask(self, d, w):
        '''
        This function converts str to binary, 
        and also returns a mask for future use.
        '''
        self.logger.debug('getting val and mask: d - %s w - %d'%(d, w))
        if not d.startswith('b'):
            return int(d,2), 1
        else:
            val = ''
            mask= ''
            for i in range(w):
                try:
                    b = d[i+1]
                    if b == 'x':
                        val += '0'
                        mask += '0'
                    else:
                        val += b
                        mask += '1'
                except:
                    mask += '1'
            return int(val, 2), int(mask, 2)
        
    def WriteSimData(self):
        out = StringIO()
        vcdout = VcdWriter(out)
        # record the current time 
        date = datetime.now()
        vcdout.date(date)
        vcdout.timescale(1)
        vals = self.data
        with vcdout.varScope("casper_simumation") as sim:
            for val in vals:
                # get signal info
                sig = val['name']
                self.logger.info('sig name: %s'%sig)
                bitwidth = val['type']['width']
                sig_type = val['type']['name']
                # add the signal
                # TODO: the type is always WIRE.
                #       I dont think we will have other types here, as this is a scope??
                sim.addVar(sig, sig, VCD_SIG_TYPE.WIRE, bitwidth, VcdBitsFormatter())
                # expand the data filed
                # we should have nsamples simulation data for each signal
                tmp = _expand_vals(val['data'], self.tick, self.nsamples)
                val['data'] = tmp
            
            for i in range(self.nsamples):
                for val in vals:
                    sig = val['name']
                    bitwidth = val['type']['width']
                    d = val['data'][i]
                    t = d[0]
                    v,m = self.get_val_mask(d[1], bitwidth)
                    vcdout.logChange(t, sig, MaskedValue(v,m), None)
        self.logger.info('Writing simulation into %s'%self.filename)
        with open(self.filename, mode='w') as f:
            f.write(out.getvalue())
    
    def ShowSimData(self):
        cmd = 'gtkwave %s &'%self.filename
        os.system(cmd)

"""
The CasperRawData class implments some methods for the raw sim data file generation.
"""
class CasperRawData(SimDataGUI):
    def __init__(self, data, nsamples, tick=500, filename='casper_simulation.json'):
        super().__init__(data, nsamples, tick, filename)
        self.logger = logging.getLogger('jasper-sim.sim_rawdata')
        self.logger.info('nsamples is %d'%nsamples)
        self.logger.info('tick is %d'%tick)
    
    def WriteSimData(self):
        for val in self.data:
            # get signal info
            sig = val['name']
            self.logger.info('sig name: %s'%sig)
            # expand the data filed
            # we should have nsamples simulation data for each signal
            tmp = _expand_vals(val['data'], self.tick, self.nsamples)
            val['data'] = tmp
        simdata = {}
        simdata['simdata'] = self.data
        with open(self.filename, 'w', encoding='utf-8') as f:
            json.dump(simdata, f, indent=4)

"""
The CasperPyplot class implments a method to use matplotlib to show the sim data.
"""
class CasperPyplot(CasperRawData):
    def __init__(self, data, nsamples, tick=500, filename='casper_simulation.json'):
        super().__init__(data, nsamples, tick, filename)
        self.logger = logging.getLogger('jasper-sim.sim_pyplot')
        self.logger.info('nsamples is %d'%nsamples)
        self.logger.info('tick is %d'%tick)
    
    def WriteSimData(self):
        return super().WriteSimData()
    
    def ShowSimData(self):
        '''
        call sim_guis/sim_pyplot.py to show the sim data.
        '''
        self.logger.info('Show sim data with pyplot.')
        mlib_devel_path = os.getenv('MLIB_DEVEL_PATH')
        script_path = '%s/scilab_library/sim_guis/sim_pyplot.py'%mlib_devel_path
        cmd = 'python %s -f %s &'%(script_path, self.filename)
        os.system(cmd)

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
