from typing import Iterable, List, Optional
import sys, os
import glob
sys.path.append(os.getenv('MLIB_DEVEL_PATH') + '/' + 'jasper_library')

import logging
import yaml
import pickle
import re
from toolflow import Toolflow
from toolflow import VivadoBackend
from toolflow import QuartusBackend
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
        print('BUILDING TOP IN DSP_FLOW')
        """
        This method is almost the same as the one in the Toolflow class.
        The difference is the two "try...except..." are removed.
        Not sure why the "try...except..." are used in the Toolflow class.
        """
        #self.topfile = self.compile_dir+'/top.v'

        append_top = 'ip'
        self.topfile = self.compile_dir+'/%s_%s.v'%(self.top_module_name, append_top)
        
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
            self.top = verilog.VerilogModule(name='%s_%s'%(self.top_module_name, append_top), topfile=self.topfile)
        else:
            self.top = verilog.VerilogModule(name='%s_%s'%(self.top_module_name, append_top))
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
            for source in obj.sources:
                if os.path.isabs(source):
                    resolved = sorted(glob.glob(source))
                    self.sources += resolved or [source]
                else:
                    rooted = os.path.join(os.getenv('HDL_ROOT'), source)
                    resolved = sorted(glob.glob(rooted))
                    self.sources += resolved or [rooted]
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
        append_top = 'ip'

        self.top.gen_module_file(filename=self.compile_dir+'/%s_%s.v'%(self.top_module_name, append_top))
        # Write any submodule files required for the compile. This is probably
        # only the hierarchical WB arbiter, or nothing at all
        for key, val in self.top.generated_sub_modules.items():
            self.logger.info("Writing sub module file %s.v" % key)
            with open(self.compile_dir+'/%s.v'%key, 'w') as fh:
                fh.write(val)
                self.sources.append(fh.name)
        self.logger.info("Dumping pickle of top-level Verilog module")
        pickle.dump(self.top, open('%s/%s_%s.pickle' %(self.compile_dir, self.top_module_name, append_top),'wb'))

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
        print('INITIALIZING VIVADO DSP BACKEND')
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
        # self.add_tcl_cmd('set_property target_language Verilog [current_project]', stage='init')
        self.add_tcl_cmd('set_property target_language VHDL [current_project]', stage='init')

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
            # we need to move the IP core generation commands from pre_synth to synth
            self.add_tcl_cmd('ipx::package_project -root_dir %s/%s/%s.srcs -vendor user.org -library user -taxonomy /UserIP'%(self.compile_dir, self.project_name, self.project_name), stage='synth')
            self.add_tcl_cmd('set_property vendor User_Company [ipx::current_core]', stage='synth') 
            self.add_tcl_cmd('set_property library SysGen [ipx::current_core]', stage='synth') 
            self.add_tcl_cmd('set_property name %s [ipx::current_core]'%(self.top_module_name), stage='synth') 
            self.add_tcl_cmd('set_property display_name %s [ipx::current_core]'%(self.top_module_name), stage='synth') 
            self.add_tcl_cmd('set_property description %s [ipx::current_core]'%(self.top_module_name), stage='synth') 
            self.add_tcl_cmd('set_property core_revision 2 [ipx::current_core]', stage='synth')
            self.add_tcl_cmd('ipx::create_xgui_files [ipx::current_core]', stage='synth')
            self.add_tcl_cmd('ipx::update_checksums [ipx::current_core]', stage='synth')
            self.add_tcl_cmd('ipx::check_integrity [ipx::current_core]', stage='synth') 
            self.add_tcl_cmd('ipx::save_core [ipx::current_core]', stage='synth')
            self.add_tcl_cmd('set_property  ip_repo_paths %s/dspproj/dspproj.srcs [current_project]'%(self.compile_dir), stage='synth')
            self.add_tcl_cmd('update_ip_catalog', stage='synth')
            # it looks like we have to synthesize the design before packaging it,
            # or we will have lib issues.
            # self.add_tcl_cmd('launch_runs synth_1 -jobs %d' % cores, stage='synth')
            self.gen_dspblock_tcl_cmds()
        else:
            pass
    
    def gen_dspblock_tcl_cmds(self):
        """
        Compose a list of tcl commands from each dsp block.
        To be added to the final tcl script.
        Actually, the code is the same as gen_yellowblock_tcl_cmds.
        The only difference is that the log info is different.
        """
        self.logger.info('Extracting dsp block tcl commands from peripherals')
        for obj in self.periph_objs:
            c = obj.gen_tcl_cmds()
            for key, val in c.items():
                if val is not None:
                    for v in val:
                        self.add_tcl_cmd(v, stage=key)


