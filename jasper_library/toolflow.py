"""
A python-based toolflow to build a vivado
project from a simulink design, using the
CASPER xps library.

A work in progress.
"""
import logging
import os
import platform
import yellow_blocks.yellow_block as yellow_block
import verilog
from constraints import PortConstraint, ClockConstraint, GenClockConstraint, \
    ClockGroupConstraint, InputDelayConstraint, OutputDelayConstraint, MaxDelayConstraint, \
    MinDelayConstraint, FalsePathConstraint, MultiCycleConstraint, RawConstraint, MAX_IMAGE_CHUNK_SIZE
import castro
import helpers
import yaml
import glob
import time
import hashlib  # Added to calculate md5hash of .bin bitstream and add it to the .fpg header
import struct

try:
    from katversion import get_version as kat_get_version
except ImportError:
    kat_get_version = None


class Toolflow(object):
    """
    A class embodying the main functionality of the toolflow.
    This class is responsible for generating a complete
    top-level verilog description of a project from a 'peripherals file'
    which encodes information about which IP a user wants instantiated.

    The toolflow class can parse such a file, and use it to generate verilog, 
    a list of source files, and a list of constraints.
    These can be passed off to a toolflow backend to be turned into some
    vendor-specific platform and compiled. At least, that's the plan...
    """
    
    def __init__(self, frontend='simulink', compile_dir='/tmp',
                 frontend_target='/tmp/test.slx', jobs=8):
        """
        Initialize the toolflow.
         
        :param frontend: Name of the toolflow frontend to use. 
            Currently only 'simulink' is supported
        :type frontend: str
        :param compile_dir: Compile directory where build files and logs 
            should go.
        """
        # Set up a logger (the logger named 'jasper' should already
        # have been configured beforehand
        self.logger = logging.getLogger('jasper.toolflow')
        self.jobs = jobs

        self.logger.info('Starting Toolflow!')
        self.logger.info('Frontend is %s' % frontend)

        self.compile_dir = compile_dir.rstrip('/')
        self.output_dir = self.compile_dir + '/outputs'

        self.logger.info('Setting compile directory: %s' % self.compile_dir)
        os.system('mkdir -p %s' % self.compile_dir)
        os.system('mkdir -p %s' % self.output_dir)

        # compile parameters which can be set straight away
        self.start_time = time.localtime()
        self.periph_file = self.compile_dir + '/jasper.per'
        self.git_info_file = self.compile_dir + '/git_info.tab'
        self.frontend_target = frontend_target
        self.frontend_target_base = os.path.basename(frontend_target)

        self.cores = None
        self.topfile = None
        self.top = None
        self.periph_objs = None
        self.constraints = None

        if frontend == 'simulink':
            self.frontend = SimulinkFrontend(compile_dir=self.compile_dir,
                                             target=frontend_target)
        else:
            self.logger.error('Unsupported toolflow frontent: %s' % frontend)
            raise Exception('Unsupported toolflow frontend: %s' % frontend)

        self.backend = None
        # if backend == 'vivado':
        #    self.backend = VivadoBackend(compile_dir=self.compile_dir)
        # elif backend == 'ise':
        #    self.backend = ISEBackend(compile_dir=self.compile_dir)
        # else:
        #    self.logger.error('Unsupported toolflow backend: %s'%backend)
        #    raise Exception('Unsupported toolflow backend: %s'%backend)

        self.sources = []
        self.ips = []
        self.tcl_sources = []
        self.const_files = []

    def exec_flow(self, gen_per=True, frontend_compile=True):
        """
        Execute a compile.
        
        :param gen_per: Have the toolflow frontend generate a fresh 
            peripherals file
        :type gen_per: bool
        :param frontend_compile: Run the frontend compiler (eg. System 
            Generator)
        :type frontend_compile: bool
        """

        if gen_per:
            self.frontend.gen_periph_file(fname=self.periph_file)
            self.frontend.write_git_info_file(fname=self.git_info_file)

        # Have the toolflow parse the information from the
        # frontend and generate the YellowBlock objects
        print 'generating peripheral objects'
        self.gen_periph_objs()

        # Copy the platforms top-level hdl file
        # and begin modifying it based on the yellow
        # block objects.
        print 'Generating HDL'
        self.build_top()
        self.generate_hdl()
        # Generate constraints (not yet xilinx standard)
        self.generate_consts()
        # Generate software cores file
        self.write_core_info()
        self.write_core_jam_info()
        # print 'Initializing backend project'
        # self.backend.initialize(self.plat)
        
        self.constraints_rule_check()
        
        if frontend_compile:
            # Run system generator (maybe flow-wise
            # it would make sense to run this sooner, 
            # but since it's the longest single step
            # it's nice to run it at the end, so there's
            # an opportunity to catch toolflow errors
            # before waiting for it
            print 'Running frontend compile'
            # skip this step if you don't want to wait for sysgen in testing
            self.frontend.compile_user_ip(update=True)
            print 'frontend complete'

        self.dump_castro(self.compile_dir+'/castro.yml')

        # binary = self.backend.binary_loc
        # os.system('cp %s %s/top.bin'%(binary, self.compile_dir))
        # mkbof_cmd = '%s/jasper_library/mkbof_64 -o %s/%s -s %s/core_info.ta' \
        #             'b -t 3 %s/top.bin' % (os.getenv('MLIB_DEVEL_PATH'),
        #                                    self.output_dir, self.output,
        #                                    self.compile_dir, self.compile_dir)
        # os.system(mkbof_cmd)
        # self.logger.info(mkbof_cmd)

    def check_attr_exists(self, thing, generator):
        """
        Lots of methods in this class require that certain attributes
        have been set by other methods before proceeding. This is probably
        a symptom of the code being terribly structured. This method
        checks if an attribute exists and throws an error message if not.
        In principle it could automatically run the necessary missing steps, 
        but that seems pretty suspect.

        :param thing: Attribute to check.
        :type thing: str
        :param generator: Method which can be used to set thing (used for 
            error message only)
        :type generator: str
        """
        if self.__getattribute__(thing) is None:
            errmsg = '%s is not defined. Have you run %s yet?' % (
                thing, generator)
            self.logger.error(errmsg)
            raise AttributeError(errmsg)

    def _add_external_tcl(self):
        """
        Add tcl commands from the frontend
        """
        raise DeprecationWarning
        for fname in self.tcl_sources:
            with open(fname, 'r') as fh:
                self.backend.add_tcl_cmd(fh.read())

    def generate_hdl(self):
        """
        Generates a top file for the target platform
        based on the peripherals file.
        Internally, calls:
        instantiate_periphs -- call each yellow block's mod_top method
        instantiate_user_ip -- add ports to top module based on port entries 
            in peripheral file
        regenerate_top -- rewrite top.v
        """
        self.logger.info('instantiating user peripherals')
        self._instantiate_periphs()
        self.logger.info('instantiating user_ip')
        self._instantiate_user_ip()
        self.logger.info('regenerating top')
        self.regenerate_top()

    def _parse_periph_file(self):
        """
        Open the peripherals file and parse it's
        contents using the pyaml package.
        Write the resulting yellow_blocks
        and user_modules dictionaries to
        attributes
        """
        if not os.path.exists(self.periph_file):
            self.logger.error('Peripherals file doesn\'t exist!')
            raise Exception('Peripherals file doesn\'t exist!')
        with open(self.periph_file, 'r') as fh:
            yaml_dict = yaml.load(fh)
        self.peripherals = yaml_dict['yellow_blocks']
        self.user_modules = yaml_dict['user_modules']

    def _extract_plat_info(self):
        """
        Extract platform information from the
        yellow_block attributes.
        Use this to instantiate the appropriate
        device from the Platform class.
        """
        for key in self.peripherals.keys():
            if self.peripherals[key]['tag'] == 'xps:xsg':
                # self.plat = platform.Platform.get_loader(
                #     self.peripherals[key]['hw_sys'])
                self.plat = platform.Platform(
                    self.peripherals[key]['hw_sys'].split(':')[0])
                # self.backend.plat = self.plat
                self.clk_src = self.peripherals[key]['clk_src']
                # in MHz
                self.clk_rate = float(self.peripherals[key]['clk_rate'])
                return
        raise Exception('self.peripherals does not contain anything '
                        'tagged xps:xsg')

    def _drc(self):
        """
        Get the provisions of the active platform and yellow blocks
        and compare with the current requirements of blocks in the design.
        """
        provisions = self._get_provisions()
        # check all requirements and exclusive reqs are provided
        for obj in self.periph_objs:
            for req_list in [obj.requires, obj.exc_requires]:
                for req in req_list:
                    self.logger.debug('%s requires %s' % (obj.name, req))
                    if req not in provisions:
                        self.logger.error('NOT SATISFIED: %s requires %s' % (
                            obj.name, req))
                        raise Exception('DRC FAIL! %s (required by %s) not '
                                        'provided by platform or any '
                                        'peripheral' % (req, obj.name))
        # check for overallocation of resources
        used = []
        for obj in self.periph_objs:
            for req in obj.exc_requires:
                self.logger.debug('%s requires %s exclusively' % (
                    obj.name, req))
                if req in used:
                    raise Exception('DRC FAIL! %s requires %s, but it has '
                                    'already been used by another block.'
                                    '' % (obj.name, req))
                else:
                    used.append(req)

    def _get_provisions(self):
        """
        Get and return all the provisions of the active platform and
        yellow blocks.
        """
        provisions = []
        for obj in self.periph_objs:
            provisions += obj.provides
        provisions += self.plat.provides
        return provisions

    def build_top(self):
        """
        Copies the base top-level verilog file (which is platform
        dependent) to the compile directory.
        Constructs an associated VerilogModule instance ready to be
        modified.
        """
        self.topfile = self.compile_dir+'/top.v'
        # delete top.v file if it exists, otherwise synthesis will fail
        if os.path.exists(self.topfile):
            os.remove(self.topfile)
        # os.system('cp %s %s'%(basetopfile, self.topfile))
        self.sources.append(self.topfile)
        for source in self.plat.sources:
            self.sources.append(os.getenv('HDL_ROOT')+'/'+source)
        for source in self.plat.consts:
            self.const_files.append(os.getenv('HDL_ROOT') + '/%s/%s' % (
                self.plat.name, source))
        if os.path.exists(self.topfile):
            self.top = verilog.VerilogModule(name='top', topfile=self.topfile, compile_dir=self.compile_dir)
        else:
            self.top = verilog.VerilogModule(name='top', compile_dir=self.compile_dir)

    def gen_periph_objs(self):
        """
        Generate a list of yellow blocks from the current peripheral file.
        Internally, calls:
        _parse_periph_file - parses .per file
        _extract_plat_info - instantiates platform instance
        Then calls each yellow block's constructor.
        Runs a system-wide drc before returning.
        """
        self._parse_periph_file()
        self._extract_plat_info()
        self.periph_objs = []
        for pk in self.peripherals.keys():
            self.logger.debug('Generating Yellow Block: %s' % pk)
            self.periph_objs.append(yellow_block.YellowBlock.make_block(
                self.peripherals[pk], self.plat))
        self._expand_children(self.periph_objs)
        self._drc()

    def _expand_children(self, population, parents=None, recursive=True):
        """
        population: a list of yellow blocks to which children will be added
        parents: a list of yellow blocks which will be invited to procreate.
                 If parents = None, the population will be used as the initial
                 parents argument
        recursive: if True, this method is called recursively, with children
                   passed as the new parents argument. The population list
                   will continue to grow until no child yellow blocks wish
                   to procreate any further.
        """
        parents = parents or population
        children = []
        for parent in parents:
            self.logger.debug('Inviting block %r to procreate' % parent)
            children += parent.gen_children()
        if not children:
            return
        else:
            population += children
            if not recursive:
                return
            else:
                self._expand_children(population, children)
                return

    def _instantiate_periphs(self):
        """
        Calls each yellow block's modify_top method against the class'
        top VerilogModule instance
        """
        print 'top:', self.topfile
        for obj in self.periph_objs:
            self.logger.debug('modifying top for obj %s' % obj.name)
            obj.modify_top(self.top)
            self.sources += obj.sources
            self.ips += obj.ips
    
    def _instantiate_user_ip(self):
        """
        Adds VerilogInstance and ports associated with user-ip to the class' top
        VerilogModule instance.
        """
        for name, usermodule in self.user_modules.items():
            inst = self.top.get_instance(entity=name, name='%s_inst' % name)
            # internal = False --> we assume that other yellow
            # blocks have set up appropriate signals in top.v
            # (we can't add them here anyway, because we don't
            # know the port widths)
            if 'clock' in usermodule.keys():
                inst.add_port(name=usermodule['clock'], signal='user_clk',
                              parent_sig=False)
            if 'clock_enable' in usermodule.keys():
                inst.add_port(name=usermodule['clock_enable'], signal='1\'b1',
                              parent_sig=False)
            for port in usermodule['ports']:
                inst.add_port(name=port, signal=port, parent_sig=False)

            if usermodule['sources'] is not None:
                for source in usermodule['sources']:
                    self.sources += glob.glob(source)
            # if usermodule['tcl_sources'] is not None:
            #    for source in usermodule['tcl_sources']:
            #        self.tcl_sources += glob.glob(source)

    def write_core_info(self):
        self.cores = self.top.wb_devices
        basefile = '%s/%s/core_info.tab' % (os.getenv('HDL_ROOT'),
                                            self.plat.name)
        newfile = '%s/core_info.tab' % self.compile_dir
        self.logger.debug('Opening %s' % basefile)
        modemap = {'rw': 3, 'r': 1, 'w': 2}
        try:
            with open(basefile, 'r') as fh:
                s = fh.read()
        # If there isn't a basefile, just plow on
        except IOError:
            s = ''
        if len(self.cores) != 0:
            longest_name = max([len(core.regname) for core in self.cores])
            format_str = '{0:%d} {1:1} {2:<16x} {3:<16x}\n' % longest_name
        for core in self.cores:
            self.logger.debug('Adding core_info.tab entry for '
                              '%s' % core.regname)
            s += format_str.format(core.regname, modemap[core.mode],
                                   core.base_addr, core.nbytes)
            # add aliases if the WB Devices have them
            for reg in core.memory_map:
                s += format_str.format(reg.name, modemap[reg.mode],
                                       core.base_addr + reg.offset, reg.nbytes)
            # s += '%s\t%d\t%x\t%x\n'%(core.regname, modemap[core.mode],
            #                          core.base_addr, core.nbytes)
        self.logger.debug('Opening %s' % basefile)
        with open(newfile, 'w') as fh:
            fh.write(s)

    def write_core_jam_info(self):
        self.cores = self.top.wb_devices
        basefile = '%s/%s/core_info.jam.tab' % (os.getenv('HDL_ROOT'), self.plat.name)
        newfile = '%s/core_info.jam.tab' % self.compile_dir
        self.logger.debug('Opening %s' % basefile)
        modemap = {'rw': 3, 'r': 1, 'w': 2}
        try:
            with open(basefile, 'r') as fh:
               s = fh.read()
        # If there isn't a basefile, just plow on
        except IOError:
            s = ''
        if len(self.cores) != 0:
            longest_name = max([len(core.regname) for core in self.cores])
            format_str = '{0:%d} {1:1} {2:<16x} {3:<16x} {4:<2x}\n' % longest_name
        for core in self.cores:
            self.logger.debug('Adding core_info.jam.tab entry for %s' % core.regname)
            s += format_str.format(core.regname, modemap[core.mode], core.base_addr, core.nbytes, core.typecode)
            # add aliases if the WB Devices have them
            for reg in core.memory_map:
                s += format_str.format(reg.name, modemap[reg.mode], core.base_addr + reg.offset, reg.nbytes, core.typecode)
            # s += '%s\t%d\t%x\t%x\n'%(core.regname, modemap[core.mode], core.base_addr, core.nbytes)
        self.logger.debug('Opening %s' % basefile)
        with open(newfile, 'w') as fh:
            fh.write(s)
        # generate the binary and xilinx-style .mem versions of this table, using some Ruby(!) scripts.
        os.system('ruby %s/jasper_library/cit2bin.rb %s > %s.bin' % (os.getenv('MLIB_DEVEL_PATH'), newfile, newfile))
        os.system('ruby %s/jasper_library/cit2mem.rb %s > %s.mem' % (os.getenv('MLIB_DEVEL_PATH'), newfile, newfile))

    def regenerate_top(self):
        """
        Generate the verilog for the modified top
        module. This involves computing the wishbone
        interconnect / addressing and generating new
        code for yellow block instances.
        """
        self.top.wb_compute(self.plat.dsp_wb_base_address,
                            self.plat.dsp_wb_base_address_alignment)
        print self.top.gen_module_file(filename=self.compile_dir+'/top.v')

    def generate_consts(self):
        """
        Compose a list of constraints from each yellow block.
        Use platform information to generate the appropriate
        physical realisation of each constraint.
        """
        self.logger.info('Extracting constraints from peripherals')
        self.check_attr_exists('periph_objs', 'gen_periph_objs()')
        self.constraints = []
        peripherals = self.peripherals
        for obj in self.periph_objs:
            c = obj.gen_constraints()
            if c is not None:
                self.constraints += c
        self.logger.info('Generating physical constraints')
        for constraint in self.constraints:
            try:
                constraint.gen_physical_const(self.plat)
            except AttributeError:
                pass  # some constraints don't have this method
        # check for any funny business
        # used_pins = []
        # for constraint in self.constraints:

    def constraints_rule_check(self):
        """
        Check pin constraints against top level signals.
        Warn about missing constraints.
        """
        port_constraints = []
        for const in self.constraints:
            if isinstance(const, PortConstraint):
                port_constraints += [const.portname]
        for port in self.top.ports:
            if port not in port_constraints:
                self.logger.warning('Port %s has no constraints!' % port)

    def dump_castro(self, filename):
        """
        Build a 'standard' Castro object, which is the
        interface between the toolflow and the backends.
        """
        import castro

        c = castro.Castro('top', self.sources, self.ips)

        # build castro standard pin constraints
        pin_constraints = []
        clk_constraints = []
        gen_clk_constraints = []
        clk_grp_constraints = []
        input_delay_constraints = []
        output_delay_constraints = []
        max_delay_constraints = []
        min_delay_constraints = []
        false_path_constraints = []
        multi_cycle_constraints = []
        raw_constraints = []

        for const in self.constraints:
            if isinstance(const, PortConstraint):
                pin_constraints += [castro.PinConstraint(
                    portname=const.portname, 
                    symbolic_name=const.iogroup, 
                    portname_indices=const.port_index, 
                    symbolic_indices=const.iogroup_index, 
                    io_standard=const.iostd, 
                    location=const.loc
                    )]
            elif isinstance(const, ClockConstraint):
                clk_constraints += [castro.ClkConstraint(
                    portname=const.signal, 
                    freq_mhz=const.freq, 
                    period_ns=const.period, 
                    clkname=const.name, 
                    waveform_min_ns=const.waveform_min, 
                    waveform_max_ns=const.waveform_max, 
                    port_en=const.port_en, 
                    virtual_en=const.virtual_en
                    )]
            elif isinstance(const, GenClockConstraint):
                gen_clk_constraints += [castro.GenClkConstraint(
                    pinname=const.signal, 
                    clkname=const.name, 
                    divide_by=const.divide_by, 
                    clksource=const.clock_source
                    )]
            elif isinstance(const, ClockGroupConstraint):
                clk_grp_constraints += [castro.ClkGrpConstraint(
                    clknamegrp1=const.clock_name_group_1, 
                    clknamegrp2=const.clock_name_group_2, 
                    clkdomaintype=const.clock_domain_relationship
                    )]
            elif isinstance(const, InputDelayConstraint):
                input_delay_constraints += [castro.InDelayConstraint(
                    clkname=const.clkname, 
                    consttype=const.consttype, 
                    constdelay_ns=const.constdelay_ns, 
                    add_delay_en=const.add_delay_en, 
                    portname=const.portname
                )]
            elif isinstance(const, OutputDelayConstraint):
                output_delay_constraints += [castro.OutDelayConstraint(
                    clkname=const.clkname, 
                    consttype=const.consttype, 
                    constdelay_ns=const.constdelay_ns, 
                    add_delay_en=const.add_delay_en, 
                    portname=const.portname
                )]
            elif isinstance(const, MaxDelayConstraint):
                max_delay_constraints += [castro.MaxDelayConstraint(
                    sourcepath=const.sourcepath,
                    destpath=const.destpath,
                    constdelay_ns=const.constdelay_ns
                )]
            elif isinstance(const, MinDelayConstraint):
                min_delay_constraints += [castro.MinDelayConstraint(
                    sourcepath=const.sourcepath,
                    destpath=const.destpath,
                    constdelay_ns=const.constdelay_ns
                )]
            elif isinstance(const, FalsePathConstraint):
                false_path_constraints += [castro.FalsePthConstraint(
                    sourcepath=const.sourcepath, 
                    destpath=const.destpath
                )]
            elif isinstance(const, MultiCycleConstraint):
                multi_cycle_constraints += [castro.MultiCycConstraint(
                    multicycletype=const.multicycletype, 
                    sourcepath=const.sourcepath, 
                    destpath=const.destpath, 
                    multicycledelay=const.multicycledelay
                )]
            elif isinstance(const, RawConstraint):
                raw_constraints += [castro.RawConstraint(
                    const.raw)]

        c.synthesis = castro.Synthesis()
        c.synthesis.pin_constraints = pin_constraints
        c.synthesis.clk_constraints = clk_constraints
        c.synthesis.gen_clk_constraints = gen_clk_constraints
        c.synthesis.clk_grp_constraints = clk_grp_constraints
        c.synthesis.input_delay_constraints = input_delay_constraints
        c.synthesis.output_delay_constraints = output_delay_constraints
        c.synthesis.max_delay_constraints = max_delay_constraints
        c.synthesis.min_delay_constraints = min_delay_constraints
        c.synthesis.false_path_constraints = false_path_constraints
        c.synthesis.multi_cycle_constraints = multi_cycle_constraints
        c.synthesis.raw_constraints = raw_constraints
        c.synthesis.platform_name = self.plat.name
        c.synthesis.fpga_manufacturer = self.plat.manufacturer
        c.synthesis.fpga_model = self.plat.fpga
        c.synthesis.pin_map = self.plat._pins

        mm_slaves = []
        for dev in self.top.wb_devices:
            if dev.mode == 'rw':
                mode = 3
            elif dev.mode == 'r':
                mode = 1
            elif dev.mode == 'w':
                mode = 2
            else:
                mode = 1
            mm_slaves += [castro.mm_slave(dev.regname, mode, dev.base_addr,
                                          dev.nbytes)]
            
        c.mm_slaves = mm_slaves
        
        with open(filename, 'w') as fh:
            fh.write(yaml.dump(c))


