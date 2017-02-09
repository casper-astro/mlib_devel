import os
import logging
from glob import glob

class YellowBlock(object):
    """
    A yellow block object encodes all the information necessary
    to instantiate a piece of IP in an existing HDL base package.
    -- which verilog modules need to be instantiated.
    -- which instances need to be connected by signals
    -- which ports of the instance need to be promoted to top-level
    -- what is the type of these ports (for the constraints file)
    -- is the device a slave on a CPU bus
    -- if so, how much address space does it need?
    -- what features does this block provide the rest of the system,
       e.g. clock sources
    -- what fixed resources does this block use (e.g. QDR chip / ZDOK interface)

    All the HDL related stuff is dealt with by the verilog module class, so we just need
    to add bus / memory space requirements and define what resources the block uses and
    provisions.
    """
    
    _count = -1
    @classmethod
    def _get_id(cls):
        cls._count += 1
        return cls._count

    @staticmethod
    def make_block(blk, platform, hdl_root=None):
        """
        A builder function to return the 
        correct block class based on 'blk'.

        Arguments:
        blk: A jasper-standard dictionary containing block information
        platform: A Platform object representing the platform type.

        Keyword Arguments:
        hdl_root: The path to a directory containing all hdl code necessary
                  for block instantiation.
        """
        if blk['tag'].startswith('xps:'):
            # This seems a little dubious
            # Import the yellow block from the same package
            # that this YellowBlock class lives
            print blk['tag'][4:]
            clsfile = __import__(__package__+'.'+blk['tag'][4:])
            cls = clsfile.__getattribute__(blk['tag'][4:])
            cls = cls.__getattribute__(blk['tag'][4:]) # don't understand
            # If the class has a factory method, call that. This should return some
            # (possibly platform dependent) yellow block instance
            # Else just return an instance of the class.
            if callable(getattr(cls, 'factory', None)):
                return cls.factory(blk, platform, hdl_root=hdl_root)
            else:
                return cls(blk,platform,hdl_root=hdl_root)
        else:
            # Don't do anything for non-xps blocks.
            pass

    @staticmethod
    def test_import():
        clsfile = __import__(__package__+'.sw_reg')
        cls = clsfile.__getattribute__('sw_reg')
        print cls
        #return cls(blk,platform,hdl_root=hdl_root)
        

    def __init__(self, blk, platform, hdl_root=None):
        """
        Set up the initial values for block attributes.
        Then run the initialize() method, which hopefully
        has been overridden by the individual block subclasses.

        Arguments:
        blk: A jasper-standard dictionary containing block information
        platform: A Platform object representing the platform type.

        Keyword Arguments:
        hdl_root: The path to a directory containing all hdl code necessary
                  for block instantiation. If None, defaults to the 
                  HDL_ROOT environment variable.
        """
        self.logger = logging.getLogger('jasper.yellowblock')

        # Get the hdl_root path from env variable if possible
        if hdl_root is None:
            self.hdl_root = os.getenv('HDL_ROOT').rstrip('/')
        else:
            self.hdl_root = hdl_root.rstrip('/')
        if self.hdl_root is not None:
            if not os.path.isdir(self.hdl_root):
                raise Exception('Specified hdl root path %s does not exist!'%self.hdl_root)

        self.inst_id = self._get_id() # an incrementing id counting instances of each subclass
        self.i_am_the_first = self.inst_id == 0
        self.n_wb_slaves = 0
        self.mem_alloc = []
        self.provides = []
        self.requires = []
        self.sources = []
        self.ips = []
        self.exc_requires = []
        self.wb_id = 0
        self.platform_support = 'all' #override this in subclasses
        self.blk = blk
        self.platform = platform
        self.name = self.blk['tag'] + '%d'%self.inst_id #this can get overwritten by copy_attrs
        self.typecode = 0xFF
        self.copy_attrs()
        try:
            self.fullname = self.fullpath.replace('/','_')
	    self.unique_name = self.fullpath.split('/',1)[1].replace('/','_')
        except AttributeError:
            self.fullpath = self.tag + '%d'%self.inst_id
            self.fullname = self.tag + '%d'%self.inst_id
            self.unique_name = self.tag + '%d'%self.inst_id
            self.logger.warning("%r doesn't have an attribute 'fullpath'"%self)
        self.initialize()
        self.check_support()

    def __str__(self):
        return "YellowBlock Object: %s (%s)"%(self.blk,self.fullname)

    def copy_attrs(self):
        """
        Grab the dictionary entries of self.blk
        and turn them into attributes of this
        YellowBlock instance.
        """
        for key in self.blk.keys():
            self.__setattr__(key,self.blk[key])

    def gen_children(self):
        """
        The toolflow will try to allow blocks to instantiate
        blocks themselves, by calling this method.
        Override it in your subclass if you need to use this
        functionality.
        """
        return []
    
    def check_support(self):
        """
        Check the platform being used is supported by this block.
        Relies on subclasses to set platform_support attribute
        appropriately in their initialize() methods. The default
        of the YellowBlock class is platform_support = 'all'
        """
        if self.platform_support == 'all':
            pass
        elif self.platform.name not in self.platform_support:
            throw_error('Unsupported hardware system %s'%self.platform)

    def initialize(self):
        """
        This function is called by YellowBlocks __init__ method. It
        is meant to be overridden by subclasses.
        We could let subclasses override __init__ instead, but this seems
        a little bit more user friendly.
        """
        pass

    def drc(self):
        """
        Perform block-specific design rule checks. This method
        should be overridden by subclasses if any drc's are required.
        """
        pass

    def modify_top(self,top):
        """ 
        Modify the VerilogModule instance top. This method is meant
        to be overridden by subclasses, and can be used to instantiate
        bits of verilog in the top-level design description.
        """
        pass

    def gen_constraints(self):
        """
        This method is designed to be overridden by subclasses. It should
        return a list of PortConstraint instances.
        """
        return []

    def gen_tcl_cmds(self):
        """
        This method is designed to be overridden by subclasses. It should
        return a list of Strings.
        """
        return {}

    #def add_resource(self, thing):
    #    """
    #    Use this method in a block's initialize() method to add
    #    provisions that a block provides. Eg., a yellow block
    #    for an adc on zdok0 may provide 'adc0_clk'.
    #    These resources don't impact the final HDL, but are used for internal
    #    error checking to catch simple errors before diving into a compile.
    #    Eg, this infrastructure is used to catch the case where a design
    #    is to be clocked off an ADC clock input, but no ADC yellow block
    #    is present in the design.
    #    """
    #    self.provisions.append(thing)

    #def add_requirement(self, thing):
    #    """
    #    Use this method to specify things that this yellow block requires
    #    to function. The toolflow later matches these requirements with
    #    the resources specified by add_resources() as well as platform-level
    #    properties.
    #    Eg, a qdr yellow block may require 'qdr3'. An exception will be thrown
    #    if neither the target platform nor another yellow block provides this
    #    resource. (This actually isn't a very good example, see: add_exc_requirement())
    #    """
    #    self.requirements.append(thing)

    #def add_exc_requirement(self, thing):
    #    """
    #    As add_requirement(), but requires that no other block is using the required
    #    resource. Eg, a qdr yellow block may require 'qdr3'. An exception will be thrown
    #    if neither the target platform nor antoher yellow block provides this resource.
    #    An error will also be thrown if the resource is provided, but is required by
    #    another yellow block.
    #    """
    #    self.requirements_exc.append(thing)

    def add_source(self, path):
        """
        Add a source file to the list of files required
        to compile this yellow block.
        """
        if path.startswith('/'):
            fullpath = path
        else:
            fullpath = self.hdl_root + '/' + path
        print path, glob(fullpath)
        for fname in glob(fullpath):
            self.sources.append(fname)
        #if not os.path.exists(fullpath):
        #    self.throw_error("path %s does not exist"%path)
        #self.sources.append(fullpath)

    def throw_error(self,message):
        """
        Raise an exception, showing the input message,
        but prefixing with a human-readable yellow block
        name.
        """
        err = "Exception from %s: %s"%(self,message)
        self.logger.error(err)
        raise Exception(err)