class QuartusDSPBackend(QuartusBackend):
    """
    This class is used for generating a quartus project for DSP blocks.
    An IP core will be created from this project, which only contains all of the dsp blocks.
    """

    def _iter_stage_cmds(self, stages=None):
        if stages is None:
            stages = ("pre_synth", "synth")
            #stages = ("init", "pre_synth", "synth", "post_synth", "promgen")

        print('STAGING COMMANDS: ' + str(self.tcl_cmds))

        cmds = []
        for stage in stages:
            stage_cmds = self.tcl_cmds.get(stage, [])
            if not stage_cmds:
                continue

            if isinstance(stage_cmds, str):
                cmds.extend(stage_cmds.splitlines())
            else:
                cmds.extend(stage_cmds)

        return cmds

    
    def initialize(self):
        """
        Initialize Quartus project using commands equivalent to Vivado-based DSPflow.
        """
        # Set module and project name
        self.top_module_name = self.compile_dir.split('/')[-1]
        if not getattr(self, 'project_name', None):
            self.project_name = self.top_module_name
        plat = self.plat

        if plat.manufacturer.lower() != self.manufacturer.lower():
            self.logger.error('Trying to compile a %s FPGA using %s %s' % (
                plat.manufacturer, self.manufacturer, self.name))

        self.logger.debug(f'Initializing Quartus project: {self.project_name}')
        project_dir = os.path.join(self.compile_dir, self.project_name)

        # Ensure directory exists
        os.makedirs(project_dir, exist_ok=True)

        # Begin Tcl commands for Quartus
        self.add_tcl_cmd('puts "Starting Quartus Tcl script"', stage='init')
        self.add_tcl_cmd(f'cd {project_dir}', stage='init')

        # Import the flow package
        self.add_tcl_cmd('load_package flow', stage='init')


        # Create a new Quartus project
        self.add_tcl_cmd(f'project_new {self.project_name} -overwrite', stage='init')

        # Set device and family
        self.add_tcl_cmd(f'set_global_assignment -name FAMILY "{plat.family}"', stage='init')
        self.add_tcl_cmd(f'set_global_assignment -name DEVICE {plat.fpga}', stage='init')

        # Set top-level design unit (important!)
        #self.add_tcl_cmd(f'set_global_assignment -name TOP_LEVEL_ENTITY {self.top_module_name}_core', stage='init')
        self.add_tcl_cmd(f'set_global_assignment -name TOP_LEVEL_ENTITY {self.top_module_name}_ip', stage='init')

        # Force VHDL mode, if needed
        self.add_tcl_cmd('set_global_assignment -name VHDL_FILE top.vhd', stage='init')  # dummy, overridden later
        self.add_tcl_cmd('set_global_assignment -name VHDL_INPUT_VERSION VHDL_2008', stage='init')

        # Track final binary locations
        self.bitstream_loc = os.path.join(self.output_dir, f'{self.top_module_name}.sof')
        self.binary_loc = os.path.join(self.output_dir, f'{self.top_module_name}.rbf')
        self.logger.debug(f'Set output bitstream to {self.bitstream_loc}')
        self.logger.debug(f'Set output rbf to {self.binary_loc}')


    def _add_dsp_compile_cmds(self, cores=8, plat=None, synth_strat=None, impl_strat=None):
        """
        Add Quartus-compatible Tcl commands for validating/synthesizing the DSP-only wrapper.

        Unlike the top-level Quartus flow, the DSP project is an internal IP-style wrapper
        with many interface ports that are not intended to be placed onto package pins.
        Running fit/asm on this wrapper causes Quartus to treat those ports as real board
        I/O and can easily exceed the device I/O count. For DSPflow we therefore stop at
        analysis/elaboration and synthesis (quartus_map) and only emit the HDL-source
        manifest that the top-level build will later source.
        """
        tcl = self.add_tcl_cmd
        proj_name = self.project_name
       
        if plat.project_mode:
            # Use the synthesis strategy if provided
            if synth_strat:
                tcl(f'set_global_assignment -name SYNTHESIS_STRATEGY "{synth_strat}"', stage='synth')

            # Optional: Set parallel jobs
            tcl(f'set_global_assignment -name NUM_PARALLEL_PROCESSORS {cores}', stage='synth')

            # Collect per-block Tcl first.
            self.gen_dspblock_tcl_cmds()
            self._remove_library_managed_source_duplicates()

            # Persist only the source-related assignments for later reuse by exec_flow.
            self.write_dsp_source_manifest()

            # Persist assignments, then run synthesis in the same Quartus Tcl session.
            # Forking a fresh quartus_map process can lose the in-session project state and
            # fall back to the revision name as the top-level entity.
            tcl('export_assignments', stage='synth')
            tcl('execute_module -tool map', stage='synth')

            # Optional: output QXP file (Quartus IP packaging)
            # tcl(f'exec quartus_sh --flow compile {proj_name}', stage='synth')
            # tcl(f'exec quartus_sh --archive {proj_name}.qxp', stage='synth')

            # Optional: Update IP catalog (Qsys), if needed
            # tcl(f'exec qsys-script --generate --project={proj_name}', stage='synth')

            self.logger.debug("Added Quartus DSP synthesis commands (no fit/asm)")
        else:
            self.logger.warning("Non-project mode not supported for Quartus DSPflow yet.")

    def add_compile_cmds_pr(self, cores=8, plat=None, synth_strat=None, impl_strat=None):
        """
        QuartusBackend.compile() calls add_compile_cmds_pr(), so DSPflow must override that
        hook rather than the generic add_compile_cmds() helper used by other backends.
        """
        self._add_dsp_compile_cmds(
            cores=cores,
            plat=plat,
            synth_strat=synth_strat,
            impl_strat=impl_strat,
        )

    def _remove_library_managed_source_duplicates(self):
        """
        Remove raw work-library assignments for files that are also added with
        an explicit Quartus library via a DSP block's gen_tcl_cmds().

        Without this, files like casper_misc_lib.pulse_ext can be pulled in two
        ways:
          1. raw from Castro/import_from_castro -> compiled into work
          2. library-qualified from block Tcl   -> compiled into casper_misc_lib

        Quartus then sees duplicate design units with the same entity name.
        """
        source_cmd_re = re.compile(
            r'^\s*set_global_assignment\s+-name\s+'
            r'(?:VHDL_FILE|VERILOG_FILE|SYSTEMVERILOG_FILE)\s+"?([^"\n]+)"?',
            re.IGNORECASE,
        )

        library_managed = set()
        for stage_cmds in self.tcl_cmds.values():
            if isinstance(stage_cmds, str):
                stage_cmds = stage_cmds.splitlines()
            for cmd in stage_cmds or []:
                if not isinstance(cmd, str) or ' -library ' not in cmd:
                    continue
                match = source_cmd_re.match(cmd.strip())
                if match:
                    library_managed.add(os.path.abspath(match.group(1)))

        if not library_managed:
            return

        pre_synth_lines = self.tcl_cmds.get('pre_synth', '').splitlines()
        filtered_lines = []
        removed = set()

        for line in pre_synth_lines:
            match = source_cmd_re.match(line.strip()) if isinstance(line, str) else None
            source_path = os.path.abspath(match.group(1)) if match else None
            if source_path and source_path in library_managed and ' -library ' not in line:
                removed.add(source_path)
                continue
            filtered_lines.append(line)

        if removed:
            for source_path in sorted(removed):
                self.logger.info(
                    'Removing raw Quartus source assignment superseded by library-managed Tcl: %s',
                    source_path,
                )
            self.tcl_cmds['pre_synth'] = '\n'.join(filtered_lines)
            if filtered_lines:
                self.tcl_cmds['pre_synth'] += '\n'

    def add_compile_cmds(self, cores=8, plat=None, synth_strat=None, impl_strat=None, threads='multi'):
        """
        Keep the generic hook aligned with the project-mode hook for any callers that
        invoke add_compile_cmds() directly.
        """
        self._add_dsp_compile_cmds(
            cores=cores,
            plat=plat,
            synth_strat=synth_strat,
            impl_strat=impl_strat,
        )

    
    def gen_dspblock_tcl_cmds(self):
        """
        Compose a list of tcl commands from each dsp block.
        To be added to the final tcl script.
        Actually, the code is the same as gen_yellowblock_tcl_cmds.
        The only difference is that the log info is different.
        """
        self.logger.info('Extracting dsp block tcl commands from peripherals')

        # Some simple DSP blocks contribute HDL only via obj.sources and do not
        # emit any explicit Tcl. Add those source files here so the DSP wrapper
        # project can compile even if castro.yml omitted them.
        seen_sources = set()
        for obj in self.periph_objs:
            for source in getattr(obj, 'sources', []):
                if source in seen_sources:
                    continue
                seen_sources.add(source)
                self.add_source(source, self.plat)

            c = obj.gen_tcl_cmds()
            if not c:
                continue

            for stage, val in c.items():
                if val is None:
                    continue

                # Normalize to list of lines
                if isinstance(val, str):
                    cmds = val.splitlines()
                else:
                    cmds = val

                for cmd in cmds:
                    if not isinstance(cmd, str):
                        continue

                    stripped = cmd.strip()
                    if not stripped:
                        continue

                    self.add_tcl_cmd(stripped, stage=stage)



    def write_dsp_source_manifest(self, manifest_path: Optional[str] = None, stages: Optional[Iterable[str]] = None) -> str:
        """
        Write a Quartus Tcl fragment containing only HDL source assignments
        discovered during DSP IP generation.

        This is intended to be sourced later by the top-level exec_flow build.

        Parameters
        ----------
        manifest_path:
            Output path for the generated Tcl manifest.
            Defaults to <compile_dir>/dspproj_sources.tcl
        stages:
            Tcl stages to scan. Defaults to init/pre_synth/synth/post_synth/promgen.

        Returns
        -------
        str
            Absolute path to the generated manifest file.
        """
        print('Writing dsp source manifest')
        if manifest_path is None:
            manifest_path = os.path.join(self.compile_dir, "dspproj_sources.tcl")

        os.makedirs(os.path.dirname(os.path.abspath(manifest_path)), exist_ok=True)
        print(f'Manifest path is {os.path.dirname(os.path.abspath(manifest_path))}')
        # Match only source-file assignments we want to replay later.
        source_cmd_re = re.compile(
            r'^\s*set_global_assignment\s+-name\s+'
            r'(VHDL_FILE|VERILOG_FILE|SYSTEMVERILOG_FILE)\b',
            re.IGNORECASE,
        )

        # You may optionally exclude obvious non-IP-generated files here.
        # For now we keep all source assignments emitted by the DSP flow.
        raw_cmds = self._iter_stage_cmds(stages=stages)

        filtered_cmds: List[str] = []
        seen = set()

        for cmd in raw_cmds:
            if not isinstance(cmd, str):
                continue

            stripped = cmd.strip()
            if not stripped:
                continue

            if not source_cmd_re.match(stripped):
                continue

            # Normalize trailing newline handling and deduplicate.
            normalized = stripped
            if normalized not in seen:
                seen.add(normalized)
                filtered_cmds.append(normalized)

        with open(manifest_path, "w", encoding="utf-8") as fh:
            fh.write('# Auto-generated by QuartusDSPBackend.write_dsp_source_manifest()\n')
            fh.write('# Contains only HDL source assignments required by the DSP IP.\n\n')
            for cmd in filtered_cmds:
                fh.write(cmd + "\n")

        self.logger.info("Wrote DSP source manifest: %s", manifest_path)
        self.logger.info("Manifest contains %d source assignment(s).", len(filtered_cmds))

        return os.path.abspath(manifest_path)