class ToolflowFrontend(object):
    """
    
    """
    def __init__(self, compile_dir='/tmp', target='/tmp/test.slx'):
        """
        
        :param compile_dir: 
        :param target: 
        """
        self.logger = logging.getLogger('jasper.toolflow.frontend')
        self.compile_dir = compile_dir
        if not os.path.exists(target):
            self.logger.error('Target path %s does not exist!' % target)
            raise Exception('Target path %s does not exist!' % target)
        self.target = target

    def gen_periph_file(self, fname='jasper.per'):
        """
        Call upon the frontend to generate a
        jasper-standard file defining peripherals
        (yellow blocks) present in a model.
        This method should be overridden by the
        specific frontend of choice, and should
        return the full path to the
        peripheral file.
        Use skip = True to just return the name of
        the file, without bothering to regenerate it
        (useful for debugging, and future use cases
        where a user only wants to run certain
        steps of a compile)
        """
        raise NotImplementedError()

    def write_git_info_file(self, fname='git_info.tab'):
        """
        Call upon the frontend to generate a
        git info file, which contains the
        git repo information, which is used for
        the header for the fpg file. This function is
        overwritten by the SimulinkFrontEnd Class
        """
        raise NotImplementedError()

    def compile_user_ip(self):
        """
        Compile the user IP to a single
        HDL module. Return the name of
        this module.
        Should be overridden by each FrontEnd
        subclass.
        """
        raise NotImplementedError()


