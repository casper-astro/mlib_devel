import os
class SimBackend(object):
    """
    A simulation backend object generates the scripts for simlation based on different simulaters.

    There are sever methods are required at least:
    1. gen_co_file: 
        For each VHDL/Verilog module, a specific compile order might be needed.
    2. gen_sim_script:
        Generate a script for running simulation in the background.
    3. run_sim:
        Call the script to run simulation.
    """
    def __init__(self, simdir, simtop, simlen, simco, simoutput):
        self.simdir = simdir
        self.simtop = simtop
        self.simlen = simlen
        self.simoutput = simoutput
        self.simco = simco
        self.simtop_name = self.simtop.split('.')[0]
        # dsp top doesn't have '_tb'
        self.dsptop = self.simtop.split('_tb.v')[0] + '.v'

    def add_compile_order(self, co, type):
        """
        'co' is the compile order for a lib, which is a dict.
        It should contains two keys at least:
            * 'lib'(str): the lib name
            * 'modules'(list): the fullpath of the modules in this lib
        'type' is the file type, which should be `vhdl` or 'verilog'
        """
        if type not in self.simco:
            raise KeyError(f"File type '{type}' not supported.")
        self.simco[type].append(co)
    
    def gen_co_file(self):
        """
        For each simulator, compile order files for VHDL and Verilog modules are necessary.
        This method generate the compile order files.
        """
        pass

    def gen_sim_script(self):
        """
        For each simulator, the script should be different for the following tasks:
        1. compile the VHDL/Verilog moduels;
        2. 'link' the modlues;
        3. call the simulatoer to run simulation
        This method generates the scripts for these tasks.
        Note: The output file has to be a VCD file.
        """
        pass

    def run_sim(self):
        """
        Call the script to run simulation.
        """
        pass

class VivadoSimulator(SimBackend):
    """
    Use Vivado Simulator as the backend simulator.
    """
    def __init__(self, simdir, simtop, simlen, simco, simoutput):
        super().__init__(simdir, simtop, simlen, simco, simoutput)
        self.vhdl_cof = simdir + '/' + 'vhdl.prj'
        self.verilog_cof = simdir + '/' + 'vlog.prj'
        self.sim_script = simdir + '/' + 'caspersim.sh'
        self.cmdtcl = simdir + '/' + 'caspersim.tcl'
        # copy glbl.v to the simdir, which is necessary
        XILINX_PATH = os.getenv('XILINX_PATH')
        os.system(f'cp {XILINX_PATH}/data/verilog/src/glbl.v {self.simdir}')

    def gen_co_file(self):
        # generate vhdl compile order first
        with open(self.vhdl_cof, 'w') as f:
            for co in self.simco['vhdl']:
                f.write(f"vhdl {co['lib']} \\\n")
                for m in co['modules']:
                    f.write(f"     \"{m}\" \\\n")
                f.write('\n')
            f.write('\n')
            f.write('nosort')
            f.write('\n')
        # generate verilog compile order
        with open(self.verilog_cof, 'w') as f:
            for co in self.simco['verilog']:
                f.write(f"verilog {co['lib']} \\\n")
                for m in co['modules']:
                    f.write(f"     \"{m}\" \\\n")
                f.write('\n')
            f.write('\n')
            # TODO: this is not a good way to get the path of dsptop...
            dspdir = self.simdir.split('/simulation')[0]
            f.write(f'verilog xil_defaultlib \"{dspdir}/{self.dsptop}\"\n\n')
            # added the sim top module to the xil_defaultlib
            f.write(f'verilog xil_defaultlib \"{self.simdir}/{self.simtop}\"\n\n')
            f.write(f'verilog xil_defaultlib \"glbl.v\"\n\n')
            f.write('nosort')
            f.write('\n')
        
    def gen_sim_scripts(self):
        # generate the simulation scripts based on the Vivado Simulator
        scripts = []
        scripts.append('#!/bin/bash -f\n\n')
        scripts.append('set -Eeuo pipefail\n\n')
        scripts.append('# set xvlog and xvhdl options\n')
        scripts.append('xvlog_opts=\"--incr --relax \"\n')
        scripts.append('xvhdl_opts=\"--incr --relax \"\n\n')
        scripts.append('# Compile \n')
        scripts.append(f"xvlog $xvlog_opts -prj {self.verilog_cof} 2>&1 | tee compile_verilog.log\n")
        scripts.append(f"xvhdl $xvhdl_opts -prj {self.vhdl_cof} 2>&1 | tee compile_vhdl.log\n\n")
        scripts.append('# Elaborate\n')
        scripts.append('xelab --incr --debug typical --relax --mt auto ')
        # get the lib names here
        libs = []
        for k in self.simco.keys():
            for co in self.simco[k]:
                if co['lib'] not in libs:
                    libs.append(co['lib'])
        # write the lib names into scripts
        for lib in libs:
            scripts.append(f'-L {lib} ')
        # These following three libs seem to be the Xilinx libs
        # They may not be necessary?
        scripts.append('-L unisims_ver -L unimacro_ver -L secureip -L xpm ')
        scripts.append(f'--snapshot {self.simtop_name} ')
        scripts.append(f'xil_defaultlib.{self.simtop_name} ')
        scripts.append('xil_defaultlib.glbl -log elaborate.log\n\n')
        scripts.append('# Sim\n')
        scripts.append(f'xsim {self.simtop_name} -key {{Behavioral:sim_1:Functional:{self.simtop}}} -tclbatch {self.cmdtcl} -log simulate.log\n\n')
        with open(self.sim_script, 'w') as f:
            for s in scripts:
                f.write(s)
        # generate cmd.tcl for getting the vcd file
        tcls = []
        tcls.append(f'open_vcd {self.simoutput}\n')
        tcls.append('log_vcd *\n')
        tcls.append(f'run {float(self.simlen)} ns\n')
        tcls.append('close_vcd\n')
        tcls.append('quit\n')
        with open(self.cmdtcl, 'w') as f:
            for t in tcls:
                f.write(t)
    
    def run_sim(self):
        # go to the simdir, so all of the log files will be generate there
        os.chdir(self.simdir)
        return os.system(f'sh {self.sim_script} > {self.simdir}/caspersim.log')