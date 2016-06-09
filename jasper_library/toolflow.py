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
from constraints import PortConstraint, ClockConstraint, RawConstraint
import castro
import helpers
import yaml
import glob
import time


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
    
    def __init__(self, frontend='simulink', compile_dir='/tmp', frontend_target='/tmp/test.slx', jobs=8):
        """
        Initialize the toolflow.
         
        :param frontend: Name of the toolflow frontend to use. Currently only 'simulink' is supported
        :type frontend: str
        :param backend: Name of the toolflow backend to use. Currently only 'vivado' is supported
        :type backend: str
        :param compile_dir: Compile directory where build files and logs should go.
        :type backend: str
        """
        # Set up a logger (the logger named 'jasper' should already
        # have been configured beforehand
        self.logger = logging.getLogger('jasper.toolflow')
        self.jobs = jobs

        self.logger.info('Starting Toolflow!')
        self.logger.info('Frontend is %s' % frontend)

        self.compile_dir = compile_dir.rstrip('/')
        self.output_dir = self.compile_dir + '/outputs'

        self.logger.info("Setting compile directory: %s" % self.compile_dir)
        os.system('mkdir -p %s' % self.compile_dir)
        os.system('mkdir -p %s' % self.output_dir)

        # compile parameters which can be set straight away
        self.start_time = time.localtime()
        self.periph_file = self.compile_dir + '/jasper.per'
        self.frontend_target = frontend_target
        self.frontend_target_base = os.path.basename(frontend_target)

        if frontend == 'simulink':
            self.frontend = SimulinkFrontend(compile_dir=self.compile_dir, target=frontend_target)
        else:
            self.logger.error("Unsupported toolflow frontent: %s"%frontend)
            raise Exception("Unsupported toolflow frontend: %s"%frontend)

        #if backend == 'vivado':
        #    self.backend = VivadoBackend(compile_dir=self.compile_dir)
        #elif backend == 'ise':
        #    self.backend = ISEBackend(compile_dir=self.compile_dir)
        #else:
        #    self.logger.error("Unsupported toolflow backend: %s"%backend)
        #    raise Exception("Unsupported toolflow backend: %s"%backend)

        self.sources= []
        self.tcl_sources= []
        self.const_files = []

    def exec_flow(self, gen_per=True, frontend_compile=True):
        """
        Execute a compile.
        
        :param gen_per: Have the toolflow frontend generate a fresh peripherals file
        :type gen_per: bool
        :param frontend_compile: Run the frontend compiler (eg. System Generator)
        :type frontend_compile: bool
        :param backend_compile: Run the backend compiler (eg. Vivado)
        :type backend_compile: bool
        """

        if gen_per:
            self.frontend.gen_periph_file(fname=self.periph_file)

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
        # mkbof_cmd = '%s/jasper_library/mkbof_64 -o %s/%s -s %s/core_info.tab -t 3 %s/top.bin'%
        # (os.getenv('MLIB_DEVEL_PATH'), self.output_dir, self.output, self.compile_dir, self.compile_dir)
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
        :param generator: Method which can be used to set thing (used for error message only)
        :type generator: str
        """
        try:
            if self.__getattribute__(thing) is None:
                self.logger.error("%s is not defined. Have you run %s yet?" % (thing,generator))
                raise AttributeError("%s is not defined. Have you run %s yet?" % (thing,generator))
        except AttributeError:
            self.logger.error("%s is not defined. Have you run %s yet?" % (thing,generator))
            raise AttributeError("%s is not defined. Have you run %s yet?" % (thing,generator))

    def _add_external_tcl(self):
        """
        Add tcl commands from the frontend
        """
        for fname in self.tcl_sources:
            with open(fname, 'r') as fh:
                self.backend.add_tcl_cmd(fh.read())

    def generate_hdl(self):
        """
        Generates a top file for the target platform
        based on the peripherals file.
        Internally, calls:
        instantiate_periphs -- call each yellow block's mod_top method
        instantiate_user_ip -- add ports to top module based on port entries in peripheral file
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
            self.logger.error("Peripherals file doesn't exist!")
            raise Exception("Peripherals file doesn't exist!")
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
                # self.plat = platform.Platform.get_loader(self.peripherals[key]['hw_sys'])
                self.plat = platform.Platform(self.peripherals[key]['hw_sys'].split(':')[0])
                # self.backend.plat = self.plat
                self.clk_src = self.peripherals[key]['clk_src']
                self.clk_rate = float(self.peripherals[key]['clk_rate'])  # in MHz
                return
        raise Exception("self.peripherals does not contain anything tagged xps:xsg")

    def _drc(self):
        """
        Get the provisions of the active platform and yellow blocks
        and compare with the current requirements of blocks in the design.
        """
        provisions = self._get_provisions()
        # check all requirements and exclusive reqs are provided
        for obj in self.periph_objs:
            for req in obj.requires:
                self.logger.debug("%s requires %s" % (obj.name, req))
                if req not in provisions:
                    self.logger.error("NOT SATISFIED: %s requires %s" % (obj.name, req))
                    raise Exception("DRC FAIL! %s (required by %s) not \
                                     provided by platform or any peripheral" % (req,obj.name))
            for req in obj.exc_requires:
                self.logger.debug("%s requires %s" % (obj.name, req))
                if req not in provisions:
                    self.logger.error("NOT SATISFIED: %s requires %s" % (obj.name, req))
                    raise Exception("DRC FAIL! %s (required by %s) not \
                                     provided by platform or any peripheral" % (req,obj.name))

        # check for overallocation of resources
        used = []
        for obj in self.periph_objs:
            for req in obj.exc_requires:
                self.logger.debug("%s requires %s exclusively" % (obj.name, req))
                if req in used:
                    raise Exception("DRC FAIL! %s requires %s, but it has \
                                     already been used by another block." % (obj.name,req))
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
        # os.system('cp %s %s'%(basetopfile,self.topfile))
        self.sources.append(self.topfile)
        for source in self.plat.sources:
            self.sources.append(os.getenv('HDL_ROOT')+'/'+source)
        for source in self.plat.consts:
            self.const_files.append(os.getenv('HDL_ROOT') + '/%s/%s' % (self.plat.name, source))
        if os.path.exists(self.topfile):
            self.top = verilog.VerilogModule(name='top', topfile=self.topfile)
        else:
            self.top = verilog.VerilogModule(name='top')   

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
            self.logger.debug('Generating Yellow Block: %s'%pk)
            self.periph_objs.append(yellow_block.YellowBlock.make_block(self.peripherals[pk], self.plat))

        self.periph_objs.append(yellow_block.YellowBlock.make_block({'tag': 'xps:'+self.plat.name}, self.plat))
        self._expand_children(self.periph_objs)
        self._drc()

    def _expand_children(self, population, parents=None, recursive=True):
        """
        population: a list of yellow blocks to which children will be added
        parents: a list of yellow blocks which will be invited to procreate.
                 If parents=None, the population will be used as the initial
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
        if children == []:
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
        print 'top:',self.topfile
        for obj in self.periph_objs:
            self.logger.debug('modifying top for obj %s' % obj.name)
            obj.modify_top(self.top)
            self.sources += obj.sources    
    
    def _instantiate_user_ip(self):
        """
        Adds VerilogInstance and ports associated with user-ip to the class' top
        VerilogModule instance.
        """
        for name,module in self.user_modules.items():
            inst = self.top.get_instance(entity=name, name='%s_inst' % name)
            # internal=False --> we assume that other yellow
            # blocks have set up appropriate signals in top.v
            # (we can't add them here anyway, because we don't
            # know the port widths)
            if 'clock' in module.keys():
                inst.add_port(name=module['clock'], signal='user_clk', parent_sig=False)
            if 'clock_enable' in module.keys():
                inst.add_port(name=module['clock_enable'], signal="1'b1", parent_sig=False)
            for port in module['ports']:
                inst.add_port(name=port, signal=port, parent_sig=False)

            if module['sources'] is not None:
                for source in module['sources']:
                    self.sources += glob.glob(source)
            if module['tcl_sources'] is not None:
                for source in module['tcl_sources']:
                    self.tcl_sources += glob.glob(source)

    def write_core_info(self):
        self.cores = self.top.wb_devices
        basefile = '%s/%s/core_info.tab' % (os.getenv('HDL_ROOT'), self.plat.name)
        newfile = '%s/core_info.tab' % self.compile_dir
        self.logger.debug('Opening %s' % basefile)
        with open(basefile, 'r') as fh:
            s = fh.read()
        modemap = {'rw': 3, 'r': 1, 'w': 2}
        if len(self.cores) != 0:
            longest_name = max([len(core.regname) for core in self.cores])
            format_str = '{0:%d} {1:1} {2:<16x} {3:<16x}\n' % longest_name
        for core in self.cores:
            self.logger.debug('Adding core_info.tab entry for %s' % core.regname)
            s += format_str.format(core.regname, modemap[core.mode], core.base_addr, core.nbytes)
            # s += '%s\t%d\t%x\t%x\n'%(core.regname, modemap[core.mode], core.base_addr, core.nbytes)
        self.logger.debug('Opening %s' % basefile)
        with open(newfile, 'w') as fh:
            fh.write(s)

    def regenerate_top(self):
        """
        Generate the verilog for the modified top
        module. This involves computing the wishbone
        interconnect / addressing and generating new
        code for yellow block instances.
        """
        self.top.wb_compute()   
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
                self.logger.warning("Port %s has no constraints!" % port)

    def dump_castro(self, filename):
        """
        Build a "standard" Castro object, which is the
        interface between the toolflow and the backends.
        """
        import castro
        
        c = castro.Castro('top', self.sources)

        # build castro standard pin constraints
        pin_constraints = []
        clk_constraints = []
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
                    period_ns=const.period
                    )]
            elif isinstance(const, RawConstraint):
                raw_constraints += [castro.RawConstraint(
                    const.raw)]

        c.synthesis = castro.Synthesis()
        c.synthesis.pin_constraints = pin_constraints
        c.synthesis.clk_constraints = clk_constraints
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
            mm_slaves += [castro.mm_slave(dev.regname, mode, dev.base_addr, dev.nbytes)]
            
        c.mm_slaves = mm_slaves
        
        with open(filename, 'w') as fh:
            fh.write(yaml.dump(c))
        

class ToolflowFrontend(object):
    def __init__(self, compile_dir='/tmp', target='/tmp/test.slx'):
        self.logger = logging.getLogger('jasper.toolflow.frontend')
        self.compile_dir = compile_dir
        if not os.path.exists(target):
            self.logger.error('Target path %s does not exist!'%target)
            raise Exception('Target path %s does not exist!'%target)
        self.target=target

    def gen_periph_file(self,fname='jasper.per'):
        """
        Call upon the frontend to generate a
        jasper-standard file defining peripherals
        (yellow blocks) present in a model.
        This method should be overridden by the
        specific frontend of choice, and should
        return the full path to the
        peripheral file.
        Use skip=True to just return the name of
        the file, without bothering to regenerate it
        (useful for debugging, and future use cases
        where a user only wants to run certain
        steps of a compile)
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
    def __init__(self, plat=None, compile_dir='/tmp'):
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
        self.output_dir = compile_dir + '/outputs'
        self.plat = plat
        if plat:
           self.initialize(plat)

    def compile(self):
        raise NotImplementedError()

    def import_from_castro(self, filename):
        import castro
        self.castro = castro.Castro.load(filename)
        existing_sources = []
        for source in self.castro.src_files:
            if source not in existing_sources:
                existing_sources.append(source)
                if not os.path.exists(source):
                    self.logger.error("sourcefile %s doesn't exist!" % source)
                    raise Exception("sourcefile %s doesn't exist!" % source)
                self.add_source(source, self.plat)
        existing_sources = []
        for source in self.castro.synthesis.vendor_constraints_files:
            if source not in existing_sources:
                existing_sources.append(source)
                if not os.path.exists(source):
                    self.logger.error("sourcefile %s doesn't exist!" % source)
                    raise Exception("sourcefile %s doesn't exist!" % source)
                self.add_const_file(source, self.plat)
       
        # elaborate pin constraints
        for const in self.castro.synthesis.pin_constraints:
            pins = self.plat.get_pins(const.symbolic_name, const.symbolic_indices)
            const.location = [pins[i].loc for i in range(len(const.symbolic_indices))]
            const.io_standard = [pins[i].iostd for i in range(len(const.symbolic_indices))]
            const.is_vector = const.portname_indices != []

        self.gen_constraint_file(self.castro.synthesis.pin_constraints + self.castro.synthesis.clk_constraints + self.castro.synthesis.raw_constraints,
                                 self.plat)
        

