import os
import logging
from argparse import ArgumentParser
import simflow

parser = ArgumentParser(prog=os.path.basename(__file__))
                            
parser.add_argument("-c", "--builddir", dest="builddir", type=str,
            default='',
            help="build directory. Default: Use directory with same name as model")
parser.add_argument("-m", "--model", dest="model", type=str,
            default='/tools/mlib_devel/jasper_library/test_models/test.slx',
            help="model to compile")
parser.add_argument("-g", "--gui", dest="gui", type=str,
            default='gtkwave',
            help="The GUI for showing the simulation data.")
parser.add_argument("--use-vivado", dest="use_vivado", action='store_false',
            default=True,
            help="Use Vivaod for the simulation, instead of using the old sim data.")

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

sim = simflow.SIMflow(builddir)
sim.get_ip_core_info()
sim.get_sim_info()
sim.gen_sim_objs()
sim.gen_sim_data()
sim.gen_testbench()
sim.gen_sim_tcl()
if opts.use_vivado:
    sim.run_sim()
sim.get_sim_data()
sim.show_sim_data(opts.gui)
