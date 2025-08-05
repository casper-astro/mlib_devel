#! /usr/bin/env python

import os, json
import sys

import logging
from argparse import ArgumentParser
import dspflow

if __name__ == '__main__':
    parser = ArgumentParser(prog=os.path.basename(__file__))
                            
    parser.add_argument("-c", "--builddir", dest="builddir", type=str,
                default='',
                help="build directory. Default: Use directory with same "
                    "name as model")
    parser.add_argument("-m", "--model", dest="model", type=str,
                    default='/tools/mlib_devel/jasper_library/test_models/'
                            'test.slx',
                    help="model to compile")
    parser.add_argument("--jobs", dest="jobs", type=int, default=4,
                    help="Number of cores to run compiles with. Default=4")
    parser.add_argument("--be", dest="be", type=str, default='vivado',
                    help="Backend to use. Default: vivado")
    
    opts = parser.parse_args()
    
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
    # get build directory
    # use user defined directory else use a directory with same name as model
    builddir = opts.builddir or opts.model.split('.')[0]

    # create the build directory, and log file
    logger = logging.getLogger('jasper')
    logger.setLevel(logging.DEBUG)
    handler = logging.FileHandler('%s/jasper-dsp.log' % builddir, mode='w')
    handler.setLevel(logging.DEBUG)
    logformat = logging.Formatter('%(levelname)s - %(asctime)s - %(name)s - %(message)s')
    handler.setFormatter(logformat)
    logger.addHandler(handler)
    logger.info('Starting generating DSP IP')

    tf = dspflow.DSPflow(builddir, opts.jobs)
    tf.gen_dsp_objs()
    tf.build_top()
    tf.generate_hdl()
    tf.dump_castro(tf.compile_dir+'/castro.yml')
    # let's set the HDL_ROOT back to the original value
    os.environ['HDL_ROOT'] = jasper_hdl_root
    # use Non-project mode to genenrate the vivado project
    # TODO: Do we need project mode to generate this project?
    print('THE BACKEND IS: ' + str(opts.be))
    if opts.be == 'vivado':
        platform = tf.plat
        platform.project_mode = True
        backend = dspflow.VivadoDSPBackend(plat=platform,
                                                compile_dir=tf.compile_dir,
                                                periph_objs=tf.periph_objs)
        backend.import_from_castro(backend.compile_dir + '/castro.yml')
        # set a new project name, so that it's different from the original project(myproj)
        backend.project_name = 'dspproj'
        backend.initialize()
        backend.compile(cores=opts.jobs, plat=platform)
        # copy gogogo.tcl to dspproj.tcl, as  gogogo.tcl will be overwritten.
        os.system('cp %s/gogogo.tcl %s/dspproj.tcl' % (backend.compile_dir, backend.compile_dir))
        # let's delete gogogo.tcl, as it's not needed anymore
        os.system('rm %s/gogogo.tcl' % backend.compile_dir)
    elif opts.be == 'quartus':
        platform = tf.plat
        platform.project_mode = True
        backend = dspflow.QuartusDSPBackend(plat=platform,
                                                compile_dir=tf.compile_dir,
                                                periph_objs=tf.periph_objs)
        backend.import_from_castro(backend.compile_dir + '/castro.yml')
        # set a new project name, so that it's different from the original project(myproj)
        backend.project_name = 'dspproj'
        backend.initialize()
        backend.compile(cores=opts.jobs, plat=platform)
        # copy gogogo.tcl to dspproj.tcl, as  gogogo.tcl will be overwritten.
        os.system('cp %s/gogogo.tcl %s/dspproj.tcl' % (backend.compile_dir, backend.compile_dir))
        # let's delete gogogo.tcl, as it's not needed anymore
        os.system('rm %s/gogogo.tcl' % backend.compile_dir)
    else:
        # TODO: Add support for other backends
        pass
