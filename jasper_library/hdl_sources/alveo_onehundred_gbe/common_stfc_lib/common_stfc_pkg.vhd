-- <h---------------------------------------------------------------------------
--! @file   common_stfc_pkg.vhd
--!
--! ### Brief ###
--! VHDL Package File for lib_stfc Common STFC library
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common_stfc_pkg is

    --------------------------------------------------------------------------------
    --! Function Declarations:
    --------------------------------------------------------------------------------
    function log_2_ceil(
        count : integer
    ) return integer;

    function vec2int(
        input_vector : std_logic_vector
    ) return integer;

    function int2uvec(
        input_vector : integer;
        size         : integer
    ) return std_logic_vector;

    function byte_reverse(
        input_vector : std_logic_vector
    ) return std_logic_vector;

    function common_min(
        l : integer;
        r : integer
    ) return integer;

    function common_max(
        l : integer;
        r : integer
    ) return integer;

    function common_log2(
        val : integer
    ) return integer;

    function dec2bytemask(
        dec       : std_logic_vector;
        nof_bytes : integer
    ) return std_logic_vector;

    function bytemask2dec(
        bytemask  : std_logic_vector;
        nof_bytes : integer
    ) return std_logic_vector;

    function sel_if_true(
        constant EVALUATE : in boolean;
        constant IF_TRUE  : in integer;
        constant IF_FALSE : in integer
    ) return integer;

    function set_tkeep_from_last_int(
        constant size     : integer;
        signal   last_int : integer) return std_logic_vector;

    function get_last_int_from_tkeep(
        constant size  : integer;
        signal   tkeep : std_logic_vector) return integer;

    function priority_encoder_int_out(
        constant size      : integer;
        signal   input_vec : std_logic_vector
    ) return integer;

end package common_stfc_pkg;

