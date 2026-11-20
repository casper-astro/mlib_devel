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
# create simulation dir, if it doesn't exist
simdir = builddir + '/simulation'
if not os.path.exists(simdir):
    os.makedirs(simdir)
    logger.info('Created the simulation directory.')
else:
    logger.info('The simulation directory is already created.')
    logger.info(f'Simdir: {simdir}')
# we have to change the HDL_ROOT first, as dspflow will use a different HDL_ROOT
# in the YellowBlock classs, self.initialize() is called in the __init__ method
# this method will use the HDL_ROOT to get the hdl files.
mlib_devel_path = os.getenv('MLIB_DEVEL_PATH')
jasper_hdl_root = os.getenv('HDL_ROOT')
dsp_hdl_root = os.getenv('DSP_HDL_ROOT')
if dsp_hdl_root is None:
    os.environ['HDL_ROOT'] = mlib_devel_path+'/scilab_library/hdl_sources'
else:
    os.environ['HDL_ROOT'] = dsp_hdl_root

sim = simflow.SIMflow(builddir)
sim.get_ip_core_info()
sim.get_sim_info()
sim.gen_sim_objs()
sim.gen_sim_data()
sim.gen_testbench()
sim.gen_sim_proj()
if opts.use_vivado:
    sim.simbackend.run_sim()
sim.get_sim_data()
sim.show_sim_data(opts.gui)

# After finishing the simulation, 
# we need t0 set the HDL_ROOT back to the original value
os.environ['HDL_ROOT'] = jasper_hdl_root
