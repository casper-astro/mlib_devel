'''
Lots of code in this file could be shared between methods
and the VerilogInstance/Module classes. Maybe distill
at some point.
'''


import os
import re
from math import ceil, floor
import logging

class Port(object):
    """
    A simple class to hold port attributes.
    """
    def __init__(self, name, signal='', extdir=None, internal=True, width=0):
        name   = name.rstrip(' ')
        signal = signal.rstrip(' ')
        self.name = name
        self.signal = signal or name #default to signal name same as port
        self.extdir = extdir
        self.internal = internal and not extdir
        self.width = width


class VerilogInstance(object):
    def __init__(self, entity='', name='', comment=None):
        """
        Construct an instance of entity 'entity'
        and instance name 'name'.
        Sourcefiles, if specified, is a list of sourcefiles (or directories)
        required to build this instance.
        You can add an optional comment string, which will appear in
        the resulting verilog file.
        """ 
        if len(entity) != 0:
            self.entity = entity
        else:
            raise ValueError("'entity' must be a string of non-zero length")
        if len(name) != 0:
            self.name = name
        else:
            raise ValueError("'entity' must be a string of non-zero length")
        self.ports = {}
        self.parameters = {}
        self.n_params = 0
        self.comment = comment
        self.wb_interfaces = 0
        self.wb_bytes = []
        self.wb_ids = []
        self.wb_names = []
        self.sourcefiles = []

    def add_sourcefile(self, file):
        self.sourcefiles.append(file)

    def add_port(self, name=None, signal=None, extdir=None, internal=True, width=0):
        """
        Add a port to the instance, with name 'name', connected to signal
        'signal'. 'signal' can be a string, and might include bit indexing,
        e.g. 'my_signal[15:8]'
        """
        if name not in self.ports.keys():
            self.ports[name] = Port(name, signal=signal, extdir=extdir, internal=internal, width=width)
        elif signal != self.ports[name].signal:
            raise Exception ('tried to redefine a port connection %s from signal %s to %s'
                             %(name, self.ports[name].signal, signal))
            
    
    def add_wb_interface(self,nbytes=4,name=None):
        """
        Add the ports necessary for a wishbone slave interface.
        Wishbone ports that depend on the slave index are identified by a parameter
        that matches the instance name. This parameter must be given a value in a higher level
        of the verilog code!
        """
        self.wb_interfaces += 1
        self.wb_bytes += [nbytes]
        if name is None:
            wb_id = self.name.upper() + '_WBID%d'%(self.wb_interfaces-1)
            self.wb_names += [self.name]
        else:
            wb_id = name.upper() + '_WBID%d'%(self.wb_interfaces-1)
            self.wb_names += [name]
        self.wb_ids += [wb_id]
        self.add_port('wb_clk_i','wb_clk_i', internal=False)
        self.add_port('wb_rst_i','wb_rst_i', internal=False)
        self.add_port('wb_cyc_i','wbs_cyc_o[%s]'%wb_id, internal=False)
        self.add_port('wb_stb_i','wbs_stb_o[%s]'%wb_id, internal=False)
        self.add_port('wb_we_i','wbs_we_o', internal=False)
        self.add_port('wb_sel_i','wbs_sel_o', width=4, internal=False)
        self.add_port('wb_adr_i','wbs_adr_o', width=32, internal=False)
        self.add_port('wb_dat_i','wbs_dat_o', width=32, internal=False)
        self.add_port('wb_dat_o','wbs_dat_i[(%s+1)*32-1:(%s)*32]'%(wb_id,wb_id), width=32, internal=False)
        self.add_port('wb_ack_o','wbs_ack_i[%s]'%wb_id, internal=False)
        self.add_port('wb_err_o','wbs_err_i[%s]'%wb_id, internal=False)

    def add_parameter(self, name=None, value=None):
        """
        Add a parameter to the instance, with name 'name' and value
        'value'
        """
        self.parameters[name] = {'value':value}
        self.n_params += 1
        if name not in self.parameters.keys():
            self.ports[name] = {'value':value}
        elif value != self.parameters[name]['value']:
            raise Exception ('tried to redefine a parameter %s from value %s to %s'
                             %(name, self.parameters[name]['value'], value))
    
    def gen_instance_verilog(self):
        s = ''
        if self.comment is not None:
            s += '  // %s\n'%self.comment
        if self.n_params > 0:
            s += '  %s #(\n' %self.entity
            n_params = len(self.parameters)
            n = 0
            for paramname, parameter in self.parameters.items():
                s += '    .%s(%s)'%(paramname, parameter['value'])
                if n != (n_params - 1):
                    s += ',\n'
                else:
                    s += '\n'
                n += 1
            s += '  ) %s (\n'%self.name
        else:
            s += '  %s  %s (\n'%(self.entity, self.name)
        n_ports = len(self.ports)
        n = 0
        for portname, port in self.ports.items():
            s += '    .%s(%s)'%(port.name, port.signal)
            if n != (n_ports - 1):
                s += ',\n'
            else:
                s += '\n'
            n += 1
        s += '  );\n'
        return s

