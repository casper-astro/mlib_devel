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
-- Purpose:
-- . Collection of commonly used base funtions for simulations
-- Interface:
-- . [n/a]
-- Description:
-- . More information can be found in the comments near the code.

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE std.textio.ALL;                     -- for boolean, integer file IO
USE IEEE.std_logic_textio.ALL;          -- for std_logic, std_logic_vector file IO
USE work.common_pkg.ALL;

PACKAGE tb_common_pkg IS

	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk   : IN STD_LOGIC;
	                                       c_nof_cycles : IN NATURAL);

	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk   : IN STD_LOGIC;
	                                       c_nof_cycles : IN REAL);

	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk_in  : IN STD_LOGIC;
	                                       SIGNAL clk_out : IN STD_LOGIC;
	                                       c_nof_cycles   : IN NATURAL);

	PROCEDURE proc_common_wait_some_pulses(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL pulse : IN STD_LOGIC;
	                                       c_nof_pulses : IN NATURAL);

	PROCEDURE proc_common_wait_until_evt(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_evt(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN INTEGER);

	PROCEDURE proc_common_wait_until_evt(CONSTANT c_timeout : IN NATURAL;
	                                     SIGNAL clk         : IN STD_LOGIC;
	                                     SIGNAL level       : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_high(CONSTANT c_timeout : IN NATURAL;
	                                      SIGNAL clk         : IN STD_LOGIC;
	                                      SIGNAL level       : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_high(SIGNAL clk   : IN STD_LOGIC;
	                                      SIGNAL level : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_low(CONSTANT c_timeout : IN NATURAL;
	                                     SIGNAL clk         : IN STD_LOGIC;
	                                     SIGNAL level       : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_low(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_hi_lo(CONSTANT c_timeout : IN NATURAL;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_hi_lo(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL level : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_lo_hi(CONSTANT c_timeout : IN NATURAL;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_lo_hi(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL level : IN STD_LOGIC);

	PROCEDURE proc_common_wait_until_value(CONSTANT c_value : IN INTEGER;
	                                       SIGNAL clk       : IN STD_LOGIC;
	                                       SIGNAL level     : IN INTEGER);

	PROCEDURE proc_common_wait_until_value(CONSTANT c_value : IN INTEGER;
	                                       SIGNAL clk       : IN STD_LOGIC;
	                                       SIGNAL level     : IN STD_LOGIC_VECTOR);

	PROCEDURE proc_common_wait_until_value(CONSTANT c_timeout : IN NATURAL;
	                                       CONSTANT c_value   : IN INTEGER;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC_VECTOR);

	-- Wait until absolute simulation time NOW = c_time
	PROCEDURE proc_common_wait_until_time(SIGNAL clk      : IN STD_LOGIC;
	                                      CONSTANT c_time : IN TIME);

	-- Exit simulation on timeout failure                                         
	PROCEDURE proc_common_timeout_failure(CONSTANT c_timeout : IN TIME;
	                                      SIGNAL tb_end      : IN STD_LOGIC);

	-- Stop simulation using severity FAILURE when g_tb_end=TRUE, else for use in multi tb report as severity NOTE
	PROCEDURE proc_common_stop_simulation(SIGNAL tb_end : IN STD_LOGIC);

	PROCEDURE proc_common_stop_simulation(CONSTANT g_tb_end  : IN BOOLEAN;
	                                      CONSTANT g_latency : IN NATURAL; -- latency between tb_done and tb_)end
	                                      SIGNAL clk         : IN STD_LOGIC;
	                                      SIGNAL tb_done     : IN STD_LOGIC;
	                                      SIGNAL tb_end      : OUT STD_LOGIC);

	PROCEDURE proc_common_stop_simulation(CONSTANT g_tb_end : IN BOOLEAN;
	                                      SIGNAL clk        : IN STD_LOGIC;
	                                      SIGNAL tb_done    : IN STD_LOGIC;
	                                      SIGNAL tb_end     : OUT STD_LOGIC);

	-- Handle stream ready signal, only support ready latency c_rl = 0 or 1.
	PROCEDURE proc_common_ready_latency(CONSTANT c_rl    : IN NATURAL;
	                                    SIGNAL clk       : IN STD_LOGIC;
	                                    SIGNAL enable    : IN STD_LOGIC; -- when '1' then active output when ready
	                                    SIGNAL ready     : IN STD_LOGIC;
	                                    SIGNAL out_valid : OUT STD_LOGIC);

	-- Generate a single active, inactive pulse
	PROCEDURE proc_common_gen_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                SIGNAL clk        : IN STD_LOGIC;
	                                SIGNAL pulse      : OUT STD_LOGIC);

	-- Pulse forever after rst was released
	PROCEDURE proc_common_gen_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                SIGNAL rst        : IN STD_LOGIC;
	                                SIGNAL clk        : IN STD_LOGIC;
	                                SIGNAL pulse      : OUT STD_LOGIC);

	-- Generate a single '1', '0' pulse
	PROCEDURE proc_common_gen_pulse(SIGNAL clk   : IN STD_LOGIC;
	                                SIGNAL pulse : OUT STD_LOGIC);

	-- Generate a periodic pulse with arbitrary duty cycle
	PROCEDURE proc_common_gen_duty_pulse(CONSTANT c_delay  : IN NATURAL; -- delay pulse for nof_clk after enable
	                                     CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                     CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                     CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                     SIGNAL rst        : IN STD_LOGIC;
	                                     SIGNAL clk        : IN STD_LOGIC;
	                                     SIGNAL enable     : IN STD_LOGIC; -- once enabled, the pulse remains enabled
	                                     SIGNAL pulse      : OUT STD_LOGIC);

	PROCEDURE proc_common_gen_duty_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                     CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                     CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                     SIGNAL rst        : IN STD_LOGIC;
	                                     SIGNAL clk        : IN STD_LOGIC;
	                                     SIGNAL enable     : IN STD_LOGIC; -- once enabled, the pulse remains enabled
	                                     SIGNAL pulse      : OUT STD_LOGIC);

	-- Generate counter data with valid and arbitrary increment or fixed increment=1
	PROCEDURE proc_common_gen_data(CONSTANT c_rl    : IN NATURAL; -- 0, 1 are supported by proc_common_ready_latency()
	                               CONSTANT c_init  : IN INTEGER;
	                               CONSTANT c_incr  : IN INTEGER;
	                               SIGNAL rst       : IN STD_LOGIC;
	                               SIGNAL clk       : IN STD_LOGIC;
	                               SIGNAL enable    : IN STD_LOGIC; -- when '0' then no valid output even when ready='1'
	                               SIGNAL ready     : IN STD_LOGIC;
	                               SIGNAL out_data  : OUT STD_LOGIC_VECTOR;
	                               SIGNAL out_valid : OUT STD_LOGIC);

	PROCEDURE proc_common_gen_data(CONSTANT c_rl    : IN NATURAL; -- 0, 1 are supported by proc_common_ready_latency()
	                               CONSTANT c_init  : IN INTEGER;
	                               SIGNAL rst       : IN STD_LOGIC;
	                               SIGNAL clk       : IN STD_LOGIC;
	                               SIGNAL enable    : IN STD_LOGIC; -- when '0' then no valid output even when ready='1'
	                               SIGNAL ready     : IN STD_LOGIC;
	                               SIGNAL out_data  : OUT STD_LOGIC_VECTOR;
	                               SIGNAL out_valid : OUT STD_LOGIC);

	-- Generate frame control
	PROCEDURE proc_common_sop(SIGNAL clk    : IN STD_LOGIC;
	                          SIGNAL in_val : OUT STD_LOGIC;
	                          SIGNAL in_sop : OUT STD_LOGIC);

	PROCEDURE proc_common_eop(SIGNAL clk    : IN STD_LOGIC;
	                          SIGNAL in_val : OUT STD_LOGIC;
	                          SIGNAL in_eop : OUT STD_LOGIC);

	PROCEDURE proc_common_val(CONSTANT c_val_len : IN NATURAL;
	                          SIGNAL clk         : IN STD_LOGIC;
	                          SIGNAL in_val      : OUT STD_LOGIC);

	PROCEDURE proc_common_val_duty(CONSTANT c_hi_len : IN NATURAL;
	                               CONSTANT c_lo_len : IN NATURAL;
	                               SIGNAL clk        : IN STD_LOGIC;
	                               SIGNAL in_val     : OUT STD_LOGIC);

	PROCEDURE proc_common_eop_flush(CONSTANT c_flush_len : IN NATURAL;
	                                SIGNAL clk           : IN STD_LOGIC;
	                                SIGNAL in_val        : OUT STD_LOGIC;
	                                SIGNAL in_eop        : OUT STD_LOGIC);

	-- Verify the DUT output incrementing data, only support ready latency c_rl = 0 or 1.
	PROCEDURE proc_common_verify_data(CONSTANT c_rl        : IN NATURAL;
	                                  SIGNAL clk           : IN STD_LOGIC;
									  SIGNAL rst		   : IN STD_LOGIC;
	                                  SIGNAL verify_en     : IN STD_LOGIC;
	                                  SIGNAL ready         : IN STD_LOGIC;
	                                  SIGNAL out_valid     : IN STD_LOGIC;
	                                  SIGNAL out_data      : IN STD_LOGIC_VECTOR;
	                                  SIGNAL prev_out_data : INOUT STD_LOGIC_VECTOR;
																		SIGNAL test_msg			 : OUT STRING;
																		SIGNAL test_pass		 : OUT BOOLEAN);

	-- Verify the DUT output valid for ready latency, only support ready latency c_rl = 0 or 1.
	PROCEDURE proc_common_verify_valid(CONSTANT c_rl     : IN NATURAL;
	                                   SIGNAL clk        : IN STD_LOGIC;
	                                   SIGNAL verify_en  : IN STD_LOGIC;
	                                   SIGNAL ready      : IN STD_LOGIC;
	                                   SIGNAL prev_ready : INOUT STD_LOGIC;
	                                   SIGNAL out_valid  : IN STD_LOGIC;
																		 SIGNAL test_msg	 : OUT STRING;
																		 SIGNAL test_pass	 : OUT BOOLEAN);

	-- Verify the DUT input to output latency for SL ctrl signals
	PROCEDURE proc_common_verify_latency(CONSTANT c_str       : IN STRING; -- e.g. "valid", "sop", "eop"
	                                     CONSTANT c_latency   : IN NATURAL;
	                                     SIGNAL clk           : IN STD_LOGIC;
	                                     SIGNAL verify_en     : IN STD_LOGIC;
	                                     SIGNAL in_ctrl       : IN STD_LOGIC;
	                                     SIGNAL pipe_ctrl_vec : INOUT STD_LOGIC_VECTOR; -- range [0:c_latency]
	                                     SIGNAL out_ctrl      : IN STD_LOGIC;
																			 SIGNAL test_msg	 : OUT STRING;
																			 SIGNAL test_pass	 : OUT BOOLEAN);

	-- Verify the DUT input to output latency for SLV data signals
	PROCEDURE proc_common_verify_latency(CONSTANT c_str       : IN STRING; -- e.g. "data"
	                                     CONSTANT c_latency   : IN NATURAL;
	                                     SIGNAL clk           : IN STD_LOGIC;
	                                     SIGNAL verify_en     : IN STD_LOGIC;
	                                     SIGNAL in_data       : IN STD_LOGIC_VECTOR;
	                                     SIGNAL pipe_data_vec : INOUT STD_LOGIC_VECTOR; -- range [0:(1 + c_latency)*c_data_w-1]
	                                     SIGNAL out_data      : IN STD_LOGIC_VECTOR;
																			 SIGNAL test_msg	 : OUT STRING;
																			 SIGNAL test_pass	 : OUT BOOLEAN);

	-- Verify the expected value, e.g. to check that a test has ran at all
	PROCEDURE proc_common_verify_value(CONSTANT mode : IN NATURAL;
	                                   SIGNAL clk    : IN STD_LOGIC;
	                                   SIGNAL en     : IN STD_LOGIC;
	                                   SIGNAL exp    : IN STD_LOGIC_VECTOR;
	                                   SIGNAL res    : IN STD_LOGIC_VECTOR);
	-- open, read line, close file
	PROCEDURE proc_common_open_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                FILE in_file : TEXT;
	                                file_name    : IN STRING;
	                                file_mode    : IN FILE_OPEN_KIND);

	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_value_0 : OUT INTEGER);

	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_value_0 : OUT INTEGER;
	                                    read_value_1 : OUT INTEGER);

	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    value_array  : OUT t_integer_arr;
	                                    nof_reads    : IN INTEGER);

	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_slv     : OUT STD_LOGIC_VECTOR);

	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    res_string   : OUT STRING);

	PROCEDURE proc_common_close_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                 FILE in_file : TEXT);

	-- read entire file
	PROCEDURE proc_common_read_integer_file(file_name           : IN STRING;
	                                        nof_header_lines    : NATURAL;
	                                        nof_row             : NATURAL;
	                                        nof_col             : NATURAL;
	                                        SIGNAL return_array : OUT t_integer_arr);

	PROCEDURE proc_common_read_mif_file(file_name           : IN STRING;
	                                    SIGNAL return_array : OUT t_integer_arr);

	PROCEDURE proc_common_read_mem_file(file_name           : IN STRING;
	                                    SIGNAL return_array : OUT t_integer_arr);									

	PROCEDURE csv_parse_line_to_array(line_in : IN STRING;
								delimiter : IN CHARACTER;
								value_array : OUT t_nat_integer_arr;
								nof_values : OUT INTEGER);									
	PROCEDURE csv_read_file_to_array(file_status  : INOUT FILE_OPEN_STATUS;
                             FILE in_file : TEXT;
                             value_matrix : OUT t_nat_integer_matrix;
                             max_lines    : IN INTEGER;
                             delimiter    : IN CHARACTER);
	
	PROCEDURE csv_open_and_read_file(file_name : IN STRING;
								value_matrix : OUT t_nat_integer_matrix;
								max_lines    : IN INTEGER;
								delimiter    : IN CHARACTER);

	-- Complex multiply function with conjugate option for input b
	FUNCTION func_complex_multiply(in_ar, in_ai, in_br, in_bi : STD_LOGIC_VECTOR; conjugate_b : BOOLEAN; str : STRING; g_out_dat_w : NATURAL) RETURN STD_LOGIC_VECTOR;

	FUNCTION func_decstring_to_integer(in_string : STRING) RETURN INTEGER;

	FUNCTION func_hexstring_to_integer(in_string : STRING) RETURN INTEGER;

	FUNCTION func_find_char_in_string(in_string : STRING; find_char : CHARACTER) RETURN INTEGER;

	FUNCTION func_find_string_in_string(in_string : STRING; find_string : STRING) RETURN BOOLEAN;

