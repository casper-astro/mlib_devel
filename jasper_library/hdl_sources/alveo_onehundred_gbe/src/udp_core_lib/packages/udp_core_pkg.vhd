-- <h---------------------------------------------------------------------------
--! @file   udp_core_pkg.vhd
--! @page udpcorepackagepage UDP Core Package File
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! General Package For UDP Core
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package udp_core_pkg is
    --------------------------------------------------------------------------------
    -- Constant Declarations:
    --------------------------------------------------------------------------------
    constant C_START_CHAR_8_10           : std_logic_vector(7 downto 0)                    := X"FB";
    constant C_START_CHAR_64_66          : std_logic_vector(7 downto 0)                    := X"FB";
    constant C_IDLE_CHAR_8_10            : std_logic_vector(7 downto 0)                    := X"BC";
    constant C_IDLE_CHAR_64_66           : std_logic_vector(7 downto 0)                    := X"07";
    constant C_CARRIER_EXTEND_8_10       : std_logic_vector(7 downto 0)                    := X"F7";
    constant C_TERMINATE_CHAR            : std_logic_vector(7 downto 0)                    := X"FD";
    constant C_PREAMBLE_BYTES            : integer                                         := 8; -- 1x 0xD5, 6x 0x55 + 1xFB (C_START_CHAR)
    constant C_PREAMBLE_CTRL_WORD        : std_logic_vector(C_PREAMBLE_BYTES - 1 downto 0) := X"01";
    constant C_MID_PREAMBLE_CTRL_WORD    : std_logic_vector(C_PREAMBLE_BYTES - 1 downto 0) := X"01";
    constant C_TOTAL_HEADER_LENGTH_BYTES : integer                                         := 42;
    constant C_FCS_BYTES                 : integer                                         := 4;
    constant C_MIN_IFG_BYTES             : integer                                         := 12; -- 1x 0xFD, 11x 0x07
    constant C_FIFO_MIN_WIDTH            : integer                                         := 5;
    constant C_MAX_PAYLOAD_SIZE          : integer                                         := 8192;

    -- Set the Number of Bytes from the Xilinx/Altera PHYs for DATA/CTRL:
    constant C_XIL_10G_NOF_BYTES : integer := 8;
    constant C_ALT_10G_NOF_BYTES : integer := 8;
    constant C_XIL_40G_NOF_BYTES : integer := 16;
    constant C_ALT_40G_NOF_BYTES : integer := 32;
    --------------------------------------------------------------------------------
    -- Type Declarations:
    --------------------------------------------------------------------------------
    constant C_MAX_MII_BYTES     : integer := 64;

    type t_mii_record is record
        data : std_logic_vector((C_MAX_MII_BYTES * 8) - 1 downto 0);
        ctrl : std_logic_vector(C_MAX_MII_BYTES - 1 downto 0);
    end record;

    type t_xgmii_record is record
        xgmii_d : std_logic_vector(C_MAX_MII_BYTES * 8 - 1 downto 0);
        xgmii_c : std_logic_vector(C_MAX_MII_BYTES - 1 downto 0);
        keep    : std_logic_vector(C_MAX_MII_BYTES - 1 downto 0);
        sof     : std_logic;
        eof     : std_logic;
        valid   : std_logic;
    end record;

    constant C_XGMII_RECORD_RST : t_xgmii_record := (
        xgmii_d => (others => '0'),
        xgmii_c => (others => '0'),
        keep    => (others => '0'),
        sof     => '0',
        eof     => '0',
        valid   => '0'
    );

    --------------------------------------------------------------------------------
    -- Function Declarations:
    --------------------------------------------------------------------------------
    function mii_idle(
        constant NUM_BYTES : in integer
    ) return std_logic_vector;

    function return_preamble(
        constant WIDTH_BYTES : in integer
    ) return std_logic_vector;

    function zeropad(
        constant SIZE : in integer
    ) return std_logic_vector;

    function eth_header_trailer_total_bytes(
        complete_words : in natural;
        partial_words  : in natural;
        mii_bytes      : in natural
    ) return natural;

    function header_words(
        header     : in natural;
        core_width : in natural
    ) return natural;

    function wider_preamble_packer(
        udp_core_nof_bytes_w : in natural
    ) return t_xgmii_record;

    function log_of_width(
        udp_core_width : in natural
    ) return integer;

    function ones_comp_add_16bit(
        signal input_1 : in std_logic_vector(15 downto 0);
        signal input_2 : in std_logic_vector(15 downto 0)
    ) return std_logic_vector;

    function udp_maximum(
        input_1 : in integer;
        input_2 : in integer
    ) return integer;

    function udp_minimum(
        input_1 : in integer;
        input_2 : in integer
    ) return integer;

    function tkeep_to_int(
        tkeep : in std_logic_vector
    ) return integer;

    function int_to_tkeep(
        last_byte : in integer;
        size      : in integer
     ) return std_logic_vector;

end package udp_core_pkg;

