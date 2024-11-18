import sys, os
sys.path.append('jasper_library')

import logging
import yaml
import pickle
from toolflow import Toolflow
from toolflow import VivadoBackend
import dsp_blocks.dsp_block as dsp_block
import verilog
import castro

class DSPflow(Toolflow):
    """
    This class is used for generating a vivado project for DSP blocks.
    An IP core will be created from this project, which only contains all of the dsp blocks.
    """
    def __init__(self, compile_dir='/tmp', jobs = 8):
        self.jobs = jobs
        # setup the logger
        self.logger = logging.getLogger('jasper.dspflow')
        self.logger.info('Starting DSPflow!')
        # set the compile directory
        self.compile_dir = compile_dir.rstrip('/')
        # set the jasper.dsp file
        self.dsp_file = self.compile_dir + '/jasper.dsp'
        # set the model_info_file
        self.model_info_file = self.compile_dir + '/jasper.json'
        # set the vars
        self.cores = None
        self.topfile = None
        self.top = None
        self.dsp_objs = None
        # In dspflow, we don't have peripherals.
        # The reason we have this attribute is that the yellow_block class uses it.
        self.periph_objs = None
        self.dsp_modules = None
        self.constraints = None
        self.sources = []
        self.ips = []
        self.tcl_sources = []
        self.const_files = []
        # by default, we don't have user modules.
        self.user_modules = {}
        self.template_project = None
        self.top_module_name = self.compile_dir.split('/')[-1]
        
    
    def _parse_dsp_file(self):
        """
        Open the peripherals file and parse it's
        contents using the pyaml package.
        Write the resulting yellow_blocks
        and user_modules dictionaries to
        attributes
        """
        self.logger.info('Parsing DSP file.')
        if not os.path.exists(self.dsp_file):
            self.logger.error('dsp file doesn\'t exist!')
            raise Exception('dsp file doesn\'t exist!')
        with open(self.dsp_file, 'r') as fh:
            yaml_dict = yaml.load(fh, Loader=yaml.Loader)
        self.dsp_modules = yaml_dict['dsp_blocks']
        self.user_modules = yaml_dict['user_modules']

    def gen_dsp_objs(self):
        """
        Generate a list of dsp blocks from the current dsp file.

        Internally, calls:

        * ``_parse_dsp_file``: parses .dsp file
        * ``_extract_plat_info``: instantiates platform instance

        Then calls each yellow block's constructor.
        Runs a system-wide drc before returning.
        """
        self.logger.info('Starting to generate DSP Blocks.')
        self._parse_dsp_file()
        # as other methods use the peripherals attribute in yellow_block class,
        # we need to set it to dsp_modules
        self.peripherals = self.dsp_modules
        self._extract_plat_info()
        self.dsp_objs = []
        for pk in list(sorted(self.dsp_modules.keys())):
            # we have a special xps block here, whicn contains the platform info,
            # so we have to skip it.
            if self.dsp_modules[pk]['tag'].startswith('xps:'):
                continue
            self.logger.debug('Generating DSP Block: %s' % pk)
            self.dsp_objs.append(dsp_block.DSPBlock.make_block(
                self.dsp_modules[pk], self.plat, model_info_file=self.model_info_file))
        self._expand_children(self.dsp_objs)
        # some methods in yellow_block class use the peripherals attribute,
        # so we have to set it to dsp_modules
        self.periph_objs = self.dsp_objs
    
    def build_top(self):
        """
        This method is almost the same as the one in the Toolflow class.
        The difference is the two "try...except..." are removed.
        Not sure why the "try...except..." are used in the Toolflow class.
        """
        #self.topfile = self.compile_dir+'/top.v'
        self.topfile = self.compile_dir+'/%s_core.v'%(self.top_module_name)
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
            self.top = verilog.VerilogModule(name='%s_core'%(self.top_module_name), topfile=self.topfile)
        else:
            self.top = verilog.VerilogModule(name='%s_core'%(self.top_module_name))
        # the IP core used in the full proj has the port clk, 
        # but it's user_clk used in the dsp proj
        # TODO: we may need to move the following code to somewhere else
        self.top.assign_signal('user_clk', 'clk')
        self.top.add_port('clk', width=1, dir='in')
    
    def _instantiate_periphs(self):
        """
        Calls each dsp block's modify_top method against the class'
        top VerilogModule instance.
        We don't have axi modules in the dsp blocks, so the axi related code is removed here.
        """
        self.logger.info('top: %s' % self.topfile)
        for obj in self.periph_objs:
            self.logger.debug('modifying top for obj %s' % obj.name)
            # self.top.set_cur_blk(obj.fullname)
            if '/' in obj.fullpath:
                obj.fullpath = obj.fullpath.partition('/')[2]
            self.top.set_cur_blk('%s: %s'%(obj.tag.split(':')[1], obj.fullpath))
            obj.modify_top(self.top)
            self.sources += obj.sources
            self.ips += obj.ips
                    
    def regenerate_top(self):
        """
        Generate the verilog for the modified top
        module. This involves computing the wishbone
        interconnect / addressing and generating new
        code for yellow block instances.
        """
        # Write top module file
        #self.top.gen_module_file(filename=self.compile_dir+'/top.v')
        self.top.gen_module_file(filename=self.compile_dir+'/%s_core.v'%(self.top_module_name))
        # Write any submodule files required for the compile. This is probably
        # only the hierarchical WB arbiter, or nothing at all
        for key, val in self.top.generated_sub_modules.items():
            self.logger.info("Writing sub module file %s.v" % key)
            with open(self.compile_dir+'/%s.v'%key, 'w') as fh:
                fh.write(val)
                self.sources.append(fh.name)
        self.logger.info("Dumping pickle of top-level Verilog module")
        pickle.dump(self.top, open('%s/%s_core.pickle' %(self.compile_dir, self.top_module_name),'wb'))

    def dump_castro(self, filename):
        """
        Build a 'standard' Castro object, which is the
        interface between the toolflow and the backends.
        """
        """
        In DSPflow, we don't have constraints, so the constraints code is removed currently.
        """
        c = castro.Castro(self.top.name, self.sources, self.ips, template_project=self.template_project)
        c.synthesis = castro.Synthesis()
        c.synthesis.platform_name = self.plat.name
        c.synthesis.fpga_manufacturer = self.plat.manufacturer
        c.synthesis.fpga_model = self.plat.fpga
        c.synthesis.pin_map = self.plat._pins
        with open(filename, 'w') as fh:
            fh.write(yaml.dump(c))

