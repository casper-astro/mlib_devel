import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule
import ast

class bus_expand(DSPBlock):
    def initialize(self):
        # create the hdl wrapper directory
        self.create_hdl_dir()
        # convert string here to list
        self.bit_division = ast.literal_eval(self.bit_division)
        # calculate the total number of bits
        self.total_bits = sum(self.bit_division)
        # check if the ndivision maches the length of bit_division
        if self.ndivision != len(self.bit_division):
            raise Exception("Length of ndivision should match the length of bit_division")
        # we don't have source files for this block
        # the hdl code is generated dynamically
        # TODO: Is this a good idea?
        self._generate_hdl_wrapper()

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'adder'
        inst = top.get_instance(entity=module, name=self.fullname)
        # TODO: add parameters
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('ce', '1', parent_port=False, width=1, dir='in')
        inst.add_port('i_data', self.fullname+'_i_data', parent_port=False, width=self.total_bits, dir='in')
        for i in range(self.ndivision):
            inst.add_port(f'o_data_{i}', self.fullname+f'_o_data_{i}', parent_port=False, width=self.bit_division[i], dir='out')

    def _generate_hdl_wrapper(self):
        # get the paramters from the bus_expand obj
        bit_division = self.bit_division
        division = len(bit_division)
        # calculate bit start.
        # For example, if bit_division = [1,2,3,4], the output bit range will be:
        # out0 - 10-1 : 9;
        # out1 -  9-8 : 7;
        # out2 -  7-5 : 4;
        # out3 -  4-1 : 0;
        # So, bit_start = [10, 9, 7, 4, 0]
        bit_start = []
        bit_start.append(sum(bit_division))
        for i in range(division):
            bit_start.append(sum(bit_division[i+1:]))
        vhdl_template = f"""
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY bus_expand_arbitrary is
port (
    clk   : in std_logic := '1';
    ce    : in std_logic := '1';

    i_data   : in std_logic_vector;
    """
        vhdl_template += "    ".join(f"o_data_{i}   : out std_logic_vector;\n" for i in range(division))
        vhdl_template += f"""
);
end ENTITY;

ARCHITECTURE rtl of bus_expand_arbitrary is
    alias a_data : STD_LOGIC_VECTOR (i_data'length-1 downto 0) is i_data;
    """
        vhdl_template += "    ".join(f"alias a_data_{i} : STD_LOGIC_VECTOR ({bit_division[i]}-1 downto 0) is o_data_{i};\n" for i in range(division))
        vhdl_template += f"""
begin

  -- g_split : FOR I IN g_division_bit_widths'range GENERATE
  -- begin
    """
        vhdl_template += "    ".join(f"a_data_{i} <= a_data({bit_start[i]}-1 downto {bit_start[i+1]});\n" for i in range(division))
        vhdl_template += f"""
  -- end GENERATE;

end ARCHITECTURE;
    """
        with open("generated_bus_expand.vhd", "w", encoding="utf-8") as file:
            file.write(vhdl_template)