package body udp_core_pkg is

    --------------------------------------------------------------------------------
    function mii_idle(
        constant NUM_BYTES : in integer
    ) return std_logic_vector is

        variable idle_vector : std_logic_vector((NUM_BYTES * 8) - 1 downto 0);
        variable idle_char   : std_logic_vector(7 downto 0);

    begin
        if NUM_BYTES = 1 then
            idle_char := C_IDLE_CHAR_8_10;
        else
            idle_char := C_IDLE_CHAR_64_66;
        end if;

        for i in 0 to (NUM_BYTES - 1) loop
            idle_vector((i + 1) * 8 - 1 downto i * 8) := idle_char;
        end loop;
        return idle_vector;
    end function mii_idle;
    --------------------------------------------------------------------------------
    function return_preamble(
        constant WIDTH_BYTES : in integer
    ) return std_logic_vector is

        variable preamble_data_word : std_logic_vector(C_PREAMBLE_BYTES * 8 - 1 downto 0);

    begin
        if WIDTH_BYTES = 1 then
            preamble_data_word := X"D5555555555555" & C_START_CHAR_8_10;
        else
            preamble_data_word := X"D5555555555555" & C_START_CHAR_64_66;
        end if;

        return preamble_data_word;
    end function;

    --------------------------------------------------------------------------------
    function zeropad(
        constant SIZE : integer
    ) return std_logic_vector is
        variable zero_vector : std_logic_vector(SIZE - 1 downto 0) := (others => '0');
    begin
        return zero_vector;
    end function zeropad;

    --------------------------------------------------------------------------------
    function eth_header_trailer_total_bytes(
        complete_words : in natural;
        partial_words  : in natural;
        mii_bytes      : in natural
    ) return natural is

        variable total_bytes : natural := 0;

    begin
        if partial_words = 0 then
            total_bytes := complete_words * mii_bytes;
        else
            total_bytes := (complete_words + 1) * mii_bytes;
        end if;
        return total_bytes;
    end function eth_header_trailer_total_bytes;
    --------------------------------------------------------------------------------
    function header_words(
        header     : in natural;
        core_width : in natural
    ) return natural is
        variable hdr_words : natural := 0;

    begin
        if (header mod core_width) = 0 then
            hdr_words := header / core_width - 1;
        else
            hdr_words := header / core_width;
        end if;

        return hdr_words;
    end function;

    --------------------------------------------------------------------------------
    function wider_preamble_packer(
        udp_core_nof_bytes_w : in natural
    ) return t_xgmii_record is

        variable xgmii_preamble : t_xgmii_record := C_XGMII_RECORD_RST;

    begin
        xgmii_preamble.xgmii_d(udp_core_nof_bytes_w * 8 - 1 downto (udp_core_nof_bytes_w - C_PREAMBLE_BYTES) * 8) := return_preamble(udp_core_nof_bytes_w);
        xgmii_preamble.xgmii_d((udp_core_nof_bytes_w - C_PREAMBLE_BYTES) * 8 - 1 downto 0)                        := mii_idle(udp_core_nof_bytes_w - C_PREAMBLE_BYTES);
        xgmii_preamble.xgmii_c(udp_core_nof_bytes_w - 1 downto udp_core_nof_bytes_w - C_PREAMBLE_BYTES)           := (others => '0');
        xgmii_preamble.xgmii_c(udp_core_nof_bytes_w - C_PREAMBLE_BYTES - 1 downto 0)                              := (others => '1');

        return xgmii_preamble;

    end function wider_preamble_packer;

    --------------------------------------------------------------------------------
    function ones_comp_add_16bit(
        signal input_1 : in std_logic_vector(15 downto 0);
        signal input_2 : in std_logic_vector(15 downto 0)
    ) return std_logic_vector is
        variable sum1  : unsigned(16 downto 0);
        variable carry : unsigned(15 downto 0);
        variable sum2  : std_logic_vector(15 downto 0);
    begin
        sum1  := unsigned('0' & input_1) + unsigned('0' & input_2);
        carry := "000000000000000" & sum1(16);
        sum2  := std_logic_vector(carry + unsigned(sum1(15 downto 0)));

        return sum2;
    end function ones_comp_add_16bit;

    --------------------------------------------------------------------------------
    function log_of_width(
        udp_core_width : in natural
    ) return integer is
    begin
        case udp_core_width is
            when 64 =>
                return 6;
            when 32 =>
                return 5;
            when 16 =>
                return 4;
            when 8 =>
                return 3;
            when 4 =>
                return 2;
            when 2 =>
                return 1;
            when others =>
                return 0;
        end case;

    end function log_of_width;

    --------------------------------------------------------------------------------
    function udp_maximum(
        input_1 : in integer;
        input_2 : in integer
    ) return integer is
    begin
        if input_1 > input_2 then
            return input_1;
        else
            return input_2;
        end if;
    end function udp_maximum;

    --------------------------------------------------------------------------------
    function udp_minimum(
        input_1 : in integer;
        input_2 : in integer
    ) return integer is
    begin
        if input_1 < input_2 then
            return input_1;
        else
            return input_2;
        end if;
    end function udp_minimum;

    --------------------------------------------------------------------------------
    function tkeep_to_int(tkeep : in std_logic_vector) return integer is
        variable int_tmp : integer range 0 to tkeep'left;
    begin
        int_tmp := 0;
        for i in tkeep'left downto 0 loop
            if tkeep(i) = '1' then
                int_tmp := i;
                exit;
            end if;
        end loop;
        return int_tmp;
    end function;

    --------------------------------------------------------------------------------
    function int_to_tkeep(last_byte : in integer;
                          size      : in integer
                         ) return std_logic_vector is
        variable tmp_vec : std_logic_Vector(size - 1 downto 0);
    begin
        for i in 0 to size - 1 loop
            if last_byte >= i then
                tmp_vec(i) := '1';
            else
                tmp_vec(i) := '0';
            end if;
        end loop;
        return tmp_vec;
    end function;

end package body udp_core_pkg;