class VivadoDSPBackend(VivadoBackend):
    """
    This class is used for generating a vivado project for DSP blocks.
    An IP core will be created from this project, which only contains all of the dsp blocks.
    """

    def initialize(self):
        """
        Simplify the initialize method.
        """
        # get the module name
        self.top_module_name = self.compile_dir.split('/')[-1]
        plat = self.plat

        if plat.manufacturer.lower() != self.manufacturer.lower():
            self.logger.error('Trying to compile a %s FPGA using %s %s' % (
                plat.manufacturer, self.manufacturer, self.name))

        self.add_tcl_cmd('puts "Starting tcl script"', stage='init')
        # Create Vivado Project in project mode only
        if plat.project_mode:
            # Create a project or use a template if provided
            self.add_tcl_cmd('cd %s' % self.compile_dir, stage='init')
            if self.template_project is None:
                self.add_tcl_cmd('create_project -f %s %s -part %s' % (
                    self.project_name, self.project_name,
                    plat.fpga), stage='init')
            else:
                self.add_tcl_cmd('exec cp %s .' % (self.template_project), stage='init')
                template_basename = os.path.basename(self.template_project)
                if template_basename.endswith('.zip'):
                    self.add_tcl_cmd('exec unzip %s' % template_basename, stage='init')
                    self.add_tcl_cmd('cd myproj', stage='init')
                    self.add_tcl_cmd('open_project myproj', stage='init')
            if hasattr(plat, 'board'):
                self.add_tcl_cmd('set_property board_part %s [current_project]' % plat.board)
        # Create the part in non-project mode (project runs in memory only)
        else:
            if self.template_project is not None:
                self.logger.error("Can't build from a template project in non-project mode!")
                raise RuntimeError
            self.add_tcl_cmd('file mkdir %s/%s' % (self.compile_dir,
                                                   self.project_name))
            self.add_tcl_cmd('set_part %s' % plat.fpga)
        # Set the project to default to vhdl    
        self.add_tcl_cmd('set_property target_language Verilog [current_project]', stage='init')

    def add_compile_cmds(self, cores=8, plat=None, synth_strat=None, impl_strat=None, threads='multi'):
        """
        Add the tcl commands for compiling the design, and then launch vivado in batch mode.
        As we only need to generate an IP core, we overwrite this method.
        """
        tcl = self.add_tcl_cmd
        # Project Mode is enabled
        if plat.project_mode:
            # For generating an IP core, we only need to run synthesis
            # Pre-Synthesis Commands
            self.add_tcl_cmd('set_property top %s [current_fileset]'%(self.top_module_name), stage='pre_synth')
            self.add_tcl_cmd('update_compile_order -fileset sources_1', stage='pre_synth')
            self.add_tcl_cmd('ipx::package_project -root_dir %s/%s/%s.srcs -vendor user.org -library user -taxonomy /UserIP'%(self.compile_dir, self.project_name, self.project_name), stage='pre_synth')
            self.add_tcl_cmd('set_property vendor User_Company [ipx::current_core]', stage='pre_synth') 
            self.add_tcl_cmd('set_property library SysGen [ipx::current_core]', stage='pre_synth') 
            self.add_tcl_cmd('set_property name %s [ipx::current_core]'%(self.top_module_name), stage='pre_synth') 
            self.add_tcl_cmd('set_property display_name %s [ipx::current_core]'%(self.top_module_name), stage='pre_synth') 
            self.add_tcl_cmd('set_property description %s [ipx::current_core]'%(self.top_module_name), stage='pre_synth') 
            self.add_tcl_cmd('set_property core_revision 2 [ipx::current_core]', stage='pre_synth')
            self.add_tcl_cmd('ipx::create_xgui_files [ipx::current_core]', stage='pre_synth')
            self.add_tcl_cmd('ipx::update_checksums [ipx::current_core]', stage='pre_synth')
            self.add_tcl_cmd('ipx::check_integrity [ipx::current_core]', stage='pre_synth') 
            self.add_tcl_cmd('ipx::save_core [ipx::current_core]', stage='pre_synth')
            self.add_tcl_cmd('set_property  ip_repo_paths %s/dspproj/dspproj.srcs [current_project]'%(self.compile_dir), stage='pre_synth')
            self.add_tcl_cmd('update_ip_catalog', stage='pre_synth')
        else:
            pass