class VerilogModule(object):
    def __init__(self, name='', topfile=None):
        """
        Construct a new module, named 'name'.
        You can either start with an empty module
        and add ports/signals/instances to it,
        or you can specify an existing top-level file
        topfile, which will be modified.
        If doing the latter, the construction of
        wishbone interconnect demands that the
        topfile has a localparam N_WB_SLAVES,
        which specifies the number of wishbone
        slaves in the un-modified topfile. And 
        SLAVE_BASE and SLAVE_HIGH localparams
        definiting the slave addresses.

        Eg:

        localparam N_WB_SLAVES = 2;

        localparam SLAVE_BASE = {
          32'h00010000, // slave_1
          32'h00000000  // slave_0
        };
      
        localparam SLAVE_HIGH = {
          32'h00010003, // slave_1
          32'hFFFFFFFF  // slave_0
        };

        This module will only tolerate
        i/o declarations like:
        
        module top (
            input sysclk_n,
            input sysclk_p,
            ...
            );

        I.e, NOT

        module top(
            sysclk_n,
            sysclk_p,
            ...
            );
            input sysclk_n;
            input sysclk_p;
            ...

        YMMV if your topfile doesn't use linebreaks as
        shown above. I.e., for best chance of success don't do

        module top( sysclk_n,
           sysclk_p);

        localparam SLAVE_BASE = {32'h00000000};

        """
        if len(name) != 0:
            self.name = name
        else:
            raise ValueError("'name' must be a string of non-zero length")
        
        self.logger = logging.getLogger('jasper.verilog')
        self.topfile = topfile
        self.ports = []         # top-level ports
        self.parameters = []    # top-level parameters
        self.localparams = []   # top-level localparams
        self.signals = {}       # top-level wires
        self.instances = {}     # top-level instances
        self.assignments = []   # top-level assign statements
        self.raw_str = ''       # the verilog text describing this module

        # wishbone stuff
        # number of wishbone slaves in the model. It will be overwritten
        # based on the N_WB_SLAVES localparam of a provided topfile,
        # and incremented when adding wishbone-enabled instances
        self.wb_slaves = 0 #wb slaves added to this module programmatically
        if self.topfile is not None:
            self.get_base_wb_slaves()
        else:
            self.base_wb_slaves = 0 #wb slaves in the topfile
        self.wb_base = []
        self.wb_high = []
        self.wb_name = []
        # sourcefiles required by the module (this is currently NOT
        # how the jasper toolflow implements source management)
        self.sourcefiles = []

    def wb_compute(self, base_addr=0x10000, alignment=4):
        '''
        Compute the appropriate wishbone address limits,
        based on the current wishbone-using instances
        instantiated in the module.

        Will NOT take into account wishbone memory space
        used by the template verilog file (but see base_addr, below)

        :param base_addr: The address from which indexing of instance wishbone
        interfaces will begin. Any memory space required by the template
        verilog file should be below this address.
        :type base_addr: int
        :param alignment: Alignment required by all memory start addresses.
        :type alignment: int
        '''
        for instname, inst in self.instances.items():
            self.logger.debug("Looking for WB slaves for instance %s"%inst.name)
            for n in range(inst.wb_interfaces):
                self.logger.debug("Found new WB slave for instance %s"%inst.name)
                self.wb_base += [base_addr]
                self.wb_high += [base_addr + (alignment*int(ceil(inst.wb_bytes[n]/float(alignment)))) - 1]
                self.wb_name += [inst.wb_names[n]]
                self.add_localparam(name=inst.wb_ids[n], value=self.wb_slaves+self.base_wb_slaves)
                base_addr = self.wb_high[-1] + 1
                self.wb_slaves += 1

    def get_base_wb_slaves(self):
        '''
        Look for the pattern 'localparam N_WB_SLAVES'
        in this modules topfile, and use it to extract the
        number of wishbone slaves in the module.
        Update the base_wb_slaves attribute accordingly.
        Also extract the addresses. Names are auto-generated
        '''
        fh = open('%s'%self.topfile, 'r')
        while(True):
            line = fh.readline()
            if len(line) == 0:
                break
            elif line.lstrip(' ').startswith('localparam N_WB_SLAVES'):
                self.logger.debug('Found N_WB_SLAVES declaration: %s'%line)
                declaration = line.split('//')[0]
                self.base_wb_slaves = int(re.search('\d+',declaration).group(0))
                self.logger.debug('base_wb_slaves is now %d'%self.base_wb_slaves)
                fh.close()
                return

        # if we get to here something has gone wrong
        fh.close()
        self.logger.error('No N_WB_SLAVES localparam found in topfile %s!'%self.topfile)
        raise Exception('No N_WB_SLAVES localparam found in topfile %s!'%self.topfile)


    def add_port(self, name, dir, width=0, comment=None, **kwargs):
        """
        Add a port to the module, with a given name, width and dir.
        Any width other than None implies a vector port. I.e., width=1
        will generate port declarations of the form '*put [0:0] some_port;'
        Direction should be 'in', 'out' or 'inout'.
        You can optionally specify a comment to add to the port. 
        """
        self.ports.append({'name':name, 'width':width, 'dir':dir,
                           'comment':comment, 'attr':kwargs})

    def add_parameter(self, name, value, comment=None):
        """
        Add a parameter to the entity, with name 'parameter' and value
        'value'.
        You may add a comment that will end up in the generated verilog.
        """
        self.parameters.append({'name':name, 'value':value, 'comment':comment})


    def add_localparam(self, name, value, comment=None):
        """
        Add a parameter to the entity, with name 'parameter' and value
        'value'.
        You may add a comment that will end up in the generated verilog.
        """
        self.localparams.append({'name':name, 'value':value, 'comment':comment})

    def add_signal(self, signal, width=0, comment=None):
        """
        Add an internal signal to the entity, with name 'signal'
        and width 'width'.
        You may add a comment that will end up in the generated verilog.
        """
        if signal not in self.signals.keys():
            self.logger.debug('Adding signal %s'%(signal))
            self.signals[signal] = {'width':width, 'comment': comment}
        elif width != self.signals[signal]['width']:
            raise Exception ('tried to redefine a signal %s from width %d to width %d'
                             %(signal, int(self.signals[signal]['width']), int(width)))

    def assign_signal(self, lhs, rhs, comment=None):
        """
        Assign one signal to another, or one signal to a port.
        i.e., generate lines of verilog like:
        assign lhs = rhs;
        'lhs' and 'rhs' are strings that can represent port or signal
        names, and may include verilog-style indexing, eg '[15:8]'
        You may add a comment that will end up in the generated verilog.
        """
        self.assignments.append({'lhs':lhs, 'rhs':rhs, 'comment':comment})

    def get_instance(self, entity, name, comment=None):
        """
        Instantiate and return a new instance of entity 'entity', with instance name 'name'.
        You may add a comment that will end up in the generated verilog.
        """
        new_inst = VerilogInstance(entity=entity, name=name, comment=comment)
        if name not in self.instances.keys():
            return new_inst
        else:
            return self.instances[name]

    def add_sourcefile(self,file):
        self.sourcefiles.append(file)

    def add_instance(self, inst):
        """
        Add an existing instance to the list of instances in the module.
        """
        if isinstance(inst,VerilogInstance):
            if inst.name not in self.instances.keys():
                self.logger.debug('Adding instance %s to top'%inst.name)
                for pname, port in inst.ports.items():
                    self.logger.debug('  Adding instance port %s to top'%port.name)
                    if port.internal:
                        self.add_signal(port.signal, width=port.width)
                    if port.extdir is not None:
                        self.add_port(port.signal, dir=port.extdir, width=port.width)
                self.instances[inst.name] = inst
                self.sourcefiles += inst.sourcefiles
            else:
                self.logger.warning('Tried to add another instance called %s'%inst.name)
        else:
            raise ValueError('inst is not a VerilogInstance instance!')

    def add_raw_string(self,s):
        self.raw_str += s

    def gen_module_file(self):
        if self.topfile is None:
            self.write_new_module_file()
        else:
            self.rewrite_module_file()

    def rewrite_module_file(self):
        '''
        Rewrite the intially supplied verilog file to
        include instance, signals, ports, assignments and
        wishbone interfaces added programmatically.
        The initial verilog file is backed up with a '.base'
        extension.
        '''
        os.system('mv %s %s.base'%(self.topfile,self.topfile))
        fh_base = open('%s.base'%self.topfile,'r')
        fh_new = open('%s'%self.topfile, 'w')
        fh_new.write('// %s, AUTOMATICALLY MODIFIED BY PYTHON\n\n'%self.topfile)
        while(True):
            line = fh_base.readline()
            if len(line) == 0:
                break
            elif line.lstrip(' ').startswith('module'):
                self.logger.debug('Found module declaration')
                fh_new.write(line)
                fh_new.write(self.gen_port_list())
            elif line.lstrip(' ').startswith('localparam N_WB_SLAVES'):
                self.logger.debug('Found N_WB_SLAVES declaration: %s'%line)
                declaration = line.split('//')[0]
                s = re.sub('\d+','%s'%(self.wb_slaves+self.base_wb_slaves),declaration)
                self.logger.debug('Replacing declaration with: %s'%s)
                fh_new.write(s)
            elif line.lstrip(' ').startswith('localparam SLAVE_BASE = {'):
                self.logger.debug('Found slave_base dec %s'%line)
                fh_new.write(line)
                for slave in range(self.wb_slaves)[::-1]:
                    fh_new.write("    32'h%08x, // %s\n"%(self.wb_base[slave], self.wb_name[slave]))
            elif line.lstrip(' ').startswith('localparam SLAVE_HIGH = {'):
                self.logger.debug('Found slave_high dec: %s'%line)
                fh_new.write(line)
                for slave in range(self.wb_slaves)[::-1]:
                    fh_new.write("    32'h%08x, // %s\n"%(self.wb_high[slave], self.wb_name[slave]))
            elif line.lstrip(' ').startswith('endmodule'):
                fh_new.write(self.gen_top_mod())
                fh_new.write(line)
            else:
                fh_new.write(line)
        fh_new.close()
        fh_base.close()

    def write_new_module_file(self):
        '''
        Write a verilog file from scratch, based on the
        programmatic additions of instances / signals / etc.
        to the VerilogModule instance.

        The jasper toolflow has been using rewrite_module_file()
        rather than this method, so it may or may not still
        work correctly. It used to, at least...
        '''
        mod_dec        = self.gen_mod_dec_str()
        # declare inputs/outputs with the module dec
        port_dec       = ''#self.gen_ports_dec_str()
        param_dec      = self.gen_params_dec_str()
        localparam_dec = self.gen_localparams_dec_str()
        sig_dec        = self.gen_signals_dec_str()
        inst_dec       = self.gen_instances_dec_str()
        assignments    = self.gen_assignments_str()
        endmod         = self.gen_endmod_str()
        fh = open('%s.v'%self.name, 'w')
        fh.write('// MODULE %s, AUTOMATICALLY GENERATED BY PYTHON\n\n'%self.name)
        fh.write('\n')
        fh.write('\n')
        fh.write(mod_dec)
        fh.write('\n')
        fh.write(port_dec)
        fh.write('\n')
        fh.write(param_dec)
        fh.write('\n')
        fh.write(localparam_dec)
        fh.write('\n')
        fh.write(sig_dec)
        fh.write('\n')
        fh.write(inst_dec)
        fh.write('\n')
        fh.write(assignments)
        fh.write('\n')
        fh.write(self.raw_str)
        fh.write('\n')
        fh.write(endmod)
        fh.close()

    def gen_top_mod(self):
        """
        Return the code that needs to go in a top level verilog file
        to incorporate this module. I.e., everything except the module
        port declaration headers and endmodule lines.

        TODO: This is almost identical to write_new_module_file(). Combine?
        """        
        # don't need this if we declare ports with the module declaration
        port_dec         = ''#self.gen_ports_dec_str()
        param_dec        = self.gen_params_dec_str()
        localparam_dec   = self.gen_localparams_dec_str()
        sig_dec          = self.gen_signals_dec_str()
        inst_dec         = self.gen_instances_dec_str()
        assignments      = self.gen_assignments_str()
        s = '// INSTANCE %s, AUTOMATICALLY GENERATED BY PYTHON\n'%self.name
        s += '\n'
        s += port_dec
        s += '\n'
        s += param_dec
        s += '\n'
        s += localparam_dec
        s += '\n'
        s += sig_dec
        s += '\n'
        s += inst_dec
        s += '\n'
        s += assignments
        s += '\n'
        s += self.raw_str
        return s
        
    def gen_mod_dec_str(self):
        """
        Generate the verilog code required to start a module
        declaration.
        """
        s = 'module %s (\n'%self.name
        n_ports = len(self.ports)
        for pn,port in enumerate(self.ports):
            if port['width'] == 0:
                s += '    %s %s'%(kwm[port['dir']],port['name'])
            else:
                s += '    %s [%d:0] %s'%(kwm[port['dir']], (port['width']-1), port['name'])
            if pn != (n_ports-1):
                s += ','
            if port['comment'] is not None:
                s += ' // %s'%port['comment']
            s += '\n'
        s += '  );\n'
        return s

    def gen_params_dec_str(self):
        """
        Generate the verilog code required to
        declare parameters
        """
        s = ''
        for pn,parameter in enumerate(self.parameters):
            s += '  parameter %s = %s;'%(parameter['name'],parameter['value'])
            if parameter['comment'] is not None:
                s += ' // %s'%parameter['comment']
            s += '\n'
        return s

    def gen_localparams_dec_str(self):
        """
        Generate the verilog code required to
        declare localparams
        """
        s = ''
        for pn,parameter in enumerate(self.localparams):
            s += '  localparam %s = %s;'%(parameter['name'],parameter['value'])
            if parameter['comment'] is not None:
                s += ' // %s'%parameter['comment']
            s += '\n'
        return s

    def gen_port_list(self):
        """
        Generate the verilog code required to
        declare ports
        """
        s = ''
        kwm = {'in':'input','out':'output','inout':'inout'}
        for pn,port in enumerate(self.ports):
            if port['width'] == 0:
                s += '    %s %s,'%(kwm[port['dir']],port['name'])
            else:
                s += '    %s [%d:0] %s,'%(kwm[port['dir']], (port['width']-1), port['name'])
            if port['comment'] is not None:
                s += ' // %s'%port['comment']
            s += '\n'
        return s

    def gen_ports_dec_str(self):
        """
        Generate the verilog code required to
        declare ports with special attributes, eg LOCS, etc.
        """
        # keyword map
        kwm = {'in':'input','out':'output','inout':'inout'}
        s = ''
        for pn,port in enumerate(self.ports):
            # set up indentation nicely
            s += '  '
            # first write attributes
            if port['attr'] != {}:
                s += '(* '
                n_keys = len(port['attr'].keys())
                for kn,key in enumerate(port['attr'].keys()):
                    if kn != (n_keys-1):
                        s += '%s = "%s",'%(key,port['attr'][key])
                    else:
                        s += '%s = "%s"'%(key,port['attr'][key])
                s += ' *)'
            # declare port
            if port['width'] == 0:
                s += '%s %s;'%(kwm[port['dir']], port['name'])
            else:
                s += '%s [%d:0] %s;'%(kwm[port['dir']], (port['width']-1), port['name'])
            if port['comment'] is not None:
                s += ' // %s'%port['comment']
            s += '\n'
        return s
       
    def gen_signals_dec_str(self):
        """
        Generate the verilog code required to
        declare signals
        """
        s = ''
        for name, sig in self.signals.items():
            self.logger.debug('Writing verilog for signal %s'%name)
            if sig['width'] == 0:
                s += '  wire %s;'%(name)
            else:
                s += '  wire [%d:0] %s;'%((sig['width']-1), name)
            if sig['comment'] is not None:
                s += ' // %s'%sig['comment']
            s += '\n'
        return s

    def gen_instances_dec_str(self):
        """
        Generate the verilog code required
        to instantiate the instances in this 
        module
        """
        n_inst = len(self.instances)
        s = ''
        n = 0
        for instname, instance in self.instances.items():
            s += instance.gen_instance_verilog()
            if n != (n_inst - 1):
                s += '\n'
            n += 1
        return s
    
    def gen_assignments_str(self):
        """
        Generate the verilog code required
        to assign a port or signal to another
        signal
        """
        s = ''
        for n,assignment in enumerate(self.assignments):
            s += '  assign %s = %s;'%(assignment['lhs'], assignment['rhs'])
            if assignment['comment'] is not None:
                s += ' // %s'%assignment['comment']
            s += '\n'
        return s

    def gen_endmod_str(self):
        return 'endmodule\n'
