import os
import logging
import toolflow
import os

##############################################################
##############################################################
##############################################################
# The simulink model to compile
MODELNAME = '/tools/mlib_devel/jasper_library/test_models/test.slx'
# The build directory
CD = '/home/jack/temp/toolflow_test'
os.system('mkdir -p %s'%CD)

SKIP_PER = False #skip generating the peripherals file
SKIP_COMPILE = False #skip running sysgen
##############################################################
##############################################################
##############################################################

# logging stuff...
logger = logging.getLogger('jasper')
logger.setLevel(logging.DEBUG)

handler = logging.FileHandler('%s/jasper.log'%CD, mode='w')
handler.setLevel(logging.DEBUG)
format = logging.Formatter('%(levelname)s - %(asctime)s - %(name)s - %(message)s')
handler.setFormatter(format)

logger.addHandler(handler)
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)
logger.addHandler(ch)

logger.info('Starting compile')


# initialise the toolflow
toolflow = toolflow.Toolflow(frontend='simulink', backend='vivado', compile_dir=CD)

#toolflow.set_compile_dir(CD)

print 'configuring frontend'
toolflow.frontend.configure(MODELNAME)

print 'generating frontend peripheral file'
# Skip this if you already have an up to date peripheral file (saves some time for testing)
toolflow.periph_file = toolflow.frontend.gen_periph_file(skip=SKIP_PER)

# Have the toolflow parse the information from the
# frontend and generate the YellowBlock objects
print 'generating peripheral objects'
toolflow.gen_periph_objs()

# Copy the platforms top-level hdl file
# and begin modifying it based on the yellow
# block objects.
print 'Generating HDL'
toolflow.copy_top()
toolflow.generate_hdl()
# Generate constraints (not yet xilinx standard)
toolflow.generate_consts()

# Generate the tcl file which will start a new
# vivado project, and add appropriate
# hdl/constraint sources
print 'Initializing backend project'
toolflow.backend.initialize(toolflow.plat)
toolflow.add_sources()

# Run system generator (maybe flow-wise
# it would make sense to run this sooner,
# but since it's the longest single step
# it's nice to run it at the end, so there's
# an opportunity to catch toolflow errors
# before waiting for it
print 'Running frontend compile'
# skip this step if you don't want to wait for sysgen in testing
toolflow.frontend_compile(update=True,skip=SKIP_COMPILE)
print 'frontend complete'


# Backend compile
# Generate a vivado spec constraints file from the
# constraints extracted from yellow blocks
toolflow.backend.gen_constraint_file(toolflow.constraints, toolflow.plat)
# launch vivado via the generated .tcl file
toolflow.backend.compile()

exit()
