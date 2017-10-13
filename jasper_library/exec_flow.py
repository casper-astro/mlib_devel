#! /usr/bin/env python

import os
import logging
from optparse import OptionParser
import toolflow

# A straight lift from StackOverflow...


def shell_source(script):
    """Sometime you want to emulate the action of "source" in bash,
    settings some environment variables. Here is a way to do it."""
    import subprocess
    import os
    pipe = subprocess.Popen(". %s > /dev/null; env" % script,
                            stdout=subprocess.PIPE, shell=True)
    output = pipe.communicate()[0]
    env = dict((line.split("=", 1) for line in output.splitlines()))
    os.environ.update(env)

parser = OptionParser()
parser.add_option("--perfile", dest="perfile", action='store_true',
                  default=False, help="Run Frontend peripheral file generation")
parser.add_option("--frontend", dest="frontend", action='store_true',
                  default=False, help="Run Frontend IP compile")
parser.add_option("--middleware", dest="middleware", action='store_true',
                  default=False, help="Run Toolflow middle")
parser.add_option("--backend", dest="backend", action='store_true',
                  default=False, help="Run backend compilation")
parser.add_option("--software", dest="software", action='store_true',
                  default=False, help="Run software compilation")
parser.add_option("--be", dest="be", type='string', default='vivado',
                  help="Backend to use. Default: vivado")
parser.add_option("--sysgen", dest="sysgen", type='string', default='',
                  help="Specify a specific sysgen startup script.")
parser.add_option("--jobs", dest="jobs", type='int', default=4,
                  help="Number of cores to run compiles with. Default=4")
parser.add_option("--nonprojectmode", dest="nonprojectmode",
                  action='store_false', default=True,
                  help="Project Mode is enabled by default/Non Project Mode "
                       "is disabled by Default (NB: Vivado Only)")
parser.add_option("-m", "--model", dest="model", type='string',
                  default='/tools/mlib_devel/jasper_library/test_models/'
                          'test.slx',
                  help="model to compile")
parser.add_option("-c", "--builddir", dest="builddir", type='string',
                  default='',
                  help="build directory. Default: Use directory with same "
                       "name as model")

(opts, args) = parser.parse_args()

# if we don't have the environment set up, source the default config file
if 'XILINX_PATH' not in os.environ.keys():
    this_file_path = os.path.realpath(__file__)
    config_file_path = os.path.join(os.path.dirname(os.path.dirname(this_file_path)), 'vivado_config.local')
    if os.path.exists(config_file_path):
        shell_source(config_file_path)

# get build directory
# use user defined directory else use a directory with same name as model
builddir = opts.builddir or opts.model[:-4]

# logging stuff...
os.system('mkdir -p %s' % builddir)
logger = logging.getLogger('jasper')
logger.setLevel(logging.DEBUG)

handler = logging.FileHandler('%s/jasper.log' % builddir, mode='w')
handler.setLevel(logging.DEBUG)
logformat = logging.Formatter('%(levelname)s - %(asctime)s - %(name)s - '
                              '%(message)s')
handler.setFormatter(logformat)

logger.addHandler(handler)
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)
logger.addHandler(ch)

logger.info('Starting compile')

if opts.be == 'vivado':
    os.environ['SYSGEN_SCRIPT'] = os.environ['MLIB_DEVEL_PATH'] + '/startsg'
    logger.debug('Vivado compile will be executed.')

if opts.be == 'ise':
    os.environ['SYSGEN_SCRIPT'] = os.environ['MLIB_DEVEL_PATH'] + '/startsg_ise'
    logger.debug('ISE compile will be executed.')

if opts.sysgen != '':
    os.environ['SYSGEN_SCRIPT'] = opts.sysgen

if not os.path.isfile(os.environ['SYSGEN_SCRIPT']):
    raise RuntimeError('Could not find sysgen startup script: '
                       '%s' % os.environ['SYSGEN_SCRIPT'])

# initialise the toolflow
tf = toolflow.Toolflow(frontend='simulink', compile_dir=builddir,
                       frontend_target=opts.model, jobs=opts.jobs)

if opts.perfile:
    tf.frontend.gen_periph_file(tf.periph_file)
    tf.frontend.write_git_info_file()

if opts.frontend:
    tf.frontend.compile_user_ip(update=True)

if opts.middleware:
    tf.gen_periph_objs()
    tf.build_top()
    tf.generate_hdl()
    tf.generate_consts()
    tf.write_core_info()
    tf.write_core_jam_info()
    tf.constraints_rule_check()
    tf.dump_castro(tf.compile_dir+'/castro.yml')

if opts.backend or opts.software:
    try:
        platform = tf.plat
    except AttributeError:
        platform = None

    # if vivado is selected to compile
    if opts.be == 'vivado':
        platform.backend_target = 'vivado'
        # Project Mode assignment (True = Project Mode,
        # False = Non-Project Mode)
        platform.project_mode = opts.nonprojectmode
        backend = toolflow.VivadoBackend(plat=platform,
                                         compile_dir=tf.compile_dir,
                                         periph_objs=tf.periph_objs)
        backend.import_from_castro(backend.compile_dir + '/castro.yml')
        # launch vivado via the generated .tcl file
        backend.compile(cores=opts.jobs, plat=platform)

    # if ISE is selected to compile
    elif opts.be == 'ise':
        platform.backend_target = 'ise'
        # Project Mode assignment (True = Project Mode,
        # False = Non-Project Mode). Not used in ISE.
        platform.project_mode = opts.nonprojectmode
        backend = toolflow.ISEBackend(plat=platform, compile_dir=tf.compile_dir)
        backend.import_from_castro(backend.compile_dir + '/castro.yml')
        # launch ISE via the generated .tcl file
        backend.compile()
    # Default to vivado for compile
    else:
        platform.backend_target = 'vivado'
        # Project Mode assignment (True = Project Mode,
        # False = Non-Project Mode)
        platform.project_mode = opts.nonprojectmode
        backend = toolflow.VivadoBackend(plat=platform,
                                         compile_dir=tf.compile_dir)
        backend.import_from_castro(backend.compile_dir + '/castro.yml')
        # launch vivado via the generated .tcl file
        backend.compile(cores=opts.jobs, plat=platform)

    if opts.software:
        binary = backend.binary_loc
        output_fpg = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d.fpg' % (
            tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
            tf.start_time.tm_hour, tf.start_time.tm_min)

        # generate bot bof and fpg files for all platforms
        backend.output_bof = tf.frontend_target_base[:-4]
        backend.output_bof += '_%d-%02d-%02d_%02d%02d.bof' % (
            tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
            tf.start_time.tm_hour, tf.start_time.tm_min)
        os.system('cp %s %s/top.bin' % (binary, backend.compile_dir))
        mkbof_cmd = '%s/jasper_library/mkbof_64 -o %s/%s -s %s/core_info.tab ' \
                    '-t 3 %s/top.bin' % (os.getenv('MLIB_DEVEL_PATH'),
                                         backend.output_dir,
                                         backend.output_bof,
                                         backend.compile_dir,
                                         backend.compile_dir)
        os.system(mkbof_cmd)
        print 'Created %s/%s' % (backend.output_dir, backend.output_bof)
        backend.mkfpg(binary, output_fpg)

# end
