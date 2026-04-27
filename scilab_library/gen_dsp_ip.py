#! /usr/bin/env python

import os, json
import re
import sys

import logging
from argparse import ArgumentParser
import dspflow


def _extract_assignment_path(cmd):
    match = re.match(
        r'^\s*set_global_assignment\s+-name\s+'
        r'(?:VHDL_FILE|VERILOG_FILE|SYSTEMVERILOG_FILE)\s+"?([^"\n]+)"?',
        cmd.strip(),
        re.IGNORECASE,
    )
    if match:
        return os.path.abspath(match.group(1))
    return None


def _sanitize_quartus_source_cmds(backend):
    """
    Remove raw work-library source assignments for files that are also added
    via block-specific library-aware Tcl. This prevents duplicate design units
    such as:

      - work.pulse_ext          (from Castro/import_from_castro)
      - casper_misc_lib.pulse_ext (from simple_bram_vacc/wbfft Tcl)

    while still keeping plain HDL-only blocks like counter/slice available.
    """
    library_managed = set()
    for stage_name, stage_cmds in backend.tcl_cmds.items():
        if isinstance(stage_cmds, str):
            stage_cmds = stage_cmds.splitlines()
        for cmd in stage_cmds or []:
            if ' -library ' not in cmd:
                continue
            source_path = _extract_assignment_path(cmd)
            if source_path:
                library_managed.add(source_path)

    if not library_managed:
        return

    pre_synth_lines = backend.tcl_cmds.get('pre_synth', '').splitlines()
    filtered_lines = []
    removed = []

    for line in pre_synth_lines:
        source_path = _extract_assignment_path(line)
        if source_path and source_path in library_managed and ' -library ' not in line:
            removed.append(source_path)
            continue
        filtered_lines.append(line)

    if removed:
        logger = logging.getLogger('jasper')
        for source_path in sorted(set(removed)):
            logger.info('Removing raw Quartus source assignment superseded by library-managed Tcl: %s', source_path)
        backend.tcl_cmds['pre_synth'] = '\n'.join(filtered_lines)
        if filtered_lines:
            backend.tcl_cmds['pre_synth'] += '\n'

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
    jasper_hdl_root_scilab = os.getenv('HDL_ROOT_SCILAB')
    scilab_hdl_root = os.getenv('SCILAB_HDL_ROOT')
    dsp_hdl_root = os.getenv('DSP_HDL_ROOT')

    # Prefer the long-standing HDL_ROOT_SCILAB variable first, then accept the
    # newer aliases for backward compatibility.
    effective_scilab_hdl_root = (
        jasper_hdl_root_scilab
        or scilab_hdl_root
        or dsp_hdl_root
        or (mlib_devel_path + '/scilab_library/hdl_sources')
    )

    os.environ['HDL_ROOT'] = effective_scilab_hdl_root
    os.environ['HDL_ROOT_SCILAB'] = effective_scilab_hdl_root
    # get build directory
    # use user defined gen_dsp_ip directory else use a directory with same name as model
    builddir = opts.builddir or opts.model.split('.')[0]
    # create the build directory before opening the log file
    os.makedirs(builddir, exist_ok=True)
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
    if jasper_hdl_root is None:
        os.environ.pop('HDL_ROOT', None)
    else:
        os.environ['HDL_ROOT'] = jasper_hdl_root

    if jasper_hdl_root_scilab is None:
        os.environ.pop('HDL_ROOT_SCILAB', None)
    else:
        os.environ['HDL_ROOT_SCILAB'] = jasper_hdl_root_scilab
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

        # Belt-and-suspenders: explicitly add the DSPflow source list to the Quartus
        # wrapper project, but avoid re-adding files already managed by a block's
        # library-aware gen_tcl_cmds() output. Re-injecting those files into the
        # default work library can create duplicate design units (for example the
        # VHDL casper_misc_lib.pulse_ext versus the standalone Verilog pulse_ext).
        explicit_source_re = re.compile(
            r'^\s*set_global_assignment\s+-name\s+'
            r'(?:VHDL_FILE|VERILOG_FILE|SYSTEMVERILOG_FILE)\s+"?([^"\n]+)"?',
            re.IGNORECASE,
        )
        explicit_sources = set()
        for stage_cmds in backend.tcl_cmds.values():
            if isinstance(stage_cmds, str):
                stage_cmds = stage_cmds.splitlines()
            for cmd in stage_cmds or []:
                if not isinstance(cmd, str):
                    continue
                match = explicit_source_re.match(cmd.strip())
                if match:
                    explicit_sources.add(os.path.abspath(match.group(1)))

        seen_sources = set()
        for source in tf.sources:
            if not source.lower().endswith(('.v', '.sv', '.vhd', '.vhdl')):
                continue

            abs_source = os.path.abspath(source)
            if abs_source in seen_sources or abs_source in explicit_sources:
                continue

            seen_sources.add(abs_source)
            backend.add_source(abs_source, platform)

        # Defensive guard: a valid Quartus Tcl script must begin with project
        # initialization commands. If the init stage somehow ended up empty,
        # re-run initialize() before compile instead of emitting a malformed
        # gogogo.tcl that starts with bare source assignments.
        if not backend.tcl_cmds.get('init', '').strip():
            logger.warning('Quartus DSP backend init stage was empty before compile; re-running initialize().')
            backend.initialize()

        if not backend.tcl_cmds.get('init', '').strip():
            raise RuntimeError('Quartus DSP backend init stage is empty; refusing to write malformed gogogo.tcl')

        print('Starting compilation')
        backend.compile(cores=opts.jobs, plat=platform)
        print('Finished compilation')
        # copy gogogo.tcl to dspproj.tcl, as  gogogo.tcl will be overwritten.
        os.system('cp %s/gogogo.tcl %s/dspproj.tcl' % (backend.compile_dir, backend.compile_dir))
        # let's delete gogogo.tcl, as it's not needed anymore
        os.system('rm %s/gogogo.tcl' % backend.compile_dir)
    else:
        # TODO: Add support for other backends
        pass