class ToolflowBackend(object):
    """
    
    """
    def __init__(self, plat=None, compile_dir='/tmp'):
        """
        
        :param plat: 
        :param compile_dir: 
        """
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
        self.output_dir = compile_dir + '/outputs'
        self.plat = plat
        self.castro = None
        if plat:
            self.initialize(plat)

    def initialize(self, plat):
        """
        
        :param plat: 
        :return: 
        """
        raise NotImplementedError

    def compile(self, core, plat):
        """
        
        :param core: 
        :param plat: 
        :return: 
        """
        raise NotImplementedError

    def add_source(self, source, plat):
        """
        Add a sourcefile to the project. Via a tcl incantation.
        In non-project mode, it is important to note that copies are not made 
        of files. The files are read from their source directory. Project mode 
        copies files from their source directory and adds them to the a new 
        compile directory.
        """
        raise NotImplementedError

    def add_const_file(self, constfile):
        """
        Add a constraint file to the project. via a tcl incantation.
        In non-project mode, it is important to note that copies are not made 
        of files. The files are read from their source directory. Project 
        mode copies files from their source directory and adds them to the 
        a new compile directory.
        :param constfile
        """
        raise NotImplementedError

    def gen_constraint_file(self, constraints):
        """
        Pass this method a toolflow-standard list of constraints
        which have already had their physical parameters calculated
        and it will generate a constraint file and add it to the
        current project.
        """
        raise NotImplementedError

    def import_from_castro(self, filename):
        import castro
        self.castro = castro.Castro.load(filename)
        existing_sources = []
        for source in self.castro.src_files:
            if source not in existing_sources:
                existing_sources.append(source)
                if not os.path.exists(source):
                    errmsg = 'sourcefile %s doesn\'t exist!' % source
                    self.logger.error(errmsg)
                    raise Exception(errmsg)
                self.add_source(source, self.plat)
        existing_sources = []
        for source in self.castro.synthesis.vendor_constraints_files:
            if source not in existing_sources:
                existing_sources.append(source)
                if not os.path.exists(source):
                    errmsg = 'sourcefile %s doesn\'t exist!' % source
                    self.logger.error(errmsg)
                    raise Exception(errmsg)
                self.add_const_file(source)

        for ip in self.castro.ips:
            self.add_library(ip['path'])
            if ip.has_key('module_name'):
                self.add_ip(ip)
       
        # elaborate pin constraints
        for const in self.castro.synthesis.pin_constraints:
            pins = self.plat.get_pins(const.symbolic_name,
                                      const.symbolic_indices)
            numindices = len(const.symbolic_indices)
            const.location = [pins[idx].loc for idx in range(numindices)]
            const.io_standard = [pins[idx].iostd for idx in range(numindices)]
            const.is_vector = const.portname_indices != []

        self.gen_constraint_file(
            self.castro.synthesis.pin_constraints +
            self.castro.synthesis.clk_constraints +
            self.castro.synthesis.gen_clk_constraints +
            self.castro.synthesis.clk_grp_constraints +
            self.castro.synthesis.input_delay_constraints +
            self.castro.synthesis.output_delay_constraints +
            self.castro.synthesis.max_delay_constraints +
            self.castro.synthesis.min_delay_constraints +
            self.castro.synthesis.false_path_constraints +
            self.castro.synthesis.multi_cycle_constraints +
            self.castro.synthesis.raw_constraints)

    def mkfpg(self, filename_bin, filename_fpg):
        """
        This function makes the fpg file header and the final fpg file, which 
        consists of the fpg file header (core_info.tab, design_info.tab and 
        git_info.tab) and the compressed binary file. The fpg file is used
        to configure the ROACH, ROACH2, MKDIG and SKARAB boards.

        :param filename_bin: This is the path and binary file (top.bin) that 
            contains the FPGA programming data.
        :type filename_bin: str
        :param filename_fpg: This is the output time stamped fpg file name
        :type filename_fpg: str
        """
        # files to read from (core_info.tab, design_info.tab and git_info.tab)
        basefile_core = '%s/core_info.tab' % self.compile_dir
        basefile_design = '%s/design_info.tab' % self.compile_dir
        basefile_git = '%s/git_info.tab' % self.compile_dir

        # file, which represents the fpg file header only
        extended_info = '%s/extended_info.kcpfpg' % self.compile_dir

        self.logger.debug('Opening core_info.tab file %s' % basefile_core)
        self.logger.debug('Opening design_info.tab file %s' % basefile_design)
        self.logger.debug('Opening git_info.tab file %s' % basefile_git)

        # read base files and write to fpg header file in correct format
        with open(extended_info, 'w') as fh4:
            fh4.write('#!/bin/kcpfpg\n')
            fh4.write('?uploadbin\n')
            with open(basefile_core, 'r') as fh1:
                for row in fh1:
                    col1, col2, col3, col4 = row.split()
                    fh4.write('?register\t'+col1+'\t0x'+col3+'\t0x'+col4+'\n')
            with open(basefile_design, 'r') as fh2:
                line = fh2.readline()
                while line:
                    fh4.write('?meta\t' + line)
                    line = fh2.readline()
            with open(basefile_git, 'r') as fh3:
                line = fh3.readline()
                while line:
                    fh4.write(line)
                    line = fh3.readline()
        # add the MD5 Checksums here
        with open(extended_info, 'r') as fh:
            md5_header = hashlib.md5(fh.read()).hexdigest()
        with open(filename_bin, 'rb') as fh:
            bitstream = fh.read()
            # 1) Calculate MD5 Checksum on binary data
            md5_bitstream = hashlib.md5(bitstream).hexdigest()

            # 2) Calculate 'FlashWriteChecksum' to be compared to
            #    SpartanChecksum when upload_to_ram()
            #   - Need to give it the chunk size being used in upload_to_ram
            #   - This alters how the SPARTAN calculates the checksum
            flash_write_checksum = self.calculate_checksum_using_bitstream(
                bitstream, packet_size=MAX_IMAGE_CHUNK_SIZE)

        # add the md5sums, checksum and ?quit to the extended info file
        with open(extended_info, 'a') as fh:
            # Line to write must follow general format, as per Paul
            line = '77777\t77777\tmd5_header\t' + md5_header + '\n'
            fh.write("?meta\t" + line)
            line = '77777\t77777\tmd5_bitstream\t' + md5_bitstream + '\n'
            fh.write("?meta\t" + line)
            line = '77777\t77777\tflash_write_checksum\t' + \
                   str(flash_write_checksum) + '_' + str(MAX_IMAGE_CHUNK_SIZE) + '\n'
            fh.write("?meta\t" + line)
            fh.write('?quit\n')

        # copy binary file from binary file location and rename to system.bin
        mkfpg_cmd1 = 'cp %s %s/system.bin' % (filename_bin, self.compile_dir)
        os.system(mkfpg_cmd1)
        # compress binary file in new location
        mkfpg_cmd2 = 'gzip -c %s/system.bin > %s/system.bin.gz' % (
            self.compile_dir, self.compile_dir)
        os.system(mkfpg_cmd2)
        # append the compressed binary file to the extended_info.kcpfpg file
        mkfpg_cmd3 = 'cat %s/system.bin.gz >> %s/extended_info.kcpfpg' % (
            self.compile_dir, self.compile_dir)
        os.system(mkfpg_cmd3)
        # copy extended_info.kcpfpg and rename to time stamped file and
        # place in output directory with the bof file
        mkfpg_cmd4 = 'cp %s/extended_info.kcpfpg %s/%s' % (
            self.compile_dir, self.output_dir, filename_fpg)
        os.system(mkfpg_cmd4)

    @staticmethod
    def calculate_checksum_using_bitstream(bitstream, packet_size=8192):
        """
        Summing up all the words in the input bitstream, and returning a
        'Checksum' - Assuming that the bitstream HAS NOT been padded yet
        :param bitstream: The actual bitstream of the file in question
        :param packet_size: max size of image packets that we pad to
        :return: checksum
        """

        size = len(bitstream)

        flash_write_checksum = 0x00

        for i in range(0, size, 2):
            # This is just getting a substring, need to convert to hex
            two_bytes = bitstream[i:i + 2]
            one_word = struct.unpack('!H', two_bytes)[0]
            flash_write_checksum += one_word

        if (size % packet_size) != 0:
            # padding required
            num_padding_bytes = packet_size - (size % packet_size)
            for i in range(num_padding_bytes / 2):
                flash_write_checksum += 0xffff

        # Last thing to do, make sure it is a 16-bit word
        flash_write_checksum &= 0xffff

        return flash_write_checksum

