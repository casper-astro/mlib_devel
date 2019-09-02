import os
import logging
from glob import glob
import collections

class YellowBlock(object):
    """
    A yellow block object encodes all the information necessary
    to instantiate a piece of IP in an existing HDL base package.

    * which verilog modules need to be instantiated.
    * which instances need to be connected by signals
    * which ports of the instance need to be promoted to top-level
    * what is the type of these ports (for the constraints file)
    * is the device a slave on a CPU bus
    * if so, how much address space does it need?
    * what features does this block provide the rest of the system, e.g. clock sources
    * what fixed resources does this block use (e.g. QDR chip / ZDOK interface)

    All the HDL related stuff is dealt with by the verilog module class, so we just need
    to add bus / memory space requirements and define what resources the block uses and
    provisions.
    """
    
    _count = -1
    @classmethod
    def _get_id(cls):
        """
        Get an auto-incrementing ID number for a yellow block of a particular
        class type.

        :param cls: ``YellowBlock`` class, e.g. ``gpio``
        :return: Number of instances of this class currently constructed.
        """
        cls._count += 1
        return cls._count

    @staticmethod
    def make_block(blk, platform, hdl_root=None):
        """
        A builder function to return an instance of the correct ``YellowBlock`` subclass for a given type
        of block and target platform.

        
        :param blk: A jasper-standard dictionary containing block information
        :param platform: A Platform object representing the platform type.
        :optional keyword param hdl_root: The path to a directory containing all hdl code necessary
                  to instantiate this block. This root directory is used as a base from which block's
                  source files are defined.
        """
        if blk['tag'].startswith('xps:'):
            # This seems a little dubious
            # Import the yellow block from the same package
            # that this YellowBlock class lives
            print(blk['tag'][4:])
            clsfile = __import__(__package__+'.'+blk['tag'][4:])
            cls = clsfile.__getattribute__(blk['tag'][4:])
            cls = cls.__getattribute__(blk['tag'][4:]) # don't understand
            # If the class has a factory method, call that. This should return some
            # (possibly platform dependent) yellow block instance
            # Else just return an instance of the class.
            if isinstance(getattr(cls, 'factory', None), collections.Callable):
                return cls.factory(blk, platform, hdl_root=hdl_root)
            else:
                return cls(blk,platform,hdl_root=hdl_root)
        else:
            # Don't do anything for non-xps blocks.
            pass

    def __init__(self, blk, platform, hdl_root=None):
        """
        Class constructor.
        Set up the initial values for block attributes, by copying key/val pairs from the ``blk``
        dictionary. Call the class's ``initialize()`` method, where the user should set compile parameters and override
        this class's default attributes.
        Finally, call the class's ``check_support()`` method, to verify that the block and platform chosen are compatible.
        
        :param blk: A jasper-standard dictionary containing block information. Key/value pairs in this
                    dictionary are copied to attributes of this instance.
        :param platform: A Platform object representing the platform type.
        :param hdl_root: The path to a directory containing all hdl code necessary
                  to instantiate this block. This root directory is used as a base from which block's
                  source files are defined. If None (default), will default to the system's `HDL_ROOT`
                  environment variable.
        :type hdl_root: Optional
        """

        self.logger = logging.getLogger('jasper.yellowblock') #: The `jasper.yellowblock` logger

        # Get the hdl_root path from env variable if possible
        if hdl_root is None:
            self.hdl_root = os.getenv('HDL_ROOT').rstrip('/') #: The base directory from which source file's locations are specified
        else:
            self.hdl_root = hdl_root.rstrip('/')
        if self.hdl_root is not None:
            if not os.path.isdir(self.hdl_root):
                raise Exception('Specified hdl root path %s does not exist!'%self.hdl_root)

        #: The ID of this block within all the instances of this block's class
        self.inst_id = self._get_id()
        #: A boolean, which is `True` if `self.inst_id == 0`
        self.i_am_the_first = self.inst_id == 0
        #: A list of strings, eg. "zdok0", "sfp1", detailing a resource this block needs to compile.
        #: To pass rule-checking, every entry here must be matched with an entry in `self.provides`
        #: of another block, or the target platform
        self.requires = []
        #: A list of strings, eg. "zdok0", "sfp1", detailing a resource this block provides to the
        #: design. These will me matched against `self.requires` and `self.exc_requires` of all
        #: the blocks in the design to determine if the compile is viable.
        self.provides = []
        #: A list of source files (paths relative to `self.hdl_root`) required by this module
        self.sources = []
        #: A list of IP dictionaries defining user-supplied IP to include with this block
        #: Dictionaries in this list have keys `path` (the path to the library)
        #: `name` (the name of the IP)
        #: `module_name` (the name of the HDL module this block defines)
        #: `vendor`, `library`, `version` (strings used by the backend to instantiate the IP)
        self.ips = []
        #: "Exclusive requirements". A list of strings, e.g. "zdok0", "sfp2", detailing a resources this block needs in order to compile.
        #: If another block tries to require the same resource, the compile will fail error checking.
        self.exc_requires = []
        #: A list of platform names this block supports, or, the string "all", indicating the block is platform agnostic.
        self.platform_support = 'all' 
        #: Stores the `blk` parameter, passed into this block's constructor.
        self.blk = blk
        #: Stores the `platform` parameter, passed into this block's constructor
        self.platform = platform
        #: A friendly name for this block, generated from the `tag` entry in the `self.blk` dictionary
        #: and `self.inst_id`. Eg. "sw_reg5", or "ten_gbe0"
        self.name = self.blk['tag'] + '%d'%self.inst_id #this can get overwritten by copy_attrs
        #: A unique typecode indicating the type of yellow block this is. See `yellow_block_typecodes.py`.
        #: This code gets baked into a memory-map in the FPGA binary, and allows embedded software to figure out
        #: what type of devices are on the CPU bus.
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
        for key in list(self.blk.keys()):
            self.__setattr__(key,self.blk[key])

    def gen_children(self):
        """
        The toolflow will try to allow blocks to instantiate
        other blocks themselves, by calling this method.
        Override it in your subclass if you need to use this
        functionality.

        :return: A list of child YellowBlock instances
        """
        return []
    
    def check_support(self):
        """
        Check the platform being used is supported by this block.
        Relies on subclasses to set the ``platform_support`` attribute
        appropriately in their ``initialize()`` methods. The default
        of the YellowBlock class is ``platform_support = 'all'``.

        Throw an error if the platform appears unsupported.
        """
        if self.platform_support == 'all':
            pass
        elif self.platform.name not in self.platform_support:
            throw_error('Unsupported hardware system %s'%self.platform)

    def initialize(self):
        """
        This function is called by the ``__init__()`` method. It
        is meant to be overridden by subclasses.

        It should over-ride instance attributes to configure the block.

        Common attributes which might be manipulated are:
        ``requires``, ``exc_requires``, ``provides``, ``ips``, ``sources``, ``platform_supports``
        """
        pass

    def drc(self):
        """
        Perform block-specific design rule checks. This method
        should be overridden by subclasses if any custom design checks are required.
        """
        pass

    def modify_top(self,top):
        """ 
        Modify the VerilogModule instance top (so as to instantiate this module's HDL)
        This method should be overridden by subclasses implementing their custom HDL requirements.

        :param top: A VerilogModule instance, defining the top-level
                    of an HDL design into which this block should instantiate itself.
        """
        pass

    def gen_constraints(self):
        """
        Generate a list of Constraint objects, appropriate for this block.
        This method should be over-ridden by sub-classes to return a list of constraints
        as defined in ``constraints.py``
        
        :return: A list of Constraint instances. Default is []
        """
        return []

    def gen_tcl_cmds(self):
        """
        Generate a dictionary of tcl command lists, to be executed at compile time.
        Allowed keys are: ``init``, ``pre_synth``, ``synth``, ``post_synth``, ``pre_impl``, ``impl``, 
        ``post_impl``, ``pre_bitgen``, ``bitgen``, ``post_bitgen``, ``prom_gem``. The key used determines
        at what stage the tcl commands will be run.

        Eg.:

        .. code-block:: python

            {
                'pre_synth': ["first pre-synthesis tcl command", "second pre-synthesis tcl command"],
                'prom_gen' : ["A tcl command to generate a prom file after bit gen"],
            }

        :return: Dictionary of tcl command lists. Default {}
        """
        return {}

    def add_build_dir_source(self):
        """
        This function is neccessary as yellow blocks dont have access to the build directory
        when they want to add a source file that is not in hdl_lib this function can be used.
        Generate a list of dictionaries containing files/directories relative to the build_dir,
        which will be added to the sources of the project.
        to the project.

        Eg.:
        []
            {'files': 'xml2vhdl_hdl_output/',    -- this can be a directory or a file
            'library' : 'work'}                  -- this is only used if the file needs to be included under a library (vhdl only) for verilog use ''
        ]

        :return: Dictionary of tcl command lists. Default {}
        """
        return []

    def gen_custom_hdl(self):
        """
        Generate a dictionary of custom hdl, to be saved as a file and added to the sources of
        the generated project.
        The key is the file name and the value is a string of HDL code to save in to that file.
        Eg.:
        {
            'my_hdl.vhdl': ["<HDL code>"],
            'my_2nd_hdl.vhdl' : ["<More HDL code>"],
        }

        :return: Dictionary of hdl files. Default {}
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
        to compile this yellow block. The path given should
        be relative to the root directory ``hdl_root``.
        Globbing is supported.

        :param path: Path of file required for compilation. Eg "/some/source/file.v" or "/some/files*.v"
        """
        if path.startswith('/'):
            fullpath = path
        else:
            fullpath = self.hdl_root + '/' + path
        print(path, glob(fullpath))
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
