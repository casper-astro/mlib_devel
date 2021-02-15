class Register(object):
    def __init__(self, name, nbytes=4, offset=0, mode='r',
                default_val=0, ram=False, ram_size=-1, data_width=32, axi4lite_mode=''):
        """
        A class to encapsulate a register's parameters. This is used when
        instantiating a device with a large address space, but it is desirable
        to be able to address sub-spaces of this memory with separate names.

        For example (see sys_block.py):

        .. code-block:: python

            class sys_block(YellowBlock):
                def initialize(self):
                    self.typecode = TYPECODE_SYSBLOCK
                    self.add_source('sys_block')
                    # the internal memory_map
                    self.memory_map = [
                        Register('sys_board_id',   mode='r',  offset=0),
                        Register('sys_rev',        mode='r',  offset=0x4),
                        Register('sys_rev_rcs',    mode='r',  offset=0xc),
                        Register('sys_scratchpad', mode='rw', offset=0x10),
                        Register('sys_clkcounter', mode='r',  offset=0x14),
                    ]
                def modify_top(self,top):
                    inst = top.get_instance('sys_block', 'sys_block_inst')
                    inst.add_parameter('BOARD_ID', self.board_id)
                    inst.add_parameter('REV_MAJ', self.rev_maj)
                    inst.add_parameter('REV_MIN', self.rev_min)
                    inst.add_parameter('REV_RCS', self.rev_rcs)
                    inst.add_port('user_clk', 'user_clk')
                    inst.add_wb_interface('sys_block', mode='r', nbytes=64, memory_map=self.memory_map, typecode=self.typecode)
        
        :param name: The name of this register
        :type name: String
        :param nbytes: Number of bytes this register occupies
        :type nbytes: Integer
        :param offset: Location, in bytes, where this register resides in memory, relative to the base address of the device.
        :type offset: Integer
        :param mode: Read/write permission for this register. 'r' (readable), 'w' (writable), 'rw' (read/writable)
        :type mode: String
        :param default_val: Default value for register to be reset to and initialized.
        :type default_val: Integer
        :param ram: Whether the register is a RAM or not.
        :type ram: Boolean
        :param ram_size: Size of the RAM
        :type ram_size: Integer
        :param data_width: Width of the data to be stored in this register.
        :type data_width: Integer
        :param axi4lite_mode: Mode of the axi4lite interface. Eg. axi4lite_mode = 'raw', instantiates a raw axi4lite device.
        :type axi4lite_mode: String

        """
        self.name = name
        self.nbytes = nbytes
        self.offset = offset
        self.mode = mode
        self.ram = ram
        #self.ram_size = ram_size
        self.default_val = default_val

        # Addded to make provision for variable-size BRAMs in AXI4-Lite devices
        # - Placing here for now because toolflow.py:generate_xml_memory_map
        #   has access to the memory.Register object in the XML generation
        self.data_width = data_width
        self.axi4lite_mode = axi4lite_mode
