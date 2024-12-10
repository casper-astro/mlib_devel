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
-- . Eric Kooistra
-- . Talon Myburgh
-- Purpose:
-- . Collection of commonly used base funtions
-- Interface:
-- . [n/a]
-- Description:
-- . This is a package containing generic constants and functions.
-- . More information can be found in the comments near the code.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;
use work.common_fixed_float_types.all;
use work.fixed_pkg.all;

PACKAGE common_pkg IS

	-- CONSTANT DECLARATIONS ----------------------------------------------------

	-- some integers
	CONSTANT c_0    : NATURAL := 0;
	CONSTANT c_zero : NATURAL := 0;
	CONSTANT c_1    : NATURAL := 1;
	CONSTANT c_one  : NATURAL := 1;
	CONSTANT c_2    : NATURAL := 2;
	CONSTANT c_4    : NATURAL := 4;
	CONSTANT c_quad : NATURAL := 4;
	CONSTANT c_8    : NATURAL := 8;
	CONSTANT c_16   : NATURAL := 16;
	CONSTANT c_32   : NATURAL := 32;
	CONSTANT c_64   : NATURAL := 64;
	CONSTANT c_128  : NATURAL := 128;
	CONSTANT c_256  : NATURAL := 256;

	-- widths and sizes
	CONSTANT c_halfword_sz : NATURAL := 2;
	CONSTANT c_word_sz     : NATURAL := 4;
	CONSTANT c_longword_sz : NATURAL := 8;
	CONSTANT c_nibble_w    : NATURAL := 4;
	CONSTANT c_byte_w      : NATURAL := 8;
	CONSTANT c_octet_w     : NATURAL := 8;
	CONSTANT c_halfword_w  : NATURAL := c_byte_w * c_halfword_sz;
	CONSTANT c_word_w      : NATURAL := c_byte_w * c_word_sz;
	CONSTANT c_integer_w   : NATURAL := 32; -- unfortunately VHDL integer type is limited to 32 bit values
	CONSTANT c_natural_w   : NATURAL := c_integer_w - 1; -- unfortunately VHDL natural type is limited to 31 bit values (0 and the positive subset of the VHDL integer type0
	CONSTANT c_longword_w  : NATURAL := c_byte_w * c_longword_sz;

	-- logic
	CONSTANT c_sl0        : STD_LOGIC                      := '0';
	CONSTANT c_sl1        : STD_LOGIC                      := '1';
	CONSTANT c_unsigned_0 : UNSIGNED(0 DOWNTO 0)           := TO_UNSIGNED(0, 1);
	CONSTANT c_unsigned_1 : UNSIGNED(0 DOWNTO 0)           := TO_UNSIGNED(1, 1);
	CONSTANT c_signed_0   : SIGNED(1 DOWNTO 0)             := TO_SIGNED(0, 2);
	CONSTANT c_signed_1   : SIGNED(1 DOWNTO 0)             := TO_SIGNED(1, 2);
	CONSTANT c_slv0       : STD_LOGIC_VECTOR(255 DOWNTO 0) := (OTHERS => '0');
	CONSTANT c_slv1       : STD_LOGIC_VECTOR(255 DOWNTO 0) := (OTHERS => '1');
	CONSTANT c_word_01    : STD_LOGIC_VECTOR(31 DOWNTO 0)  := "01010101010101010101010101010101";
	CONSTANT c_word_10    : STD_LOGIC_VECTOR(31 DOWNTO 0)  := "10101010101010101010101010101010";
	CONSTANT c_slv01      : STD_LOGIC_VECTOR(255 DOWNTO 0) := c_word_01 & c_word_01 & c_word_01 & c_word_01 & c_word_01 & c_word_01 & c_word_01 & c_word_01;
	CONSTANT c_slv10      : STD_LOGIC_VECTOR(255 DOWNTO 0) := c_word_10 & c_word_10 & c_word_10 & c_word_10 & c_word_10 & c_word_10 & c_word_10 & c_word_10;

	-- math
	CONSTANT c_nof_complex   : NATURAL := 2; -- Real and imaginary part of complex number
	CONSTANT c_sign_w        : NATURAL := 1; -- Sign bit, can be used to skip one of the double sign bits of a product
	CONSTANT c_sum_of_prod_w : NATURAL := 1; -- Bit growth for sum of 2 products, can be used in case complex multiply has normalized real and imag inputs instead of normalized amplitude inputs

	-- FF, block RAM, FIFO
	CONSTANT c_meta_delay_len  : NATURAL := 3; -- default nof flipflops (FF) in meta stability recovery delay line (e.g. for clock domain crossing)
	CONSTANT c_meta_fifo_depth : NATURAL := 16; -- default use 16 word deep FIFO to cross clock domain, typically > 2*c_meta_delay_len or >~ 8 is enough

	CONSTANT c_bram_m9k_nof_bits   : NATURAL := 1024 * 9; -- size of 1 Altera M9K block RAM in bits
	CONSTANT c_bram_m9k_max_w      : NATURAL := 36; -- maximum width of 1 Altera M9K block RAM, so the size is then 256 words of 36 bits
	CONSTANT c_bram_m9k_fifo_depth : NATURAL := c_bram_m9k_nof_bits / c_bram_m9k_max_w; -- using a smaller FIFO depth than this leaves part of the RAM unused

	CONSTANT c_fifo_afull_margin : NATURAL := 4; -- default or minimal FIFO almost full margin

	-- DSP
	CONSTANT c_dsp_mult_w : NATURAL := 18; -- Width of the embedded multipliers in Stratix IV

	-- TYPE DECLARATIONS --------------------------------------------------------
	TYPE t_boolean_arr IS ARRAY (INTEGER RANGE <>) OF BOOLEAN; -- INTEGER left index starts default at -2**31
	TYPE t_integer_arr IS ARRAY (INTEGER RANGE <>) OF INTEGER; -- INTEGER left index starts default at -2**31
	TYPE t_natural_arr IS ARRAY (INTEGER RANGE <>) OF NATURAL; -- INTEGER left index starts default at -2**31
	TYPE t_nat_boolean_arr IS ARRAY (NATURAL RANGE <>) OF BOOLEAN; -- NATURAL left index starts default at 0
	TYPE t_nat_integer_arr IS ARRAY (NATURAL RANGE <>) OF INTEGER; -- NATURAL left index starts default at 0
	TYPE t_nat_natural_arr IS ARRAY (NATURAL RANGE <>) OF NATURAL; -- NATURAL left index starts default at 0
	TYPE t_sl_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC;
	TYPE t_slv_1_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(0 DOWNTO 0);
	TYPE t_slv_2_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(1 DOWNTO 0);
	TYPE t_slv_4_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
	TYPE t_slv_8_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	TYPE t_slv_12_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(11 DOWNTO 0);
	TYPE t_slv_16_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	TYPE t_slv_18_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(17 DOWNTO 0);
	TYPE t_slv_24_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
	TYPE t_slv_32_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	TYPE t_slv_44_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(43 DOWNTO 0);
	TYPE t_slv_48_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(47 DOWNTO 0);
	TYPE t_signed_48_arr IS ARRAY (INTEGER RANGE <>) OF SIGNED(47 DOWNTO 0);
	TYPE t_slv_64_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
	TYPE t_signed_96_arr IS ARRAY (INTEGER RANGE <>) OF SIGNED(95 DOWNTO 0);
	TYPE t_slv_128_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(127 DOWNTO 0);
	TYPE t_slv_256_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(255 DOWNTO 0);
	TYPE t_slv_512_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(511 DOWNTO 0);
	TYPE t_slv_1024_arr IS ARRAY (INTEGER RANGE <>) OF STD_LOGIC_VECTOR(1023 DOWNTO 0);
	--type t_unsigned_array is array(natural range <>)    of unsigned;
	--type t_slv_array is array(natural range <>)         of std_logic_vector;
	--type t_signed_array is array(natural range <>)      of signed;
	TYPE t_rounding_mode is (TRUNCATE, ROUND, ROUNDINF);

	CONSTANT c_boolean_arr     : t_boolean_arr     := (TRUE, FALSE); -- array all possible values that can be iterated over
	CONSTANT c_nat_boolean_arr : t_nat_boolean_arr := (TRUE, FALSE); -- array all possible values that can be iterated over

	TYPE t_natural_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF NATURAL;
	TYPE t_integer_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF INTEGER;
	TYPE t_nat_integer_matrix IS ARRAY (NATURAL RANGE <>, NATURAL RANGE <>) OF INTEGER;
	TYPE t_boolean_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF BOOLEAN;
	TYPE t_sl_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF STD_LOGIC;
	TYPE t_slv_8_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	TYPE t_slv_16_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	TYPE t_slv_32_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	TYPE t_slv_64_matrix IS ARRAY (INTEGER RANGE <>, INTEGER RANGE <>) OF STD_LOGIC_VECTOR(63 DOWNTO 0);

	TYPE t_natural_2arr_2 IS ARRAY (INTEGER RANGE <>) OF t_natural_arr(1 DOWNTO 0);

	-- STRUCTURE DECLARATIONS ---------------------------------------------------

	-- Clock and Reset
	--
	-- . rst   = Reset. Can be used asynchronously to take effect immediately
	--           when used before the clk'EVENT section. May also be used as
	--           synchronous reset using it as first condition in the clk'EVENT
	--           section. As synchronous reset it requires clock activity to take
	--           effect. A synchronous rst may or may not depend on clken,
	--           however typically rst should take priority over clken.
	-- . clk   = Clock. Used in clk'EVENT line via rising_edge(clk) or sometimes
	--           as falling_edge(clk).
	-- . clken = Clock Enable. Used for the whole clk'EVENT section.
	TYPE t_sys_rce IS RECORD
		rst   : STD_LOGIC;
		clk   : STD_LOGIC;
		clken : STD_LOGIC;              -- := '1';
	END RECORD;

	TYPE t_sys_ce IS RECORD
		clk   : STD_LOGIC;
		clken : STD_LOGIC;              -- := '1';
	END RECORD;

	-- FUNCTION DECLARATIONS ----------------------------------------------------

	-- All functions assume [high downto low] input ranges

	FUNCTION pow2(n : NATURAL) RETURN NATURAL; -- = 2**n
	FUNCTION ceil_pow2(n : INTEGER) RETURN NATURAL; -- = 2**n, returns 1 for n<0

	FUNCTION true_log2(n : NATURAL) RETURN NATURAL; -- true_log2(n) = log2(n)
	FUNCTION ceil_log2(n : NATURAL) RETURN NATURAL; -- ceil_log2(n) = log2(n), but force ceil_log2(1) = 1
	FUNCTION next_pow2(n : NATURAL) RETURN NATURAL; -- next_pow2(n) = next power of two that is >= n

	FUNCTION floor_log10(n : NATURAL) RETURN NATURAL;

	FUNCTION is_pow2(n : NATURAL) RETURN BOOLEAN; -- return TRUE when n is a power of 2, so 0, 1, 2, 4, 8, 16, ...
	FUNCTION true_log_pow2(n : NATURAL) RETURN NATURAL; -- 2**true_log2(n), return power of 2 that is >= n

	FUNCTION ratio(n, d : NATURAL) RETURN NATURAL; -- return n/d when n MOD d = 0 else return 0, so ratio * d = n only when integer ratio > 0
	FUNCTION ratio2(n, m : NATURAL) RETURN NATURAL; -- return integer ratio of n/m or m/n, whichever is the largest

	FUNCTION ceil_div(n, d : NATURAL) RETURN NATURAL; -- ceil_div    = n/d + (n MOD d)/=0
	FUNCTION ceil_value(n, d : NATURAL) RETURN NATURAL; -- ceil_value  = ceil_div(n, d) * d
	FUNCTION floor_value(n, d : NATURAL) RETURN NATURAL; -- floor_value = (n/d) * d
	FUNCTION ceil_div(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED;
	FUNCTION ceil_value(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED;
	FUNCTION floor_value(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED;

	FUNCTION slv(n : IN STD_LOGIC) RETURN STD_LOGIC_VECTOR; -- standard logic to 1 element standard logic vector
	FUNCTION sl(n : IN STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- 1 element standard logic vector to standard logic

	FUNCTION to_natural_arr(n : t_integer_arr; to_zero : BOOLEAN) RETURN t_natural_arr; -- if to_zero=TRUE then negative numbers are forced to zero, otherwise they will give a compile range error
	FUNCTION to_natural_arr(n : t_nat_natural_arr) RETURN t_natural_arr;
	FUNCTION to_integer_arr(n : t_natural_arr) RETURN t_integer_arr;
	FUNCTION to_integer_arr(n : t_nat_natural_arr) RETURN t_integer_arr;
	FUNCTION to_slv_32_arr(n : t_integer_arr) RETURN t_slv_32_arr;
	FUNCTION to_slv_32_arr(n : t_natural_arr) RETURN t_slv_32_arr;

	FUNCTION vector_tree(slv : STD_LOGIC_VECTOR; operation : STRING) RETURN STD_LOGIC; -- Core operation tree function for vector "AND", "OR", "XOR"
	FUNCTION vector_and(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- '1' when all slv bits are '1' else '0'
	FUNCTION vector_or(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- '0' when all slv bits are '0' else '1'
	FUNCTION vector_xor(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- '1' when the slv has an odd number of '1' bits else '0'
	FUNCTION vector_one_hot(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- Returns slv when it contains one hot bit, else returns 0.

	FUNCTION andv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- alias of vector_and
	FUNCTION orv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- alias of vector_or
	FUNCTION xorv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- alias of vector_xor

	FUNCTION matrix_and(mat : t_sl_matrix; wi, wj : NATURAL) RETURN STD_LOGIC; -- '1' when all matrix bits are '1' else '0'
	FUNCTION matrix_or(mat : t_sl_matrix; wi, wj : NATURAL) RETURN STD_LOGIC; -- '0' when all matrix bits are '0' else '1'

	FUNCTION smallest(n, m : INTEGER) RETURN INTEGER;
	FUNCTION smallest(n, m, l : INTEGER) RETURN INTEGER;
	FUNCTION smallest(n : t_natural_arr) RETURN NATURAL;

	FUNCTION largest(n, m : INTEGER) RETURN INTEGER;
	FUNCTION largest(n : t_natural_arr) RETURN NATURAL;

	FUNCTION func_sum(n : t_natural_arr) RETURN NATURAL; -- sum     of all elements in array
	FUNCTION func_sum(n : t_nat_natural_arr) RETURN NATURAL;
	FUNCTION func_product(n : t_natural_arr) RETURN NATURAL; -- product of all elements in array
	FUNCTION func_product(n : t_nat_natural_arr) RETURN NATURAL;

	FUNCTION "+"(L, R : t_natural_arr) RETURN t_natural_arr; -- element wise sum
	FUNCTION "+"(L : t_natural_arr; R : INTEGER) RETURN t_natural_arr; -- element wise sum
	FUNCTION "+"(L : INTEGER; R : t_natural_arr) RETURN t_natural_arr; -- element wise sum

	FUNCTION "-"(L, R : t_natural_arr) RETURN t_natural_arr; -- element wise subtract
	FUNCTION "-"(L, R : t_natural_arr) RETURN t_integer_arr; -- element wise subtract, support negative result
	FUNCTION "-"(L : t_natural_arr; R : INTEGER) RETURN t_natural_arr; -- element wise subtract
	FUNCTION "-"(L : INTEGER; R : t_natural_arr) RETURN t_natural_arr; -- element wise subtract

	FUNCTION "*"(L, R : t_natural_arr) RETURN t_natural_arr; -- element wise product
	FUNCTION "*"(L : t_natural_arr; R : NATURAL) RETURN t_natural_arr; -- element wise product
	FUNCTION "*"(L : NATURAL; R : t_natural_arr) RETURN t_natural_arr; -- element wise product

	FUNCTION "/"(L, R : t_natural_arr) RETURN t_natural_arr; -- element wise division
	FUNCTION "/"(L : t_natural_arr; R : POSITIVE) RETURN t_natural_arr; -- element wise division
	FUNCTION "/"(L : NATURAL; R : t_natural_arr) RETURN t_natural_arr; -- element wise division

	FUNCTION is_true(a : STD_LOGIC) RETURN BOOLEAN;
	FUNCTION is_true(a : STD_LOGIC) RETURN NATURAL;
	FUNCTION is_true(a : BOOLEAN) RETURN STD_LOGIC;
	FUNCTION is_true(a : BOOLEAN) RETURN NATURAL;
	FUNCTION is_true(a : INTEGER) RETURN BOOLEAN; -- also covers NATURAL because it is a subtype of INTEGER
	FUNCTION is_true(a : INTEGER) RETURN STD_LOGIC; -- also covers NATURAL because it is a subtype of INTEGER

	FUNCTION is_all(vec : STD_LOGIC_VECTOR; val : STD_LOGIC) return BOOLEAN;

	FUNCTION sel_a_b(sel, a, b : BOOLEAN) RETURN BOOLEAN;
	FUNCTION sel_a_b(sel, a, b : INTEGER) RETURN INTEGER;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : INTEGER) RETURN INTEGER;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : REAL) RETURN REAL;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STD_LOGIC) RETURN STD_LOGIC;
	FUNCTION sel_a_b(sel : INTEGER; a, b : STD_LOGIC) RETURN STD_LOGIC;
	FUNCTION sel_a_b(sel : INTEGER; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : SIGNED) RETURN SIGNED;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : UNSIGNED) RETURN UNSIGNED;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_integer_arr) RETURN t_integer_arr;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_natural_arr) RETURN t_natural_arr;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_nat_integer_arr) RETURN t_nat_integer_arr;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_nat_natural_arr) RETURN t_nat_natural_arr;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STRING) RETURN STRING;
	FUNCTION sel_a_b(sel : INTEGER; a, b : STRING) RETURN STRING;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : TIME) RETURN TIME;
	FUNCTION sel_a_b(sel : BOOLEAN; a, b : SEVERITY_LEVEL) RETURN SEVERITY_LEVEL;

	-- sel_n() index sel = 0, 1, 2, ... will return a, b, c, ...
	FUNCTION sel_n(sel : NATURAL; a, b, c : BOOLEAN) RETURN BOOLEAN; --  3
	FUNCTION sel_n(sel : NATURAL; a, b, c, d : BOOLEAN) RETURN BOOLEAN; --  4
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : BOOLEAN) RETURN BOOLEAN; --  5
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : BOOLEAN) RETURN BOOLEAN; --  6
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : BOOLEAN) RETURN BOOLEAN; --  7
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : BOOLEAN) RETURN BOOLEAN; --  8
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : BOOLEAN) RETURN BOOLEAN; --  9
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : BOOLEAN) RETURN BOOLEAN; -- 10

	FUNCTION sel_n(sel : NATURAL; a, b, c : INTEGER) RETURN INTEGER; --  3
	FUNCTION sel_n(sel : NATURAL; a, b, c, d : INTEGER) RETURN INTEGER; --  4
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : INTEGER) RETURN INTEGER; --  5
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : INTEGER) RETURN INTEGER; --  6
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : INTEGER) RETURN INTEGER; --  7
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : INTEGER) RETURN INTEGER; --  8
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : INTEGER) RETURN INTEGER; --  9
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : INTEGER) RETURN INTEGER; -- 10

	FUNCTION sel_n(sel : NATURAL; a, b : STRING) RETURN STRING; --  2
	FUNCTION sel_n(sel : NATURAL; a, b, c : STRING) RETURN STRING; --  3
	FUNCTION sel_n(sel : NATURAL; a, b, c, d : STRING) RETURN STRING; --  4
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : STRING) RETURN STRING; --  5
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : STRING) RETURN STRING; --  6
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : STRING) RETURN STRING; --  7
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : STRING) RETURN STRING; --  8
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : STRING) RETURN STRING; --  9
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : STRING) RETURN STRING; -- 10

	FUNCTION array_init(init : STD_LOGIC; nof : NATURAL) RETURN STD_LOGIC_VECTOR; -- useful to init a unconstrained array of size 1
	FUNCTION array_init(init, nof : NATURAL) RETURN t_natural_arr; -- useful to init a unconstrained array of size 1
	FUNCTION array_init(init, nof : NATURAL) RETURN t_nat_natural_arr; -- useful to init a unconstrained array of size 1
	FUNCTION array_init(init, nof, incr : NATURAL) RETURN t_natural_arr; -- useful to init an array with incrementing numbers
	FUNCTION array_init(init, nof, incr : NATURAL) RETURN t_nat_natural_arr;
	FUNCTION array_init(init, nof, incr : INTEGER) RETURN t_slv_16_arr;
	FUNCTION array_init(init, nof, incr : INTEGER) RETURN t_slv_32_arr;
	FUNCTION array_init(init, nof, width : NATURAL) RETURN STD_LOGIC_VECTOR; -- useful to init an unconstrained std_logic_vector with repetitive content
	FUNCTION array_init(init, nof, width, incr : NATURAL) RETURN STD_LOGIC_VECTOR; -- useful to init an unconstrained std_logic_vector with incrementing content
	FUNCTION array_sinit(init : INTEGER; nof, width : NATURAL) RETURN STD_LOGIC_VECTOR; -- useful to init an unconstrained std_logic_vector with repetitive content

	FUNCTION init_slv_64_matrix(nof_a, nof_b, k : INTEGER) RETURN t_slv_64_matrix; -- initialize all elements in t_slv_64_matrix to value k

	-- Concatenate two or more STD_LOGIC_VECTORs into a single STD_LOGIC_VECTOR or extract one of them from a concatenated STD_LOGIC_VECTOR
	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a, b, c, d, e, f, g : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a, b, c, d, e, f : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a, b, c, d, e : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d : BOOLEAN; a, b, c, d : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat(use_a, use_b, use_c : BOOLEAN; a, b, c : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat(use_a, use_b : BOOLEAN; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w, g_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a_w, b_w, c_w, d_w, e_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d : BOOLEAN; a_w, b_w, c_w, d_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_concat_w(use_a, use_b, use_c : BOOLEAN; a_w, b_w, c_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_concat_w(use_a, use_b : BOOLEAN; a_w, b_w : NATURAL) RETURN NATURAL;
	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w, g_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a_w, b_w, c_w, d_w, e_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d : BOOLEAN; a_w, b_w, c_w, d_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_extract(use_a, use_b, use_c : BOOLEAN; a_w, b_w, c_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION func_slv_extract(use_a, use_b : BOOLEAN; a_w, b_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR;

	FUNCTION func_slv_reverse(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

	FUNCTION TO_UINT(vec : STD_LOGIC_VECTOR) RETURN NATURAL; -- beware: NATURAL'HIGH = 2**31-1, not 2*32-1, use TO_SINT to avoid warning
	FUNCTION TO_SINT(vec : STD_LOGIC_VECTOR) RETURN INTEGER;

	FUNCTION TO_UVEC(dec, w : NATURAL) RETURN STD_LOGIC_VECTOR;
	FUNCTION TO_SVEC(dec, w : INTEGER) RETURN STD_LOGIC_VECTOR;

	FUNCTION TO_SVEC_32(dec : INTEGER) RETURN STD_LOGIC_VECTOR; -- = TO_SVEC() with w=32 for t_slv_32_arr slv elements

	-- The RESIZE for SIGNED in IEEE.NUMERIC_STD extends the sign bit or it keeps the sign bit and LS part. This
	-- behaviour of preserving the sign bit is less suitable for DSP and not necessary in general. A more
	-- appropriate approach is to ignore the MSbit sign and just keep the LS part. For too large values this 
	-- means that the result gets wrapped, but that is fine for default behaviour, because that is also what
	-- happens for RESIZE of UNSIGNED. Therefor this is what the RESIZE_NUM for SIGNED and the RESIZE_SVEC do
	-- and better not use RESIZE for SIGNED anymore.
	FUNCTION RESIZE_NUM(u : UNSIGNED; w : NATURAL) RETURN UNSIGNED; -- left extend with '0' or keep LS part (same as RESIZE for UNSIGNED)
	FUNCTION RESIZE_NUM(s : SIGNED; w : NATURAL) RETURN SIGNED; -- extend sign bit or keep LS part
	FUNCTION RESIZE_UVEC(sl : STD_LOGIC; w : NATURAL) RETURN STD_LOGIC_VECTOR; -- left extend with '0' into slv
	FUNCTION RESIZE_UVEC(vec : STD_LOGIC_VECTOR; w : NATURAL) RETURN STD_LOGIC_VECTOR; -- left extend with '0' or keep LS part
	FUNCTION RESIZE_SVEC(vec : STD_LOGIC_VECTOR; w : NATURAL) RETURN STD_LOGIC_VECTOR; -- extend sign bit or keep LS part
	FUNCTION RESIZE_UINT(u : INTEGER; w : NATURAL) RETURN INTEGER; -- left extend with '0' or keep LS part
	FUNCTION RESIZE_SINT(s : INTEGER; w : NATURAL) RETURN INTEGER; -- extend sign bit or keep LS part

	FUNCTION RESIZE_UVEC_32(vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- = RESIZE_UVEC() with w=32 for t_slv_32_arr slv elements
	FUNCTION RESIZE_SVEC_32(vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- = RESIZE_SVEC() with w=32 for t_slv_32_arr slv elements

	FUNCTION INCR_UVEC(vec : STD_LOGIC_VECTOR; dec : INTEGER) RETURN STD_LOGIC_VECTOR;
	FUNCTION INCR_UVEC(vec : STD_LOGIC_VECTOR; dec : UNSIGNED) RETURN STD_LOGIC_VECTOR;
	FUNCTION INCR_SVEC(vec : STD_LOGIC_VECTOR; dec : INTEGER) RETURN STD_LOGIC_VECTOR;
	FUNCTION INCR_SVEC(vec : STD_LOGIC_VECTOR; dec : SIGNED) RETURN STD_LOGIC_VECTOR;

	-- Used in common_add_sub.vhd
	FUNCTION ADD_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR; -- l_vec + r_vec, treat slv operands as signed,   slv output width is res_w
	FUNCTION SUB_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR; -- l_vec - r_vec, treat slv operands as signed,   slv output width is res_w
	FUNCTION ADD_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR; -- l_vec + r_vec, treat slv operands as unsigned, slv output width is res_w
	FUNCTION SUB_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR; -- l_vec - r_vec, treat slv operands as unsigned, slv output width is res_w

	FUNCTION ADD_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- l_vec + r_vec, treat slv operands as signed,   slv output width is l_vec'LENGTH
	FUNCTION SUB_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- l_vec - r_vec, treat slv operands as signed,   slv output width is l_vec'LENGTH
	FUNCTION ADD_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- l_vec + r_vec, treat slv operands as unsigned, slv output width is l_vec'LENGTH
	FUNCTION SUB_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- l_vec - r_vec, treat slv operands as unsigned, slv output width is l_vec'LENGTH

	FUNCTION COMPLEX_MULT_REAL(a_re, a_im, b_re, b_im : INTEGER) RETURN INTEGER; -- Calculate real part of complex multiplication: a_re*b_re - a_im*b_im 
	FUNCTION COMPLEX_MULT_IMAG(a_re, a_im, b_re, b_im : INTEGER) RETURN INTEGER; -- Calculate imag part of complex multiplication: a_im*b_re + a_re*b_im 

	FUNCTION S_ADD_OVFLW_DET(a, b, sum_a_b : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- Preempt whether there is addition overflow for signed values 
	FUNCTION S_SUB_OVFLW_DET(a, b, sub_a_b : STD_LOGIC_VECTOR) RETURN STD_LOGIC; -- Preempt whether there is subtraction overflow for signed values 

	FUNCTION SHIFT_UVEC(vec : STD_LOGIC_VECTOR; shift : INTEGER) RETURN STD_LOGIC_VECTOR; -- < 0 shift left, > 0 shift right
	FUNCTION SHIFT_SVEC(vec : STD_LOGIC_VECTOR; shift : INTEGER) RETURN STD_LOGIC_VECTOR; -- < 0 shift left, > 0 shift right

	FUNCTION offset_binary(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

	FUNCTION truncate(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR; -- remove n LSBits from vec, so result has width vec'LENGTH-n
	FUNCTION truncate_and_resize_uvec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR; -- remove n LSBits from vec and then resize to width w
	FUNCTION truncate_and_resize_svec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR; -- idem for signed values
	FUNCTION scale(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR; -- add n '0' LSBits to vec
	FUNCTION scale_and_resize_uvec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR; -- add n '0' LSBits to vec and then resize to width w
	FUNCTION scale_and_resize_svec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR; -- idem for signed values
	FUNCTION truncate_or_resize_uvec(vec : STD_LOGIC_VECTOR; b : BOOLEAN; w : NATURAL) RETURN STD_LOGIC_VECTOR; -- when b=TRUE then truncate to width w, else resize to width w
	FUNCTION truncate_or_resize_svec(vec : STD_LOGIC_VECTOR; b : BOOLEAN; w : NATURAL) RETURN STD_LOGIC_VECTOR; -- idem for signed values

	FUNCTION s_round_inf(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR; -- remove n LSBits from vec by rounding away from 0, so result has width vec'LENGTH-n, and clip to avoid wrap
	FUNCTION s_round(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN; round_style : t_rounding_mode) RETURN STD_LOGIC_VECTOR; -- remove n LSBits from vec by rounding away from 0, so result has width vec'LENGTH-n, and clip to avoid wrap
	FUNCTION s_round(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR; -- remove n LSBits from vec by rounding away from 0, so result has width vec'LENGTH-n
	FUNCTION s_round_up(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR; -- idem but round up to +infinity (s_round_up = u_round)
	FUNCTION s_round_up(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR; -- idem but round up to +infinity (s_round_up = u_round)
	FUNCTION u_round(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR; -- idem round up for unsigned values
	FUNCTION u_round(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR; -- idem round up for unsigned values

	FUNCTION u_to_s(u : NATURAL; w : NATURAL) RETURN INTEGER; -- interpret w bit unsigned u as w bit   signed, and remove any MSbits
	FUNCTION s_to_u(s : INTEGER; w : NATURAL) RETURN NATURAL; -- interpret w bit   signed s as w bit unsigned, and remove any MSbits

	FUNCTION u_wrap(u : NATURAL; w : NATURAL) RETURN NATURAL; -- return u & 2**w-1 (bit wise and), so keep w LSbits of unsigned u, and remove MSbits
	FUNCTION s_wrap(s : INTEGER; w : NATURAL) RETURN INTEGER; -- return s & 2**w-1 (bit wise and), so keep w LSbits of   signed s, and remove MSbits

	FUNCTION u_clip(u : NATURAL; max : NATURAL) RETURN NATURAL; -- if s < max return s, else return n
	FUNCTION s_clip(s : INTEGER; max : NATURAL; min : INTEGER) RETURN INTEGER; -- if s <=  min return  min, else if s >= max return max, else return s
	FUNCTION s_clip(s : INTEGER; max : NATURAL) RETURN INTEGER; -- if s <= -max return -max, else if s >= max return max, else return s

	FUNCTION hton(a : STD_LOGIC_VECTOR; w, sz : NATURAL) RETURN STD_LOGIC_VECTOR; -- convert endianity from host to network, sz in symbols of width w
	FUNCTION hton(a : STD_LOGIC_VECTOR; sz : NATURAL) RETURN STD_LOGIC_VECTOR; -- convert endianity from host to network, sz in bytes
	FUNCTION hton(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- convert endianity from host to network, for all bytes in a
	FUNCTION ntoh(a : STD_LOGIC_VECTOR; sz : NATURAL) RETURN STD_LOGIC_VECTOR; -- convert endianity from network to host, sz in bytes, ntoh() = hton()
	FUNCTION ntoh(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- convert endianity from network to host, for all bytes in a, ntoh() = hton()

	FUNCTION flip(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR; -- bit flip a vector, map a[h:0] to [0:h]
	FUNCTION flip(a, w : NATURAL) RETURN NATURAL; -- bit flip a vector, map a[h:0] to [0:h], h = w-1
	FUNCTION flip(a : t_slv_32_arr) RETURN t_slv_32_arr;
	FUNCTION flip(a : t_integer_arr) RETURN t_integer_arr;
	FUNCTION flip(a : t_natural_arr) RETURN t_natural_arr;
	FUNCTION flip(a : t_nat_natural_arr) RETURN t_nat_natural_arr;

	FUNCTION transpose(a : STD_LOGIC_VECTOR; row, col : NATURAL) RETURN STD_LOGIC_VECTOR; -- transpose a vector, map a[i*row+j] to output index [j*col+i]
	FUNCTION transpose(a, row, col : NATURAL) RETURN NATURAL; -- transpose index a = [i*row+j] to output index [j*col+i]

	FUNCTION split_w(input_w : NATURAL; min_out_w : NATURAL; max_out_w : NATURAL) RETURN NATURAL;

	FUNCTION pad(str : STRING; width : NATURAL; pad_char : CHARACTER) RETURN STRING;

	FUNCTION slice_up(str : STRING; width : NATURAL; i : NATURAL) RETURN STRING;
	FUNCTION slice_up(str : STRING; width : NATURAL; i : NATURAL; pad_char : CHARACTER) RETURN STRING;
	FUNCTION slice_dn(str : STRING; width : NATURAL; i : NATURAL) RETURN STRING;

	FUNCTION nat_arr_to_concat_slv(nat_arr : t_natural_arr; nof_elements : NATURAL) RETURN STD_LOGIC_VECTOR;

	------------------------------------------------------------------------------
	-- Component specific functions
	------------------------------------------------------------------------------

	-- common_fifo_*  
	PROCEDURE proc_common_fifo_asserts(CONSTANT c_fifo_name   : IN STRING;
	                                   CONSTANT c_note_is_ful : IN BOOLEAN;
	                                   CONSTANT c_fail_rd_emp : IN BOOLEAN;
	                                   SIGNAL   wr_rst        : IN STD_LOGIC;
	                                   SIGNAL   wr_clk        : IN STD_LOGIC;
	                                   SIGNAL   wr_full       : IN STD_LOGIC;
	                                   SIGNAL   wr_en         : IN STD_LOGIC;
	                                   SIGNAL   rd_clk        : IN STD_LOGIC;
	                                   SIGNAL   rd_empty      : IN STD_LOGIC;
	                                   SIGNAL   rd_en         : IN STD_LOGIC);

	-- common_fanout_tree  
	FUNCTION func_common_fanout_tree_pipelining(c_nof_stages, c_nof_output_per_cell, c_nof_output : NATURAL;
	                                            c_cell_pipeline_factor_arr, c_cell_pipeline_arr   : t_natural_arr) RETURN t_natural_arr;

	-- common_reorder_symbol 
	FUNCTION func_common_reorder2_is_there(I, J : NATURAL) RETURN BOOLEAN;
	FUNCTION func_common_reorder2_is_active(I, J, N : NATURAL) RETURN BOOLEAN;
	FUNCTION func_common_reorder2_get_select_index(I, J, N : NATURAL) RETURN INTEGER;
	FUNCTION func_common_reorder2_get_select(I, J, N : NATURAL; select_arr : t_natural_arr) RETURN NATURAL;
	FUNCTION func_common_reorder2_inverse_select(N : NATURAL; select_arr : t_natural_arr) RETURN t_natural_arr;

	-- Generate faster sample SCLK from digital DCLK for sim only
	PROCEDURE proc_common_dclk_generate_sclk(CONSTANT Pfactor : IN POSITIVE;
	                                         SIGNAL   dclk    : IN STD_LOGIC;
	                                         SIGNAL   sclk    : INOUT STD_LOGIC);
	function stringround_to_enum_round(stringin : string) return t_rounding_mode;
END common_pkg;

PACKAGE BODY common_pkg IS

	FUNCTION pow2(n : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN 2 ** n;
	END;

	FUNCTION ceil_pow2(n : INTEGER) RETURN NATURAL IS
		-- Also allows negative exponents and rounds up before returning the value
	BEGIN
		RETURN natural(integer(ceil(2 ** real(n))));
	END;

	FUNCTION true_log2(n : NATURAL) RETURN NATURAL IS
		-- Purpose: For calculating extra vector width of existing vector
		-- Description: Return mathematical ceil(log2(n))
		--   n    log2()
		--   0 -> -oo  --> FAILURE
		--   1 ->  0
		--   2 ->  1
		--   3 ->  2
		--   4 ->  2
		--   5 ->  3
		--   6 ->  3
		--   7 ->  3
		--   8 ->  3
		--   9 ->  4
		--   etc, up to n = NATURAL'HIGH = 2**31-1
	BEGIN
		RETURN natural(integer(ceil(log2(real(n)))));
	END;

	FUNCTION ceil_log2(n : NATURAL) RETURN NATURAL IS
		-- Purpose: For calculating vector width of new vector 
		-- Description:
		--   Same as true_log2() except ceil_log2(1) = 1, which is needed to support
		--   the vector width width for 1 address, to avoid NULL array for single
		--   word register address.
		--   If n = 0, return 0 so we get a NULL array when using 
		--   STD_LOGIC_VECTOR(ceil_log2(g_addr_w)-1 DOWNTO 0), instead of an error.
	BEGIN
		IF n = 0 THEN
			RETURN 0;                   -- Get NULL array
		ELSIF n = 1 THEN
			RETURN 1;                   -- avoid NULL array
		ELSE
			RETURN true_log2(n);
		END IF;
	END;

	FUNCTION next_pow2(n : NATURAL) return NATURAL is
		variable pow    : NATURAL := 1;
		variable result : NATURAL;
	begin
		while pow < n loop
			pow := pow * 2;
		end loop;
		result := ceil_log2(pow);
		return result;
	end FUNCTION;

	FUNCTION floor_log10(n : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN natural(integer(floor(log10(real(n)))));
	END;

	FUNCTION is_pow2(n : NATURAL) RETURN BOOLEAN IS
	BEGIN
		RETURN n = 2 ** true_log2(n);
	END;

	FUNCTION true_log_pow2(n : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN 2 ** true_log2(n);
	END;

	FUNCTION ratio(n, d : NATURAL) RETURN NATURAL IS
	BEGIN
		IF n MOD d = 0 THEN
			RETURN n / d;
		ELSE
			RETURN 0;
		END IF;
	END;

	FUNCTION ratio2(n, m : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN largest(ratio(n, m), ratio(m, n));
	END;

	FUNCTION ceil_div(n, d : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN n / d + sel_a_b(n MOD d = 0, 0, 1);
	END;

	FUNCTION ceil_value(n, d : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN ceil_div(n, d) * d;
	END;

	FUNCTION floor_value(n, d : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN (n / d) * d;
	END;

	FUNCTION ceil_div(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED IS
	BEGIN
		RETURN n / d + sel_a_b(n MOD d = 0, 0, 1); -- "/" returns same width as n
	END;

	FUNCTION ceil_value(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED IS
		CONSTANT w : NATURAL := n'LENGTH;
		VARIABLE p : UNSIGNED(2 * w - 1 DOWNTO 0);
	BEGIN
		p := ceil_div(n, d) * d;
		RETURN p(w - 1 DOWNTO 0);       -- return same width as n
	END;

	FUNCTION floor_value(n : UNSIGNED; d : NATURAL) RETURN UNSIGNED IS
		CONSTANT w : NATURAL := n'LENGTH;
		VARIABLE p : UNSIGNED(2 * w - 1 DOWNTO 0);
	BEGIN
		p := (n / d) * d;
		RETURN p(w - 1 DOWNTO 0);       -- return same width as n
	END;

	FUNCTION slv(n : IN STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
		VARIABLE r : STD_LOGIC_VECTOR(0 DOWNTO 0);
	BEGIN
		r(0) := n;
		RETURN r;
	END;

	FUNCTION sl(n : IN STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
		VARIABLE r : STD_LOGIC;
	BEGIN
		r := n(n'LOW);
		RETURN r;
	END;

	FUNCTION to_natural_arr(n : t_integer_arr; to_zero : BOOLEAN) RETURN t_natural_arr IS
		VARIABLE vN : t_integer_arr(n'LENGTH - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := n;
		FOR I IN vN'RANGE LOOP
			IF to_zero = FALSE THEN
				vR(I) := vN(I);
			ELSE
				vR(I) := 0;
				IF vN(I) > 0 THEN
					vR(I) := vN(I);
				END IF;
			END IF;
		END LOOP;
		RETURN vR;
	END;

	FUNCTION to_natural_arr(n : t_nat_natural_arr) RETURN t_natural_arr IS
		VARIABLE vN : t_nat_natural_arr(n'LENGTH - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := n;
		FOR I IN vN'RANGE LOOP
			vR(I) := vN(I);
		END LOOP;
		RETURN vR;
	END;

	FUNCTION to_integer_arr(n : t_natural_arr) RETURN t_integer_arr IS
		VARIABLE vN : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
		VARIABLE vR : t_integer_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := n;
		FOR I IN vN'RANGE LOOP
			vR(I) := vN(I);
		END LOOP;
		RETURN vR;
	END;

	FUNCTION to_integer_arr(n : t_nat_natural_arr) RETURN t_integer_arr IS
		VARIABLE vN : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := to_natural_arr(n);
		RETURN to_integer_arr(vN);
	END;

	FUNCTION to_slv_32_arr(n : t_integer_arr) RETURN t_slv_32_arr IS
		VARIABLE vN : t_integer_arr(n'LENGTH - 1 DOWNTO 0);
		VARIABLE vR : t_slv_32_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := n;
		FOR I IN vN'RANGE LOOP
			vR(I) := TO_SVEC(vN(I), 32);
		END LOOP;
		RETURN vR;
	END;

	FUNCTION to_slv_32_arr(n : t_natural_arr) RETURN t_slv_32_arr IS
		VARIABLE vN : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
		VARIABLE vR : t_slv_32_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := n;
		FOR I IN vN'RANGE LOOP
			vR(I) := TO_UVEC(vN(I), 32);
		END LOOP;
		RETURN vR;
	END;

	FUNCTION vector_tree(slv : STD_LOGIC_VECTOR; operation : STRING) RETURN STD_LOGIC IS
		-- Linear loop to determine result takes combinatorial delay that is proportional to slv'LENGTH:
		--   FOR I IN slv'RANGE LOOP
		--     v_result := v_result OPERATION slv(I);
		--   END LOOP;
		--   RETURN v_result;
		-- Instead use binary tree to determine result with smallest combinatorial delay that depends on log2(slv'LENGTH)
		CONSTANT c_slv_w      : NATURAL   := slv'LENGTH;
		CONSTANT c_nof_stages : NATURAL   := ceil_log2(c_slv_w);
		CONSTANT c_w          : NATURAL   := 2 ** c_nof_stages; -- extend the input slv to a vector with length power of 2 to ease using binary tree
		TYPE t_stage_arr IS ARRAY (-1 TO c_nof_stages - 1) OF STD_LOGIC_VECTOR(c_w - 1 DOWNTO 0);
		VARIABLE v_stage_arr  : t_stage_arr;
		VARIABLE v_result     : STD_LOGIC := '0';
	BEGIN
		-- default any unused, the stage results will be kept in the LSBits and the last result in bit 0
		IF operation = "AND" THEN
			v_stage_arr := (OTHERS => (OTHERS => '1'));
		ELSIF operation = "OR" THEN
			v_stage_arr := (OTHERS => (OTHERS => '0'));
		ELSIF operation = "XOR" THEN
			v_stage_arr := (OTHERS => (OTHERS => '0'));
		ELSE
			ASSERT TRUE REPORT "common_pkg: Unsupported vector_tree operation" SEVERITY FAILURE;
		END IF;
		v_stage_arr(-1)(c_slv_w - 1 DOWNTO 0) := slv; -- any unused input c_w : c_slv_w bits have void default value
		FOR J IN 0 TO c_nof_stages - 1 LOOP
			FOR I IN 0 TO c_w / (2 ** (J + 1)) - 1 LOOP
				IF operation = "AND" THEN
					v_stage_arr(J)(I) := v_stage_arr(J - 1)(2 * I) AND v_stage_arr(J - 1)(2 * I + 1);
				ELSIF operation = "OR" THEN
					v_stage_arr(J)(I) := v_stage_arr(J - 1)(2 * I) OR v_stage_arr(J - 1)(2 * I + 1);
				ELSIF operation = "XOR" THEN
					v_stage_arr(J)(I) := v_stage_arr(J - 1)(2 * I) XOR v_stage_arr(J - 1)(2 * I + 1);
				END IF;
			END LOOP;
		END LOOP;
		RETURN v_stage_arr(c_nof_stages - 1)(0);
	END;

	FUNCTION vector_and(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "AND");
	END;

	FUNCTION vector_or(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "OR");
	END;

	FUNCTION vector_xor(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "XOR");
	END;

	FUNCTION vector_one_hot(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_one_hot : BOOLEAN                     := FALSE;
		VARIABLE v_zeros   : STD_LOGIC_VECTOR(slv'RANGE) := (OTHERS => '0');
	BEGIN
		FOR i IN slv'RANGE LOOP
			IF slv(i) = '1' THEN
				IF NOT (v_one_hot) THEN
					-- No hot bits found so far
					v_one_hot := TRUE;
				ELSE
					-- This is the second hot bit found; return zeros.
					RETURN v_zeros;
				END IF;
			END IF;
		END LOOP;
		-- No or a single hot bit found in slv; return slv.
		RETURN slv;
	END;

	FUNCTION andv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "AND");
	END;

	FUNCTION orv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "OR");
	END;

	FUNCTION xorv(slv : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
	BEGIN
		RETURN vector_tree(slv, "XOR");
	END;

	FUNCTION matrix_and(mat : t_sl_matrix; wi, wj : NATURAL) RETURN STD_LOGIC IS
		VARIABLE v_mat    : t_sl_matrix(0 TO wi - 1, 0 TO wj - 1) := mat; -- map to fixed range
		VARIABLE v_result : STD_LOGIC                             := '1';
	BEGIN
		FOR I IN 0 TO wi - 1 LOOP
			FOR J IN 0 TO wj - 1 LOOP
				v_result := v_result AND v_mat(I, J);
			END LOOP;
		END LOOP;
		RETURN v_result;
	END;

	FUNCTION matrix_or(mat : t_sl_matrix; wi, wj : NATURAL) RETURN STD_LOGIC IS
		VARIABLE v_mat    : t_sl_matrix(0 TO wi - 1, 0 TO wj - 1) := mat; -- map to fixed range
		VARIABLE v_result : STD_LOGIC                             := '0';
	BEGIN
		FOR I IN 0 TO wi - 1 LOOP
			FOR J IN 0 TO wj - 1 LOOP
				v_result := v_result OR v_mat(I, J);
			END LOOP;
		END LOOP;
		RETURN v_result;
	END;

	FUNCTION smallest(n, m : INTEGER) RETURN INTEGER IS
	BEGIN
		IF n < m THEN
			RETURN n;
		ELSE
			RETURN m;
		END IF;
	END;

	FUNCTION smallest(n, m, l : INTEGER) RETURN INTEGER IS
		VARIABLE v : NATURAL;
	BEGIN
		v := n;
		IF v > m THEN
			v := m;
		END IF;
		IF v > l THEN
			v := l;
		END IF;
		RETURN v;
	END;

	FUNCTION smallest(n : t_natural_arr) RETURN NATURAL IS
		VARIABLE m : NATURAL := 0;
	BEGIN
		FOR I IN n'RANGE LOOP
			IF n(I) < m THEN
				m := n(I);
			END IF;
		END LOOP;
		RETURN m;
	END;

	FUNCTION largest(n, m : INTEGER) RETURN INTEGER IS
	BEGIN
		IF n > m THEN
			RETURN n;
		ELSE
			RETURN m;
		END IF;
	END;

	FUNCTION largest(n : t_natural_arr) RETURN NATURAL IS
		VARIABLE m : NATURAL := 0;
	BEGIN
		FOR I IN n'RANGE LOOP
			IF n(I) > m THEN
				m := n(I);
			END IF;
		END LOOP;
		RETURN m;
	END;

	FUNCTION func_sum(n : t_natural_arr) RETURN NATURAL IS
		VARIABLE vS : NATURAL;
	BEGIN
		vS := 0;
		FOR I IN n'RANGE LOOP
			vS := vS + n(I);
		END LOOP;
		RETURN vS;
	END;

	FUNCTION func_sum(n : t_nat_natural_arr) RETURN NATURAL IS
		VARIABLE vN : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := to_natural_arr(n);
		RETURN func_sum(vN);
	END;

	FUNCTION func_product(n : t_natural_arr) RETURN NATURAL IS
		VARIABLE vP : NATURAL;
	BEGIN
		vP := 1;
		FOR I IN n'RANGE LOOP
			vP := vP * n(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION func_product(n : t_nat_natural_arr) RETURN NATURAL IS
		VARIABLE vN : t_natural_arr(n'LENGTH - 1 DOWNTO 0);
	BEGIN
		vN := to_natural_arr(n);
		RETURN func_product(vN);
	END;

	FUNCTION "+"(L, R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		vR := R;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) + vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "+"(L : t_natural_arr; R : INTEGER) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) + R;
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "+"(L : INTEGER; R : t_natural_arr) RETURN t_natural_arr IS
	BEGIN
		RETURN R + L;
	END;

	FUNCTION "-"(L, R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		vR := R;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) - vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "-"(L, R : t_natural_arr) RETURN t_integer_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_integer_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		vR := R;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) - vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "-"(L : t_natural_arr; R : INTEGER) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) - R;
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "-"(L : INTEGER; R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := R'LENGTH;
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vR := R;
		FOR I IN vR'RANGE LOOP
			vP(I) := L - vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "*"(L, R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		vR := R;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) * vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "*"(L : t_natural_arr; R : NATURAL) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) * R;
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "*"(L : NATURAL; R : t_natural_arr) RETURN t_natural_arr IS
	BEGIN
		RETURN R * L;
	END;

	FUNCTION "/"(L, R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		vR := R;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) / vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "/"(L : t_natural_arr; R : POSITIVE) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := L'LENGTH;
		VARIABLE vL : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vL := L;
		FOR I IN vL'RANGE LOOP
			vP(I) := vL(I) / R;
		END LOOP;
		RETURN vP;
	END;

	FUNCTION "/"(L : NATURAL; R : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT w  : NATURAL := R'LENGTH;
		VARIABLE vR : t_natural_arr(w - 1 DOWNTO 0);
		VARIABLE vP : t_natural_arr(w - 1 DOWNTO 0);
	BEGIN
		vR := R;
		FOR I IN vR'RANGE LOOP
			vP(I) := L / vR(I);
		END LOOP;
		RETURN vP;
	END;

	FUNCTION is_true(a : STD_LOGIC) RETURN BOOLEAN IS
	BEGIN
		IF a = '1' THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END;
	FUNCTION is_true(a : STD_LOGIC) RETURN NATURAL IS
	BEGIN
		IF a = '1' THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
	FUNCTION is_true(a : BOOLEAN) RETURN STD_LOGIC IS
	BEGIN
		IF a = TRUE THEN
			RETURN '1';
		ELSE
			RETURN '0';
		END IF;
	END;
	FUNCTION is_true(a : BOOLEAN) RETURN NATURAL IS
	BEGIN
		IF a = TRUE THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
	FUNCTION is_true(a : INTEGER) RETURN BOOLEAN IS
	BEGIN
		IF a /= 0 THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END;
	FUNCTION is_true(a : INTEGER) RETURN STD_LOGIC IS
	BEGIN
		IF a /= 0 THEN
			RETURN '1';
		ELSE
			RETURN '0';
		END IF;
	END;

	FUNCTION is_all(vec : STD_LOGIC_VECTOR; val : STD_LOGIC) RETURN BOOLEAN IS
		CONSTANT all_bits : STD_LOGIC_VECTOR(vec'RANGE) := (OTHERS => val);
	BEGIN
		RETURN vec = all_bits;
	END FUNCTION;

	FUNCTION sel_a_b(sel, a, b : INTEGER) RETURN INTEGER IS
	BEGIN
		IF sel /= 0 THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel, a, b : BOOLEAN) RETURN BOOLEAN IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : INTEGER) RETURN INTEGER IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : REAL) RETURN REAL IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STD_LOGIC) RETURN STD_LOGIC IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : INTEGER; a, b : STD_LOGIC) RETURN STD_LOGIC IS
	BEGIN
		IF sel /= 0 THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : INTEGER; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		IF sel /= 0 THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : SIGNED) RETURN SIGNED IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : UNSIGNED) RETURN UNSIGNED IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_integer_arr) RETURN t_integer_arr IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_natural_arr) RETURN t_natural_arr IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_nat_integer_arr) RETURN t_nat_integer_arr IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : t_nat_natural_arr) RETURN t_nat_natural_arr IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : STRING) RETURN STRING IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : INTEGER; a, b : STRING) RETURN STRING IS
	BEGIN
		IF sel /= 0 THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : TIME) RETURN TIME IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	FUNCTION sel_a_b(sel : BOOLEAN; a, b : SEVERITY_LEVEL) RETURN SEVERITY_LEVEL IS
	BEGIN
		IF sel = TRUE THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;

	-- sel_n : boolean
	FUNCTION sel_n(sel : NATURAL; a, b, c : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e, f);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e, f, g);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e, f, g, h);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e, f, g, h, i);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : BOOLEAN) RETURN BOOLEAN IS
		CONSTANT c_arr : t_nat_boolean_arr := (a, b, c, d, e, f, g, h, i, j);
	BEGIN
		RETURN c_arr(sel);
	END;

	-- sel_n : integer
	FUNCTION sel_n(sel : NATURAL; a, b, c : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e, f);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e, f, g);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e, f, g, h);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e, f, g, h, i);
	BEGIN
		RETURN c_arr(sel);
	END;

	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : INTEGER) RETURN INTEGER IS
		CONSTANT c_arr : t_nat_integer_arr := (a, b, c, d, e, f, g, h, i, j);
	BEGIN
		RETURN c_arr(sel);
	END;

	-- sel_n : string
	FUNCTION sel_n(sel : NATURAL; a, b : STRING) RETURN STRING IS
	BEGIN
		IF sel = 0 THEN
			RETURN a;
		ELSE
			RETURN b;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c : STRING) RETURN STRING IS
	BEGIN
		IF sel < 2 THEN
			RETURN sel_n(sel, a, b);
		ELSE
			RETURN c;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d : STRING) RETURN STRING IS
	BEGIN
		IF sel < 3 THEN
			RETURN sel_n(sel, a, b, c);
		ELSE
			RETURN d;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e : STRING) RETURN STRING IS
	BEGIN
		IF sel < 4 THEN
			RETURN sel_n(sel, a, b, c, d);
		ELSE
			RETURN e;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f : STRING) RETURN STRING IS
	BEGIN
		IF sel < 5 THEN
			RETURN sel_n(sel, a, b, c, d, e);
		ELSE
			RETURN f;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g : STRING) RETURN STRING IS
	BEGIN
		IF sel < 6 THEN
			RETURN sel_n(sel, a, b, c, d, e, f);
		ELSE
			RETURN g;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h : STRING) RETURN STRING IS
	BEGIN
		IF sel < 7 THEN
			RETURN sel_n(sel, a, b, c, d, e, f, g);
		ELSE
			RETURN h;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i : STRING) RETURN STRING IS
	BEGIN
		IF sel < 8 THEN
			RETURN sel_n(sel, a, b, c, d, e, f, g, h);
		ELSE
			RETURN i;
		END IF;
	END;
	FUNCTION sel_n(sel : NATURAL; a, b, c, d, e, f, g, h, i, j : STRING) RETURN STRING IS
	BEGIN
		IF sel < 9 THEN
			RETURN sel_n(sel, a, b, c, d, e, f, g, h, i);
		ELSE
			RETURN j;
		END IF;
	END;

	FUNCTION array_init(init : STD_LOGIC; nof : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_arr : STD_LOGIC_VECTOR(0 TO nof - 1);
	BEGIN
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := init;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof : NATURAL) RETURN t_natural_arr IS
		VARIABLE v_arr : t_natural_arr(0 TO nof - 1);
	BEGIN
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := init;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof : NATURAL) RETURN t_nat_natural_arr IS
		VARIABLE v_arr : t_nat_natural_arr(0 TO nof - 1);
	BEGIN
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := init;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, incr : NATURAL) RETURN t_natural_arr IS
		VARIABLE v_arr : t_natural_arr(0 TO nof - 1);
		VARIABLE v_i   : NATURAL;
	BEGIN
		v_i := 0;
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := init + v_i * incr;
			v_i      := v_i + 1;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, incr : NATURAL) RETURN t_nat_natural_arr IS
		VARIABLE v_arr : t_nat_natural_arr(0 TO nof - 1);
		VARIABLE v_i   : NATURAL;
	BEGIN
		v_i := 0;
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := init + v_i * incr;
			v_i      := v_i + 1;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, incr : INTEGER) RETURN t_slv_16_arr IS
		VARIABLE v_arr : t_slv_16_arr(0 TO nof - 1);
		VARIABLE v_i   : NATURAL;
	BEGIN
		v_i := 0;
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := TO_SVEC(init + v_i * incr, 16);
			v_i      := v_i + 1;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, incr : INTEGER) RETURN t_slv_32_arr IS
		VARIABLE v_arr : t_slv_32_arr(0 TO nof - 1);
		VARIABLE v_i   : NATURAL;
	BEGIN
		v_i := 0;
		FOR I IN v_arr'RANGE LOOP
			v_arr(I) := TO_SVEC(init + v_i * incr, 32);
			v_i      := v_i + 1;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, width : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_arr : STD_LOGIC_VECTOR(nof * width - 1 DOWNTO 0);
	BEGIN
		FOR I IN 0 TO nof - 1 LOOP
			v_arr(width * (I + 1) - 1 DOWNTO width * I) := TO_UVEC(init, width);
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_init(init, nof, width, incr : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_arr : STD_LOGIC_VECTOR(nof * width - 1 DOWNTO 0);
		VARIABLE v_i   : NATURAL;
	BEGIN
		v_i := 0;
		FOR I IN 0 TO nof - 1 LOOP
			v_arr(width * (I + 1) - 1 DOWNTO width * I) := TO_UVEC(init + v_i * incr, width);
			v_i                                         := v_i + 1;
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION array_sinit(init : INTEGER; nof, width : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_arr : STD_LOGIC_VECTOR(nof * width - 1 DOWNTO 0);
	BEGIN
		FOR I IN 0 TO nof - 1 LOOP
			v_arr(width * (I + 1) - 1 DOWNTO width * I) := TO_SVEC(init, width);
		END LOOP;
		RETURN v_arr;
	END;

	FUNCTION init_slv_64_matrix(nof_a, nof_b, k : INTEGER) RETURN t_slv_64_matrix IS
		VARIABLE v_mat : t_slv_64_matrix(nof_a - 1 DOWNTO 0, nof_b - 1 DOWNTO 0);
	BEGIN
		FOR I IN 0 TO nof_a - 1 LOOP
			FOR J IN 0 TO nof_b - 1 LOOP
				v_mat(I, J) := TO_SVEC(k, 64);
			END LOOP;
		END LOOP;
		RETURN v_mat;
	END;

	-- Support concatenation of up to 7 slv into 1 slv
	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a, b, c, d, e, f, g : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_max_w : NATURAL                                := a'LENGTH + b'LENGTH + c'LENGTH + d'LENGTH + e'LENGTH + f'LENGTH + g'LENGTH;
		VARIABLE v_res   : STD_LOGIC_VECTOR(c_max_w - 1 DOWNTO 0) := (OTHERS => '0');
		VARIABLE v_len   : NATURAL                                := 0;
	BEGIN
		IF use_a = TRUE THEN
			v_res(a'LENGTH - 1 + v_len DOWNTO v_len) := a;
			v_len                                    := v_len + a'LENGTH;
		END IF;
		IF use_b = TRUE THEN
			v_res(b'LENGTH - 1 + v_len DOWNTO v_len) := b;
			v_len                                    := v_len + b'LENGTH;
		END IF;
		IF use_c = TRUE THEN
			v_res(c'LENGTH - 1 + v_len DOWNTO v_len) := c;
			v_len                                    := v_len + c'LENGTH;
		END IF;
		IF use_d = TRUE THEN
			v_res(d'LENGTH - 1 + v_len DOWNTO v_len) := d;
			v_len                                    := v_len + d'LENGTH;
		END IF;
		IF use_e = TRUE THEN
			v_res(e'LENGTH - 1 + v_len DOWNTO v_len) := e;
			v_len                                    := v_len + e'LENGTH;
		END IF;
		IF use_f = TRUE THEN
			v_res(f'LENGTH - 1 + v_len DOWNTO v_len) := f;
			v_len                                    := v_len + f'LENGTH;
		END IF;
		IF use_g = TRUE THEN
			v_res(g'LENGTH - 1 + v_len DOWNTO v_len) := g;
			v_len                                    := v_len + g'LENGTH;
		END IF;
		RETURN v_res(v_len - 1 DOWNTO 0);
	END func_slv_concat;

	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a, b, c, d, e, f : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_concat(use_a, use_b, use_c, use_d, use_e, use_f, FALSE, a, b, c, d, e, f, "0");
	END func_slv_concat;

	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a, b, c, d, e : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_concat(use_a, use_b, use_c, use_d, use_e, FALSE, FALSE, a, b, c, d, e, "0", "0");
	END func_slv_concat;

	FUNCTION func_slv_concat(use_a, use_b, use_c, use_d : BOOLEAN; a, b, c, d : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_concat(use_a, use_b, use_c, use_d, FALSE, FALSE, FALSE, a, b, c, d, "0", "0", "0");
	END func_slv_concat;

	FUNCTION func_slv_concat(use_a, use_b, use_c : BOOLEAN; a, b, c : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_concat(use_a, use_b, use_c, FALSE, FALSE, FALSE, FALSE, a, b, c, "0", "0", "0", "0");
	END func_slv_concat;

	FUNCTION func_slv_concat(use_a, use_b : BOOLEAN; a, b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_concat(use_a, use_b, FALSE, FALSE, FALSE, FALSE, FALSE, a, b, "0", "0", "0", "0", "0");
	END func_slv_concat;

	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w, g_w : NATURAL) RETURN NATURAL IS
		VARIABLE v_len : NATURAL := 0;
	BEGIN
		IF use_a = TRUE THEN
			v_len := v_len + a_w;
		END IF;
		IF use_b = TRUE THEN
			v_len := v_len + b_w;
		END IF;
		IF use_c = TRUE THEN
			v_len := v_len + c_w;
		END IF;
		IF use_d = TRUE THEN
			v_len := v_len + d_w;
		END IF;
		IF use_e = TRUE THEN
			v_len := v_len + e_w;
		END IF;
		IF use_f = TRUE THEN
			v_len := v_len + f_w;
		END IF;
		IF use_g = TRUE THEN
			v_len := v_len + g_w;
		END IF;
		RETURN v_len;
	END func_slv_concat_w;

	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, use_f, FALSE, a_w, b_w, c_w, d_w, e_w, f_w, 0);
	END func_slv_concat_w;

	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a_w, b_w, c_w, d_w, e_w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN func_slv_concat_w(use_a, use_b, use_c, use_d, use_e, FALSE, FALSE, a_w, b_w, c_w, d_w, e_w, 0, 0);
	END func_slv_concat_w;

	FUNCTION func_slv_concat_w(use_a, use_b, use_c, use_d : BOOLEAN; a_w, b_w, c_w, d_w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN func_slv_concat_w(use_a, use_b, use_c, use_d, FALSE, FALSE, FALSE, a_w, b_w, c_w, d_w, 0, 0, 0);
	END func_slv_concat_w;

	FUNCTION func_slv_concat_w(use_a, use_b, use_c : BOOLEAN; a_w, b_w, c_w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN func_slv_concat_w(use_a, use_b, use_c, FALSE, FALSE, FALSE, FALSE, a_w, b_w, c_w, 0, 0, 0, 0);
	END func_slv_concat_w;

	FUNCTION func_slv_concat_w(use_a, use_b : BOOLEAN; a_w, b_w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN func_slv_concat_w(use_a, use_b, FALSE, FALSE, FALSE, FALSE, FALSE, a_w, b_w, 0, 0, 0, 0, 0);
	END func_slv_concat_w;

	-- extract slv
	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e, use_f, use_g : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w, g_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_w  : NATURAL := 0;
		VARIABLE v_lo : NATURAL := 0;
	BEGIN
		-- if the selected slv is not used in vec, then return dummy, else return the selected slv from vec
		CASE sel IS
			WHEN 0 =>
				IF use_a = TRUE THEN
					v_w := a_w;
				ELSE
					RETURN c_slv0(a_w - 1 DOWNTO 0);
				END IF;
			WHEN 1 =>
				IF use_b = TRUE THEN
					v_w := b_w;
				ELSE
					RETURN c_slv0(b_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
			WHEN 2 =>
				IF use_c = TRUE THEN
					v_w := c_w;
				ELSE
					RETURN c_slv0(c_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
				IF use_b = TRUE THEN
					v_lo := v_lo + b_w;
				END IF;
			WHEN 3 =>
				IF use_d = TRUE THEN
					v_w := d_w;
				ELSE
					RETURN c_slv0(d_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
				IF use_b = TRUE THEN
					v_lo := v_lo + b_w;
				END IF;
				IF use_c = TRUE THEN
					v_lo := v_lo + c_w;
				END IF;
			WHEN 4 =>
				IF use_e = TRUE THEN
					v_w := e_w;
				ELSE
					RETURN c_slv0(e_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
				IF use_b = TRUE THEN
					v_lo := v_lo + b_w;
				END IF;
				IF use_c = TRUE THEN
					v_lo := v_lo + c_w;
				END IF;
				IF use_d = TRUE THEN
					v_lo := v_lo + d_w;
				END IF;
			WHEN 5 =>
				IF use_f = TRUE THEN
					v_w := f_w;
				ELSE
					RETURN c_slv0(f_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
				IF use_b = TRUE THEN
					v_lo := v_lo + b_w;
				END IF;
				IF use_c = TRUE THEN
					v_lo := v_lo + c_w;
				END IF;
				IF use_d = TRUE THEN
					v_lo := v_lo + d_w;
				END IF;
				IF use_e = TRUE THEN
					v_lo := v_lo + e_w;
				END IF;
			WHEN 6 =>
				IF use_g = TRUE THEN
					v_w := g_w;
				ELSE
					RETURN c_slv0(g_w - 1 DOWNTO 0);
				END IF;
				IF use_a = TRUE THEN
					v_lo := v_lo + a_w;
				END IF;
				IF use_b = TRUE THEN
					v_lo := v_lo + b_w;
				END IF;
				IF use_c = TRUE THEN
					v_lo := v_lo + c_w;
				END IF;
				IF use_d = TRUE THEN
					v_lo := v_lo + d_w;
				END IF;
				IF use_e = TRUE THEN
					v_lo := v_lo + e_w;
				END IF;
				IF use_f = TRUE THEN
					v_lo := v_lo + f_w;
				END IF;
			WHEN OTHERS => REPORT "Unknown common_pkg func_slv_extract argument" SEVERITY FAILURE;
		END CASE;
		RETURN vec(v_w - 1 + v_lo DOWNTO v_lo); -- extracted slv
	END func_slv_extract;

	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e, use_f : BOOLEAN; a_w, b_w, c_w, d_w, e_w, f_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_extract(use_a, use_b, use_c, use_d, use_e, use_f, FALSE, a_w, b_w, c_w, d_w, e_w, f_w, 0, vec, sel);
	END func_slv_extract;

	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d, use_e : BOOLEAN; a_w, b_w, c_w, d_w, e_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_extract(use_a, use_b, use_c, use_d, use_e, FALSE, FALSE, a_w, b_w, c_w, d_w, e_w, 0, 0, vec, sel);
	END func_slv_extract;

	FUNCTION func_slv_extract(use_a, use_b, use_c, use_d : BOOLEAN; a_w, b_w, c_w, d_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_extract(use_a, use_b, use_c, use_d, FALSE, FALSE, FALSE, a_w, b_w, c_w, d_w, 0, 0, 0, vec, sel);
	END func_slv_extract;

	FUNCTION func_slv_extract(use_a, use_b, use_c : BOOLEAN; a_w, b_w, c_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_extract(use_a, use_b, use_c, FALSE, FALSE, FALSE, FALSE, a_w, b_w, c_w, 0, 0, 0, 0, vec, sel);
	END func_slv_extract;

	FUNCTION func_slv_extract(use_a, use_b : BOOLEAN; a_w, b_w : NATURAL; vec : STD_LOGIC_VECTOR; sel : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN func_slv_extract(use_a, use_b, FALSE, FALSE, FALSE, FALSE, FALSE, a_w, b_w, 0, 0, 0, 0, 0, vec, sel);
	END func_slv_extract;

	FUNCTION func_slv_reverse(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		VARIABLE result : STD_LOGIC_VECTOR(a'RANGE);
		ALIAS aa        : STD_LOGIC_VECTOR(a'REVERSE_RANGE) is a;
	BEGIN
		FOR i in aa'RANGE LOOP
			result(i) := aa(i);
		END LOOP;
		RETURN result;
	END;

	FUNCTION TO_UINT(vec : STD_LOGIC_VECTOR) RETURN NATURAL IS
	BEGIN
		RETURN TO_INTEGER(UNSIGNED(vec));
	END;

	FUNCTION TO_SINT(vec : STD_LOGIC_VECTOR) RETURN INTEGER IS
	BEGIN
		RETURN TO_INTEGER(SIGNED(vec));
	END;

	FUNCTION TO_UVEC(dec, w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(TO_UNSIGNED(dec, w));
	END;

	FUNCTION TO_SVEC(dec, w : INTEGER) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(TO_SIGNED(dec, w));
	END;

	FUNCTION TO_SVEC_32(dec : INTEGER) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN TO_SVEC(dec, 32);
	END;

	FUNCTION RESIZE_NUM(u : UNSIGNED; w : NATURAL) RETURN UNSIGNED IS
	BEGIN
		-- left extend with '0' or keep LS part (same as RESIZE for UNSIGNED)
		RETURN RESIZE(u, w);
	END;

	FUNCTION RESIZE_NUM(s : SIGNED; w : NATURAL) RETURN SIGNED IS
	BEGIN
		-- left extend with sign bit or keep sign bit and LS part (same as RESIZE for SIGNED)
		-- If w < s'LENGTH then assume caller ensures that the actual s values
		-- will still fit in the w bits. Otherwise the result will wrap and
		-- there is nothing more that this RESIZE_NUM() can improve compared
		-- to RESIZE().
		RETURN RESIZE(s, w);
	END;

	FUNCTION RESIZE_UVEC(sl : STD_LOGIC; w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_slv0 : STD_LOGIC_VECTOR(w - 1 DOWNTO 1) := (OTHERS => '0');
	BEGIN
		RETURN v_slv0 & sl;
	END;

	FUNCTION RESIZE_UVEC(vec : STD_LOGIC_VECTOR; w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(UNSIGNED(vec), w));
	END;

	FUNCTION RESIZE_SVEC(vec : STD_LOGIC_VECTOR; w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(SIGNED(vec), w));
	END;

	FUNCTION RESIZE_UINT(u : INTEGER; w : NATURAL) RETURN INTEGER IS
		VARIABLE v : STD_LOGIC_VECTOR(c_word_w - 1 DOWNTO 0);
	BEGIN
		v := TO_UVEC(u, c_word_w);
		RETURN TO_UINT(v(w - 1 DOWNTO 0));
	END;

	FUNCTION RESIZE_SINT(s : INTEGER; w : NATURAL) RETURN INTEGER IS
		VARIABLE v : STD_LOGIC_VECTOR(c_word_w - 1 DOWNTO 0);
	BEGIN
		v := TO_SVEC(s, c_word_w);
		RETURN TO_SINT(v(w - 1 DOWNTO 0));
	END;

	FUNCTION RESIZE_UVEC_32(vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN RESIZE_UVEC(vec, 32);
	END;

	FUNCTION RESIZE_SVEC_32(vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN RESIZE_SVEC(vec, 32);
	END;

	FUNCTION INCR_UVEC(vec : STD_LOGIC_VECTOR; dec : INTEGER) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_dec : INTEGER;
	BEGIN
		IF dec < 0 THEN
			v_dec := -dec;
			RETURN STD_LOGIC_VECTOR(UNSIGNED(vec) - v_dec); -- uses function "-" (L : UNSIGNED, R : NATURAL), there is no function + with R : INTEGER argument
		ELSE
			v_dec := dec;
			RETURN STD_LOGIC_VECTOR(UNSIGNED(vec) + v_dec); -- uses function "+" (L : UNSIGNED, R : NATURAL)
		END IF;
	END;

	FUNCTION INCR_UVEC(vec : STD_LOGIC_VECTOR; dec : UNSIGNED) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(UNSIGNED(vec) + dec);
	END;

	FUNCTION INCR_SVEC(vec : STD_LOGIC_VECTOR; dec : INTEGER) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_dec : INTEGER;
	BEGIN
		RETURN STD_LOGIC_VECTOR(SIGNED(vec) + v_dec); -- uses function "+" (L : SIGNED, R : INTEGER)
	END;

	FUNCTION INCR_SVEC(vec : STD_LOGIC_VECTOR; dec : SIGNED) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(SIGNED(vec) + dec);
	END;

	FUNCTION ADD_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(SIGNED(l_vec), res_w) + SIGNED(r_vec));
	END;

	FUNCTION SUB_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(SIGNED(l_vec), res_w) - SIGNED(r_vec));
	END;

	FUNCTION ADD_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(UNSIGNED(l_vec), res_w) + UNSIGNED(r_vec));
	END;

	FUNCTION SUB_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR; res_w : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN STD_LOGIC_VECTOR(RESIZE_NUM(UNSIGNED(l_vec), res_w) - UNSIGNED(r_vec));
	END;

	FUNCTION ADD_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN ADD_SVEC(l_vec, r_vec, l_vec'LENGTH);
	END;

	FUNCTION SUB_SVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN SUB_SVEC(l_vec, r_vec, l_vec'LENGTH);
	END;

	FUNCTION ADD_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN ADD_UVEC(l_vec, r_vec, l_vec'LENGTH);
	END;

	FUNCTION SUB_UVEC(l_vec : STD_LOGIC_VECTOR; r_vec : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN SUB_UVEC(l_vec, r_vec, l_vec'LENGTH);
	END;

	FUNCTION COMPLEX_MULT_REAL(a_re, a_im, b_re, b_im : INTEGER) RETURN INTEGER IS
	BEGIN
		RETURN (a_re * b_re - a_im * b_im);
	END;

	FUNCTION COMPLEX_MULT_IMAG(a_re, a_im, b_re, b_im : INTEGER) RETURN INTEGER IS
	BEGIN
		RETURN (a_im * b_re + a_re * b_im);
	END;

	FUNCTION S_ADD_OVFLW_DET(a, b, sum_a_b : STD_LOGIC_VECTOR) RETURN STD_LOGIC is
		VARIABLE a_sign       : SIGNED(a'RANGE)       := SIGNED(a);
		VARIABLE b_sign       : SIGNED(a'RANGE)       := SIGNED(b);
		VARIABLE sum_a_b_sign : SIGNED(sum_a_b'RANGE) := SIGNED(sum_a_b);
	BEGIN
		IF (a_sign >= 0 xor b_sign >= 0) THEN
			RETURN '0';                 -- no overflow from addition can occur when signed values have different signs
		ELSIF (sum_a_b_sign >= 0 xor a_sign >= 0) THEN -- signs are same so use either a_sign|b_sign
			RETURN '1';                 -- overflow has occured - note sum wrapped to a different sign than inputs
		ELSE
			RETURN '0';
		END IF;
	END;

	FUNCTION S_SUB_OVFLW_DET(a, b, sub_a_b : STD_LOGIC_VECTOR) RETURN STD_LOGIC is
		VARIABLE a_sign       : SIGNED(a'RANGE)       := SIGNED(a);
		VARIABLE b_sign       : SIGNED(a'RANGE)       := SIGNED(b);
		VARIABLE sub_a_b_sign : SIGNED(sub_a_b'RANGE) := SIGNED(sub_a_b);
	BEGIN
		IF not (a_sign >= 0 xor b_sign >= 0) THEN
			RETURN '0';                 -- no overflow from subtraction can occur when signed values have same signs
		ELSIF not (sub_a_b_sign >= 0 xor b_sign >= 0) THEN
			RETURN '1';                 -- overflow occurs if the result has the same sign as the subtrahend
		ELSE
			RETURN '0';
		END IF;
	END;

	FUNCTION SHIFT_UVEC(vec : STD_LOGIC_VECTOR; shift : INTEGER) RETURN STD_LOGIC_VECTOR is
	BEGIN
		IF shift < 0 THEN
			RETURN STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(vec), -shift)); -- fill zeros from right
		ELSE
			RETURN STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(vec), shift)); -- fill zeros from left
		END IF;
	END;

	FUNCTION SHIFT_SVEC(vec : STD_LOGIC_VECTOR; shift : INTEGER) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		IF shift < 0 THEN
			RETURN STD_LOGIC_VECTOR(SHIFT_LEFT(SIGNED(vec), -shift)); -- same as SHIFT_LEFT for UNSIGNED
		ELSE
			RETURN STD_LOGIC_VECTOR(SHIFT_RIGHT(SIGNED(vec), shift)); -- extend sign
		END IF;
	END;

	--
	-- offset_binary() : maps offset binary to or from two-complement binary.
	--
	--   National ADC08DC1020     offset binary     two-complement binary
	--   + full scale =  127.5 :  11111111 = 255     127 = 01111111
	--     ...                                  
	--   +            =   +0.5 :  10000000 = 128       0 = 00000000
	--   0
	--   -            =   -0.5 :  01111111 = 127      -1 = 11111111
	--     ...                                  
	--   - full scale = -127.5 :  00000000 =   0    -128 = 10000000
	--
	-- To map between the offset binary and two complement binary involves
	-- adding 128 to the binary value or equivalently inverting the sign bit.
	-- The offset_binary() mapping can be done and undone both ways.
	-- The offset_binary() mapping to two-complement binary yields a DC offset
	-- of -0.5 Lsb.
	FUNCTION offset_binary(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_res : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0) := a;
	BEGIN
		v_res(v_res'HIGH) := NOT v_res(v_res'HIGH); -- invert MSbit to get to from offset binary to two's complement, or vice versa
		RETURN v_res;
	END;

	FUNCTION truncate(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL                                := vec'LENGTH;
		CONSTANT c_trunc_w : NATURAL                                := c_vec_w - n;
		VARIABLE v_vec     : STD_LOGIC_VECTOR(c_vec_w - 1 DOWNTO 0) := vec;
		VARIABLE v_res     : STD_LOGIC_VECTOR(c_trunc_w - 1 DOWNTO 0);
	BEGIN
		v_res := v_vec(c_vec_w - 1 DOWNTO n); -- keep MS part
		RETURN v_res;
	END;

	FUNCTION truncate_and_resize_uvec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL := vec'LENGTH;
		CONSTANT c_trunc_w : NATURAL := c_vec_w - n;
		VARIABLE v_trunc   : STD_LOGIC_VECTOR(c_trunc_w - 1 DOWNTO 0);
		VARIABLE v_res     : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		v_trunc := truncate(vec, n);    -- first keep MS part
		v_res   := RESIZE_UVEC(v_trunc, w); -- then keep LS part or left extend with '0'
		RETURN v_res;
	END;

	FUNCTION truncate_and_resize_svec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL := vec'LENGTH;
		CONSTANT c_trunc_w : NATURAL := c_vec_w - n;
		VARIABLE v_trunc   : STD_LOGIC_VECTOR(c_trunc_w - 1 DOWNTO 0);
		VARIABLE v_res     : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		v_trunc := truncate(vec, n);    -- first keep MS part
		v_res   := RESIZE_SVEC(v_trunc, w); -- then keep sign bit and LS part or left extend sign bit
		RETURN v_res;
	END;

	FUNCTION scale(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL                                  := vec'LENGTH;
		CONSTANT c_scale_w : NATURAL                                  := c_vec_w + n;
		VARIABLE v_res     : STD_LOGIC_VECTOR(c_scale_w - 1 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		v_res(c_scale_w - 1 DOWNTO n) := vec; -- scale by adding n zero bits at the right
		RETURN v_res;
	END;

	FUNCTION scale_and_resize_uvec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL                                  := vec'LENGTH;
		CONSTANT c_scale_w : NATURAL                                  := c_vec_w + n;
		VARIABLE v_scale   : STD_LOGIC_VECTOR(c_scale_w - 1 DOWNTO 0) := (OTHERS => '0');
		VARIABLE v_res     : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		v_scale(c_scale_w - 1 DOWNTO n) := vec; -- first scale by adding n zero bits at the right
		v_res                           := RESIZE_UVEC(v_scale, w); -- then keep LS part or left extend with '0'
		RETURN v_res;
	END;

	FUNCTION scale_and_resize_svec(vec : STD_LOGIC_VECTOR; n, w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w   : NATURAL                                  := vec'LENGTH;
		CONSTANT c_scale_w : NATURAL                                  := c_vec_w + n;
		VARIABLE v_scale   : STD_LOGIC_VECTOR(c_scale_w - 1 DOWNTO 0) := (OTHERS => '0');
		VARIABLE v_res     : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		v_scale(c_scale_w - 1 DOWNTO n) := vec; -- first scale by adding n zero bits at the right
		v_res                           := RESIZE_SVEC(v_scale, w); -- then keep LS part or left extend sign bit
		RETURN v_res;
	END;

	FUNCTION truncate_or_resize_uvec(vec : STD_LOGIC_VECTOR; b : BOOLEAN; w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w : NATURAL := vec'LENGTH;
		VARIABLE c_n     : INTEGER := c_vec_w - w;
		VARIABLE v_res   : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		IF b = TRUE AND c_n > 0 THEN
			v_res := truncate_and_resize_uvec(vec, c_n, w);
		ELSE
			v_res := RESIZE_UVEC(vec, w);
		END IF;
		RETURN v_res;
	END;

	FUNCTION truncate_or_resize_svec(vec : STD_LOGIC_VECTOR; b : BOOLEAN; w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_vec_w : NATURAL := vec'LENGTH;
		VARIABLE c_n     : INTEGER := c_vec_w - w;
		VARIABLE v_res   : STD_LOGIC_VECTOR(w - 1 DOWNTO 0);
	BEGIN
		IF b = TRUE AND c_n > 0 THEN
			v_res := truncate_and_resize_svec(vec, c_n, w);
		ELSE
			v_res := RESIZE_SVEC(vec, w);
		END IF;
		RETURN v_res;
	END;

	-- Functions s_round, s_round_up and u_round:
	--
	-- . The returned output width is input width - n.
	-- . If n=0 then the return value is the same as the input value so only
	--   wires (NOP, no operation).
	-- . Both have the same implementation but different c_max and c_clip values.
	-- . Round up for unsigned so +2.5 becomes 3

	--   Round away from zero was previously implemented here, but for DSP applications
	--   Round Away from zero can cause a noticable dc bias when using large FFTs and/or doing correlation.
	--   A more appopriate rounding logic is to use round to nearest even for DSP
	-- 
	-- Generates rounding logic when there is bits to round off
	-- Round nearest Even does the following assuming two fractional bits and two integer bits
	-- with an output of no fractional and two integer bits.
	-- #     Binary    Round out
	-- -1.75  "10.01"     -2   "10"
	-- -1.5   "10.10"     -2   "10"
	-- -1.25  "10.11"     -1   "11"
	-- -1.00  "11.00"     -1   "11"
	-- -0.75  "11.01"     -1   "11"
	-- -0.5   "11.10"      0   "00"
	-- -0.25  "11.11"      0   "00"
	--  0.00  "00.00"      0   "00"
	--  0.25  "00.01"      0   "00"
	--  0.50  "00.10"      0   "00"
	--  0.75  "00.11"      1   "01"
	--  1.00  "01.00"      1   "01"
	--  1.25  "01.01"      1   "01"
	--  1.5   "01.10"      2   "10"
	--  1.75  "01.11"      2   "10"

	-- . Rounding can cause an increase to the integer part, use clip = TRUE to
	--   clip the potential overflow due to adding 0.5 to +max.
	-- . For negative values overflow due to rounding can not occur, because c_half-1 >= 0 for n>0
	-- . If the input comes from a product and is rounded to the input width then
	--   clip can safely be FALSE, because e.g. for unsigned 4b*4b=8b->4b the
	--   maximum product is 15*15=225 <= 255-8, and for signed 4b*4b=8b->4b the
	--   maximum product is -8*-8=+64 <= 127-8, so wrapping due to rounding
	--   overflow will never occur.

	FUNCTION s_round_inf(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR IS
		-- Use SIGNED to avoid NATURAL (32 bit range) overflow error
		CONSTANT c_in_w  : NATURAL                      := vec'LENGTH;
		CONSTANT c_out_w : NATURAL                      := vec'LENGTH - n;
		CONSTANT c_one   : SIGNED(c_in_w - 1 DOWNTO 0)  := TO_SIGNED(1, c_in_w);
		CONSTANT c_half  : SIGNED(c_in_w - 1 DOWNTO 0)  := SHIFT_LEFT(c_one, n - 1); -- = 2**(n-1)
		CONSTANT c_max   : SIGNED(c_in_w - 1 DOWNTO 0)  := SIGNED('0' & c_slv1(c_in_w - 2 DOWNTO 0)) - c_half; -- = 2**(c_in_w-1)-1 - c_half  
		CONSTANT c_clip  : SIGNED(c_out_w - 1 DOWNTO 0) := SIGNED('0' & c_slv1(c_out_w - 2 DOWNTO 0)); -- = 2**(c_out_w-1)-1
		VARIABLE v_in    : SIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_out   : SIGNED(c_out_w - 1 DOWNTO 0);
	BEGIN
		v_in := SIGNED(vec);
		IF n > 0 THEN
			IF clip AND v_in > c_max THEN
				v_out := c_clip;        -- Round clip to maximum positive to avoid wrap to negative
			ELSE
				IF vec(vec'HIGH) = '0' THEN
					v_out := RESIZE_NUM(SHIFT_RIGHT(v_in + c_half + 0, n), c_out_w); -- Round up for positive
				ELSE
					v_out := RESIZE_NUM(SHIFT_RIGHT(v_in + c_half - 1, n), c_out_w); -- Round down for negative
				END IF;
			END IF;
		ELSE
			v_out := RESIZE_NUM(v_in, c_out_w); -- NOP
		END IF;
		RETURN STD_LOGIC_VECTOR(v_out);
	END;

	FUNCTION s_round(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN; round_style : t_rounding_mode) RETURN STD_LOGIC_VECTOR IS
		-- Use SIGNED to avoid NATURAL (32 bit range) overflow error
		CONSTANT c_out_w           : NATURAL := vec'LENGTH - n;
		variable input_data_fixed  : sfixed(c_out_w - 1 downto (-n)); -- we will use Fixed Point Lib in VHDL 2008 to do the calcs
		variable output_data_fixed : sfixed(c_out_w - 1 downto 0);
	BEGIN
		input_data_fixed := sfixed(signed(vec));
		--even rounding specified
		if round_style = ROUND then
			if clip then
				output_data_fixed := resize(arg => input_data_fixed, size_res => output_data_fixed, overflow_style => fixed_saturate, round_style => fixed_round);
			else
				output_data_fixed := resize(arg => input_data_fixed, size_res => output_data_fixed, overflow_style => fixed_wrap, round_style => fixed_round);
			end if;
		--infinite rounding specified
		elsif round_style = ROUNDINF then
			RETURN s_round_inf(vec => vec, n => n, clip => clip);
		else
			RETURN truncate(vec, n);
		end if;
		RETURN to_slv(output_data_fixed);
	END;

	FUNCTION s_round(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN s_round(vec, n, FALSE, ROUND); -- no even-round clip
	END;

	-- An alternative is to always round up, also for negative numbers (i.e. s_round_up = u_round).
	FUNCTION s_round_up(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN u_round(vec, n, clip);
	END;

	FUNCTION s_round_up(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN u_round(vec, n, FALSE);  -- no round clip
	END;

	-- Unsigned numbers are round up (almost same as s_round, but without the else on negative vec)
	FUNCTION u_round(vec : STD_LOGIC_VECTOR; n : NATURAL; clip : BOOLEAN) RETURN STD_LOGIC_VECTOR IS
		-- Use UNSIGNED to avoid NATURAL (32 bit range) overflow error
		CONSTANT c_in_w  : NATURAL                        := vec'LENGTH;
		CONSTANT c_out_w : NATURAL                        := vec'LENGTH - n;
		CONSTANT c_one   : UNSIGNED(c_in_w - 1 DOWNTO 0)  := TO_UNSIGNED(1, c_in_w);
		CONSTANT c_half  : UNSIGNED(c_in_w - 1 DOWNTO 0)  := SHIFT_LEFT(c_one, n - 1); -- = 2**(n-1)
		CONSTANT c_max   : UNSIGNED(c_in_w - 1 DOWNTO 0)  := UNSIGNED(c_slv1(c_in_w - 1 DOWNTO 0)) - c_half; -- = 2**c_in_w-1 - c_half  
		CONSTANT c_clip  : UNSIGNED(c_out_w - 1 DOWNTO 0) := UNSIGNED(c_slv1(c_out_w - 1 DOWNTO 0)); -- = 2**c_out_w-1
		VARIABLE v_in    : UNSIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_out   : UNSIGNED(c_out_w - 1 DOWNTO 0);
	BEGIN
		v_in := UNSIGNED(vec);
		IF n > 0 THEN
			IF clip AND v_in > c_max THEN
				v_out := c_clip;        -- Round clip to +max to avoid wrap to 0
			ELSE
				v_out := RESIZE_NUM(SHIFT_RIGHT(v_in + c_half, n), c_out_w); -- Round up
			END IF;
		ELSE
			v_out := RESIZE_NUM(v_in, c_out_w); -- NOP
		END IF;
		RETURN STD_LOGIC_VECTOR(v_out);
	END;

	FUNCTION u_round(vec : STD_LOGIC_VECTOR; n : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN u_round(vec, n, FALSE);  -- no round clip
	END;

	FUNCTION u_to_s(u : NATURAL; w : NATURAL) RETURN INTEGER IS
		VARIABLE v_u : STD_LOGIC_VECTOR(31 DOWNTO 0) := TO_UVEC(u, 32); -- via 32 bit word to avoid NUMERIC_STD.TO_SIGNED: vector truncated warming
	BEGIN
		RETURN TO_SINT(v_u(w - 1 DOWNTO 0));
	END;

	FUNCTION s_to_u(s : INTEGER; w : NATURAL) RETURN NATURAL IS
		VARIABLE v_s : STD_LOGIC_VECTOR(31 DOWNTO 0) := TO_SVEC(s, 32); -- via 32 bit word to avoid NUMERIC_STD.TO_SIGNED: vector truncated warming
	BEGIN
		RETURN TO_UINT(v_s(w - 1 DOWNTO 0));
	END;

	FUNCTION u_wrap(u : NATURAL; w : NATURAL) RETURN NATURAL IS
		VARIABLE v_u : STD_LOGIC_VECTOR(31 DOWNTO 0) := TO_UVEC(u, 32); -- via 32 bit word to avoid NUMERIC_STD.TO_SIGNED: vector truncated warming
	BEGIN
		RETURN TO_UINT(v_u(w - 1 DOWNTO 0));
	END;

	FUNCTION s_wrap(s : INTEGER; w : NATURAL) RETURN INTEGER IS
		VARIABLE v_s : STD_LOGIC_VECTOR(31 DOWNTO 0) := TO_SVEC(s, 32); -- via 32 bit word to avoid NUMERIC_STD.TO_SIGNED: vector truncated warming
	BEGIN
		RETURN TO_SINT(v_s(w - 1 DOWNTO 0));
	END;

	FUNCTION u_clip(u : NATURAL; max : NATURAL) RETURN NATURAL IS
	BEGIN
		IF u > max THEN
			RETURN max;
		ELSE
			RETURN u;
		END IF;
	END;

	FUNCTION s_clip(s : INTEGER; max : NATURAL; min : INTEGER) RETURN INTEGER IS
	BEGIN
		IF s < min THEN
			RETURN min;
		ELSE
			IF s > max THEN
				RETURN max;
			ELSE
				RETURN s;
			END IF;
		END IF;
	END;

	FUNCTION s_clip(s : INTEGER; max : NATURAL) RETURN INTEGER IS
	BEGIN
		RETURN s_clip(s, max, -max);
	END;

	FUNCTION hton(a : STD_LOGIC_VECTOR; w, sz : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_a : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0) := a; -- map a to range [h:0]
		VARIABLE v_b : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0) := a; -- default b = a
		VARIABLE vL  : NATURAL;
		VARIABLE vK  : NATURAL;
	BEGIN
		-- Note:
		-- . if sz = 1          then v_b = v_a
		-- . if a'LENGTH > sz*w then v_b(a'LENGTH:sz*w) = v_a(a'LENGTH:sz*w)
		FOR vL IN 0 TO sz - 1 LOOP
			vK                                  := sz - 1 - vL;
			v_b((vL + 1) * w - 1 DOWNTO vL * w) := v_a((vK + 1) * w - 1 DOWNTO vK * w);
		END LOOP;
		RETURN v_b;
	END FUNCTION;

	FUNCTION hton(a : STD_LOGIC_VECTOR; sz : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN hton(a, c_byte_w, sz);   -- symbol width w = c_byte_w = 8
	END FUNCTION;

	FUNCTION hton(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_sz : NATURAL := a'LENGTH / c_byte_w;
	BEGIN
		RETURN hton(a, c_byte_w, c_sz); -- symbol width w = c_byte_w = 8
	END FUNCTION;

	FUNCTION ntoh(a : STD_LOGIC_VECTOR; sz : NATURAL) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN hton(a, sz);             -- i.e. ntoh() = hton()
	END FUNCTION;

	FUNCTION ntoh(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN hton(a);                 -- i.e. ntoh() = hton()
	END FUNCTION;

	FUNCTION flip(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_a : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0) := a;
		VARIABLE v_b : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		FOR I IN v_a'RANGE LOOP
			v_b(a'LENGTH - 1 - I) := v_a(I);
		END LOOP;
		RETURN v_b;
	END;

	FUNCTION flip(a, w : NATURAL) RETURN NATURAL IS
	BEGIN
		RETURN TO_UINT(flip(TO_UVEC(a, w)));
	END;

	FUNCTION flip(a : t_slv_32_arr) RETURN t_slv_32_arr IS
		VARIABLE v_a : t_slv_32_arr(a'LENGTH - 1 DOWNTO 0) := a;
		VARIABLE v_b : t_slv_32_arr(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		FOR I IN v_a'RANGE LOOP
			v_b(a'LENGTH - 1 - I) := v_a(I);
		END LOOP;
		RETURN v_b;
	END;

	FUNCTION flip(a : t_integer_arr) RETURN t_integer_arr IS
		VARIABLE v_a : t_integer_arr(a'LENGTH - 1 DOWNTO 0) := a;
		VARIABLE v_b : t_integer_arr(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		FOR I IN v_a'RANGE LOOP
			v_b(a'LENGTH - 1 - I) := v_a(I);
		END LOOP;
		RETURN v_b;
	END;

	FUNCTION flip(a : t_natural_arr) RETURN t_natural_arr IS
		VARIABLE v_a : t_natural_arr(a'LENGTH - 1 DOWNTO 0) := a;
		VARIABLE v_b : t_natural_arr(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		FOR I IN v_a'RANGE LOOP
			v_b(a'LENGTH - 1 - I) := v_a(I);
		END LOOP;
		RETURN v_b;
	END;

	FUNCTION flip(a : t_nat_natural_arr) RETURN t_nat_natural_arr IS
		VARIABLE v_a : t_nat_natural_arr(a'LENGTH - 1 DOWNTO 0) := a;
		VARIABLE v_b : t_nat_natural_arr(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		FOR I IN v_a'RANGE LOOP
			v_b(a'LENGTH - 1 - I) := v_a(I);
		END LOOP;
		RETURN v_b;
	END;

	FUNCTION transpose(a : STD_LOGIC_VECTOR; row, col : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE vIn  : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0);
		VARIABLE vOut : STD_LOGIC_VECTOR(a'LENGTH - 1 DOWNTO 0);
	BEGIN
		vIn  := a;                      -- map input vector to h:0 range
		vOut := vIn;                    -- default leave any unused MSbits the same
		FOR J IN 0 TO row - 1 LOOP
			FOR I IN 0 TO col - 1 LOOP
				vOut(J * col + I) := vIn(I * row + J); -- transpose vector, map input index [i*row+j] to output index [j*col+i]
			END LOOP;
		END LOOP;
		RETURN vOut;
	END FUNCTION;

	FUNCTION transpose(a, row, col : NATURAL) RETURN NATURAL IS -- transpose index a = [i*row+j] to output index [j*col+i]
		VARIABLE vI : NATURAL;
		VARIABLE vJ : NATURAL;
	BEGIN
		vI := a / row;
		vJ := a MOD row;
		RETURN vJ * col + vI;
	END;

	FUNCTION split_w(input_w : NATURAL; min_out_w : NATURAL; max_out_w : NATURAL) RETURN NATURAL IS -- Calculate input_w in multiples as close as possible to max_out_w
		-- Examples: split_w(256, 8, 32) = 32;  split_w(16, 8, 32) = 16; split_w(72, 8, 32) = 18;    -- Input_w must be multiple of 2.
		VARIABLE r : NATURAL;
	BEGIN
		r := input_w;
		FOR i IN 1 TO ceil_log2(input_w) LOOP -- Useless to divide the number beyond this       
			IF r <= max_out_w AND r >= min_out_w THEN
				RETURN r;
			ELSIF i = ceil_log2(input_w) THEN -- last iteration
				RETURN 0;               -- Indicates wrong values were used
			END IF;
			r := r / 2;
		END LOOP;
	END;

	FUNCTION pad(str : STRING; width : NATURAL; pad_char : CHARACTER) RETURN STRING IS
		VARIABLE v_str : STRING(1 TO width) := (OTHERS => pad_char);
	BEGIN
		v_str(width - str'LENGTH + 1 TO width) := str;
		RETURN v_str;
	END;

	FUNCTION slice_up(str : STRING; width : NATURAL; i : NATURAL) RETURN STRING IS
	BEGIN
		RETURN str(i * width + 1 TO (i + 1) * width);
	END;

	-- If the input value is not a multiple of the desired width, the return value is padded with
	-- the passed pad value. E.g. if input='10' and desired width is 4, return value is '0010'.
	FUNCTION slice_up(str : STRING; width : NATURAL; i : NATURAL; pad_char : CHARACTER) RETURN STRING IS
		VARIABLE padded_str : STRING(1 TO width) := (OTHERS => '0');
	BEGIN
		padded_str := pad(str(i * width + 1 TO (i + 1) * width), width, '0');
		RETURN padded_str;
	END;

	FUNCTION slice_dn(str : STRING; width : NATURAL; i : NATURAL) RETURN STRING IS
	BEGIN
		RETURN str((i + 1) * width - 1 DOWNTO i * width);
	END;

	FUNCTION nat_arr_to_concat_slv(nat_arr : t_natural_arr; nof_elements : NATURAL) RETURN STD_LOGIC_VECTOR IS
		VARIABLE v_concat_slv : STD_LOGIC_VECTOR(nof_elements * 32 - 1 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		FOR i IN 0 TO nof_elements - 1 LOOP
			v_concat_slv(i * 32 + 32 - 1 DOWNTO i * 32) := TO_UVEC(nat_arr(i), 32);
		END LOOP;
		RETURN v_concat_slv;
	END;

	------------------------------------------------------------------------------
	-- common_fifo_*  
	------------------------------------------------------------------------------

	PROCEDURE proc_common_fifo_asserts(CONSTANT c_fifo_name   : IN STRING;
	                                   CONSTANT c_note_is_ful : IN BOOLEAN;
	                                   CONSTANT c_fail_rd_emp : IN BOOLEAN;
	                                   SIGNAL   wr_rst        : IN STD_LOGIC;
	                                   SIGNAL   wr_clk        : IN STD_LOGIC;
	                                   SIGNAL   wr_full       : IN STD_LOGIC;
	                                   SIGNAL   wr_en         : IN STD_LOGIC;
	                                   SIGNAL   rd_clk        : IN STD_LOGIC;
	                                   SIGNAL   rd_empty      : IN STD_LOGIC;
	                                   SIGNAL   rd_en         : IN STD_LOGIC) IS
	BEGIN
		-- c_fail_rd_emp : when TRUE report FAILURE when read from an empty FIFO, important when FIFO rd_val is not used
		-- c_note_is_ful : when TRUE report NOTE when FIFO goes full, to note that operation is on the limit
		-- FIFO overflow is always reported as FAILURE

		-- The FIFO wr_full goes high at reset to indicate that it can not be written and it goes low a few cycles after reset.
		-- Therefore only check on wr_full going high when wr_rst='0'.

		--synthesis translate_off
		ASSERT NOT (c_fail_rd_emp = TRUE AND rising_edge(rd_clk) AND rd_empty = '1' AND rd_en = '1') REPORT c_fifo_name & " : read from empty fifo occurred!" SEVERITY FAILURE;
		ASSERT NOT (c_note_is_ful = TRUE AND rising_edge(wr_full) AND wr_rst = '0') REPORT c_fifo_name & " : fifo is full now" SEVERITY NOTE;
		ASSERT NOT (rising_edge(wr_clk) AND wr_full = '1' AND wr_en = '1') REPORT c_fifo_name & " : fifo overflow occurred!" SEVERITY FAILURE;
		--synthesis translate_on
	END PROCEDURE proc_common_fifo_asserts;

	------------------------------------------------------------------------------
	-- common_fanout_tree 
	------------------------------------------------------------------------------

	FUNCTION func_common_fanout_tree_pipelining(c_nof_stages, c_nof_output_per_cell, c_nof_output : NATURAL;
	                                            c_cell_pipeline_factor_arr, c_cell_pipeline_arr   : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT k_cell_pipeline_factor_arr : t_natural_arr(c_nof_stages - 1 DOWNTO 0)          := c_cell_pipeline_factor_arr;
		CONSTANT k_cell_pipeline_arr        : t_natural_arr(c_nof_output_per_cell - 1 DOWNTO 0) := c_cell_pipeline_arr;
		VARIABLE v_stage_pipeline_arr       : t_natural_arr(c_nof_output - 1 DOWNTO 0)          := (OTHERS => 0);
		VARIABLE v_prev_stage_pipeline_arr  : t_natural_arr(c_nof_output - 1 DOWNTO 0)          := (OTHERS => 0);
	BEGIN
		loop_stage : FOR j IN 0 TO c_nof_stages - 1 LOOP
			v_prev_stage_pipeline_arr := v_stage_pipeline_arr;
			loop_cell : FOR i IN 0 TO c_nof_output_per_cell ** j - 1 LOOP
				v_stage_pipeline_arr((i + 1) * c_nof_output_per_cell - 1 DOWNTO i * c_nof_output_per_cell) := v_prev_stage_pipeline_arr(i) + (k_cell_pipeline_factor_arr(j) * k_cell_pipeline_arr);
			END LOOP;
		END LOOP;
		RETURN v_stage_pipeline_arr;
	END FUNCTION func_common_fanout_tree_pipelining;

	------------------------------------------------------------------------------
	-- common_reorder_symbol 
	------------------------------------------------------------------------------

	-- Determine whether the stage I and row J index refer to any (active or redundant) 2-input reorder cell instantiation
	FUNCTION func_common_reorder2_is_there(I, J : NATURAL) RETURN BOOLEAN IS
		VARIABLE v_odd  : BOOLEAN;
		VARIABLE v_even : BOOLEAN;
	BEGIN
		v_odd  := (I MOD 2 = 1) AND (J MOD 2 = 1); -- for odd  stage at each odd  row
		v_even := (I MOD 2 = 0) AND (J MOD 2 = 0); -- for even stage at each even row
		RETURN v_odd OR v_even;
	END func_common_reorder2_is_there;

	-- Determine whether the stage I and row J index refer to an active 2-input reorder cell instantiation in a reorder network with N stages
	FUNCTION func_common_reorder2_is_active(I, J, N : NATURAL) RETURN BOOLEAN IS
		VARIABLE v_inst : BOOLEAN;
		VARIABLE v_act  : BOOLEAN;
	BEGIN
		v_inst := func_common_reorder2_is_there(I, J);
		v_act  := (I > 0) AND (I <= N) AND (J > 0) AND (J < N);
		RETURN v_inst AND v_act;
	END func_common_reorder2_is_active;

	-- Get the index K in the select setting array for the reorder2 cell on stage I and row J in a reorder network with N stages
	FUNCTION func_common_reorder2_get_select_index(I, J, N : NATURAL) RETURN INTEGER IS
		CONSTANT c_nof_reorder2_per_odd_stage  : NATURAL := N / 2;
		CONSTANT c_nof_reorder2_per_even_stage : NATURAL := (N - 1) / 2;
		VARIABLE v_nof_odd_stages              : NATURAL;
		VARIABLE v_nof_even_stages             : NATURAL;
		VARIABLE v_offset                      : NATURAL;
		VARIABLE v_K                           : INTEGER;
	BEGIN
		-- for I, J that do not refer to an reorder cell instance for -1 as dummy return value.
		-- for the redundant two port reorder cells at the border rows for -1 to indicate that the cell should pass on the input.
		v_K := -1;
		IF func_common_reorder2_is_active(I, J, N) THEN
			-- for the active two port reorder cells use the setting at index v_K from the select setting array
			v_nof_odd_stages  := I / 2;
			v_nof_even_stages := (I - 1) / 2;
			v_offset          := (J - 1) / 2; -- suits both odd stage and even stage
			v_K               := v_nof_odd_stages * c_nof_reorder2_per_odd_stage + v_nof_even_stages * c_nof_reorder2_per_even_stage + v_offset;
		END IF;
		RETURN v_K;
	END func_common_reorder2_get_select_index;

	-- Get the select setting for the reorder2 cell on stage I and row J in a reorder network with N stages
	FUNCTION func_common_reorder2_get_select(I, J, N : NATURAL; select_arr : t_natural_arr) RETURN NATURAL IS
		CONSTANT c_nof_select : NATURAL                                  := select_arr'LENGTH;
		CONSTANT c_select_arr : t_natural_arr(c_nof_select - 1 DOWNTO 0) := select_arr; -- force range downto 0
		VARIABLE v_sel        : NATURAL;
		VARIABLE v_K          : INTEGER;
	BEGIN
		v_sel := 0;
		v_K   := func_common_reorder2_get_select_index(I, J, N);
		IF v_K >= 0 THEN
			v_sel := c_select_arr(v_K);
		END IF;
		RETURN v_sel;
	END func_common_reorder2_get_select;

	-- Determine the inverse of a reorder network by using two reorder networks in series
	FUNCTION func_common_reorder2_inverse_select(N : NATURAL; select_arr : t_natural_arr) RETURN t_natural_arr IS
		CONSTANT c_nof_select  : NATURAL                                      := select_arr'LENGTH;
		CONSTANT c_select_arr  : t_natural_arr(c_nof_select - 1 DOWNTO 0)     := select_arr; -- force range downto 0
		VARIABLE v_sel         : NATURAL;
		VARIABLE v_Ki          : INTEGER;
		VARIABLE v_Ii          : NATURAL;
		VARIABLE v_inverse_arr : t_natural_arr(2 * c_nof_select - 1 DOWNTO 0) := (OTHERS => 0); -- default set identity for the reorder2 cells in both reorder instances
	BEGIN
		-- the inverse select consists of inverse_in reorder and inverse_out reorder in series
		IF N MOD 2 = 1 THEN
			-- N is odd so only need to fill in the inverse_in reorder, the inverse_out reorder remains at default pass on
			FOR I IN 1 TO N LOOP
				FOR J IN 0 TO N - 1 LOOP
					-- get the DUT setting
					v_sel := func_common_reorder2_get_select(I, J, N, c_select_arr);
					-- map DUT I to inverse v_Ii stage index and determine the index for the inverse setting
					v_Ii  := 1 + N - I;
					v_Ki  := func_common_reorder2_get_select_index(v_Ii, J, N);
					IF v_Ki >= 0 THEN
						v_inverse_arr(v_Ki) := v_sel;
					END IF;
				END LOOP;
			END LOOP;
		ELSE
			-- N is even so only use stage 1 of the inverse_out reorder, the other stages remain at default pass on
			FOR K IN 0 TO N / 2 - 1 LOOP
				v_Ki                := c_nof_select + K; -- stage 1 of the inverse_out reorder
				v_inverse_arr(v_Ki) := c_select_arr(K);
			END LOOP;
			-- N is even so leave stage 1 of the inverse_in reorder at default pass on, and do inverse the other stages
			FOR I IN 2 TO N LOOP
				FOR J IN 0 TO N - 1 LOOP
					-- get the DUT setting
					v_sel := func_common_reorder2_get_select(I, J, N, c_select_arr);
					-- map DUT I to inverse v_Ii stage index and determine the index for the inverse setting
					v_Ii  := 2 + N - I;
					v_Ki  := func_common_reorder2_get_select_index(v_Ii, J, N);
					IF v_Ki >= 0 THEN
						v_inverse_arr(v_Ki) := v_sel;
					END IF;
				END LOOP;
			END LOOP;
		END IF;
		RETURN v_inverse_arr;
	END func_common_reorder2_inverse_select;

	------------------------------------------------------------------------------
	-- PROCEDURE: Generate faster sample SCLK from digital DCLK for sim only
	-- Description:
	--   The SCLK kan be used to serialize Pfactor >= 1 symbols per word and then 
	--   view them in a scope component that is use internally in the design.
	--   The scope component is only instantiated for simulation, to view the
	--   serialized symbols, typically with decimal radix and analogue format.
	--   The scope component will not be synthesized, because the SCLK can not
	--   be synthesized.
	--   
	--   Pfactor = 4
	--            _______         _______         _______         _______
	--   DCLK ___|       |_______|       |_______|       |_______|       |_______
	--        ___________________   _   _   _   _   _   _   _   _   _   _   _   _
	--   SCLK                    |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_|
	--
	--   The rising edges of SCLK occur after the rising edge of DCLK, to ensure
	--   that they all apply to the same wide data word that was clocked by the
	--   rising edge of the DCLK.
	------------------------------------------------------------------------------
	PROCEDURE proc_common_dclk_generate_sclk(CONSTANT Pfactor : IN POSITIVE;
	                                         SIGNAL   dclk    : IN STD_LOGIC;
	                                         SIGNAL   sclk    : INOUT STD_LOGIC) IS
		VARIABLE v_dperiod : TIME;
		VARIABLE v_speriod : TIME;
	BEGIN
		SCLK      <= '1';
		-- Measure DCLK period
		WAIT UNTIL rising_edge(DCLK);
		v_dperiod := NOW;
		WAIT UNTIL rising_edge(DCLK);
		v_dperiod := NOW - v_dperiod;
		v_speriod := v_dperiod / Pfactor;
		-- Generate Pfactor SCLK periods per DCLK period
		WHILE TRUE LOOP
			-- Realign at every DCLK
			WAIT UNTIL rising_edge(DCLK);
			-- Create Pfactor SCLK periods within this DCLK period
			SCLK <= '0';
			IF Pfactor > 1 THEN
				FOR I IN 0 TO 2 * Pfactor - 1 - 2 LOOP
					WAIT FOR v_speriod / 2;
					SCLK <= NOT SCLK;
				END LOOP;
			END IF;
			WAIT FOR v_speriod / 2;
			SCLK <= '1';
			-- Wait for next DCLK
		END LOOP;
		WAIT;
	END proc_common_dclk_generate_sclk;

	function stringround_to_enum_round(stringin : string) return t_rounding_mode is
	begin
		-- use an ugly if because CASE expects string to always be the same length
		if stringin = "ROUND" then
			return ROUND;
		elsif stringin = "ROUNDINF" then
			return ROUNDINF;
		else
			return TRUNCATE;
		end if;
	end function stringround_to_enum_round;
END common_pkg;