class SimulinkFrontend(ToolflowFrontend):
    def __init__(self, compile_dir='/tmp', target='/tmp/test.slx'):
        ToolflowFrontend.__init__(self, compile_dir=compile_dir, target=target)
        if target[-4:] not in ['.slx', '.mdl']:
            self.logger.warning('Frontend target %s does not look like a simulink file!' % target)
        self.modelpath = target
        self.modelname = target.split('/')[-1][:-4]  # strip off extension

    def gen_periph_file(self, fname='jasper.per'):
        """
        generate the peripheral file. i.e., the list of yellow blocks
        and their parameters.

        :param fname: The full path and name to give the peripheral file.
        :type fname: str
        """
        self.logger.info('Generating yellow block description file : %s' % fname)
        # The command to start matlab with appropriate libraries
        matlab_start_cmd = os.getenv('SYSGEN_SCRIPT')

        # The matlab script responsible for generating the peripheral file
        # each script represents a matlab function
        script1 = 'open_system'
        script2 = 'set_param'
        script3 = 'gen_block_file'
        # The matlab syntax to call this script with appropriate args
        # This scripts runs open_system(), set_param() and finally gen_block_file().
        # if open_system() and set_param() are not run then the peripheral names will
        # be incorrectly generated and the design will not compile. Everything is run
        # on a single matlab terminal line
        ml_cmd = "%s('%s');sys=gcs;%s(sys,'SimulationCommand','update');%s('%s','%s');exit" \
                 % (script1, self.modelpath, script2, script3, self.compile_dir, fname)
        # Complete command to run on terminal
        term_cmd = matlab_start_cmd + ' -nodesktop -nosplash -r "%s"' % ml_cmd
        self.logger.info('Running terminal command: %s' % term_cmd)
        os.system(term_cmd)

    def compile_user_ip(self,update=False):
        """
        Compile the users simulink design. The resulting netlist should
        end up in the location already specified in the peripherals file.

        :param update: Update the simulink model before running system generator.
        :type update: bool
        """
        self.logger.info('Compiling user IP to module: %s' % self.modelname)
        # The command to start matlab with appropriate libraries
        # matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
        matlab_start_cmd = os.getenv('SYSGEN_SCRIPT')
        # The matlab syntax to start a compile with appropriate args
        ml_cmd = "start_sysgen_compile('%s','%s',%d);exit" % (self.modelpath,self.compile_dir, int(update))
        term_cmd = matlab_start_cmd + ' -nodesktop -nosplash -r "%s"' % ml_cmd
        self.logger.info('Running terminal command: %s' % term_cmd)
        os.system(term_cmd)
        # return the name of the top module of the user ip