END tb_common_pkg;

PACKAGE BODY tb_common_pkg IS

	------------------------------------------------------------------------------
	-- PROCEDURE: Wait some clock cycles
	------------------------------------------------------------------------------
	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk   : IN STD_LOGIC;
	                                       c_nof_cycles : IN NATURAL) IS
	BEGIN
		FOR I IN 0 TO c_nof_cycles - 1 LOOP
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_wait_some_cycles;

	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk   : IN STD_LOGIC;
	                                       c_nof_cycles : IN REAL) IS
	BEGIN
		proc_common_wait_some_cycles(clk, NATURAL(c_nof_cycles));
	END proc_common_wait_some_cycles;

	PROCEDURE proc_common_wait_some_cycles(SIGNAL clk_in  : IN STD_LOGIC;
	                                       SIGNAL clk_out : IN STD_LOGIC;
	                                       c_nof_cycles   : IN NATURAL) IS
	BEGIN
		proc_common_wait_some_cycles(clk_in, c_nof_cycles);
		proc_common_wait_some_cycles(clk_out, c_nof_cycles);
	END proc_common_wait_some_cycles;

	------------------------------------------------------------------------------
	-- PROCEDURE: Wait some pulses
	------------------------------------------------------------------------------
	PROCEDURE proc_common_wait_some_pulses(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL pulse : IN STD_LOGIC;
	                                       c_nof_pulses : IN NATURAL) IS
	BEGIN
		FOR I IN 0 TO c_nof_pulses - 1 LOOP
			proc_common_wait_until_hi_lo(clk, pulse);
		END LOOP;
	END proc_common_wait_some_pulses;

	------------------------------------------------------------------------------
	-- PROCEDURE: Wait until the level input event
	-- PROCEDURE: Wait until the level input is high
	-- PROCEDURE: Wait until the level input is low
	-- PROCEDURE: Wait until the       input is equal to c_value
	------------------------------------------------------------------------------
	PROCEDURE proc_common_wait_until_evt(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN STD_LOGIC) IS
		VARIABLE v_level : STD_LOGIC := level;
	BEGIN
		WAIT UNTIL rising_edge(clk);
		WHILE v_level = level LOOP
			v_level := level;
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_wait_until_evt;

	PROCEDURE proc_common_wait_until_evt(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN INTEGER) IS
		VARIABLE v_level : INTEGER := level;
	BEGIN
		WAIT UNTIL rising_edge(clk);
		WHILE v_level = level LOOP
			v_level := level;
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_wait_until_evt;

	PROCEDURE proc_common_wait_until_evt(CONSTANT c_timeout : IN NATURAL;
	                                     SIGNAL clk         : IN STD_LOGIC;
	                                     SIGNAL level       : IN STD_LOGIC) IS
		VARIABLE v_level : STD_LOGIC := level;
		VARIABLE v_I     : NATURAL   := 0;
	BEGIN
		WAIT UNTIL rising_edge(clk);
		WHILE v_level = level LOOP
			v_level := level;
			WAIT UNTIL rising_edge(clk);
			v_I     := v_I + 1;
			IF v_I >= c_timeout - 1 THEN
				REPORT "COMMON : level evt timeout" SEVERITY ERROR;
				EXIT;
			END IF;
		END LOOP;
	END proc_common_wait_until_evt;

	PROCEDURE proc_common_wait_until_high(SIGNAL clk   : IN STD_LOGIC;
	                                      SIGNAL level : IN STD_LOGIC) IS
	BEGIN
		IF level /= '1' THEN
			WAIT UNTIL rising_edge(clk) AND level = '1';
		END IF;
	END proc_common_wait_until_high;

	PROCEDURE proc_common_wait_until_high(CONSTANT c_timeout : IN NATURAL;
	                                      SIGNAL clk         : IN STD_LOGIC;
	                                      SIGNAL level       : IN STD_LOGIC) IS
	BEGIN
		FOR I IN 0 TO c_timeout - 1 LOOP
			IF level = '1' THEN
				EXIT;
			ELSE
				IF I = c_timeout - 1 THEN
					REPORT "COMMON : level high timeout" SEVERITY ERROR;
				END IF;
				WAIT UNTIL rising_edge(clk);
			END IF;
		END LOOP;
	END proc_common_wait_until_high;

	PROCEDURE proc_common_wait_until_low(SIGNAL clk   : IN STD_LOGIC;
	                                     SIGNAL level : IN STD_LOGIC) IS
	BEGIN
		IF level /= '0' THEN
			WAIT UNTIL rising_edge(clk) AND level = '0';
		END IF;
	END proc_common_wait_until_low;

	PROCEDURE proc_common_wait_until_low(CONSTANT c_timeout : IN NATURAL;
	                                     SIGNAL clk         : IN STD_LOGIC;
	                                     SIGNAL level       : IN STD_LOGIC) IS
	BEGIN
		FOR I IN 0 TO c_timeout - 1 LOOP
			IF level = '0' THEN
				EXIT;
			ELSE
				IF I = c_timeout - 1 THEN
					REPORT "COMMON : level low timeout" SEVERITY ERROR;
				END IF;
				WAIT UNTIL rising_edge(clk);
			END IF;
		END LOOP;
	END proc_common_wait_until_low;

	PROCEDURE proc_common_wait_until_hi_lo(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL level : IN STD_LOGIC) IS
	BEGIN
		IF level /= '1' THEN
			proc_common_wait_until_high(clk, level);
		END IF;
		proc_common_wait_until_low(clk, level);
	END proc_common_wait_until_hi_lo;

	PROCEDURE proc_common_wait_until_hi_lo(CONSTANT c_timeout : IN NATURAL;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC) IS
	BEGIN
		IF level /= '1' THEN
			proc_common_wait_until_high(c_timeout, clk, level);
		END IF;
		proc_common_wait_until_low(c_timeout, clk, level);
	END proc_common_wait_until_hi_lo;

	PROCEDURE proc_common_wait_until_lo_hi(SIGNAL clk   : IN STD_LOGIC;
	                                       SIGNAL level : IN STD_LOGIC) IS
	BEGIN
		IF level /= '0' THEN
			proc_common_wait_until_low(clk, level);
		END IF;
		proc_common_wait_until_high(clk, level);
	END proc_common_wait_until_lo_hi;

	PROCEDURE proc_common_wait_until_lo_hi(CONSTANT c_timeout : IN NATURAL;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC) IS
	BEGIN
		IF level /= '0' THEN
			proc_common_wait_until_low(c_timeout, clk, level);
		END IF;
		proc_common_wait_until_high(c_timeout, clk, level);
	END proc_common_wait_until_lo_hi;

	PROCEDURE proc_common_wait_until_value(CONSTANT c_value : IN INTEGER;
	                                       SIGNAL clk       : IN STD_LOGIC;
	                                       SIGNAL level     : IN INTEGER) IS
	BEGIN
		WHILE level /= c_value LOOP
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_wait_until_value;

	PROCEDURE proc_common_wait_until_value(CONSTANT c_value : IN INTEGER;
	                                       SIGNAL clk       : IN STD_LOGIC;
	                                       SIGNAL level     : IN STD_LOGIC_VECTOR) IS
	BEGIN
		WHILE SIGNED(level) /= c_value LOOP
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_wait_until_value;

	PROCEDURE proc_common_wait_until_value(CONSTANT c_timeout : IN NATURAL;
	                                       CONSTANT c_value   : IN INTEGER;
	                                       SIGNAL clk         : IN STD_LOGIC;
	                                       SIGNAL level       : IN STD_LOGIC_VECTOR) IS
	BEGIN
		FOR I IN 0 TO c_timeout - 1 LOOP
			IF SIGNED(level) = c_value THEN
				EXIT;
			ELSE
				IF I = c_timeout - 1 THEN
					REPORT "COMMON : level value timeout" SEVERITY ERROR;
				END IF;
				WAIT UNTIL rising_edge(clk);
			END IF;
		END LOOP;
	END proc_common_wait_until_value;

	PROCEDURE proc_common_wait_until_time(SIGNAL clk      : IN STD_LOGIC;
	                                      CONSTANT c_time : IN TIME) IS
	BEGIN
		WHILE NOW < c_time LOOP
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END PROCEDURE;

	PROCEDURE proc_common_timeout_failure(CONSTANT c_timeout : IN TIME;
	                                      SIGNAL tb_end      : IN STD_LOGIC) IS
	BEGIN
		WHILE tb_end = '0' LOOP
			ASSERT NOW < c_timeout REPORT "Test bench timeout." SEVERITY FAILURE;
			WAIT FOR 1 us;
		END LOOP;
	END PROCEDURE;

	PROCEDURE proc_common_stop_simulation(SIGNAL tb_end : IN STD_LOGIC) IS
	BEGIN
		WAIT UNTIL tb_end = '1';
		-- For modelsim_regression_test_vhdl.py:
		-- The tb_end will stop the test verification bases on error or failure. The wait is necessary to
		-- stop the simulation using failure, without causing the test to fail.
		WAIT FOR 1 ns;
		REPORT "Tb simulation finished." SEVERITY FAILURE;
		WAIT;
	END PROCEDURE;

	PROCEDURE proc_common_stop_simulation(CONSTANT g_tb_end  : IN BOOLEAN;
	                                      CONSTANT g_latency : IN NATURAL;
	                                      SIGNAL clk         : IN STD_LOGIC;
	                                      SIGNAL tb_done     : IN STD_LOGIC;
	                                      SIGNAL tb_end      : OUT STD_LOGIC) IS
	BEGIN
		-- Wait until simulation indicates done
		proc_common_wait_until_high(clk, tb_done);

		-- Wait some more cycles
		proc_common_wait_some_cycles(clk, g_latency);

		-- Stop the simulation or only report NOTE
		tb_end <= '1';
		-- For modelsim_regression_test_vhdl.py:
		-- The tb_end will stop the test verification bases on error or failure. The wait is necessary to
		-- stop the simulation using failure, without causing the test to fail.
		WAIT FOR 1 ns;
		IF g_tb_end = FALSE THEN
			REPORT "Tb Simulation finished." SEVERITY NOTE;
		ELSE
			REPORT "Tb Simulation finished." SEVERITY FAILURE;
		END IF;
		WAIT;
	END PROCEDURE;

	PROCEDURE proc_common_stop_simulation(CONSTANT g_tb_end : IN BOOLEAN;
	                                      SIGNAL clk        : IN STD_LOGIC;
	                                      SIGNAL tb_done    : IN STD_LOGIC;
	                                      SIGNAL tb_end     : OUT STD_LOGIC) IS
	BEGIN
		proc_common_stop_simulation(g_tb_end, 0, clk, tb_done, tb_end);
	END PROCEDURE;

	------------------------------------------------------------------------------
	-- PROCEDURE: Handle stream ready signal for data valid
	-- . output active when ready='1' and enable='1'
	-- . only support ready latency c_rl = 0 or 1
	------------------------------------------------------------------------------
	PROCEDURE proc_common_ready_latency(CONSTANT c_rl    : IN NATURAL;
	                                    SIGNAL clk       : IN STD_LOGIC;
	                                    SIGNAL enable    : IN STD_LOGIC;
	                                    SIGNAL ready     : IN STD_LOGIC;
	                                    SIGNAL out_valid : OUT STD_LOGIC) IS
	BEGIN
		-- skip ready cycles until enable='1'
		out_valid <= '0';
		WHILE enable = '0' LOOP
			IF c_rl = 0 THEN
				WAIT UNTIL rising_edge(clk);
				WHILE ready /= '1' LOOP
					WAIT UNTIL rising_edge(clk);
				END LOOP;
			END IF;
			IF c_rl = 1 THEN
				WHILE ready /= '1' LOOP
					WAIT UNTIL rising_edge(clk);
				END LOOP;
				WAIT UNTIL rising_edge(clk);
			END IF;
		END LOOP;
		-- active output when ready
		IF c_rl = 0 THEN
			out_valid <= '1';
			WAIT UNTIL rising_edge(clk);
			WHILE ready /= '1' LOOP
				WAIT UNTIL rising_edge(clk);
			END LOOP;
		END IF;
		IF c_rl = 1 THEN
			WHILE ready /= '1' LOOP
				out_valid <= '0';
				WAIT UNTIL rising_edge(clk);
			END LOOP;
			out_valid <= '1';
			WAIT UNTIL rising_edge(clk);
		END IF;
	END proc_common_ready_latency;

	------------------------------------------------------------------------------
	-- PROCEDURE: Generate a single active, inactive pulse
	------------------------------------------------------------------------------
	PROCEDURE proc_common_gen_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                SIGNAL clk        : IN STD_LOGIC;
	                                SIGNAL pulse      : OUT STD_LOGIC) IS
		VARIABLE v_cnt : NATURAL RANGE 0 TO c_period := 0;
	BEGIN
		WHILE v_cnt < c_period LOOP
			IF v_cnt < c_active THEN
				pulse <= c_level;
			ELSE
				pulse <= NOT c_level;
			END IF;
			v_cnt := v_cnt + 1;
			WAIT UNTIL rising_edge(clk);
		END LOOP;
	END proc_common_gen_pulse;

	-- Pulse forever after rst was released
	PROCEDURE proc_common_gen_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                SIGNAL rst        : IN STD_LOGIC;
	                                SIGNAL clk        : IN STD_LOGIC;
	                                SIGNAL pulse      : OUT STD_LOGIC) IS
		VARIABLE v_cnt : NATURAL RANGE 0 TO c_period := 0;
	BEGIN
		pulse <= NOT c_level;
		IF rst = '0' THEN
			WAIT UNTIL rising_edge(clk);
			WHILE TRUE LOOP
				proc_common_gen_pulse(c_active, c_period, c_level, clk, pulse);
			END LOOP;
		END IF;
	END proc_common_gen_pulse;

	-- pulse '1', '0'
	PROCEDURE proc_common_gen_pulse(SIGNAL clk   : IN STD_LOGIC;
	                                SIGNAL pulse : OUT STD_LOGIC) IS
	BEGIN
		proc_common_gen_pulse(1, 2, '1', clk, pulse);
	END proc_common_gen_pulse;

	------------------------------------------------------------------------------
	-- PROCEDURE: Generate a periodic pulse with arbitrary duty cycle
	------------------------------------------------------------------------------
	PROCEDURE proc_common_gen_duty_pulse(CONSTANT c_delay  : IN NATURAL; -- delay pulse for nof_clk after enable
	                                     CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                     CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                     CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                     SIGNAL rst        : IN STD_LOGIC;
	                                     SIGNAL clk        : IN STD_LOGIC;
	                                     SIGNAL enable     : IN STD_LOGIC;
	                                     SIGNAL pulse      : OUT STD_LOGIC) IS
		VARIABLE v_cnt : NATURAL RANGE 0 TO c_period - 1 := 0;
	BEGIN
		pulse <= NOT c_level;
		IF rst = '0' THEN
			proc_common_wait_until_high(clk, enable); -- if enabled then continue immediately else wait here
			proc_common_wait_some_cycles(clk, c_delay); -- apply initial c_delay. Once enabled, the pulse remains enabled
			WHILE TRUE LOOP
				WAIT UNTIL rising_edge(clk);
				IF v_cnt < c_active THEN
					pulse <= c_level;
				ELSE
					pulse <= NOT c_level;
				END IF;
				IF v_cnt < c_period - 1 THEN
					v_cnt := v_cnt + 1;
				ELSE
					v_cnt := 0;
				END IF;
			END LOOP;
		END IF;
	END proc_common_gen_duty_pulse;

	PROCEDURE proc_common_gen_duty_pulse(CONSTANT c_active : IN NATURAL; -- pulse active for nof clk
	                                     CONSTANT c_period : IN NATURAL; -- pulse period for nof clk
	                                     CONSTANT c_level  : IN STD_LOGIC; -- pulse level when active
	                                     SIGNAL rst        : IN STD_LOGIC;
	                                     SIGNAL clk        : IN STD_LOGIC;
	                                     SIGNAL enable     : IN STD_LOGIC;
	                                     SIGNAL pulse      : OUT STD_LOGIC) IS
	BEGIN
		proc_common_gen_duty_pulse(0, c_active, c_period, c_level, rst, clk, enable, pulse);
	END proc_common_gen_duty_pulse;

	------------------------------------------------------------------------------
	-- PROCEDURE: Generate counter data with valid
	-- . Output counter data dependent on enable and ready
	------------------------------------------------------------------------------
	-- arbitrary c_incr
	PROCEDURE proc_common_gen_data(CONSTANT c_rl    : IN NATURAL; -- 0, 1 are supported by proc_common_ready_latency()
	                               CONSTANT c_init  : IN INTEGER;
	                               CONSTANT c_incr  : IN INTEGER;
	                               SIGNAL rst       : IN STD_LOGIC;
	                               SIGNAL clk       : IN STD_LOGIC;
	                               SIGNAL enable    : IN STD_LOGIC; -- when '0' then no valid output even when ready='1'
	                               SIGNAL ready     : IN STD_LOGIC;
	                               SIGNAL out_data  : OUT STD_LOGIC_VECTOR;
	                               SIGNAL out_valid : OUT STD_LOGIC) IS
		CONSTANT c_data_w : NATURAL                                 := out_data'LENGTH;
		VARIABLE v_data   : STD_LOGIC_VECTOR(c_data_w - 1 DOWNTO 0) := TO_SVEC(c_init, c_data_w);
	BEGIN
		out_valid <= '0';
		out_data  <= v_data;
		IF rst = '0' THEN
			WAIT UNTIL rising_edge(clk);
			WHILE TRUE LOOP
				out_data <= v_data;
				proc_common_ready_latency(c_rl, clk, enable, ready, out_valid);
				v_data   := INCR_UVEC(v_data, c_incr);
			END LOOP;
		END IF;
	END proc_common_gen_data;

	-- c_incr = 1
	PROCEDURE proc_common_gen_data(CONSTANT c_rl    : IN NATURAL; -- 0, 1 are supported by proc_common_ready_latency()
	                               CONSTANT c_init  : IN INTEGER;
	                               SIGNAL rst       : IN STD_LOGIC;
	                               SIGNAL clk       : IN STD_LOGIC;
	                               SIGNAL enable    : IN STD_LOGIC; -- when '0' then no valid output even when ready='1'
	                               SIGNAL ready     : IN STD_LOGIC;
	                               SIGNAL out_data  : OUT STD_LOGIC_VECTOR;
	                               SIGNAL out_valid : OUT STD_LOGIC) IS
	BEGIN
		proc_common_gen_data(c_rl, c_init, 1, rst, clk, enable, ready, out_data, out_valid);
	END proc_common_gen_data;

	------------------------------------------------------------------------------
	-- PROCEDURE: Generate frame control
	------------------------------------------------------------------------------
	PROCEDURE proc_common_sop(SIGNAL clk    : IN STD_LOGIC;
	                          SIGNAL in_val : OUT STD_LOGIC;
	                          SIGNAL in_sop : OUT STD_LOGIC) IS
	BEGIN
		in_val <= '1';
		in_sop <= '1';
		proc_common_wait_some_cycles(clk, 1);
		in_sop <= '0';
	END proc_common_sop;

	PROCEDURE proc_common_eop(SIGNAL clk    : IN STD_LOGIC;
	                          SIGNAL in_val : OUT STD_LOGIC;
	                          SIGNAL in_eop : OUT STD_LOGIC) IS
	BEGIN
		in_val <= '1';
		in_eop <= '1';
		proc_common_wait_some_cycles(clk, 1);
		in_val <= '0';
		in_eop <= '0';
	END proc_common_eop;

	PROCEDURE proc_common_val(CONSTANT c_val_len : IN NATURAL;
	                          SIGNAL clk         : IN STD_LOGIC;
	                          SIGNAL in_val      : OUT STD_LOGIC) IS
	BEGIN
		in_val <= '1';
		proc_common_wait_some_cycles(clk, c_val_len);
		in_val <= '0';
	END proc_common_val;

	PROCEDURE proc_common_val_duty(CONSTANT c_hi_len : IN NATURAL;
	                               CONSTANT c_lo_len : IN NATURAL;
	                               SIGNAL clk        : IN STD_LOGIC;
	                               SIGNAL in_val     : OUT STD_LOGIC) IS
	BEGIN
		in_val <= '1';
		proc_common_wait_some_cycles(clk, c_hi_len);
		in_val <= '0';
		proc_common_wait_some_cycles(clk, c_lo_len);
	END proc_common_val_duty;

	PROCEDURE proc_common_eop_flush(CONSTANT c_flush_len : IN NATURAL;
	                                SIGNAL clk           : IN STD_LOGIC;
	                                SIGNAL in_val        : OUT STD_LOGIC;
	                                SIGNAL in_eop        : OUT STD_LOGIC) IS
	BEGIN
		-- . eop
		proc_common_eop(clk, in_val, in_eop);
		-- . flush after in_eop to empty the shift register
		proc_common_wait_some_cycles(clk, c_flush_len);
	END proc_common_eop_flush;

	------------------------------------------------------------------------------
	-- PROCEDURE: Verify incrementing data
	------------------------------------------------------------------------------
	PROCEDURE proc_common_verify_data(CONSTANT c_rl        : IN NATURAL;
	                                  SIGNAL clk           : IN STD_LOGIC;
									  SIGNAL rst		   : IN STD_LOGIC;
	                                  SIGNAL verify_en     : IN STD_LOGIC;
	                                  SIGNAL ready         : IN STD_LOGIC;
	                                  SIGNAL out_valid     : IN STD_LOGIC;
	                                  SIGNAL out_data      : IN STD_LOGIC_VECTOR;
	                                  SIGNAL prev_out_data : INOUT STD_LOGIC_VECTOR;
																		SIGNAL test_msg			 : OUT STRING;
																		SIGNAL test_pass		 : OUT BOOLEAN) IS
		VARIABLE v_exp_data : STD_LOGIC_VECTOR(out_data'RANGE);
	BEGIN
		test_pass <= TRUE;
		IF rst = '0' then
			IF rising_edge(clk) THEN
				-- out_valid must be active, because only the out_data will it differ from the previous out_data
				IF out_valid = '1' THEN
					-- for ready_latency = 1 out_valid indicates new data
					-- for ready_latency = 0 out_valid only indicates new data when it is confirmed by ready
					IF c_rl = 1 OR (c_rl = 0 AND ready = '1') THEN
						prev_out_data <= out_data;
						v_exp_data    := INCR_UVEC(prev_out_data, 1); -- increment first then compare to also support increment wrap around
						IF verify_en = '1' AND UNSIGNED(out_data) /= UNSIGNED(v_exp_data) THEN
							test_pass <= FALSE;
							test_msg <= pad("COMMON : Wrong out_data count", test_msg'length, '.')(test_msg'range);
							REPORT "COMMON : Wrong out_data count" SEVERITY ERROR;
						END IF;
					END IF;
				END IF;
			end if;
		END IF;
	END proc_common_verify_data;

	------------------------------------------------------------------------------
	-- PROCEDURE: Verify the DUT output valid
	-- . only support ready latency c_rl = 0 or 1
	------------------------------------------------------------------------------
	PROCEDURE proc_common_verify_valid(CONSTANT c_rl     : IN NATURAL;
	                                   SIGNAL clk        : IN STD_LOGIC;
	                                   SIGNAL verify_en  : IN STD_LOGIC;
	                                   SIGNAL ready      : IN STD_LOGIC;
	                                   SIGNAL prev_ready : INOUT STD_LOGIC;
	                                   SIGNAL out_valid  : IN STD_LOGIC;
																		 SIGNAL test_msg	 : OUT STRING;
																		 SIGNAL test_pass	 : OUT BOOLEAN) IS
	BEGIN
		test_pass <= TRUE;
		IF rising_edge(clk) THEN
			-- for ready latency c_rl = 1 out_valid may only be asserted after ready
			-- for ready latency c_rl = 0 out_valid may always be asserted
			prev_ready <= '0';
			IF c_rl = 1 THEN
				prev_ready <= ready;
				IF verify_en = '1' AND out_valid = '1' THEN
					IF prev_ready /= '1' THEN
						test_pass <= FALSE;
						test_msg <= pad("COMMON : Wrong ready latency between ready and out_valid", test_msg'length, '.')(test_msg'range);
						REPORT "COMMON : Wrong ready latency between ready and out_valid" SEVERITY ERROR;
					END IF;
				END IF;
			END IF;
		END IF;
	END proc_common_verify_valid;

	------------------------------------------------------------------------------
	-- PROCEDURE: Verify the DUT input to output latency
	------------------------------------------------------------------------------
	-- for SL ctrl
	PROCEDURE proc_common_verify_latency(CONSTANT c_str       : IN STRING; -- e.g. "valid", "sop", "eop"
	                                     CONSTANT c_latency   : IN NATURAL;
	                                     SIGNAL clk           : IN STD_LOGIC;
	                                     SIGNAL verify_en     : IN STD_LOGIC;
	                                     SIGNAL in_ctrl       : IN STD_LOGIC;
	                                     SIGNAL pipe_ctrl_vec : INOUT STD_LOGIC_VECTOR; -- range [0:c_latency]
	                                     SIGNAL out_ctrl      : IN STD_LOGIC;
																			 SIGNAL test_msg	 : OUT STRING;
																			 SIGNAL test_pass	 : OUT BOOLEAN) IS
	BEGIN
		test_pass <= TRUE;
		IF rising_edge(clk) THEN
			pipe_ctrl_vec <= in_ctrl & pipe_ctrl_vec(0 TO c_latency - 1); -- note: pipe_ctrl_vec(c_latency) is a dummy place holder to avoid [0:-1] range
			IF verify_en = '1' THEN
				IF c_latency = 0 THEN
					IF in_ctrl /= out_ctrl THEN
						test_pass <= FALSE;
						test_msg <= pad("COMMON : Wrong zero latency between input " & c_str & " and output " & c_str, test_msg'length, '.')(test_msg'range);
						REPORT "COMMON : Wrong zero latency between input " & c_str & " and output " & c_str SEVERITY ERROR;
					END IF;
				ELSE
					IF pipe_ctrl_vec(c_latency - 1) /= out_ctrl THEN
						test_pass <= FALSE;
						test_msg <= pad("COMMON : Wrong latency between input " & c_str & " and output " & c_str, test_msg'length, '.')(test_msg'range);
						REPORT "COMMON : Wrong latency between input " & c_str & " and output " & c_str SEVERITY ERROR;
					END IF;
				END IF;
			END IF;
		END IF;
	END proc_common_verify_latency;

	-- for SLV data
	PROCEDURE proc_common_verify_latency(CONSTANT c_str       : IN STRING; -- e.g. "data"
	                                     CONSTANT c_latency   : IN NATURAL;
	                                     SIGNAL clk           : IN STD_LOGIC;
	                                     SIGNAL verify_en     : IN STD_LOGIC;
	                                     SIGNAL in_data       : IN STD_LOGIC_VECTOR;
	                                     SIGNAL pipe_data_vec : INOUT STD_LOGIC_VECTOR; -- range [0:(1 + c_latency)*c_data_w-1]
	                                     SIGNAL out_data      : IN STD_LOGIC_VECTOR;
																			 SIGNAL test_msg	 : OUT STRING;
																			 SIGNAL test_pass	 : OUT BOOLEAN) IS
		CONSTANT c_data_w     : NATURAL := in_data'LENGTH;
		CONSTANT c_data_vec_w : NATURAL := pipe_data_vec'LENGTH; -- = (1 + c_latency) * c_data_w
	BEGIN
		test_pass <= TRUE;
		IF rising_edge(clk) THEN
			pipe_data_vec <= in_data & pipe_data_vec(0 TO c_data_vec_w - c_data_w - 1); -- note: pipe_data_vec(c_latency) is a dummy place holder to avoid [0:-1] range
			IF verify_en = '1' THEN
				IF c_latency = 0 THEN
					IF UNSIGNED(in_data) /= UNSIGNED(out_data) THEN
						test_pass <= FALSE;
						test_msg <= pad("COMMON : Wrong zero latency between input " & c_str & " and output " & c_str, test_msg'length, '.')(test_msg'range);
						REPORT "COMMON : Wrong zero latency between input " & c_str & " and output " & c_str SEVERITY ERROR;
					END IF;
				ELSE
					IF UNSIGNED(pipe_data_vec(c_data_vec_w - c_data_w - c_data_w TO c_data_vec_w - c_data_w - 1)) /= UNSIGNED(out_data) THEN
						test_pass <= FALSE;
						test_msg <= pad("COMMON : Wrong latency between input " & c_str & " and output " & c_str, test_msg'length, '.')(test_msg'range);
						REPORT "COMMON : Wrong latency between input " & c_str & " and output " & c_str SEVERITY ERROR;
					END IF;
				END IF;
			END IF;
		END IF;
	END proc_common_verify_latency;

	------------------------------------------------------------------------------
	-- PROCEDURE: Verify the expected value
	-- . e.g. to check that a test has ran at all
	------------------------------------------------------------------------------
	PROCEDURE proc_common_verify_value(CONSTANT mode : IN NATURAL;
	                                   SIGNAL clk    : IN STD_LOGIC;
	                                   SIGNAL en     : IN STD_LOGIC;
	                                   SIGNAL exp    : IN STD_LOGIC_VECTOR;
	                                   SIGNAL res    : IN STD_LOGIC_VECTOR) IS
	BEGIN
		IF rising_edge(clk) THEN
			IF en = '1' THEN
				IF mode = 0 AND UNSIGNED(res) /= UNSIGNED(exp) THEN
					REPORT "COMMON : Wrong result value" SEVERITY ERROR; -- == (equal)
				END IF;
				IF mode = 1 AND UNSIGNED(res) < UNSIGNED(exp) THEN
					REPORT "COMMON : Wrong result value too small" SEVERITY ERROR; -- >= (at least)
				END IF;
			END IF;
		END IF;
	END proc_common_verify_value;

	------------------------------------------------------------------------------
	-- PROCEDURE: Opens a file for access and reports fail or success of opening. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_open_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                FILE in_file : TEXT;
	                                file_name    : IN STRING;
	                                file_mode    : IN FILE_OPEN_KIND) IS
	BEGIN
		IF file_status = OPEN_OK THEN
			file_close(in_file);
		END IF;
		file_open(file_status, in_file, file_name, file_mode);
		IF file_status = OPEN_OK THEN
			REPORT "COMMON : File opened " SEVERITY NOTE;
		ELSE
			REPORT "COMMON : Unable to open file '" & file_name & "'" SEVERITY FAILURE;
		END IF;
	END proc_common_open_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads an integer from a file. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_value_0 : OUT INTEGER) IS
		VARIABLE v_line : LINE;
		VARIABLE v_good : BOOLEAN;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			IF ENDFILE(in_file) THEN
				REPORT "COMMON : end of file " SEVERITY NOTE;
			ELSE
				READLINE(in_file, v_line);
				READ(v_line, read_value_0, v_good);
				IF v_good = FALSE THEN
					REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
				END IF;
			END IF;
		END IF;
	END proc_common_readline_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads two integers from two columns in a file. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_value_0 : OUT INTEGER;
	                                    read_value_1 : OUT INTEGER) IS
		VARIABLE v_line : LINE;
		VARIABLE v_good : BOOLEAN;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			IF ENDFILE(in_file) THEN
				REPORT "COMMON : end of file " SEVERITY NOTE;
			ELSE
				READLINE(in_file, v_line);
				READ(v_line, read_value_0, v_good);
				IF v_good = FALSE THEN
					REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
				END IF;
				READ(v_line, read_value_1, v_good);
				IF v_good = FALSE THEN
					REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
				END IF;
			END IF;
		END IF;
	END proc_common_readline_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads an array of integer from a file. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    value_array  : OUT t_integer_arr;
	                                    nof_reads    : IN INTEGER) IS
		VARIABLE v_line : LINE;
		VARIABLE v_good : BOOLEAN;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			IF ENDFILE(in_file) THEN
				REPORT "COMMON : end of file " SEVERITY NOTE;
			ELSE
				READLINE(in_file, v_line);
				FOR I IN 0 TO nof_reads - 1 LOOP
					READ(v_line, value_array(I), v_good);
					IF v_good = FALSE THEN
						REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
					END IF;
				END LOOP;
			END IF;
		END IF;
	END proc_common_readline_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads an std_logic_vector from a file
	------------------------------------------------------------------------------
	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    read_slv     : OUT STD_LOGIC_VECTOR) IS
		VARIABLE v_line : LINE;
		VARIABLE v_good : BOOLEAN;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			IF ENDFILE(in_file) THEN
				REPORT "COMMON : end of file " SEVERITY NOTE;
			ELSE
				READLINE(in_file, v_line);
				READ(v_line, read_slv, v_good);
				IF v_good = FALSE THEN
					REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
				END IF;
			END IF;
		END IF;
	END proc_common_readline_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads a string of any length from a file pointer. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_readline_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                    FILE in_file : TEXT;
	                                    res_string   : OUT STRING) IS
		VARIABLE v_line    : LINE;
		VARIABLE v_char    : CHARACTER;
		VARIABLE is_string : BOOLEAN;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			IF ENDFILE(in_file) THEN
				REPORT "COMMON : end of file " SEVERITY NOTE;
			ELSE
				readline(in_file, v_line);
				-- clear the contents of the result string
				FOR I IN res_string'RANGE LOOP
					res_string(I) := ' ';
				END LOOP;
				-- read all characters of the line, up to the length  
				-- of the results string
				FOR I IN res_string'RANGE LOOP
					read(v_line, v_char, is_string);
					IF NOT is_string THEN -- found end of line
						EXIT;
					END IF;
					res_string(I) := v_char;
				END LOOP;
			END IF;
		END IF;
	END proc_common_readline_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Closes a file. 
	------------------------------------------------------------------------------
	PROCEDURE proc_common_close_file(file_status  : INOUT FILE_OPEN_STATUS;
	                                 FILE in_file : TEXT) IS
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File was not opened " SEVERITY WARNING;
		END IF;
		FILE_CLOSE(in_file);
		REPORT "COMMON : File closed " SEVERITY NOTE;
	END proc_common_close_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads the integer data from nof_rows with nof_col values per
	--            row from a file and returns it row by row in an array of
	--            integers.
	------------------------------------------------------------------------------
	PROCEDURE proc_common_read_integer_file(file_name           : IN STRING;
	                                        nof_header_lines    : NATURAL;
	                                        nof_row             : NATURAL;
	                                        nof_col             : NATURAL;
	                                        SIGNAL return_array : OUT t_integer_arr) IS
		VARIABLE v_file_status : FILE_OPEN_STATUS;
		FILE v_in_file         : TEXT;
		VARIABLE v_input_line  : LINE;
		VARIABLE v_string      : STRING(1 TO 80);
		VARIABLE v_row_arr     : t_integer_arr(0 TO nof_col - 1);
	BEGIN
		IF file_name /= "UNUSED" AND file_name /= "unused" THEN
			-- Open the file for reading
			proc_common_open_file(v_file_status, v_in_file, file_name, READ_MODE);
			-- Read and skip the header
			FOR J IN 0 TO nof_header_lines - 1 LOOP
				proc_common_readline_file(v_file_status, v_in_file, v_string);
			END LOOP;
			FOR J IN 0 TO nof_row - 1 LOOP
				proc_common_readline_file(v_file_status, v_in_file, v_row_arr, nof_col);
				FOR I IN 0 TO nof_col - 1 LOOP
					return_array(J * nof_col + I) <= v_row_arr(I); -- use loop to be independent of t_integer_arr downto or to range
				END LOOP;
				IF ENDFILE(v_in_file) THEN
					IF J /= nof_row - 1 THEN
						REPORT "COMMON : Unexpected end of file" SEVERITY FAILURE;
					END IF;
					EXIT;
				END IF;
			END LOOP;
			-- Close the file 
			proc_common_close_file(v_file_status, v_in_file);
		ELSE
			return_array <= (return_array'RANGE => 0);
		END IF;
	END proc_common_read_integer_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads the data column from a .mif file and returns it in an 
	--            array of integers
	------------------------------------------------------------------------------
	PROCEDURE proc_common_read_mif_file(file_name           : IN STRING;
	                                    SIGNAL return_array : OUT t_integer_arr) IS
		VARIABLE v_file_status : FILE_OPEN_STATUS;
		FILE v_in_file         : TEXT;
		VARIABLE v_input_line  : LINE;
		VARIABLE v_string      : STRING(1 TO 80);
		VARIABLE v_mem_width   : NATURAL := 0;
		VARIABLE v_mem_depth   : NATURAL := 0;
		VARIABLE v_up_bound    : NATURAL := 0;
		VARIABLE v_low_bound   : NATURAL := 0;
		VARIABLE v_end_header  : BOOLEAN := FALSE;
		VARIABLE v_char        : CHARACTER;
	BEGIN
		-- Open the .mif file for reading
		proc_common_open_file(v_file_status, v_in_file, file_name, READ_MODE);
		-- Read the header.
		WHILE NOT v_end_header LOOP
			proc_common_readline_file(v_file_status, v_in_file, v_string);
			IF (func_find_string_in_string(v_string, "WIDTH=")) THEN -- check for "WIDTH=" 
				v_up_bound  := func_find_char_in_string(v_string, ';');
				v_low_bound := func_find_char_in_string(v_string, '=');
				v_mem_width := func_decstring_to_integer(v_string(v_low_bound + 1 TO v_up_bound - 1));
			ELSIF (func_find_string_in_string(v_string, "DEPTH=")) THEN -- check for "DEPTH=" 
				v_up_bound  := func_find_char_in_string(v_string, ';');
				v_low_bound := func_find_char_in_string(v_string, '=');
				v_mem_depth := func_decstring_to_integer(v_string(v_low_bound + 1 TO v_up_bound - 1));
			ELSIF (func_find_string_in_string(v_string, "CONTENT BEGIN")) THEN
				v_end_header := TRUE;
			END IF;
		END LOOP;
		-- Read the data           
		FOR I IN 0 TO v_mem_depth - 1 LOOP
			proc_common_readline_file(v_file_status, v_in_file, v_string); -- Read the next line from the file. 
			v_low_bound     := func_find_char_in_string(v_string, ':'); -- Find the left position of the string that contains the data field
			v_up_bound      := func_find_char_in_string(v_string, ';'); -- Find the right position of the string that contains the data field           
			return_array(I) <= func_hexstring_to_integer(v_string(v_low_bound + 1 TO v_up_bound - 1));
		END LOOP;
		-- Close the file 
		proc_common_close_file(v_file_status, v_in_file);
	END proc_common_read_mif_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads the data column from a .mem file and returns it in an 
	--            array of integers
	------------------------------------------------------------------------------
	PROCEDURE proc_common_read_mem_file(file_name           : IN STRING;
	                                    SIGNAL return_array : OUT t_integer_arr) IS
		VARIABLE v_file_status : FILE_OPEN_STATUS;
		FILE 	 v_in_file     : TEXT;
		VARIABLE v_line        : LINE;
		VARIABLE v_string      : STRING(1 TO 80);
		VARIABLE I 			   : NATURAL := 0;
	BEGIN
		-- Open the .mem file for reading
		proc_common_open_file(v_file_status, v_in_file, file_name, READ_MODE);
		-- Read the header - there is none
		-- Read the data till the end of the file          
		WHILE NOT endfile(v_in_file) LOOP
			readline(v_in_file, v_line);
			-- Skip empty lines
			IF v_line.all'length = 0 then
				next;
			END IF;
			proc_common_readline_file(v_file_status, v_in_file, v_string); -- Read the next line from the file. 
			return_array(I) <= func_hexstring_to_integer(v_string);
			I := I+1;         
		END LOOP;
		-- Close the file 
		proc_common_close_file(v_file_status, v_in_file);
	END proc_common_read_mem_file;

	------------------------------------------------------------------------------
	-- PROCEDURE: Parses a line of text into an integer array using a specified delimiter.
	------------------------------------------------------------------------------
	PROCEDURE csv_parse_line_to_array(line_in : IN STRING;
								delimiter : IN CHARACTER;
								value_array : OUT t_nat_integer_arr;
								nof_values : OUT INTEGER) IS
		VARIABLE v_idx : INTEGER := 1;
		VARIABLE v_len : INTEGER := line_in'LENGTH;
		VARIABLE v_start : INTEGER := 1;
		VARIABLE v_cnt_vals : INTEGER := 0;
		VARIABLE v_substr : STRING(1 TO 100);
		VARIABLE v_int : INTEGER;
		VARIABLE v_good : BOOLEAN;
		VARIABLE v_subline : LINE;
	BEGIN
		WHILE v_start <= v_len LOOP
			-- Find the next delimiter position
			v_idx := v_start;
			WHILE v_idx <= v_len AND line_in(v_idx) /= delimiter LOOP
				v_idx := v_idx + 1;
			END LOOP;
			-- Extract substring
			IF v_idx > v_start THEN
				v_substr := line_in(v_start TO v_idx - 1);
			ELSE
				v_substr := line_in(v_start TO v_len);
			END IF;
			-- Convert substring to integer
			WRITE(v_subline, v_substr);
			READ(v_subline, v_int, v_good);
			IF v_good = FALSE THEN
				REPORT "COMMON : Read from line unsuccessful " SEVERITY FAILURE;
			END IF;
			value_array(v_cnt_vals) := v_int;
			v_cnt_vals := v_cnt_vals + 1;
			-- Move to the next part of the line
			v_start := v_idx + 1;
		END LOOP;
		nof_values := v_cnt_vals;
	END csv_parse_line_to_array;

	------------------------------------------------------------------------------
	-- PROCEDURE: Reads a file line by line and populates an array of integer arrays.
	------------------------------------------------------------------------------
	PROCEDURE csv_read_file_to_array(file_status  : INOUT FILE_OPEN_STATUS;
								FILE in_file : TEXT;
								value_matrix : OUT t_nat_integer_matrix;
								max_lines    : IN INTEGER;
								delimiter    : IN CHARACTER) IS
		VARIABLE v_line : LINE;
		VARIABLE v_array : t_nat_integer_arr(0 TO 100); -- Adjust size as needed
		VARIABLE v_nof_values : INTEGER;
		VARIABLE v_line_idx : INTEGER := 0;
	BEGIN
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : File is not opened " SEVERITY FAILURE;
		ELSE
			WHILE NOT ENDFILE(in_file) AND v_line_idx < max_lines LOOP
				READLINE(in_file, v_line);
				csv_parse_line_to_array(v_line.all, delimiter, v_array, v_nof_values);
				FOR i IN 0 TO v_nof_values - 1 LOOP
					value_matrix(v_line_idx, i) := v_array(i);
				END LOOP;
				v_line_idx := v_line_idx + 1;
			END LOOP;
		END IF;
	END csv_read_file_to_array;

	------------------------------------------------------------------------------
	-- PROCEDURE: Opens a file and calls read_file_to_array to process it.
	------------------------------------------------------------------------------
	PROCEDURE csv_open_and_read_file(file_name : IN STRING;
								value_matrix : OUT t_nat_integer_matrix;
								max_lines    : IN INTEGER;
								delimiter    : IN CHARACTER) IS
		FILE in_file : TEXT;
		VARIABLE file_status : FILE_OPEN_STATUS;
	BEGIN
		-- Open the file
		proc_common_open_file(file_status, in_file, file_name, READ_MODE);
		IF file_status /= OPEN_OK THEN
			REPORT "COMMON : Unable to open file " & file_name SEVERITY FAILURE;
		ELSE
			-- Call read_file_to_array to process the file
			csv_read_file_to_array(file_status, in_file, value_matrix, max_lines, delimiter);
			-- Close the file
			FILE_CLOSE(in_file);
		END IF;
	END csv_open_and_read_file;
	
	------------------------------------------------------------------------------
	-- FUNCTION: Complex multiply with conjugate option for input b
	------------------------------------------------------------------------------
	FUNCTION func_complex_multiply(in_ar, in_ai, in_br, in_bi : STD_LOGIC_VECTOR; conjugate_b : BOOLEAN; str : STRING; g_out_dat_w : NATURAL) RETURN STD_LOGIC_VECTOR IS
		-- Function: Signed complex multiply
		--   p = a * b       when g_conjugate_b = FALSE
		--     = (ar + j ai) * (br + j bi)
		--     =  ar*br - ai*bi + j ( ar*bi + ai*br)
		--
		--   p = a * conj(b) when g_conjugate_b = TRUE
		--     = (ar + j ai) * (br - j bi)
		--     =  ar*br + ai*bi + j (-ar*bi + ai*br)
		-- From mti_numeric_std.vhd follows:
		-- . SIGNED * --> output width = 2 * input width
		-- . SIGNED + --> output width = largest(input width)
		CONSTANT c_in_w      : NATURAL := in_ar'LENGTH; -- all input have same width
		CONSTANT c_res_w     : NATURAL := 2 * c_in_w + 1; -- *2 for multiply, +1 for sum of two products
		VARIABLE v_ar        : SIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_ai        : SIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_br        : SIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_bi        : SIGNED(c_in_w - 1 DOWNTO 0);
		VARIABLE v_result_re : SIGNED(c_res_w - 1 DOWNTO 0);
		VARIABLE v_result_im : SIGNED(c_res_w - 1 DOWNTO 0);
	BEGIN
		-- Calculate expected result
		v_ar := RESIZE_NUM(SIGNED(in_ar), c_in_w);
		v_ai := RESIZE_NUM(SIGNED(in_ai), c_in_w);
		v_br := RESIZE_NUM(SIGNED(in_br), c_in_w);
		v_bi := RESIZE_NUM(SIGNED(in_bi), c_in_w);
		IF conjugate_b = FALSE THEN
			v_result_re := RESIZE_NUM(v_ar * v_br, c_res_w) - v_ai * v_bi;
			v_result_im := RESIZE_NUM(v_ar * v_bi, c_res_w) + v_ai * v_br;
		ELSE
			v_result_re := RESIZE_NUM(v_ar * v_br, c_res_w) + v_ai * v_bi;
			v_result_im := RESIZE_NUM(v_ai * v_br, c_res_w) - v_ar * v_bi;
		END IF;
		-- Note that for the product needs as many bits as the sum of the input widths. However the
		-- sign bit is then only needed for the case that both inputs have the largest negative
		-- values, only then the MSBits will be "01". For all other inputs the MSbits will always
		-- be "00" for positive numbers or "11" for negative numbers. MSbits "10" can not occur.
		-- For largest negative inputs the complex multiply result becomes:
		--
		--   3b inputs                --> 6b products     --> c_res_w = 7b
		--     -4 *   -4 +   -4 *   -4 =     +16 +     +16 =      +64       -- most negative valued inputs
		--   b100 * b100 + b100 * b100 = b010000 + b010000 = b0100000
		--
		--   --> if g_out_dat_w = 6b then
		--       a) IEEE unsigned resizing skips   the MSbits so b0100000 = +64 becomes b_100000 = -64
		--       b) IEEE signed resizing preserves the MSbit  so b0100000 = +64 becomes b0_00000 = 0
		--       c) detect MSbits = "01" to clip max positive to get                    _b011111 = +63
		-- Option a) seems to map best on the FPGA hardware multiplier IP.
		IF str = "RE" THEN
			RETURN STD_LOGIC_VECTOR(RESIZE_NUM(v_result_re, g_out_dat_w)); -- conform option a)
		ELSE
			RETURN STD_LOGIC_VECTOR(RESIZE_NUM(v_result_im, g_out_dat_w)); -- conform option a)
		END IF;
	END;

	------------------------------------------------------------------------------
	-- FUNCTION: Converts the decimal value represented in a string to an integer value. 
	------------------------------------------------------------------------------
	FUNCTION func_decstring_to_integer(in_string : STRING) RETURN INTEGER IS
		CONSTANT c_nof_digits : NATURAL := in_string'LENGTH; -- Define the length of the string
		VARIABLE v_char       : CHARACTER;
		VARIABLE v_weight     : INTEGER := 1;
		VARIABLE v_return_int : INTEGER := 0;
	BEGIN
		-- Walk through the string character by character. 
		FOR I IN c_nof_digits - 1 DOWNTO 0 LOOP
			v_char := in_string(I + in_string'LOW);
			CASE v_char IS
				WHEN '0'    => v_return_int := v_return_int + 0 * v_weight;
				WHEN '1'    => v_return_int := v_return_int + 1 * v_weight;
				WHEN '2'    => v_return_int := v_return_int + 2 * v_weight;
				WHEN '3'    => v_return_int := v_return_int + 3 * v_weight;
				WHEN '4'    => v_return_int := v_return_int + 4 * v_weight;
				WHEN '5'    => v_return_int := v_return_int + 5 * v_weight;
				WHEN '6'    => v_return_int := v_return_int + 6 * v_weight;
				WHEN '7'    => v_return_int := v_return_int + 7 * v_weight;
				WHEN '8'    => v_return_int := v_return_int + 8 * v_weight;
				WHEN '9'    => v_return_int := v_return_int + 9 * v_weight;
				WHEN OTHERS => NULL;
			END CASE;
			IF (v_char /= ' ') THEN     -- Only increment the weight when the character is NOT a spacebar. 
				v_weight := v_weight * 10; -- Addapt the weight for the next decimal digit.
			END IF;
		END LOOP;
		RETURN (v_return_int);
	END FUNCTION func_decstring_to_integer;

	------------------------------------------------------------------------------
	-- FUNCTION: Converts the hexadecimal value represented in a string to an integer value. 
	------------------------------------------------------------------------------
	FUNCTION func_hexstring_to_integer(in_string : STRING) RETURN INTEGER IS
		CONSTANT c_nof_digits : NATURAL := in_string'LENGTH; -- Define the length of the string
		VARIABLE v_char       : CHARACTER;
		VARIABLE v_weight     : INTEGER := 1;
		VARIABLE v_return_int : INTEGER := 0;
	BEGIN
		-- Walk through the string character by character. 
		FOR I IN c_nof_digits - 1 DOWNTO 0 LOOP
			v_char := in_string(I + in_string'LOW);
			CASE v_char IS
				WHEN '0'       => v_return_int := v_return_int + 0 * v_weight;
				WHEN '1'       => v_return_int := v_return_int + 1 * v_weight;
				WHEN '2'       => v_return_int := v_return_int + 2 * v_weight;
				WHEN '3'       => v_return_int := v_return_int + 3 * v_weight;
				WHEN '4'       => v_return_int := v_return_int + 4 * v_weight;
				WHEN '5'       => v_return_int := v_return_int + 5 * v_weight;
				WHEN '6'       => v_return_int := v_return_int + 6 * v_weight;
				WHEN '7'       => v_return_int := v_return_int + 7 * v_weight;
				WHEN '8'       => v_return_int := v_return_int + 8 * v_weight;
				WHEN '9'       => v_return_int := v_return_int + 9 * v_weight;
				WHEN 'A' | 'a' => v_return_int := v_return_int + 10 * v_weight;
				WHEN 'B' | 'b' => v_return_int := v_return_int + 11 * v_weight;
				WHEN 'C' | 'c' => v_return_int := v_return_int + 12 * v_weight;
				WHEN 'D' | 'd' => v_return_int := v_return_int + 13 * v_weight;
				WHEN 'E' | 'e' => v_return_int := v_return_int + 14 * v_weight;
				WHEN 'F' | 'f' => v_return_int := v_return_int + 15 * v_weight;
				WHEN OTHERS    => NULL;
			END CASE;
			IF (v_char /= ' ') THEN     -- Only increment the weight when the character is NOT a spacebar. 
				v_weight := v_weight * 16; -- Addapt the weight for the next hexadecimal digit.                   
			END IF;
		END LOOP;
		RETURN (v_return_int);
	END FUNCTION func_hexstring_to_integer;

	------------------------------------------------------------------------------
	-- FUNCTION: Finds the first instance of a given character in a string 
	--           and returns its position. 
	------------------------------------------------------------------------------
	FUNCTION func_find_char_in_string(in_string : STRING; find_char : CHARACTER) RETURN INTEGER IS
		VARIABLE v_char_position : INTEGER := 0;
	BEGIN
		FOR I IN 1 TO in_string'LENGTH LOOP
			IF (in_string(I) = find_char) THEN
				v_char_position := I;
			END IF;
		END LOOP;
		RETURN (v_char_position);
	END FUNCTION func_find_char_in_string;

	------------------------------------------------------------------------------
	-- FUNCTION: Checks if a string(find_string) is part of a larger string(in_string).
	--           The result is returned as a BOOLEAN. 
	------------------------------------------------------------------------------
	FUNCTION func_find_string_in_string(in_string : STRING; find_string : STRING) RETURN BOOLEAN IS
		CONSTANT c_in_length   : NATURAL := in_string'LENGTH; -- Define the length of the string to search in
		CONSTANT c_find_length : NATURAL := find_string'LENGTH; -- Define the length of the string to be find
		VARIABLE v_found_it    : BOOLEAN := FALSE;
	BEGIN
		FOR I IN 1 TO c_in_length - c_find_length LOOP
			IF (in_string(I TO (I + c_find_length - 1)) = find_string) THEN
				v_found_it := TRUE;
			END IF;
		END LOOP;
		RETURN (v_found_it);
	END FUNCTION func_find_string_in_string;

END tb_common_pkg;
