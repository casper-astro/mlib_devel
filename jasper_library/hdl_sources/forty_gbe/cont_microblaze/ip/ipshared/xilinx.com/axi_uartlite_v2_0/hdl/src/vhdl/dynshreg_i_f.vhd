-- dynshreg_i_f - entity / architecture pair
-------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2007-2010 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:      dynshreg_i_f.vhd
--
-- Description:   This module implements a dynamic shift register with clock
--                enable. (Think, for example, of the function of the SRL16E.)
--                The width and depth of the shift register are selectable
--                via generics C_WIDTH and C_DEPTH, respectively. The C_FAMILY
--                allows the implementation to be tailored to the target
--                FPGA family. An inferred implementation is used if C_FAMILY
--                is "nofamily" (the default) or if synthesis will not produce
--                an optimal implementation.  Otherwise, a structural
--                implementation will be generated.
--
--                There is no restriction on the values of C_WIDTH and
--                C_DEPTH and, in particular, the C_DEPTH does not have
--                to be a power of two.
--
--                This version allows the client to specify the initial value
--                of the contents of the shift register, as applied
--                during configuration.
--
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
--      predecessor value by # clks:            "*_p#"

---(
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.UNSIGNED;
use     ieee.numeric_std.TO_INTEGER;
--
library lib_pkg_v1_0_2;
    use lib_pkg_v1_0_2.all;
    use lib_pkg_v1_0_2.lib_pkg.clog2;


--------------------------------------------------------------------------------
-- Explanations of generics and ports regarding aspects that may not be obvious.
--
-- C_DWIDTH
   --------
-- Theoretically, C_DWIDTH may be set to zero and this could be a more
-- natural or preferrable way of excluding a dynamic shift register
-- in a client than using a VHDL Generate statement. However, this usage is not
-- tested, and the user should expect that some VHDL tools will be deficient
-- with respect to handling this properly.
--
-- C_INIT_VALUE
   ---------------
-- C_INIT_VALUE can be used to specify the initial values of the elements
-- in the dynamic shift register, i.e. the values to be present after config-
-- uration. C_INIT_VALUE need not be the same size as the dynamic shift
-- register, i.e. C_DWIDTH*C_DEPTH. When smaller, C_INIT_VALUE
-- is replicated as many times as needed (possibly fractionally the last time)
-- to form a full initial value that is the size of the shift register.
-- So, if C_INIT_VALUE is left at its default value--an array of size one
-- whose value is '0'--the shift register will initialize with all bits at
-- all addresses set to '0'. This will also be the case if C_INIT_VALUE is a
-- null (size zero) array.
-- When determined according to the rules outlined above, the full
-- initial value is a std_logic_vector value from (0 to C_DWIDTH*C_DEPTH-1). It
-- is allocated to the addresses of the dynamic shift register in this
-- manner: The first C_DWIDTH values (i.e. 0 to C_CWIDTH-1) assigned to
-- the corresponding indices at address 0, the second C_DWIDTH values
-- assigned to address 1, and so forth.
-- Please note that the shift register is not resettable after configuration.
--
-- Addr
   ----
-- Addr addresses the elements of the dynamic shift register. Addr=0 causes
-- the most recently shifted-in element to appear at Dout, Addr=1
-- the second most recently shifted in element, etc. If C_DEPTH is not
-- a power of two, then not all of the values of Addr correspond to an
-- element in the shift register. When such an address is applied, the value
-- of Dout is undefined until a valid address is established.
--------------------------------------------------------------------------------
entity dynshreg_i_f is
  generic (
    C_DEPTH  : positive := 32;
    C_DWIDTH : natural := 1;
    C_INIT_VALUE : bit_vector := "0";
    C_FAMILY : string := "nofamily"
  );
  port (
    Clk   : in  std_logic;
    Clken : in  std_logic;
    Addr  : in  std_logic_vector(0 to clog2(C_DEPTH)-1);
    Din   : in  std_logic_vector(0 to C_DWIDTH-1);
    Dout  : out std_logic_vector(0 to C_DWIDTH-1)
  );
end dynshreg_i_f;


architecture behavioral of dynshreg_i_f is

  constant USE_INFERRED     : boolean := true;
    type     bv2sl_type is array(bit) of std_logic;
  constant bv2sl      : bv2sl_type := ('0' => '0', '1' => '1');
  function min(a, b: natural) return natural is
  begin
      if a<b then return a; else return b; end if;
  end min;

  --
  ------------------------------------------------------------------------------
  -- Function used to establish the full initial value. (See the comments for
  -- C_INIT_VALUE, above.)
  ------------------------------------------------------------------------------
  function full_initial_value(w : natural; d : positive; v : bit_vector
                             ) return bit_vector is
    variable r : bit_vector(0 to w*d-1);
    variable i, j : natural;
             -- i - the index where filling of r continues
             -- j - the amount to fill on the cur. iteration of the while loop
  begin
    if w = 0 then null;  -- Handle the case where the shift reg width is zero
    elsif v'length = 0 then r := (others => '0');
    else
      i := 0;
      while i /= r'length loop
          j := min(v'length, r'length-i);
          r(i to i+j-1) := v(0 to j-1);
          i := i+j;
      end loop;
    end if;
    return r;
  end full_initial_value;

  constant FULL_INIT_VAL : bit_vector(0 to C_DWIDTH*C_DEPTH -1)
                         := full_initial_value(C_DWIDTH, C_DEPTH, C_INIT_VALUE);

  -- As of I.32, XST is not infering optimal dynamic shift registers for
  -- depths not a power of two (by not taking advantage of don't care
  -- at output when address not within the range of the depth)
  -- or a power of two less than the native SRL depth (by building shift
  -- register out of discrete FFs and LUTs instead of SRLs).

 ---------------------------------------------------------------------------- 
 -- Unisim components declared locally for maximum avoidance of default
 -- binding and vcomponents version issues.
 ---------------------------------------------------------------------------- 


begin

  INFERRED_GEN : if USE_INFERRED = true generate
    --
    type dataType is array (0 to C_DEPTH-1) of std_logic_vector(0 to C_DWIDTH-1);
    --
    function fill_data(w: natural; d: positive; v: bit_vector
                      ) return dataType is
        variable r : dataType;
    begin
        for i in 0 to d-1 loop
           for j in 0 to w-1 loop
               r(i)(j) := bv2sl(v(i*w+j)); 
           end loop;
        end loop;
        return r;
    end fill_data;

    signal data: dataType := fill_data(C_DWIDTH, C_DEPTH, FULL_INIT_VAL);
    --
  begin
    process(Clk)
    begin
      if Clk'event and Clk = '1' then
        if Clken = '1' then
          data <= Din & data(0 to C_DEPTH-2);
        end if;
      end if;
    end process;

    Dout <= data(TO_INTEGER(UNSIGNED(Addr)))
                when (TO_INTEGER(UNSIGNED(Addr)) < C_DEPTH)
                else
            (others => '-');
  end generate INFERRED_GEN;
  ---)

end behavioral;
