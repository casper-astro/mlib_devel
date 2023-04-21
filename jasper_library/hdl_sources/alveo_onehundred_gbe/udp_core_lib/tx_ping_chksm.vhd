-- <h---------------------------------------------------------------------------
--! @file tx_ping_chksm.vhd
--! @page txpingchksmpage Tx Ping Checksum
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Calculates Ping checksum for Data Widths larger than 1 Byte. Uses pyramid
--! structure of ones complement adders depending on how large the data bus is.
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

entity tx_ping_chksm is
    generic(
        G_UDP_CORE_WIDTH    : integer := 8                                              --! Width of Data bus in Bytes
    );
    port(
        clk                 : in  std_logic;                                            --! Clk
        rst_s_n             : in  std_logic;                                            --! Active Low synchronous reset
        data_in             : in  std_logic_vector(G_UDP_CORE_WIDTH * 8 - 1 downto 0);  --! Ping Data in
        width_in            : in  std_logic_vector(G_UDP_CORE_WIDTH - 1 downto 0);      --! Width of Valid Data
        valid               : in  std_logic;                                            --! Ping Valid
        sof                 : in  std_logic;                                            --! Start of Packet
        eof                 : in  std_logic;                                            --! End of Packet
        done                : out std_logic;                                            --! Calculations Finished
        out_chksm           : out std_logic_vector(15 downto 0)                         --! Checksum Out
    );
end entity tx_ping_chksm;

architecture behavioural of tx_ping_chksm is
    constant C_NUMBER_OF_LEVELS : integer := udp_maximum(log_of_width(G_UDP_CORE_WIDTH) - 1, 1);
    constant C_SUM_REGISTERS    : integer := udp_maximum(1, G_UDP_CORE_WIDTH / 2 - 1);

    constant C_16BIT_WORDS : integer := G_UDP_CORE_WIDTH / 2;
    constant C_LAYER_1_REG : integer := C_16BIT_WORDS / 2;
    constant C_LAYER_2_REG : integer := C_LAYER_1_REG / 2;
    constant C_LAYER_3_REG : integer := C_LAYER_2_REG / 2;
    constant C_LAYER_4_REG : integer := C_LAYER_3_REG / 2;

    constant C_LAST_REG : integer := C_16BIT_WORDS - 2;

    type t_tx_ping_chksm_next_state is (
        idle,
        calculating,
        finished
    );

    type t_sum_reg is array (0 to C_SUM_REGISTERS) of std_logic_vector(15 downto 0);
    signal sum_reg      : t_sum_reg;
    type t_16_bit is array (0 to C_16BIT_WORDS - 1) of std_logic_vector(15 downto 0);
    signal s_16_bit_reg : t_16_bit;
    signal prev_sum     : std_logic_vector(15 downto 0);

    signal tx_ping_chksm_next_state : t_tx_ping_chksm_next_state := idle;

    signal valid_pipe : std_logic_vector(C_NUMBER_OF_LEVELS downto 0);
    signal eof_pipe   : std_logic_vector(C_NUMBER_OF_LEVELS downto 0);

