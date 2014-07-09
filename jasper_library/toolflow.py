import logging
import os
import platform
import yellow_blocks.yellow_block as yellow_block
import verilog
from constraints import PortConstraint
import helpers

class Toolflow(object):
    def __init__(self, frontend='simulink', backend='vivado', compile_dir='/tmp'):
        '''
        Initialize the toolflow.
        
        Args:
        frontend: Name of the toolflow frontend to use. Currently
                  only 'simulink' is supported
        backend : Name of the toolflow backend to use. Currently
                  only 'vivado' is supported
        compile_dir : compile directory
        '''
        # Set up a logger (the logger named 'jasper' should already
        # have been configured beforehand
        self.logger = logging.getLogger('jasper.toolflow')

        self.logger.info('Starting Toolflow!')
        self.logger.info('Frontend is %s'%frontend)
        self.logger.info('Backend is %s'%backend)

        self.logger.info("Setting compile directory: %s"%compile_dir)
        os.system('mkdir -p %s'%compile_dir)
        self.compile_dir = compile_dir

        if frontend == 'simulink':
            self.frontend = SimulinkFrontend(compile_dir=self.compile_dir)
        else:
            self.logger.error("Unsupported toolflow frontent: %s"%frontend)
            raise Exception("Unsupported toolflow frontend: %s"%frontend)

        if backend == 'vivado':
            self.backend = VivadoBackend(compile_dir=self.compile_dir)
        else:
            self.logger.error("Unsupported toolflow backent: %s"%backend)
            raise Exception("Unsupported toolflow backend: %s"%backend)

    def check_attr_exists(self, thing, generator):
        try:
            if self.__getattribute__(thing) == None:
                self.logger.error("%s is not defined. Have you run %s yet?"%(thing,generator))
                raise AttributeError("%s is not defined. Have you run %s yet?"%(thing,generator))
        except AttributeError:
            self.logger.error("%s is not defined. Have you run %s yet?"%(thing,generator))
            raise AttributeError("%s is not defined. Have you run %s yet?"%(thing,generator))

    def generate_hdl(self):
        self.logger.info('setting user ip name')
        self.user_ip_name = (self.frontend.module)
        self.logger.info('instantiating user peripherals')
        self.instantiate_periphs()
        self.logger.info('instantiating user_ip')
        self.instantiate_user_ip()
        self.logger.info('regenerating top')
        self.regenerate_top()

    def parse_periph_file(self):
        self.check_attr_exists('periph_file', 'gen_periph_file()')

        self.logger.info("Parsing peripherals file: %s"%self.periph_file)
        fh = open(self.periph_file,'r')
        self.peripherals = {}
        self.user_ip_ports = {}
        self.user_sources  = {} 
        self.user_ip_parameters = {}
        while(True):
            # Catch end of file and stop, otherwise strip newline characters and parse
            line = fh.readline()
            if len(line)==0:
                break
            elif line == '\n':
                continue
            elif line.startswith('BEGIN'):
                self.logger.debug("Found start of new entry: %s"%line)
                this_entry = {}
            elif line.startswith('ENDBLOCK'):
                self.logger.debug("Found end of entry: %s"%line)
                self.peripherals[this_entry['name']]= this_entry
            elif line.startswith('ENDPORT'):
                self.logger.debug("Found port: %s"%line)
                self.user_ip_ports[this_entry['name']]= this_entry
            elif line.startswith('ENDSOURCEFILE'):
                self.logger.debug("Found sourcefile entry: %s"%line)
                self.user_sources[this_entry['name']]= this_entry
            elif line.startswith('ENDPARAMETER'):
                self.logger.debug("Found end of parameter: %s"%line)
                self.user_ip_parameters[this_entry['name']]= this_entry
            else:
                param,val = line.rstrip('\n').split('=')
                self.logger.debug("Added peripheral entry %s with value %s"%(param.lower(),val))
                this_entry[param.lower()] = val
        fh.close()

    def extract_plat_info(self):
        self.check_attr_exists('peripherals', 'parse_periph_file()')
        for key in self.peripherals.keys():
            if self.peripherals[key]['tag'] == 'xps:xsg':
                self.plat = platform.Platform.get_loader(self.peripherals[key]['hw_sys'])
                self.backend.set_plat(self.plat)
                self.clk_src = self.peripherals[key]['clk_src']
                self.clk_rate = float(self.peripherals[key]['clk_rate']) #in MHz
                return
        raise Exception("self.peripherals does not contain anything tagged xps:xsg")

    def drc(self):
        self.get_provisions()
        self.check_attr_exists('periph_objs', 'gen_periph_objs()')
        self.check_attr_exists('provisions', 'gen_provisions()')
        ## check drcs for each block
        #for obj in self.periph_objs:
        #    obj.drc(self.plat)

        # check all requirements are provided
        for obj in self.periph_objs:
            for req in obj.requires:
                if req not in self.provisions:
                    raise Exception("DRC FAIL! %s (required by %s) not " \
                                    "provided by platform or any peripheral"%(req,obj.name))

        # check for overallocation of resources
        prov = self.provisions[:]
        for obj in self.periph_objs:
            for req in obj.exc_requires:
                try:
                    prov.remove(req)
                except ValueError:
                    raise Exception("DRC FAIL! %s requires %s, but it has \
                                     already been used by another block."%(obj.name,req))


    def get_provisions(self):
        self.check_attr_exists('periph_objs', 'gen_periph_objs()')
        self.provisions = []
        for obj in self.periph_objs:
            self.provisions += obj.provides
        self.provisions += self.plat.provides

    def copy_top(self):
        basetopfile = os.getenv('HDL_ROOT') + '/%s/top.v'%self.plat.name
        self.topfile = self.compile_dir+'/top.v'
        os.system('cp %s %s'%(basetopfile,self.topfile))


    def gen_periph_objs(self):
        self.parse_periph_file()
        self.extract_plat_info()
        self.periph_objs = []
        for pk in self.peripherals.keys():
            self.logger.debug('Generating Yellow Block: %s'%pk)
            self.periph_objs.append(yellow_block.YellowBlock.make_block(self.peripherals[pk], self.plat))
        self.drc()

    def instantiate_periphs(self):
        self.check_attr_exists('periph_objs', 'gen_periph_objs()')
        #self.topfile = self.backend.proj_root_dir + '/' + self.backend.top_module
        self.top = verilog.VerilogModule(name='top',topfile=self.topfile)
        print 'top:',self.topfile
        for obj in self.periph_objs:
            self.logger.debug('modifying top for obj %s'%obj.name)
            obj.modify_top(self.top)
    
    def instantiate_user_ip(self):
        inst = verilog.VerilogInstance(entity=self.user_ip_name,name='user_ip_inst')
        for port in self.user_ip_ports:
            if port == 'clk':
                inst.add_port(name=port,signal='user_clk')
            else:
                inst.add_port(name=port,signal=port)
        for param in self.user_ip_parameters:
            inst.add_param(name=param['name'],value=param['value'])
        self.top.add_instance(inst)

    def frontend_compile(self,update=True, skip=False):
        module, source = self.frontend.compile_user_ip(update=update, skip=skip)
        self.backend.add_source(source)

    def regenerate_top(self):
        self.top.wb_compute()
        self.top.gen_module_file()

    def add_sources(self):
        existing_sources = []
        for obj in self.periph_objs:
            for source in obj.sources:
                if source not in existing_sources:
                    existing_sources.append(source)
                    self.backend.add_source(source)
            

    def generate_consts(self):
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
    def __init__(self, compile_dir='/tmp'):
        self.logger = logging.getLogger('jasper.toolflow.frontend')
        self.compile_dir = compile_dir
    def gen_periph_file(self,skip=False):
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
    def configure(self,modelpath):
        if not os.path.exists(modelpath):
            logger.error('Model path %s does not exist!'%modelpath)
            raise Exception('Model path %s does not exist!'%modelpath)
        self.modelpath = modelpath
        self.modelname = modelpath.split('/')[-1][:-4] #strip off extension
        self.module = self.modelname
    def gen_periph_file(self,skip=False):
        '''
        generate the peripheral file. I.e., the list of yellow blocks
        and their parameters. Return the full path to this file.
        Use skip to just return the path without regenerating. This
        assumes the file has been gerated on a previous toolflow run.
        '''
        fname = self.compile_dir.rstrip('/') + '/' \
                + self.modelpath.split('/')[-1].rstrip('.mdl') + '.per'
        self.logger.info('Generating yellow block description file : %s'%fname)
        if not skip:
            # The command to start matlab with appropriate libraries
            matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
            # The matlab script responsible for generating the peripheral file
            script = 'gen_block_file'
            # The matlab syntax to call this script with appropriate args
            ml_cmd = "%s('%s','%s');"%(script, fname, self.modelpath)
            # Complete command to run on terminal
            term_cmd = matlab_start_cmd + ' -nodisplay -nosplash -nosplash -r "%s"'%ml_cmd
            self.logger.info('Running terminal command: %s'%term_cmd)
            os.system(term_cmd)
        # return the full path and name of the peripherals file
        return fname

    def compile_user_ip(self,update=False, skip=False):
        if not skip:
            self.logger.info('Compiling user IP to module: %s'%self.modelname)
            # The command to start matlab with appropriate libraries
            matlab_start_cmd = os.getenv('MLIB_DEVEL_PATH') + '/startsg'
            # The matlab syntax to start a compile with appropriate args
            ml_cmd = "start_sysgen_compile('%s','%s',%d);"%(self.modelpath,self.compile_dir,int(update))
            term_cmd = matlab_start_cmd + ' -nosplash -r "%s"'%ml_cmd
            self.logger.info('Running terminal command: %s'%term_cmd)
            os.system(term_cmd)
            # return the name of the top module of the user ip
        ip_loc = self.compile_dir + '/sysgen/hdl_netlist/%s.srcs/sources_1/imports/sysgen'%self.modelname
        return self.modelname, ip_loc


class VivadoBackend(ToolflowBackend):
    def initialize(self,plat):
        self.name = 'vivado'
        self.manufacturer = 'xilinx'
        self.tcl_cmd = ''
        if plat.manufacturer != self.manufacturer:
            logger.error('Trying to compile a %s FPGA using %s %s'
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
        Add a sourcefile to the project.
        '''
        self.logger.debug('Adding source file: %s'%source)
        self.add_tcl_cmd('import_files -force %s'%(source))

    def add_const_file(self, constfile):
        '''
        Add a constrant file to the project.
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
        Pass a single toolflow-standard constraint,
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
        
    
    def gen_constraint_file(self, constraints, platform):
        """
        Pass this method a toolflow-standard list of constraints
        and a platform (which allows mapping net names to pins),
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
        
