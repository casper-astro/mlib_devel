-------------------------------------------------------------------------------
--
-- Copyright 2020
-- ASTRON (Netherlands Institute for Radio Astronomy) <http://www.astron.nl/>
-- P.O.Box 2, 7990 AA Dwingeloo, The Netherlands
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-------------------------------------------------------------------------------

-- Author:
-- . Daniel van der Schuur
-- Purpose:
-- . Collection of commonly used string funtions
-- Interface:
-- . [n/a]
-- Description:
-- . None

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE work.common_pkg.ALL;

PACKAGE common_str_pkg IS

	TYPE t_str_4_arr IS ARRAY (INTEGER RANGE <>) OF STRING(1 TO 4);

	FUNCTION nof_digits(number : NATURAL) RETURN NATURAL;
	FUNCTION nof_digits_int(number : INTEGER) RETURN NATURAL;

	FUNCTION time_to_str(in_time : TIME) RETURN STRING;
	FUNCTION str_to_time(in_str : STRING) RETURN TIME;
	FUNCTION slv_to_str(slv : STD_LOGIC_VECTOR) RETURN STRING;
	FUNCTION sl_to_str(sl : STD_LOGIC) RETURN STRING;
	FUNCTION str_to_hex(str : STRING) RETURN STRING;
	FUNCTION slv_to_hex(slv : STD_LOGIC_VECTOR) RETURN STRING;
	FUNCTION hex_to_slv(str : STRING) RETURN STD_LOGIC_VECTOR;

	Function hex_nibble_to_slv(c : character) return std_logic_vector;

	FUNCTION int_to_str(int : INTEGER) RETURN STRING;
	FUNCTION real_to_str(re : REAL; width : INTEGER; digits : INTEGER) RETURN STRING;

	PROCEDURE print_str(str : STRING);

	FUNCTION str_to_ascii_integer_arr(s : STRING) RETURN t_integer_arr;
	FUNCTION str_to_ascii_slv_8_arr(s : STRING) RETURN t_slv_8_arr;
	FUNCTION str_to_ascii_slv_32_arr(s : STRING) RETURN t_slv_32_arr;
	FUNCTION str_to_ascii_slv_32_arr(s : STRING; arr_size : NATURAL) RETURN t_slv_32_arr;

END common_str_pkg;

