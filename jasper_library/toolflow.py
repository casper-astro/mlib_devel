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
from constraints import PortConstraint
import helpers
import yaml

class Toolflow(object):
    '''
    A class embodying the main functionality of the toolflow.
    This class is responsible for generating a complete
    top-level verilog description of a project from a 'peripherals file'
    which encodes information about which IP a user wants instantiated.

    The toolflow class can parse such a file, and use it to generate verilog,
    a list of source files, and a list of constraints.
    These can be passed off to a toolflow backend to be turned into some
    vendor-specific platform and compiled. At least, that's the plan...
    '''
    
    def __init__(self, frontend='simulink', backend='vivado', compile_dir='/tmp', frontend_target='/tmp/test.slx'):
        '''
        Initialize the toolflow.
         
        :param frontend: Name of the toolflow frontend to use. Currently only 'simulink' is supported
        :type frontend: str
        :param backend: Name of the toolflow backend to use. Currently only 'vivado' is supported
        :type backend: str
        :param compile_dir: Compile directory where build files and logs should go.
        :type backend: str
        '''
        # Set up a logger (the logger named 'jasper' should already
        # have been configured beforehand
        self.logger = logging.getLogger('jasper.toolflow')

        self.logger.info('Starting Toolflow!')
        self.logger.info('Frontend is %s'%frontend)
        self.logger.info('Backend is %s'%backend)

        self.compile_dir = compile_dir.rstrip('/')
        self.logger.info("Setting compile directory: %s"%self.compile_dir)
        os.system('mkdir -p %s'%self.compile_dir)

        if frontend == 'simulink':
            self.frontend = SimulinkFrontend(compile_dir=self.compile_dir, target=frontend_target)
        else:
            self.logger.error("Unsupported toolflow frontent: %s"%frontend)
            raise Exception("Unsupported toolflow frontend: %s"%frontend)

        if backend == 'vivado':
            self.backend = VivadoBackend(compile_dir=self.compile_dir)
        else:
            self.logger.error("Unsupported toolflow backent: %s"%backend)
            raise Exception("Unsupported toolflow backend: %s"%backend)

        # compile parameters which can be set straight away
        self.periph_file = self.compile_dir + '/jasper.per'
        self.sources= []

    def exec_flow(self, gen_per=True, frontend_compile=True, backend_compile=True):
        '''
        Execute a compile.
        
        :param gen_per: Have the toolflow frontend generate a fresh peripherals file
        :type gen_per: bool
        :param frontend_compile: Run the frontend compiler (eg. System Generator)
        :type frontend_compile: bool
        :param backend_compile: Run the backend compiler (eg. Vivado)
        :type backend_compile: bool
        '''

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
        # Generate the tcl file which will start a new
        # vivado project, and add appropriate
        # hdl/constraint sources
        print 'Initializing backend project'
        self.backend.initialize(self.plat)
        
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
        
        
        # Backend compile
        # Generate a vivado spec constraints file from the
        # constraints extracted from yellow blocks
        self.add_sources_to_be()
        self.backend.gen_constraint_file(self.constraints)
        if backend_compile:
            # launch vivado via the generated .tcl file
            self.backend.compile()

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
            if self.__getattribute__(thing) == None:
                self.logger.error("%s is not defined. Have you run %s yet?"%(thing,generator))
                raise AttributeError("%s is not defined. Have you run %s yet?"%(thing,generator))
        except AttributeError:
            self.logger.error("%s is not defined. Have you run %s yet?"%(thing,generator))
            raise AttributeError("%s is not defined. Have you run %s yet?"%(thing,generator))

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
        '''
        Open the peripherals file and parse it's
        contents using the pyaml package.
        Write the resulting yellow_blocks
        and user_modules dictionaries to
        attributes
        '''
        if not os.path.exists(self.periph_file):
            self.logger.error("Peripherals file doesn't exist!")
            raise Exception("Peripherals file doesn't exist!")
        with open(self.periph_file, 'r') as fh:
            yaml_dict = yaml.load(fh)
        self.peripherals = yaml_dict['yellow_blocks']
        self.user_modules = yaml_dict['user_modules']

    def _extract_plat_info(self):
        '''
        Extract platform information from the
        yellow_block attributes.
        Use this to instantiate the appropriate
        device from the Platform class.
        '''
        for key in self.peripherals.keys():
            if self.peripherals[key]['tag'] == 'xps:xsg':
                self.plat = platform.Platform.get_loader(self.peripherals[key]['hw_sys'])
                self.backend.set_plat(self.plat)
                self.clk_src = self.peripherals[key]['clk_src']
                self.clk_rate = float(self.peripherals[key]['clk_rate']) #in MHz
                return
        raise Exception("self.peripherals does not contain anything tagged xps:xsg")

    def _drc(self):
        '''
        Get the provisions of the active platform and yellow blocks
        and compare with the current requirements of blocks in the design.
        '''
        provisions = self._get_provisions()
        # check all requirements and exclusive reqs are provided
        for obj in self.periph_objs:
            for req in obj.requires:
                self.logger.debug("%s requires %s"%(obj.name, req))
                if req not in provisions:
                    self.logger.error("NOT SATISFIED: %s requires %s"%(obj.name, req))
                    raise Exception("DRC FAIL! %s (required by %s) not " \
                                    "provided by platform or any peripheral"%(req,obj.name))
            for req in obj.exc_requires:
                self.logger.debug("%s requires %s"%(obj.name, req))
                if req not in provisions:
                    self.logger.error("NOT SATISFIED: %s requires %s"%(obj.name, req))
                    raise Exception("DRC FAIL! %s (required by %s) not " \
                                    "provided by platform or any peripheral"%(req,obj.name))

        # check for overallocation of resources
        used = []
        for obj in self.periph_objs:
            for req in obj.exc_requires:
                self.logger.debug("%s requires %s exclusively"%(obj.name, req))
                if req in used:
                    raise Exception("DRC FAIL! %s requires %s, but it has \
                                     already been used by another block."%(obj.name,req))
                else:
                    used.append(req)

    def _get_provisions(self):
        '''
        Get and return all the provisions of the active platform and
        yellow blocks.
        '''
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
        basetopfile = os.getenv('HDL_ROOT') + '/%s/top.v'%self.plat.name
        self.topfile = self.compile_dir+'/top.v'
        os.system('cp %s %s'%(basetopfile,self.topfile))
        self.sources.append(self.topfile)
        self.top = verilog.VerilogModule(name='top',topfile=self.topfile)


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
        self._drc()

    def _instantiate_periphs(self):
        """
        Calls each yellow block's modify_top method against the class'
        top VerilogModule instance
        """
        print 'top:',self.topfile
        for obj in self.periph_objs:
            self.logger.debug('modifying top for obj %s'%obj.name)
            obj.modify_top(self.top)
            self.sources += obj.sources
    
    def _instantiate_user_ip(self):
        """
        Adds VerilogInstance and ports associated with user-ip to the class' top
        VerilogModule instance.
        """
        for name,module in self.user_modules.items():
            inst = verilog.VerilogInstance(entity=name,name='%s_inst'%name)
            for port in module['ports']:
                if port == 'clk':
                    inst.add_port(name=port,signal='user_clk')
                else:
                    inst.add_port(name=port,signal=port)
            self.top.add_instance(inst)
            self.sources += module['sources']

    def regenerate_top(self):
        '''
        Generate the verilog for the modified top
        module. This involves computing the wishbone
        interconnect / addressing and generating new
        code for yellow block instances.
        '''
        self.top.wb_compute()
        self.top.gen_module_file()

    def add_sources_to_be(self):
        '''
        Add all sources in the current toolflow list
        to the backend, after de-duplicating.
        '''
        existing_sources = []
        for source in self.sources:
            if source not in existing_sources:
                existing_sources.append(source)
                if not os.path.exists(source):
                    self.logger.error("sourcefile %s doesn't exist!"%source)
                    raise Exception("sourcefile %s doesn't exist!"%source)
                self.backend.add_source(source)
            

    def generate_consts(self):
        '''
        Compose a list of constraints from each yellow block.
        Use platform information to generate the appropriate
        physical realisation of each constraint.
        '''
        self.logger.info('Extracting constraints from peripherals')
        self.check_attr_exists('periph_objs', 'gen_periph_objs()')
        self.constraints = []

        for obj in self.periph_objs:
            c = obj.gen_constraints()
            if c is not None:
                self.constraints += c

        self.logger.info('Generating physical constraints')
        for constraint in self.constraints:
            constraint.gen_physical_const(self.plat)
        


