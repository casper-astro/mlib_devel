--------------------------------------------------------------------------------
--! @file   serial_pipe.vhd
--! @brief  A variable length serial pipe-line.
--! <pre>
--! Science and Technology Facilities Council
--! Technology
--! Electronic System Design Group
--! </pre>
--! $URL: https://svn.ska.rl.ac.uk/svn/ska/libraries/lib_stfc/common_stfc/trunk/src/vhdl/serial_pipe.vhd $
--! $Date: 2016-05-24 18:51:50 +0100 (Tue, 24 May 2016) $
--! $Rev: 839 $
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serial_pipe is
    generic(
        SR_LEN              : integer := 1;
        SR_INIT             : std_logic := '0';
        SR_RST              : std_logic := '0';
        SR_EXT              : string := "false"
    );
    port( 
        clk                 : in    std_logic;
        rst_s_n             : in    std_logic;
        en                  : in    std_logic;
        serial_in           : in    std_logic;
        serial_out          : out   std_logic
    );
end entity serial_pipe;

architecture behavioral of serial_pipe is

signal shift_reg            : std_logic_vector(SR_LEN-1 downto 0) := (others => SR_INIT);

--------------------------------------------------------------------------------
--! Xilinx Synthesis Attributes (ignored by Altera Tools):
--! \todo Determine if there is an Altera equivalent for this attribute.
--------------------------------------------------------------------------------
attribute shift_extract     : string;
attribute shift_extract of shift_reg : signal is SR_EXT;

begin

    --! Shift register length is greater than one
    sr_gt1 :
    if(SR_LEN > 1) generate
    begin
        sr_gt1_proc : process(clk)
        begin  
            if(rising_edge(clk)) then
                if(rst_s_n = '0') then
                    shift_reg <= (others => SR_RST);
                elsif(en = '1') then
                    shift_reg <= serial_in & shift_reg(SR_LEN-1 downto 1);
                end if;
            end if;
        end process sr_gt1_proc;
        serial_out <= shift_reg(0);
    end generate sr_gt1;

    --! Shift register length is equal to one
    sr_eq1 :
    if(SR_LEN = 1) generate
    begin
        sr_eq1_proc : process(clk)
        begin  
            if(rising_edge(clk)) then
                if(rst_s_n = '0') then
                    serial_out <= SR_RST;
                elsif(en = '1') then
                    serial_out <= serial_in;
                end if;
            end if;
        end process sr_eq1_proc;
    end generate sr_eq1;

    --! Shift register length is zero = No register!
    sr_eq0 :
    if(SR_LEN = 0) generate
    begin
        serial_out <= serial_in;
    end generate sr_eq0;

end architecture behavioral;