PACKAGE BODY common_str_pkg IS

	FUNCTION nof_digits(number : NATURAL) RETURN NATURAL IS
		-- Returns number of digits in a natural number. Only used in string processing, so defined here.
		-- log10(0) is not allowed so:
		-- . nof_digits(0) = 1
		-- We're adding 1 so:
		-- . nof_digits(1) = 1
		-- . nof_digits(9) = 1
		-- . nof_digits(10) = 2
	BEGIN
		IF number > 0 THEN
			RETURN floor_log10(number) + 1;
		ELSE
			RETURN 1;
		END IF;
	END;

	FUNCTION nof_digits_int(number : INTEGER) RETURN NATURAL IS
		-- Returns number of digits in a natural number. Only used in string processing, so defined here.
		-- log10(0) is not allowed so:
		-- . nof_digits(0) = 1
		-- We're adding 1 so:
		-- . nof_digits(1) = 1
		-- . nof_digits(9) = 1
		-- . nof_digits(10) = 2
		-- . nof_digits(1) = 2
	BEGIN
		IF number = 0 THEN
			RETURN 1;
		ELSE
			IF number > 0 THEN
				RETURN floor_log10(number) + 1;
			ELSE
				RETURN floor_log10(-1 * number) + 2;
			END IF;
		END IF;
	END;

	FUNCTION time_to_str(in_time : TIME) RETURN STRING IS
		CONSTANT c_max_len_time : NATURAL                     := 20;
		VARIABLE v_line         : LINE;
		VARIABLE v_str          : STRING(1 TO c_max_len_time) := (OTHERS => ' ');
	BEGIN
		write(v_line, in_time);
		v_str(v_line.ALL'RANGE) := v_line.ALL;
		deallocate(v_line);
		RETURN v_str;
	END;

	FUNCTION str_to_time(in_str : STRING) RETURN TIME IS
	BEGIN
		RETURN TIME'VALUE(in_str);
	END;

	FUNCTION slv_to_str(slv : STD_LOGIC_VECTOR) RETURN STRING IS
		VARIABLE v_line : LINE;
		VARIABLE v_str  : STRING(1 TO slv'LENGTH) := (OTHERS => ' ');
	BEGIN
		write(v_line, slv);
		v_str(v_line.ALL'RANGE) := v_line.ALL;
		deallocate(v_line);
		RETURN v_str;
	END;

	FUNCTION sl_to_str(sl : STD_LOGIC) RETURN STRING IS
		VARIABLE v_line : LINE;
		VARIABLE v_str  : STRING(1 TO 2) := (OTHERS => ' ');
	BEGIN
		write(v_line, sl);
		v_str(v_line.ALL'RANGE) := v_line.ALL;
		deallocate(v_line);
		RETURN v_str;
	END;

	FUNCTION str_to_hex(str : STRING) RETURN STRING IS
		CONSTANT c_nof_nibbles : NATURAL                             := ceil_div(str'LENGTH, c_nibble_w);
		VARIABLE v_nibble_arr  : t_str_4_arr(0 TO c_nof_nibbles - 1) := (OTHERS => (OTHERS => '0'));
		VARIABLE v_hex         : STRING(1 TO c_nof_nibbles)          := (OTHERS => '0');
	BEGIN
		FOR i IN 0 TO v_hex'RIGHT - 1 LOOP
			v_nibble_arr(i) := slice_up(str, c_nibble_w, i, '0');

			CASE v_nibble_arr(i) IS
				WHEN "0000" => v_hex(i + 1) := '0';
				WHEN "0001" => v_hex(i + 1) := '1';
				WHEN "0010" => v_hex(i + 1) := '2';
				WHEN "0011" => v_hex(i + 1) := '3';
				WHEN "0100" => v_hex(i + 1) := '4';
				WHEN "0101" => v_hex(i + 1) := '5';
				WHEN "0110" => v_hex(i + 1) := '6';
				WHEN "0111" => v_hex(i + 1) := '7';
				WHEN "1000" => v_hex(i + 1) := '8';
				WHEN "1001" => v_hex(i + 1) := '9';
				WHEN "1010" => v_hex(i + 1) := 'A';
				WHEN "1011" => v_hex(i + 1) := 'B';
				WHEN "1100" => v_hex(i + 1) := 'C';
				WHEN "1101" => v_hex(i + 1) := 'D';
				WHEN "1110" => v_hex(i + 1) := 'E';
				WHEN "1111" => v_hex(i + 1) := 'F';
				WHEN OTHERS => v_hex(i + 1) := 'X';
			END CASE;
		END LOOP;
		RETURN v_hex;
	END;

	FUNCTION slv_to_hex(slv : STD_LOGIC_VECTOR) RETURN STRING IS
	BEGIN
		RETURN str_to_hex(slv_to_str(slv));
	END;

	FUNCTION hex_to_slv(str : STRING) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_length : NATURAL                 := str'LENGTH;
		VARIABLE v_str    : STRING(1 TO str'LENGTH) := str; -- Keep local copy of str to prevent range mismatch
		VARIABLE v_result : STD_LOGIC_VECTOR(c_length * 4 - 1 DOWNTO 0);
	BEGIN
		FOR i IN c_length DOWNTO 1 LOOP
			v_result(3 + (c_length - i) * 4 DOWNTO (c_length - i) * 4) := hex_nibble_to_slv(v_str(i));
		END LOOP;
		RETURN v_result;
	END;

	FUNCTION hex_nibble_to_slv(c : CHARACTER) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_result : STD_LOGIC_VECTOR(3 DOWNTO 0);
	BEGIN
		CASE c IS
			WHEN '0' => v_result := "0000";
			WHEN '1' => v_result := "0001";
			WHEN '2' => v_result := "0010";
			WHEN '3' => v_result := "0011";
			WHEN '4' => v_result := "0100";
			WHEN '5' => v_result := "0101";
			WHEN '6' => v_result := "0110";
			WHEN '7' => v_result := "0111";
			WHEN '8' => v_result := "1000";
			WHEN '9' => v_result := "1001";
			WHEN 'A' => v_result := "1010";
			WHEN 'B' => v_result := "1011";
			WHEN 'C' => v_result := "1100";
			WHEN 'D' => v_result := "1101";
			WHEN 'E' => v_result := "1110";
			WHEN 'F' => v_result := "1111";
			WHEN 'a' => v_result := "1010";
			WHEN 'b' => v_result := "1011";
			WHEN 'c' => v_result := "1100";
			WHEN 'd' => v_result := "1101";
			WHEN 'e' => v_result := "1110";
			WHEN 'f' => v_result := "1111";
			WHEN 'x' => v_result := "XXXX";
			WHEN 'X' => v_result := "XXXX";
			WHEN 'z' => v_result := "ZZZZ";
			WHEN 'Z' => v_result := "ZZZZ";

			WHEN OTHERS => v_result := "0000";
		END CASE;
		RETURN v_result;
	END hex_nibble_to_slv;

	FUNCTION int_to_str(int : INTEGER) RETURN STRING IS
		VARIABLE v_line : LINE;
		VARIABLE v_str  : STRING(1 TO nof_digits_int(int)) := (OTHERS => ' ');
	BEGIN
		STD.TEXTIO.WRITE(v_line, int);
		v_str(v_line.ALL'RANGE) := v_line.ALL;
		deallocate(v_line);
		RETURN v_str;
	END;

	FUNCTION real_to_str(re : REAL; width : INTEGER; digits : INTEGER) RETURN STRING IS
		VARIABLE v_line : LINE;
		VARIABLE v_str  : STRING(1 TO width) := (OTHERS => ' ');
	BEGIN
		STD.TEXTIO.WRITE(v_line, re, right, width, digits);
		v_str(v_line.ALL'RANGE) := v_line.ALL;
		deallocate(v_line);
		RETURN v_str;
	END;

	PROCEDURE print_str(str : STRING) IS
		VARIABLE v_line : LINE;
	BEGIN
		write(v_line, str);
		writeline(output, v_line);
		deallocate(v_line);
	END;

	FUNCTION str_to_ascii_integer_arr(s : STRING) RETURN t_integer_arr IS
		VARIABLE r : t_integer_arr(0 TO s'RIGHT - 1);
	BEGIN
		FOR i IN s'RANGE LOOP
			r(i - 1) := CHARACTER'POS(s(i));
		END LOOP;
		RETURN r;
	END;

	FUNCTION str_to_ascii_slv_8_arr(s : STRING) RETURN t_slv_8_arr IS
		VARIABLE r : t_slv_8_arr(0 TO s'RIGHT - 1);
	BEGIN
		FOR i IN s'RANGE LOOP
			r(i - 1) := TO_UVEC(str_to_ascii_integer_arr(s)(i - 1), 8);
		END LOOP;
		RETURN r;
	END;

	-- Returns minimum array size required to fit the string
	FUNCTION str_to_ascii_slv_32_arr(s : STRING) RETURN t_slv_32_arr IS
		CONSTANT c_slv_8          : t_slv_8_arr(0 TO s'RIGHT - 1)                                 := str_to_ascii_slv_8_arr(s);
		CONSTANT c_bytes_per_word : NATURAL                                                       := 4;
		-- Initialize all elements to (OTHERS=>'0') so any unused bytes become a NULL character
		VARIABLE r                : t_slv_32_arr(0 TO ceil_div(s'RIGHT * c_byte_w, c_word_w) - 1) := (OTHERS => (OTHERS => '0'));
	BEGIN
		FOR word IN r'RANGE LOOP        --0, 1
			FOR byte IN 0 TO c_bytes_per_word - 1 LOOP -- 0,1,2,3
				IF byte + c_bytes_per_word * word <= c_slv_8'RIGHT THEN
					r(word)(byte * c_byte_w + c_byte_w - 1 DOWNTO byte * c_byte_w) := c_slv_8(byte + c_bytes_per_word * word);
				END IF;
			END LOOP;
		END LOOP;

		RETURN r;
	END;

	-- Overloaded version to match array size to arr_size
	FUNCTION str_to_ascii_slv_32_arr(s : STRING; arr_size : NATURAL) RETURN t_slv_32_arr IS
		CONSTANT slv_32 : t_slv_32_arr(0 TO ceil_div(s'RIGHT * c_byte_w, c_word_w) - 1) := str_to_ascii_slv_32_arr(s);
		VARIABLE r      : t_slv_32_arr(0 TO arr_size - 1)                               := (OTHERS => (OTHERS => '0'));
	BEGIN
		FOR word IN slv_32'RANGE LOOP
			r(word) := slv_32(word);
		END LOOP;
		RETURN r;
	END;

END common_str_pkg;