class ToolflowFrontend(object):
    def __init__(self, compile_dir='/tmp', target='/tmp/test.slx'):
        self.logger = logging.getLogger('jasper.toolflow.frontend')
        self.compile_dir = compile_dir
        if not os.path.exists(target):
            self.logger.error('Target path %s does not exist!'%target)
            raise Exception('Target path %s does not exist!'%target)
        self.target=target
    def gen_periph_file(self,fname='jasper.per'):
        '''
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
        '''
        raise NotImplementedError()
    def compile_user_ip(self):
        '''
        Compile the user IP to a single
        HDL module. Return the name of
        this module.
        Should be overridden by each FrontEnd
        subclass.
        '''
        raise NotImplementedError()

class ToolflowBackend(object):
    def __init__(self,compile_dir='/tmp'):
        self.logger = logging.getLogger('jasper.toolflow.backend')
        self.compile_dir = compile_dir
    def set_plat(self,plat):
        self.plat = plat
    def set_proj_root_dir(self,dir):
        self.proj_root_dir = dir.rstrip('/')
    def copy_base_package(self):
        raise NotImplementedError()
    def compile(self):
        raise NotImplementedError()

class SimulinkFrontend(ToolflowFrontend):
    def __init__(self,compile_dir='/tmp',target='/tmp/test.slx'):
        ToolflowFrontend.__init__(self, compile_dir=compile_dir, target=target)
        if target[-4:] not in ['.slx','.mdl']:
            self.logger.warning('Frontend target %s does not look like a simulink file!'%target)
        self.modelpath = target
        self.modelname = target.split('/')[-1][:-4] #strip off extension
    def gen_periph_file(self,fname='jasper.per'):
        '''
        generate the peripheral file. I.e., the list of yellow blocks
        and their parameters.

        :param fname: The full path and name to give the peripheral file.
        :type fname: str
        '''
        self.logger.info('Generating yellow block description file : %s'%fname)
        # The command to start matlab with appropriate libraries
        matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
        # The matlab script responsible for generating the peripheral file
        script = 'gen_block_file'
        # The matlab syntax to call this script with appropriate args
        ml_cmd = "%s('%s','%s','%s');"%(script, self.compile_dir, fname, self.modelpath)
        # Complete command to run on terminal
        term_cmd = matlab_start_cmd + ' -nodisplay -nosplash -r "%s"'%ml_cmd
        self.logger.info('Running terminal command: %s'%term_cmd)
        os.system(term_cmd)

    def compile_user_ip(self,update=False):
        '''
        Compile the users simulink design. The resulting netlist should
        end up in the location already specified in the periphrals file.

        :param update: Update the simulink model before running system generator.
        :type update: bool
        '''
        self.logger.info('Compiling user IP to module: %s'%self.modelname)
        # The command to start matlab with appropriate libraries
        matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
        # The matlab syntax to start a compile with appropriate args
        ml_cmd = "start_sysgen_compile('%s','%s',%d);"%(self.modelpath,self.compile_dir,int(update))
        term_cmd = matlab_start_cmd + ' -nosplash -r "%s"'%ml_cmd
        self.logger.info('Running terminal command: %s'%term_cmd)
        os.system(term_cmd)
        # return the name of the top module of the user ip


