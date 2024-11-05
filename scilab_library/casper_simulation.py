import os
import logging
from argparse import ArgumentParser
from mlib_devel.scilab_library.simflow import SIMflow

parser = ArgumentParser(prog=os.path.basename(__file__))
                            
parser.add_argument("-c", "--builddir", dest="builddir", type=str,
            default='',
            help="build directory. Default: Use directory with same name as model")
parser.add_argument("-m", "--model", dest="model", type=str,
            default='/tools/mlib_devel/jasper_library/test_models/test.slx',
            help="model to compile")

opts = parser.parse_args()
builddir = opts.builddir or opts.model.split('.')[0]

logger = logging.getLogger('jasper-sim')
logger.setLevel(logging.DEBUG)
handler = logging.FileHandler('%s/jasper-sim.log' % builddir, mode='w')
handler.setLevel(logging.DEBUG)
logformat = logging.Formatter('%(levelname)s - %(asctime)s - %(name)s - %(message)s')
handler.setFormatter(logformat)
logger.addHandler(handler)
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)
logger.addHandler(ch)
logger.info('Starting Simulation')

sim = SIMflow()
sim.get_ip_core_info()
sim.get_sim_info()
sim.gen_sim_objs()