class SimulinkFrontend(ToolflowFrontend):
    """
    
    """
    def __init__(self, compile_dir='/tmp', target='/tmp/test.slx'):
        """
        
        :param compile_dir: 
        :param target: 
        """
        ToolflowFrontend.__init__(self, compile_dir=compile_dir, target=target)
        if target[-4:] not in ['.slx', '.mdl']:
            self.logger.warning('Frontend target %s does not look like a '
                                'simulink file!' % target)
        self.modelpath = target
        self.modelname = target.split('/')[-1][:-4]  # strip off extension

    def gen_periph_file(self, fname='jasper.per'):
        """
        generate the peripheral file. i.e., the list of yellow blocks
        and their parameters. It also generates the design_info.tab file
        which is used to populate the fpg file header

        :param fname: The full path and name to give the peripheral file.
        :type fname: str
        """
        self.logger.info('Generating yellow block description file: %s' % fname)
        # change directory to the matlab script directory
        term_cmd = os.getenv('MLIB_DEVEL_PATH')
        os.chdir(term_cmd)
        # The command to start matlab with appropriate libraries
        matlab_start_cmd = os.path.join(os.getenv('XILINX_PATH'), 'bin', 'sysgen')
        #matlab_start_cmd = os.getenv('SYSGEN_SCRIPT')
        # The matlab script responsible for generating the peripheral file
        # each script represents a matlab function
        script1 = 'open_system'
        script2 = 'set_param'
        script3 = 'gen_block_file'
        script4 = 'gen_xps_add_design_info'

        # The matlab syntax to call this script with appropriate args
        # This scripts runs open_system(), set_param(), gen_block_file() and
        # gen_xps_add_design_info().
        # if open_system() and set_param() are not run then the peripheral
        # names will be incorrectly generated and the design will not compile.
        # Everything is run on a single matlab terminal line
        ml_cmd = "%s('%s');sys=gcs;%s(sys,'SimulationCommand','update');" \
                 "%s('%s','%s');mssge.xps_path='%s';" \
                 "%s(sys,mssge,'/');exit" % (script1, self.modelpath, script2,
                                             script3, self.compile_dir, fname,
                                             self.compile_dir, script4)
        # Complete command to run on terminal
        term_cmd = matlab_start_cmd + ' -nodesktop -nosplash -r "%s"' % ml_cmd
        self.logger.info('Running terminal command: %s' % term_cmd)
        os.system(term_cmd)

    def write_git_info_file(self, fname='git_info.tab'):
        """
        Get the git info for mlib_devel and the model file.
        :param fname: 
        :return: 
        """
        fpath = '%s/%s' % (self.compile_dir, fname)
        fptr = open(fpath, 'w')
        if kat_get_version is None:
            fptr.close()
            return
        model_git = self.modelpath + '\t' + kat_get_version(self.modelpath)
        mlib_git = __file__ + '\t' + kat_get_version(__file__)
        fptr.write('?meta\t77777_git\trcs\t{}\n'.format(model_git))
        fptr.write('?meta\t77777_git\trcs\t{}\n'.format(mlib_git))
        fptr.close()

    def compile_user_ip(self, update=False):
        """
        Compile the users simulink design. The resulting netlist should
        end up in the location already specified in the peripherals file.

        :param update: Update the simulink model before running system generator
        :type update: bool
        """
        self.logger.info('Compiling user IP to module: %s' % self.modelname)
        # change directory to the matlab script directory
        term_cmd = os.getenv('MLIB_DEVEL_PATH')
        os.chdir(term_cmd)
        # The command to start matlab with appropriate libraries
        # matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
        #matlab_start_cmd = os.getenv('SYSGEN_SCRIPT')
        matlab_start_cmd = os.path.join(os.getenv('XILINX_PATH'), 'bin', 'sysgen')
        # The matlab syntax to start a compile with appropriate args
        ml_cmd = "start_sysgen_compile('%s','%s',%d);exit" % (
            self.modelpath, self.compile_dir, int(update))
        term_cmd = matlab_start_cmd + ' -nodesktop -nosplash -r "%s"' % ml_cmd
        self.logger.info('Running terminal command: %s' % term_cmd)
        os.system(term_cmd)
        # return the name of the top module of the user ip


