--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------

-- Author:
-- . Eric Kooistra
-- Purpose:
-- . Linear Feedback Shift Register based pseudo random sequence generation.
-- Interface:
-- . [n/a]
-- Description:
-- . Based on Xilinx application note xapp052.

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.common_pkg.ALL;

PACKAGE common_lfsr_sequences_pkg IS

	CONSTANT c_common_lfsr_max_nof_feedbacks : NATURAL := 6;
	CONSTANT c_common_lfsr_first             : NATURAL := 1; -- also support n = 1 and 2 in addition to n >= 3

	TYPE t_FEEDBACKS IS ARRAY (c_common_lfsr_max_nof_feedbacks - 1 DOWNTO 0) OF NATURAL;
	TYPE t_SEQUENCES IS ARRAY (NATURAL RANGE <>) OF t_FEEDBACKS;

	-- XNOR feedbacks for n = 1:
	--   (0,0,0,0,0, 0) yields repeat <1>
	--   (0,0,0,0,0, 1) yields repeat <0, 1>

	-- XNOR feedbacks for n = 2:
	--   (0,0,0,0, 0, 1) yields repeat <1, 2>
	--   (0,0,0,0, 0, 2) yields repeat <0, 1, 3, 2>
	--   (0,0,0,0, 2, 1) yields repeat <0, 1, 2>

	-- XNOR feedbacks from outputs for n = 3 .. 72 from Xilinx xapp052.pdf (that lists feedbacks for in total 168 sequences)
	CONSTANT c_common_lfsr_sequences : t_SEQUENCES := ((0, 0, 0, 0, 0, 1), -- 1 : <0, 1>
	                                                   (0, 0, 0, 0, 0, 2), -- 2 : <0, 1, 3, 2>
	                                                   (0, 0, 0, 0, 3, 2), -- 3
	                                                   (0, 0, 0, 0, 4, 3), -- 4
	                                                   (0, 0, 0, 0, 5, 3), -- 5
	                                                   (0, 0, 0, 0, 6, 5), -- 6
	                                                   (0, 0, 0, 0, 7, 6), -- 7
	                                                   (0, 0, 8, 6, 5, 4), -- 8
	                                                   (0, 0, 0, 0, 9, 5), -- 9
	                                                   (0, 0, 0, 0, 10, 7), -- 10
	                                                   (0, 0, 0, 0, 11, 9), -- 11
	                                                   (0, 0, 12, 6, 4, 1), -- 12
	                                                   (0, 0, 13, 4, 3, 1), -- 13
	                                                   (0, 0, 14, 5, 3, 1), -- 14
	                                                   (0, 0, 0, 0, 15, 14), -- 15
	                                                   (0, 0, 16, 15, 13, 4), -- 16
	                                                   (0, 0, 0, 0, 17, 14), -- 17
	                                                   (0, 0, 0, 0, 18, 11), -- 18
	                                                   (0, 0, 19, 6, 2, 1), -- 19
	                                                   (0, 0, 0, 0, 20, 17), -- 20
	                                                   (0, 0, 0, 0, 21, 19), -- 21
	                                                   (0, 0, 0, 0, 22, 21), -- 22
	                                                   (0, 0, 0, 0, 23, 18), -- 23
	                                                   (0, 0, 24, 23, 22, 17), -- 24
	                                                   (0, 0, 0, 0, 25, 22), -- 25
	                                                   (0, 0, 26, 6, 2, 1), -- 26
	                                                   (0, 0, 27, 5, 2, 1), -- 27
	                                                   (0, 0, 0, 0, 28, 25), -- 28
	                                                   (0, 0, 0, 0, 29, 27), -- 29
	                                                   (0, 0, 30, 6, 4, 1), -- 30
	                                                   (0, 0, 0, 0, 31, 28), -- 31
	                                                   (0, 0, 32, 22, 2, 1), -- 32
	                                                   (0, 0, 0, 0, 33, 20), -- 33
	                                                   (0, 0, 34, 27, 2, 1), -- 34
	                                                   (0, 0, 0, 0, 35, 33), -- 35
	                                                   (0, 0, 0, 0, 36, 25), -- 36
	                                                   (37, 5, 4, 3, 2, 1), -- 37
	                                                   (0, 0, 38, 6, 5, 1), -- 38
	                                                   (0, 0, 0, 0, 39, 35), -- 39
	                                                   (0, 0, 40, 38, 21, 19), -- 40
	                                                   (0, 0, 0, 0, 41, 38), -- 41
	                                                   (0, 0, 42, 41, 20, 19), -- 42
	                                                   (0, 0, 43, 42, 38, 37), -- 43
	                                                   (0, 0, 44, 43, 18, 17), -- 44
	                                                   (0, 0, 45, 44, 42, 41), -- 45
	                                                   (0, 0, 46, 45, 26, 25), -- 46
	                                                   (0, 0, 0, 0, 47, 42), -- 47
	                                                   (0, 0, 48, 47, 21, 20), -- 48
	                                                   (0, 0, 0, 0, 49, 40), -- 49
	                                                   (0, 0, 50, 49, 24, 23), -- 50
	                                                   (0, 0, 51, 50, 36, 35), -- 51
	                                                   (0, 0, 0, 0, 52, 49), -- 52
	                                                   (0, 0, 53, 52, 38, 37), -- 53
	                                                   (0, 0, 54, 53, 18, 17), -- 54
	                                                   (0, 0, 0, 0, 55, 31), -- 55
	                                                   (0, 0, 56, 55, 35, 34), -- 56
	                                                   (0, 0, 0, 0, 57, 50), -- 57
	                                                   (0, 0, 0, 0, 58, 39), -- 58
	                                                   (0, 0, 59, 58, 38, 37), -- 59
	                                                   (0, 0, 0, 0, 60, 59), -- 60
	                                                   (0, 0, 61, 60, 46, 45), -- 61
	                                                   (0, 0, 62, 61, 6, 5), -- 62
	                                                   (0, 0, 0, 0, 63, 62), -- 63
	                                                   (0, 0, 64, 63, 61, 60), -- 64
	                                                   (0, 0, 0, 0, 65, 47), -- 65
	                                                   (0, 0, 66, 65, 57, 56), -- 66
	                                                   (0, 0, 67, 66, 58, 57), -- 67
	                                                   (0, 0, 0, 0, 68, 59), -- 68
	                                                   (0, 0, 69, 67, 42, 40), -- 69
	                                                   (0, 0, 70, 69, 55, 54), -- 70
	                                                   (0, 0, 0, 0, 71, 65), -- 71
	                                                   (0, 0, 72, 66, 25, 19)); -- 72

	-- Procedure for calculating the next PSRG and COUNTER sequence value
	PROCEDURE common_lfsr_nxt_seq(CONSTANT c_lfsr_nr : IN NATURAL;
	                              CONSTANT g_incr    : IN INTEGER;
	                              in_en              : IN STD_LOGIC;
	                              in_req             : IN STD_LOGIC;
	                              in_dat             : IN STD_LOGIC_VECTOR;
	                              prsg               : IN STD_LOGIC_VECTOR;
	                              cntr               : IN STD_LOGIC_VECTOR;
	                              SIGNAL nxt_prsg    : OUT STD_LOGIC_VECTOR;
	                              SIGNAL nxt_cntr    : OUT STD_LOGIC_VECTOR);

	-- Use lfsr part of common_lfsr_nxt_seq to make a random bit generator function
	-- . width of lfsr selects the LFSR sequence
	-- . initialized lfsr with (OTHERS=>'0')
	-- . use lfsr(lfsr'HIGH) as random bit
	FUNCTION func_common_random(lfsr : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

END common_lfsr_sequences_pkg;

PACKAGE BODY common_lfsr_sequences_pkg IS

	PROCEDURE common_lfsr_nxt_seq(CONSTANT c_lfsr_nr : IN NATURAL;
	                              CONSTANT g_incr    : IN INTEGER;
	                              in_en              : IN STD_LOGIC;
	                              in_req             : IN STD_LOGIC;
	                              in_dat             : IN STD_LOGIC_VECTOR;
	                              prsg               : IN STD_LOGIC_VECTOR;
	                              cntr               : IN STD_LOGIC_VECTOR;
	                              SIGNAL nxt_prsg    : OUT STD_LOGIC_VECTOR;
	                              SIGNAL nxt_cntr    : OUT STD_LOGIC_VECTOR) IS
		VARIABLE v_feedback : STD_LOGIC;
	BEGIN
		nxt_prsg <= prsg;
		nxt_cntr <= cntr;
		IF in_en = '0' THEN             -- init reference value
			nxt_prsg <= in_dat;
			nxt_cntr <= in_dat;
		ELSIF in_req = '1' THEN         -- next reference value
			-- PRSG shift
			nxt_prsg    <= prsg(prsg'HIGH - 1 DOWNTO 0) & '0';
			-- PRSG feedback
			v_feedback  := '0';
			FOR I IN c_common_lfsr_max_nof_feedbacks - 1 DOWNTO 0 LOOP
				IF c_common_lfsr_sequences(c_lfsr_nr)(I) /= 0 THEN
					v_feedback := v_feedback XOR prsg(c_common_lfsr_sequences(c_lfsr_nr)(I) - 1);
				END IF;
			END LOOP;
			nxt_prsg(0) <= NOT v_feedback;

			-- COUNTER
			nxt_cntr <= INCR_UVEC(cntr, g_incr);
		END IF;
	END common_lfsr_nxt_seq;

	FUNCTION func_common_random(lfsr : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
		CONSTANT c_lfsr_nr  : NATURAL := lfsr'LENGTH - c_common_lfsr_first;
		VARIABLE v_nxt_lfsr : STD_LOGIC_VECTOR(lfsr'RANGE);
		VARIABLE v_feedback : STD_LOGIC;
	BEGIN
		-- shift
		v_nxt_lfsr    := lfsr(lfsr'HIGH - 1 DOWNTO 0) & '0';
		-- feedback
		v_feedback    := '0';
		FOR I IN c_common_lfsr_max_nof_feedbacks - 1 DOWNTO 0 LOOP
			IF c_common_lfsr_sequences(c_lfsr_nr)(I) /= 0 THEN
				v_feedback := v_feedback XOR lfsr(c_common_lfsr_sequences(c_lfsr_nr)(I) - 1);
			END IF;
		END LOOP;
		v_nxt_lfsr(0) := NOT v_feedback;
		RETURN v_nxt_lfsr;
	END func_common_random;

END common_lfsr_sequences_pkg;