class VivadoBackend(ToolflowBackend):
    def initialize(self,plat):
        self.plat = plat
        self.name = 'vivado'
        self.manufacturer = 'xilinx'
        self.tcl_cmd = ''
        if plat.manufacturer != self.manufacturer:
            self.logger.error('Trying to compile a %s FPGA using %s %s'
                  %(plat.manufacturer,self.manufacturer,self.name))

        self.add_tcl_cmd('puts "Starting tcl script"')
        self.add_tcl_cmd('create_project -f %s %s/%s -part %s'%(plat.name, self.compile_dir, plat.name, plat.fpga))
        for source in plat.sources:
            self.add_source(os.getenv('HDL_ROOT')+'/'+source)
        self.add_source(self.compile_dir+'/top.v')
        for const in plat.consts:
            self.add_const_file(os.getenv('HDL_ROOT')+'/'+const)
        self.add_tcl_cmd('set_property top top [current_fileset]')
        self.add_tcl_cmd('update_compile_order -fileset sources_1')

    def add_source(self, source):
        '''
        Add a sourcefile to the project. Via a tcl incantation.
        '''
        self.logger.debug('Adding source file: %s'%source)
        self.add_tcl_cmd('import_files -force %s'%(source))

    def add_const_file(self, constfile):
        '''
        Add a constrant file to the project. via a tcl incantation.
        '''
        self.logger.debug('Adding constraint file: %s'%constfile)
        self.add_tcl_cmd('import_files -force -fileset constrs_1 %s'%constfile)

    def add_tcl_cmd(self,cmd):
        '''
        Add a command to the tcl command list with
        a trailing newline.
        '''
        self.logger.debug('Adding tcl command: %s'%cmd)
        self.tcl_cmd += cmd
        self.tcl_cmd += '\n'

    def compile(self):
        '''
        add the tcl commands for compiling the design, and then launch
        vivado in batch mode
        '''
        self.add_tcl_cmd('reset_run synth_1')
        self.add_tcl_cmd('launch_runs synth_1')
        self.add_tcl_cmd('wait_on_run synth_1')
        self.add_tcl_cmd('launch_runs impl_1 -to_step write_bitstream')
        self.add_tcl_cmd('wait_on_run impl_1')

        # write tcl command to file
        tcl_file = self.compile_dir+'/gogogo.tcl'
        helpers.write_file(tcl_file,self.tcl_cmd)
        #os.system('vivado -mode batch -source %s'%(tcl_file))
        os.system('vivado -jou %s/vivado.jou -log %s/vivado.log -mode batch -source %s'%(self.compile_dir,self.compile_dir,tcl_file))

    def get_tcl_const(self,const):
        '''
        Pass a single toolflow-standard PortConstraint,
        and get back a tcl command to add the constraint
        to a vivado project.
        '''
        user_const = ''
        if isinstance(const, PortConstraint):
            self.logger.debug('New constraint instance found')
            if const.loc is not None:
                if const.index is None:
                    #A constraint with no index, eg. sys_clk
                    user_const += self.format_const('package_pin', const.loc, const.portname)
                else:
                    #A constraint with an index, eg. gpio_0
                    for i in range(const.width):
                        user_const += self.format_const('package_pin', const.loc[i], const.portname, index=i)
            if const.iostd is not None:
                if const.index is None:
                    user_const += self.format_const('iostandard', const.iostd, const.portname)
                else:
                    for i in range(const.width):
                        user_const += self.format_const('iostandard', const.iostd[i], const.portname, index=i)
        return user_const

    def format_const(self, attribute, val, port, index=None):
        '''
        Generate a tcl syntax command from an attribute, value and port
        (with indexing if required)
        '''
        if index is None:
            return 'set_property %s %s [get_ports {%s}]\n'%(attribute,val,port)
        else:
            return 'set_property %s %s [get_ports {%s[%d]}]\n'%(attribute,val,port,index)
        
    
    def gen_constraint_file(self, constraints):
        """
        Pass this method a toolflow-standard list of constraints
        which have already had their physical parameters calculated
        and it will generate a contstraint file and add it to the
        current project.
        """
        constfile = '%s/user_const.xdc'%self.compile_dir
        user_const = ''
        for constraint in constraints:
            print 'parsing constraint', constraint
            user_const += self.get_tcl_const(constraint)
        print user_const
        helpers.write_file(constfile,user_const)
        print 'writen constraint file', constfile
        self.add_const_file(constfile)
        