class VivadoBackend(ToolflowBackend):
    """
    
    """
    def __init__(self, plat=None, compile_dir='/tmp', periph_objs=None):
        """
        
        :param plat: 
        :param compile_dir: 
        :param periph_objs: 
        """
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
        self.const_file_ext = 'xdc'
        # src_file parameters for non-project mode only
        self.src_file_vhdl_ext = 'vhd'
        self.src_file_ip_ext = 'xci'
        self.src_file_verilog_ext = 'v'
        self.src_file_sys_verilog_ext = 'sv'
        self.src_file_block_diagram_ext = 'bd'
        self.src_file_elf_ext = 'elf'
        self.src_file_coe_ext = 'coe'
        self.src_file_design_checkpoint_ext = 'dcp'
        self.manufacturer = 'xilinx'
        self.project_name = 'myproj'
        self.periph_objs = periph_objs
        self.tcl_cmd = ''
        # if project mode is enabled
        if plat.project_mode:
            self.binary_loc = '%s/%s/%s.runs/impl_1/top.bin' % (
                self.compile_dir, self.project_name, self.project_name)
        # if non-project mode is enabled
        else:
            self.binary_loc = '%s/%s/top.bin' % (
                self.compile_dir, self.project_name)
        self.name = 'vivado'
        self.npm_sources = []
        ToolflowBackend.__init__(self, plat=plat, compile_dir=compile_dir)

    def initialize(self, plat):
        self.tcl_cmds = {
            'init'        : '',
            'pre_synth'   : '',
            'synth'       : '',
            'post_synth'  : '',
            'pre_impl'    : '',
            'impl'        : '',
            'post_impl'   : '',
            'pre_bitgen'  : '',
            'bitgen'      : '',
            'post_bitgen' : '',
            'promgen'     : '',
        }

        if plat.manufacturer != self.manufacturer:
            self.logger.error('Trying to compile a %s FPGA using %s %s' % (
                plat.manufacturer, self.manufacturer, self.name))

        self.add_tcl_cmd('puts "Starting tcl script"')
        # Create Vivado Project in project mode only
        if plat.project_mode:
            self.add_tcl_cmd('create_project -f %s %s/%s -part %s' % (
                self.project_name, self.compile_dir, self.project_name,
                plat.fpga))
        # Create the part in non-project mode (project runs in memory only)
        else:
            self.add_tcl_cmd('file mkdir %s/%s' % (self.compile_dir,
                                                   self.project_name))
            self.add_tcl_cmd('set_part %s' % plat.fpga)

        # for source in plat.sources:
        #  self.add_source(os.getenv('HDL_ROOT')+'/'+source)
        #  self.add_source(self.compile_dir+'/top.v')
        self.add_source(self.compile_dir+'/wbs_arbiter.v', self.plat)

    def add_library(self, path):
        """
        Add a library at <path>
        """
        self.add_tcl_cmd('set repos [get_property ip_repo_paths [current_project]]')
        self.add_tcl_cmd('set_property ip_repo_paths "$repos %s" [current_project]' % path)
        self.add_tcl_cmd('update_ip_catalog')

    def add_ip(self, ip):
        """
        Add an ip core from a library
        """
        self.add_tcl_cmd('create_ip -name %s -vendor %s -library %s -version %s -module_name %s' % (ip['name'], ip['vendor'], ip['library'], ip['version'], ip['module_name']))

    def add_source(self, source, plat):
        """
        Add a sourcefile to the project. Via a tcl incantation.
        In non-project mode, it is important to note that copies are not made 
        of files. The files are read from their source directory. Project mode 
        copies files from their source directory and adds them to the a new 
        compile directory.
        """
        self.logger.debug('Adding source file: %s' % source)
        # Project Mode is enabled
        if plat.project_mode:
            self.add_tcl_cmd('import_files -force %s' % source)
        # Non-Project Mode is enabled
        else:
            if os.path.basename(source) == 'top.v':
                # Convert from string to Lists and extract filenames from
                # the directory source
                self.npm_sources = os.path.basename(source).split()
            # extract file names from the directories listed in the source
            else:
                self.npm_sources = os.listdir(source)
                self.logger.debug('source %s' % source)
                self.logger.debug('npm_sources %s' % self.npm_sources)
            for item in self.npm_sources:
                ext = item.split('.')[-1]
                current_source = item
                self.logger.debug('extension: %s' % ext)
                self.logger.debug('current_source: %s' % current_source)
                # VHDL File
                if ext == self.src_file_vhdl_ext:
                    self.add_tcl_cmd('read_vhdl %s/%s' % (
                        source, current_source))
                # Verilog File
                elif ext == self.src_file_verilog_ext:
                    # Only read from source when reading the top.v file
                    if os.path.basename(source) == 'top.v':
                        self.add_tcl_cmd('read_verilog %s' % source)
                    else:
                        self.add_tcl_cmd('read_verilog %s/%s' % (
                            source, current_source))
                # System Verilog File
                elif ext == self.src_file_sys_verilog_ext:
                    self.add_tcl_cmd('read_verilog -sv %s/%s' % (source,current_source))
                # IP File
                elif ext == self.src_file_ip_ext:
                    self.add_tcl_cmd('read_ip %s/%s' % (source,current_source))
                # Block Diagram File
                elif ext == self.src_file_block_diagram_ext:
                    self.add_tcl_cmd('read_bd %s/%s' % (source,current_source))
                # ELF Microblaze File
                elif ext == self.src_file_elf_ext:
                    self.add_tcl_cmd('add_files %s/%s' % (source,current_source))
                # Coefficient BRAM File
                elif ext == self.src_file_coe_ext:
                    self.add_tcl_cmd('add_files %s/%s' % (source,current_source))
                # Design checkpoint files
                elif ext == self.src_file_design_checkpoint_ext:
                    self.add_tcl_cmd('add_files %s' % current_source)
                else:
                    self.logger.warning('unknown extension, ignoring source file %s' % current_source)

    def add_const_file(self, constfile):
        """
        Add a constraint file to the project. via a tcl incantation.
        In non-project mode, it is important to note that copies are not made 
        of files. The files are read from their source directory. Project 
        mode copies files from their source directory and adds them to the 
        a new compile directory.
        :param constfile
        """
        if constfile.split('.')[-1] == self.const_file_ext:
            self.logger.debug('Adding constraint file: %s' % constfile)
            # Project Mode is enabled
            if self.plat.project_mode:
                self.add_tcl_cmd('import_files -force -fileset constrs_1 %s' %
                                 constfile)
            # Non-Project Mode is enabled
            else:
                self.add_tcl_cmd('read_xdc %s' % constfile)
        else:
            self.logger.debug('Ignore constraint file: %s, with wrong file '
                              'extension' % constfile)

    def add_tcl_cmd(self, cmd, stage='pre_synth'):
        """
        Add a command to the tcl command list with
        a trailing newline.
        """
        self.logger.debug('Adding tcl command: %s' % cmd)
        self.tcl_cmds[stage] += cmd
        self.tcl_cmds[stage] += '\n'

    def eval_tcl(self):
        s = ''
        s += self.tcl_cmds['init']
        s += self.tcl_cmds['pre_synth']
        s += self.tcl_cmds['synth']
        s += self.tcl_cmds['post_synth']
        s += self.tcl_cmds['pre_impl']
        s += self.tcl_cmds['impl']
        s += self.tcl_cmds['post_impl']
        s += self.tcl_cmds['pre_bitgen']
        s += self.tcl_cmds['bitgen']
        s += self.tcl_cmds['post_bitgen']
        s += self.tcl_cmds['promgen']
        return s

    def add_compile_cmds(self, cores=8, plat=None):
        """
        Add the tcl commands for compiling the design, and then launch
        vivado in batch mode
        """
        tcl = self.add_tcl_cmd
        # Project Mode is enabled
        if plat.project_mode:
            # Pre-Synthesis Commands
            self.add_tcl_cmd('set_property top top [current_fileset]', stage='pre_synth')
            self.add_tcl_cmd('update_compile_order -fileset sources_1', stage='pre_synth')
            # Hack to get the System generator RAMs to see their coefficient files.
            # Vivado (2016.1) doesn't seem to import the .coe and ram .xci files in the
            # correct relative directories as configured by System Generator.
            self.add_tcl_cmd('if {[llength [glob -nocomplain [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe]] > 0} {', stage='pre_synth')
            self.add_tcl_cmd('file copy -force {*}[glob [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe] [get_property directory [current_project]]/myproj.srcs/sources_1/ip/', stage='pre_synth')
            self.add_tcl_cmd('}', stage='pre_synth')
            
            # add the upgrade_ip command to the tcl file if the yaml file requrests it, default to upgrading the IP
            if "upgrade_ip" not in plat.conf.keys() or plat.conf['upgrade_ip'] == True:
                self.add_tcl_cmd('upgrade_ip -quiet [get_ips *]', stage='pre_synth')
                self.logger.debug('adding the upgrade_ip command to the tcl script')
            else:             
                self.logger.debug('The upgrade_ip command is not being added to the tcl script')
            # Add in if ILA is being used to prevent signal names from changing during synthesis
            #self.add_tcl_cmd('set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]')

            # Synthesis Commands   
            self.add_tcl_cmd('reset_run synth_1', stage='synth')
            self.add_tcl_cmd('launch_runs synth_1 -jobs %d' % cores, stage='synth')
            self.add_tcl_cmd('wait_on_run synth_1', stage='synth')

            # Post-Synthesis Commands
            self.add_tcl_cmd('open_run synth_1', stage='post_synth')

            # Pre-Implementation Commands
            self.add_tcl_cmd('set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]', stage='pre_impl')
            self.add_tcl_cmd('set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]', stage='pre_impl')

            # Implementation Commands
            self.add_tcl_cmd('launch_runs impl_1 -jobs %d' % cores, stage='impl')
            self.add_tcl_cmd('wait_on_run impl_1', stage='impl')

            # Post-Implementation Commands
            self.add_tcl_cmd('open_run impl_1', stage='post_impl')

            # Pre-Bitgen Commands

            # Bitgen Commands
            self.add_tcl_cmd('launch_runs impl_1 -to_step write_bitstream', stage='bitgen')
            self.add_tcl_cmd('wait_on_run impl_1', stage='bitgen')
            self.add_tcl_cmd('cd [get_property DIRECTORY [current_project]]', stage='bitgen')

            # Post-Bitgen Commands
            # Generate a binary file for SKARAB where the bits are reversed per byte. This is used by casperfpga for
            # configuring the FPGA
            try:
                if plat.conf['bit_reversal'] == True:
                    self.add_tcl_cmd('write_cfgmem -force -format bin -interface bpix8 -size 128 -loadbit "up 0x0 '
                                 '%s/%s/%s.runs/impl_1/top.bit" -file %s'
                                 % (self.compile_dir, self.project_name, self.project_name, self.binary_loc), stage='post_bitgen')
            # just ignore if key is not present as only some platforms will have the key.
            except KeyError:
                s = ""

            # Determine if the design meets timing or not
            # Look for Worst Negative Slack
            self.add_tcl_cmd('if { [get_property STATS.WNS [get_runs impl_1] ] < 0 } {', stage='post_bitgen')
            self.add_tcl_cmd('puts "Found timing violations => Worst Negative Slack:'
                             ' [get_property STATS.WNS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('} else {', stage='post_bitgen')
            self.add_tcl_cmd('puts "No timing violations => Worst Negative Slack:'
                             ' [get_property STATS.WNS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('}', stage='post_bitgen')
            # Look for Total Negative Slack
            self.add_tcl_cmd('if { [get_property STATS.TNS [get_runs impl_1] ] < 0 } {', stage='post_bitgen')
            self.add_tcl_cmd('puts "Found timing violations => Total Negative Slack:'
                             ' [get_property STATS.TNS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('} else {', stage='post_bitgen')
            self.add_tcl_cmd('puts "No timing violations => Total Negative Slack:'
                             ' [get_property STATS.TNS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('}', stage='post_bitgen')
            # Look for Worst Hold Slack
            self.add_tcl_cmd('if { [get_property STATS.WHS [get_runs impl_1] ] < 0 } {', stage='post_bitgen')
            self.add_tcl_cmd('puts "Found timing violations => Worst Hold Slack:'
                             ' [get_property STATS.WHS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('} else {', stage='post_bitgen')
            self.add_tcl_cmd('puts "No timing violations => Worst Hold Slack:'
                             ' [get_property STATS.WHS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('}', stage='post_bitgen')
            # Look for Total Hold Slack
            self.add_tcl_cmd('if { [get_property STATS.THS [get_runs impl_1] ] < 0 } {', stage='post_bitgen')
            self.add_tcl_cmd('puts "Found timing violations => Total Hold Slack:'
                             ' [get_property STATS.THS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('} else {', stage='post_bitgen')
            self.add_tcl_cmd('puts "No timing violations => Total Hold Slack:'
                             ' [get_property STATS.THS [get_runs impl_1]] ns" ', stage='post_bitgen')
            self.add_tcl_cmd('}', stage='post_bitgen')

            # Let Yellow Blocks add their own tcl commands
            self.gen_yellowblock_tcl_cmds()

        # Non-Project mode is enabled
        # Options can be added to the *_design commands to change strategies
        # or meet timing
        else:
            proj_path = '%s/%s' % (self.compile_dir, self.project_name)
            tcl('synth_design -top top -part %s' % plat.fpga)
            tcl('write_checkpoint -force %s/post_synth.dcp' % proj_path)
            tcl('report_timing_summary -file %s/post_synth_timing_summary.'
                'rpt' % proj_path)
            tcl('report_utilization -file %s/post_synth_timing_summary.'
                'rpt' % proj_path)
            tcl('opt_design')
            tcl('place_design')
            tcl('report_clock_utilization -file %s/clock_util.rpt' % proj_path)
            # Run power_opt_design and phys_opt_design if setup timing
            # violations occur
            tcl('if { [get_property SLACK [get_timing_paths -max_paths 1 '
                '-nworst 1 -setup] ] < 0 } {')
            tcl('puts "Found setup timing violations => running physical '
                'optimization" ')
            tcl('power_opt_design')
            tcl('phys_opt_design')
            tcl('}')
            # Run power_opt_design and phys_opt_design if hold timing
            # violations occur
            tcl('if { [get_property SLACK [get_timing_paths -max_paths 1 '
                '-nworst 1 -hold] ] < 0 } {')
            tcl('puts "Found hold timing violations => running physical '
                'optimization" ')
            tcl('power_opt_design')
            tcl('phys_opt_design')
            tcl('}')
            tcl('write_checkpoint -force %s/post_place.dcp' % proj_path)
            tcl('report_utilization -file %s/post_place_util.rpt' % proj_path)
            tcl('report_timing_summary -file %s/post_place_timing_summary.'
                'rpt' % proj_path)
            tcl('route_design')
            tcl('write_checkpoint -force %s/post_route.dcp' % proj_path)
            tcl('report_route_status -file %s/post_route_status.'
                'rpt' % proj_path)
            tcl('report_timing_summary -file %s/post_route_timing_summary.'
                'rpt' % proj_path)
            tcl('report_power -file %s/post_route_power.rpt' % proj_path)
            tcl('report_drc -file %s/post_imp_drc.rpt' % proj_path)
            tcl('set_property SEVERITY {Warning} [get_drc_checks UCIO-1]')
            tcl('write_bitstream -force -bin_file %s/top.bit' % proj_path)
            # Generate a binary file for SKARAB where the bits are reversed
            # per byte. This is used by casperfpga for configuring the FPGA
            try:
                if plat.conf['bit_reversal']:
                    tcl('write_cfgmem -force -format bin -interface bpix8 '
                        '-size 128 -loadbit "up 0x0 %s/%s/top.bit" -file %s' % (
                            self.compile_dir, self.project_name,
                            self.binary_loc))
            # just ignore if key is not present as only some platforms
            # will have the key.
            except KeyError as e:
                raise KeyError(e.message)

            # Determine if the design meets timing or not
            # Check for setup timing violations
            tcl('if { [get_property SLACK [get_timing_paths -max_paths 1 '
                '-nworst 1 -setup] ] < 0 } {')
            tcl('puts "Found setup timing violations => Worst Setup Slack: '
                '[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 '
                '-setup]] ns" ')
            tcl('} else {')
            tcl('puts "No setup timing violations => Worst Setup Slack: '
                '[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 '
                '-setup]] ns" ')
            tcl('}')
            # Check for hold timing violations
            tcl('if { [get_property SLACK [get_timing_paths -max_paths 1 '
                '-nworst 1 -hold] ] < 0 } {')
            tcl('puts "Found setup timing violations => Worst Hold Slack: '
                '[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 '
                '-hold]] ns" ')
            tcl('} else {')
            tcl('puts "No setup timing violations => Worst Hold Slack: '
                '[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 '
                '-hold]] ns" ')
            tcl('}')

    def compile(self, cores, plat):
        """
        
        :param cores: 
        :param plat: 
        :return: 
        """
        self.add_compile_cmds(cores=cores, plat=plat)
        # write tcl command to file
        tcl_file = self.compile_dir+'/gogogo.tcl'
        helpers.write_file(tcl_file, self.eval_tcl())
        rv = os.system('vivado -jou {cdir}/vivado.jou -log {cdir}/vivado.log '
                       '-mode batch -source '
                       '{cfile}'.format(cdir=self.compile_dir, cfile=tcl_file))
        if rv:
            raise Exception('Vivado failed!')

    def get_tcl_const(self, const):
        """
        Pass a single toolflow-standard PortConstraint, 
        and get back a tcl command to add the constraint
        to a vivado project.
        """
        user_const = ''
        if isinstance(const, castro.PinConstraint):
            self.logger.debug('New PortConstraint instance found: %s -> %s' % (
                const.portname, const.symbolic_name))
            for idx, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting loc for port index %d' % idx)
                loc = const.location[idx]
                if loc is not None:
                    self.logger.debug('LOC constraint found at %s' % loc)
                    user_const += self.format_const(
                        'PACKAGE_PIN', loc, const.portname,
                        index=const.portname_indices[idx] if
                        const.portname_indices else None)

            for idx, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting iostd for port index %d' % idx)
                iostd = const.io_standard[idx]
                if iostd is not None:
                    self.logger.debug('IOSTD constraint found: %s' % iostd)
                    user_const += self.format_const(
                        'IOSTANDARD', iostd, const.portname,
                        index=const.portname_indices[idx]
                        if const.portname_indices else None)

        if isinstance(const, castro.ClkConstraint):
            self.logger.debug('New Clock constraint found')
            user_const += self.format_clock_const(const)

        if isinstance(const, castro.GenClkConstraint):
            self.logger.debug('New Generated Clock constraint found')
            user_const += self.format_gen_clock_const(const)

        if isinstance(const, castro.ClkGrpConstraint):
            self.logger.debug('New Clock group constraint found')
            user_const += self.format_clock_group_const(const)

        if isinstance(const, castro.InDelayConstraint):
            self.logger.debug('New Input delay constraint found')
            user_const += self.format_input_delay_const(const)

        if isinstance(const, castro.OutDelayConstraint):
            self.logger.debug('New Output delay constraint found')
            user_const += self.format_output_delay_const(const)

        if isinstance(const, castro.MaxDelayConstraint):
            self.logger.debug('New Max delay constraint found')
            user_const += self.format_max_delay_const(const)

        if isinstance(const, castro.MinDelayConstraint):
            self.logger.debug('New Min delay constraint found')
            user_const += self.format_min_delay_const(const)

        if isinstance(const, castro.FalsePthConstraint):
            self.logger.debug('New False Path constraint found')
            user_const += self.format_false_path_const(const)

        if isinstance(const, castro.MultiCycConstraint):
            self.logger.debug('New Multi Cycle constraint found')
            user_const += self.format_multi_cycle_const(const)

        if isinstance(const, castro.RawConstraint):
            self.logger.debug('New Raw constraint found')
            user_const += const.raw

        return user_const

    @staticmethod
    def format_clock_const(c):
        if c.virtual_en:
            return 'create_clock -period %4.3f -name %s -waveform {%4.3f ' \
                   '%4.3f}\n' % (c.period_ns, c.clkname, c.waveform_min_ns,
                                 c.waveform_max_ns)
        elif c.port_en:
            return 'create_clock -period %4.3f -name %s -waveform {%4.3f ' \
                   '%4.3f} [get_ports {%s}]\n' % (c.period_ns, c.clkname,
                                                  c.waveform_min_ns,
                                                  c.waveform_max_ns, c.portname)
        else:
            return 'create_clock -period %4.3f -name %s -waveform {%4.3f ' \
                   '%4.3f} [get_pins {%s}]\n' % (c.period_ns, c.clkname,
                                                 c.waveform_min_ns,
                                                 c.waveform_max_ns, c.portname)

    @staticmethod
    def format_gen_clock_const(c):
        return 'create_generated_clock -name %s -source [get_pins {%s}] ' \
               '-divide_by %d [get_pins {%s}]\n' % (c.clkname, c.clksource,
                                                    c.divide_by, c.pinname)

    @staticmethod
    def format_clock_group_const(c):
        return 'set_clock_groups -%s -group [get_clocks %s] -group ' \
               '[get_clocks %s]\n' % (c.clkdomaintype, c.clknamegrp1,
                                      c.clknamegrp2)

    @staticmethod
    def format_input_delay_const(c):
        if c.add_delay_en:
            return 'set_input_delay -clock [get_clocks %s] -%s -add_delay ' \
                   '%4.3f [get_ports {%s}]\n' % (c.clkname, c.consttype,
                                                 c.constdelay_ns, c.portname)
        else:
            return 'set_input_delay -clock [get_clocks %s] -%s %4.3f ' \
                   '[get_ports {%s}]\n' % (c.clkname, c.consttype,
                                           c.constdelay_ns, c.portname)

    @staticmethod
    def format_output_delay_const(c):
        if c.add_delay_en:
            return 'set_output_delay -clock [get_clocks %s] -%s -add_delay ' \
                   '%4.3f [get_ports {%s}]\n' % (c.clkname, c.consttype,
                                                 c.constdelay_ns, c.portname)
        else:
            return 'set_output_delay -clock [get_clocks %s] -%s %4.3f ' \
                   '[get_ports {%s}]\n' % (c.clkname, c.consttype,
                                           c.constdelay_ns, c.portname)

    @staticmethod
    def format_max_delay_const(c):
        if c.sourcepath is None:
             return 'set_max_delay %s -to %s\n' % (c.constdelay_ns, c.destpath)
        elif c.destpath is None:
             return 'set_max_delay %s -from %s\n' % (c.constdelay_ns, c.sourcepath)
        else:
             return 'set_max_delay %s -from %s -to %s\n' % (c.constdelay_ns, c.sourcepath, c.destpath)

    @staticmethod
    def format_min_delay_const(c):
        if c.sourcepath is None:
             return 'set_min_delay %s -to %s\n' % (c.constdelay_ns, c.destpath)
        elif c.destpath is None:
             return 'set_min_delay %s -from %s\n' % (c.constdelay_ns, c.sourcepath)
        else:
             return 'set_min_delay %s -from %s -to %s\n' % (c.constdelay_ns, c.sourcepath, c.destpath)

    @staticmethod
    def format_false_path_const(c):
        if c.sourcepath is None:
            return 'set_false_path -to %s\n' % c.destpath
        elif c.destpath is None:
            return 'set_false_path -from %s\n' % c.sourcepath
        else:
            return 'set_false_path -from %s -to %s\n' % (c.sourcepath,
                                                         c.destpath)

    @staticmethod
    def format_multi_cycle_const(c):
        return 'set_multicycle_path -%s -from [%s] -to [%s] %d\n' % (
            c.multicycletype, c.sourcepath, c.destpath, c.multicycledelay)

    @staticmethod
    def format_const(attribute, val, port, index=None):
        """
        Generate a tcl syntax command from an attribute, value and port
        (with indexing if required)
        """
        return 'set_property %s %s [get_ports %s%s]\n' % (
                attribute, val, port,
                '[%d]' % index if index is not None else '')

    @staticmethod
    def format_cfg_const(attribute, val):
        """
        Generate a configuration tcl syntax command from an attribute and value
        """
        return 'set_property %s %s [current_design]\n' % (attribute, val)

    def gen_yellowblock_tcl_cmds(self):
        """
        Compose a list of tcl commands from each yellow block.
        To be added to the final tcl script.
        """
        self.logger.info('Extracting yellow block tcl commands'
                         ' from peripherals')
        for obj in self.periph_objs:
            c = obj.gen_tcl_cmds()
            for key, val in c.iteritems():
                if val is not None:
                    for v in val:
                        self.add_tcl_cmd(v, stage=key)

    def gen_constraint_file(self, constraints):
        """
        Pass this method a toolflow-standard list of constraints
        which have already had their physical parameters calculated
        and it will generate a constraint file and add it to the
        current project.
        """
        constfile = '%s/user_const.xdc' % self.compile_dir
        user_const = ''
        for constraint in constraints:
            print 'parsing constraint', constraint
            user_const += self.get_tcl_const(constraint)
        print user_const
        helpers.write_file(constfile, user_const)
        print 'written constraint file', constfile
        self.add_const_file(constfile)


class ISEBackend(VivadoBackend):
    """
    
    """
    def __init__(self, plat=None, compile_dir='/tmp'):
        """
        
        :param plat: 
        :param compile_dir: 
        """
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
        self.const_file_ext = 'ucf'
        self.manufacturer = 'xilinx'
        self.project_name = 'myproj'
        self.name = 'ise'
        self.binary_loc = '%s/%s/%s.runs/impl_1/top.bin' % (
            self.compile_dir, self.project_name, self.project_name)
        ToolflowBackend.__init__(self, plat=plat, compile_dir=compile_dir)

    def add_compile_cmds(self, cores=8, plat=None):
        """
        add the tcl commands for compiling the design, and then launch
        vivado in batch mode
        """
        tcl = self.add_tcl_cmd
        tcl('set_property -name {steps.bitgen.args.More Options} -value '
            '{-g Binary:Yes} -objects [get_runs impl_1]')
        tcl('reset_run synth_1')
        tcl('launch_runs synth_1')
        tcl('wait_on_run synth_1')
        tcl('launch_runs impl_1 -to_step BitGen')
        tcl('wait_on_run impl_1')
        # Generate timing report. There is no way to read back the timing paths.
        # 'get_timing_paths' is not recognised in ISE PlanAhead, so reports
        # are generated. The report will indicate whether the timing has
        # failed or not.
        tcl('open_run [get_runs impl_1]')
        tcl('puts "Report setup timing" ')
        tcl('report_timing -max_paths 1 -nworst 1 -setup')
        tcl('report_timing -name setup1 -max_paths 1 -nworst 1 -setup')
        tcl('write_timing setup1 -force %s/%s/%s.runs/impl_1/setup_timing_'
            'analysis.rpt' % (self.compile_dir, self.project_name,
                              self.project_name))
        tcl('puts "Report hold timing" ')
        tcl('report_timing -max_paths 1 -nworst 1 -hold')
        tcl('report_timing -name hold1 -max_paths 1 -nworst 1 -hold')
        tcl('write_timing hold1 -force %s/%s/%s.runs/impl_1/hold_timing_'
            'analysis.rpt' % (self.compile_dir, self.project_name,
                              self.project_name))
        tcl('exit')

    def compile(self, cores, plat):
        """
        
        :return: 
        """
        self.add_compile_cmds()
        # write tcl command to file
        tcl_file = self.compile_dir+'/gogogo.tcl'
        helpers.write_file(tcl_file, self.tcl_cmd)
        # os.system('vivado -mode batch -source %s'%(tcl_file))
        os.system('planAhead -jou %s/planahead.jou -log %s/planahead.log '
                  '-mode tcl -source %s' % (self.compile_dir,
                                            self.compile_dir, tcl_file))

    @staticmethod
    def format_const(attribute, val, port, index=None):
        """
        Generate a tcl syntax command from an attribute, value and port
        (with indexing if required)
        """
        if index is None:
            return 'NET "%s" %s = "%s";\n' % (port, attribute, val)
        else:
            return 'NET %s<%d> %s = "%s";\n' % (port, index, attribute, val)

    def gen_constraint_file(self, constraints):
        """
        Pass this method a toolflow-standard list of constraints
        which have already had their physical parameters calculated
        and it will generate a contstraint file and add it to the
        current project.
        """
        constfile = '%s/user_const.ucf' % self.compile_dir
        user_const = ''
        print 'constraints %s' % constraints
        for constraint in constraints:
            print 'parsing constraint', constraint
            user_const += self.get_ucf_const(constraint)
        print user_const
        helpers.write_file(constfile, user_const)
        print 'written constraint file', constfile
        self.add_const_file(constfile)

    def get_ucf_const(self, const):
        """
        Pass a single toolflow-standard PortConstraint, 
        and get back a tcl command to add the constraint
        to a vivado project.
        """
        user_const = ''
        if isinstance(const, castro.PinConstraint):
            self.logger.debug('New PortConstraint instance found: %s -> '
                              '%s' % (const.portname, const.symbolic_name))
            for idx, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting loc for port index %d' % idx)
                loc = const.location[idx]
                if loc is not None:
                    self.logger.debug('LOC constraint found at %s' % loc)
                    user_const += self.format_const(
                        'LOC', loc, const.portname,
                        index=p if const.portname_indices else None)

            for idx, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting iostd for port index %d' % idx)
                iostd = const.io_standard[idx]
                if iostd is not None:
                    self.logger.debug('IOSTD constraint found: %s' % iostd)
                    user_const += self.format_const(
                        'IOSTANDARD', iostd, const.portname,
                        index=p if const.portname_indices else None)

        if isinstance(const, castro.ClkConstraint):
            self.logger.debug('New Clock constraint found')
            user_const += self.format_clock_const(const)

        if isinstance(const, RawConstraint):
            self.logger.debug('New Raw constraint found')
            user_const += const.raw

        return user_const

    @staticmethod
    def format_clock_const(c):
        return 'NET "%s" TNM_NET = "%s";\nTIMESPEC "TS_%s" = PERIOD ' \
               '"%s" %f ns HIGH 50 %s;\n' % (c.portname, c.portname + '_grp',
                                             c.portname, c.portname + '_grp',
                                             c.period_ns, '%')

# end