begin

    out_chksm <= prev_sum;

    fsm_proc : process(clk)
        variable sum_int : unsigned(16 downto 0);

    begin
        if (rising_edge(clk)) then
            if (rst_s_n = '0') then
                s_16_bit_reg <= (others => (others => '0'));
                sum_reg      <= (others => (others => '0'));
                prev_sum     <= (others => '0');
                done         <= '0';
                eof_pipe     <= (others => '0');
                valid_pipe   <= (others => '0');
            else
                case (tx_ping_chksm_next_state) is
                    when idle =>
                        if (valid = '1' and sof = '1') then
                            valid_pipe                     <= (others => '0');
                            valid_pipe(C_NUMBER_OF_LEVELS) <= '1';
                            eof_pipe                       <= (others => '0');
                            eof_pipe(C_NUMBER_OF_LEVELS)   <= eof;

                            --Read Data into 16 bit registers, if the byte isn't valid data set to 0s
                            for i in 0 to C_16BIT_WORDS - 1 loop
                                --s_16_bit_reg(i) <= ((7 downto 0 => (width_in(i*2+1))) & (7 downto 0 => (width_in(i*2)))) and  (data_in(16*(1+i) - 1 downto 16*i)); Doesn't pass dont know why
                                s_16_bit_reg(i) <= (width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2)) and data_in(16 * (1 + i) - 1 downto 16 * i);

                            end loop;

                            tx_ping_chksm_next_state <= calculating;
                        end if;

                    when calculating =>
                        valid_pipe <= valid & valid_pipe(C_NUMBER_OF_LEVELS downto 1);
                        eof_pipe   <= eof & eof_pipe(C_NUMBER_OF_LEVELS downto 1);

                        --Read Data into 16 bit registers, if the byte isn't valid data set to 0s
                        if (valid = '1') then
                            for i in 0 to C_16BIT_WORDS - 1 loop
                                s_16_bit_reg(i) <= (width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2 + 1) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2) & width_in(i * 2)) and data_in(16 * (1 + i) - 1 downto 16 * i);
                            end loop;
                        end if;

                        --Ones Complement sum 16 bit registers into layer 1 registers
                        if (valid_pipe(C_NUMBER_OF_LEVELS) = '1') then
                            for i in 0 to C_LAYER_1_REG - 1 loop
                                sum_int    := unsigned('0' & s_16_bit_reg(2 * i + 1)) + unsigned('0' & s_16_bit_reg(2 * i));
                                sum_reg(i) <= std_logic_vector("000000000000000" & sum_int(16) + sum_int(15 downto 0));
                            end loop;
                        end if;

                        --For Widths = 8 or more, ones complement sum layer 1 registers into layer 2 registers
                        if C_NUMBER_OF_LEVELS > 1 and valid_pipe(C_NUMBER_OF_LEVELS - 1) = '1' then
                            for reg in 0 to C_LAYER_2_REG - 1 loop
                                sum_int                      := unsigned('0' & sum_reg(2 * reg + 1)) + unsigned('0' & sum_reg(2 * reg));
                                sum_reg(C_LAYER_1_REG + reg) <= std_logic_vector("000000000000000" & sum_int(16) + sum_int(15 downto 0));
                            end loop;
                        end if;

                        --For Widths = 16 or more, ones complement sum layer 2 registers into layer 3 registers
                        if C_NUMBER_OF_LEVELS > 2 and valid_pipe(C_NUMBER_OF_LEVELS - 2) = '1' then
                            for reg in 0 to C_LAYER_3_REG - 1 loop
                                sum_int                                      := unsigned('0' & sum_reg(2 * reg + C_LAYER_1_REG + 1)) + unsigned('0' & sum_reg(2 * reg + C_LAYER_1_REG));
                                sum_reg(C_LAYER_1_REG + C_LAYER_2_REG + reg) <= std_logic_vector("000000000000000" & sum_int(16) + sum_int(15 downto 0));
                            end loop;
                        end if;

                        --For Widths = 32 or more, ones complement sum layer 3 registers into layer 4 registers
                        if C_NUMBER_OF_LEVELS > 3 and valid_pipe(C_NUMBER_OF_LEVELS - 3) = '1' then
                            for reg in 0 to C_LAYER_4_REG - 1 loop
                                sum_int                                                      := unsigned('0' & sum_reg(2 * reg + C_LAYER_1_REG + C_LAYER_2_REG + 1)) + unsigned('0' & sum_reg(2 * reg + C_LAYER_1_REG + C_LAYER_2_REG));
                                sum_reg(C_LAYER_1_REG + C_LAYER_2_REG + C_LAYER_3_REG + reg) <= std_logic_vector("000000000000000" & sum_int(16) + sum_int(15 downto 0));
                            end loop;
                        end if;

                        --For Widths = 64 ones complement sum layer 4 registers into layer 5 registers
                        if C_NUMBER_OF_LEVELS > 4 and valid_pipe(C_NUMBER_OF_LEVELS - 4) = '1' then

                            sum_int                                                                := unsigned('0' & sum_reg(C_LAYER_1_REG + C_LAYER_2_REG + C_LAYER_3_REG + 1)) + unsigned('0' & sum_reg(C_LAYER_1_REG + C_LAYER_2_REG + C_LAYER_3_REG));
                            sum_reg(C_LAYER_1_REG + C_LAYER_2_REG + C_LAYER_3_REG + C_LAYER_4_REG) <= std_logic_vector("000000000000000" & sum_int(16) + sum_int(15 downto 0));

                        end if;

                        if valid_pipe(0) = '1' then
                            prev_sum <= ones_comp_add_16bit(prev_sum, sum_reg(C_LAST_REG));
                        end if;

                        if eof_pipe(0) = '1' then
                            done                     <= '1';
                            tx_ping_chksm_next_state <= finished;
                        end if;

                    when finished =>
                        tx_ping_chksm_next_state <= idle;
                        done                     <= '0';
                        s_16_bit_reg             <= (others => (others => '0'));
                        sum_reg                  <= (others => (others => '0'));
                        prev_sum                 <= (others => '0');
                        eof_pipe                 <= (others => '0');
                        valid_pipe               <= (others => '0');

                end case;
            end if;
        end if;

    end process;

end architecture behavioural;