class VivadoBackend(ToolflowBackend):
    def __init__(self, plat=None, compile_dir='/tmp'):
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
        self.manufacturer = 'xilinx'
        self.project_name = 'myproj'
        # if project mode is enabled
        if plat.project_mode:
            self.binary_loc = '%s/%s/%s.runs/impl_1/top.bin' % (self.compile_dir, self.project_name, self.project_name)
        # if non-project mode is enabled
        else:
            self.binary_loc = '%s/%s/top.bin' % (self.compile_dir, self.project_name)

        self.name = 'vivado'
        self.npm_sources = []
        ToolflowBackend.__init__(self, plat=plat, compile_dir=compile_dir)

    def initialize(self, plat):
        self.tcl_cmd = ''
        if plat.manufacturer != self.manufacturer:
            self.logger.error('Trying to compile a %s FPGA using %s %s'
                              % (plat.manufacturer, self.manufacturer, self.name))

        self.add_tcl_cmd('puts "Starting tcl script"')
        # Create Vivado Project in project mode only
        if plat.project_mode:
            self.add_tcl_cmd('create_project -f %s %s/%s -part %s'
                             % (self.project_name, self.compile_dir, self.project_name, plat.fpga))
        # Create the part in non-project mode (project runs in memory only)
        else:
            self.add_tcl_cmd('file mkdir %s/%s' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('set_part %s' % plat.fpga)

        # for source in plat.sources:
        #  self.add_source(os.getenv('HDL_ROOT')+'/'+source)
        #  self.add_source(self.compile_dir+'/top.v')

    def add_source(self, source, plat):
        """
        Add a sourcefile to the project. Via a tcl incantation.
        In non-project mode, it is important to note that copies are not made of files. The files
        are read from their source directory. Project mode copies files from their source directory
        and adds them to the a new compile directory.
        """
        self.logger.debug('Adding source file: %s' % source)
        # Project Mode is enabled
        if plat.project_mode:
            self.add_tcl_cmd('import_files -force %s' % source)
        # Non-Project Mode is enabled
        else:
            if os.path.basename(source) == 'top.v':
                # Convert from string to Lists and extract filenames from the directory source
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
                    self.add_tcl_cmd('read_vhdl %s/%s' % (source,current_source))
                # Verilog File
                if ext == self.src_file_verilog_ext:
                    # Only read from source when reading the top.v file
                    if os.path.basename(source) == 'top.v':
                      self.add_tcl_cmd('read_verilog %s' % source)
                    else:
                      self.add_tcl_cmd('read_verilog %s/%s' % (source,current_source))
                # System Verilog File
                if ext == self.src_file_sys_verilog_ext:
                    self.add_tcl_cmd('read_verilog -sv %s/%s' % (source,current_source))
                # IP File
                if ext == self.src_file_ip_ext:
                    self.add_tcl_cmd('read_ip %s/%s' % (source,current_source))
                # Block Diagram File
                if ext == self.src_file_block_diagram_ext:
                    self.add_tcl_cmd('read_bd %s/%s' % (source,current_source))
                # ELF Microblaze File
                if ext == self.src_file_elf_ext:
                    self.add_tcl_cmd('add_files %s/%s' % (source,current_source))
                # Coefficient BRAM File
                if ext == self.src_file_coe_ext:
                    self.add_tcl_cmd('add_files %s/%s' % (source,current_source))

    def add_const_file(self, constfile, plat):
        """
        Add a constraint file to the project. via a tcl incantation.
        In non-project mode, it is important to note that copies are not made of files. The files
        are read from their source directory. Project mode copies files from their source directory
        and adds them to the a new compile directory.
        """
        if constfile.split('.')[-1] == self.const_file_ext:
            self.logger.debug('Adding constraint file: %s' % constfile)
            # Project Mode is enabled
            if plat.project_mode:
                self.add_tcl_cmd('import_files -force -fileset constrs_1 %s' % constfile)
            # Non-Project Mode is enabled
            else:
                self.add_tcl_cmd('read_xdc %s' % constfile)

        else:
            self.logger.debug('Ignore constraint file: %s, with wrong file extension' % constfile)

    def add_tcl_cmd(self,cmd):
        """
        Add a command to the tcl command list with
        a trailing newline.
        """
        self.logger.debug('Adding tcl command: %s' % cmd)
        self.tcl_cmd += cmd
        self.tcl_cmd += '\n'

    def add_compile_cmds(self, cores=8, plat=None):
        """
        Add the tcl commands for compiling the design, and then launch
        vivado in batch mode
        """
        # Project Mode is enabled
        if plat.project_mode:
            self.add_tcl_cmd('set_property top top [current_fileset]')
            self.add_tcl_cmd('update_compile_order -fileset sources_1')
            self.add_tcl_cmd('set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]')
            self.add_tcl_cmd('set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]')
            # Hack to get the System generator RAMs to see their coefficient files.
            # Vivado (2016.1) doesn't seem to import the .coe and ram .xci files in the
            # correct relative directories as configured by System Generator.
            self.add_tcl_cmd('if {[llength [glob -nocomplain [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe]] > 0} {')
            self.add_tcl_cmd('file copy -force {*}[glob [get_property directory [current_project]]/myproj.srcs/sources_1/imports/*.coe] [get_property directory [current_project]]/myproj.srcs/sources_1/ip/')
            self.add_tcl_cmd('}')
            self.add_tcl_cmd('upgrade_ip -quiet [get_ips *]')
            self.add_tcl_cmd('reset_run synth_1')
            self.add_tcl_cmd('launch_runs synth_1 -jobs %d' % cores)
            self.add_tcl_cmd('wait_on_run synth_1')
            self.add_tcl_cmd('launch_runs impl_1 -jobs %d' % cores)
            self.add_tcl_cmd('wait_on_run impl_1')
            self.add_tcl_cmd('open_run impl_1')
            # self.add_tcl_cmd('set_property CONFIG_VOLTAGE %.1f [get_designs impl_1]'
            # % self.plat.conf['config_voltage'])
            # self.add_tcl_cmd('set_property CFGBVS %s [get_designs impl_1]' % self.plat.conf['cfgbvs'])
            self.add_tcl_cmd('launch_runs impl_1 -to_step write_bitstream')
            self.add_tcl_cmd('wait_on_run impl_1')
            # Generate a binary file for SKARAB where the bits are reversed per byte. This is used by casperfpga for
            # configuring the FPGA
            if plat.name == 'skarab':
                self.add_tcl_cmd('write_cfgmem -force -format bin -interface bpix8 -size 128 -loadbit "up 0x0 '
                                 '%s/%s/%s.runs/impl_1/top.bit" -file %s/%s/%s.runs/impl_1/top_skarab.bin'
                                 % (self.compile_dir, self.project_name, self.project_name, self.compile_dir,
                                    self.project_name, self.project_name))

            # Determine if the design meets timing or not
            # Look for Worst Negative Slack
            self.add_tcl_cmd('if { [get_property STATS.WNS [get_runs impl_1] ] < 0 } {')
            self.add_tcl_cmd('puts "Found timing violations => Worst Negative Slack:'
                             ' [get_property STATS.WNS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No timing violations => Worst Negative Slack:'
                             ' [get_property STATS.WNS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('}')
            # Look for Total Negative Slack
            self.add_tcl_cmd('if { [get_property STATS.TNS [get_runs impl_1] ] < 0 } {')
            self.add_tcl_cmd('puts "Found timing violations => Total Negative Slack:'
                             ' [get_property STATS.TNS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No timing violations => Total Negative Slack:'
                             ' [get_property STATS.TNS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('}')
            # Look for Worst Hold Slack
            self.add_tcl_cmd('if { [get_property STATS.WHS [get_runs impl_1] ] < 0 } {')
            self.add_tcl_cmd('puts "Found timing violations => Worst Hold Slack:'
                             ' [get_property STATS.WHS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No timing violations => Worst Hold Slack:'
                             ' [get_property STATS.WHS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('}')
            # Look for Total Hold Slack
            self.add_tcl_cmd('if { [get_property STATS.THS [get_runs impl_1] ] < 0 } {')
            self.add_tcl_cmd('puts "Found timing violations => Total Hold Slack:'
                             ' [get_property STATS.THS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No timing violations => Total Hold Slack:'
                             ' [get_property STATS.THS [get_runs impl_1]] ns" ')
            self.add_tcl_cmd('}')

        # Non-Project mode is enabled
        # Options can be added to the *_design commands to change strategies or meet timing
        else:
            self.add_tcl_cmd('synth_design -top top -part %s' % plat.fpga)
            self.add_tcl_cmd('write_checkpoint -force %s/%s/post_synth.dcp' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_timing_summary -file %s/%s/post_synth_timing_summary.rpt'
                             % (self.compile_dir,self.project_name))
            self.add_tcl_cmd('report_utilization -file %s/%s/post_synth_timing_summary.rpt'
                             % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('opt_design')
            self.add_tcl_cmd('place_design')
            self.add_tcl_cmd('report_clock_utilization -file %s/%s/clock_util.rpt'
                             % (self.compile_dir, self.project_name))
            # Run power_opt_design and phys_opt_design if setup timing violations occur
            self.add_tcl_cmd('if { [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup] ] < 0 } {')
            self.add_tcl_cmd('puts "Found setup timing violations => running physical optimization" ')
            self.add_tcl_cmd('power_opt_design')
            self.add_tcl_cmd('phys_opt_design')
            self.add_tcl_cmd('}')
            # Run power_opt_design and phys_opt_design if hold timing violations occur
            self.add_tcl_cmd('if { [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -hold] ] < 0 } {')
            self.add_tcl_cmd('puts "Found hold timing violations => running physical optimization" ')
            self.add_tcl_cmd('power_opt_design')
            self.add_tcl_cmd('phys_opt_design')
            self.add_tcl_cmd('}')
            self.add_tcl_cmd('write_checkpoint -force %s/%s/post_place.dcp' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_utilization -file %s/%s/post_place_util.rpt'
                             % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_timing_summary -file %s/%s/post_place_timing_summary.rpt'
                             % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('route_design')
            self.add_tcl_cmd('write_checkpoint -force %s/%s/post_route.dcp' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_route_status -file %s/%s/post_route_status.rpt'
                             % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_timing_summary -file %s/%s/post_route_timing_summary.rpt'
                             % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_power -file %s/%s/post_route_power.rpt' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('report_drc -file %s/%s/post_imp_drc.rpt' % (self.compile_dir, self.project_name))
            self.add_tcl_cmd('set_property SEVERITY {Warning} [get_drc_checks UCIO-1]')
            self.add_tcl_cmd('write_bitstream -force -bin_file %s/%s/top.bit' % (self.compile_dir, self.project_name))
            # Generate a binary file for SKARAB where the bits are reversed per byte. This is used by casperfpga for
            # configuring the FPGA
            if plat.name == 'skarab':
                self.add_tcl_cmd('write_cfgmem -force -format bin -interface bpix8 -size 128 -loadbit "up 0x0 '
                                 '%s/%s/top.bit" -file %s/%s/top_skarab.bin'
                                 % (self.compile_dir, self.project_name, self.compile_dir, self.project_name))
            # Determine if the design meets timing or not
            # Check for setup timing violations
            self.add_tcl_cmd('if { [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup] ] < 0 } {')
            self.add_tcl_cmd('puts "Found setup timing violations => Worst Setup Slack:'
                             ' [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No setup timing violations => Worst Setup Slack:'
                             ' [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] ns" ')
            self.add_tcl_cmd('}')
            # Check for hold timing violations
            self.add_tcl_cmd('if { [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -hold] ] < 0 } {')
            self.add_tcl_cmd('puts "Found setup timing violations => Worst Hold Slack:'
                             ' [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -hold]] ns" ')
            self.add_tcl_cmd('} else {')
            self.add_tcl_cmd('puts "No setup timing violations => Worst Hold Slack:'
                             ' [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -hold]] ns" ')
            self.add_tcl_cmd('}')

    def compile(self, cores, plat):
        self.add_compile_cmds(cores=cores, plat=plat)
        # write tcl command to file
        tcl_file = self.compile_dir+'/gogogo.tcl'
        helpers.write_file(tcl_file,self.tcl_cmd)
        rv = os.system('vivado -jou %s/vivado.jou -log %s/vivado.log -mode batch -source %s'
                       % (self.compile_dir, self.compile_dir, tcl_file))
        if rv:
            raise Exception("Vivado failed!")

    def get_tcl_const(self,const):
        """
        Pass a single toolflow-standard PortConstraint,
        and get back a tcl command to add the constraint
        to a vivado project.
        """
        user_const = ''
        if isinstance(const, castro.PinConstraint):
            self.logger.debug('New PortConstraint instance found: %s -> %s' % (const.portname, const.symbolic_name))
            for i,p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting loc for port index %d' % i)
                if const.location[i] is not None:
                    self.logger.debug('LOC constraint found at %s' % const.location[i])
                    if const.portname_indices != []:
                        user_const += self.format_const('PACKAGE_PIN', const.location[i], const.portname, index=p)
                    else:
                        user_const += self.format_const('PACKAGE_PIN', const.location[i], const.portname)

            for i,p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting iostd for port index %d' % i)
                if const.io_standard[i] is not None:
                    self.logger.debug('IOSTD constraint found: %s' % const.io_standard[i])
                    if const.portname_indices != []:
                        user_const += self.format_const('IOSTANDARD', const.io_standard[i], const.portname, index=p)
                    else:
                        user_const += self.format_const('IOSTANDARD', const.io_standard[i], const.portname)

        if isinstance(const, castro.ClkConstraint):
            self.logger.debug('New Clock constraint found')
            user_const += self.format_clock_const(const)

        if isinstance(const, castro.RawConstraint):
            self.logger.debug('New Raw constraint found')
            user_const += const.raw

        return user_const

    def format_clock_const(self, c):
        return 'create_clock -period %f -name %s [get_ports {%s}]\n' % (c.period_ns, c.portname+'_CLK', c.portname)

    def format_const(self, attribute, val, port, index=None):
        """
        Generate a tcl syntax command from an attribute, value and port
        (with indexing if required)
        """
        if index is None:
            return 'set_property %s %s [get_ports %s]\n' % (attribute, val, port)
        else:
            return 'set_property %s %s [get_ports %s[%d]]\n' % (attribute, val, port, index)

    def gen_constraint_file(self, constraints, plat):
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
        helpers.write_file(constfile,user_const)
        print 'written constraint file', constfile
        self.add_const_file(constfile, plat)


class ISEBackend(VivadoBackend):
    def __init__(self, plat=None, compile_dir='/tmp'):
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
        self.const_file_ext = 'ucf'
        self.manufacturer = 'xilinx'
        self.project_name = 'myproj'
        self.name = 'ise'
        self.binary_loc = '%s/%s/%s.runs/impl_1/top.bin' % (self.compile_dir, self.project_name, self.project_name)
        ToolflowBackend.__init__(self, plat=plat, compile_dir=compile_dir)

    def add_compile_cmds(self):
        """
        add the tcl commands for compiling the design, and then launch
        vivado in batch mode
        """
        self.add_tcl_cmd('set_property -name {steps.bitgen.args.More Options} -value {-g Binary:Yes} '
                         '-objects [get_runs impl_1]')
        self.add_tcl_cmd('reset_run synth_1')
        self.add_tcl_cmd('launch_runs synth_1')
        self.add_tcl_cmd('wait_on_run synth_1')
        self.add_tcl_cmd('launch_runs impl_1 -to_step BitGen')
        self.add_tcl_cmd('wait_on_run impl_1')
        # Generate timing report. There is no way to read back the timing paths. "get_timing_paths" is not recognised
        # in ISE PlanAhead, so reports are generated. The report will indicate whether the timing has failed or not.
        self.add_tcl_cmd('open_run [get_runs impl_1]')
        self.add_tcl_cmd('puts "Report setup timing" ')
        self.add_tcl_cmd('report_timing -max_paths 1 -nworst 1 -setup')
        self.add_tcl_cmd('report_timing -name setup1 -max_paths 1 -nworst 1 -setup')
        self.add_tcl_cmd('write_timing setup1 -force %s/%s/%s.runs/impl_1/setup_timing_analysis.rpt'
                         % (self.compile_dir, self.project_name, self.project_name))
        self.add_tcl_cmd('puts "Report hold timing" ')
        self.add_tcl_cmd('report_timing -max_paths 1 -nworst 1 -hold')
        self.add_tcl_cmd('report_timing -name hold1 -max_paths 1 -nworst 1 -hold')
        self.add_tcl_cmd('write_timing hold1 -force %s/%s/%s.runs/impl_1/hold_timing_analysis.rpt'
                         % (self.compile_dir, self.project_name, self.project_name))
        self.add_tcl_cmd('exit')

    def compile(self):
        self.add_compile_cmds()
        # write tcl command to file
        tcl_file = self.compile_dir+'/gogogo.tcl'
        helpers.write_file(tcl_file,self.tcl_cmd)
        # os.system('vivado -mode batch -source %s'%(tcl_file))
        os.system('planAhead -jou %s/planahead.jou -log %s/planahead.log -mode tcl -source %s'
                  % (self.compile_dir, self.compile_dir, tcl_file))

    def format_const(self, attribute, val, port, index=None):
        """
        Generate a tcl syntax command from an attribute, value and port
        (with indexing if required)
        """
        if index is None:
            return 'NET "%s" %s = "%s";\n' % (port, attribute, val)
        else:
            return 'NET %s<%d> %s = "%s";\n' % (port, index, attribute, val)

    def gen_constraint_file(self, constraints, plat):
        """
        Pass this method a toolflow-standard list of constraints
        which have already had their physical parameters calculated
        and it will generate a contstraint file and add it to the
        current project.
        """
        constfile = '%s/user_const.ucf' % self.compile_dir
        user_const = ''
        print 'constraints %s'%constraints
        for constraint in constraints:
            print 'parsing constraint', constraint
            user_const += self.get_ucf_const(constraint)
        print user_const
        helpers.write_file(constfile,user_const)
        print 'written constraint file', constfile
        self.add_const_file(constfile, plat)

    def get_ucf_const(self, const):
        """
        Pass a single toolflow-standard PortConstraint,
        and get back a tcl command to add the constraint
        to a vivado project.
        """
        user_const = ''
        if isinstance(const, castro.PinConstraint):
            self.logger.debug('New PortConstraint instance found: %s -> %s' % (const.portname, const.symbolic_name))
            for i, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting loc for port index %d' % i)
                if const.location[i] is not None:
                    self.logger.debug('LOC constraint found at %s' % const.location[i])
                    if const.portname_indices != []:
                        user_const += self.format_const('LOC', const.location[i], const.portname, index=p)
                    else:
                        user_const += self.format_const('LOC', const.location[i], const.portname)

            for i, p in enumerate(const.symbolic_indices):
                self.logger.debug('Getting iostd for port index %d' % i)
                if const.io_standard[i] is not None:
                    self.logger.debug('IOSTD constraint found: %s' % const.io_standard[i])
                    if const.portname_indices != []:
                        user_const += self.format_const('IOSTANDARD', const.io_standard[i], const.portname, index=p)
                    else:
                        user_const += self.format_const('IOSTANDARD', const.io_standard[i], const.portname)

        if isinstance(const, castro.ClkConstraint):
            self.logger.debug('New Clock constraint found')
            user_const += self.format_clock_const(const)

        if isinstance(const, RawConstraint):
            self.logger.debug('New Raw constraint found')
            user_const += const.raw

        return user_const

    def format_clock_const(self, c):
        return 'NET "%s" TNM_NET = "%s";\nTIMESPEC "TS_%s" = PERIOD "%s" %f ns HIGH 50 %s;\n' % (
               c.portname, c.portname + '_grp', c.portname, c.portname + '_grp', c.period_ns, '%')