package body common_stfc_pkg is

    function log_2_ceil(count : integer) return integer is -- COUNT should be >0
        variable tmp, count_tmp : INTEGER;
    begin
        tmp       := 0;
        count_tmp := count;

        while count_tmp > 1 loop
            tmp       := tmp + 1;
            count_tmp := count_tmp / 2;
        end loop;

        if count > 2 ** tmp then
            tmp := tmp + 1;
        end if;

        return tmp;
    end;

    function vec2int(
        input_vector : std_logic_vector
    ) return integer is
        variable int_tmp : integer range 0 to 2 ** input_vector'length;
    begin
        int_tmp := to_integer(unsigned(input_vector));
        return int_tmp;
    end function;

    function int2uvec(
        input_vector : integer;
        size         : integer
    ) return std_logic_vector is
        variable vec_tmp : std_logic_vector(size - 1 downto 0);
    begin
        vec_tmp := std_logic_vector(to_unsigned(input_vector, size));
        return vec_tmp;
    end function;

    --! @brief        Reverses each of the Bytes from LSB to MSB of a std_logic_vector
    --! @param[in]    input_vector        std_loigc_vector to perform the byte reverse on
    --! @return                           Returns a std_logic_vector where each byte from LSB to MSB has been reversed
    function byte_reverse(
        input_vector : std_logic_vector
    ) return std_logic_vector is

        variable output_vector : std_logic_vector(input_vector'high downto 0);
        variable a             : integer;
        variable b             : integer;
        variable c             : integer;
        variable d             : integer;
        constant NUM_BYTES     : integer := input_vector'length / 8;

    begin
        for i in 0 to (NUM_BYTES - 1) loop
            d                         := 8 * NUM_BYTES - i * 8 - 1;
            c                         := 8 * NUM_BYTES - i * 8 - 8;
            b                         := i * 8 + 7;
            a                         := i * 8;
            output_vector(d downto c) := input_vector(b downto a);
        end loop;
        return output_vector;
    end function byte_reverse;
    --------------------------------------------------------------------------------
    --! @brief        Takes two integers and returns the greater integer
    --! @param[in]    l        left-side integer
    --! @param[in]    r        right-side integer
    --! @return                Returns the greater integer of either l or r
    function common_max(
        l : integer;
        r : integer
    ) return integer is

    begin
        if (l > r) then
            return l;
        else
            return r;
        end if;
    end function common_max;
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    --! @brief        Takes two integers and returns the lesser integer
    --! @param[in]    l        left-side integer
    --! @param[in]    r        right-side integer
    --! @return                Returns the lesser integer of either l or r
    function common_min(
        l : integer;
        r : integer
    ) return integer is

    begin
        if (l < r) then
            return l;
        else
            return r;
        end if;
    end function common_min;
    --------------------------------------------------------------------------------
    --! @brief        Calculates the Binary Logarithm \f$log_2(val)\f$
    --! @param[in]    val      typically the integer std_vector_logic'length (max 32 bit wide)
    --! @return                Log base 2 of val
    -- function common_log2(
    -- val                             : integer
    -- ) return natural is

    -- variable res : natural;
    -- begin
    -- for i in 0 to 31 loop
    -- if(val <= (2**i)) then
    -- RES := i;
    -- exit;
    -- end if;
    -- end loop;
    -- return res;
    -- end function common_log2;

    function common_log2(
        val : integer
    ) return integer is

        variable temp, res : integer;
    begin
        temp := val;
        res  := 0;
        while (temp /= 0) loop
            temp := temp / 2;
            res  := res + 1;
        end loop;
        return res;
    end function common_log2;
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    function dec2bytemask(
        dec       : std_logic_vector;
        nof_bytes : integer
    ) return std_logic_vector is

        variable index           : integer                                  := to_integer(unsigned(dec));
        variable mask_0          : std_logic_vector(nof_bytes - 1 downto 0) := (others => '0');
        variable mask_1          : std_logic_vector(nof_bytes - 1 downto 0) := (others => '1');
        variable calculated_mask : std_logic_vector(nof_bytes - 1 downto 0) := (others => '0');
    begin
        if index > nof_bytes - 1 then
            report "dec2bytemask Error: dec > nof_bytes" severity error;
            calculated_mask := mask_1;
        elsif index = 0 then
            calculated_mask := mask_0;
        else
            calc_loop : for i in 1 to nof_bytes - 1 loop
                if index = i then
                    calculated_mask := mask_0(nof_bytes - 1 downto i) & mask_1(i - 1 downto 0);
                end if;
            end loop calc_loop;
        end if;

        return calculated_mask;

    end function dec2bytemask;
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    function bytemask2dec(
        bytemask  : std_logic_vector;
        nof_bytes : integer
    ) return std_logic_vector is

    begin

        return std_logic_vector(to_unsigned(common_log2(to_integer(unsigned(bytemask))), nof_bytes));

    end function bytemask2dec;

    --------------------------------------------------------------------------------

    function sel_if_true(
        constant EVALUATE : in boolean;
        constant IF_TRUE  : in integer;
        constant IF_FALSE : in integer
    ) return integer is
    begin
        if EVALUATE then
            return IF_TRUE;
        else
            return IF_FALSE;
        end if;
    end function;

    function set_tkeep_from_last_int(
        constant size     : integer;
        signal   last_int : integer
    ) return std_logic_vector is
        variable tkeep_out : std_logic_vector(size - 1 downto 0);
    begin
        for i in 0 to size - 1 loop
            if last_int >= size then
                tkeep_out(i) := '1';
            else
                tkeep_out(i) := '0';
            end if;
        end loop;
        return tkeep_out;
    end function;

    function get_last_int_from_tkeep(
        constant size  : integer;
        signal   tkeep : std_logic_vector
    ) return integer is
        variable last_int : integer range 0 to size - 1;
    begin
        last_int := 0;
        for i in 1 to size - 1 loop
            if tkeep(i) = '1' then
                last_int := last_int + 1;
            end if;
        end loop;
        return last_int;
    end function;

    function priority_encoder_int_out(
        constant size      : integer;
        signal   input_vec : std_logic_vector
    ) return integer is
        variable int_out : integer range 0 to size;
    begin
        int_out := 0;
        for i in 0 to size - 1 loop
            if input_vec(i) = '1' then
                int_out := i + 1;
            end if;
        end loop;
        return int_out;
    end function;

end package body common_stfc_pkg;
