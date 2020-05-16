#! /usr/bin/env python

import os
import sys
import logging
from argparse import ArgumentParser
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

if __name__ == '__main__':
    parser = ArgumentParser(prog=os.path.basename(__file__))
                            
    parser.add_argument("--perfile", dest="perfile", action='store_true',
                    default=False, help="Run Frontend peripheral file generation")
    parser.add_argument("--frontend", dest="frontend", action='store_true',
                    default=False, help="Run Frontend IP compile")
    parser.add_argument("--middleware", dest="middleware", action='store_true',
                    default=False, help="Run Toolflow middle")
    parser.add_argument("--backend", dest="backend", action='store_true',
                    default=False, help="Run backend compilation")
    parser.add_argument("--software", dest="software", action='store_true',
                    default=False, help="Run software compilation")
    parser.add_argument("--be", dest="be", type=str, default='vivado',
                    help="Backend to use. Default: vivado")
    parser.add_argument("--sysgen", dest="sysgen", type=str, default='',
                    help="Specify a specific sysgen startup script.")
    parser.add_argument("--jobs", dest="jobs", type=int, default=4,
                    help="Number of cores to run compiles with. Default=4")
    parser.add_argument("--nonprojectmode", dest="nonprojectmode",
                    action='store_false', default=True,
                    help="Project Mode is enabled by default/Non Project Mode "
                        "is disabled by Default (NB: Vivado Only)")
    parser.add_argument("-m", "--model", dest="model", type=str,
                    default='/tools/mlib_devel/jasper_library/test_models/'
                            'test.slx',
                    help="model to compile")
    parser.add_argument("-c", "--builddir", dest="builddir", type=str,
                    default='',
                    help="build directory. Default: Use directory with same "
                        "name as model")
    
    vivado_synth_strats_list = ['Flow_AreaOptimized_high',
                                'Flow_AreaOptimized_medium',
                                'Flow_AreaMultThresholdDSP',
                                'Flow_AlternateRoutability',
                                'Flow_PerfOptimized_high',
                                'Flow_PerfThresholdCarry',
                                'Flow_RuntimeOptimized']

    vivado_synth_strats_str = '\n ||'.join(vivado_synth_strats_list)
    parser.add_argument("--synth_strat", dest="synth_strat",
                    type=str, default=None,
                    help="Specify the Synthesis Strategy for your compile. "
                            "Your options are: ||{}".format(vivado_synth_strats_str))

    vivado_impl_strats_list = ['Performance_Explore',
                               'Performance_ExplorePostRoutePhysOpt',
                               'Performance_ExploreWithRemap',
                               'Performance_WLBlockPlacement',
                               'Performance_WLBlockPlacementFanoutOpt',
                               'Performance_EarlyBlockPlacement',
                               'Performance_NetDelay_high',
                               'Performance_NetDelay_low',
                               'Performance_Retiming',
                               'Performance_ExtraTimingOpt',
                               'Performance_RefinePlacement',
                               'Performance_SpreadSLLs',
                               'Performance_BalanceSLLs',
                               'Performance_BalanceSLRs',
                               'Performance_HighUtilSLRs',
                               'Congestion_SpreadLogic_high',
                               'Congestion_SpreadLogic_medium',
                               'Congestion_SpreadLogic_low',
                               'Congestion_SSI_SpreadLogic_high',
                               'Congestion_SSI_SpreadLogic_low',
                               'Area_Explore',
                               'Area_ExploreSequential',
                               'Area_ExploreWithRemap',
                               'Power_DefaultOpt',
                               'Power_ExploreArea',
                               'Flow_RunPhysOpt',
                               'Flow_RunPostRoutePhysOpt',
                               'Flow_RuntimeOptimized',
                               'Flow_Quick']

    vivado_impl_strats_str = ' \n ||'.join(vivado_impl_strats_list)
    parser.add_argument("--impl_strat", dest="impl_strat",
                    type=str, default=None,
                    help="Specify the Implementation Strategy for your compile. "
                            "Your options are: ||{}".format(vivado_impl_strats_str))
    
    opts = parser.parse_args()
    sys.argv = [sys.argv[0]] # Keep only the script name. Flush other options

    # if we don't have the environment set up, source the default config file
    if 'XILINX_PATH' not in list(sorted(os.environ.keys())):
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

        if opts.synth_strat is not None:
            # Check if the Strategy specified exists/is known
            # - Looking for a direct match, albeit as lower-case
            result = [synth_strat for synth_strat in vivado_synth_strats_list 
                        if opts.synth_strat.lower() == synth_strat.lower()]

            if len(result) < 1:
                # Problem
                errmsg = 'Synthesis Strategy specified is not supported - {}. ' \
                            '\nChoose from the following options:\n ||{}'.format(opts.synth_strat, vivado_synth_strats_str)
                logger.error(errmsg)
                raise ValueError

            opts.synth_strat = result[0]
            logger.debug('Using the following Synthesis Strategy: {}'.format(opts.synth_strat))
            

        if opts.impl_strat is not None:
            # Check if the Strategy specified exists/is known
            # - Looking for a direct match, albeit as lower-case
            result = [impl_strat for impl_strat in vivado_impl_strats_list
                        if opts.impl_strat.lower() == impl_strat.lower()]
            
            if len(result) < 1:
                # Problem
                errmsg = 'Implementation Strategy specified is not supported - {}. ' \
                            '\nChoose from the following options:\n ||{}'.format(opts.impl_strat, vivado_impl_strats_str)
                logger.error(errmsg)
                raise ValueError

            opts.impl_strat = result[0]
            logger.debug('Using the following Implementation Strategy: {}'.format(opts.impl_strat))
            
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
            backend.compile(cores=opts.jobs, plat=platform,
                            synth_strat=opts.synth_strat, impl_strat=opts.impl_strat)
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
            backend.compile(cores=opts.jobs, plat=platform,
                            synth_strat=opts.synth_strat, impl_strat=opts.impl_strat)

        if opts.software:
            binary = backend.binary_loc
            hex_file = backend.hex_loc
            mcs_file = backend.mcs_loc
            prm_file = backend.prm_loc

            backend.output_fpg = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d.fpg' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)

            #Generate the hex timestamp for the golden and multiboot images, if selected
            if platform.boot_image == 'golden':
                backend.output_bin = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_golden.bin' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_hex = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_golden.hex' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_mcs = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_golden.mcs' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_prm = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_golden.prm' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
            elif platform.boot_image == 'multiboot':
                backend.output_bin = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_multiboot.bin' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_hex = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_multiboot.hex' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_mcs = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_multiboot.mcs' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)
                backend.output_prm = tf.frontend_target_base[:-4] + '_%d-%02d-%02d_%02d%02d_multiboot.prm' % (
                tf.start_time.tm_year, tf.start_time.tm_mon, tf.start_time.tm_mday,
                tf.start_time.tm_hour, tf.start_time.tm_min)

            #Only generate the bof and fpg files if a toolflow image
            if platform.boot_image == 'toolflow':
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
                print('Created %s/%s' % (backend.output_dir, backend.output_bof))
                backend.mkfpg(binary, backend.output_fpg)
                print('Created %s/%s' % (backend.output_dir, backend.output_fpg))

            # Only generate the hex and mcs files if a golden image or multiboot image
            if platform.boot_image == 'golden' or platform.boot_image == 'multiboot':
                os.system('cp %s %s/%s' % (
                    binary, backend.output_dir, backend.output_bin))
                os.system('cp %s %s/%s' % (
                    hex_file, backend.output_dir, backend.output_hex))
                os.system('cp %s %s/%s' % (
                    mcs_file, backend.output_dir, backend.output_mcs))
                os.system('cp %s %s/%s' % (
                    prm_file, backend.output_dir, backend.output_prm))
                print('Created bin file: %s/%s' % (backend.output_dir, backend.output_bin))
                print('Created hex file: %s/%s' % (backend.output_dir, backend.output_hex))
                print('Created mcs file: %s/%s' % (backend.output_dir, backend.output_mcs))
                print('Created prm file: %s/%s' % (backend.output_dir, backend.output_prm))

    # end
