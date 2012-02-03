--  #####  ######  ### ### #######  #####  #####    #####
--    #     #    #  #   #  #  #  #    #      #     #     #
--    #     #    #  #   #     #       #      #     #
--    #     #    #  #   #     #       #      #     #
--    #     #####   #   #     #       #      #      #####
--    #     #       #   #     #       #      #           #
--    #     #       #   #     #       #      #           #
--    #     #       #   #     #       #      #   # #     #
--  #####  ####      ###     ###    #####  #######  #####


--   ##    ######   #####  ####### ### ###
--    #     #    #    #    #  #  #  #   #
--    #     #    #    #       #     #   #
--   # #    #    #    #       #     #   #
--   # #    #####     #       #     #####
--  #   #   #  #      #       #     #   #
--  #####   #  #      #       #     #   #
--  #   #   #   #     #       #     #   #
-- ### ### ###  ##  #####    ###   ### ###

-------------------------------------------------------------------------------
-- This file is a replica of std_logic_arith (08/2001) by Synopsys,
--  modified for use in the work library.
-------------------------------------------------------------------------------

--------------------------------------------------------------------------
--                                                                      --
-- Copyright (c) 1990,1991,1992 by Synopsys, Inc.  All rights reserved. --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--	Package name: iputils_std_logic_arith					--
--									--
--	Purpose: 							--
--	 A set of arithemtic, conversion, and comparison functions 	--
--	 for SIGNED, UNSIGNED, SMALL_INT, INTEGER, 			--
--	 STD_ULOGIC, STD_LOGIC, and STD_LOGIC_VECTOR.			--
--									--
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package iputils_std_logic_arith is

    type UNSIGNED is array (NATURAL range <>) of STD_LOGIC;
    type SIGNED is array (NATURAL range <>) of STD_LOGIC;
    subtype SMALL_INT is INTEGER range 0 to 1;

    function "+"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
    function "+"(L: SIGNED; R: SIGNED) return SIGNED;
    function "+"(L: UNSIGNED; R: SIGNED) return SIGNED;
    function "+"(L: SIGNED; R: UNSIGNED) return SIGNED;
    function "+"(L: UNSIGNED; R: INTEGER) return UNSIGNED;
    function "+"(L: INTEGER; R: UNSIGNED) return UNSIGNED;
    function "+"(L: SIGNED; R: INTEGER) return SIGNED;
    function "+"(L: INTEGER; R: SIGNED) return SIGNED;
    function "+"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED;
    function "+"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED;
    function "+"(L: SIGNED; R: STD_ULOGIC) return SIGNED;
    function "+"(L: STD_ULOGIC; R: SIGNED) return SIGNED;

    function "+"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR;

    function "-"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
    function "-"(L: SIGNED; R: SIGNED) return SIGNED;
    function "-"(L: UNSIGNED; R: SIGNED) return SIGNED;
    function "-"(L: SIGNED; R: UNSIGNED) return SIGNED;
    function "-"(L: UNSIGNED; R: INTEGER) return UNSIGNED;
    function "-"(L: INTEGER; R: UNSIGNED) return UNSIGNED;
    function "-"(L: SIGNED; R: INTEGER) return SIGNED;
    function "-"(L: INTEGER; R: SIGNED) return SIGNED;
    function "-"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED;
    function "-"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED;
    function "-"(L: SIGNED; R: STD_ULOGIC) return SIGNED;
    function "-"(L: STD_ULOGIC; R: SIGNED) return SIGNED;

    function "-"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR;

    function "+"(L: UNSIGNED) return UNSIGNED;
    function "+"(L: SIGNED) return SIGNED;
    function "-"(L: SIGNED) return SIGNED;
    function "ABS"(L: SIGNED) return SIGNED;

    function "+"(L: UNSIGNED) return STD_LOGIC_VECTOR;
    function "+"(L: SIGNED) return STD_LOGIC_VECTOR;
    function "-"(L: SIGNED) return STD_LOGIC_VECTOR;
    function "ABS"(L: SIGNED) return STD_LOGIC_VECTOR;

    function "*"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
    function "*"(L: SIGNED; R: SIGNED) return SIGNED;
    function "*"(L: SIGNED; R: UNSIGNED) return SIGNED;
    function "*"(L: UNSIGNED; R: SIGNED) return SIGNED;

    function "*"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "*"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
    function "*"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
    function "*"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;

    function "<"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function "<"(L: SIGNED; R: SIGNED) return BOOLEAN;
    function "<"(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function "<"(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function "<"(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function "<"(L: SIGNED; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: SIGNED) return BOOLEAN;

    function "<="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function "<="(L: SIGNED; R: SIGNED) return BOOLEAN;
    function "<="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function "<="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function "<="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function "<="(L: SIGNED; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: SIGNED) return BOOLEAN;

    function ">"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function ">"(L: SIGNED; R: SIGNED) return BOOLEAN;
    function ">"(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function ">"(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function ">"(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function ">"(L: SIGNED; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: SIGNED) return BOOLEAN;

    function ">="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function ">="(L: SIGNED; R: SIGNED) return BOOLEAN;
    function ">="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function ">="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function ">="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function ">="(L: SIGNED; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: SIGNED) return BOOLEAN;

    function "="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function "="(L: SIGNED; R: SIGNED) return BOOLEAN;
    function "="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function "="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function "="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function "="(L: SIGNED; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: SIGNED) return BOOLEAN;

    function "/="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
    function "/="(L: SIGNED; R: SIGNED) return BOOLEAN;
    function "/="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
    function "/="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
    function "/="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
    function "/="(L: SIGNED; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: SIGNED) return BOOLEAN;

    function SHL(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED;
    function SHL(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED;
    function SHR(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED;
    function SHR(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED;

    function CONV_INTEGER(ARG: INTEGER) return INTEGER;
    function CONV_INTEGER(ARG: UNSIGNED) return INTEGER;
    function CONV_INTEGER(ARG: SIGNED) return INTEGER;
    function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT;

    function CONV_UNSIGNED(ARG: INTEGER; SIZE: INTEGER) return UNSIGNED;
    function CONV_UNSIGNED(ARG: UNSIGNED; SIZE: INTEGER) return UNSIGNED;
    function CONV_UNSIGNED(ARG: SIGNED; SIZE: INTEGER) return UNSIGNED;
    function CONV_UNSIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return UNSIGNED;

    function CONV_SIGNED(ARG: INTEGER; SIZE: INTEGER) return SIGNED;
    function CONV_SIGNED(ARG: UNSIGNED; SIZE: INTEGER) return SIGNED;
    function CONV_SIGNED(ARG: SIGNED; SIZE: INTEGER) return SIGNED;
    function CONV_SIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return SIGNED;

    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER)
						       return STD_LOGIC_VECTOR;
    function CONV_STD_LOGIC_VECTOR(ARG: UNSIGNED; SIZE: INTEGER)
						       return STD_LOGIC_VECTOR;
    function CONV_STD_LOGIC_VECTOR(ARG: SIGNED; SIZE: INTEGER)
						       return STD_LOGIC_VECTOR;
    function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER)
						       return STD_LOGIC_VECTOR;
    -- zero extend STD_LOGIC_VECTOR (ARG) to SIZE,
    -- SIZE < 0 is same as SIZE = 0
    -- returns STD_LOGIC_VECTOR(SIZE-1 downto 0)
    function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;

    -- sign extend STD_LOGIC_VECTOR (ARG) to SIZE,
    -- SIZE < 0 is same as SIZE = 0
    -- return STD_LOGIC_VECTOR(SIZE-1 downto 0)
    function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;

end iputils_std_logic_arith;



library IEEE;
use IEEE.std_logic_1164.all;

package body iputils_std_logic_arith is

    function max(L, R: INTEGER) return INTEGER is
    begin
	if L > R then
	    return L;
	else
	    return R;
	end if;
    end;


    function min(L, R: INTEGER) return INTEGER is
    begin
	if L < R then
	    return L;
	else
	    return R;
	end if;
    end;

    -- synopsys synthesis_off
    type tbl_type is array (STD_ULOGIC) of STD_ULOGIC;
    constant tbl_BINARY : tbl_type :=
	('X', 'X', '0', '1', 'X', 'X', '0', '1', 'X');
    -- synopsys synthesis_on

    -- synopsys synthesis_off
    type tbl_mvl9_boolean is array (STD_ULOGIC) of boolean;
    constant IS_X : tbl_mvl9_boolean :=
        (true, true, false, false, true, true, false, false, true);
    -- synopsys synthesis_on



    function MAKE_BINARY(A : STD_ULOGIC) return STD_ULOGIC is
	-- synopsys built_in SYN_FEED_THRU
    begin
	-- synopsys synthesis_off
	    if (IS_X(A)) then
		assert false
		report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		severity warning;
	        return ('X');
	    end if;
	    return tbl_BINARY(A);
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : UNSIGNED) return UNSIGNED is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : UNSIGNED (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : UNSIGNED) return SIGNED is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : SIGNED (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : SIGNED) return UNSIGNED is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : UNSIGNED (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : SIGNED) return SIGNED is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : SIGNED (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : STD_LOGIC_VECTOR (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : UNSIGNED) return STD_LOGIC_VECTOR is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : STD_LOGIC_VECTOR (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;

    function MAKE_BINARY(A : SIGNED) return STD_LOGIC_VECTOR is
	-- synopsys built_in SYN_FEED_THRU
	variable one_bit : STD_ULOGIC;
	variable result : STD_LOGIC_VECTOR (A'range);
    begin
	-- synopsys synthesis_off
	    for i in A'range loop
	        if (IS_X(A(i))) then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
	-- synopsys synthesis_on
    end;



    -- Type propagation function which returns a signed type with the
    -- size of the left arg.
    function LEFT_SIGNED_ARG(A,B: SIGNED) return SIGNED is
      variable Z: SIGNED (A'left downto 0);
      -- pragma return_port_name Z
    begin
      return(Z);
    end;

    -- Type propagation function which returns an unsigned type with the
    -- size of the left arg.
    function LEFT_UNSIGNED_ARG(A,B: UNSIGNED) return UNSIGNED is
      variable Z: UNSIGNED (A'left downto 0);
      -- pragma return_port_name Z
    begin
      return(Z);
    end;

    -- Type propagation function which returns a signed type with the
    -- size of the result of a signed multiplication
    function MULT_SIGNED_ARG(A,B: SIGNED) return SIGNED is
      variable Z: SIGNED ((A'length+B'length-1) downto 0);
      -- pragma return_port_name Z
    begin
      return(Z);
    end;

    -- Type propagation function which returns an unsigned type with the
    -- size of the result of a unsigned multiplication
    function MULT_UNSIGNED_ARG(A,B: UNSIGNED) return UNSIGNED is
      variable Z: UNSIGNED ((A'length+B'length-1) downto 0);
      -- pragma return_port_name Z
    begin
      return(Z);
    end;



    function mult(A,B: SIGNED) return SIGNED is

      variable BA: SIGNED((A'length+B'length-1) downto 0);
      variable PA: SIGNED((A'length+B'length-1) downto 0);
      variable AA: SIGNED(A'length downto 0);
      variable neg: STD_ULOGIC;
      constant one : UNSIGNED(1 downto 0) := "01";

      -- pragma map_to_operator MULT_TC_OP
      -- pragma type_function MULT_SIGNED_ARG
      -- pragma return_port_name Z

      begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            PA := (others => 'X');
            return(PA);
	end if;
        PA := (others => '0');
        neg := B(B'left) xor A(A'left);
        BA := CONV_SIGNED(('0' & ABS(B)),(A'length+B'length));
        AA := '0' & ABS(A);
        for i in 0 to A'length-1 loop
          if AA(i) = '1' then
            PA := PA+BA;
          end if;
          BA := SHL(BA,one);
        end loop;
        if (neg= '1') then
          return(-PA);
        else
          return(PA);
        end if;
      end;

    function mult(A,B: UNSIGNED) return UNSIGNED is

      variable BA: UNSIGNED((A'length+B'length-1) downto 0);
      variable PA: UNSIGNED((A'length+B'length-1) downto 0);
      constant one : UNSIGNED(1 downto 0) := "01";

      -- pragma map_to_operator MULT_UNS_OP
      -- pragma type_function MULT_UNSIGNED_ARG
      -- pragma return_port_name Z

      begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            PA := (others => 'X');
            return(PA);
	end if;
        PA := (others => '0');
        BA := CONV_UNSIGNED(B,(A'length+B'length));
        for i in 0 to A'length-1 loop
          if A(i) = '1' then
            PA := PA+BA;
          end if;
          BA := SHL(BA,one);
        end loop;
        return(PA);
      end;

    -- subtract two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
    function minus(A, B: SIGNED) return SIGNED is
	variable carry: STD_ULOGIC;
	variable BV: STD_ULOGIC_VECTOR (A'left downto 0);
	variable sum: SIGNED (A'left downto 0);

	-- pragma map_to_operator SUB_TC_OP

	-- pragma type_function LEFT_SIGNED_ARG
        -- pragma return_port_name Z

    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '1';
	BV := not STD_ULOGIC_VECTOR(B);

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;

    -- add two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
    function plus(A, B: SIGNED) return SIGNED is
	variable carry: STD_ULOGIC;
	variable BV, sum: SIGNED (A'left downto 0);

	-- pragma map_to_operator ADD_TC_OP
	-- pragma type_function LEFT_SIGNED_ARG
        -- pragma return_port_name Z

    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '0';
	BV := B;

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;


    -- subtract two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function unsigned_minus(A, B: UNSIGNED) return UNSIGNED is
	variable carry: STD_ULOGIC;
	variable BV: STD_ULOGIC_VECTOR (A'left downto 0);
	variable sum: UNSIGNED (A'left downto 0);

	-- pragma map_to_operator SUB_UNS_OP
	-- pragma type_function LEFT_UNSIGNED_ARG
        -- pragma return_port_name Z

    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '1';
	BV := not STD_ULOGIC_VECTOR(B);

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;

    -- add two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function unsigned_plus(A, B: UNSIGNED) return UNSIGNED is
	variable carry: STD_ULOGIC;
	variable BV, sum: UNSIGNED (A'left downto 0);

	-- pragma map_to_operator ADD_UNS_OP
	-- pragma type_function LEFT_UNSIGNED_ARG
        -- pragma return_port_name Z

    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '0';
	BV := B;

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;



    function "*"(L: SIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 296
    begin
          return     mult(CONV_SIGNED(L, L'length),
		          CONV_SIGNED(R, R'length)); -- pragma label mult
    end;

    function "*"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 295
    begin
          return   mult(CONV_UNSIGNED(L, L'length),
                        CONV_UNSIGNED(R, R'length)); -- pragma label mult
    end;

    function "*"(L: UNSIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 297
    begin
 	return       mult(CONV_SIGNED(L, L'length+1),
		          CONV_SIGNED(R, R'length)); -- pragma label mult
    end;

    function "*"(L: SIGNED; R: UNSIGNED) return SIGNED is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 298
    begin
	return      mult(CONV_SIGNED(L, L'length),
		         CONV_SIGNED(R, R'length+1)); -- pragma label mult
    end;


    function "*"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 301
    begin
          return STD_LOGIC_VECTOR (
		mult(-- pragma label mult
		CONV_SIGNED(L, L'length), CONV_SIGNED(R, R'length)));
    end;

    function "*"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 300
    begin
          return STD_LOGIC_VECTOR (
		mult(-- pragma label mult
		CONV_UNSIGNED(L, L'length), CONV_UNSIGNED(R, R'length)));
    end;

    function "*"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 302
    begin
 	return STD_LOGIC_VECTOR (
		mult(-- pragma label mult
		CONV_SIGNED(L, L'length+1), CONV_SIGNED(R, R'length)));
    end;

    function "*"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to mult
	-- synopsys subpgm_id 303
    begin
	return STD_LOGIC_VECTOR (
		mult(-- pragma label mult
		CONV_SIGNED(L, L'length), CONV_SIGNED(R, R'length+1)));
    end;


    function "+"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 236
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_plus(CONV_UNSIGNED(L, length),
			     CONV_UNSIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: SIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 237
	constant length: INTEGER := max(L'length, R'length);
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: UNSIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 238
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: SIGNED; R: UNSIGNED) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 239
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: UNSIGNED; R: INTEGER) return UNSIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 240
	constant length: INTEGER := L'length + 1;
    begin
	return CONV_UNSIGNED(
		plus( -- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "+"(L: INTEGER; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 241
	constant length: INTEGER := R'length + 1;
    begin
	return CONV_UNSIGNED(
		plus( -- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "+"(L: SIGNED; R: INTEGER) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 242
	constant length: INTEGER := L'length;
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: INTEGER; R: SIGNED) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 243
	constant length: INTEGER := R'length;
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 244
	constant length: INTEGER := L'length;
    begin
	return unsigned_plus(CONV_UNSIGNED(L, length),
		     CONV_UNSIGNED(R, length)) ; -- pragma label plus
    end;


    function "+"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 245
	constant length: INTEGER := R'length;
    begin
	return unsigned_plus(CONV_UNSIGNED(L, length),
		     CONV_UNSIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: SIGNED; R: STD_ULOGIC) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 246
	constant length: INTEGER := L'length;
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;


    function "+"(L: STD_ULOGIC; R: SIGNED) return SIGNED is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 247
	constant length: INTEGER := R'length;
    begin
	return plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)); -- pragma label plus
    end;



    function "+"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 260
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (
		unsigned_plus(-- pragma label plus
		CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)));
    end;


    function "+"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 261
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 262
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 263
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 264
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		plus( -- pragma label plus
	        CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "+"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 265
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		plus( -- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "+"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 266
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 267
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 268
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (
		unsigned_plus(-- pragma label plus
		CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length))) ;
    end;


    function "+"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 269
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (
		unsigned_plus(-- pragma label plus
		CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)));
    end;


    function "+"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 270
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "+"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to plus
	-- synopsys subpgm_id 271
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (
		plus(-- pragma label plus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;



    function "-"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 248
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_minus(CONV_UNSIGNED(L, length),
		      	      CONV_UNSIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: SIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 249
	constant length: INTEGER := max(L'length, R'length);
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: UNSIGNED; R: SIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 250
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: SIGNED; R: UNSIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 251
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: UNSIGNED; R: INTEGER) return UNSIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 252
	constant length: INTEGER := L'length + 1;
    begin
	return CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "-"(L: INTEGER; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 253
	constant length: INTEGER := R'length + 1;
    begin
	return CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "-"(L: SIGNED; R: INTEGER) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 254
	constant length: INTEGER := L'length;
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: INTEGER; R: SIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 255
	constant length: INTEGER := R'length;
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 256
	constant length: INTEGER := L'length + 1;
    begin
	return CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "-"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 257
	constant length: INTEGER := R'length + 1;
    begin
	return CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1);
    end;


    function "-"(L: SIGNED; R: STD_ULOGIC) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 258
	constant length: INTEGER := L'length;
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;


    function "-"(L: STD_ULOGIC; R: SIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 259
	constant length: INTEGER := R'length;
    begin
	return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); -- pragma label minus
    end;




    function "-"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 272
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (
		unsigned_minus(-- pragma label minus
		CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)));
    end;


    function "-"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 273
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 274
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 275
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 276
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "-"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 277
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "-"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 278
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 279
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 280
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "-"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 281
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus( -- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)), length-1));
    end;


    function "-"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 282
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;


    function "-"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 283
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (
		minus(-- pragma label minus
		CONV_SIGNED(L, length), CONV_SIGNED(R, length)));
    end;




    function "+"(L: UNSIGNED) return UNSIGNED is
	-- synopsys subpgm_id 284
    begin
	return L;
    end;


    function "+"(L: SIGNED) return SIGNED is
	-- synopsys subpgm_id 285
    begin
	return L;
    end;


    function "-"(L: SIGNED) return SIGNED is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 286
    begin
	return 0 - L; -- pragma label minus
    end;


    function "ABS"(L: SIGNED) return SIGNED is
	-- synopsys subpgm_id 287
    begin
	if (L(L'left) = '0' or L(L'left) = 'L') then
	    return L;
	else
	    return 0 - L;
	end if;
    end;


    function "+"(L: UNSIGNED) return STD_LOGIC_VECTOR is
	-- synopsys subpgm_id 289
    begin
	return STD_LOGIC_VECTOR (L);
    end;


    function "+"(L: SIGNED) return STD_LOGIC_VECTOR is
	-- synopsys subpgm_id 290
    begin
	return STD_LOGIC_VECTOR (L);
    end;


    function "-"(L: SIGNED) return STD_LOGIC_VECTOR is
	-- pragma label_applies_to minus
	-- synopsys subpgm_id 292
	variable tmp: SIGNED(L'length-1 downto 0);
    begin
	tmp := 0 - L;  -- pragma label minus
	return STD_LOGIC_VECTOR (tmp);
    end;


    function "ABS"(L: SIGNED) return STD_LOGIC_VECTOR is
	-- synopsys subpgm_id 294
	variable tmp: SIGNED(L'length-1 downto 0);
    begin
	if (L(L'left) = '0' or L(L'left) = 'L') then
	    return STD_LOGIC_VECTOR (L);
	else
	    tmp := 0 - L;
	    return STD_LOGIC_VECTOR (tmp);
	end if;
    end;


    -- Type propagation function which returns the type BOOLEAN
    function UNSIGNED_RETURN_BOOLEAN(A,B: UNSIGNED) return BOOLEAN is
      variable Z: BOOLEAN;
      -- pragma return_port_name Z
    begin
      return(Z);
    end;

    -- Type propagation function which returns the type BOOLEAN
    function SIGNED_RETURN_BOOLEAN(A,B: SIGNED) return BOOLEAN is
      variable Z: BOOLEAN;
      -- pragma return_port_name Z
    begin
      return(Z);
    end;


    -- compare two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
    function is_less(A, B: SIGNED) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;

	-- pragma map_to_operator LT_TC_OP
	-- pragma type_function SIGNED_RETURN_BOOLEAN
        -- pragma return_port_name Z

    begin
	if A(sign) /= B(sign) then
	    result := A(sign) = '1';
	else
	    result := FALSE;
	    for i in 0 to sign-1 loop
		a_is_0 := A(i) = '0';
		b_is_1 := B(i) = '1';
		result := (a_is_0 and b_is_1) or
			  (a_is_0 and result) or
			  (b_is_1 and result);
	    end loop;
	end if;
	return result;
    end;


    -- compare two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
    function is_less_or_equal(A, B: SIGNED) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;

	-- pragma map_to_operator LEQ_TC_OP
	-- pragma type_function SIGNED_RETURN_BOOLEAN
        -- pragma return_port_name Z

    begin
	if A(sign) /= B(sign) then
	    result := A(sign) = '1';
	else
	    result := TRUE;
	    for i in 0 to sign-1 loop
		a_is_0 := A(i) = '0';
		b_is_1 := B(i) = '1';
		result := (a_is_0 and b_is_1) or
			  (a_is_0 and result) or
			  (b_is_1 and result);
	    end loop;
	end if;
	return result;
    end;



    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function unsigned_is_less(A, B: UNSIGNED) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;

	-- pragma map_to_operator LT_UNS_OP
	-- pragma type_function UNSIGNED_RETURN_BOOLEAN
        -- pragma return_port_name Z

    begin
	result := FALSE;
	for i in 0 to sign loop
	    a_is_0 := A(i) = '0';
	    b_is_1 := B(i) = '1';
	    result := (a_is_0 and b_is_1) or
		      (a_is_0 and result) or
		      (b_is_1 and result);
	end loop;
	return result;
    end;


    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function unsigned_is_less_or_equal(A, B: UNSIGNED) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;

	-- pragma map_to_operator LEQ_UNS_OP
	-- pragma type_function UNSIGNED_RETURN_BOOLEAN
        -- pragma return_port_name Z

    begin
	result := TRUE;
	for i in 0 to sign loop
	    a_is_0 := A(i) = '0';
	    b_is_1 := B(i) = '1';
	    result := (a_is_0 and b_is_1) or
		      (a_is_0 and result) or
		      (b_is_1 and result);
	end loop;
	return result;
    end;




    function "<"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 305
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_is_less(CONV_UNSIGNED(L, length),
				CONV_UNSIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 306
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 307
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 308
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 309
	constant length: INTEGER := L'length + 1;
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 310
	constant length: INTEGER := R'length + 1;
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 311
	constant length: INTEGER := L'length;
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;


    function "<"(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to lt
	-- synopsys subpgm_id 312
	constant length: INTEGER := R'length;
    begin
	return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); -- pragma label lt
    end;




    function "<="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 314
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_is_less_or_equal(CONV_UNSIGNED(L, length),
			     CONV_UNSIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 315
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 316
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 317
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 318
	constant length: INTEGER := L'length + 1;
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 319
	constant length: INTEGER := R'length + 1;
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 320
	constant length: INTEGER := L'length;
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;


    function "<="(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to leq
	-- synopsys subpgm_id 321
	constant length: INTEGER := R'length;
    begin
	return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); -- pragma label leq
    end;




    function ">"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 323
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_is_less(CONV_UNSIGNED(R, length),
				CONV_UNSIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 324
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 325
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 326
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 327
	constant length: INTEGER := L'length + 1;
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 328
	constant length: INTEGER := R'length + 1;
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 329
	constant length: INTEGER := L'length;
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;


    function ">"(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to gt
	-- synopsys subpgm_id 330
	constant length: INTEGER := R'length;
    begin
	return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); -- pragma label gt
    end;




    function ">="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 332
	constant length: INTEGER := max(L'length, R'length);
    begin
	return unsigned_is_less_or_equal(CONV_UNSIGNED(R, length),
			CONV_UNSIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 333
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
			CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 334
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
			CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 335
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
			CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 336
	constant length: INTEGER := L'length + 1;
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 337
	constant length: INTEGER := R'length + 1;
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 338
	constant length: INTEGER := L'length;
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); -- pragma label geq
    end;


    function ">="(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- pragma label_applies_to geq
	-- synopsys subpgm_id 339
	constant length: INTEGER := R'length;
    begin
	return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); -- pragma label geq
    end;




    -- for internal use only.  Assumes SIGNED arguments of equal length.
    function bitwise_eql(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
						return BOOLEAN is
	-- pragma built_in SYN_EQL
    begin
	for i in L'range loop
	    if L(i) /= R(i) then
		return FALSE;
	    end if;
	end loop;
	return TRUE;
    end;

    -- for internal use only.  Assumes SIGNED arguments of equal length.
    function bitwise_neq(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
						return BOOLEAN is
	-- pragma built_in SYN_NEQ
    begin
	for i in L'range loop
	    if L(i) /= R(i) then
		return TRUE;
	    end if;
	end loop;
	return FALSE;
    end;


    function "="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 341
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_UNSIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_UNSIGNED(R, length) ) );
    end;


    function "="(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 342
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 343
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 344
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- synopsys subpgm_id 345
	constant length: INTEGER := L'length + 1;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 346
	constant length: INTEGER := R'length + 1;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- synopsys subpgm_id 347
	constant length: INTEGER := L'length;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "="(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 348
	constant length: INTEGER := R'length;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;




    function "/="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 350
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_UNSIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_UNSIGNED(R, length) ) );
    end;


    function "/="(L: SIGNED; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 351
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 352
	constant length: INTEGER := max(L'length + 1, R'length);
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 353
	constant length: INTEGER := max(L'length, R'length + 1);
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
	-- synopsys subpgm_id 354
	constant length: INTEGER := L'length + 1;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
	-- synopsys subpgm_id 355
	constant length: INTEGER := R'length + 1;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: SIGNED; R: INTEGER) return BOOLEAN is
	-- synopsys subpgm_id 356
	constant length: INTEGER := L'length;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;


    function "/="(L: INTEGER; R: SIGNED) return BOOLEAN is
	-- synopsys subpgm_id 357
	constant length: INTEGER := R'length;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
    end;



    function SHL(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
	-- synopsys subpgm_id 358
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: UNSIGNED (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is UNSIGNED (result_msb downto 0);
	variable result, temp: rtype;
    begin
	control := MAKE_BINARY(COUNT);
	-- synopsys synthesis_off
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	-- synopsys synthesis_on
	result := ARG;
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => '0');
		if 2**i <= result_msb then
		    temp(result_msb downto 2**i) :=
				    result(result_msb - 2**i downto 0);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;

    function SHL(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
	-- synopsys subpgm_id 359
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: UNSIGNED (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is SIGNED (result_msb downto 0);
	variable result, temp: rtype;
    begin
	control := MAKE_BINARY(COUNT);
	-- synopsys synthesis_off
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	-- synopsys synthesis_on
	result := ARG;
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => '0');
		if 2**i <= result_msb then
		    temp(result_msb downto 2**i) :=
				    result(result_msb - 2**i downto 0);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;


    function SHR(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
	-- synopsys subpgm_id 360
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: UNSIGNED (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is UNSIGNED (result_msb downto 0);
	variable result, temp: rtype;
    begin
	control := MAKE_BINARY(COUNT);
	-- synopsys synthesis_off
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	-- synopsys synthesis_on
	result := ARG;
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => '0');
		if 2**i <= result_msb then
		    temp(result_msb - 2**i downto 0) :=
					result(result_msb downto 2**i);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;

    function SHR(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
	-- synopsys subpgm_id 361
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: UNSIGNED (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is SIGNED (result_msb downto 0);
	variable result, temp: rtype;
	variable sign_bit: STD_ULOGIC;
    begin
	control := MAKE_BINARY(COUNT);
	-- synopsys synthesis_off
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	-- synopsys synthesis_on
	result := ARG;
	sign_bit := ARG(ARG'left);
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => sign_bit);
		if 2**i <= result_msb then
		    temp(result_msb - 2**i downto 0) :=
					result(result_msb downto 2**i);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;




    function CONV_INTEGER(ARG: INTEGER) return INTEGER is
	-- synopsys subpgm_id 365
    begin
	return ARG;
    end;

    function CONV_INTEGER(ARG: UNSIGNED) return INTEGER is
	variable result: INTEGER;
	variable tmp: STD_ULOGIC;
	-- synopsys built_in SYN_UNSIGNED_TO_INTEGER
	-- synopsys subpgm_id 366
    begin
	-- synopsys synthesis_off
	assert ARG'length <= 31
	    report "ARG is too large in CONV_INTEGER"
	    severity FAILURE;
	result := 0;
	for i in ARG'range loop
	    result := result * 2;
	    tmp := tbl_BINARY(ARG(i));
	    if tmp = '1' then
		result := result + 1;
	    elsif tmp = 'X' then
		assert false
		report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		severity warning;
		assert false
		report "CONV_INTEGER: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, and it has been converted to 0."
		severity WARNING;
		return 0;
	    end if;
	end loop;
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_INTEGER(ARG: SIGNED) return INTEGER is
	variable result: INTEGER;
	variable tmp: STD_ULOGIC;
	-- synopsys built_in SYN_SIGNED_TO_INTEGER
	-- synopsys subpgm_id 367
    begin
	-- synopsys synthesis_off
	assert ARG'length <= 32
	    report "ARG is too large in CONV_INTEGER"
	    severity FAILURE;
	result := 0;
	for i in ARG'range loop
	    if i /= ARG'left then
		result := result * 2;
	        tmp := tbl_BINARY(ARG(i));
	        if tmp = '1' then
		    result := result + 1;
	        elsif tmp = 'X' then
		    assert false
		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
		    severity warning;
		    assert false
		    report "CONV_INTEGER: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, and it has been converted to 0."
		    severity WARNING;
		    return 0;
	        end if;
	    end if;
	end loop;
	tmp := MAKE_BINARY(ARG(ARG'left));
	if tmp = '1' then
	    if ARG'length = 32 then
		result := (result - 2**30) - 2**30;
	    else
		result := result - (2 ** (ARG'length-1));
	    end if;
	end if;
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT is
	variable tmp: STD_ULOGIC;
	-- synopsys built_in SYN_FEED_THRU
	-- synopsys subpgm_id 370
    begin
	-- synopsys synthesis_off
	tmp := tbl_BINARY(ARG);
	if tmp = '1' then
	    return 1;
	elsif tmp = 'X' then
	    assert false
	    report "CONV_INTEGER: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, and it has been converted to 0."
	    severity WARNING;
	    return 0;
	else
	    return 0;
	end if;
	-- synopsys synthesis_on
    end;


    -- convert an integer to a unsigned STD_ULOGIC_VECTOR
    function CONV_UNSIGNED(ARG: INTEGER; SIZE: INTEGER) return UNSIGNED is
	variable result: UNSIGNED(SIZE-1 downto 0);
	variable temp: integer;
	-- synopsys built_in SYN_INTEGER_TO_UNSIGNED
	-- synopsys subpgm_id 371
    begin
	-- synopsys synthesis_off
	temp := ARG;
	for i in 0 to SIZE-1 loop
	    if (temp mod 2) = 1 then
		result(i) := '1';
	    else
		result(i) := '0';
	    end if;
	    if temp > 0 then
		temp := temp / 2;
	    else
		temp := (temp - 1) / 2; -- simulate ASR
	    end if;
	end loop;
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_UNSIGNED(ARG: UNSIGNED; SIZE: INTEGER) return UNSIGNED is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is UNSIGNED (SIZE-1 downto 0);
	variable new_bounds: UNSIGNED (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 372
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => '0');
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_UNSIGNED(ARG: SIGNED; SIZE: INTEGER) return UNSIGNED is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is UNSIGNED (SIZE-1 downto 0);
	variable new_bounds: UNSIGNED (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_SIGN_EXTEND
	-- synopsys subpgm_id 373
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => new_bounds(new_bounds'left));
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_UNSIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return UNSIGNED is
	subtype rtype is UNSIGNED (SIZE-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 375
    begin
	-- synopsys synthesis_off
	result := rtype'(others => '0');
	result(0) := MAKE_BINARY(ARG);
	if (result(0) = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
	-- synopsys synthesis_on
    end;


    -- convert an integer to a 2's complement STD_ULOGIC_VECTOR
    function CONV_SIGNED(ARG: INTEGER; SIZE: INTEGER) return SIGNED is
	variable result: SIGNED (SIZE-1 downto 0);
	variable temp: integer;
	-- synopsys built_in SYN_INTEGER_TO_SIGNED
	-- synopsys subpgm_id 376
    begin
	-- synopsys synthesis_off
	temp := ARG;
	for i in 0 to SIZE-1 loop
	    if (temp mod 2) = 1 then
		result(i) := '1';
	    else
		result(i) := '0';
	    end if;
	    if temp > 0 then
		temp := temp / 2;
	    elsif (temp > integer'low) then
		temp := (temp - 1) / 2; -- simulate ASR
	    else
		temp := temp / 2; -- simulate ASR
	    end if;
	end loop;
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_SIGNED(ARG: UNSIGNED; SIZE: INTEGER) return SIGNED is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is SIGNED (SIZE-1 downto 0);
	variable new_bounds : SIGNED (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 377
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => '0');
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;

    function CONV_SIGNED(ARG: SIGNED; SIZE: INTEGER) return SIGNED is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is SIGNED (SIZE-1 downto 0);
	variable new_bounds : SIGNED (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_SIGN_EXTEND
	-- synopsys subpgm_id 378
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => new_bounds(new_bounds'left));
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_SIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return SIGNED is
	subtype rtype is SIGNED (SIZE-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 380
    begin
	-- synopsys synthesis_off
	result := rtype'(others => '0');
	result(0) := MAKE_BINARY(ARG);
	if (result(0) = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
	-- synopsys synthesis_on
    end;


    -- convert an integer to an STD_LOGIC_VECTOR
    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	variable result: STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable temp: integer;
	-- synopsys built_in SYN_INTEGER_TO_BIT_VECTOR
	-- synopsys subpgm_id 381
    begin
	-- synopsys synthesis_off
	temp := ARG;
	for i in 0 to SIZE-1 loop
	    if (temp mod 2) = 1 then
		result(i) := '1';
	    else
		result(i) := '0';
	    end if;
	    if temp > 0 then
		temp := temp / 2;
	    elsif (temp > integer'low) then
		temp := (temp - 1) / 2; -- simulate ASR
	    else
		temp := temp / 2; -- simulate ASR
	    end if;
	end loop;
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_STD_LOGIC_VECTOR(ARG: UNSIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 382
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => '0');
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;

    function CONV_STD_LOGIC_VECTOR(ARG: SIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_SIGN_EXTEND
	-- synopsys subpgm_id 383
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => new_bounds(new_bounds'left));
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


    function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 384
    begin
	-- synopsys synthesis_off
	result := rtype'(others => '0');
	result(0) := MAKE_BINARY(ARG);
	if (result(0) = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
	-- synopsys synthesis_on
    end;

    function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER)
						return STD_LOGIC_VECTOR is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds: STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_ZERO_EXTEND
	-- synopsys subpgm_id 385
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => '0');
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


    function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
	-- synopsys built_in SYN_SIGN_EXTEND
	-- synopsys subpgm_id 386
    begin
	-- synopsys synthesis_off
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => new_bounds(new_bounds'left));
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
	-- synopsys synthesis_on
    end;


end iputils_std_logic_arith;


-- ### ### ##  ###  #####   #####    ####  ##  ### ####### #####
--  #   #   #   #  #     #    #     #    #  #   #   #    #  #   #
--  #   #   ##  #  #          #    #        ##  #   #       #    #
--  #   #   ##  #  #          #    #        ##  #   #  #    #    #
--  #   #   # # #   #####     #    #        # # #   ####    #    #
--  #   #   #  ##        #    #    #   ###  #  ##   #  #    #    #
--  #   #   #  ##        #    #    #     #  #  ##   #       #    #
--  #   #   #   #  #     #    #     #    #  #   #   #    #  #   #
--   ###   ###  #   #####   #####    ####  ###  #  ####### #####

-------------------------------------------------------------------------------
-- This file is a replica of std_logic_unsigned (08/2001) by Synopsys,
--  modified for use in the work library.
-------------------------------------------------------------------------------

--------------------------------------------------------------------------
--                                                                      --
-- Copyright (c) 1990, 1991, 1992 by Synopsys, Inc.                     --
--                                             All rights reserved.     --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--	Package name: iputils_std_logic_unsigned                                --
--                                 					--
--									--
--      Date:        	09/11/92	KN				--
--			10/08/92 	AMT				--
--									--
--	Purpose: 							--
--	 A set of unsigned arithemtic, conversion,                      --
--           and comparision functions for STD_LOGIC_VECTOR.            --
--									--
--	Note:  comparision of same length discrete arrays is defined	--
--		by the LRM.  This package will "overload" those 	--
--		definitions						--
--									--
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


LIBRARY work;
USE work.iputils_std_logic_arith.ALL;
--use IEEE.std_logic_arith.all;

package iputils_std_logic_unsigned is

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER;

-- remove this since it is already in std_logic_arith
--    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR;

end iputils_std_logic_unsigned;

library IEEE;
use IEEE.std_logic_1164.all;

LIBRARY work;
USE work.iputils_std_logic_arith.ALL;
--use IEEE.std_logic_arith.all;

package body iputils_std_logic_unsigned is


    function maximum(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;


    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := UNSIGNED(L) + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) + R;-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) + R;-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
            -- pragma label_applies_to plus
    variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := UNSIGNED(L) - UNSIGNED(R); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) - R; -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - UNSIGNED(R);  -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) - R;
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - UNSIGNED(R);  -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := + UNSIGNED(L);
        return   std_logic_vector(result);
    end;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to mult
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR ((L'length+R'length-1) downto 0);
    begin
        result  := UNSIGNED(L) * UNSIGNED(R); -- pragma label mult
        return   std_logic_vector(result);
    end;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
        constant length: INTEGER := maximum(L'length, R'length);
    begin
        return   UNSIGNED(L) < UNSIGNED(R); -- pragma label lt
    end;

    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to lt
    begin
        return   UNSIGNED(L) < R; -- pragma label lt
    end;

    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
    begin
        return   L < UNSIGNED(R); -- pragma label lt
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   UNSIGNED(L) <= UNSIGNED(R); -- pragma label leq
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   UNSIGNED(L) <= R; -- pragma label leq
    end;

    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   L <= UNSIGNED(R); -- pragma label leq
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   UNSIGNED(L) > UNSIGNED(R); -- pragma label gt
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   UNSIGNED(L) > R; -- pragma label gt
    end;

    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   L > UNSIGNED(R); -- pragma label gt
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   UNSIGNED(L) >= UNSIGNED(R);  -- pragma label geq
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   UNSIGNED(L) >= R;  -- pragma label geq
    end;

    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   L >= UNSIGNED(R);  -- pragma label geq
    end;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   UNSIGNED(L) = UNSIGNED(R);
    end;

    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   UNSIGNED(L) = R;
    end;

    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L = UNSIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   UNSIGNED(L) /= UNSIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   UNSIGNED(L) /= R;
    end;

    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L /= UNSIGNED(R);
    end;

    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
        variable result    : UNSIGNED(ARG'range);
    begin
        result    := UNSIGNED(ARG);
        return   CONV_INTEGER(result);
    end;
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHL(UNSIGNED(ARG),UNSIGNED(COUNT)));
    end;

    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHR(UNSIGNED(ARG),UNSIGNED(COUNT)));
    end;


-- remove this since it is already in std_logic_arith
    --function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
        --variable result1 : UNSIGNED (SIZE-1 downto 0);
        --variable result2 : STD_LOGIC_VECTOR (SIZE-1 downto 0);
    --begin
        --result1 := CONV_UNSIGNED(ARG,SIZE);
        --return   std_logic_vector(result1);
    --end;


end iputils_std_logic_unsigned;


--   ####    ###   ##  ### ### ###
--  #    #  #   #   #   #   #   #
-- #       #     #  ##  #   #   #
-- #       #     #  ##  #   #   #
-- #       #     #  # # #    # #
-- #       #     #  #  ##    # #
-- #       #     #  #  ##    # #
--  #    #  #   #   #   #     #
--   ####    ###   ###  #     #

-------------------------------------------------------------------------------
-- $Id: xilinx_sim_src.vhd 111 2006-06-29 22:33:33Z hchen05 $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Data Type Conversion Functions
--
-------------------------------------------------------------------------------
--
-- This file is owned and controlled by Xilinx and must be used solely
-- for design, simulation, implementation and creation of design files
-- limited to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and immediately
-- terminates your license.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
--            **************************************
--            ** Copyright (C) 2000, Xilinx, Inc. **
--            ** All Rights Reserved.             **
--            **************************************
--
-------------------------------------------------------------------------------
--
-- This file contains the following packages:
--   iputils_conv - data conversions between different data types
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
---- iputils_conv
----   data conversions between different data types
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_conv IS

	FUNCTION rat( value : std_logic )
	RETURN std_logic;

    FUNCTION std_logic_vector_2_string(v : STD_LOGIC_VECTOR)
    RETURN STRING;

    FUNCTION std_logic_2_string(v : STD_LOGIC)
    RETURN STRING;

    FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
	RETURN integer;

	FUNCTION two_comp(vect : std_logic_vector)
	RETURN std_logic_vector;

	FUNCTION int_2_std_logic_vector( value, bitwidth : integer )
	RETURN std_logic_vector;

	FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
	RETURN integer;

     FUNCTION int_2_boolean(int: integer)
       RETURN BOOLEAN;

     FUNCTION int_2_string(val : integer; str_length :integer)
       RETURN string;

     FUNCTION bint_2_sl (X : integer)
       RETURN std_logic;

     FUNCTION str_to_slv_0(bitsin : string; nbits : integer)
       RETURN std_logic_vector;

  FUNCTION number_of_bits (data_value : integer)
    RETURN integer;

  FUNCTION number_of_digits (data_value : integer; radix : integer)
    RETURN integer;

  FUNCTION conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer)
    RETURN string;

  FUNCTION int_2_hex( value, bitwidth : INTEGER )
    RETURN STRING;

  FUNCTION bin_2_hex_string(bin: string)
    RETURN string;

  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer )
    RETURN std_logic_vector;


END iputils_conv;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


PACKAGE BODY iputils_conv IS

	--This function included to support other functions in this package
	FUNCTION rat( value : std_logic )
		RETURN std_logic IS

	BEGIN

		CASE value IS
			WHEN '0' | '1' => RETURN value;
			WHEN 'H'       => RETURN '1';
			WHEN 'L'       => RETURN '0';
			WHEN OTHERS    => RETURN 'X';
		END CASE;

	END rat;

  ----------------------------------------------------------------------------
  -- This function converts a a standard logic vector to a string.
  ----------------------------------------------------------------------------
  FUNCTION std_logic_vector_2_string(v : STD_LOGIC_VECTOR) RETURN STRING IS
    VARIABLE str                       : STRING(1 TO v'high+1);
    CONSTANT ss                        : STRING(1 TO 3) := "01X";
  BEGIN
    FOR i IN v'high DOWNTO v'low LOOP
      IF (v(i) = '0') THEN
        str(v'high-i+1)                                 := ss(1);
      ELSIF (v(i) = '1') THEN
        str(v'high-i+1)                                 := ss(2);
      ELSE
        str(v'high-i+1)                                 := ss(3);
      END IF;
    END LOOP;
    RETURN str;
  END std_logic_vector_2_string;

  ----------------------------------------------------------------------------
  -- This function converts a standard logic signal to a string.
  ----------------------------------------------------------------------------
  FUNCTION std_logic_2_string(v : STD_LOGIC) RETURN STRING IS
    VARIABLE str                : STRING(1 TO 2) := "  ";
    CONSTANT ss                 : STRING(1 TO 3) := "01X";
  BEGIN
    IF (v = '0') THEN
      str(2)                                     := ss(1);
    ELSIF (v = '1') THEN
      str(2)                                     := ss(2);
    ELSE
      str(2)                                     := ss(3);
    END IF;
    RETURN str;
  END std_logic_2_string;



	FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
		RETURN integer IS

		VARIABLE local_vect : std_logic_vector(vect'high DOWNTO 0);
		VARIABLE result     : integer := 0;

	BEGIN

		IF (rat(vect(vect'high)) = '1') THEN  -- negative number
			local_vect := two_comp(vect);
		ELSE
			local_vect := vect;
		END IF;

		FOR i IN vect'high DOWNTO 0 LOOP
			result   := result * 2;
			IF (rat(local_vect(i)) = '1') THEN
				result := result + 1;
			ELSIF (rat(local_vect(i)) /= '0') THEN
				ASSERT false
				REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_int"
				SEVERITY warning;
			END IF;
		END LOOP;

		IF (rat(vect(vect'high)) = '1') THEN
			result := -1 * result;
		END IF;

		RETURN result;

	END std_logic_vector_2_int;

	FUNCTION two_comp(vect : std_logic_vector)
		RETURN std_logic_vector IS

		VARIABLE local_vect : std_logic_vector(vect'high DOWNTO 0);
		VARIABLE toggle     : integer := 0;

	BEGIN

		FOR i IN 0 TO vect'high LOOP
			IF (toggle = 1) THEN
				IF (vect(i) = '0') THEN
					local_vect(i) := '1';
				ELSE
					local_vect(i) := '0';
				END IF;
			ELSE
				local_vect(i)   := vect(i);
				IF (vect(i) = '1') THEN
					toggle        := 1;
				END IF;
			END IF;
		END LOOP;

		RETURN local_vect;

	END two_comp;

	FUNCTION int_2_std_logic_vector( value, bitwidth : integer )
		RETURN std_logic_vector IS

		VARIABLE running_value  : integer := value;
		VARIABLE running_result : std_logic_vector(bitwidth-1 DOWNTO 0);

	BEGIN

		IF (value < 0) THEN
			running_value := -1 * value;
		END IF;

		FOR i IN 0 TO bitwidth-1 LOOP

			IF running_value MOD 2 = 0 THEN
				running_result(i) := '0';
			ELSE
				running_result(i) := '1';
			END IF;
			running_value       := running_value/2;
		END LOOP;

		IF (value < 0) THEN                 -- find the 2s complement
			RETURN two_comp(running_result);
		ELSE
			RETURN running_result;
		END IF;

	END int_2_std_logic_vector;

	FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
		RETURN integer IS

		VARIABLE result : integer := 0;

	BEGIN

		FOR i IN vect'high DOWNTO vect'low LOOP
			result   := result * 2;
			IF (rat(vect(i)) = '1') THEN
				result := result + 1;
			ELSIF (rat(vect(i)) /= '0') THEN
				ASSERT false
				REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_posint"
				SEVERITY warning;
			END IF;
		END LOOP;

		RETURN result;

	END std_logic_vector_2_posint;


  -----------------------------------------------------------------------------
  -- int_2_boolean:
  -- Converts an integer to a boolean value.
  --  This function assumes 1=true, otherwise false.
  -----------------------------------------------------------------------------
  FUNCTION int_2_boolean(int: integer)
    RETURN BOOLEAN IS
    VARIABLE bool : boolean := false;
    BEGIN
      IF (int = 1) THEN
        bool := TRUE;
      END IF;
      RETURN TRUE;--bool;
    END int_2_boolean;


  -----------------------------------------------------------------------------
  -- int_2_string:
  --  Converts an integer to a string of the desired string length.
  -----------------------------------------------------------------------------
  FUNCTION int_2_string(val : integer;str_length :integer)
    RETURN string IS

    VARIABLE digit : INTEGER;
    VARIABLE value : integer := val;
    VARIABLE length : INTEGER := 0;
    VARIABLE posn : INTEGER;
    CONSTANT str : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value : string(1 to str_length);

  BEGIN

    ASSERT (val >= 0)
    REPORT "Function iputils_conv.int_2_string must receive a positive integer."
    SEVERITY ERROR;
    ASSERT (str_length >= 1)
    REPORT "Function iputils_conv.int_2_string was given an invalid str_length."
    SEVERITY ERROR;
    ASSERT (10**str_length >= val)
    REPORT "Function iputils_conv.int_2_string has too small of str_length to display value."
    SEVERITY ERROR;

      FOR i IN 1 TO str_length LOOP
        ret_value(i) := str(1);
      END LOOP;  -- i

      posn := str_length;
      WHILE (value /= 0) LOOP
	digit := value MOD 10;
  	ret_value(posn) := str(digit+1);  --right here
 	value := value/10;
 	posn := posn - 1;
      END LOOP;


    RETURN ret_value;

  END int_2_string;



  -----------------------------------------------------------------------------
  -- bint_2_sl:
  --  Converts a binary integer (0 or 1) to a std_logic binary value.
  --
  --  Formula:  std_logic='0' when integer=0, else std_logic='1'
  -----------------------------------------------------------------------------

  FUNCTION bint_2_sl (X : integer) RETURN std_logic IS
  BEGIN
    IF (X = 0) THEN
      RETURN '0';
    ELSE
      RETURN '1';
    END IF;
  END bint_2_sl;


  -----------------------------------------------------------------------------
  -- str_to_slv_0:
  --
  -- Converts a string containing 1's and 0's into a std_logic_vector of
  --  width nbits.
  -----------------------------------------------------------------------------

  FUNCTION str_to_slv_0(bitsin : string; nbits : integer) RETURN std_logic_vector is
		variable ret : std_logic_vector(bitsin'range);
		-- String types range from 1 to len!!!
		variable ret0s : std_logic_vector(1 to nbits) := (others => '0');
		variable retpadded : std_logic_vector(1 to nbits) := (others => '0');
		variable offset : integer := 0;
   begin
   		if(bitsin = "") then -- Make all '0's
			return ret0s;
		end if;
		if(bitsin'length < nbits) then -- pad MSBs with '0's
			offset := nbits - bitsin'length;
	   		for i in bitsin'range loop
				if bitsin(i) = '1' then
					retpadded(i+offset) := '1';
				elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
					retpadded(i+offset) := 'X';
				elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
					retpadded(i+offset) := 'Z';
				elsif (bitsin(i) = '0') then
					retpadded(i+offset) := '0';
				end if;
			end loop;
			retpadded(1 to offset) := (others => '0');
			return retpadded;
		end if;
   		for i in bitsin'range loop
			if bitsin(i) = '1' then
				ret(i) := '1';
			elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
				ret(i) := 'X';
			elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
				ret(i) := 'Z';
			elsif (bitsin(i) = '0') then
				ret(i) := '0';
			end if;
		end loop;

		return ret;
	end str_to_slv_0;


 -------------------------------------------------------------------------------
-- number_of_bits
-------------------------------------------------------------------------------
-- Purpose:
-- Calculates the number of bits needed to represent the specified value
-- Algorithm:
-- ????
-- Parameters:
-- data_value : input number
-- return : number of bits needed
-------------------------------------------------------------------------------
  FUNCTION number_of_bits (data_value : integer)
    RETURN integer IS

    VARIABLE dwidth : integer := 0;

  BEGIN
    WHILE 2**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;

    RETURN dwidth;
  END number_of_bits;



-------------------------------------------------------------------------------
-- number_of_digits
-------------------------------------------------------------------------------
-- Purpose:
-- Calculates the number of bits needed to represent the specified value
-- Algorithm:
-- ????
-- Parameters:
-- data_value : input number
-- return : number of bits needed
-------------------------------------------------------------------------------
  FUNCTION number_of_digits (data_value : integer; radix : integer)
    RETURN integer IS

    VARIABLE dwidth : integer := 0;

  BEGIN
    WHILE radix**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;

    RETURN dwidth;
  END number_of_digits;


-------------------------------------------------------------------------------
-- conv_int_to_new_radix
-------------------------------------------------------------------------------
-- Purpose:
-- Converts an integer to a string of the specified radix (2 to 16)
-- Algorithm:
-- Based on the destination string size, or the input number, the function
-- determines the largest possible exponent to attempt.
-- It then loops downward, determining the coefficient for each exponent value
-- and subtracting the value from the remaining value.
-- Parameters:
-- number : the integer value to convert
-- target_str_len : the number of terms in the target string
-- target_radix : the desired radix of the output string
-- return : string formatted number in the desired radix (padded with 0's)
-------------------------------------------------------------------------------
  FUNCTION conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer) RETURN string IS

    VARIABLE return_string   : string(1 TO target_str_len) := (OTHERS => '0');
    VARIABLE string_location : integer                     := 0;
    VARIABLE tmp_string_val  : integer                     := 0;
    VARIABLE new_number      : integer                     := number;
    VARIABLE hexdigits       : string(1 TO 16)             := "0123456789ABCDEF";
    VARIABLE max_exp         : integer                     := 0;
  BEGIN
    max_exp                                                := number_of_digits(number, target_radix);
    IF target_str_len < max_exp THEN
      max_exp                                              := target_str_len;
    END IF;

    new_number := number;

    FOR exp IN max_exp-1 DOWNTO 0 LOOP
      string_location := target_str_len-exp;

      tmp_string_val := new_number/(target_radix**exp);

      new_number := new_number - tmp_string_val*(target_radix**exp);

      return_string(string_location) := hexdigits(tmp_string_val+1);

    END LOOP;

    RETURN return_string;

  END conv_int_to_new_radix;

-------------------------------------------------------------------------------
-- int_2_hex
--   Converts an integer to a hexidecimal string value
-------------------------------------------------------------------------------
  FUNCTION int_2_hex( value, bitwidth : INTEGER )
    RETURN STRING IS

    VARIABLE hexdigits	    : STRING(1 TO 16) := "0123456789ABCDEF";
    VARIABLE running_value  : INTEGER	      := value;
    VARIABLE digit_value    : INTEGER	      := 0;
    VARIABLE digit_position : INTEGER	      := 1;
    VARIABLE results_string : STRING(1 TO bitwidth/4);

  BEGIN

    FOR i IN bitwidth-1 DOWNTO 0 LOOP

      IF (2**i) <= running_value THEN
	running_value := running_value - (2**i);
	digit_value := digit_value + (2**(i mod 4));
      END IF;

      IF i MOD 4 = 0 THEN
	results_string(digit_position) := hexdigits(1+digit_value);
	digit_value := 0;
	digit_position := digit_position + 1;
      END IF;

    END LOOP;

    RETURN results_string;

  END int_2_hex;


	-----------------------------------------------------------------------------
	-- FUNCTION : div4roundup_v2
	-- Returns the ceiling value of the division by 4
        --  This version of this function is only for use by the
        --  bin_2_hex_string function.  Users should use
        --  div4roundup from iputils_math.
	-----------------------------------------------------------------------------
	FUNCTION div4roundup_v2 (data_value : integer)
		RETURN integer IS
		VARIABLE div                   : integer;
	BEGIN
		div   := data_value/4;
		IF ( (data_value MOD 4) /= 0) THEN
			div := div+1;
		END IF;
		RETURN div;
	END div4roundup_v2;


  ------------------------------------------------------------------------------
  -- bin_2_hex_string
  -- This function converts a standard logic vector to a string.
  ------------------------------------------------------------------------------
  function bin_2_hex_string(bin: string) return string is
    variable hex_len : integer := div4roundup_v2(bin'high);
    variable bin_ext : string(1 to hex_len*4);
    variable hex: string(1 to hex_len);
    variable sub_bin : string (1 to 4);
  begin

    -- extend binary string to a multiple of 4
    for j in 1 to hex_len*4 loop
      if (j <= hex_len*4-bin'high) then
        bin_ext(j) := '0';
      else
        bin_ext(j) := bin(j-(hex_len*4-bin'high));
      end if;
    end loop;

    for i in 0 to hex_len-1 loop
      sub_bin := bin_ext(i*4+1 to i*4+4);
      case sub_bin is
        when "0000" => hex(i+1) := '0';
        when "0001" => hex(i+1) := '1';
        when "0010" => hex(i+1) := '2';
        when "0011" => hex(i+1) := '3';
        when "0100" => hex(i+1) := '4';
        when "0101" => hex(i+1) := '5';
        when "0110" => hex(i+1) := '6';
        when "0111" => hex(i+1) := '7';
        when "1000" => hex(i+1) := '8';
        when "1001" => hex(i+1) := '9';
        when "1010" => hex(i+1) := 'a';
        when "1011" => hex(i+1) := 'b';
        when "1100" => hex(i+1) := 'c';
        when "1101" => hex(i+1) := 'd';
        when "1110" => hex(i+1) := 'e';
        when others => hex(i+1) := 'f';
      end case;
    end loop;

    return hex;

  end bin_2_hex_string;


-------------------------------------------------------------------------------
-- hexstr_to_std_logic_vec
--  This function converts a hex string to a std_logic_vector
-------------------------------------------------------------------------------
  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer ) RETURN std_logic_vector IS
    VARIABLE RESULT                      : std_logic_vector(size-1 DOWNTO 0)                   := (OTHERS => '0');
    VARIABLE BIN                         : std_logic_vector(3 DOWNTO 0);
    VARIABLE INDEX                       : integer                                             := 0;
  BEGIN
    FOR i IN arg1'reverse_range LOOP
      CASE arg1(i) IS
        WHEN '0'                                                                        => BIN := (OTHERS => '0');
        WHEN '1'                                                                        => BIN := (0 => '1', OTHERS => '0');
        WHEN '2'                                                                        => BIN := (1 => '1', OTHERS => '0');
        WHEN '3'                                                                        => BIN := (0 => '1', 1 => '1', OTHERS => '0');
        WHEN '4'                                                                        => BIN := (2 => '1', OTHERS => '0');
        WHEN '5'                                                                        => BIN := (0 => '1', 2 => '1', OTHERS => '0');
        WHEN '6'                                                                        => BIN := (1 => '1', 2 => '1', OTHERS => '0');
        WHEN '7'                                                                        => BIN := (3 => '0', OTHERS => '1');
        WHEN '8'                                                                        => BIN := (3 => '1', OTHERS => '0');
        WHEN '9'                                                                        => BIN := (0 => '1', 3 => '1', OTHERS => '0');
        WHEN 'A'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'a'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'B'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'b'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'C'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'c'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'D'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'd'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'E'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'e'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'F'                                                                        => BIN := (OTHERS => '1');
        WHEN 'f'                                                                        => BIN := (OTHERS => '1');
        WHEN OTHERS                                                                     =>
          --ASSERT false
          --  REPORT "NOT A HEX CHARACTER" SEVERITY error;
          FOR j IN 0 TO 3 LOOP
            BIN(j)                                                                             := 'X';
          END LOOP;
      END CASE;
      FOR j IN 0 TO 3 LOOP
        IF (INDEX*4)+j < size THEN
          RESULT((INDEX*4)+j)                                                                  := BIN(j);
        END IF;
      END LOOP;
      INDEX                                                                                    := INDEX + 1;
    END LOOP;
    RETURN RESULT;
  END hexstr_to_std_logic_vec;


END iputils_conv;


-- ##   ##  #####   #####    ####
--  #   #     #    #     #  #    #
--  ## ##     #    #       #
--  ## ##     #    #       #
--  # # #     #     #####  #
--  # # #     #          # #
--  #   #     #          # #
--  #   #     #    #     #  #    #
-- ### ###  #####   #####    ####

-------------------------------------------------------------------------------
-- $Id: xilinx_sim_src.vhd 111 2006-06-29 22:33:33Z hchen05 $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Miscellaneous Functions
--
--
-------------------------------------------------------------------------------
--
-- This file is owned and controlled by Xilinx and must be used solely
-- for design, simulation, implementation and creation of design files
-- limited to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and immediately
-- terminates your license.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
--            **************************************
--            ** Copyright (C) 2000, Xilinx, Inc. **
--            ** All Rights Reserved.             **
--            **************************************
--
-------------------------------------------------------------------------------
--
-- This file contains the following package:
--   iputils_misc - miscellaneous functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- iputils_misc
----   Miscellaneous utility functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_misc IS

	FUNCTION if_then_else (condition : integer; true_case : integer; false_case : integer)
	RETURN integer;

	FUNCTION if_then_else (condition : boolean; true_case : integer; false_case : integer)
	RETURN integer;

 FUNCTION index_in_str(stringtosearch : string; stringsize : integer; char : string; instnum : integer) RETURN integer;

  FUNCTION cond_string (condition : boolean; true_string : string; false_string : string) RETURN string;

FUNCTION get_lesser (a: INTEGER; b: INTEGER)
RETURN INTEGER;

FUNCTION get_greater (a: INTEGER; b: INTEGER)
RETURN INTEGER;

FUNCTION  zero_string (length: INTEGER)
RETURN STRING;

FUNCTION  ones_string (length: INTEGER)
RETURN STRING;

  FUNCTION lcase(instring : string)
    RETURN string;

  FUNCTION ucase(instring : string)
    RETURN string;

  FUNCTION case_sensitive_compare(a, b : string)
    RETURN boolean;

  FUNCTION case_insensitive_compare(a, b : string)
    RETURN boolean;

  FUNCTION strbool_to_int(boolean_string : string)
    RETURN integer;


END iputils_misc;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
PACKAGE BODY iputils_misc IS

-------------------------------------------------------------------------------
-- This function is used to implement an IF..THEN when such a statement is not
--  allowed.  It considers all non-zero integers as TRUE.
-------------------------------------------------------------------------------
FUNCTION if_then_else (condition : integer; true_case : integer; false_case : integer) RETURN integer IS
VARIABLE retval : integer := 0;
BEGIN
  IF condition=0 THEN
    retval:=false_case;
  ELSE
    retval:=true_case;
  END IF;
  RETURN retval;
END if_then_else;


-------------------------------------------------------------------------------
-- This function is used to implement an IF..THEN when such a statement is not
--  allowed.
-------------------------------------------------------------------------------
FUNCTION if_then_else (condition : boolean; true_case : integer; false_case : integer) RETURN integer IS
VARIABLE retval : integer := 0;
BEGIN
  IF NOT condition THEN
    retval:=false_case;
  ELSE
    retval:=true_case;
  END IF;
  RETURN retval;
END if_then_else;


-------------------------------------------------------------------------------
-- index_in_str:
-- Returns the index of a specified instance of a specified character in another string
-- Example: What is the index of the third "l" in "Hello World"? =10
--
-- Inputs:
-- string of characters of any length
-- length of string (number of characters)
-- character to search for
-- number of instance to locate
-- Outputs:
-- integer index value 1 to stringsize, if char exists. Returns 0 if the char
-- was not found.
-------------------------------------------------------------------------------
  FUNCTION index_in_str(stringtosearch : string; stringsize : integer; char : string; instnum : integer) RETURN integer IS

    VARIABLE instfound    : integer := 0;
    VARIABLE foundatindex : integer := 0;
  BEGIN
    FOR i IN 1 TO stringsize LOOP
      IF stringtosearch(i) = char(1) THEN
        instfound                   := instfound + 1;

        IF instfound = instnum THEN
          foundatindex := i;
        END IF;
      END IF;
    END LOOP;  -- i

    RETURN foundatindex;
  END index_in_str;

  -----------------------------------------------------------------------------
  -- cond_string:
  --  Conditional string selection.  If condition is TRUE, then the string
  --  passed-in as true_string is returned, otherwise, the false_string
  --  string value is returned.
  -----------------------------------------------------------------------------
  FUNCTION cond_string (condition : boolean; true_string : string; false_string : string) RETURN string IS
  BEGIN
    IF condition THEN
      RETURN true_string;
    ELSE
      RETURN false_string;
    END IF;
  END cond_string;



-- ---------------------------------------------------
-- FUNCTION : get_lesser
--  Returns the smaller of two integers.
-- ---------------------------------------------------
FUNCTION get_lesser (a: INTEGER; b: INTEGER)
	RETURN INTEGER IS
	VARIABLE smallest : INTEGER := 1;

	BEGIN
		IF (a < b) THEN
          		smallest := a;
          	ELSE
          		smallest := b;
          	END IF;
	RETURN smallest;
END get_lesser;


--------------------------------------------------------
---  FUNCION : get_greater           -------------------
--  Returns the larger of two integers.
--------------------------------------------------------

FUNCTION get_greater(a: INTEGER; b: INTEGER) RETURN INTEGER IS
       VARIABLE largest : INTEGER;
       BEGIN
               IF (a > b) THEN
                       largest := a;
               ELSE
                       largest := b;
               END IF;
       RETURN largest;
END get_greater;

--------------------------------------------------------
---  zero_string
--  Creates a string of 0's of the specified length
--------------------------------------------------------

FUNCTION zero_string (length: INTEGER) RETURN STRING IS
       VARIABLE zeros : string(1 TO length);
       BEGIN
               FOR i IN 1 TO length LOOP
                       zeros(i) := '0';
               end LOOP;
       RETURN zeros;
END zero_string;

--------------------------------------------------------
---  ones_string
--  Creates a string of 1's of the specified length
--------------------------------------------------------

FUNCTION ones_string (length: INTEGER) RETURN STRING IS
       VARIABLE ones : string(1 TO length);
       BEGIN
               FOR i IN 1 TO length LOOP
                       ones(i) := '1';
               end LOOP;
       RETURN ones;
END ones_string;


-------------------------------------------------------------------------------
-- lcase
--   Converts a string to all lowercase.
-------------------------------------------------------------------------------
  FUNCTION lcase(instring : string) RETURN string IS
    VARIABLE retstring : string (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'A' => retstring(i) := 'a';
        WHEN 'B' => retstring(i) := 'b';
        WHEN 'C' => retstring(i) := 'c';
        WHEN 'D' => retstring(i) := 'd';
        WHEN 'E' => retstring(i) := 'e';
        WHEN 'F' => retstring(i) := 'f';
        WHEN 'G' => retstring(i) := 'g';
        WHEN 'H' => retstring(i) := 'h';
        WHEN 'I' => retstring(i) := 'i';
        WHEN 'J' => retstring(i) := 'j';
        WHEN 'K' => retstring(i) := 'k';
        WHEN 'L' => retstring(i) := 'l';
        WHEN 'M' => retstring(i) := 'm';
        WHEN 'N' => retstring(i) := 'n';
        WHEN 'O' => retstring(i) := 'o';
        WHEN 'P' => retstring(i) := 'p';
        WHEN 'Q' => retstring(i) := 'q';
        WHEN 'R' => retstring(i) := 'r';
        WHEN 'S' => retstring(i) := 's';
        WHEN 'T' => retstring(i) := 't';
        WHEN 'U' => retstring(i) := 'u';
        WHEN 'V' => retstring(i) := 'v';
        WHEN 'W' => retstring(i) := 'w';
        WHEN 'X' => retstring(i) := 'x';
        WHEN 'Y' => retstring(i) := 'y';
        WHEN 'Z' => retstring(i) := 'z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END lcase;


-------------------------------------------------------------------------------
-- ucase
--   Converts a string to all uppercase.
-------------------------------------------------------------------------------
  FUNCTION ucase(instring : string) RETURN string IS
    VARIABLE retstring : string (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'a' => retstring(i) := 'A';
        WHEN 'b' => retstring(i) := 'B';
        WHEN 'c' => retstring(i) := 'C';
        WHEN 'd' => retstring(i) := 'D';
        WHEN 'e' => retstring(i) := 'E';
        WHEN 'f' => retstring(i) := 'F';
        WHEN 'g' => retstring(i) := 'G';
        WHEN 'h' => retstring(i) := 'H';
        WHEN 'i' => retstring(i) := 'I';
        WHEN 'j' => retstring(i) := 'J';
        WHEN 'k' => retstring(i) := 'K';
        WHEN 'l' => retstring(i) := 'L';
        WHEN 'm' => retstring(i) := 'M';
        WHEN 'n' => retstring(i) := 'N';
        WHEN 'o' => retstring(i) := 'O';
        WHEN 'p' => retstring(i) := 'P';
        WHEN 'q' => retstring(i) := 'Q';
        WHEN 'r' => retstring(i) := 'R';
        WHEN 's' => retstring(i) := 'S';
        WHEN 't' => retstring(i) := 'T';
        WHEN 'u' => retstring(i) := 'U';
        WHEN 'v' => retstring(i) := 'V';
        WHEN 'w' => retstring(i) := 'W';
        WHEN 'x' => retstring(i) := 'X';
        WHEN 'y' => retstring(i) := 'Y';
        WHEN 'z' => retstring(i) := 'Z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END ucase;


-------------------------------------------------------------------------------
-- case_sensitive_compare
--      Compares two strings for equality, case dependent
-------------------------------------------------------------------------------
  FUNCTION case_sensitive_compare(a, b : string) RETURN boolean IS
    VARIABLE retval : boolean := true;
  BEGIN
    --If strings are not the same length can they not be considered equivalent
    IF NOT(a'length = b'length) THEN
      retval := false;
    ELSE
      --if strings are the same length
      --compare each character
      FOR i IN a'low TO a'high LOOP
        --if a character doesn't match, return false
        IF a(i)/=b(i) THEN
          retval:=false;
        END IF;
      END LOOP;  -- i
    END IF;

    RETURN retval;
  END case_sensitive_compare;


-------------------------------------------------------------------------------
-- case_insensitive_compare
--      Compares two strings for equality, ignoring case differences.
-------------------------------------------------------------------------------
  FUNCTION case_insensitive_compare(a, b : string) RETURN boolean IS
  BEGIN

    RETURN case_sensitive_compare(ucase(a), ucase(b));

  END case_insensitive_compare;


-------------------------------------------------------------------------------
-- strbool_to_int
--      Converts a boolean string to an integer (0 or 1).
-------------------------------------------------------------------------------
  FUNCTION strbool_to_int(boolean_string : string) RETURN integer IS
  BEGIN
    IF case_insensitive_compare(boolean_string, "TRUE") THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END strbool_to_int;



END iputils_misc;


-- ####### #####     ####  #######
--  #    #  #   #   #    #  #    #
--  #       #    # #        #
--  #  #    #    # #        #  #
--  ####    #    # #        ####
--  #  #    #    # #        #  #
--  #       #    # #        #
--  #       #   #   #    #  #    #
-- ####    #####     ####  #######

-- $Header$
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 8.1i
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  D Flip-Flop with Asynchronous Clear and Clock Enable
-- /___/   /\     Filename : FDCE.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:55:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL FDCE -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FDCE is
  generic(
    INIT : bit := '0'
    );

  port(
    Q : out std_ulogic;

    C   : in std_ulogic;
    CE  : in std_ulogic;
    CLR : in std_ulogic;
    D   : in std_ulogic
    );
end FDCE;

architecture FDCE_V of FDCE is
begin
  VITALBehavior         : process(C, CLR)
    variable FIRST_TIME : boolean := true ;
  begin

    if (FIRST_TIME = true) then
      Q <= TO_X01(INIT);
      FIRST_TIME := false;
    end if;

    if (CLR = '1') then
      Q   <= '0';
    elsif (rising_edge(C)) then
      if (CE = '1') then
--        Q <= D after 100 ps;
        Q <= D after 100 ms;
      end if;
    end if;
  end process;
end FDCE_V;


-- $Header$
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 8.1i
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  D Flip-Flop with Asynchronous Clear, Clock Enable and Negative-Edge Clock
-- /___/   /\     Filename : FDCE_1.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:55:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL FDCE_1 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FDCE_1 is
  generic(
    INIT : bit := '0'
    );

  port(
    Q : out std_ulogic;

    C   : in std_ulogic;
    CE  : in std_ulogic;
    CLR : in std_ulogic;
    D   : in std_ulogic
    );
end FDCE_1;

architecture FDCE_1_V of FDCE_1 is
begin
  VITALBehavior         : process(C, CLR)
    variable FIRST_TIME : boolean := true ;
  begin

    if (FIRST_TIME = true) then
      Q <= TO_X01(INIT);
      FIRST_TIME := false;
    end if;

    if (CLR = '1') then
      Q   <= '0';
    elsif (falling_edge(C)) then
      if (CE = '1') then
--        Q <= D after 100 ps;
        Q <= D after 100 ms;
      end if;
    end if;
  end process;
end FDCE_1_V;


-- ######    ##    ##   ##    #       ##   ### ###    #    #####
--  #    #    #     #   #   ###      #      #   #   ###     #   #
--  #    #    #     ## ##     #     #        # #      #     #    #
--  #    #   # #    ## ##     #     #        # #      #     #    #
--  #####    # #    # # #     #     ####      #       #     #    #
--  #  #    #   #   # # #     #     #   #    # #      #     #    #
--  #  #    #####   #   #     #     #   #    # #      #     #    #
--  #   #   #   #   #   #     #     #   #   #   #     #     #   #
-- ###  ## ### ### ### ###  #####    ###   ### ###  #####  #####

library IEEE;
use IEEE.STD_LOGIC_1164.all;
package VCOMPONENTS is
attribute BOX_TYPE : string;

----- component RAM16X1D -----
component RAM16X1D
	generic
	(
		INIT : bit_vector(15 downto 0) := X"0000"
	);
	port
	(
		DPO : out std_ulogic;
		SPO : out std_ulogic;
		A0 : in std_ulogic;
		A1 : in std_ulogic;
		A2 : in std_ulogic;
		A3 : in std_ulogic;
		D : in std_ulogic;
		DPRA0 : in std_ulogic;
		DPRA1 : in std_ulogic;
		DPRA2 : in std_ulogic;
		DPRA3 : in std_ulogic;
		WCLK : in std_ulogic;
		WE : in std_ulogic
	);
end component;
attribute BOX_TYPE of
	RAM16X1D : component is "PRIMITIVE";

----- component RAM16X1D_1 -----
component RAM16X1D_1
	generic
	(
		INIT : bit_vector(15 downto 0) := X"0000"
	);
	port
	(
		DPO : out std_ulogic;
		SPO : out std_ulogic;
		A0 : in std_ulogic;
		A1 : in std_ulogic;
		A2 : in std_ulogic;
		A3 : in std_ulogic;
		D : in std_ulogic;
		DPRA0 : in std_ulogic;
		DPRA1 : in std_ulogic;
		DPRA2 : in std_ulogic;
		DPRA3 : in std_ulogic;
		WCLK : in std_ulogic;
		WE : in std_ulogic
	);
end component;
attribute BOX_TYPE of
	RAM16X1D_1 : component is "PRIMITIVE";

end VCOMPONENTS;

-- $Header$
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 8.1i
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  Static Dual Port Synchronous RAM 16-Deep by 1-Wide
-- /___/   /\     Filename : RAM16X1D.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:56:47 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL RAM16X1D -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library UNISIM;
use UNISIM.VPKG.all;

entity RAM16X1D is

  generic (
       INIT : bit_vector(15 downto 0) := X"0000"
  );

  port (
        DPO   : out std_ulogic;
        SPO   : out std_ulogic;

        A0    : in std_ulogic;
        A1    : in std_ulogic;
        A2    : in std_ulogic;
        A3    : in std_ulogic;
        D     : in std_ulogic;
        DPRA0 : in std_ulogic;
        DPRA1 : in std_ulogic;
        DPRA2 : in std_ulogic;
        DPRA3 : in std_ulogic;
        WCLK  : in std_ulogic;
        WE    : in std_ulogic
       );
end RAM16X1D;

architecture RAM16X1D_V of RAM16X1D is
  signal MEM       : std_logic_vector( 16 downto 0 ) := ('X' & To_StdLogicVector(INIT) );

begin
 VITALReadBehavior : process(A0, A1, A2, A3, DPRA3, DPRA2, DPRA1, DPRA0, MEM)
       Variable Index_SP   : integer  := 16 ;
       Variable Index_DP   : integer  := 16 ;

  begin
    Index_SP := DECODE_ADDR4(ADDRESS => (A3, A2, A1, A0));
    Index_DP := DECODE_ADDR4(ADDRESS => (DPRA3, DPRA2, DPRA1, DPRA0));
    SPO <= MEM(Index_SP);
    DPO <= MEM(Index_DP);

  end process VITALReadBehavior;

 VITALWriteBehavior : process(WCLK)
    variable Index_SP  : integer := 16;
    variable Index_DP  : integer := 16;
  begin
    Index_SP := DECODE_ADDR4(ADDRESS => (A3, A2, A1, A0));
    if ((WE = '1') and (wclk'event) and (wclk'last_value = '0') and (wclk = '1')) then
--      MEM(Index_SP) <= D after 100 ps;
      MEM(Index_SP) <= D after 100 ms;
    end if;
  end process VITALWriteBehavior;
end RAM16X1D_V;


-- $Header$
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 8.1i
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  Static Dual Port Synchronous RAM 16-Deep by 1-Wide
-- /___/   /\     Filename : RAM16X1D_1.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:56:47 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL RAM16X1D_1 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library UNISIM;
use UNISIM.VPKG.all;

entity RAM16X1D_1 is

  generic (
    INIT : bit_vector(15 downto 0) := X"0000"
    );

  port (
    DPO : out std_ulogic;
    SPO : out std_ulogic;

    A0    : in std_ulogic;
    A1    : in std_ulogic;
    A2    : in std_ulogic;
    A3    : in std_ulogic;
    D     : in std_ulogic;
    DPRA0 : in std_ulogic;
    DPRA1 : in std_ulogic;
    DPRA2 : in std_ulogic;
    DPRA3 : in std_ulogic;
    WCLK  : in std_ulogic;
    WE    : in std_ulogic
    );
end RAM16X1D_1;

architecture RAM16X1D_1_V of RAM16X1D_1 is
  signal MEM : std_logic_vector( 16 downto 0 ) := ('X' & To_StdLogicVector(INIT) );

begin
  VITALReadBehavior   : process(A0, A1, A2, A3, DPRA3, DPRA2, DPRA1, DPRA0, MEM)
    variable Index_SP : integer := 16;
    variable Index_DP : integer := 16;

  begin
    Index_SP := DECODE_ADDR4(ADDRESS => (A3, A2, A1, A0));
    Index_DP := DECODE_ADDR4(ADDRESS => (DPRA3, DPRA2, DPRA1, DPRA0));
    SPO <= MEM(Index_SP);
    DPO <= MEM(Index_DP);
  end process VITALReadBehavior;

  VITALWriteBehavior  : process(WCLK)
    variable Index_SP : integer := 16;
    variable Index_DP : integer := 16;
  begin
    Index_SP                    := DECODE_ADDR4(ADDRESS => (A3, A2, A1, A0));
    if ((WE = '1') and (wclk'event) and (wclk'last_value = '1') and (wclk = '0')) then
--      MEM(Index_SP) <= D after 100 ps;
      MEM(Index_SP) <= D after 100 ms;
    end if;

  end process VITALWriteBehavior;
end RAM16X1D_1_V;


-- #######  #####  #######   ###             ####  ####### ##  ###
--  #    #    #     #    #  #   #           #    #  #    #  #   #
--  #         #     #      #     #         #        #       ##  #
--  #  #      #     #  #   #     #         #        #  #    ##  #
--  ####      #     ####   #     #         #        ####    # # #
--  #  #      #     #  #   #     #         #   ###  #  #    #  ##
--  #         #     #      #     #         #     #  #       #  ##
--  #         #     #       #   #           #    #  #    #  #   #
-- ####     #####  ####      ###             ####  ####### ###  #
--
--                                #########

-------------------------------------------------------------------------------
-- $RCSfile$ $Revision: 111 $ $Date: 2006-06-29 15:33:33 -0700 (Thu, 29 Jun 2006) $
-------------------------------------------------------------------------------
--
-- FIFO Generator v2.1 - VHDL Behavioral Model
--
-------------------------------------------------------------------------------
--
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under
-- license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid
-- license agreement with Xilinx, Inc. Xilinx hereby
-- grants you a license to use this text/file solely for
-- design, simulation, implementation and creation of
-- design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly
-- prohibited and immediately terminates your license unless
-- covered by a separate agreement.
--
-- Xilinx is providing theis design, code, or information
-- "as-is" solely for use in developing programs and
-- solutions for Xilinx devices, with no obligation on the
-- part of Xilinx to provide support. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard. Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for obtaining
-- any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c)Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
-----------------------------------------------------------------------------
--
-- Filename: fifo_generator_v2_2_bhv.vhd
--
-- Description:
--  The behavioral model for the FIFO Generator.
--
-------------------------------------------------------------------------------




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Asynchronous FIFO Behavioral Model
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;
-- USE IEEE.std_logic_arith.ALL;

LIBRARY work;
USE work.iputils_std_logic_unsigned.ALL;
USE work.iputils_std_logic_arith.ALL;
USE work.iputils_conv.ALL;
USE work.iputils_misc.ALL;

-------------------------------------------------------------------------------
-- Entity Declaration
-------------------------------------------------------------------------------
ENTITY fifo_generator_v2_2_bhv_as IS

  GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations
    --------------------------------------------------------------------------------
    C_DIN_WIDTH                    :    integer := 8;
    C_DOUT_RST_VAL                 :    string  := "";
    C_DOUT_WIDTH                   :    integer := 8;
    C_ENABLE_RLOCS                 :    integer := 0;
    C_FAMILY                       :    string  := "";
    C_HAS_ALMOST_FULL              :    integer := 0;
    C_HAS_ALMOST_EMPTY             :    integer := 0;
    C_HAS_OVERFLOW                 :    integer := 0;
    C_HAS_RD_DATA_COUNT            :    integer := 2;
    C_HAS_VALID                    :    integer := 0;
    C_HAS_RST                      :    integer := 1;
    C_HAS_UNDERFLOW                :    integer := 0;
    C_HAS_WR_ACK                   :    integer := 0;
    C_HAS_WR_DATA_COUNT            :    integer := 2;
    C_MEMORY_TYPE                  :    integer := 1;
    C_OPTIMIZATION_MODE            :    integer := 0;
    C_WR_RESPONSE_LATENCY          :    integer := 1;
    C_OVERFLOW_LOW                 :    integer := 0;
    C_PRELOAD_REGS                 :    integer := 0;
    C_PRELOAD_LATENCY              :    integer := 1;
    C_PRIM_FIFO_TYPE               :    integer := 512;
    C_PROG_EMPTY_TYPE              :    integer := 0;
    C_PROG_EMPTY_THRESH_ASSERT_VAL :    integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL :    integer := 0;
    C_PROG_FULL_TYPE               :    integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  :    integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  :    integer := 0;
    C_VALID_LOW                    :    integer := 0;
    C_RD_DATA_COUNT_WIDTH          :    integer := 0;
    C_RD_DEPTH                     :    integer := 256;
    C_RD_PNTR_WIDTH                :    integer := 8;
    C_UNDERFLOW_LOW                :    integer := 0;
    C_WR_ACK_LOW                   :    integer := 0;
    C_WR_DATA_COUNT_WIDTH          :    integer := 0;
    C_WR_DEPTH                     :    integer := 256;
    C_WR_PNTR_WIDTH                :    integer := 8
    );
  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    DIN                            : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH              : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_ASSERT       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_NEGATE       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH               : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_ASSERT        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_NEGATE        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    RD_CLK                         : IN std_logic;
    RD_EN                          : IN std_logic;
    RST                            : IN std_logic;
    WR_CLK                         : IN std_logic;
    WR_EN                          : IN std_logic;

    ALMOST_EMPTY  : OUT std_logic := '1';
    ALMOST_FULL   : OUT std_logic := '1';
    DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY         : OUT std_logic := '1';
    FULL          : OUT std_logic := '1';
    OVERFLOW      : OUT std_logic := '0';
    PROG_EMPTY    : OUT std_logic := '1';
    PROG_FULL     : OUT std_logic := '1';
    VALID         : OUT std_logic := '0';
    RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                    (OTHERS => '0');
    UNDERFLOW     : OUT std_logic := '0';
    WR_ACK        : OUT std_logic := '0';
    WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                    (OTHERS => '0')
    );



END fifo_generator_v2_2_bhv_as;

-------------------------------------------------------------------------------
-- Definition of Ports
-- DIN : Input data bus for the fifo.
-- DOUT : Output data bus for the fifo.
-- AINIT : Asynchronous Reset for the fifo.
-- WR_EN : Write enable signal.
-- WR_CLK : Write Clock.
-- FULL : Full signal.
-- ALMOST_FULL : One space left.
-- WR_ACK : Last write acknowledged.
-- WR_ERR : Last write rejected.
-- WR_COUNT : Number of data words in fifo(synchronous to WR_CLK)
-- Rd_EN : Read enable signal.
-- RD_CLK : Read Clock.
-- EMPTY : Empty signal.
-- ALMOST_EMPTY: One sapce left
-- VALID : Last read acknowledged.
-- RD_ERR : Last read rejected.
-- RD_COUNT : Number of data words in fifo(synchronous to RD_CLK)
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF fifo_generator_v2_2_bhv_as IS



-------------------------------------------------------------------------------
-- FUNCTION actual_fifo_depth
--
-- Returns the actual depth of the FIFO (may differ from what the user specified)
--
-- The FIFO depth is always represented as 2^n (16,32,64,128,256)
-- However, the ACTUAL fifo depth may be 2^n or (2^n - 1) depending on certain
-- options. This function returns the ACTUAL depth of the fifo, as seen by
-- the user.
--
-- The FIFO depth remains as 2^n when any of the following conditions are true:
-- *C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=1 (preload output register adds 1
-- word of depth to the FIFO)
-------------------------------------------------------------------------------
  FUNCTION actual_fifo_depth(c_fifo_depth : integer; C_PRELOAD_REGS : integer; C_PRELOAD_LATENCY : integer) RETURN integer IS
  BEGIN
    IF (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 1) THEN
      RETURN c_fifo_depth;
    ELSIF (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 0) THEN
      RETURN c_fifo_depth-1;
    ELSE
      RETURN c_fifo_depth-1;
    END IF;
  END actual_fifo_depth;

-------------------------------------------------------------------------------
-- Derived Constants
-------------------------------------------------------------------------------
  CONSTANT C_FULL_RESET_VAL        : std_logic := '1';
  CONSTANT C_ALMOST_FULL_RESET_VAL : std_logic := '1';
  CONSTANT C_PROG_FULL_RESET_VAL   : std_logic := '1';

  CONSTANT C_FIFO_WR_DEPTH : integer := actual_fifo_depth(C_WR_DEPTH, C_PRELOAD_REGS, C_PRELOAD_LATENCY);
  CONSTANT C_FIFO_RD_DEPTH : integer := actual_fifo_depth(C_RD_DEPTH, C_PRELOAD_REGS, C_PRELOAD_LATENCY);

  CONSTANT C_SMALLER_PNTR_WIDTH : integer := get_lesser(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_SMALLER_DEPTH      : integer := get_lesser(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_SMALLER_DATA_WIDTH : integer := get_lesser(C_DIN_WIDTH, C_DOUT_WIDTH);
  CONSTANT C_LARGER_PNTR_WIDTH  : integer := get_greater(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_LARGER_DEPTH       : integer := get_greater(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_LARGER_DATA_WIDTH  : integer := get_greater(C_DIN_WIDTH, C_DOUT_WIDTH);

  --The write depth to read depth ratio is   C_RATIO_W : C_RATIO_R
  CONSTANT C_RATIO_W : integer := if_then_else( (C_WR_DEPTH > C_RD_DEPTH), (C_WR_DEPTH/C_RD_DEPTH), 1);
  CONSTANT C_RATIO_R : integer := if_then_else( (C_RD_DEPTH > C_WR_DEPTH), (C_RD_DEPTH/C_WR_DEPTH), 1);

  CONSTANT C_PROG_FULL_REG  : integer := 0;
  CONSTANT C_PROG_EMPTY_REG : integer := 0;

  CONSTANT counter_depth_wr : integer := C_FIFO_WR_DEPTH + 1;
  CONSTANT counter_depth_rd : integer := C_FIFO_RD_DEPTH + 1;


-------------------------------------------------------------------------------
-- Internal Signals
-------------------------------------------------------------------------------
  SIGNAL wr_point : integer   := 0;
  SIGNAL rd_point : integer   := 0;
  SIGNAL rd_reg0  : integer   := 0;
  SIGNAL rd_reg1  : integer   := 0;
  SIGNAL wr_reg0  : integer   := 0;
  SIGNAL wr_reg1  : integer   := 0;
  SIGNAL empty_i  : std_logic := '1';
  SIGNAL empty_q  : std_logic := '1';
  SIGNAL full_i   : std_logic := '1';
  SIGNAL almost_empty_i  : std_logic := '1';
  SIGNAL almost_full_i   : std_logic := '1';

  SIGNAL rd_rst_i : std_logic;
  SIGNAL rd_rst_int : std_logic;
  SIGNAL rd_rst_reg : std_logic;
  SIGNAL wr_rst_i : std_logic;
  SIGNAL wr_rst_int : std_logic;
  SIGNAL wr_rst_reg : std_logic;

  SIGNAL wr_diff_count   : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)       := (OTHERS => '0');
  SIGNAL rd_diff_count   : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)       := (OTHERS => '0');

  SIGNAL wr_ack_i    : std_logic := '0';
  SIGNAL wr_ack_q    : std_logic := '0';
  SIGNAL wr_ack_q2   : std_logic := '0';
  SIGNAL overflow_i  : std_logic := '0';
  SIGNAL overflow_q  : std_logic := '0';
  SIGNAL overflow_q2 : std_logic := '0';

  SIGNAL valid_i     : std_logic := '0';
  SIGNAL underflow_i : std_logic := '0';

  SIGNAL output_regs_valid : std_logic := '0';

  SIGNAL prog_full_noreg   : std_logic := '1';
  SIGNAL prog_full_reg     : std_logic := '1';
  SIGNAL prog_empty_noreg  : std_logic := '1';
  SIGNAL prog_empty_reg    : std_logic := '1';

-------------------------------------------------------------------------------
-- Linked List types
-------------------------------------------------------------------------------
  TYPE listtyp;
  TYPE listptr IS ACCESS listtyp;
  TYPE listtyp IS RECORD
                    data  : std_logic_vector(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
                    older : listptr;
                    newer : listptr;
                  END RECORD;


-------------------------------------------------------------------------------
-- Processes for linked list implementation
-------------------------------------------------------------------------------
  --Create a new linked list
  PROCEDURE newlist (head : INOUT listptr; tail : INOUT listptr) IS
  BEGIN
    head := NULL;
    tail := NULL;
  END;  -- procedure newlist;

  --Add a data element to a linked list
  PROCEDURE add (head : INOUT listptr; tail : INOUT listptr; data : IN std_logic_vector) IS
    VARIABLE oldhead  :       listptr;
    VARIABLE newhead  :       listptr;
  BEGIN
    --Create a pointer to the existing head, if applicable
    IF (head /= NULL) THEN
      oldhead       := head;
    END IF;
    --Create a new node for the list
    newhead         := NEW listtyp;
    --Make the new node point to the old head
    newhead.older   := oldhead;
    --Make the old head point back to the new node (for doubly-linked list)
    IF (head /= NULL) THEN
      oldhead.newer := newhead;
    END IF;
    --Put the data into the new head node
    newhead.data    := data;
    --If the new head we just created is the only node in the list, make the tail point to it
    IF (newhead.older = NULL) THEN
      tail          := newhead;
    END IF;
    --Return the new head pointer
    head            := newhead;
  END;  -- procedure; -- add;


  --Read the data from the tail of the linked list
  PROCEDURE read (tail : INOUT listptr; data : OUT std_logic_vector) IS
  BEGIN
    data := tail.data;
  END;  -- procedure; -- read;


  --Remove the tail from the linked list
  PROCEDURE remove (head : INOUT listptr; tail : INOUT listptr) IS
    VARIABLE oldtail     :       listptr;
    VARIABLE newtail     :       listptr;
  BEGIN
    --Make a copy of the old tail pointer
    oldtail         := tail;
    --If there is no newer node, then set the tail pointer to nothing (list is empty)
    IF (oldtail.newer = NULL) THEN
      newtail       := NULL;
      --otherwise, make the next newer node the new tail, and make it point to nothing older
    ELSE
      newtail       := oldtail.newer;
      newtail.older := NULL;
    END IF;
    --Clean up the memory for the old tail node
    DEALLOCATE(oldtail);
    --If the new tail is nothing, then we have an empty list, and head should also be set to nothing
    IF (newtail = NULL) THEN
      head          := NULL;
    END IF;
    --Return the new tail
    tail            := newtail;
  END;  -- procedure; -- remove;


  --Calculate the size of the linked list
  PROCEDURE sizeof (head : INOUT listptr; size : OUT integer) IS
    VARIABLE curlink     :       listptr;
    VARIABLE tmpsize     :       integer := 0;
  BEGIN
    --If head is null, then there is nothing in the list to traverse
    IF (head /= NULL) THEN
      --start with the head node (which implies at least one node exists)
      curlink                            := head;
      tmpsize                            := 1;
      --Loop through each node until you find the one that points to nothing (the tail)
      WHILE (curlink.older /= NULL) LOOP
        tmpsize                          := tmpsize + 1;
        curlink                          := curlink.older;
      END LOOP;
    END IF;
    --Return the number of nodes
    size                                 := tmpsize;
  END;  -- procedure; -- sizeof;


  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  FUNCTION count( fifo_count    : IN integer;
                  pointer_width : IN integer;
                  counter_width : IN integer
                  ) RETURN std_logic_vector IS
    VARIABLE temp               :    std_logic_vector(pointer_width-1 DOWNTO 0)   := (OTHERS => '0');
    VARIABLE output             :    std_logic_vector(counter_width - 1 DOWNTO 0) := (OTHERS => '0');

  BEGIN

    temp     := CONV_STD_LOGIC_VECTOR(fifo_count, pointer_width);
    IF (counter_width <= pointer_width) THEN
      output := temp(pointer_width - 1 DOWNTO pointer_width - counter_width);
    ELSE
      output := temp(counter_width - 1 DOWNTO 0);
    END IF;
    RETURN output;
  END count;


-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN



-------------------------------------------------------------------------------
-- Prepare input signals
-------------------------------------------------------------------------------
--Single RST
grst : IF (C_HAS_RST=1) GENERATE
  PROCESS (WR_CLK, RST)
  BEGIN
    IF (RST = '1') THEN
      wr_rst_reg <= '1';
    ELSIF (WR_CLK'event and WR_CLK = '1') THEN
      IF (wr_rst_int = '1') THEN
        wr_rst_reg <= '0';
      END IF;
    END IF;

    IF (RST = '1') THEN
      wr_rst_int <= '1';
    ELSIF (WR_CLK'event and WR_CLK = '1') THEN
      wr_rst_int <= wr_rst_reg;
    END IF;
  END PROCESS;

  PROCESS (RD_CLK, RST)
  BEGIN
    IF (RST = '1') THEN
      rd_rst_reg <= '1';
    ELSIF (RD_CLK'event and RD_CLK = '1') THEN
      IF (rd_rst_int = '1') THEN
        rd_rst_reg <= '0';
      END IF;
    END IF;

    IF (RST = '1') THEN
      rd_rst_int <= '1';
    ELSIF (RD_CLK'event and RD_CLK = '1') THEN
      rd_rst_int <= rd_rst_reg;
    END IF;

  END PROCESS;

  wr_rst_i <= wr_rst_int;
  rd_rst_i <= rd_rst_int;
END GENERATE grst;

--No RST
norst  : IF (C_HAS_RST=0) GENERATE
  rd_rst_i <= '0';
  wr_rst_i <= '0';
END GENERATE norst;



  --Calculate WR_ACK based on C_WR_ACK_LOW parameters
    gwalow : IF (C_WR_ACK_LOW = 0) GENERATE
      --WR_ACK <= wr_ack_q;
      WR_ACK <= wr_ack_i;
    END GENERATE gwalow;
    gwahgh : IF (C_WR_ACK_LOW = 1) GENERATE
      --WR_ACK <= NOT wr_ack_q;
      WR_ACK <= NOT wr_ack_i;
    END GENERATE gwahgh;

  --Calculate OVERFLOW based on C_OVERFLOW_LOW parameters
    govlow : IF (C_OVERFLOW_LOW = 0) GENERATE
      --OVERFLOW <= overflow_q;
      OVERFLOW <= overflow_i;
    END GENERATE govlow;
    govhgh : IF (C_OVERFLOW_LOW = 1) GENERATE
      --OVERFLOW <= NOT overflow_q;
      OVERFLOW <= NOT overflow_i;
    END GENERATE govhgh;

  --Calculate VALID based on C_PRELOAD_LATENCY, C_PRELOAD_REGS, and C_VALID_LOW settings
  gvlat1 : IF ((C_PRELOAD_LATENCY = 1) AND (C_PRELOAD_REGS = 0)) GENERATE
    gnvl : IF (C_VALID_LOW = 0) GENERATE
      VALID <= valid_i;
    END GENERATE gnvl;
    gnvh : IF (C_VALID_LOW = 1) GENERATE
      VALID <= NOT valid_i;
    END GENERATE gnvh;
  END GENERATE gvlat1;

  --Calculate VALID based on C_PRELOAD_LATENCY, C_PRELOAD_REGS, and C_VALID_LOW settings
  gvreg1 : IF ((C_PRELOAD_LATENCY = 0) AND (C_PRELOAD_REGS = 1)) GENERATE
    gnvl : IF (C_VALID_LOW = 0) GENERATE
      VALID <= valid_i;
    END GENERATE gnvl;
    gnvh : IF (C_VALID_LOW = 1) GENERATE
      VALID <= NOT valid_i;
    END GENERATE gnvh;
  END GENERATE gvreg1;

  --Calculate UNDERFLOW based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  guflat1 : IF ((C_PRELOAD_LATENCY = 1) AND (C_PRELOAD_REGS = 0)) GENERATE
    gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
      UNDERFLOW <= underflow_i;
    END GENERATE gnul;
    gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
      UNDERFLOW <= NOT underflow_i;
    END GENERATE gnuh;
  END GENERATE guflat1;

  --Calculate UNDERFLOW based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  gufreg1 : IF ((C_PRELOAD_LATENCY = 0) AND (C_PRELOAD_REGS = 1)) GENERATE
    gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
      UNDERFLOW <= underflow_i;
    END GENERATE gnul;
    gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
      UNDERFLOW <= NOT underflow_i;
    END GENERATE gnuh;
  END GENERATE gufreg1;

  --Insert registered delay based on C_PROG_FULL_REG setting
  gpfnreg: IF (C_PROG_FULL_REG = 0) GENERATE
    PROG_FULL <= prog_full_noreg;
  END GENERATE gpfnreg;

  gpfreg: IF (C_PROG_FULL_REG = 1) GENERATE
    PROG_FULL <= prog_full_reg;
  END GENERATE gpfreg;

  --Insert registered delay based on C_PROG_EMPTY_REG setting
  gpenreg: IF (C_PROG_EMPTY_REG = 0) GENERATE
    PROG_EMPTY <= prog_empty_noreg;
  END GENERATE gpenreg;

  gpereg: IF (C_PROG_EMPTY_REG = 1) GENERATE
    PROG_EMPTY <= prog_empty_reg;
  END GENERATE gpereg;

  rdcg: if (C_RD_DATA_COUNT_WIDTH>C_RD_PNTR_WIDTH) generate
    RD_DATA_COUNT <= '0' & rd_diff_count;
  end generate rdcg;
  nrdcg: if (C_RD_DATA_COUNT_WIDTH<=C_RD_PNTR_WIDTH) generate
    RD_DATA_COUNT <= rd_diff_count(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH);
  end generate nrdcg;

  wdcg: if (C_WR_DATA_COUNT_WIDTH>C_WR_PNTR_WIDTH) generate
    WR_DATA_COUNT <= '0' & wr_diff_count;
  end generate wdcg;
  nwdcg: if (C_WR_DATA_COUNT_WIDTH<=C_WR_PNTR_WIDTH) generate
    WR_DATA_COUNT <= wr_diff_count(C_WR_PNTR_WIDTH-1 DOWNTO C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH);
  end generate nwdcg;

  FULL          <= full_i;
  EMPTY         <= empty_i;
  ALMOST_FULL   <= almost_full_i;
  ALMOST_EMPTY  <= almost_empty_i;

-------------------------------------------------------------------------------
-- Asynchrounous FIFO using linked lists
-------------------------------------------------------------------------------
  FIFO_PROC : PROCESS (WR_CLK, RD_CLK, rd_rst_i, wr_rst_i)

    VARIABLE head : listptr;
    VARIABLE tail : listptr;
    VARIABLE size : integer                                     := 0;
    --VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
    VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) := (others => '0');

    VARIABLE prog_empty_actual_assert_thresh : integer := 0;
    VARIABLE prog_empty_actual_negate_thresh : integer := 0;
    VARIABLE prog_full_actual_assert_thresh : integer := 0;
    VARIABLE prog_full_actual_negate_thresh : integer := 0;

  BEGIN

    --Calculate the current contents of the FIFO (size)
    -- Warning: This value should only be calculated once each time this
    -- process is entered. It is updated instantaneously.
    sizeof(head, size);

    -- RESET CONDITIONS
    IF wr_rst_i = '1' THEN
      -- Whenever user is attempting to write to
      -- a FULL FIFO, the core should report an overflow error, even if
      -- the core is in a RESET condition.
      overflow_i  <= full_i and WR_EN;
      overflow_q  <= full_i and WR_EN;
      overflow_q2 <= full_i and WR_EN;
      wr_ack_q    <= '0';
      wr_ack_q2   <= '0';
      wr_ack_i    <= '0';

      full_i          <= C_FULL_RESET_VAL;         --'1';
      almost_full_i   <= C_ALMOST_FULL_RESET_VAL;  --'1';

      wr_point <= 0;
      rd_reg0  <= 0;
      rd_reg1  <= 0;
      wr_diff_count <= (others => '0');

      IF wr_rst_reg = '0' THEN
        prog_full_noreg <= '0';
        prog_full_reg   <= '0';
      ELSE
        prog_full_noreg <= C_PROG_FULL_RESET_VAL;
        prog_full_reg   <= C_PROG_FULL_RESET_VAL;
      END IF;

        --Create new linked list
      newlist(head, tail);

      --Clear data output queue
      data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);

      ---------------------------------------------------------------------------
      -- Write to FIFO
      ---------------------------------------------------------------------------
    ELSIF WR_CLK'event AND WR_CLK = '1' THEN

      --Create registered versions of these internal signals
      wr_ack_q    <= wr_ack_i;
      wr_ack_q2   <= wr_ack_q;
      overflow_q  <= overflow_i;
      overflow_q2 <= overflow_q;

      rd_reg0 <= rd_point;
      rd_reg1 <= rd_reg0;

      prog_full_reg <= prog_full_noreg;

      wr_diff_count <= conv_std_logic_vector((size/C_RATIO_R), C_WR_PNTR_WIDTH);


        IF (WR_EN = '1' and full_i = '0') THEN

          --If writing, then it is not possible to predict how many
          --words will actually be in the FIFO after the write concludes
          --(because the number of reads which happen in this time can
          -- not be determined).
          --Therefore, treat it pessimistically and always assume that
          -- the write will happen without a read (assume the FIFO is
          -- C_RATIO_R fuller than it is).
          IF (size+C_RATIO_R >= C_FIFO_WR_DEPTH*C_RATIO_R-C_RATIO_R+1) THEN
            full_i      <= '1';
            almost_full_i <= '1';
          ELSIF (size+C_RATIO_R >= C_FIFO_WR_DEPTH*C_RATIO_R-(2*C_RATIO_R)+1) THEN
            full_i      <= '0';
            almost_full_i <= '1';
          ELSE
            full_i      <= '0';
            almost_full_i <= '0';
          END IF;

        ELSE --IF (WR_EN='0' or full_i='1')

          --If not writing, then use the actual number of words in the FIFO
          -- to determine if the FIFO should be reporting FULL or not.
          IF (size >= C_FIFO_WR_DEPTH*C_RATIO_R-C_RATIO_R+1) THEN
            full_i      <= '1';
            almost_full_i <= '1';
          ELSIF (size >= C_FIFO_WR_DEPTH*C_RATIO_R-(2*C_RATIO_R)+1) THEN
            full_i      <= '0';
            almost_full_i <= '1';
          ELSE
            full_i      <= '0';
            almost_full_i <= '0';
          END IF;

        END IF;  --WR_EN



      -- User is writing to the FIFO
      IF WR_EN = '1' THEN
        -- User is writing to a FIFO which is NOT reporting FULL
        IF full_i /= '1' THEN

          -- FIFO really is Full
          IF size/C_RATIO_R = C_FIFO_WR_DEPTH THEN
            --Report Overflow and do not acknowledge the write
            overflow_i <= '1';
            wr_ack_i   <= '0';

            -- FIFO is almost full
          ELSIF size/C_RATIO_R + 1 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go FULL
            overflow_i <= '0';
            wr_ack_i   <= '1';
            full_i     <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;

            -- FIFO is one away from almost full
          ELSIF size/C_RATIO_R + 2 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go almost_full_i
            overflow_i  <= '0';
            wr_ack_i    <= '1';
            almost_full_i <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point    <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;

            -- FIFO is no where near FULL
          ELSE
            --Write will succeed, no change in status
            overflow_i <= '0';
            wr_ack_i   <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;
          END IF;

          -- User is writing to a FIFO which IS reporting FULL
        ELSE                            --IF full_i = '1'
          --Write will fail
          overflow_i <= '1';
          wr_ack_i   <= '0';
        END IF;  --full_i

      ELSE                              --WR_EN/='1'
        --No write attempted, so neither overflow or acknowledge
        overflow_i <= '0';
        wr_ack_i   <= '0';
      END IF;  --WR_EN

      -------------------------------------------------------------------------
      -- Programmable FULL flags
      -------------------------------------------------------------------------
      -- Determine the assert and negate thresholds for comparison
      -- (Subtract 2 read words when using Preload 0)

      --Single Constant Threshold
      IF (C_PROG_FULL_TYPE = 1) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_full_actual_assert_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R-2*C_RATIO_W;
          prog_full_actual_negate_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R-2*C_RATIO_W;
        else
          prog_full_actual_assert_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R;
          prog_full_actual_negate_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R;
        end if;


        --Dual Constant Thresholds
      ELSIF (C_PROG_FULL_TYPE = 2) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_full_actual_assert_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R-2*C_RATIO_W;
          prog_full_actual_negate_thresh := C_PROG_FULL_THRESH_NEGATE_VAL*C_RATIO_R-2*C_RATIO_W;
        else
          prog_full_actual_assert_thresh := C_PROG_FULL_THRESH_ASSERT_VAL*C_RATIO_R;
          prog_full_actual_negate_thresh := C_PROG_FULL_THRESH_NEGATE_VAL*C_RATIO_R;
        end if;

        --Single threshold input port
      ELSIF (C_PROG_FULL_TYPE = 3) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_full_actual_assert_thresh := conv_integer(PROG_FULL_THRESH)*C_RATIO_R-2*C_RATIO_W;
          prog_full_actual_negate_thresh := conv_integer(PROG_FULL_THRESH)*C_RATIO_R-2*C_RATIO_W;
        else
          prog_full_actual_assert_thresh := conv_integer(PROG_FULL_THRESH)*C_RATIO_R;
          prog_full_actual_negate_thresh := conv_integer(PROG_FULL_THRESH)*C_RATIO_R;
        end if;

        --Dual threshold input ports
      ELSIF (C_PROG_FULL_TYPE = 4) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_full_actual_assert_thresh := conv_integer(PROG_FULL_THRESH_ASSERT)*C_RATIO_R-2*C_RATIO_W;
          prog_full_actual_negate_thresh := conv_integer(PROG_FULL_THRESH_NEGATE)*C_RATIO_R-2*C_RATIO_W;
        else
          prog_full_actual_assert_thresh := conv_integer(PROG_FULL_THRESH_ASSERT)*C_RATIO_R;
          prog_full_actual_negate_thresh := conv_integer(PROG_FULL_THRESH_NEGATE)*C_RATIO_R;
        end if;

      END IF;  --C_PROG_FULL_TYPE


        -- If we will be going at or above the prog_full_actual_assert_thresh threshold
        -- on the next clock cycle, then assert PROG_FULL

        -- WARNING: For the fifo with separate clocks, it is possible that
        -- the core could be both reading and writing simultaneously, with
        -- the writes occuring faster. This means that the number of words
        -- in the FIFO is increasing, and PROG_FULL should be asserted. So,
        -- we assume the worst and assert PROG_FULL if we are close and
        -- writing, since RD_EN may or may not have an impact on the number
        -- of words in the FIFO.
        IF ((size = prog_full_actual_assert_thresh-1) AND WR_EN = '1') THEN
          prog_full_noreg <= '1';

        -- If we are at or above the prog_full_actual_assert_thresh, then assert
        -- PROG_FULL
        ELSIF (size >= prog_full_actual_assert_thresh) THEN
          prog_full_noreg <= '1';
        --If we are below the prog_full_actual_negate_thresh, then de-assert PROG_FULL
        ELSIF (size <prog_full_actual_negate_thresh) THEN
          prog_full_noreg <= '0';
        END IF;




    END IF;  --WR_CLK

    ---------------------------------------------------------------------------
    -- Read from FIFO
    ---------------------------------------------------------------------------
    IF rd_rst_i = '1' THEN
      -- Whenever user is attempting to read from
      -- an EMPTY FIFO, the core should report an underflow error, even if
      -- the core is in a RESET condition.
      underflow_i       <= empty_i and RD_EN;
      valid_i           <= '0';
      output_regs_valid <= '0';
      empty_i           <= '1';
      empty_q           <= '1';
      almost_empty_i      <= '1';

      rd_point <= 0;
      wr_reg0  <= 0;
      wr_reg1  <= 0;
      rd_diff_count <= (others => '0');

      prog_empty_noreg <= '1';
      prog_empty_reg <= '1';

      --Clear data output queue
      data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);

    ELSIF RD_CLK'event AND RD_CLK = '1' THEN

      --These values are set to this value
      -- (unless overridden later in this process)
      underflow_i <= '0';
      valid_i     <= '0';
      empty_q     <= empty_i;

      prog_empty_reg <= prog_empty_noreg;
      --Default
      wr_reg0           <= wr_point;
      wr_reg1           <= wr_reg0;
      rd_diff_count <= conv_std_logic_vector((size/C_RATIO_W), C_RD_PNTR_WIDTH);

      ---------------------------------------------------------------------------
      -- Read Latency 1
      ---------------------------------------------------------------------------

        IF size/C_RATIO_W = 0 THEN
          empty_i      <= '1';
          almost_empty_i <= '1';
        ELSIF size/C_RATIO_W = 1 THEN
          empty_i      <= '0';
          almost_empty_i <= '1';
        ELSE
          empty_i      <= '0';
          almost_empty_i <= '0';
        END IF;

        IF RD_EN = '1' THEN

          IF empty_i /= '1' THEN
            -- FIFO full
            IF size/C_RATIO_W = 2 THEN
              almost_empty_i <= '1';
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
              -- almost empty
            ELSIF size/C_RATIO_W = 1 THEN
              almost_empty_i <= '1';
              empty_i      <= '1';
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
              -- fifo empty
            ELSIF size/C_RATIO_W = 0 THEN
              underflow_i  <= '1';
              -- middle counts
            ELSE
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
            END IF;
          ELSE
            underflow_i    <= '1';
          END IF;
        END IF;  --RD_EN

      ---------------------------------------------------------------------------
      -- Programmable EMPTY Flags
      ---------------------------------------------------------------------------
      -- Determine the assert and negate thresholds for comparison
      -- (Subtract 2 read words when using Preload 0)


      --Single Constant Threshold
      IF (C_PROG_EMPTY_TYPE = 1) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_empty_actual_assert_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL - 2;
          prog_empty_actual_negate_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL - 2;
        else
          prog_empty_actual_assert_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL;
          prog_empty_actual_negate_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL;
        end if;

        --Dual constant thresholds
      ELSIF (C_PROG_EMPTY_TYPE = 2) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_empty_actual_assert_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL - 2;
          prog_empty_actual_negate_thresh := C_PROG_EMPTY_THRESH_NEGATE_VAL - 2;
        else
          prog_empty_actual_assert_thresh := C_PROG_EMPTY_THRESH_ASSERT_VAL;
          prog_empty_actual_negate_thresh := C_PROG_EMPTY_THRESH_NEGATE_VAL;
        end if;

  --Single threshold input port
      ELSIF (C_PROG_EMPTY_TYPE = 3) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_empty_actual_assert_thresh := conv_integer(PROG_EMPTY_THRESH) - 2;
          prog_empty_actual_negate_thresh := conv_integer(PROG_EMPTY_THRESH) - 2;
        else
          prog_empty_actual_assert_thresh := conv_integer(PROG_EMPTY_THRESH);
          prog_empty_actual_negate_thresh := conv_integer(PROG_EMPTY_THRESH);
        end if;

        --Dual threshold input ports
      ELSIF (C_PROG_EMPTY_TYPE = 4) THEN
        if (C_PRELOAD_REGS=1 and C_PRELOAD_LATENCY=0) then
          prog_empty_actual_assert_thresh := conv_integer(PROG_EMPTY_THRESH_ASSERT) - 2;
          prog_empty_actual_negate_thresh := conv_integer(PROG_EMPTY_THRESH_NEGATE) - 2;
        else
          prog_empty_actual_assert_thresh := conv_integer(PROG_EMPTY_THRESH_ASSERT);
          prog_empty_actual_negate_thresh := conv_integer(PROG_EMPTY_THRESH_NEGATE);
        end if;

     END IF;


        -- If we will be going at or below the prog_empty_actual_assert_thresh threshold
        -- on the next clock cycle, then assert PROG_EMPTY
        --
        -- WARNING: For the fifo with separate clocks, it is possible that
        -- the core could be both reading and writing simultaneously, with
        -- the reads occuring faster. This means that the number of words
        -- in the FIFO is decreasing, and PROG_EMPTY should be asserted. So,
        -- we assume the worst and assert PROG_EMPTY if we are close and
        -- reading, since WR_EN may or may not have an impact on the number
        -- of words in the FIFO.
        IF ((size/C_RATIO_W = prog_empty_actual_assert_thresh+1) AND RD_EN = '1') THEN
          prog_empty_noreg <= '1';

          -- If we are at or below the prog_empty_actual_assert_thresh, then assert
          -- PROG_EMPTY
        ELSIF (size/C_RATIO_W <= prog_empty_actual_assert_thresh) THEN
          prog_empty_noreg          <= '1';

          --If we are above the prog_empty_actual_negate_thresh, then de-assert PROG_EMPTY
        ELSIF (size/C_RATIO_W > prog_empty_actual_negate_thresh) THEN
          prog_empty_noreg <= '0';
        END IF;







    END IF;  --RD_CLK

    DOUT <= data;

  END PROCESS;

END behavioral;




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Synchronous FIFO Behavioral Model
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;
-- USE IEEE.std_logic_arith.ALL;

LIBRARY work;
USE work.iputils_std_logic_unsigned.ALL;
USE work.iputils_std_logic_arith.ALL;
USE work.iputils_conv.ALL;
USE work.iputils_misc.ALL;

-------------------------------------------------------------------------------
-- Entity Declaration
-------------------------------------------------------------------------------
ENTITY fifo_generator_v2_2_bhv_ss IS

  GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    --------------------------------------------------------------------------------
    C_COMMON_CLOCK          : integer := 0;  --supported
    C_COUNT_TYPE            : integer := 0;  --not relevant to behavioral model
    C_DATA_COUNT_WIDTH      : integer := 2;  --supported
    C_DEFAULT_VALUE         : string  := "";  --supported
    C_DIN_WIDTH             : integer := 8;  --asymmetric ports not yet supported. AsyncFifoParam=C_DATA_WIDTH       : integer := 32;
    C_DOUT_RST_VAL          : string  := "";  --supported
    C_DOUT_WIDTH            : integer := 8;  --asymmetric ports not yet supported. AsyncFifoParam=C_DATA_WIDTH       : integer := 32;
    C_ENABLE_RLOCS          : integer := 0;  --not relevant to behavioral model
    C_FAMILY                : string  := "virtex2";  --not relevant to behavioral model
    C_HAS_ALMOST_FULL       : integer := 0;  --supported. AsyncFifoParam=C_HAS_ALMOST_FULL  : integer := 0;
    C_HAS_ALMOST_EMPTY      : integer := 0;  --supported. AsyncFifoParam=C_HAS_ALMOST_EMPTY : integer := 0;
    C_HAS_BACKUP            : integer := 0;  --not yet supported
    C_HAS_DATA_COUNT        : integer := 0;  --supported
    C_HAS_MEMINIT_FILE      : integer := 0;  --not yet supported
    C_HAS_OVERFLOW          : integer := 0;  --supported. AsyncFifoParam=C_HAS_WR_ERR       : integer := 0;
    C_HAS_RD_DATA_COUNT     : integer := 0;  --not yet supported. AsyncFifoParam=C_HAS_RD_COUNT     : integer := 0;
    C_HAS_RD_RST            : integer := 0;  --not yet supported
    C_HAS_RST               : integer := 0;  --supported
    C_HAS_UNDERFLOW         : integer := 0;  --supported. AsyncFifoParam=C_HAS_RD_ERR       : integer := 0;
    C_HAS_VALID             : integer := 0;  --supported. AsyncFifoParam=C_HAS_VALID       : integer := 0;
    C_HAS_WR_ACK            : integer := 0;  --supported. AsyncFifoParam=C_HAS_WR_ACK       : integer := 0;
    C_HAS_WR_DATA_COUNT     : integer := 0;  --not yet supported. AsyncFifoParam=C_HAS_WR_COUNT     : integer := 0;
    C_HAS_WR_RST            : integer := 0;  --supported
    C_INIT_WR_PNTR_VAL      : integer := 0;  --not yet supported
    C_MEMORY_TYPE           : integer := 1;  --supported. AsyncFifoParam=C_MEMOTY_TYPE     : integer := 1;
    C_MIF_FILE_NAME         : string  := "";  --not yet supported
    C_OPTIMIZATION_MODE     : integer := 0;  --not relevant to behavioral model
    C_OVERFLOW_LOW          : integer := 0;  --supported. AsyncFifoParam=C_WR_ERR_LOW       : integer := 0;
    C_PRELOAD_REGS          : integer := 0;  --not yet supported
    C_PRELOAD_LATENCY       : integer := 1;  --not yet supported
    C_PROG_EMPTY_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_EMPTY_TYPE              : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  : integer := 0;
    C_PROG_FULL_TYPE               : integer := 0;
    C_RD_DATA_COUNT_WIDTH   : integer := 2;  --supported. AsyncFifoParam=C_RD_COUNT_WIDTH   : integer := 2;
    C_RD_DEPTH              : integer := 256;  --asymmetric ports not yet supported. AsyncFifoParam=C_FIFO_DEPTH       : integer := 511;
    C_RD_PNTR_WIDTH         : integer := 8;  --not yet supported
    C_UNDERFLOW_LOW         : integer := 0;  --supported. AsyncFifoParam=C_RD_ERR_LOW       : integer := 0;
    C_VALID_LOW             : integer := 0;  --supported. AsyncFifoParam=C_VALID_LOW       : integer := 0;
    C_WR_ACK_LOW            : integer := 0;  --supported. AsyncFifoParam=C_WR_ACK_LOW       : integer := 0;
    C_WR_DATA_COUNT_WIDTH   : integer := 2;  --supported. AsyncFifoParam=C_WR_COUNT_WIDTH   : integer := 2;
    C_WR_DEPTH              : integer := 256;  --asymmetric ports not yet supported. AsyncFifoParam=C_FIFO_DEPTH       : integer := 511;
    C_WR_PNTR_WIDTH         : integer := 8;  --not yet supported
    C_WR_RESPONSE_LATENCY   : integer := 1  --not yet supported
    );


  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK               : IN std_logic                                    := '0';
    BACKUP            : IN std_logic                                    := '0';
    BACKUP_MARKER     : IN std_logic                                    := '0';
    DIN               : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0)     := (OTHERS => '0');
    PROG_EMPTY_THRESH : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK            : IN std_logic                                    := '0';
    RD_EN             : IN std_logic                                    := '0';
    RD_RST            : IN std_logic                                    := '0';
    RST               : IN std_logic                                    := '0';
    WR_CLK            : IN std_logic                                    := '0';
    WR_EN             : IN std_logic                                    := '0';
    WR_RST            : IN std_logic                                    := '0';

    ALMOST_EMPTY  : OUT std_logic := '1';
    ALMOST_FULL   : OUT std_logic := '1';
    DATA_COUNT    : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                      (OTHERS => '0');
    DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY         : OUT std_logic := '1';
    FULL          : OUT std_logic := '1';
    OVERFLOW      : OUT std_logic := '0';
    PROG_EMPTY    : OUT std_logic := '1';
    PROG_FULL     : OUT std_logic := '1';
    VALID         : OUT std_logic := '0';
    RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                     (OTHERS => '0');
    UNDERFLOW     : OUT std_logic := '0';
    WR_ACK        : OUT std_logic := '0';
    WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0):=
                     (OTHERS => '0')
    );

END fifo_generator_v2_2_bhv_ss;
-------------------------------------------------------------------------------
-- Definition of Ports
-- DIN : Input data bus for the fifo.
-- DOUT : Output data bus for the fifo.
-- AINIT : Asynchronous Reset for the fifo.
-- WR_EN : Write enable signal.
-- WR_CLK : Write Clock.
-- FULL : Full signal.
-- ALMOST_FULL : One space left.
-- WR_ACK : Last write acknowledged.
-- WR_ERR : Last write rejected.
-- WR_COUNT : Number of data words in fifo(synchronous to WR_CLK)
-- Rd_EN : Read enable signal.
-- RD_CLK : Read Clock.
-- EMPTY : Empty signal.
-- ALMOST_EMPTY: One sapce left
-- VALID : Last read acknowledged.
-- RD_ERR : Last read rejected.
-- RD_COUNT : Number of data words in fifo(synchronous to RD_CLK)
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF fifo_generator_v2_2_bhv_ss IS

  CONSTANT C_HAS_FAST_FIFO  : integer := 0;  --DEFAULT_HAS_FAST_FIFO

-------------------------------------------------------------------------------
-- actual_fifo_depth
-- Returns the actual depth of the FIFO (may differ from what the user specified)
--
-- The FIFO depth is always represented as 2^n (16,32,64,128,256)
-- However, the ACTUAL fifo depth may be 2^n or (2^n - 1) depending on certain
-- options. This function returns the ACTUAL depth of the fifo, as seen by
-- the user.
--
-- The FIFO depth remains as 2^n when any of the following conditions are true:
-- *C_HAS_FAST_FIFO=1 (using Peter Alfke's implementation)
-- *C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=1 (preload output register adds 1
-- word of depth to the FIFO)
-- *C_COMMON_CLOCK=1 (sync fifo can use entire memory depth)
-------------------------------------------------------------------------------
  FUNCTION actual_fifo_depth(c_fifo_depth : integer; C_HAS_FAST_FIFO : integer; C_PRELOAD_REGS : integer; C_PRELOAD_LATENCY : integer; C_COMMON_CLOCK : integer) RETURN integer IS
  BEGIN
    IF (C_HAS_FAST_FIFO = 1 OR (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 1) OR C_COMMON_CLOCK = 1) THEN
      RETURN c_fifo_depth;
    ELSE
      RETURN c_fifo_depth-1;
    END IF;
  END actual_fifo_depth;

--------------------------------------------------------------------------------
-- Derived Constants
--------------------------------------------------------------------------------
  CONSTANT C_FULL_RESET_VAL        : std_logic := '1';
  CONSTANT C_ALMOST_FULL_RESET_VAL : std_logic := '1';
  CONSTANT C_PROG_FULL_RESET_VAL   : std_logic := '1';

  CONSTANT C_FIFO_WR_DEPTH : integer := actual_fifo_depth(C_WR_DEPTH, C_HAS_FAST_FIFO, C_PRELOAD_REGS, C_PRELOAD_LATENCY, C_COMMON_CLOCK);
  CONSTANT C_FIFO_RD_DEPTH : integer := actual_fifo_depth(C_RD_DEPTH, C_HAS_FAST_FIFO, C_PRELOAD_REGS, C_PRELOAD_LATENCY, C_COMMON_CLOCK);

  CONSTANT C_SMALLER_PNTR_WIDTH : integer := get_lesser(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_SMALLER_DEPTH      : integer := get_lesser(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_SMALLER_DATA_WIDTH : integer := get_lesser(C_DIN_WIDTH, C_DOUT_WIDTH);
  CONSTANT C_LARGER_PNTR_WIDTH  : integer := get_greater(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_LARGER_DEPTH       : integer := get_greater(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_LARGER_DATA_WIDTH  : integer := get_greater(C_DIN_WIDTH, C_DOUT_WIDTH);

  --The write depth to read depth ratio is   C_RATIO_W : C_RATIO_R
  CONSTANT C_RATIO_W : integer := if_then_else( (C_WR_DEPTH > C_RD_DEPTH), (C_WR_DEPTH/C_RD_DEPTH), 1);
  CONSTANT C_RATIO_R : integer := if_then_else( (C_RD_DEPTH > C_WR_DEPTH), (C_RD_DEPTH/C_WR_DEPTH), 1);

  CONSTANT C_PROG_FULL_REG  : integer := 1;
  CONSTANT C_PROG_EMPTY_REG : integer := 1;

  CONSTANT counter_depth_wr : integer := C_FIFO_WR_DEPTH + 1;
  CONSTANT counter_depth_rd : integer := C_FIFO_RD_DEPTH + 1;

-------------------------------------------------------------------------------
-- Internal Signals
-------------------------------------------------------------------------------
  SIGNAL empty_i        : std_logic := '1';
  SIGNAL full_i         : std_logic := '1';
  SIGNAL almost_empty_i : std_logic := '1';
  SIGNAL almost_full_i  : std_logic := '1';

  SIGNAL rst_i : std_logic;
  SIGNAL rst_int : std_logic;
  SIGNAL rst_reg : std_logic;

  SIGNAL diff_count   : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)       := (OTHERS => '0');

  SIGNAL wr_ack_i    : std_logic := '0';
  SIGNAL wr_ack_q    : std_logic := '0';
  SIGNAL wr_ack_q2   : std_logic := '0';
  SIGNAL overflow_i  : std_logic := '0';
  SIGNAL overflow_q  : std_logic := '0';
  SIGNAL overflow_q2 : std_logic := '0';

  SIGNAL valid_i     : std_logic := '0';
  SIGNAL underflow_i : std_logic := '0';

  SIGNAL output_regs_valid : std_logic := '0';
  SIGNAL rst_q          : std_logic := '0';

  SIGNAL prog_full_reg   : std_logic := '1';
  SIGNAL prog_full_noreg : std_logic := '1';
  SIGNAL prog_empty_reg  : std_logic := '1';
  SIGNAL prog_empty_noreg: std_logic := '1';

  SIGNAL power_on_timer  : integer := 3;

-------------------------------------------------------------------------------
-- Linked List types
-------------------------------------------------------------------------------
  TYPE listtyp;
  TYPE listptr IS ACCESS listtyp;
  TYPE listtyp IS RECORD
                    data  : std_logic_vector(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
                    older : listptr;
                    newer : listptr;
                  END RECORD;

-------------------------------------------------------------------------------
-- Processes for linked list implementation
-------------------------------------------------------------------------------
  --Create a new linked list
  PROCEDURE newlist (head : INOUT listptr; tail : INOUT listptr) IS
  BEGIN
    head := NULL;
    tail := NULL;
  END;  -- procedure newlist;

  --Add a data element to a linked list
  PROCEDURE add (head : INOUT listptr; tail : INOUT listptr; data : IN std_logic_vector) IS
    VARIABLE oldhead  :       listptr;
    VARIABLE newhead  :       listptr;
  BEGIN
    --Create a pointer to the existing head, if applicable
    IF (head /= NULL) THEN
      oldhead       := head;
    END IF;
    --Create a new node for the list
    newhead         := NEW listtyp;
    --Make the new node point to the old head
    newhead.older   := oldhead;
    --Make the old head point back to the new node (for doubly-linked list)
    IF (head /= NULL) THEN
      oldhead.newer := newhead;
    END IF;
    --Put the data into the new head node
    newhead.data    := data;
    --If the new head we just created is the only node in the list, make the tail point to it
    IF (newhead.older = NULL) THEN
      tail          := newhead;
    END IF;
    --Return the new head pointer
    head            := newhead;
  END;  -- procedure; -- add;


  --Read the data from the tail of the linked list
  PROCEDURE read (tail : INOUT listptr; data : OUT std_logic_vector) IS
  BEGIN
    data := tail.data;
  END;  -- procedure; -- read;


  --Remove the tail from the linked list
  PROCEDURE remove (head : INOUT listptr; tail : INOUT listptr) IS
    VARIABLE oldtail     :       listptr;
    VARIABLE newtail     :       listptr;
  BEGIN
    --Make a copy of the old tail pointer
    oldtail         := tail;
    --If there is no newer node, then set the tail pointer to nothing (list is empty)
    IF (oldtail.newer = NULL) THEN
      newtail       := NULL;
      --otherwise, make the next newer node the new tail, and make it point to nothing older
    ELSE
      newtail       := oldtail.newer;
      newtail.older := NULL;
    END IF;
    --Clean up the memory for the old tail node
    DEALLOCATE(oldtail);
    --If the new tail is nothing, then we have an empty list, and head should also be set to nothing
    IF (newtail = NULL) THEN
      head          := NULL;
    END IF;
    --Return the new tail
    tail            := newtail;
  END;  -- procedure; -- remove;


  --Calculate the size of the linked list
  PROCEDURE sizeof (head : INOUT listptr; size : OUT integer) IS
    VARIABLE curlink     :       listptr;
    VARIABLE tmpsize     :       integer := 0;
  BEGIN
    --If head is null, then there is nothing in the list to traverse
    IF (head /= NULL) THEN
      --start with the head node (which implies at least one node exists)
      curlink                            := head;
      tmpsize                            := 1;
      --Loop through each node until you find the one that points to nothing (the tail)
      WHILE (curlink.older /= NULL) LOOP
        tmpsize                          := tmpsize + 1;
        curlink                          := curlink.older;
      END LOOP;
    END IF;
    --Return the number of nodes
    size                                 := tmpsize;
  END;  -- procedure; -- sizeof;


  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  FUNCTION count( fifo_count    : IN integer;
                  pointer_width : IN integer;
                  counter_width : IN integer
                  ) RETURN std_logic_vector IS
    VARIABLE temp               :    std_logic_vector(pointer_width-1 DOWNTO 0)   := (OTHERS => '0');
    VARIABLE output             :    std_logic_vector(counter_width - 1 DOWNTO 0) := (OTHERS => '0');

  BEGIN

    temp     := CONV_STD_LOGIC_VECTOR(fifo_count, pointer_width);
    IF (counter_width <= pointer_width) THEN
      output := temp(pointer_width - 1 DOWNTO pointer_width - counter_width);
    ELSE
      output := temp(counter_width - 1 DOWNTO 0);
    END IF;
    RETURN output;
  END count;


-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN


-------------------------------------------------------------------------------
-- Prepare input signals
-------------------------------------------------------------------------------
--Single RST
grst : IF (C_HAS_RST=1) GENERATE
  PROCESS (CLK, RST)
  BEGIN
    IF (RST = '1') THEN
      rst_reg <= '1';
    ELSIF (CLK'event and CLK = '1') THEN
      IF (rst_int = '1') THEN
        rst_reg <= '0';
      END IF;
    END IF;

    IF (RST = '1') THEN
      rst_int <= '1';
    ELSIF (CLK'event and CLK = '1') THEN
      rst_int <= rst_reg;
    END IF;

  END PROCESS;

  rst_i <= rst_int;
END GENERATE grst;

--No RST
norst  : IF (C_HAS_RST=0) GENERATE
  rst_i <= '0';
END GENERATE norst;


  gdc    : IF (C_HAS_DATA_COUNT = 1) GENERATE

    gdcb : IF (C_DATA_COUNT_WIDTH > C_RD_PNTR_WIDTH) GENERATE
      DATA_COUNT(C_RD_PNTR_WIDTH-1 DOWNTO 0)                  <= diff_count;
      DATA_COUNT(C_DATA_COUNT_WIDTH-1 DOWNTO C_DATA_COUNT_WIDTH-C_RD_PNTR_WIDTH) <= (OTHERS => '0');
    END GENERATE;

    gdcs : IF (C_DATA_COUNT_WIDTH <= C_RD_PNTR_WIDTH) GENERATE
      DATA_COUNT <= diff_count(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_DATA_COUNT_WIDTH);
    END GENERATE;
  END GENERATE;

  gndc    : IF (C_HAS_DATA_COUNT = 0) GENERATE
      DATA_COUNT <= (OTHERS => '0');
  END GENERATE;

  --Calculate WR_ACK based on C_WR_ACK_LOW parameters
    gwalow : IF (C_WR_ACK_LOW = 0) GENERATE
      WR_ACK <= wr_ack_i;
    END GENERATE gwalow;
    gwahgh : IF (C_WR_ACK_LOW = 1) GENERATE
      WR_ACK <= NOT wr_ack_i;
    END GENERATE gwahgh;

  --Calculate OVERFLOW based on C_OVERFLOW_LOW parameters
    govlow : IF (C_OVERFLOW_LOW = 0) GENERATE
      OVERFLOW <= overflow_i;
    END GENERATE govlow;
    govhgh : IF (C_OVERFLOW_LOW = 1) GENERATE
      OVERFLOW <= NOT overflow_i;
    END GENERATE govhgh;

  --Calculate VALID based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  gvlat1 : IF (C_PRELOAD_LATENCY = 1) GENERATE
    gnvl : IF (C_VALID_LOW = 0) GENERATE
      VALID <= valid_i;
    END GENERATE gnvl;
    gnvh : IF (C_VALID_LOW = 1) GENERATE
      VALID <= NOT valid_i;
    END GENERATE gnvh;
  END GENERATE gvlat1;

  --Calculate UNDERFLOW based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  guflat1 : IF (C_PRELOAD_LATENCY = 1) GENERATE
    gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
      UNDERFLOW <= underflow_i;
    END GENERATE gnul;
    gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
      UNDERFLOW <= NOT underflow_i;
    END GENERATE gnuh;
  END GENERATE guflat1;

  --Insert registered delay based on C_PROG_FULL_REG setting
  gpfnreg: IF (C_PROG_FULL_REG = 0) GENERATE
    PROCESS (power_on_timer, prog_full_noreg)
    BEGIN
      IF (power_on_timer = 0) THEN
        PROG_FULL <= prog_full_noreg;
      ELSE
        PROG_FULL <= C_PROG_FULL_RESET_VAL;
      END IF;
    END PROCESS;
  END GENERATE gpfnreg;

  gpfreg: IF (C_PROG_FULL_REG = 1) GENERATE
    PROCESS (power_on_timer, prog_full_reg)
    BEGIN
      IF (power_on_timer = 0) THEN
        PROG_FULL <= prog_full_reg;
      ELSE
        PROG_FULL <= C_PROG_FULL_RESET_VAL;
      END IF;
    END PROCESS;
  END GENERATE gpfreg;

  --Insert registered delay based on C_PROG_EMPTY_REG setting
  gpenreg: IF (C_PROG_EMPTY_REG = 0) GENERATE
    PROG_EMPTY <= prog_empty_noreg;
  END GENERATE gpenreg;

  gpereg: IF (C_PROG_EMPTY_REG = 1) GENERATE
    PROG_EMPTY <= prog_empty_reg;
  END GENERATE gpereg;

  PROCESS (power_on_timer, full_i)
  BEGIN
    IF (power_on_timer = 0) THEN
      FULL <= full_i;
    ELSE
      FULL <= C_FULL_RESET_VAL;
    END IF;
  END PROCESS;

  PROCESS (power_on_timer, almost_full_i)
  BEGIN
    IF (power_on_timer = 0) THEN
      ALMOST_FULL <= almost_full_i;
    ELSE
      ALMOST_FULL <= C_ALMOST_FULL_RESET_VAL;
    END IF;
  END PROCESS;

  EMPTY         <= empty_i;
  ALMOST_EMPTY  <= almost_empty_i;

-------------------------------------------------------------------------------
-- Synchrounous FIFO using linked lists
-------------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Simulataneous Write and Read
  -- Write process will always happen before the read the process
  -----------------------------------------------------------------------------
  FIFO_PROC : PROCESS (CLK, rst_i)


  VARIABLE head : listptr;
  VARIABLE tail : listptr;
  VARIABLE size : integer                                     := 0;
  VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) :=
    hexstr_to_std_logic_vec( cond_string(C_MEMORY_TYPE /= 1, C_DOUT_RST_VAL, "0"),
                             C_DOUT_WIDTH);
  BEGIN

    ---------------------------------------------------------------------------
    --Calculate the current contents of the FIFO (size)
    -- Warning: This value should only be calculated once each time this
    -- process is entered. It is updated instantaneously.
    ---------------------------------------------------------------------------
    sizeof(head, size);

    -- RESET CONDITIONS
    IF (rst_i = '1') THEN
      -- Whenever user is attempting to write to
      -- a FULL FIFO, the core should report an overflow error, even if
      -- the core is in a RESET condition.
      overflow_i  <= full_i and WR_EN;
      overflow_q  <= full_i and WR_EN;
      overflow_q2 <= full_i and WR_EN;
      wr_ack_q    <= '0';
      wr_ack_q2   <= '0';
      wr_ack_i    <= '0';
      rst_q <= '1';
      power_on_timer <= 0;

      full_i          <= C_FULL_RESET_VAL;
      almost_full_i   <= C_ALMOST_FULL_RESET_VAL;
      prog_full_reg   <= C_PROG_FULL_RESET_VAL;
      prog_full_noreg <= C_PROG_FULL_RESET_VAL;

      --Create new linked list
      newlist(head, tail);

      IF (C_MEMORY_TYPE/=1) THEN         --Most memories asynchronously reset
        data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      END IF;
      IF (C_MEMORY_TYPE=1) THEN         --Block Memory Synchronously resets
        IF (CLK'event AND CLK = '1') THEN
          data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
        END IF;
      END IF;

      --Clear data output queue
      -- Whenever user is attempting to read from
      -- an EMPTY FIFO, the core should report an underflow error, even if
      -- the core is in a RESET condition.
      underflow_i       <= empty_i and RD_EN;
      valid_i         <= '0';
      output_regs_valid <= '0';
      empty_i         <= '1';
      almost_empty_i  <= '1';
      prog_empty_reg  <= '1';
      prog_empty_noreg<= '1';

      diff_count      <= (others => '0');

    ELSIF (CLK'event AND CLK = '1') THEN

      --------------------------------------------------------------------------
      -- Write to FIFO
      -------------------------------------------------------------------------
      --Create registered versions of these internal signals
      wr_ack_q    <= wr_ack_i;
      wr_ack_q2   <= wr_ack_q;
      overflow_q  <= overflow_i;
      overflow_q2 <= overflow_q;
      rst_q <= rst_i;

      --------------------------------------------------------------------------
      -- Read from FIFO
      --------------------------------------------------------------------------
      underflow_i <= '0';
      valid_i     <= '0';

      -------------------------------------------------------------------------
      -- Synchronous FIFO Condition #1 : Writing and not reading
      -------------------------------------------------------------------------
      IF ((WR_EN = '1') AND (RD_EN = '0')) THEN

        --------------------
        -- FIFO is FULL
        --------------------
        IF (size = C_FIFO_WR_DEPTH) THEN
            --Report Overflow and do not acknowledge the write
            overflow_i <= '1';
            wr_ack_i   <= '0';

            --FIFO Remains FULL & ALMOST_FULL
            full_i        <= '1';
            almost_full_i <= '1';

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --No write, so do not update diff_count

        --------------------
        -- FIFO is reporting FULL (Start-up condition)
        --------------------
        ELSIF ((size < C_FIFO_WR_DEPTH) AND (full_i = '1')) THEN
            --Report Overflow and do not acknowledge the write
            overflow_i <= '1';
            wr_ack_i   <= '0';

            --FIFO is not "really" FULL, so clear these values
            full_i        <= '0';
            almost_full_i <= '0';

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO EMPTY in this state can not be determined
            --empty_i        <= ;
            --almost_empty_i <= ;

            --No write, so do not update diff_count

        --------------------
        -- FIFO is one from FULL
        --------------------
        ELSIF (size + 1 = C_FIFO_WR_DEPTH) THEN
            -- This write will succeed, and FIFO will go FULL
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '1';
            almost_full_i <= '1';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);

          --------------------
          --FIFO is two from FULL
          --------------------
          ELSIF size + 2 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go ALMOST_FULL
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '1';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);

          --------------------
          --FIFO is ALMOST EMPTY
          --------------------
          ELSIF size = 1 THEN
            -- This write will succeed, and FIFO will no longer be ALMOST EMPTY
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is leaving ALMOST_EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);

          --------------------
          --FIFO is EMPTY
          --------------------
          ELSIF size = 0 THEN
            -- This write will succeed, and FIFO will no longer be EMPTY
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is leaving EMPTY, but is still ALMOST_EMPTY
            empty_i        <= '0';
            almost_empty_i <= '1';

             --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);

         --------------------
          --FIFO has two or more words in the FIFO, but is not near FULL
          --------------------
          ELSE -- size>1 and size<C_FIFO_DEPTH-2
            -- This write will succeed, and FIFO will no longer be EMPTY
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Report no underflow. Output not valid.
            underflow_i  <= '0';
            valid_i      <= '0';

            --FIFO is no longer EMPTY or ALMOST_EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);

          END IF;


      -------------------------------------------------------------------------
      -- Synchronous FIFO Condition #2 : Reading and not writing
      -------------------------------------------------------------------------
      ELSIF ((WR_EN = '0') AND (RD_EN = '1')) THEN

          --------------------
          --FIFO is EMPTY or reporting EMPTY
          --------------------
          IF ((size = 0) OR (EMPTY_i = '1')) THEN
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '0';

            --Successful read
            underflow_i  <= '1';
            valid_i      <= '0';
            --FIFO is going EMPTY
            empty_i        <= '1';
            almost_empty_i <= '1';

            --No read, so do not update diff_count

          --------------------
          --FIFO is ALMOST EMPTY
          --------------------
          ELSIF (size = 1) THEN
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '0';

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is going EMPTY
            empty_i        <= '1';
            almost_empty_i <= '1';

            --This read will succeed, but it's the last one
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);

        --------------------
        -- FIFO is two from EMPTY
        --------------------
        ELSIF (size = 2) THEN
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '0';

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is going ALMOST_EMPTY
            empty_i        <= '0';
            almost_empty_i <= '1';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);

        --------------------
        -- FIFO is one from FULL
        --------------------
        ELSIF (size + 1 = C_FIFO_WR_DEPTH) THEN
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '0';

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);

        --------------------
        -- FIFO is FULL
        --------------------
        ELSIF (size = C_FIFO_WR_DEPTH) THEN
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '1';

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);



          --------------------
          --FIFO has two or more words in the FIFO, but is not near FULL
          --------------------
          ELSE -- size>2 and size<C_FIFO_DEPTH-1
            --No write attempted, but a read will succeed
            overflow_i    <= '0';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '0';

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is going EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --This read will succeed, but it's the last one
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);

          END IF;


      -------------------------------------------------------------------------
      -- Synchronous FIFO Condition #3 : Reading and writing
      -------------------------------------------------------------------------
      ELSIF ((WR_EN = '1') AND (RD_EN = '1')) THEN

        --------------------
        -- FIFO is FULL
        --------------------
        IF (size = C_FIFO_WR_DEPTH) THEN
            -- Write to FULL FIFO will fail
            overflow_i    <= '1';
            wr_ack_i      <= '0';
            full_i        <= '0';
            almost_full_i <= '1';

            -- Read will be successful.
            underflow_i  <= '0';
            valid_i      <= '1';

            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size-1),C_RD_PNTR_WIDTH);

        --------------------
        -- FIFO is reporting FULL, but it is empty
        --  (this is a special case, when coming out of RST)
        --------------------
        ELSIF ((size = 0) AND (full_i = '1')) THEN
            -- Write to FULL FIFO will fail
            overflow_i    <= '1';
            wr_ack_i      <= '0';

            --Clear the FULL flags for normal use
            full_i        <= '0';
            almost_full_i <= '0';

            -- Read will be unsuccessful, because we're empty
            underflow_i  <= '1';
            valid_i      <= '0';

            --FIFO EMPTY in this state can not be determined
            empty_i        <= '1';
            almost_empty_i <= '1';

            --Do Not Read

            --No read or write, don't update data count

        --------------------
        -- FIFO is one from FULL
        --------------------
        ELSIF (size + 1 = C_FIFO_WR_DEPTH) THEN
            -- Write will be successful
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '1';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Simulaneous read and write, no change in diff_count

          --------------------
          --FIFO is ALMOST EMPTY
          --------------------
          ELSIF (size = 1) THEN
            -- Write will be successful
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '1';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Simulaneous read and write, no change in diff_count

          --------------------
          --FIFO is EMPTY
          --------------------
          ELSIF ((size = 0) OR (EMPTY_i = '1')) THEN
            -- Write will be successful
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Read will fail, because core is reporting EMPTY
            underflow_i  <= '1';
            valid_i      <= '0';
            --FIFO is no longer EMPTY
            empty_i        <= '0';
            almost_empty_i <= '1';

            --Update count (for DATA_COUNT output)
            diff_count <= conv_std_logic_vector((size+1),C_RD_PNTR_WIDTH);


          --------------------
          --FIFO has two or more words in the FIFO, but is not near FULL
          --------------------
          ELSE -- size>1 and size<C_FIFO_DEPTH-1
            -- Write will be successful
            overflow_i    <= '0';
            wr_ack_i      <= '1';
            full_i        <= '0';
            almost_full_i <= '0';
            add(head, tail, DIN( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );

            --Successful read
            underflow_i  <= '0';
            valid_i      <= '1';
            --FIFO is nowhere near EMPTY
            empty_i        <= '0';
            almost_empty_i <= '0';

            --Update read
            read(tail, data( (C_SMALLER_DATA_WIDTH)-1 DOWNTO 0 ) );
            remove(head, tail);

            --Simulaneous read and write, no change in diff_count

          END IF;

      -------------------------------------------------------------------------
      -- Synchronous FIFO Condition #4 : Not reading or writing
      -------------------------------------------------------------------------
      ELSE -- ((WR_EN = '0') AND (RD_EN = '0'))

        IF (size = C_FIFO_WR_DEPTH) THEN  --FULL
           -- No write
           overflow_i    <= '0';
           wr_ack_i      <= '0';
           full_i        <= '1';
           almost_full_i <= '1';

           --No read
           underflow_i    <= '0';
           valid_i        <= '0';
           empty_i        <= '0';
           almost_empty_i <= '0';

        ELSIF (size >= C_FIFO_WR_DEPTH - 1) THEN  --ALMOST_FULL
           -- No write
           overflow_i    <= '0';
           wr_ack_i      <= '0';
           full_i        <= '0';
           almost_full_i <= '1';

           --No read
           underflow_i    <= '0';
           valid_i        <= '0';
           empty_i        <= '0';
           almost_empty_i <= '0';

        ELSIF (size = 1) THEN  -- ALMOST_EMPTY
           -- No write
           overflow_i    <= '0';
           wr_ack_i      <= '0';
           full_i        <= '0';
           almost_full_i <= '0';

           --No read
           underflow_i    <= '0';
           valid_i        <= '0';
           empty_i        <= '0';
           almost_empty_i <= '1';

        ELSIF (size = 0) THEN  -- EMPTY
           -- No write
           overflow_i    <= '0';
           wr_ack_i      <= '0';
           full_i        <= '0';
           almost_full_i <= '0';

           --No read
           underflow_i    <= '0';
           valid_i        <= '0';
           empty_i        <= '1';
           almost_empty_i <= '1';

        ELSE  -- Not near FULL or EMPTY
           -- No write
           overflow_i    <= '0';
           wr_ack_i      <= '0';
           full_i        <= '0';
           almost_full_i <= '0';

           --No read
           underflow_i    <= '0';
           valid_i        <= '0';
           empty_i        <= '0';
           almost_empty_i <= '0';

        END IF;



      END IF;  -- WR_EN, RD_EN



      -------------------------------------------------------------------------
      -- Programmable FULL flags
      -------------------------------------------------------------------------
        IF (C_PROG_FULL_TYPE /= 0) THEN

          --------------------------------
          -- Prog FULL Type 3 (single input port)
          --------------------------------
          IF (C_PROG_FULL_TYPE = 3) THEN
            --If we are at or above the PROG_FULL_THRESH, or we will be
            --  next clock cycle, then assert PROG_FULL
            --Since this is a FIFO with common clocks, we can accurately
            --predict the outcome using WR_EN and RD_EN.
            IF (
              (size >= conv_integer(PROG_FULL_THRESH)) OR
              ((size = conv_integer(PROG_FULL_THRESH)-1) AND WR_EN = '1'
               AND RD_EN = '0')
              ) THEN
                prog_full_noreg <= '1';
            END IF;

            IF (((size = conv_integer(PROG_FULL_THRESH)) AND RD_EN = '1'
               AND WR_EN = '0') OR (rst_q='1' AND rst_i='0')) THEN
                prog_full_noreg <= '0';
            END IF;

          --------------------------------
          -- Prog FULL Type 4 (dual input ports)
          --------------------------------
          ELSIF (C_PROG_FULL_TYPE = 4) THEN
            --If we are at or above the PROG_FULL_THRESH, or we will be
            --  next clock cycle, then assert PROG_FULL
            --Since this is a FIFO with common clocks, we can accurately
            --predict the outcome using WR_EN and RD_EN.
             IF (
               ((size = conv_integer(PROG_FULL_THRESH_ASSERT)-1) AND WR_EN = '1'
                AND RD_EN = '0')
               ) THEN
                 prog_full_noreg <= '1';
             END IF;
             IF (((size = conv_integer(PROG_FULL_THRESH_NEGATE)) AND RD_EN = '1'
                AND WR_EN = '0') OR (rst_q='1' AND rst_i='0')) THEN
                 prog_full_noreg <= '0';
             END IF;

          --------------------------------
          -- Prog FULL Type 2 (dual constants)
          --------------------------------
          ELSIF (C_PROG_FULL_TYPE = 2) THEN
            --If we will be going at or above the C_PROG_FULL_ASSERT threshold
            -- on the next clock cycle, then assert PROG_FULL
            --Since this is a FIFO with common clocks, we can accurately
            --predict the outcome using WR_EN and RD_EN.
            IF ((size = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1'
                AND RD_EN = '0') THEN
                prog_full_noreg <= '1';
            -- If we will be going below C_PROG_FULL_NEGATE on the next clock
            -- cycle, then de-assert PROG_FULL
            ELSIF ((size = C_PROG_FULL_THRESH_NEGATE_VAL) AND RD_EN = '1'
                   AND WR_EN = '0') THEN
                prog_full_noreg <= '0';
            -- If we are at or above the C_PROG_FULL_ASSERT, then assert
            -- PROG_FULL
            ELSIF (size >= C_PROG_FULL_THRESH_ASSERT_VAL) THEN
                prog_full_noreg <= '1';
            --If we are below the C_PROG_FULL_NEGATE, then de-assert PROG_FULL
            ELSIF (size < C_PROG_FULL_THRESH_NEGATE_VAL) THEN
                prog_full_noreg <= '0';
            END IF;

          --------------------------------
          -- Prog FULL Type 1 (single constant)
          --------------------------------
          ELSE
            IF (
              (size >= C_PROG_FULL_THRESH_ASSERT_VAL) OR
              ((size = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1'
               AND RD_EN = '0')
              ) THEN
                prog_full_noreg <= '1';
            END IF;

            IF (((size = C_PROG_FULL_THRESH_ASSERT_VAL) AND RD_EN = '1'
               AND WR_EN = '0') OR (rst_q='1' AND rst_i='0')) THEN
                prog_full_noreg <= '0';
            END IF;

          END IF; --C_PROG_FULL_TYPE

          if (rst_q='1' and rst_i='0') then
            prog_full_reg <= '0';
          else
            prog_full_reg <= prog_full_noreg;
          end if;

        END IF;  --C_PROG_FULL_TYPE /= 0


    ----------------------------------------------------------------------------
    -- Programmable EMPTY Flags
    ----------------------------------------------------------------------------

        IF C_PROG_EMPTY_TYPE /= 0 THEN


          --------------------------------
          -- Prog EMPTY Type 3 (single input port)
          --------------------------------
          IF C_PROG_EMPTY_TYPE = 3 THEN
            --If we are at or below the PROG_EMPTY_THRESH, or we will be
            --  the next clock cycle, then assert PROG_EMPTY
            IF (
              (size = conv_integer(PROG_EMPTY_THRESH)+1) AND RD_EN = '1' AND WR_EN = '0') THEN
              prog_empty_noreg      <= '1';
            ELSIF ((size = conv_integer(PROG_EMPTY_THRESH)) AND WR_EN = '1' AND RD_EN = '0') THEN
              prog_empty_noreg      <= '0';
            ELSIF ((size <= conv_integer(PROG_EMPTY_THRESH)) AND RD_EN = '1') THEN
              prog_empty_noreg  <= '1';
            END IF; --C_PROG_EMPTY_TYPE = 3


          --------------------------------
          -- Prog EMPTY Type 4 (dual input ports)
          --------------------------------
          ELSIF C_PROG_EMPTY_TYPE = 4 THEN
            --If we are at or below the PROG_EMPTY_THRESH, or we will be
            --  the next clock cycle, then assert PROG_EMPTY
            IF (
              ((size = conv_integer(PROG_EMPTY_THRESH_ASSERT)+1) AND RD_EN = '1'
               AND WR_EN = '0')
              ) THEN
                prog_empty_noreg      <= '1';
            END IF;

            IF (
              ((size = conv_integer(PROG_EMPTY_THRESH_NEGATE)) AND WR_EN = '1'
               AND RD_EN = '0')) THEN
                prog_empty_noreg      <= '0';
            END IF; --C_PROG_EMPTY_TYPE = 4


          --------------------------------
          -- Prog EMPTY Type 2 (dual constants)
          --------------------------------
          ELSIF C_PROG_EMPTY_TYPE = 2 THEN

            --If we will be going at or below the C_PROG_EMPTY_ASSERT threshold
            -- on the next clock cycle, then assert PROG_EMPTY
            IF ((size = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) AND RD_EN = '1'
                AND WR_EN = '0') THEN
                prog_empty_noreg          <= '1';
            -- If we will be going above C_PROG_EMPTY_NEGATE on the next clock
            -- cycle, then de-assert PROG_EMPTY
            ELSIF ((size = C_PROG_EMPTY_THRESH_NEGATE_VAL) AND WR_EN = '1'
                   AND RD_EN = '0') THEN
                prog_empty_noreg          <= '0';
            -- If we are at or below the C_PROG_EMPTY_ASSERT, then assert
            -- PROG_EMPTY
            ELSIF (size <= C_PROG_EMPTY_THRESH_ASSERT_VAL) THEN
                prog_empty_noreg          <= '1';
            -- If we are above the C_PROG_EMPTY_THRESH_NEGATE, then de-assert
            -- PROG_EMPTY
            ELSIF (size > C_PROG_EMPTY_THRESH_NEGATE_VAL) THEN
                prog_empty_noreg          <= '0';
            END IF;


          --------------------------------
          -- Prog EMPTY Type 1 (single constant)
          --------------------------------
          ELSIF C_PROG_EMPTY_TYPE = 1 THEN
            --If we are at or below the PROG_EMPTY_THRESH, or we will be
            --  the next clock cycle, then assert PROG_EMPTY
            IF (
              (size = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) AND RD_EN = '1' AND WR_EN = '0') THEN
                prog_empty_noreg      <= '1';
            END IF;
            IF ((size = C_PROG_EMPTY_THRESH_ASSERT_VAL) AND WR_EN = '1' AND RD_EN = '0') THEN
                prog_empty_noreg      <= '0';
            END IF;

          END IF; -- C_PROG_EMPTY_TYPE

          prog_empty_reg <= prog_empty_noreg;

        END IF; --C_PROG_EMPTY_TYPE /= 0

      IF (power_on_timer >= 2) THEN
        data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      END IF;

      IF (power_on_timer > 0) THEN
        power_on_timer <= power_on_timer - 1;
      ELSE
        power_on_timer <= 0;
      END IF;

    END IF;	--CLK

    DOUT <= data;

  END PROCESS;

END behavioral;



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Asynchronous FIFO Behavioral Model for FIFO16 Implementation
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Library Declaration
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;
-- USE IEEE.std_logic_arith.ALL;

LIBRARY work;
USE work.iputils_std_logic_unsigned.ALL;
USE work.iputils_std_logic_arith.ALL;
USE work.iputils_conv.ALL;
USE work.iputils_misc.ALL;

-------------------------------------------------------------------------------
-- Entity Declaration
-------------------------------------------------------------------------------
ENTITY fifo_generator_v2_2_bhv_fifo16 IS

  GENERIC (
    ----------------------------------------------------------------------------
    -- Generic Declarations
    ----------------------------------------------------------------------------
    C_COMMON_CLOCK                 :    integer := 0;
    C_DIN_WIDTH                    :    integer := 8;
    C_DOUT_RST_VAL                 :    string  := "";
    C_DOUT_WIDTH                   :    integer := 8;
    C_ENABLE_RLOCS                 :    integer := 0;
    C_FAMILY                       :    string  := "";
    C_HAS_ALMOST_FULL              :    integer := 0;
    C_HAS_ALMOST_EMPTY             :    integer := 0;
    C_HAS_OVERFLOW                 :    integer := 0;
    C_HAS_RD_DATA_COUNT            :    integer := 2;
    C_HAS_VALID                    :    integer := 0;
    C_HAS_RST                      :    integer := 1;
    C_HAS_UNDERFLOW                :    integer := 0;
    C_HAS_WR_ACK                   :    integer := 0;
    C_HAS_WR_DATA_COUNT            :    integer := 2;
    C_MEMORY_TYPE                  :    integer := 1;
    C_OPTIMIZATION_MODE            :    integer := 0;
    C_WR_RESPONSE_LATENCY          :    integer := 1;
    C_OVERFLOW_LOW                 :    integer := 0;
    C_PRELOAD_REGS                 :    integer := 0;
    C_PRELOAD_LATENCY              :    integer := 1;
    C_PRIM_FIFO_TYPE               :    integer := 512;
    C_PROG_EMPTY_TYPE              :    integer := 0;
    C_PROG_EMPTY_THRESH_ASSERT_VAL :    integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL :    integer := 0;
    C_PROG_FULL_TYPE               :    integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  :    integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  :    integer := 0;
    C_VALID_LOW                    :    integer := 0;
    C_RD_DATA_COUNT_WIDTH          :    integer := 0;
    C_RD_DEPTH                     :    integer := 256;
    C_RD_PNTR_WIDTH                :    integer := 8;
    C_UNDERFLOW_LOW                :    integer := 0;
    C_USE_FIFO16_FLAGS              :    integer := 0;
    C_WR_ACK_LOW                   :    integer := 0;
    C_WR_DATA_COUNT_WIDTH          :    integer := 0;
    C_WR_DEPTH                     :    integer := 256;
    C_WR_PNTR_WIDTH                :    integer := 8
    );
  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    DIN                            : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH              : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_ASSERT       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_EMPTY_THRESH_NEGATE       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH               : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_ASSERT        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    PROG_FULL_THRESH_NEGATE        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
    CLK                            : IN std_logic;
    RD_CLK                         : IN std_logic;
    RD_EN                          : IN std_logic;
    RST                            : IN std_logic;
    WR_CLK                         : IN std_logic;
    WR_EN                          : IN std_logic;

    ALMOST_EMPTY  : OUT std_logic := '1';
    ALMOST_FULL   : OUT std_logic := '1';
    DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY         : OUT std_logic := '1';
    FULL          : OUT std_logic := '1';
    OVERFLOW      : OUT std_logic := '0';
    PROG_EMPTY    : OUT std_logic := '1';
    PROG_FULL     : OUT std_logic := '1';
    VALID         : OUT std_logic := '0';
    RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                          (OTHERS => '0');
    UNDERFLOW     : OUT std_logic := '0';
    WR_ACK        : OUT std_logic := '0';
    WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0) :=
                          (OTHERS => '0')
    );



END fifo_generator_v2_2_bhv_fifo16;


-------------------------------------------------------------------------------
-- Definition of Ports
-- DIN : Input data bus for the fifo.
-- DOUT : Output data bus for the fifo.
-- AINIT : Asynchronous Reset for the fifo.
-- WR_EN : Write enable signal.
-- WR_CLK : Write Clock.
-- FULL : Full signal.
-- ALMOST_FULL : One space left.
-- WR_ACK : Last write acknowledged.
-- WR_ERR : Last write rejected.
-- WR_COUNT : Number of data words in fifo(synchronous to WR_CLK)
-- Rd_EN : Read enable signal.
-- RD_CLK : Read Clock.
-- EMPTY : Empty signal.
-- ALMOST_EMPTY: One sapce left
-- VALID : Last read acknowledged.
-- RD_ERR : Last read rejected.
-- RD_COUNT : Number of data words in fifo(synchronous to RD_CLK)
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Architecture Heading
-------------------------------------------------------------------------------
ARCHITECTURE behavioral OF fifo_generator_v2_2_bhv_fifo16 IS



-------------------------------------------------------------------------------
-- actual_fifo_depth
-- Returns the actual depth of the FIFO (may differ from what the user specified)
--
-- The FIFO depth is always represented as 2^n (16,32,64,128,256)
-- However, the ACTUAL fifo depth may be 2^n or (2^n - 1) depending on certain
-- options. This function returns the ACTUAL depth of the fifo, as seen by
-- the user.
--
-- The FIFO depth remains as 2^n when any of the following conditions are true:
-- *C_PRELOAD_REGS=1 AND C_PRELOAD_LATENCY=1 (preload output register adds 1
-- word of depth to the FIFO)
-------------------------------------------------------------------------------
  FUNCTION actual_fifo_depth(c_fifo_depth : integer; C_PRELOAD_REGS : integer; C_PRELOAD_LATENCY : integer) RETURN integer IS
  BEGIN
    IF (C_PRELOAD_REGS = 1 AND C_PRELOAD_LATENCY = 1) THEN
      RETURN c_fifo_depth;
    ELSE
      RETURN c_fifo_depth-1;
    END IF;
  END actual_fifo_depth;

-------------------------------------------------------------------------------
-- fifo16_fifo_depth
--   This is the depth of the memory used in the FIFO for FIFO16
--   implementation. The depth calculation takes into account the number of
--   cascaded primitives.
-------------------------------------------------------------------------------
  FUNCTION fifo16_fifo_depth (c_fifo_depth : integer; C_PRIM_FIFO_TYPE : integer; C_USE_FIFO16_FLAGS : integer) RETURN integer IS
    VARIABLE actual_depth : integer;
    VARIABLE num_fifo     : integer := 0;  --Number of primitives
  BEGIN
    --C_USE_FIFO16_FLAGS
    -- 0 : FIFO16 using AlmostFull flag as FIFO Generator FULL
    -- 1 : FIFO16 using Full flag as FIFO Generator FULL

    num_fifo := ((c_fifo_depth-1)/C_PRIM_FIFO_TYPE) + 1;
    if (c_fifo_depth>=C_PRIM_FIFO_TYPE) then
      if (C_USE_FIFO16_FLAGS /= 0) then
        -----------------------------------------------------------------------
        -- Each primitive follows the following rules:
        --
        -- Each FIFO primitive, by default, is C_PRIM_FIFO_TYPE words deep.
        --
        -- If there is only one primitive, +1 words of depth since it is a
        -- latency one FIFO using the real FULL.
        --
        -- If there is more than one primitive, the first FIFO (write FIFO)
        -- uses the real FULL, but is a first-word fall-through FIFO, so it has
        -- an additional +2 words of depth.
        --
        -- If there is more than one primitive, the last FIFO (read FIFO) is a
        -- latency-one FIFO using the ALMOSTFULL output. It has an offset of 5,
        -- and therefore a reduction of -5 words from the depth.
        --
        -- If there is more than two primitives, all chained FIFOs except the
        -- first (write FIFO) and last (read FIFO) are First-word Fall-through
        -- FIFOs using the ALMOSTFULL output. FWFT FIFOs have an offset of 6,
        -- but the extra register inside the FWFT FIFO adds 1 to the depth,
        -- resulting in a net depth change of -5 words.
        --
        -- Example: Prim=512, Depth=2048
        --  Prim 1 (write interface) = 507
        --  Prim 2 = 507
        --  Prim 3 = 507
        --  Prim 4 (read interface) = 514
        --  Actual Depth = 507 + 507 + 507 + 514 = 2035
        --
        -- Example: Prim=512, Depth=512
        --  Prim 1 (write interface) = 513
        --  Actual Depth = 513
        -----------------------------------------------------------------------
        if (num_fifo=1) then
          actual_depth := C_PRIM_FIFO_TYPE+1;
        elsif (num_fifo>=2) then
          -- Write FIFO + Middle FIFOs + Read FIFO
          actual_depth := (C_PRIM_FIFO_TYPE+2) + ((num_fifo-2)*(C_PRIM_FIFO_TYPE-5)) + (C_PRIM_FIFO_TYPE-5);
        end if;
      else
        -- actual_depth := ((C_PRIM_FIFO_TYPE-4)*num_fifo);
        actual_depth := ((C_PRIM_FIFO_TYPE-5)*num_fifo);
      end if;
    else
      actual_depth := c_fifo_depth-1;
    end if;

    RETURN actual_depth;

  END fifo16_fifo_depth;

--------------------------------------------------------------------------------
-- Derived Constants
--------------------------------------------------------------------------------
  CONSTANT C_ALMOST_FULL_RESET_VAL : std_logic := '0';
  CONSTANT C_FULL_RESET_VAL        : std_logic := '0';


  --If C_USE_FIFO16_FLAGS is set, and PROG_FULL_TYPE=1, then the AlmostFull
  --flag of the FIFO16 is used for Programmable FULL, and the reset value will
  --be 0.  For all other cases, the reset value is 1.
  constant tmp_prog_full_reset_val : std_logic_vector(0 downto 0) := int_2_std_logic_vector(if_then_else(C_USE_FIFO16_FLAGS=1 and C_PROG_FULL_TYPE=1, 0, 1), 1);
  constant C_PROG_FULL_RESET_VAL   : std_logic := tmp_prog_full_reset_val(0);

  CONSTANT C_FIFO_WR_DEPTH : integer := fifo16_fifo_depth(C_WR_DEPTH,C_PRIM_FIFO_TYPE,C_USE_FIFO16_FLAGS);
  CONSTANT C_FIFO_RD_DEPTH : integer := fifo16_fifo_depth(C_RD_DEPTH,C_PRIM_FIFO_TYPE,C_USE_FIFO16_FLAGS);

  CONSTANT C_SMALLER_PNTR_WIDTH : integer := get_lesser(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_SMALLER_DEPTH      : integer := get_lesser(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_SMALLER_DATA_WIDTH : integer := get_lesser(C_DIN_WIDTH, C_DOUT_WIDTH);
  CONSTANT C_LARGER_PNTR_WIDTH  : integer := get_greater(C_WR_PNTR_WIDTH, C_RD_PNTR_WIDTH);
  CONSTANT C_LARGER_DEPTH       : integer := get_greater(C_FIFO_WR_DEPTH, C_FIFO_RD_DEPTH);
  CONSTANT C_LARGER_DATA_WIDTH  : integer := get_greater(C_DIN_WIDTH, C_DOUT_WIDTH);

  --The write depth to read depth ratio is   C_RATIO_W : C_RATIO_R
  CONSTANT C_RATIO_W : integer := if_then_else( (C_WR_DEPTH > C_RD_DEPTH), (C_WR_DEPTH/C_RD_DEPTH), 1);
  CONSTANT C_RATIO_R : integer := if_then_else( (C_RD_DEPTH > C_WR_DEPTH), (C_RD_DEPTH/C_WR_DEPTH), 1);

  CONSTANT counter_depth_wr : integer := C_FIFO_WR_DEPTH + 1;
  CONSTANT counter_depth_rd : integer := C_FIFO_RD_DEPTH + 1;

-------------------------------------------------------------------------------
-- Internal Signals
-------------------------------------------------------------------------------
  SIGNAL wr_point     : integer   := 0;
  SIGNAL rd_point     : integer   := 0;
  SIGNAL rd_reg0      : integer   := 0;
  SIGNAL rd_reg1      : integer   := 0;
  SIGNAL wr_reg0      : integer   := 0;
  SIGNAL wr_reg1      : integer   := 0;
  SIGNAL empty_i      : std_logic := '1';
  signal almost_empty_i : std_logic := '1';
  SIGNAL full_i       : std_logic := '1';
  signal almost_full_i : std_logic := '1';
  SIGNAL prog_empty_i : std_logic := '1';
  SIGNAL prog_full_i  : std_logic := '1';
  SIGNAL prog_empty_q : std_logic := '1';
  SIGNAL prog_full_q  : std_logic := '1';

  SIGNAL rd_rst_i : std_logic;
  SIGNAL wr_rst_i : std_logic;

  SIGNAL wr_diff_count   : std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0)       := (OTHERS => '0');
  SIGNAL rd_diff_count   : std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0)       := (OTHERS => '0');

  SIGNAL wr_ack_i    : std_logic := '0';
  SIGNAL wr_ack_q    : std_logic := '0';
  SIGNAL wr_ack_q2   : std_logic := '0';
  SIGNAL overflow_i  : std_logic := '0';
  SIGNAL overflow_q  : std_logic := '0';
  SIGNAL overflow_q2 : std_logic := '0';

  SIGNAL valid_i     : std_logic := '0';
  SIGNAL underflow_i : std_logic := '0';

  SIGNAL output_regs_valid : std_logic := '0';

  signal message_complete : boolean := false;

-------------------------------------------------------------------------------
-- Linked List types
-------------------------------------------------------------------------------
  TYPE listtyp;
  TYPE listptr IS ACCESS listtyp;
  TYPE listtyp IS RECORD
                    data  : std_logic_vector(C_SMALLER_DATA_WIDTH - 1 DOWNTO 0);
                    older : listptr;
                    newer : listptr;
                  END RECORD;


-------------------------------------------------------------------------------
-- Processes for linked list implementation
-------------------------------------------------------------------------------
  --Create a new linked list
  PROCEDURE newlist (head : INOUT listptr; tail : INOUT listptr) IS
  BEGIN
    head := NULL;
    tail := NULL;
  END;  -- procedure newlist;

  --Add a data element to a linked list
  PROCEDURE add (head : INOUT listptr; tail : INOUT listptr; data : IN std_logic_vector) IS
    VARIABLE oldhead  :       listptr;
    VARIABLE newhead  :       listptr;
  BEGIN
    --Create a pointer to the existing head, if applicable
    IF (head /= NULL) THEN
      oldhead       := head;
    END IF;
    --Create a new node for the list
    newhead         := NEW listtyp;
    --Make the new node point to the old head
    newhead.older   := oldhead;
    --Make the old head point back to the new node (for doubly-linked list)
    IF (head /= NULL) THEN
      oldhead.newer := newhead;
    END IF;
    --Put the data into the new head node
    newhead.data    := data;
    --If the new head we just created is the only node in the list, make the tail point to it
    IF (newhead.older = NULL) THEN
      tail          := newhead;
    END IF;
    --Return the new head pointer
    head            := newhead;
  END;  -- procedure; -- add;


  --Read the data from the tail of the linked list
  PROCEDURE read (tail : INOUT listptr; data : OUT std_logic_vector) IS
  BEGIN
    data := tail.data;
  END;  -- procedure; -- read;


  --Remove the tail from the linked list
  PROCEDURE remove (head : INOUT listptr; tail : INOUT listptr) IS
    VARIABLE oldtail     :       listptr;
    VARIABLE newtail     :       listptr;
  BEGIN
    --Make a copy of the old tail pointer
    oldtail         := tail;
    --If there is no newer node, then set the tail pointer to nothing (list is empty)
    IF (oldtail.newer = NULL) THEN
      newtail       := NULL;
      --otherwise, make the next newer node the new tail, and make it point to nothing older
    ELSE
      newtail       := oldtail.newer;
      newtail.older := NULL;
    END IF;
    --Clean up the memory for the old tail node
    DEALLOCATE(oldtail);
    --If the new tail is nothing, then we have an empty list, and head should also be set to nothing
    IF (newtail = NULL) THEN
      head          := NULL;
    END IF;
    --Return the new tail
    tail            := newtail;
  END;  -- procedure; -- remove;


  --Calculate the size of the linked list
  PROCEDURE sizeof (head : INOUT listptr; size : OUT integer) IS
    VARIABLE curlink     :       listptr;
    VARIABLE tmpsize     :       integer := 0;
  BEGIN
    --If head is null, then there is nothing in the list to traverse
    IF (head /= NULL) THEN
      --start with the head node (which implies at least one node exists)
      curlink                            := head;
      tmpsize                            := 1;
      --Loop through each node until you find the one that points to nothing (the tail)
      WHILE (curlink.older /= NULL) LOOP
        tmpsize                          := tmpsize + 1;
        curlink                          := curlink.older;
      END LOOP;
    END IF;
    --Return the number of nodes
    size                                 := tmpsize;
  END;  -- procedure; -- sizeof;


  -- converts integer to specified length std_logic_vector : dropping least
  -- significant bits if integer is bigger than what can be represented by
  -- the vector
  FUNCTION count( fifo_count    : IN integer;
                  pointer_width : IN integer;
                  counter_width : IN integer
                  ) RETURN std_logic_vector IS
    VARIABLE temp               :    std_logic_vector(pointer_width-1 DOWNTO 0)   := (OTHERS => '0');
    VARIABLE output             :    std_logic_vector(counter_width - 1 DOWNTO 0) := (OTHERS => '0');

  BEGIN

    temp     := CONV_STD_LOGIC_VECTOR(fifo_count, pointer_width);
    IF (counter_width <= pointer_width) THEN
      output := temp(pointer_width - 1 DOWNTO pointer_width - counter_width);
    ELSE
      output := temp(counter_width - 1 DOWNTO 0);
    END IF;
    RETURN output;
  END count;

-------------------------------------------------------------------------------
-- architecture begins here
-------------------------------------------------------------------------------
BEGIN



-------------------------------------------------------------------------------
-- Prepare input signals
-------------------------------------------------------------------------------
  rd_rst_i <= RST;
  wr_rst_i <= RST;



  --Calculate WR_ACK based on C_WR_RESPONSE_LATENCY and C_WR_ACK_LOW parameters
    gwalow : IF (C_WR_ACK_LOW = 0) GENERATE
      --WR_ACK <= wr_ack_q;
      WR_ACK <= wr_ack_i;
    END GENERATE gwalow;
    gwahgh : IF (C_WR_ACK_LOW = 1) GENERATE
      --WR_ACK <= NOT wr_ack_q;
      WR_ACK <= NOT wr_ack_i;
    END GENERATE gwahgh;

  --Calculate OVERFLOW based on C_WR_RESPONSE_LATENCY and C_OVERFLOW_LOW parameters
    govlow : IF (C_OVERFLOW_LOW = 0) GENERATE
      --OVERFLOW <= overflow_q;
      OVERFLOW <= overflow_i;
    END GENERATE govlow;
    govhgh : IF (C_OVERFLOW_LOW = 1) GENERATE
      --OVERFLOW <= NOT overflow_q;
      OVERFLOW <= NOT overflow_i;
    END GENERATE govhgh;

  --Calculate VALID based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  gvlat1 : IF (C_PRELOAD_LATENCY = 1) GENERATE
    gnvl : IF (C_VALID_LOW = 0) GENERATE
      VALID <= valid_i;
    END GENERATE gnvl;
    gnvh : IF (C_VALID_LOW = 1) GENERATE
      VALID <= NOT valid_i;
    END GENERATE gnvh;
  END GENERATE gvlat1;

  --Calculate UNDERFLOW based on C_PRELOAD_LATENCY and C_VALID_LOW settings
  guflat1 : IF (C_PRELOAD_LATENCY = 1) GENERATE
    gnul  : IF (C_UNDERFLOW_LOW = 0) GENERATE
      UNDERFLOW <= underflow_i;
    END GENERATE gnul;
    gnuh  : IF (C_UNDERFLOW_LOW = 1) GENERATE
      UNDERFLOW <= NOT underflow_i;
    END GENERATE gnuh;
  END GENERATE guflat1;

  RD_DATA_COUNT <= rd_diff_count(C_RD_PNTR_WIDTH-1 DOWNTO C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH);
  WR_DATA_COUNT <= wr_diff_count(C_WR_PNTR_WIDTH-1 DOWNTO C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH);

  uffn: if (C_USE_FIFO16_FLAGS=0) generate
    FULL          <= full_i;
  end generate uffn;

  uff: if (C_USE_FIFO16_FLAGS=1) generate
    fprc: process (WR_CLK, CLK, wr_rst_i)
    begin  -- process fprc
      if (wr_rst_i='1') then
        FULL          <= '0';           --FIFO16 FULL resets to 0
      elsif (WR_CLK'event and WR_CLK = '1') or (CLK'event and CLK='1') then  -- rising clock edge
        FULL          <= full_i;
      end if;
    end process fprc;
  end generate uff;


  EMPTY         <= empty_i;
  ALMOST_FULL   <= almost_full_i;
  ALMOST_EMPTY  <= almost_empty_i;

-------------------------------------------------------------------------------
-- Asynchrounous FIFO using linked lists
-------------------------------------------------------------------------------
  FIFO_PROC : PROCESS (WR_CLK, RD_CLK, CLK, rd_rst_i, wr_rst_i)

    VARIABLE head : listptr;
    VARIABLE tail : listptr;
    VARIABLE size : integer                                     := 0;
    VARIABLE data : std_logic_vector(c_dout_width - 1 DOWNTO 0) := (OTHERS => '0');

  BEGIN

    --Calculate the current contents of the FIFO (size)
    -- Warning: This value should only be calculated once each time this
    -- process is entered. It is updated instantaneously.
    sizeof(head, size);


    -- RESET CONDITIONS
    IF wr_rst_i = '1' THEN
      assert (message_complete) report "Warning: When using Virtex-4 built-in FIFO configurations for the FIFO Generator, it is strongly recommended that you use the structural simulation model instead of the behavioral model. This will ensure accurate behavior and latencies during simulation. You can enable this from CORE Generator by selecting Project -> Project Options -> Generation tab -> Structural Simulation. See the FIFO Generator User Guide for more information." severity NOTE;
      message_complete <= true;
      overflow_i  <= '0';
      overflow_q  <= '0';
      overflow_q2 <= '0';
      wr_ack_q    <= '0';
      wr_ack_q2   <= '0';
      wr_ack_i    <= '0';

      full_i          <= C_FULL_RESET_VAL;         --'1';
      almost_full_i     <= C_ALMOST_FULL_RESET_VAL;  --'1';
      PROG_FULL       <= C_PROG_FULL_RESET_VAL;    --'1';
      prog_full_i     <= C_PROG_FULL_RESET_VAL;    --'1';
      prog_full_q     <= C_PROG_FULL_RESET_VAL;    --'1';

      wr_point <= 0;
      rd_reg0  <= 0;
      rd_reg1  <= 0;
      wr_diff_count <= (others => '0');

      --Create new linked list
      newlist(head, tail);

      --Clear data output queue
--       data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      data := (OTHERS => '0');

      ---------------------------------------------------------------------------
      -- Write to FIFO
      ---------------------------------------------------------------------------
    ELSIF ((WR_CLK'event AND WR_CLK = '1') OR (CLK'event AND CLK = '1')) THEN

      --Create registered versions of these internal signals
      wr_ack_q    <= wr_ack_i;
      wr_ack_q2   <= wr_ack_q;
      overflow_q  <= overflow_i;
      overflow_q2 <= overflow_q;

      rd_reg0 <= rd_point;
      rd_reg1 <= rd_reg0;

      wr_diff_count <= conv_std_logic_vector((size/C_RATIO_R), C_WR_PNTR_WIDTH);


      --Set the current state of FULL and almost_full_i values
      -- (these may be overwritten later in this process        if the user is writing to the FIFO)
      IF (C_RATIO_R = 1) THEN
        IF (size = C_FIFO_WR_DEPTH) THEN
          full_i      <= '1';
          almost_full_i <= '1';
        ELSIF size >= C_FIFO_WR_DEPTH - 1 THEN
          full_i      <= '0';
          almost_full_i <= '1';
        ELSE
          full_i      <= '0';
          almost_full_i <= '0';
        END IF;
      ELSE

        IF (WR_EN = '0') THEN

          --If not writing, then use the actual number of words in the FIFO
          -- to determine if the FIFO should be reporting FULL or not.
          IF (size >= C_FIFO_WR_DEPTH*C_RATIO_R-C_RATIO_R+1) THEN
            full_i      <= '1';
            almost_full_i <= '1';
          ELSIF (size >= C_FIFO_WR_DEPTH*C_RATIO_R-(2*C_RATIO_R)+1) THEN
            full_i      <= '0';
            almost_full_i <= '1';
          ELSE
            full_i      <= '0';
            almost_full_i <= '0';
          END IF;

        ELSE                            --IF (WR_EN='1')

          --If writing, then it is not possible to predict how many
          --words will actually be in the FIFO after the write concludes
          --(because the number of reads which happen in this time can
          -- not be determined).
          --Therefore, treat it pessimistically and always assume that
          -- the write will happen without a read (assume the FIFO is
          -- C_RATIO_R fuller than it is).
          IF (size+C_RATIO_R >= C_FIFO_WR_DEPTH*C_RATIO_R-C_RATIO_R+1) THEN
            full_i      <= '1';
            almost_full_i <= '1';
          ELSIF (size+C_RATIO_R >= C_FIFO_WR_DEPTH*C_RATIO_R-(2*C_RATIO_R)+1) THEN
            full_i      <= '0';
            almost_full_i <= '1';
          ELSE
            full_i      <= '0';
            almost_full_i <= '0';
          END IF;

        END IF;  --WR_EN

      END IF;  --C_RATIO_R



      -- User is writing to the FIFO
      IF WR_EN = '1' THEN
        -- User is writing to a FIFO which is NOT reporting FULL
        IF full_i /= '1' THEN

          -- FIFO really is Full
          IF size/C_RATIO_R = C_FIFO_WR_DEPTH THEN
            --Report Overflow and do not acknowledge the write
            overflow_i <= '1';
            wr_ack_i   <= '0';

            -- FIFO is almost full
          ELSIF size/C_RATIO_R + 1 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go FULL
            overflow_i <= '0';
            wr_ack_i   <= '1';
            full_i     <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;

            -- FIFO is one away from almost full
          ELSIF size/C_RATIO_R + 2 = C_FIFO_WR_DEPTH THEN
            -- This write will succeed, and FIFO will go almost_full_i
            overflow_i  <= '0';
            wr_ack_i    <= '1';
            almost_full_i <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point    <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;

            -- FIFO is no where near FULL
          ELSE
            --Write will succeed, no change in status
            overflow_i <= '0';
            wr_ack_i   <= '1';
            FOR h IN C_RATIO_R DOWNTO 1 LOOP
              add(head, tail, DIN( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
            END LOOP;
            wr_point   <= (wr_point + 1) MOD C_FIFO_WR_DEPTH;
          END IF;

          -- User is writing to a FIFO which IS reporting FULL
        ELSE                            --IF full_i = '1'
          --Write will fail
          overflow_i <= '1';
          wr_ack_i   <= '0';
        END IF;  --full_i

      ELSE                              --WR_EN/='1'
        --No write attempted, so neither overflow or acknowledge
        overflow_i <= '0';
        wr_ack_i   <= '0';
      END IF;  --WR_EN

      -------------------------------------------------------------------------
      -- Programmable FULL flags
      -------------------------------------------------------------------------

      --Single Constant Threshold
      IF (C_PROG_FULL_TYPE = 1) THEN

        -- If we are at or above the PROG_FULL_THRESH, or we will be
        --  next clock cycle, then assert PROG_FULL
        IF ((size/C_RATIO_R >= C_PROG_FULL_THRESH_ASSERT_VAL) OR ((size/C_RATIO_R = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1')) THEN
          prog_full_i <= '1';
        ELSE
          prog_full_i <= '0';
        END IF;  -- C_HAS_PROG_FULL_THRESH = 1


        --Dual Constant Thresholds
      ELSIF (C_PROG_FULL_TYPE = 2) THEN

        -- If we will be going at or above the C_PROG_FULL_ASSERT threshold
        -- on the next clock cycle, then assert PROG_FULL

        -- WARNING: For the fifo with separate clocks, it is possible that
        -- the core could be both reading and writing simultaneously, with
        -- the writes occuring faster. This means that the number of words
        -- in the FIFO is increasing, and PROG_FULL should be asserted. So,
        -- we assume the worst and assert PROG_FULL if we are close and
        -- writing, since RD_EN may or may not have an impact on the number
        -- of words in the FIFO.
        IF ((size/C_RATIO_R = C_PROG_FULL_THRESH_ASSERT_VAL-1) AND WR_EN = '1') THEN
          prog_full_i <= '1';

        ELSIF (size/C_RATIO_R >= C_PROG_FULL_THRESH_ASSERT_VAL) THEN
          prog_full_i <= '1';
          --If we are below the C_PROG_FULL_NEGATE, then de-assert PROG_FULL
        ELSIF (size/C_RATIO_R < C_PROG_FULL_THRESH_NEGATE_VAL) THEN
          prog_full_i <= '0';
        END IF;

        --Single threshold input port
      ELSIF (C_PROG_FULL_TYPE = 3) THEN

        -- If we are at or above the PROG_FULL_THRESH, or we will be
        --  next clock cycle, then assert PROG_FULL
        IF ((size/C_RATIO_R >= conv_integer(PROG_FULL_THRESH)) OR ((size/C_RATIO_R = conv_integer(PROG_FULL_THRESH)-1) AND WR_EN = '1')) THEN
          prog_full_i <= '1';
        ELSE
          prog_full_i <= '0';
        END IF;  -- C_HAS_PROG_FULL_THRESH = 1

        --Dual threshold input ports
      ELSIF (C_PROG_FULL_TYPE = 4) THEN


        -- If we will be going at or above the C_PROG_FULL_ASSERT threshold
        -- on the next clock cycle, then assert PROG_FULL
        IF ((size/C_RATIO_R = conv_integer(PROG_FULL_THRESH_ASSERT)-1) AND WR_EN = '1') THEN
          prog_full_i <= '1';
          -- If we are at or above the C_PROG_FULL_ASSERT, then assert
          -- PROG_FULL
        ELSIF (size/C_RATIO_R >= conv_integer(PROG_FULL_THRESH_ASSERT)) THEN
          prog_full_i <= '1';
          --If we are below the C_PROG_FULL_NEGATE, then de-assert PROG_FULL
        ELSIF (size/C_RATIO_R < conv_integer(PROG_FULL_THRESH_NEGATE)) THEN
          prog_full_i <= '0';
        END IF;


      END IF;  --C_PROG_FULL_TYPE

      prog_full_q <= prog_full_i;
      PROG_FULL <= prog_full_q;

    END IF;  --WR_CLK

    ---------------------------------------------------------------------------
    -- Read from FIFO
    ---------------------------------------------------------------------------
    IF rd_rst_i = '1' THEN
      underflow_i       <= '0';
      valid_i           <= '0';
      output_regs_valid <= '0';
      empty_i           <= '1';
      almost_empty_i      <= '1';
      PROG_EMPTY        <= '1';
      prog_empty_i      <= '1';
      prog_empty_q      <= '1';

      rd_point <= 0;
      wr_reg0  <= 0;
      wr_reg1  <= 0;
      rd_diff_count <= (others => '0');

      --Clear data output queue
--       data := hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
      data := (OTHERS => '0');

    ELSIF ((RD_CLK'event AND RD_CLK = '1') OR (CLK'event AND CLK = '1')) THEN

      underflow_i <= '0';
      valid_i     <= '0';

      --Default
      wr_reg0           <= wr_point;
      wr_reg1           <= wr_reg0;
      rd_diff_count <= conv_std_logic_vector((size/C_RATIO_W), C_RD_PNTR_WIDTH);

      ---------------------------------------------------------------------------
      -- Read Latency 1
      ---------------------------------------------------------------------------
      IF (C_PRELOAD_LATENCY = 1) THEN

        IF size/C_RATIO_W = 0 THEN
          empty_i      <= '1';
          almost_empty_i <= '1';
        ELSIF size/C_RATIO_W = 1 THEN
          empty_i      <= '0';
          almost_empty_i <= '1';
        ELSE
          empty_i      <= '0';
          almost_empty_i <= '0';
        END IF;

        IF RD_EN = '1' THEN

          IF empty_i /= '1' THEN
            -- FIFO full
            IF size/C_RATIO_W = 2 THEN
              almost_empty_i <= '1';
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
              -- almost empty
            ELSIF size/C_RATIO_W = 1 THEN
              almost_empty_i <= '1';
              empty_i      <= '1';
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
              -- fifo empty
            ELSIF size/C_RATIO_W = 0 THEN
              underflow_i  <= '1';
              -- middle counts
            ELSE
              valid_i      <= '1';
              FOR h IN C_RATIO_W DOWNTO 1 LOOP
                read(tail, data( (C_SMALLER_DATA_WIDTH*h)-1 DOWNTO C_SMALLER_DATA_WIDTH*(h-1) ) );
                remove(head, tail);
              END LOOP;
              rd_point     <= (rd_point + 1) MOD C_FIFO_RD_DEPTH;
            END IF;
          ELSE
            underflow_i    <= '1';
          END IF;
        END IF;  --RD_EN
      END IF;  --C_PRELOAD_LATENCY


      ---------------------------------------------------------------------------
      -- Programmable EMPTY Flags
      ---------------------------------------------------------------------------

      --Single Constant Threshold
      IF (C_PROG_EMPTY_TYPE = 1) THEN

        -- If we are at or below the PROG_EMPTY_THRESH, or we will be
        -- the next clock cycle, then assert PROG_EMPTY
        IF (
          (size/C_RATIO_W <= C_PROG_EMPTY_THRESH_ASSERT_VAL) OR
          ((size/C_RATIO_W = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) AND RD_EN = '1')
          ) THEN
          prog_empty_i      <= '1';
        ELSE
          prog_empty_i      <= '0';
        END IF;

        --Dual constant thresholds
      ELSIF (C_PROG_EMPTY_TYPE = 2) THEN


        -- If we will be going at or below the C_PROG_EMPTY_ASSERT threshold
        -- on the next clock cycle, then assert PROG_EMPTY
        --
        -- WARNING: For the fifo with separate clocks, it is possible that
        -- the core could be both reading and writing simultaneously, with
        -- the reads occuring faster. This means that the number of words
        -- in the FIFO is decreasing, and PROG_EMPTY should be asserted. So,
        -- we assume the worst and assert PROG_EMPTY if we are close and
        -- reading, since WR_EN may or may not have an impact on the number
        -- of words in the FIFO.
        IF ((size/C_RATIO_W = C_PROG_EMPTY_THRESH_ASSERT_VAL+1) AND RD_EN = '1') THEN
          prog_empty_i <= '1';
          -- If we are at or below the C_PROG_EMPTY_ASSERT, then assert
          -- PROG_EMPTY
        ELSIF (size/C_RATIO_W <= C_PROG_EMPTY_THRESH_ASSERT_VAL) THEN
          prog_empty_i          <= '1';

          --If we are above the C_PROG_EMPTY_NEGATE, then de-assert PROG_EMPTY
        ELSIF (size/C_RATIO_W > C_PROG_EMPTY_THRESH_NEGATE_VAL) THEN
          prog_empty_i <= '0';
        END IF;

        --Single threshold input port
      ELSIF (C_PROG_EMPTY_TYPE = 3) THEN

        -- If we are at or below the PROG_EMPTY_THRESH, or we will be
        -- the next clock cycle, then assert PROG_EMPTY
        IF (
          (size/C_RATIO_W <= conv_integer(PROG_EMPTY_THRESH)) OR
          ((size/C_RATIO_W = conv_integer(PROG_EMPTY_THRESH)+1) AND RD_EN = '1')
          ) THEN
          prog_empty_i      <= '1';
        ELSE
          prog_empty_i      <= '0';
        END IF;


        --Dual threshold input ports
      ELSIF (C_PROG_EMPTY_TYPE = 4) THEN

        -- If we will be going at or below the C_PROG_EMPTY_ASSERT threshold
        -- on the next clock cycle, then assert PROG_EMPTY
        IF ((size/C_RATIO_W = conv_integer(PROG_EMPTY_THRESH_ASSERT)+1) AND RD_EN = '1') THEN
          prog_empty_i          <= '1';
          -- If we are at or below the C_PROG_EMPTY_ASSERT, then assert
          -- PROG_EMPTY
        ELSIF (size/C_RATIO_W <= conv_integer(PROG_EMPTY_THRESH_ASSERT)) THEN
          prog_empty_i          <= '1';

          --If we are above the C_PROG_EMPTY_NEGATE, then de-assert PROG_EMPTY
        ELSIF (size/C_RATIO_W > conv_integer(PROG_EMPTY_THRESH_NEGATE)) THEN
          prog_empty_i <= '0';
        END IF;


      END IF;


    prog_empty_q <= prog_empty_i;
    PROG_EMPTY   <= prog_empty_q;


    END IF;  --RD_CLK


    DOUT       <= data;

  END PROCESS;


END behavioral;



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Preload Latency 0 Module
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;

LIBRARY work;
USE work.iputils_std_logic_unsigned.ALL;
USE work.iputils_conv.ALL;
USE work.iputils_misc.ALL;

ENTITY fifo_generator_v2_2_bhv_preload0 IS

  GENERIC (
    C_DOUT_RST_VAL    : string  := "";
    C_DOUT_WIDTH      : integer := 8;
    C_USERVALID_LOW   : integer := 0;
    C_USERUNDERFLOW_LOW : integer := 0);
  PORT (
    RD_CLK        : IN  std_logic;
    RD_RST        : IN  std_logic;
    RD_EN         : IN  std_logic;
    FIFOEMPTY     : IN  std_logic;
    FIFODATA      : IN  std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    USERDATA      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    USERVALID     : OUT std_logic;
    USERUNDERFLOW : OUT std_logic;
    USEREMPTY     : OUT std_logic;
    USERALMOSTEMPTY : OUT std_logic;
    RAMVALID      : OUT std_logic;
    FIFORDEN      : OUT std_logic);

END fifo_generator_v2_2_bhv_preload0;

ARCHITECTURE behavioral OF fifo_generator_v2_2_bhv_preload0 IS

  constant USE_ALTERNATE_EMPTY_FLAGS : integer := 1;

  SIGNAL preloadstage1     : std_logic := '0';
  SIGNAL preloadstage2     : std_logic := '0';
  SIGNAL ram_valid_i       : std_logic := '0';
  SIGNAL read_data_valid_i : std_logic := '0';
  SIGNAL ram_regout_en     : std_logic := '0';
  SIGNAL ram_rd_en         : std_logic := '0';
  SIGNAL empty_i           : std_logic := '1';
  SIGNAL empty_q           : std_logic := '1';
  SIGNAL almost_empty_i           : std_logic := '1';
  SIGNAL almost_empty_q           : std_logic := '1';



BEGIN  -- behavioral


p0g: if USE_ALTERNATE_EMPTY_FLAGS=0 generate

--------------------------------------------------------------------------------
--  preloadstage2 indicates that stage2 needs to be updated. This is true
--  whenever read_data_valid is false, and RAM_valid is true.
--------------------------------------------------------------------------------
  preloadstage2 <= ram_valid_i AND (NOT read_data_valid_i or RD_EN);

--------------------------------------------------------------------------------
--  preloadstage1 indicates that stage1 needs to be updated. This is true
--  whenever the RAM has data (RAM_EMPTY is false), and either RAM_Valid is
--  false (indicating that Stage1 needs updating), or preloadstage2 is active
--  (indicating that Stage2 is going to update, so Stage1, therefore, must
--  also be updated to keep it valid.
--------------------------------------------------------------------------------
  preloadstage1 <= (((NOT ram_valid_i) OR preloadstage2) AND (NOT FIFOEMPTY));

--------------------------------------------------------------------------------
-- Calculate RAM_REGOUT_EN
--  The output registers are controlled by the ram_regout_en signal.
--  These registers should be updated either when the output in Stage2 is
--  invalid (preloadstage2), OR when the user is reading, in which case the
--  Stage2 value will go invalid unless it is replenished.
--------------------------------------------------------------------------------
  ram_regout_en <= preloadstage2;

--------------------------------------------------------------------------------
-- Calculate RAM_RD_EN
--   RAM_RD_EN will be asserted whenever the RAM needs to be read in order to
--  update the value in Stage1.
--   One case when this happens is when preloadstage1=true, which indicates
--  that the data in Stage1 or Stage2 is invalid, and needs to automatically
--  be updated.
--   The other case is when the user is reading from the FIFO, which guarantees
--  that Stage1 or Stage2 will be invalid on the next clock cycle, unless it is
--  replinished by data from the memory. So, as long as the RAM has data in it,
--  a read of the RAM should occur.
--------------------------------------------------------------------------------
  ram_rd_en     <= (RD_EN AND NOT FIFOEMPTY) OR preloadstage1;

--------------------------------------------------------------------------------
-- Calculate ram_valid
--   ram_valid indicates that the data in Stage1 is valid.
--
--   If the RAM is being read from on this clock cycle (ram_rd_en=1), then
--   ram_valid is certainly going to be true.
--   If the RAM is not being read from, but the output registers are being
--   updated to fill Stage2 (ram_regout_en=1), then Stage1 will be emptying,
--   therefore causing ram_valid to be false.
--   Otherwise, ram_valid will remain unchanged.
--------------------------------------------------------------------------------
  regout_valid: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_valid
    IF RD_RST = '1' THEN                -- asynchronous reset (active high)
      ram_valid_i <= '0';
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF ram_rd_en = '1' THEN
        ram_valid_i <= '1';
      ELSE
        IF ram_regout_en = '1' THEN
          ram_valid_i <= '0';
        ELSE
          ram_valid_i <= ram_valid_i;
        END IF;
      END IF;
    END IF;
  END PROCESS regout_valid;

--------------------------------------------------------------------------------
-- Calculate READ_DATA_VALID
--  READ_DATA_VALID indicates whether the value in Stage2 is valid or not.
--  Stage2 has valid data whenever Stage1 had valid data and ram_regout_en_i=1,
--  such that the data in Stage1 is propogated into Stage2.
--------------------------------------------------------------------------------
  regout_dvalid : PROCESS (RD_CLK, RD_RST)
  BEGIN
    IF (RD_RST='1') THEN
      read_data_valid_i <= '0';
    ELSIF (RD_CLK'event AND RD_CLK='1') THEN
      read_data_valid_i <= ram_valid_i or (read_data_valid_i and not RD_EN);
    END IF; --RD_CLK
  END PROCESS regout_dvalid;

  regout_empty: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_empty
    IF RD_RST = '1' THEN                -- asynchronous reset (active high)
      empty_i <= '1';
      empty_q <= '1';
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF ((ram_regout_en = '1') OR (FIFOEMPTY = '0' AND read_data_valid_i = '1' AND  RD_EN='0')) THEN
        empty_i <= FIFOEMPTY;
      END IF;
      empty_q   <= empty_i;
    END IF;
  END PROCESS regout_empty;

  USEREMPTY <= empty_i;
  FIFORDEN  <= ram_rd_en;
  RAMVALID  <= ram_valid_i;

  guvh: if C_USERVALID_LOW=0 generate
    USERVALID <= read_data_valid_i;
  end generate guvh;
  guvl: if C_USERVALID_LOW=1 generate
    USERVALID <= not read_data_valid_i;
  end generate guvl;

  gufh: if C_USERUNDERFLOW_LOW=0 generate
    USERUNDERFLOW <= empty_q AND RD_EN;
  end generate gufh;
  gufl: if C_USERUNDERFLOW_LOW=1 generate
    USERUNDERFLOW <= not (empty_q AND RD_EN);
  end generate gufl;

  regout_lat0: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_lat0
    IF RD_RST = '1' THEN              -- asynchronous reset (active high)
      USERDATA <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF (ram_regout_en = '1') THEN
        USERDATA <= FIFODATA;
      END IF;
    END IF;
  END PROCESS regout_lat0;




end generate p0g;

p0ga: if USE_ALTERNATE_EMPTY_FLAGS=1 generate

--------------------------------------------------------------------------------
--  preloadstage2 indicates that stage2 needs to be updated. This is true
--  whenever read_data_valid is false, and RAM_valid is true.
--------------------------------------------------------------------------------
  preloadstage2 <= ram_valid_i AND (NOT read_data_valid_i or RD_EN);

--------------------------------------------------------------------------------
--  preloadstage1 indicates that stage1 needs to be updated. This is true
--  whenever the RAM has data (RAM_EMPTY is false), and either RAM_Valid is
--  false (indicating that Stage1 needs updating), or preloadstage2 is active
--  (indicating that Stage2 is going to update, so Stage1, therefore, must
--  also be updated to keep it valid.
--------------------------------------------------------------------------------
  preloadstage1 <= (((NOT ram_valid_i) OR preloadstage2) AND (NOT FIFOEMPTY));

--------------------------------------------------------------------------------
-- Calculate RAM_REGOUT_EN
--  The output registers are controlled by the ram_regout_en signal.
--  These registers should be updated either when the output in Stage2 is
--  invalid (preloadstage2), OR when the user is reading, in which case the
--  Stage2 value will go invalid unless it is replenished.
--------------------------------------------------------------------------------
  ram_regout_en <= preloadstage2;

--------------------------------------------------------------------------------
-- Calculate RAM_RD_EN
--   RAM_RD_EN will be asserted whenever the RAM needs to be read in order to
--  update the value in Stage1.
--   One case when this happens is when preloadstage1=true, which indicates
--  that the data in Stage1 or Stage2 is invalid, and needs to automatically
--  be updated.
--   The other case is when the user is reading from the FIFO, which guarantees
--  that Stage1 or Stage2 will be invalid on the next clock cycle, unless it is
--  replinished by data from the memory. So, as long as the RAM has data in it,
--  a read of the RAM should occur.
--------------------------------------------------------------------------------
  ram_rd_en     <= (RD_EN AND NOT FIFOEMPTY) OR preloadstage1;

--------------------------------------------------------------------------------
-- Calculate ram_valid
--   ram_valid indicates that the data in Stage1 is valid.
--
--   If the RAM is being read from on this clock cycle (ram_rd_en=1), then
--   ram_valid is certainly going to be true.
--   If the RAM is not being read from, but the output registers are being
--   updated to fill Stage2 (ram_regout_en=1), then Stage1 will be emptying,
--   therefore causing ram_valid to be false.
--   Otherwise, ram_valid will remain unchanged.
--------------------------------------------------------------------------------
  regout_valid: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_valid
    IF RD_RST = '1' THEN                -- asynchronous reset (active high)
      ram_valid_i <= '0';
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF ram_rd_en = '1' THEN
        ram_valid_i <= '1';
      ELSE
        IF ram_regout_en = '1' THEN
          ram_valid_i <= '0';
        ELSE
          ram_valid_i <= ram_valid_i;
        END IF;
      END IF;
    END IF;
  END PROCESS regout_valid;

--------------------------------------------------------------------------------
-- Calculate READ_DATA_VALID
--  READ_DATA_VALID indicates whether the value in Stage2 is valid or not.
--  Stage2 has valid data whenever Stage1 had valid data and ram_regout_en_i=1,
--  such that the data in Stage1 is propogated into Stage2.
--------------------------------------------------------------------------------
  regout_dvalid : PROCESS (RD_CLK, RD_RST)
  BEGIN
    IF (RD_RST='1') THEN
      read_data_valid_i <= '0';
    ELSIF (RD_CLK'event AND RD_CLK='1') THEN
      read_data_valid_i <= ram_valid_i or (read_data_valid_i and not RD_EN);
    END IF; --RD_CLK
  END PROCESS regout_dvalid;

-------------------------------------------------------------------------------
-- Calculate EMPTY
--  Defined as the inverse of READ_DATA_VALID
--
-- Description:
--
--  If read_data_valid_i indicates that the output is not valid,
-- and there is no valid data on the output of the ram to preload it
-- with, then we will report empty.
--
--  If there is no valid data on the output of the ram and we are
-- reading, then the FIFO will go empty.
--

-------------------------------------------------------------------------------
  regout_empty :  PROCESS (RD_CLK, RD_RST)       --This is equivalent to (NOT read_data_valid_i)
  BEGIN
    IF (RD_RST='1') THEN
      empty_i <= '1';
      empty_q <= '1';
    ELSIF (RD_CLK'event AND RD_CLK='1') THEN
      --empty_i  <= not (ram_valid_i or (read_data_valid_i and not RD_EN));
      empty_i  <= (not ram_valid_i and not read_data_valid_i) or (not ram_valid_i and RD_EN);
      empty_q  <= empty_i;
    END IF; --RD_CLK
  END PROCESS regout_empty;

-------------------------------------------------------------------------------
-- Calculate user_almost_empty
--  user_almost_empty is defined such that, unless more words are written
--  to the FIFO, the next read will cause the FIFO to go EMPTY.
--
--  In most cases, whenever the output registers are updated (due to a user
-- read or a preload condition), then user_almost_empty will update to
-- whatever RAM_EMPTY is.
--
--  The exception is when the output is valid, the user is not reading, and
-- Stage1 is not empty. In this condition, Stage1 will be preloaded from the
-- memory, so we need to make sure user_almost_empty deasserts properly under
-- this condition.
-------------------------------------------------------------------------------
  regout_aempty: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_empty
    IF RD_RST = '1' THEN                -- asynchronous reset (active high)
      almost_empty_i <= '1';
      almost_empty_q <= '1';
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF ((ram_regout_en = '1') OR (FIFOEMPTY = '0' AND read_data_valid_i = '1' AND  RD_EN='0')) THEN
        almost_empty_i <= FIFOEMPTY;
      END IF;
      almost_empty_q   <= almost_empty_i;
    END IF;
  END PROCESS regout_aempty;

  USEREMPTY <= empty_i;
  USERALMOSTEMPTY <= almost_empty_i;
  FIFORDEN  <= ram_rd_en;
  RAMVALID  <= ram_valid_i;

  guvh: if C_USERVALID_LOW=0 generate
    USERVALID <= read_data_valid_i;
  end generate guvh;
  guvl: if C_USERVALID_LOW=1 generate
    USERVALID <= not read_data_valid_i;
  end generate guvl;

  gufh: if C_USERUNDERFLOW_LOW=0 generate
    USERUNDERFLOW <= empty_q AND RD_EN;
  end generate gufh;
  gufl: if C_USERUNDERFLOW_LOW=1 generate
    USERUNDERFLOW <= not (empty_q AND RD_EN);
  end generate gufl;

  regout_lat0: PROCESS (RD_CLK, RD_RST)
  BEGIN  -- PROCESS regout_lat0
    IF RD_RST = '1' THEN              -- asynchronous reset (active high)
      USERDATA <= hexstr_to_std_logic_vec(C_DOUT_RST_VAL, C_DOUT_WIDTH);
    ELSIF RD_CLK'event AND RD_CLK = '1' THEN  -- rising clock edge
      IF (ram_regout_en = '1') THEN
        USERDATA <= FIFODATA;
      END IF;
    END IF;
  END PROCESS regout_lat0;





end generate p0ga;




END behavioral;




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--  Top-level Behavioral Model
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;
-- USE IEEE.std_logic_arith.ALL;

LIBRARY work;
USE work.iputils_std_logic_unsigned.ALL;
USE work.iputils_std_logic_arith.ALL;
USE work.iputils_conv.ALL;
USE work.iputils_misc.ALL;
USE work.fifo_generator_v2_2_bhv_as;
USE work.fifo_generator_v2_2_bhv_ss;
USE work.fifo_generator_v2_2_bhv_fifo16;


ENTITY fifo_generator_v2_2 IS
  GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations
    --------------------------------------------------------------------------------
    C_COMMON_CLOCK                : integer := 0;
    C_COUNT_TYPE                  : integer := 0;
    C_DATA_COUNT_WIDTH            : integer := 2;
    C_DEFAULT_VALUE               : string  := "";
    C_DIN_WIDTH                   : integer := 8;
    C_DOUT_RST_VAL                : string  := "";
    C_DOUT_WIDTH                  : integer := 8;
    C_ENABLE_RLOCS                : integer := 0;
    C_FAMILY                      : string  := "";
    C_HAS_ALMOST_EMPTY            : integer := 0;
    C_HAS_ALMOST_FULL             : integer := 0;
    C_HAS_BACKUP                  : integer := 0;
    C_HAS_DATA_COUNT              : integer := 0;
    C_HAS_MEMINIT_FILE            : integer := 0;
    C_HAS_OVERFLOW                : integer := 0;
    C_HAS_RD_DATA_COUNT           : integer := 0;
    C_HAS_RD_RST                  : integer := 0;
    C_HAS_RST                     : integer := 1;
    C_HAS_UNDERFLOW               : integer := 0;
    C_HAS_VALID                   : integer := 0;
    C_HAS_WR_ACK                  : integer := 0;
    C_HAS_WR_DATA_COUNT           : integer := 0;
    C_HAS_WR_RST                  : integer := 0;
    C_IMPLEMENTATION_TYPE         : integer := 0;
    C_INIT_WR_PNTR_VAL            : integer := 0;
    C_MEMORY_TYPE                 : integer := 1;
    C_MIF_FILE_NAME               : string  := "";
    C_OPTIMIZATION_MODE           : integer := 0;
    C_OVERFLOW_LOW                : integer := 0;
    C_PRELOAD_REGS                : integer := 0;
    C_PRELOAD_LATENCY             : integer := 1;
    C_PRIM_FIFO_TYPE              : integer := 512;
    C_PROG_EMPTY_THRESH_ASSERT_VAL: integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL: integer := 0;
    C_PROG_EMPTY_TYPE             : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_FULL_TYPE              : integer := 0;
    C_RD_DATA_COUNT_WIDTH         : integer := 2;
    C_RD_DEPTH                    : integer := 256;
    C_RD_PNTR_WIDTH               : integer := 8;
    C_UNDERFLOW_LOW               : integer := 0;
    C_USE_FIFO16_FLAGS             : integer := 0;
    C_VALID_LOW                   : integer := 0;
    C_WR_ACK_LOW                  : integer := 0;
    C_WR_DATA_COUNT_WIDTH         : integer := 2;
    C_WR_DEPTH                    : integer := 256;
    C_WR_PNTR_WIDTH               : integer := 8;
    C_WR_RESPONSE_LATENCY         : integer := 1
    );
  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK                       : IN  std_logic := '0';
    BACKUP                    : IN  std_logic := '0';
    BACKUP_MARKER             : IN  std_logic := '0';
    DIN                       : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0); --
    --Mandatory input
    PROG_EMPTY_THRESH         : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH          : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK                    : IN  std_logic := '0';
    RD_EN                     : IN  std_logic;  --Mandatory input
    RD_RST                    : IN  std_logic := '0';
    RST                       : IN  std_logic := '0';
    WR_CLK                    : IN  std_logic := '0';
    WR_EN                     : IN  std_logic;  --Mandatory input
    WR_RST                    : IN  std_logic := '0';

    ALMOST_EMPTY              : OUT std_logic;
    ALMOST_FULL               : OUT std_logic;
    DATA_COUNT                : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    DOUT                      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY                     : OUT std_logic;
    FULL                      : OUT std_logic;
    OVERFLOW                  : OUT std_logic;
    PROG_EMPTY                : OUT std_logic;
    PROG_FULL                 : OUT std_logic;
    VALID                     : OUT std_logic;
    RD_DATA_COUNT             : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    UNDERFLOW                 : OUT std_logic;
    WR_ACK                    : OUT std_logic;
    WR_DATA_COUNT             : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
    );

END fifo_generator_v2_2;



ARCHITECTURE behavioral OF fifo_generator_v2_2 IS

  COMPONENT fifo_generator_v2_2_bhv_as

    GENERIC (
      --------------------------------------------------------------------------------
      -- Generic Declarations
      --------------------------------------------------------------------------------
      C_DIN_WIDTH                    :    integer := 8;
      C_DOUT_RST_VAL                 :    string  := "";
      C_DOUT_WIDTH                   :    integer := 8;
      C_ENABLE_RLOCS                 :    integer := 0;
      C_FAMILY                       :    string  := "";
      C_HAS_ALMOST_FULL              :    integer := 0;
      C_HAS_ALMOST_EMPTY             :    integer := 0;
      C_HAS_OVERFLOW                 :    integer := 0;
      C_HAS_RD_DATA_COUNT            :    integer := 2;
      C_HAS_VALID                    :    integer := 0;
      C_HAS_RST                      :    integer := 1;
      C_HAS_UNDERFLOW                :    integer := 0;
      C_HAS_WR_ACK                   :    integer := 0;
      C_HAS_WR_DATA_COUNT            :    integer := 2;
      C_MEMORY_TYPE                  :    integer := 1;
      C_OPTIMIZATION_MODE            :    integer := 0;
      C_WR_RESPONSE_LATENCY          :    integer := 1;
      C_OVERFLOW_LOW                 :    integer := 0;
      C_PRELOAD_REGS                 :    integer := 0;
      C_PRELOAD_LATENCY              :    integer := 1;
      C_PROG_EMPTY_TYPE              :    integer := 0;
      C_PROG_EMPTY_THRESH_ASSERT_VAL :    integer := 0;
      C_PROG_EMPTY_THRESH_NEGATE_VAL :    integer := 0;
      C_PROG_FULL_TYPE               :    integer := 0;
      C_PROG_FULL_THRESH_ASSERT_VAL  :    integer := 0;
      C_PROG_FULL_THRESH_NEGATE_VAL  :    integer := 0;
      C_VALID_LOW                    :    integer := 0;
      C_RD_DATA_COUNT_WIDTH          :    integer := 0;
      C_RD_DEPTH                     :    integer := 256;
      C_RD_PNTR_WIDTH                :    integer := 8;
      C_UNDERFLOW_LOW                :    integer := 0;
      C_WR_ACK_LOW                   :    integer := 0;
      C_WR_DATA_COUNT_WIDTH          :    integer := 0;
      C_WR_DEPTH                     :    integer := 256;
      C_WR_PNTR_WIDTH                :    integer := 8
      );
    PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
      DIN                            : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH              : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_ASSERT       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_NEGATE       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH               : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_ASSERT        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_NEGATE        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      RD_CLK                         : IN std_logic;
      RD_EN                          : IN std_logic;
      RST                            : IN std_logic;
      WR_CLK                         : IN std_logic;
      WR_EN                          : IN std_logic;

      ALMOST_EMPTY  : OUT std_logic;
      ALMOST_FULL   : OUT std_logic;
      DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      EMPTY         : OUT std_logic;
      FULL          : OUT std_logic;
      OVERFLOW      : OUT std_logic;
      PROG_EMPTY    : OUT std_logic;
      PROG_FULL     : OUT std_logic;
      VALID         : OUT std_logic;
      RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
      UNDERFLOW     : OUT std_logic;
      WR_ACK        : OUT std_logic;
      WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
      );

  END COMPONENT;



  COMPONENT fifo_generator_v2_2_bhv_ss

    GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    --------------------------------------------------------------------------------
    C_COMMON_CLOCK          : integer := 0;
    C_COUNT_TYPE            : integer := 0;
    C_DATA_COUNT_WIDTH      : integer := 2;
    C_DEFAULT_VALUE         : string  := "";
    C_DIN_WIDTH             : integer := 8;
    C_DOUT_RST_VAL          : string  := "";
    C_DOUT_WIDTH            : integer := 8;
    C_ENABLE_RLOCS          : integer := 0;
    C_FAMILY                : string  := "virtex2";
    C_HAS_ALMOST_FULL       : integer := 0;
    C_HAS_ALMOST_EMPTY      : integer := 0;
    C_HAS_BACKUP            : integer := 0;
    C_HAS_DATA_COUNT        : integer := 0;
    C_HAS_MEMINIT_FILE      : integer := 0;
    C_HAS_OVERFLOW          : integer := 0;
    C_HAS_RD_DATA_COUNT     : integer := 0;
    C_HAS_RD_RST            : integer := 0;
    C_HAS_RST               : integer := 0;
    C_HAS_UNDERFLOW         : integer := 0;
    C_HAS_VALID             : integer := 0;
    C_HAS_WR_ACK            : integer := 0;
    C_HAS_WR_DATA_COUNT     : integer := 0;
    C_HAS_WR_RST            : integer := 0;
    C_INIT_WR_PNTR_VAL      : integer := 0;
    C_MEMORY_TYPE           : integer := 1;
    C_MIF_FILE_NAME         : string  := "";
    C_OPTIMIZATION_MODE     : integer := 0;
    C_OVERFLOW_LOW          : integer := 0;
    C_PRELOAD_REGS          : integer := 0;
    C_PRELOAD_LATENCY       : integer := 1;
    C_PROG_EMPTY_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_EMPTY_TYPE              : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL  : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL  : integer := 0;
    C_PROG_FULL_TYPE               : integer := 0;
    C_RD_DATA_COUNT_WIDTH   : integer := 2;
    C_RD_DEPTH              : integer := 256;
    C_RD_PNTR_WIDTH         : integer := 8;
    C_UNDERFLOW_LOW         : integer := 0;
    C_VALID_LOW             : integer := 0;
    C_WR_ACK_LOW            : integer := 0;
    C_WR_DATA_COUNT_WIDTH   : integer := 2;
    C_WR_DEPTH              : integer := 256;
    C_WR_PNTR_WIDTH         : integer := 8;
    C_WR_RESPONSE_LATENCY   : integer := 1
    );


  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK               : IN std_logic                                    := '0';
    BACKUP            : IN std_logic                                    := '0';
    BACKUP_MARKER     : IN std_logic                                    := '0';
    DIN               : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0)     := (OTHERS => '0');
    PROG_EMPTY_THRESH : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE  : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK            : IN std_logic                                    := '0';
    RD_EN             : IN std_logic                                    := '0';
    RD_RST            : IN std_logic                                    := '0';
    RST               : IN std_logic                                    := '0';
    WR_CLK            : IN std_logic                                    := '0';
    WR_EN             : IN std_logic                                    := '0';
    WR_RST            : IN std_logic                                    := '0';

    ALMOST_EMPTY  : OUT std_logic;
    ALMOST_FULL   : OUT std_logic;
    DATA_COUNT    : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY         : OUT std_logic;
    FULL          : OUT std_logic;
    OVERFLOW      : OUT std_logic;
    PROG_EMPTY    : OUT std_logic;
    PROG_FULL     : OUT std_logic;
    VALID         : OUT std_logic;
    RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    UNDERFLOW     : OUT std_logic;
    WR_ACK        : OUT std_logic;
    WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
    );

  END COMPONENT;



  COMPONENT fifo_generator_v2_2_bhv_fifo16

    GENERIC (
      --------------------------------------------------------------------------------
      -- Generic Declarations
      --------------------------------------------------------------------------------
      C_COMMON_CLOCK                 :    integer := 0;
      C_DIN_WIDTH                    :    integer := 8;
      C_DOUT_RST_VAL                 :    string  := "";
      C_DOUT_WIDTH                   :    integer := 8;
      C_ENABLE_RLOCS                 :    integer := 0;
      C_FAMILY                       :    string  := "";
      C_HAS_ALMOST_FULL              :    integer := 0;
      C_HAS_ALMOST_EMPTY             :    integer := 0;
      C_HAS_OVERFLOW                 :    integer := 0;
      C_HAS_RD_DATA_COUNT            :    integer := 2;
      C_HAS_VALID                    :    integer := 0;
      C_HAS_RST                      :    integer := 1;
      C_HAS_UNDERFLOW                :    integer := 0;
      C_HAS_WR_ACK                   :    integer := 0;
      C_HAS_WR_DATA_COUNT            :    integer := 2;
      C_MEMORY_TYPE                  :    integer := 1;
      C_OPTIMIZATION_MODE            :    integer := 0;
      C_WR_RESPONSE_LATENCY          :    integer := 1;
      C_OVERFLOW_LOW                 :    integer := 0;
      C_PRELOAD_REGS                 :    integer := 0;
      C_PRELOAD_LATENCY              :    integer := 1;
      C_PROG_EMPTY_TYPE              :    integer := 0;
      C_PROG_EMPTY_THRESH_ASSERT_VAL :    integer := 0;
      C_PROG_EMPTY_THRESH_NEGATE_VAL :    integer := 0;
      C_PROG_FULL_TYPE               :    integer := 0;
      C_PROG_FULL_THRESH_ASSERT_VAL  :    integer := 0;
      C_PROG_FULL_THRESH_NEGATE_VAL  :    integer := 0;
      C_VALID_LOW                    :    integer := 0;
      C_RD_DATA_COUNT_WIDTH          :    integer := 0;
      C_RD_DEPTH                     :    integer := 256;
      C_RD_PNTR_WIDTH                :    integer := 8;
      C_UNDERFLOW_LOW                :    integer := 0;
      C_USE_FIFO16_FLAGS              :    integer := 0;
      C_WR_ACK_LOW                   :    integer := 0;
      C_WR_DATA_COUNT_WIDTH          :    integer := 0;
      C_WR_DEPTH                     :    integer := 256;
      C_WR_PNTR_WIDTH                :    integer := 8;
      C_PRIM_FIFO_TYPE               :    integer := 512
      );
    PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
      DIN                            : IN std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH              : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_ASSERT       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_EMPTY_THRESH_NEGATE       : IN std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH               : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_ASSERT        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      PROG_FULL_THRESH_NEGATE        : IN std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0);
      CLK                            : IN std_logic;
      RD_CLK                         : IN std_logic;
      RD_EN                          : IN std_logic;
      RST                            : IN std_logic;
      WR_CLK                         : IN std_logic;
      WR_EN                          : IN std_logic;

      ALMOST_EMPTY  : OUT std_logic;
      ALMOST_FULL   : OUT std_logic;
      DOUT          : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      EMPTY         : OUT std_logic;
      FULL          : OUT std_logic;
      OVERFLOW      : OUT std_logic;
      PROG_EMPTY    : OUT std_logic;
      PROG_FULL     : OUT std_logic;
      VALID         : OUT std_logic;
      RD_DATA_COUNT : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
      UNDERFLOW     : OUT std_logic;
      WR_ACK        : OUT std_logic;
      WR_DATA_COUNT : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
      );

  END COMPONENT;

  COMPONENT fifo_generator_v2_2_bhv_preload0
    GENERIC (
      C_DOUT_RST_VAL : string;
      C_DOUT_WIDTH   : integer;
      C_USERVALID_LOW   : integer := 0;
      C_USERUNDERFLOW_LOW : integer := 0);
    PORT (
      RD_CLK        : IN std_logic;
      RD_RST        : IN std_logic;
      RD_EN         : IN  std_logic;
      FIFOEMPTY     : IN  std_logic;
      FIFODATA      : IN  std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      USERDATA      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
      USERVALID     : OUT std_logic;
      USERUNDERFLOW : OUT std_logic;
      USEREMPTY     : OUT std_logic;
      USERALMOSTEMPTY  : OUT std_logic;
      RAMVALID      : OUT std_logic;
      FIFORDEN      : OUT std_logic);
  END COMPONENT;



  SIGNAL zero : std_logic := '0';



  -----------------------------------------------------------------------------
  -- Internal Signals
  --  In the normal case, these signals tie directly to the FIFO's inputs and
  --  outputs.
  --  In the case of Preload Latency 0 or 1, these are the intermediate
  --  signals between the internal FIFO and the preload logic.
  -----------------------------------------------------------------------------
    SIGNAL rd_en_fifo_in          : std_logic;
    SIGNAL dout_fifo_out          : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    SIGNAL empty_fifo_out         : std_logic;
    SIGNAL almost_empty_fifo_out  : std_logic;
    SIGNAL valid_fifo_out         : std_logic;
    SIGNAL underflow_fifo_out     : std_logic;
    SIGNAL rd_data_count_fifo_out : std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    SIGNAL wr_data_count_fifo_out : std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0);

    SIGNAL dout_p0_out            : std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    signal valid_p0_out           : std_logic;
    signal empty_p0_out           : std_logic;
    signal underflow_p0_out       : std_logic;
    signal almost_empty_p0_out    : std_logic;

    signal empty_p0_out_q         : std_logic;
    signal almost_empty_p0_out_q  : std_logic;

    SIGNAL ram_valid              : std_logic;  --Internal signal used to monitor the
                                         --ram_valid state


BEGIN

  --Assign Ground Signal
  zero <= '0';



  gen_ss : IF ((C_IMPLEMENTATION_TYPE = 0) OR (C_IMPLEMENTATION_TYPE = 1)) GENERATE
    fgss : fifo_generator_v2_2_bhv_ss
      GENERIC MAP (
        C_COMMON_CLOCK            => C_COMMON_CLOCK,
        C_COUNT_TYPE              => C_COUNT_TYPE,
        C_DATA_COUNT_WIDTH        => C_DATA_COUNT_WIDTH,
        C_DEFAULT_VALUE           => C_DEFAULT_VALUE,
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_ENABLE_RLOCS                 => C_ENABLE_RLOCS,
        C_FAMILY                       => C_FAMILY,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_BACKUP              => C_HAS_BACKUP,
        C_HAS_DATA_COUNT          => C_HAS_DATA_COUNT,
        C_HAS_MEMINIT_FILE        => C_HAS_MEMINIT_FILE,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
        C_HAS_RD_RST              => C_HAS_RD_RST,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
        C_HAS_WR_RST              => C_HAS_WR_RST,
        C_INIT_WR_PNTR_VAL        => C_INIT_WR_PNTR_VAL,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_MIF_FILE_NAME           => C_MIF_FILE_NAME,
        C_OPTIMIZATION_MODE            => C_OPTIMIZATION_MODE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_VALID_LOW                    => C_VALID_LOW,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_WR_RESPONSE_LATENCY          => C_WR_RESPONSE_LATENCY
        )
      PORT MAP(
        --Inputs
        CLK                       => CLK,
        BACKUP                    => BACKUP,
        BACKUP_MARKER             => BACKUP_MARKER,
        DIN                            => DIN,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,
        RD_CLK                         => zero,
        RD_EN                          => RD_EN,
        RD_RST                    => RD_RST,
        RST                            => RST,
        WR_CLK                         => zero,
        WR_EN                          => WR_EN,
        WR_RST                    => WR_RST,

        --Outputs
        ALMOST_EMPTY          => almost_empty_fifo_out,
        ALMOST_FULL           => ALMOST_FULL,
        DATA_COUNT            => DATA_COUNT,
        DOUT                  => dout_fifo_out,
        EMPTY                 => empty_fifo_out,
        FULL                  => FULL,
        OVERFLOW              => OVERFLOW,
        PROG_EMPTY            => PROG_EMPTY,
        PROG_FULL             => PROG_FULL,
        RD_DATA_COUNT         => rd_data_count_fifo_out,
        UNDERFLOW             => underflow_fifo_out,
        VALID                 => valid_fifo_out,
        WR_ACK                => WR_ACK,
        WR_DATA_COUNT         => wr_data_count_fifo_out
        );
  END GENERATE gen_ss;



  gen_as : IF (C_IMPLEMENTATION_TYPE = 2) GENERATE

    fgas : fifo_generator_v2_2_bhv_as
      GENERIC MAP (
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_ENABLE_RLOCS                 => C_ENABLE_RLOCS,
        C_FAMILY                       => C_FAMILY,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_OPTIMIZATION_MODE            => C_OPTIMIZATION_MODE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_VALID_LOW                    => C_VALID_LOW,
        C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_WR_RESPONSE_LATENCY          => C_WR_RESPONSE_LATENCY
        )
      PORT MAP(
        --Inputs
        WR_CLK                         => WR_CLK,
        RD_CLK                         => RD_CLK,
        RST                            => RST,
        DIN                            => DIN,
        WR_EN                          => WR_EN,
        RD_EN                          => rd_en_fifo_in,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,

        --Outputs
        DOUT                  => dout_fifo_out,
        FULL                  => FULL,
        ALMOST_FULL           => ALMOST_FULL,
        WR_ACK                => WR_ACK,
        OVERFLOW              => OVERFLOW,
        EMPTY                 => empty_fifo_out,
        ALMOST_EMPTY          => almost_empty_fifo_out,
        VALID                 => valid_fifo_out,
        UNDERFLOW             => underflow_fifo_out,
        RD_DATA_COUNT         => rd_data_count_fifo_out,
        WR_DATA_COUNT         => wr_data_count_fifo_out,
        PROG_FULL             => PROG_FULL,
        PROG_EMPTY            => PROG_EMPTY
        );

  END GENERATE gen_as;


  gen_fifo16 : IF (C_IMPLEMENTATION_TYPE = 3) GENERATE

    fg16 : fifo_generator_v2_2_bhv_fifo16
      GENERIC MAP (
        C_COMMON_CLOCK                 => C_COMMON_CLOCK,
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_ENABLE_RLOCS                 => C_ENABLE_RLOCS,
        C_FAMILY                       => C_FAMILY,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_OPTIMIZATION_MODE            => C_OPTIMIZATION_MODE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_PRIM_FIFO_TYPE               => C_PRIM_FIFO_TYPE,
        C_VALID_LOW                    => C_VALID_LOW,
        C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_USE_FIFO16_FLAGS              => C_USE_FIFO16_FLAGS,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_WR_RESPONSE_LATENCY          => C_WR_RESPONSE_LATENCY
        )
      PORT MAP(
        --Inputs
        WR_CLK                         => WR_CLK,
        RD_CLK                         => RD_CLK,
        CLK                            => CLK,
        RST                            => RST,
        DIN                            => DIN,
        WR_EN                          => WR_EN,
        RD_EN                          => RD_EN,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,

        --Outputs
        DOUT                  => dout_fifo_out,
        FULL                  => FULL,
        ALMOST_FULL           => ALMOST_FULL,
        WR_ACK                => WR_ACK,
        OVERFLOW              => OVERFLOW,
        EMPTY                 => empty_fifo_out,
        ALMOST_EMPTY          => almost_empty_fifo_out,
        VALID                 => valid_fifo_out,
        UNDERFLOW             => underflow_fifo_out,
        RD_DATA_COUNT         => rd_data_count_fifo_out,
        WR_DATA_COUNT         => wr_data_count_fifo_out,
        PROG_FULL             => PROG_FULL,
        PROG_EMPTY            => PROG_EMPTY
        );

  END GENERATE gen_fifo16;


  gen_other : IF (C_IMPLEMENTATION_TYPE = 4) GENERATE

    fgoth : fifo_generator_v2_2_bhv_as
      GENERIC MAP (
        C_DIN_WIDTH                    => C_DIN_WIDTH,
        C_DOUT_RST_VAL                 => C_DOUT_RST_VAL,
        C_DOUT_WIDTH                   => C_DOUT_WIDTH,
        C_ENABLE_RLOCS                 => C_ENABLE_RLOCS,
        C_FAMILY                       => C_FAMILY,
        C_HAS_ALMOST_EMPTY             => C_HAS_ALMOST_EMPTY,
        C_HAS_ALMOST_FULL              => C_HAS_ALMOST_FULL,
        C_HAS_OVERFLOW                 => C_HAS_OVERFLOW,
        C_PROG_EMPTY_TYPE              => C_PROG_EMPTY_TYPE,
        C_PROG_EMPTY_THRESH_ASSERT_VAL => C_PROG_EMPTY_THRESH_ASSERT_VAL,
        C_PROG_EMPTY_THRESH_NEGATE_VAL => C_PROG_EMPTY_THRESH_NEGATE_VAL,
        C_PROG_FULL_TYPE               => C_PROG_FULL_TYPE,
        C_PROG_FULL_THRESH_ASSERT_VAL  => C_PROG_FULL_THRESH_ASSERT_VAL,
        C_PROG_FULL_THRESH_NEGATE_VAL  => C_PROG_FULL_THRESH_NEGATE_VAL,
        C_HAS_VALID                    => C_HAS_VALID,
        C_HAS_RD_DATA_COUNT            => C_HAS_RD_DATA_COUNT,
        C_HAS_RST                      => C_HAS_RST,
        C_HAS_UNDERFLOW                => C_HAS_UNDERFLOW,
        C_HAS_WR_ACK                   => C_HAS_WR_ACK,
        C_HAS_WR_DATA_COUNT            => C_HAS_WR_DATA_COUNT,
        C_MEMORY_TYPE                  => C_MEMORY_TYPE,
        C_OPTIMIZATION_MODE            => C_OPTIMIZATION_MODE,
        C_OVERFLOW_LOW                 => C_OVERFLOW_LOW,
        C_PRELOAD_LATENCY              => C_PRELOAD_LATENCY,
        C_PRELOAD_REGS                 => C_PRELOAD_REGS,
        C_VALID_LOW                    => C_VALID_LOW,
        C_RD_DATA_COUNT_WIDTH          => C_RD_DATA_COUNT_WIDTH,
        C_RD_DEPTH                     => C_RD_DEPTH,
        C_RD_PNTR_WIDTH                => C_RD_PNTR_WIDTH,
        C_UNDERFLOW_LOW                => C_UNDERFLOW_LOW,
        C_WR_ACK_LOW                   => C_WR_ACK_LOW,
        C_WR_DATA_COUNT_WIDTH          => C_WR_DATA_COUNT_WIDTH,
        C_WR_DEPTH                     => C_WR_DEPTH,
        C_WR_PNTR_WIDTH                => C_WR_PNTR_WIDTH,
        C_WR_RESPONSE_LATENCY          => C_WR_RESPONSE_LATENCY
        )
      PORT MAP(
        --Inputs
        WR_CLK                         => WR_CLK,
        RD_CLK                         => RD_CLK,
        RST                            => RST,
        DIN                            => DIN,
        WR_EN                          => WR_EN,
        RD_EN                          => RD_EN,
        PROG_FULL_THRESH               => PROG_FULL_THRESH,
        PROG_EMPTY_THRESH_ASSERT       => PROG_EMPTY_THRESH_ASSERT,
        PROG_EMPTY_THRESH_NEGATE       => PROG_EMPTY_THRESH_NEGATE,
        PROG_EMPTY_THRESH              => PROG_EMPTY_THRESH,
        PROG_FULL_THRESH_ASSERT        => PROG_FULL_THRESH_ASSERT,
        PROG_FULL_THRESH_NEGATE        => PROG_FULL_THRESH_NEGATE,

        --Outputs
        DOUT                  => DOUT,
        FULL                  => FULL,
        ALMOST_FULL           => ALMOST_FULL,
        WR_ACK                => WR_ACK,
        OVERFLOW              => OVERFLOW,
        EMPTY                 => EMPTY,
        ALMOST_EMPTY          => ALMOST_EMPTY,
        VALID                 => VALID,
        UNDERFLOW             => UNDERFLOW,
        RD_DATA_COUNT         => rd_data_count_fifo_out,
        WR_DATA_COUNT         => wr_data_count_fifo_out,
        PROG_FULL             => PROG_FULL,
        PROG_EMPTY            => PROG_EMPTY
        );

  END GENERATE gen_other;


  -----------------------------------------------------------------------------
  -- Connect Internal Signals
  --  In the normal case, these signals tie directly to the FIFO's inputs and
  --  outputs.
  --  In the case of Preload Latency 0 or 1, these are the intermediate
  --  signals between the internal FIFO and the preload logic.
  -----------------------------------------------------------------------------
  latnrm: IF (C_PRELOAD_REGS=0) GENERATE
     rd_en_fifo_in <= RD_EN;
     DOUT          <= dout_fifo_out;
     VALID         <= valid_fifo_out;
     EMPTY         <= empty_fifo_out;
     ALMOST_EMPTY  <= almost_empty_fifo_out;
     UNDERFLOW     <= underflow_fifo_out;
     RD_DATA_COUNT <= rd_data_count_fifo_out;
     WR_DATA_COUNT <= wr_data_count_fifo_out;
  END GENERATE latnrm;


  lat0: IF ((C_PRELOAD_REGS = 1) AND (C_PRELOAD_LATENCY = 0)) GENERATE

    lat0logic : fifo_generator_v2_2_bhv_preload0
      GENERIC MAP (
        C_DOUT_RST_VAL      => C_DOUT_RST_VAL,
        C_DOUT_WIDTH        => C_DOUT_WIDTH,
        C_USERVALID_LOW     => C_VALID_LOW,
        C_USERUNDERFLOW_LOW => C_UNDERFLOW_LOW)
      PORT MAP (
        RD_CLK          => RD_CLK,
        RD_RST          => RST,
        RD_EN           => RD_EN,
        FIFOEMPTY       => empty_fifo_out,
        FIFODATA        => dout_fifo_out,
        USERDATA        => dout_p0_out,
        USERVALID       => valid_p0_out,
        USEREMPTY       => empty_p0_out,
        USERALMOSTEMPTY => almost_empty_p0_out,
        USERUNDERFLOW   => underflow_p0_out,
        RAMVALID        => ram_valid, --Used for observing the state of the ram_valid
        FIFORDEN        => rd_en_fifo_in);

    rdcg: if (C_RD_DATA_COUNT_WIDTH>C_RD_PNTR_WIDTH) generate
      eclk: process (RD_CLK)
      begin  -- process eclk
        if (RST='1') then
          empty_p0_out_q <= '1';
          almost_empty_p0_out_q <= '1';
        elsif RD_CLK'event and RD_CLK = '1' then  -- rising clock edge
          empty_p0_out_q <= empty_p0_out;
          almost_empty_p0_out_q <= almost_empty_p0_out;
         end if;
      end process eclk;

      rcsproc: process (rd_data_count_fifo_out, empty_p0_out_q, almost_empty_p0_out_q)
      begin  -- process rcsproc
        if (empty_p0_out_q='1' or RST='1') then
          RD_DATA_COUNT <= int_2_std_logic_vector(0, C_RD_DATA_COUNT_WIDTH);
        elsif (almost_empty_p0_out_q='1') then
          RD_DATA_COUNT <= int_2_std_logic_vector(1, C_RD_DATA_COUNT_WIDTH);
        else
          RD_DATA_COUNT <= rd_data_count_fifo_out + int_2_std_logic_vector(2, C_RD_DATA_COUNT_WIDTH);
        end if;
      end process rcsproc;
    end generate rdcg;
    nrdcg: if (C_RD_DATA_COUNT_WIDTH<=C_RD_PNTR_WIDTH) generate
      RD_DATA_COUNT <= rd_data_count_fifo_out;
    end generate nrdcg;

    wdcg: if (C_WR_DATA_COUNT_WIDTH>C_WR_PNTR_WIDTH) generate
      WR_DATA_COUNT <= wr_data_count_fifo_out + int_2_std_logic_vector(2, C_WR_DATA_COUNT_WIDTH);
    end generate wdcg;
    nwdcg: if (C_WR_DATA_COUNT_WIDTH<=C_WR_PNTR_WIDTH) generate
      WR_DATA_COUNT <= wr_data_count_fifo_out;
    end generate nwdcg;

     DOUT          <= dout_p0_out;
     VALID         <= valid_p0_out;
     EMPTY         <= empty_p0_out;
     ALMOST_EMPTY  <= almost_empty_p0_out;
     UNDERFLOW     <= underflow_p0_out;

  END GENERATE lat0;




END behavioral;



-------------------------------------------------------------------------------
-- $RCSfile$
-------------------------------------------------------------------------------
--
-- Fifo Generator - VHDL Behavioral Model Component Declaration
--
-------------------------------------------------------------------------------
--
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under
-- license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid
-- license agreement with Xilinx, Inc. Xilinx hereby
-- grants you a license to use this text/file solely for
-- design, simulation, implementation and creation of
-- design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly
-- prohibited and immediately terminates your license unless
-- covered by a separate agreement.
--
-- Xilinx is providing theis design, code, or information
-- "as-is" solely for use in developing programs and
-- solutions for Xilinx devices, with no obligation on the
-- part of Xilinx to provide support. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard. Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for obtaining
-- any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
--
-- Any modifications that are made to the Source Code are
-- done at the user's sole risk and will be unsupported.
-- The Xilinx Support Hotline does not have access to source
-- code and therefore cannot answer specific questions related
-- to source HDL. The Xilinx Hotline support of original source
-- code IP shall only address issues and questions related
-- to source HDL. The Xilinx Hotline support of original source
-- code IP shall only address issues and questions related
-- to standard Netlist version of the core (and thus
-- indirectly, the original core source).
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c)Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Filename: fifo__generator_v2_1_comp.vhd
--
-- Description:
--  The behavioral model for the FIFO Generator core.
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE fifo_generator_v2_2_comp IS

 COMPONENT fifo_generator_v2_2
  GENERIC (
    --------------------------------------------------------------------------------
    -- Generic Declarations (alphabetical)
    --------------------------------------------------------------------------------
    C_COMMON_CLOCK                : integer := 0;
    C_COUNT_TYPE                  : integer := 0;
    C_DATA_COUNT_WIDTH            : integer := 2;
    C_DEFAULT_VALUE               : string  := "";
    C_DIN_WIDTH                   : integer := 8;
    C_DOUT_RST_VAL                : string  := "";
    C_DOUT_WIDTH                  : integer := 8;
    C_ENABLE_RLOCS                : integer := 0;
    C_FAMILY                      : string  := "";
    C_HAS_ALMOST_EMPTY            : integer := 0;
    C_HAS_ALMOST_FULL             : integer := 0;
    C_HAS_BACKUP                  : integer := 0;
    C_HAS_DATA_COUNT              : integer := 0;
    C_HAS_MEMINIT_FILE            : integer := 0;
    C_HAS_OVERFLOW                : integer := 0;
    C_HAS_RD_DATA_COUNT           : integer := 0;
    C_HAS_RD_RST                  : integer := 0;
    C_HAS_RST                     : integer := 1;
    C_HAS_UNDERFLOW               : integer := 0;
    C_HAS_VALID                   : integer := 0;
    C_HAS_WR_ACK                  : integer := 0;
    C_HAS_WR_DATA_COUNT           : integer := 0;
    C_HAS_WR_RST                  : integer := 0;
    C_IMPLEMENTATION_TYPE         : integer := 0;
    C_INIT_WR_PNTR_VAL            : integer := 0;
    C_MEMORY_TYPE                 : integer := 1;
    C_MIF_FILE_NAME               : string  := "";
    C_OPTIMIZATION_MODE           : integer := 0;
    C_OVERFLOW_LOW                : integer := 0;
    C_PRELOAD_REGS                : integer := 0;
    C_PRELOAD_LATENCY             : integer := 1;
    C_PRIM_FIFO_TYPE             : integer := 512;
    C_PROG_EMPTY_THRESH_ASSERT_VAL: integer := 0;
    C_PROG_EMPTY_THRESH_NEGATE_VAL: integer := 0;
    C_PROG_EMPTY_TYPE             : integer := 0;
    C_PROG_FULL_THRESH_ASSERT_VAL : integer := 0;
    C_PROG_FULL_THRESH_NEGATE_VAL : integer := 0;
    C_PROG_FULL_TYPE              : integer := 0;
    C_RD_DATA_COUNT_WIDTH         : integer := 2;
    C_RD_DEPTH                    : integer := 256;
    C_RD_PNTR_WIDTH               : integer := 8;
    C_UNDERFLOW_LOW               : integer := 0;
    C_USE_FIFO16_FLAGS             : integer := 0;
    C_VALID_LOW                   : integer := 0;
    C_WR_ACK_LOW                  : integer := 0;
    C_WR_DATA_COUNT_WIDTH         : integer := 2;
    C_WR_DEPTH                    : integer := 256;
    C_WR_PNTR_WIDTH               : integer := 8;
    C_WR_RESPONSE_LATENCY         : integer := 1
    );


  PORT(
--------------------------------------------------------------------------------
-- Input and Output Declarations
--------------------------------------------------------------------------------
    CLK                       : IN  std_logic := '0';
    BACKUP                    : IN  std_logic := '0';
    BACKUP_MARKER             : IN  std_logic := '0';
    DIN                       : IN  std_logic_vector(C_DIN_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH         : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_ASSERT  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_EMPTY_THRESH_NEGATE  : IN  std_logic_vector(C_RD_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH          : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_ASSERT   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    PROG_FULL_THRESH_NEGATE   : IN  std_logic_vector(C_WR_PNTR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
    RD_CLK                    : IN  std_logic := '0';
    RD_EN                     : IN  std_logic := '0';
    RD_RST                    : IN  std_logic := '0';
    RST                       : IN  std_logic := '0';
    WR_CLK                    : IN  std_logic := '0';
    WR_EN                     : IN  std_logic := '0';
    WR_RST                    : IN  std_logic := '0';

    ALMOST_EMPTY              : OUT std_logic;
    ALMOST_FULL               : OUT std_logic;
    DATA_COUNT                : OUT std_logic_vector(C_DATA_COUNT_WIDTH-1 DOWNTO 0);
    DOUT                      : OUT std_logic_vector(C_DOUT_WIDTH-1 DOWNTO 0);
    EMPTY                     : OUT std_logic;
    FULL                      : OUT std_logic;
    OVERFLOW                  : OUT std_logic;
    PROG_EMPTY                : OUT std_logic;
    PROG_FULL                 : OUT std_logic;
    VALID                     : OUT std_logic;
    RD_DATA_COUNT             : OUT std_logic_vector(C_RD_DATA_COUNT_WIDTH-1 DOWNTO 0);
    UNDERFLOW                 : OUT std_logic;
    WR_ACK                    : OUT std_logic;
    WR_DATA_COUNT             : OUT std_logic_vector(C_WR_DATA_COUNT_WIDTH-1 DOWNTO 0)
    );
 END COMPONENT;

END fifo_generator_v2_2_comp;
