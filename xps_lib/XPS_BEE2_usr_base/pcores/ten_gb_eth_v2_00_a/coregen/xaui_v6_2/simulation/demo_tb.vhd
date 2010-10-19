-------------------------------------------------------------------------------
-- project     : XAUI
-------------------------------------------------------------------------------
-- file        : demo_tb.vhd
-------------------------------------------------------------------------------
-- description : This testbench will exercise the ports of the XAUI core to
--               demonstrate the functionality.
-------------------------------------------------------------------------------
-- Copyright(c) 2005 by xilinx, inc. all rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc. , is distributed by
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc.  This 
-- copyright notice must be retained as part of this text 
-- at all times.
-------------------------------------------------------------------------------
-- This testbench performs the following operations on the XAUI core:
-- data and idle frames of varying length are pushed into the transmit path
-- and are captured at the xgmii rx interface.  the testbench compares the
-- captured frames to those originally sent.
-------------------------------------------------------------------------------

entity testbench is
end testbench;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;
architecture behav of testbench is

-------------------------------------------------------------------------------
-- component declaration of design under test.
-------------------------------------------------------------------------------

  component xaui_v6_2_top
     port (
      reset            : in  std_logic;
      xgmii_txd        : in  std_logic_vector(63 downto 0);
      xgmii_txc        : in  std_logic_vector(7 downto 0);
      xgmii_rxd        : out std_logic_vector(63 downto 0);
      xgmii_rxc        : out std_logic_vector(7 downto 0);
      refclk_p         : in  std_logic;
      refclk_n         : in  std_logic;
      xaui_tx_l0_p     : out std_logic;
      xaui_tx_l0_n     : out std_logic;
      xaui_tx_l1_p     : out std_logic;
      xaui_tx_l1_n     : out std_logic;
      xaui_tx_l2_p     : out std_logic;
      xaui_tx_l2_n     : out std_logic;
      xaui_tx_l3_p     : out std_logic;
      xaui_tx_l3_n     : out std_logic;
      xaui_rx_l0_p     : in  std_logic;
      xaui_rx_l0_n     : in  std_logic;
      xaui_rx_l1_p     : in  std_logic;
      xaui_rx_l1_n     : in  std_logic;
      xaui_rx_l2_p     : in  std_logic;
      xaui_rx_l2_n     : in  std_logic;
      xaui_rx_l3_p     : in  std_logic;
      xaui_rx_l3_n     : in  std_logic;
      signal_detect    : in  std_logic_vector(3 downto 0);
      align_status     : out std_logic;
      sync_status      : out std_logic_vector(3 downto 0);
      configuration_vector : in  std_logic_vector(6 downto 0);
      status_vector        : out std_logic_vector(7 downto 0));
   end component;

  ----------------------------------------------------------------------------
  -- XAUI helper procedures
  ----------------------------------------------------------------------------

  -- Nominal unit interval 
  constant XAUI_UI : time := 320 ps;
  constant K28_0 : std_logic_vector := X"1C";
  constant K28_3 : std_logic_vector := X"7C";
  constant K28_5 : std_logic_vector := X"BC";
  
  -- Decode the 8B10B code. No disparity verification is performed, just a
  -- simple table lookup.
  procedure decode_8b10b (
    constant d10  : in  std_logic_vector(0 to 9);
    variable q8   : out std_logic_vector(7 downto 0);
    variable is_k : out boolean) is
    variable k28 : boolean;
    variable d10_rev : std_logic_vector(9 downto 0);
  begin
    -- reverse the 10B codeword
    for i in 0 to 9 loop
      d10_rev(i) := d10(i);
    end loop;  -- i
    -- do the 6B5B decode
    case d10_rev(5 downto 0) is
      when "000110" =>
        q8(4 downto 0) := "00000";   --D.0
      when "111001" =>
        q8(4 downto 0) := "00000";   --D.0
      when "010001" =>
        q8(4 downto 0) := "00001";   --D.1
      when "101110" =>
        q8(4 downto 0) := "00001";   --D.1
      when "010010" =>
        q8(4 downto 0) := "00010";   --D.2
      when "101101" =>
        q8(4 downto 0) := "00010";   --D.2
      when "100011" =>
        q8(4 downto 0) := "00011";   --D.3
      when "010100" =>
        q8(4 downto 0) := "00100";   --D.4
      when "101011" =>
        q8(4 downto 0) := "00100";   --D.4
      when "100101" =>
        q8(4 downto 0) := "00101";   --D.5
      when "100110" =>
        q8(4 downto 0) := "00110";   --D.6
      when "000111" =>
        q8(4 downto 0) := "00111";   --D.7
      when "111000" =>
        q8(4 downto 0) := "00111";   --D.7
      when "011000" =>
        q8(4 downto 0) := "01000";   --D.8
      when "100111" =>
        q8(4 downto 0) := "01000";   --D.8
      when "101001" =>
        q8(4 downto 0) := "01001";   --D.9
      when "101010" =>
        q8(4 downto 0) := "01010";   --D.10
      when "001011" =>
        q8(4 downto 0) := "01011";   --D.11
      when "101100" =>
        q8(4 downto 0) := "01100";   --D.12
      when "001101" =>
        q8(4 downto 0) := "01101";   --D.13
      when "001110" =>
        q8(4 downto 0) := "01110";   --D.14
      when "000101" =>
        q8(4 downto 0) := "01111";   --D.15
      when "111010" =>
        q8(4 downto 0) := "01111";   --D.15

      when "110110" =>
        q8(4 downto 0) := "10000";    --D.16
      when "001001" =>
        q8(4 downto 0) := "10000";    --D.16
      when "110001" =>
        q8(4 downto 0) := "10001";    --D.17
      when "110010" =>
        q8(4 downto 0) := "10010";    --D.18
      when "010011" =>
        q8(4 downto 0) := "10011";    --D.19
      when "110100" =>
        q8(4 downto 0) := "10100";    --D.20
      when "010101" =>
        q8(4 downto 0) := "10101";    --D.21
      when "010110" =>
        q8(4 downto 0) := "10110";    --D.22
      when "010111" =>
        q8(4 downto 0) := "10111";    --D/K.23
      when "101000" =>
        q8(4 downto 0) := "10111";    --D/K.23
      when "001100" =>
        q8(4 downto 0) := "11000";    --D.24
      when "110011" =>
        q8(4 downto 0) := "11000";    --D.24
      when "011001" =>
        q8(4 downto 0) := "11001";    --D.25
      when "011010" =>
        q8(4 downto 0) := "11010";    --D.26
      when "011011" =>
        q8(4 downto 0) := "11011";    --D/K.27
      when "100100" =>
        q8(4 downto 0) := "11011";    --D/K.27
      when "011100" =>
        q8(4 downto 0) := "11100";    --D.28
      when "111100" =>
        q8(4 downto 0) := "11100";    --K.28
      when "000011" =>
        q8(4 downto 0) := "11100";    --K.28
      when "011101" =>
        q8(4 downto 0) := "11101";    --D/K.29
      when "100010" =>
        q8(4 downto 0) := "11101";    --D/K.29
      when "011110" =>
        q8(4 downto 0) := "11110";    --D.30
      when "100001" =>
        q8(4 downto 0) := "11110";    --D.30
      when "110101" =>
        q8(4 downto 0) := "11111";    --D.31
      when "001010" =>
        q8(4 downto 0) := "11111";    --D.31
        
      when others   =>
        q8(4 downto 0) := "11110";  --CODE VIOLATION - return /E/
    end case;

    k28 := not((d10(2) OR d10(3) OR d10(4) OR d10(5)
                OR NOT(d10(8) XOR d10(9)))) = '1';
    
    -- do the 4B3B decode
    case d10_rev(9 downto 6) is
      when "0010" =>
        q8(7 downto 5) := "000";       --D/K.x.0
      when "1101" =>
        q8(7 downto 5) := "000";       --D/K.x.0
      when "1001" =>
        if not k28 then
          q8(7 downto 5) := "001";               --D/K.x.1
        else
          q8(7 downto 5) := "110";               --K28.6
        end if;
      when "0110" =>
        if k28 then
          q8(7 downto 5) := "001";               --K.28.1
        else
          q8(7 downto 5) := "110";               --D/K.x.6
        end if;
      when "1010" =>
        if not k28 then
          q8(7 downto 5) := "010";               --D/K.x.2
        else
          q8(7 downto 5) := "101";               --K28.5
        end if;
      when "0101" =>
        if k28 then
          q8(7 downto 5) := "010";               --K28.2
        else
          q8(7 downto 5) := "101";               --D/K.x.5
        end if;
      when "0011" =>
        q8(7 downto 5) := "011";       --D/K.x.3
      when "1100" =>
        q8(7 downto 5) := "011";       --D/K.x.3
      when "0100" =>
        q8(7 downto 5) := "100";       --D/K.x.4
      when "1011" =>
        q8(7 downto 5) := "100";       --D/K.x.4
      when "0111" =>
        q8(7 downto 5) := "111";       --D.x.7
      when "1000" =>
        q8(7 downto 5) := "111";       --D.x.7
      when "1110" =>
        q8(7 downto 5) := "111";       --D/K.x.7
      when "0001" =>
        q8(7 downto 5) := "111";       --D/K.x.7
      when others =>
        q8(7 downto 5) := "111";   --CODE VIOLATION - return /E/
    end case;
    is_k := ((d10(2) and d10(3) and d10(4) and d10(5))
            or not (d10(2) or d10(3) or d10(4) or d10(5))
            or ((d10(4) xor d10(5))
                and ((d10(5) and d10(7) and d10(8) and d10(9))
                     or not(d10(5) or d10(7) or d10(8) or d10(9))))) = '1' ;
  end decode_8b10b;

  function to_stdlogic (
    constant b : boolean)
    return std_logic is
  begin  -- to_stdlogic
    if b then
      return '1';
    else
      return '0';
    end if;
  end to_stdlogic;
  
  function is_comma (
    constant codegroup : std_logic_vector(0 to 9))
    return boolean is
  begin  -- is_comma
    case codegroup(0 to 6) is
      when "0011111" =>
        return true;
      when "1100000" =>
        return true;
      when others =>
        return false;
    end case;
  end is_comma;

  procedure lane_decode (
    signal bitclock : in  std_logic;
    signal sdata    : in  std_logic;
    signal pdata    : out std_logic_vector(7 downto 0);
    signal is_k     : out std_logic) is
    variable code_buffer : std_logic_vector(0 to 9);
    variable decoded_data : std_logic_vector(7 downto 0);
    variable bit_count : integer;
    variable is_k_var, initial_sync : boolean;
  begin  -- lane_decode
    bit_count := 0;
    initial_sync := false;
    loop 
      wait on bitclock;
      code_buffer := code_buffer(1 to 9) & sdata;
      -- comma detection
      if is_comma(code_buffer) then
        bit_count := 0;
        initial_sync := true;
      end if;
      if bit_count = 0 and initial_sync then
        decode_8b10b(
          d10  => code_buffer,
          q8   => decoded_data,
          is_k => is_k_var);
        -- drive the output signals with the results
        pdata <= decoded_data;
        is_k <= to_stdlogic(is_k_var);
      end if;
      
      if initial_sync then
        bit_count := bit_count + 1;
        if bit_count = 10 then
          bit_count := 0;
        end if;
      end if;
    end loop;
    
  end lane_decode;

  procedure encode_8b10b (
    constant d8                : in  std_logic_vector(7 downto 0);
    constant is_k              : in  boolean;
    variable q10               : out std_logic_vector(0 to 9);
    constant disparity_pos_in  : in  boolean;
    variable disparity_pos_out : out boolean) is
    variable b6                       : std_logic_vector(5 downto 0);
    variable b4                       : std_logic_vector(3 downto 0);
    variable k28, pdes6, a7, l13, l31 : boolean;
    variable a, b, c, d, e            : boolean;
  begin  -- encode_8b10b
    -- precalculate some common terms
    a := d8(0) = '1';
    b := d8(1) = '1';
    c := d8(2) = '1';
    d := d8(3) = '1';
    e := d8(4) = '1';

    k28 := is_k and d8(4 downto 0) = "11100";
    l13 := (((a xor b) and not (c or d))
            or ((c xor d) and not(a or b)));

    l31 := (((a xor b) and (c and d))
             or
             ((c xor d) and (a and b)));

    a7 := is_k or ((l31 and d and not e and disparity_pos_in)
                   or (l13 and not d and e and not disparity_pos_in));

    --------------------------------------------------------------------------
    -- Do the 5B/6B conversion (calculate the 6b symbol)
    --------------------------------------------------------------------------
    if k28 then                         --K.28
      if not disparity_pos_in then
        b6 := "111100";
      else
        b6 := "000011";
      end if;
    else
      case d8(4 downto 0) is
        when "00000" =>                 --D.0
          if disparity_pos_in then
            b6 := "000110";
          else
            b6 := "111001";
          end if;
        when "00001" =>                 --D.1
          if disparity_pos_in then
            b6 := "010001";
          else
            b6 := "101110";
          end if;
        when "00010" =>                 --D.2
          if disparity_pos_in then
            b6 := "010010";
          else
            b6 := "101101";
          end if;
        when "00011" =>
          b6 := "100011";               --D.3
        when "00100" =>                 --D.4
          if disparity_pos_in then
            b6 := "010100";
          else
            b6 := "101011";
          end if;
        when "00101" =>
          b6 := "100101";               --D.5
        when "00110" =>
          b6 := "100110";               --D.6
        when "00111" =>                 --D.7   
          if not disparity_pos_in then
            b6 := "000111";
          else
            b6 := "111000";
          end if;
        when "01000" =>                 --D.8
          if disparity_pos_in then
            b6 := "011000";
          else
            b6 := "100111";
          end if;
        when "01001" =>
          b6 := "101001";               --D.9
        when "01010" =>
          b6 := "101010";               --D.10
        when "01011" =>
          b6 := "001011";               --D.11
        when "01100" =>
          b6 := "101100";               --D.12
        when "01101" =>
          b6 := "001101";               --D.13
        when "01110" =>
          b6 := "001110";               --D.14
        when "01111" =>                 --D.15
          if disparity_pos_in then
            b6 := "000101";
          else
            b6 := "111010";
          end if;
        when "10000" =>                 --D.16
          if not disparity_pos_in then
            b6 := "110110";
          else
            b6 := "001001";
          end if;
        when "10001" =>
          b6 := "110001";               --D.17
        when "10010" =>
          b6 := "110010";               --D.18
        when "10011" =>
          b6 := "010011";               --D.19
        when "10100" =>
          b6 := "110100";               --D.20
        when "10101" =>
          b6 := "010101";               --D.21
        when "10110" =>
          b6 := "010110";               --D.22
        when "10111" =>                 --D/K.23
          if not disparity_pos_in then
            b6 := "010111";
          else
            b6 := "101000";
          end if;
        when "11000" =>                 --D.24
          if disparity_pos_in then
            b6 := "001100";
          else
            b6 := "110011";
          end if;
        when "11001" =>
          b6 := "011001";               --D.25
        when "11010" =>
          b6 := "011010";               --D.26
        when "11011" =>                 --D/K.27
          if not disparity_pos_in then
            b6 := "011011";
          else
            b6 := "100100";
          end if;
        when "11100" =>
          b6 := "011100";               --D.28
        when "11101" =>                 --D/K.29
          if not disparity_pos_in then
            b6 := "011101";
          else
            b6 := "100010";
          end if;
        when "11110" =>                 --D/K.30
          if not disparity_pos_in then
            b6 := "011110";
          else
            b6 := "100001";
          end if;
        when "11111" =>                 --D.31
          if not disparity_pos_in then
            b6 := "110101";
          else
            b6 := "001010";
          end if;
        when others =>
          b6 := "XXXXXX";
      end case;
    end if;

    -- reverse the bits
    for i in 0 to 5 loop
      q10(i) := b6(i);
    end loop;  -- i

    -- calculate the running disparity after the 5B6B block encode
    if k28 then
      pdes6 := not disparity_pos_in;
    else
      case d8(4 downto 0) is
        when "00000" => pdes6 := not disparity_pos_in;
        when "00001" => pdes6 := not disparity_pos_in;
        when "00010" => pdes6 := not disparity_pos_in;
        when "00011" => pdes6 := disparity_pos_in;
        when "00100" => pdes6 := not disparity_pos_in;
        when "00101" => pdes6 := disparity_pos_in;
        when "00110" => pdes6 := disparity_pos_in;
        when "00111" => pdes6 := disparity_pos_in;

        when "01000" => pdes6 := not disparity_pos_in;
        when "01001" => pdes6 := disparity_pos_in;
        when "01010" => pdes6 := disparity_pos_in;
        when "01011" => pdes6 := disparity_pos_in;
        when "01100" => pdes6 := disparity_pos_in;
        when "01101" => pdes6 := disparity_pos_in;
        when "01110" => pdes6 := disparity_pos_in;
        when "01111" => pdes6 := not disparity_pos_in;

        when "10000" => pdes6 := not disparity_pos_in;
        when "10001" => pdes6 := disparity_pos_in;
        when "10010" => pdes6 := disparity_pos_in;
        when "10011" => pdes6 := disparity_pos_in;
        when "10100" => pdes6 := disparity_pos_in;
        when "10101" => pdes6 := disparity_pos_in;
        when "10110" => pdes6 := disparity_pos_in;
        when "10111" => pdes6 := not disparity_pos_in;

        when "11000" => pdes6 := not disparity_pos_in;
        when "11001" => pdes6 := disparity_pos_in;
        when "11010" => pdes6 := disparity_pos_in;
        when "11011" => pdes6 := not disparity_pos_in;
        when "11100" => pdes6 := disparity_pos_in;
        when "11101" => pdes6 := not disparity_pos_in;
        when "11110" => pdes6 := not disparity_pos_in;
        when "11111" => pdes6 := not disparity_pos_in;
        when others  => pdes6 := disparity_pos_in;
      end case;
    end if;

    case d8(7 downto 5) is
      when "000" =>                     --D/K.x.0
        if pdes6 then
          b4 := "0010";
        else
          b4 := "1101";
        end if;
      when "001" =>                     --D/K.x.1
        if k28 and not pdes6 then
          b4 := "0110";
        else
          b4 := "1001";
        end if;
      when "010" =>                     --D/K.x.2
        if k28 and not pdes6 then
          b4 := "0101";
        else
          b4 := "1010";
        end if;
      when "011" =>                     --D/K.x.3
        if not pdes6 then
          b4 := "0011";
        else
          b4 := "1100";
        end if;
      when "100" =>                     --D/K.x.4
        if pdes6 then
          b4 := "0100";
        else
          b4 := "1011";
        end if;
      when "101" =>                     --D/K.x.5
        if k28 and not pdes6 then
          b4 := "1010";
        else
          b4 := "0101";
        end if;
      when "110" =>                     --D/K.x.6
        if k28 and not pdes6 then
          b4 := "1001";
        else
          b4 := "0110";
        end if;
      when "111" =>                     --D.x.P7
        if not a7 then
          if not pdes6 then
            b4 := "0111";
          else
            b4 := "1000";
          end if;
        else                            --D/K.y.A7
          if not pdes6 then
            b4 := "1110";
          else
            b4 := "0001";
          end if;
        end if;
      when others =>
        b4 := "XXXX";
    end case;

    -- Reverse the bits
    for i in 0 to 3 loop
      q10(i+6) := b4(i);
    end loop;  -- i

    -- Calculate the running disparity after the 4B group
    case d8(7 downto 5) is
      when "000"  =>
        disparity_pos_out := not pdes6;
      when "001"  =>
        disparity_pos_out := pdes6;
      when "010"  =>
        disparity_pos_out := pdes6;
      when "011"  =>
        disparity_pos_out := pdes6;
      when "100"  =>
        disparity_pos_out := not pdes6;
      when "101"  =>
        disparity_pos_out := pdes6;
      when "110"  =>
        disparity_pos_out := pdes6;
      when "111"  =>
        disparity_pos_out := not pdes6;
      when others =>
        disparity_pos_out := pdes6;
    end case;
    
  end encode_8b10b;

-------------------------------------------------------------------------------
-- constants, signals, etc.
-------------------------------------------------------------------------------

   constant idle   : bit_vector := x"07";
   constant start  : bit_vector := x"fb";
   constant term   : bit_vector := x"fd";
   constant data_a : bit_vector := x"aa";
   constant data_5 : bit_vector := x"55";

   constant clocktick    : time := 6400 ps;
   

   signal reset                : std_logic;

   signal refclk_p             : std_logic;
   signal refclk_n             : std_logic;

   signal xgmii_txd : std_logic_vector(63 downto 0);
   signal xgmii_txc : std_logic_vector(7 downto 0);
   signal xgmii_rxd : std_logic_vector(63 downto 0);
   signal xgmii_rxc : std_logic_vector(7 downto 0);

   signal xaui_tx_l0_p, xaui_tx_l0_n : std_logic;
   signal xaui_tx_l1_p, xaui_tx_l1_n : std_logic;
   signal xaui_tx_l2_p, xaui_tx_l2_n : std_logic;
   signal xaui_tx_l3_p, xaui_tx_l3_n : std_logic;
   signal xaui_rx_l0_p, xaui_rx_l0_n : std_logic;
   signal xaui_rx_l1_p, xaui_rx_l1_n : std_logic;
   signal xaui_rx_l2_p, xaui_rx_l2_n : std_logic;
   signal xaui_rx_l3_p, xaui_rx_l3_n : std_logic;

   signal signal_detect        : std_logic_vector(3 downto 0);
   signal align_status         : std_logic;
   signal sync_status          : std_logic_vector(3 downto 0);
   signal configuration_vector : std_logic_vector(6 downto 0);
   signal status_vector        : std_logic_vector(7 downto 0);

   signal xaui_tx_bitclock : std_logic;
   signal xaui_tx_pdata    : std_logic_vector(31 downto 0);
   signal xaui_tx_is_k     : std_logic_vector(3 downto 0);


   signal tx_monitor_finished : boolean := false;
   signal rx_monitor_finished : boolean := false;
   signal simulation_finished : boolean := false;
   signal frame_index  : integer   :=  0;
   signal end_of_frame : std_logic := '0';
   signal good_frame   : std_logic := '1';
   signal bad_frame    : std_logic := '0';   

   type column_typ is record
                        d : bit_vector(31 downto 0);
                        c : bit_vector(3 downto 0);
                      end record;

   type column_array_typ is array (natural range <>) of column_typ;

   type frame_typ is record
                       stim : column_array_typ(0 to 31);
                       length : integer;
                     end record;

   type frame_typ_array is array (natural range 0 to 3) of frame_typ;

-------------------------------------------------------------------------------
-- define the stimulus the testbench will utilise.
-------------------------------------------------------------------------------

   constant frame_data : frame_typ_array := (
      0      => ( -- frame 0
        stim => (
           0 => ( d => X"111111" & start, c => X"1" ),
           1 => ( d => X"22222222", c => X"0" ),
           2 => ( d => X"33333333", c => X"0" ),
           3 => ( d => X"44444444", c => X"0" ),
           4 => ( d => X"55555555", c => X"0" ),
           5 => ( d => X"66666666", c => X"0" ),
           6 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           7 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
           8 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           9 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          10 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          11 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          12 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          13 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          14 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          15 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          16 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          17 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          18 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          19 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          20 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          21 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          22 => ( d => term   & data_5 & data_5 & data_5, c => X"8" ),
      others => ( d => (others => '0'),                   c => X"0")),
      length => 23),
      1      => ( -- frame 1
        stim => (
           0 => ( d => X"111111" & start,      c => "0001" ),
           1 => ( d => X"22222222", c => X"0" ),
           2 => ( d => X"33333333", c => X"0" ),
           3 => ( d => X"44444444", c => X"0" ),
           4 => ( d => X"55555555", c => X"0" ),
           5 => ( d => X"66666666", c => X"0" ),
           6 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           7 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
           8 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           9 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          10 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          11 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          12 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          13 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          14 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          15 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          16 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          17 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          18 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          19 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          20 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          21 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          22 => ( d => idle   & term   & data_5 & data_5, c => X"C" ),
      others => ( d => (others => '0'),                   c => X"0")),
      length => 23),
      2      => ( -- frame 2
        stim => (
           0 => ( d => X"11" & X"11" & X"11" & start, c => X"1" ),
           1 => ( d => X"22222222", c => X"0" ),
           2 => ( d => X"33333333", c => X"0" ),
           3 => ( d => X"44444444", c => X"0" ),
           4 => ( d => X"55555555", c => X"0" ),
           5 => ( d => X"66666666", c => X"0" ),
           6 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           7 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
           8 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           9 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          10 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          11 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          12 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          13 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          14 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          15 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          16 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          17 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          18 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          19 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          20 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          21 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          22 => ( d => idle   & idle   & term   & data_5, c => X"E" ),
      others => ( d => (others => '0'),                   c => X"0")),
      length => 23),
      3      => ( -- frame 3
        stim => (
           0 => ( d => X"111111" & start,      c => X"1" ),
           1 => ( d => X"22222222", c => X"0" ),
           2 => ( d => X"33333333", c => X"0" ),
           3 => ( d => X"44444444", c => X"0" ),
           4 => ( d => X"55555555", c => X"0" ),
           5 => ( d => X"66666666", c => X"0" ),
           6 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           7 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
           8 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
           9 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          10 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          11 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          12 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          13 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          14 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          15 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          16 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          17 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          18 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          19 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          20 => ( d => data_a & data_a & data_a & data_a, c => X"0" ),
          21 => ( d => data_5 & data_5 & data_5 & data_5, c => X"0" ),
          22 => ( d => idle   & idle   & idle   & term,   c => X"F" ),
      others => ( d => (others => '0'),                   c => X"0")),
      length => 23));

   signal read_back : frame_typ_array := (
      0         => (                       -- frame 0
         stim   => (others => ( d => (others => '0'), c => X"0")),
         length => 0),
      1         => (                       -- frame 1
         stim   => (others => ( d => (others => '0'), c => X"0")),
         length => 0),
      2         => (                       -- frame 2
         stim   => (others => ( d => (others => '0'), c => X"0")),
         length => 0),
      3         => (                       -- frame 3
         stim   => (others => ( d => (others => '0'), c => X"0")),
         length => 0));

-------------------------------------------------------------------------------
-- connect the design under test to the signals in the testbench.
-------------------------------------------------------------------------------

begin  -- behav




   dut : xaui_v6_2_top
      port map (
         reset           => reset,
         --------------------------------------------------------------
         -- xgmii interface
         xgmii_txd       => xgmii_txd,
         xgmii_txc       => xgmii_txc,
         xgmii_rxd       => xgmii_rxd,
         xgmii_rxc       => xgmii_rxc,
         --------------------------------------------------------------
         -- xaui interface

         refclk_p        => refclk_p,
         refclk_n        => refclk_n,
         xaui_tx_l0_p    => xaui_tx_l0_p,
         xaui_tx_l0_n    => xaui_tx_l0_n,
         xaui_tx_l1_p    => xaui_tx_l1_p,
         xaui_tx_l1_n    => xaui_tx_l1_n,
         xaui_tx_l2_p    => xaui_tx_l2_p,
         xaui_tx_l2_n    => xaui_tx_l2_n,
         xaui_tx_l3_p    => xaui_tx_l3_p,
         xaui_tx_l3_n    => xaui_tx_l3_n,
         xaui_rx_l0_p    => xaui_rx_l0_p,
         xaui_rx_l0_n    => xaui_rx_l0_n,
         xaui_rx_l1_p    => xaui_rx_l1_p,
         xaui_rx_l1_n    => xaui_rx_l1_n,
         xaui_rx_l2_p    => xaui_rx_l2_p,
         xaui_rx_l2_n    => xaui_rx_l2_n,
         xaui_rx_l3_p    => xaui_rx_l3_p,
         xaui_rx_l3_n    => xaui_rx_l3_n,
         signal_detect   => signal_detect,
         align_status    => align_status,
         sync_status     => sync_status,
         -------------------------------------------------------------
         -- Configuration and status vectors
         configuration_vector => configuration_vector,
         status_vector => status_vector);

   signal_detect <= "1111";

   configuration_vector <= (others => '0');

-------------------------------------------------------------------------------
-- generate the clock signals.
-------------------------------------------------------------------------------
   
   gen_refclk : process
   begin
      refclk_p <= '0';
      refclk_n <= '1';
      wait for clocktick/2;
      refclk_p <= '1';
      refclk_n <= '0';
      wait for clocktick/2;
   end process gen_refclk;





-------------------------------------------------------------------------------
-- using the defined stimulus in the frame_data array, stimulate the xgmii
-------------------------------------------------------------------------------

   p_xgmii_tx_stimulus : process
 
      variable cached_column_valid : boolean := false;
      variable cached_column_data : std_logic_vector(31 downto 0);
      variable cached_column_ctrl : std_logic_vector(3 downto 0);

      procedure send_column (
         constant d : in std_logic_vector(31 downto 0);
         constant c : in std_logic_vector(3 downto 0)) is
      begin  -- send_column
         if cached_column_valid then
            wait until refclk_p = '1';
            wait for 2.8 ns;
            xgmii_txd(31 downto 0) <= cached_column_data;
            xgmii_txc(3 downto 0) <= cached_column_ctrl;
            xgmii_txd(63 downto 32) <= d;
            xgmii_txc(7 downto 4) <= c;
            cached_column_valid := false;
         else
            cached_column_data := d;
            cached_column_ctrl := c;
            cached_column_valid := true;
         end if;
      end send_column;

      procedure send_column (
         constant c : in column_typ) is
      begin  -- send_column
         send_column(to_stdlogicvector(c.d),
                     to_stdlogicvector(c.c));  -- invert "data_valid" sense
      end send_column;

      procedure send_idle is
      begin  -- send_idle
         send_column(X"07070707", "1111");
      end send_idle;

      procedure send_frame (
         constant frame : in frame_typ) is
         variable column_index : integer;
      begin  -- send_frame
         column_index := 0;

         while column_index < frame.length loop
            send_column(frame.stim(column_index));
            column_index := column_index + 1;
         end loop;

         assert false
           report "Transmitter: frame inserted into XGMII interface"
           severity note;

      end send_frame;

   begin
      while reset /= '0' loop
         send_idle;        
      end loop;
 
      -- wait until the receiver has synced up
      -- This isn't strictly necessary but it leads to data flowing in both 
      -- directions simultaneously
      while align_status /= '1' loop
         send_idle;
      end loop;

      for i in frame_data'low to frame_data'high loop
         send_frame(frame_data(i));
         send_idle;
         send_idle;
      end loop;  -- i

      while true loop
         send_idle;
      end loop;

   end process p_xgmii_tx_stimulus;

-----------------------------------------------------------------------------
-- Four independent processes synchronize and decode the 4 lanes of the XAUI
-- data stream.
-----------------------------------------------------------------------------

   p_xaui_decode_lane0: process
   begin  -- process p_xaui_decode_lane0
      lane_decode(
         bitclock => xaui_tx_bitclock,
         sdata => xaui_tx_l0_p,
         pdata => xaui_tx_pdata(7 downto 0),
         is_k  => xaui_tx_is_k(0));
   end process p_xaui_decode_lane0;

   p_xaui_decode_lane1: process
   begin  -- process p_xaui_decode_lane1
      lane_decode(
         bitclock => xaui_tx_bitclock,
         sdata => xaui_tx_l1_p,
         pdata => xaui_tx_pdata(15 downto 8),
         is_k  => xaui_tx_is_k(1));
   end process p_xaui_decode_lane1;
  
   p_xaui_decode_lane2: process
   begin  -- process p_xaui_decode_lane2
      lane_decode(
         bitclock => xaui_tx_bitclock,
         sdata => xaui_tx_l2_p,
         pdata => xaui_tx_pdata(23 downto 16),
         is_k  => xaui_tx_is_k(2));
   end process p_xaui_decode_lane2;
  
   p_xaui_decode_lane3: process
   begin  -- process p_xaui_decode_lane3
      lane_decode(
         bitclock => xaui_tx_bitclock,
         sdata => xaui_tx_l3_p,
         pdata => xaui_tx_pdata(31 downto 24),
         is_k  => xaui_tx_is_k(3));
   end process p_xaui_decode_lane3;

   -- The following process generates a bitclock for sampling the XAUI streams.
   -- It uses the lane 0 transmit signal, waits for 20 transitions to allow the
   -- stream to stabilise, then centres the xaui_tx_bitclock transition in the
   -- centre of the transmit eye. This signal is used as a sampling point by the
   -- 4 lane processes.
   p_xaui_tx_bitclock : process
   begin
      xaui_tx_bitclock <= '0';
      for i in 1 to 20 loop
         wait on xaui_tx_l0_p;
      end loop;  -- i
      wait for xaui_ui / 2.0;
      loop
         xaui_tx_bitclock <= not xaui_tx_bitclock;
         wait for xaui_ui;
      end loop;
   end process p_xaui_tx_bitclock;

   p_xaui_tx_monitor : process
      -----------------------------------------------------------------
      -- This XAUI decode functional procedure assumes that there is no
      -- skew beween the lanes. It does not follow the XAUI
      -- specification exactly.
      -----------------------------------------------------------------
      procedure get_next_column (
         variable d : out std_logic_vector(31 downto 0);
         variable c : out std_logic_vector(3 downto 0)) is
      begin  -- get_next_column
         wait on refclk_p;
         -- Filter sequence ordered sets
         if xaui_tx_pdata(7 downto 0) = X"9C" and xaui_tx_is_k(0) = '1' then
            d := X"07070707";
            c := "1111";
         else
            -- process each lane independently
            for i in 0 to 3 loop
               if xaui_tx_is_k(i) = '1' then
                  if xaui_tx_pdata(i*8+7 downto i*8) = X"1C" or
                     xaui_tx_pdata(i*8+7 downto i*8) = X"7C" or
                     xaui_tx_pdata(i*8+7 downto i*8) = X"BC" then

                     d(i*8+7 downto i*8) := X"07";
                     c(i) := '1';

                  elsif xaui_tx_pdata(i*8+7 downto i*8) = X"FB" or
                     xaui_tx_pdata(i*8+7 downto i*8) = X"FD" then

                     d(i*8+7 downto i*8) := xaui_tx_pdata(i*8+7 downto i*8);
                     c(i) := '1';
                  else
                     d(i*8+7 downto i*8) := X"FE";
                     c(i) := '1';             
                  end if;
               else
                  -- data codegroup
                  d(i*8+7 downto i*8) := xaui_tx_pdata(i*8+7 downto i*8);
                  c(i) := xaui_tx_is_k(i);
               end if;
            end loop;  -- i
         end if;
      end get_next_column;

      procedure check_frame (
         constant frame : in frame_typ) is
         variable d : std_logic_vector(31 downto 0) := X"07070707";
         variable c : std_logic_vector(3 downto 0) := "1111";
         variable column_index, lane_index : integer;
      begin
         -- Wait for start code
         while not (d(7 downto 0) = X"FB" and c(0) = '1') loop
           get_next_column(d,c);
         end loop;
         column_index := 0;
         -- test all columns except the final one of the frame
         while column_index < frame.length-1 loop
            if d /= to_stdlogicvector(frame.stim(column_index).d) then
               -- only report an error if it should be an intact frame
               assert false
                  report "Transmit fail: data mismatch at XAUI serial interface"
                  severity error;

               return;                       -- end of comparison for this frame
            end if;
            column_index := column_index + 1;
            get_next_column(d,c);
         end loop;

         -- now deal with the final partial column
         lane_index := 0;
         while frame.stim(column_index).c(lane_index) = '0' loop
            if d(lane_index*8+7 downto lane_index*8) /=
               to_stdlogicvector(frame.stim(column_index).d(lane_index*8+7 downto lane_index*8)) then
               assert false
                  report "Transmit fail: data mismatch at XAUI serial interface"
                  severity error;
               return;  -- end of comparison for this frame
            end if;
            lane_index := lane_index + 1;
         end loop;    
  
         assert false
            report "Transmitter: Frame completed at XAUI interface"
            severity note;
      end check_frame;
    
   begin
      for i in frame_data'low to frame_data'high loop
         check_frame(frame_data(i));
      end loop;  -- i
      tx_monitor_finished <= true;
      wait;
   end process p_xaui_tx_monitor;

-----------------------------------------------------------------------------
-- Receive Stimulus process. This process pushes frames of data through the
--  receiver side of the core
-----------------------------------------------------------------------------
   p_xaui_rx_stimulus : process
      variable disp_is_pos : std_logic_vector(0 to 3);
      type IDLE_STATE_TYP is (SEND_K, SEND_RANDOM_R,
                              SEND_RANDOM_K, SEND_RANDOM_A, SEND_DATA);
      variable idle_state : IDLE_STATE_TYP := SEND_K;
      variable next_ifg_is_a : boolean;
      variable a_cnt : integer := 0;
      variable code_sel_generator : std_logic_vector(1 to 7)
         := (others => '1');
      alias code_sel : std_logic is code_sel_generator(7);

   procedure send_10b_column (
      constant d : in std_logic_vector(0 to 39)) is
   begin  -- send_10b_column
      for i in 0 to 9 loop
         xaui_rx_l0_p <= d(i);
         xaui_rx_l0_n <= not d(i);
         xaui_rx_l1_p <= d(i+10);
         xaui_rx_l1_n <= not d(i+10);
         xaui_rx_l2_p <= d(i+20);
         xaui_rx_l2_n <= not d(i+20);
         xaui_rx_l3_p <= d(i+30);
         xaui_rx_l3_n <= not d(i+30);
         wait for XAUI_UI;
      end loop;  -- i
   end send_10b_column;

   procedure update_prbs is
   begin  -- update_prbs
      code_sel_generator := (code_sel_generator(7) xor code_sel_generator(3))
                            & code_sel_generator(1 to 6);
   end update_prbs;

   function is_idle (
      constant d : std_logic_vector(7 downto 0);
      constant c : std_logic)
      return boolean is
   begin  -- is_idle
      if c = '1' then
         case d is
            when K28_0 | K28_3 | K28_5 =>
               return true;
            when others =>
               return false;
         end case;
      else
         return false;
      end if;
   end is_idle;

   procedure send_column (
      constant d : in std_logic_vector(31 downto 0);
      constant c : in std_logic_vector(3 downto 0)) is

      variable codegroups : std_logic_vector(0 to 39);
      variable next_disp_is_pos : boolean;

   begin  -- send_column
      -- encode each character in the column
      for i in 0 to 3 loop
         if d(i*8+7 downto i*8) = X"07" and c(i) = '1' then
            -- convert idles in data columns to K28.5
            encode_8b10b(
               d8                => K28_5,
               is_k              => true,
               disparity_pos_in  => disp_is_pos(i) = '1',
               q10               => codegroups(i*10 to i*10+9),
               disparity_pos_out => next_disp_is_pos);

         else
            -- create codegroup as is
            encode_8b10b(
               d8                => d(i*8+7 downto i*8),
               is_k              => (c(i) = '1'),
               disparity_pos_in  => disp_is_pos(i) = '1',
               q10               => codegroups(i*10 to i*10+9),
               disparity_pos_out => next_disp_is_pos);
         end if;

         if next_disp_is_pos then
            disp_is_pos(i) := '1';
         else
            disp_is_pos(i) := '0';
         end if;
      end loop;  -- i

      send_10b_column(codegroups);

      if d(7 downto 0) = K28_3 and c(0) = '1' then
         -- ||A|| column
         a_cnt := to_integer(unsigned('1' & code_sel_generator(4 to 7)));
      elsif a_cnt > 0 then
         a_cnt := a_cnt - 1;
      end if;

      if not is_idle(d(7 downto 0), c(0)) then
         idle_state := SEND_DATA;
      end if;

      update_prbs;

   end send_column;

   procedure send_column (
      constant c : in column_typ) is
   begin -- send_column
      send_column(to_stdlogicvector(c.d), to_stdlogicvector(c.c));
   end send_column;

   -- Randomizes idles. This state machine is a simplification of the one
   -- published in IEEE 802.3ae_2002.
   procedure get_next_idle_code (
      variable idle_code : out std_logic_vector(7 downto 0)) is
   begin  -- get_next_idle_code
      case idle_state is
         when SEND_DATA =>
            if next_ifg_is_a and a_cnt = 0 then
               -- transition through SEND_A state
               idle_code := K28_3;
               next_ifg_is_a := false;
            else
               -- transition through SEND_K state
               idle_code := K28_5;
               next_ifg_is_a := true;
            end if;

            idle_state := SEND_RANDOM_R;

         when SEND_K =>
            idle_code := K28_5;
            idle_state := SEND_RANDOM_R;
            next_ifg_is_a := true;
          
         when SEND_RANDOM_R =>
            idle_code := K28_0;
            if a_cnt = 0 then
               idle_state := SEND_RANDOM_A;
            elsif code_sel = '1' then
               idle_state := SEND_RANDOM_R;
            else
               idle_state := SEND_RANDOM_K;
            end if;
          
         when SEND_RANDOM_A =>
            idle_code := K28_3;
            if code_sel = '0' then
               idle_state := SEND_RANDOM_K;
            else
               idle_state := SEND_RANDOM_R;
            end if;
          
         when SEND_RANDOM_K =>
            idle_code := K28_5;
            if a_cnt = 0 then
               idle_state := SEND_RANDOM_A;
            elsif code_sel = '0' then
               idle_state := SEND_RANDOM_K;
            else
               idle_state := SEND_RANDOM_R;
            end if;
      end case;
   end get_next_idle_code;
    
   procedure send_idle is
      variable next_idle_code : std_logic_vector(7 downto 0);
   begin  -- send_idle
      get_next_idle_code(next_idle_code);
      send_column(next_idle_code
                  & next_idle_code
                  & next_idle_code
                  & next_idle_code, "1111");
   end send_idle;

   procedure send_frame (
      constant frame : in frame_typ) is
      constant MIN_FRAME_DATA_BYTES : integer := 60;
      variable column_index : integer;
   begin  -- send_frame
      column_index := 0;

      while column_index < frame.length loop
         send_column(frame.stim(column_index));
         column_index := column_index + 1;
      end loop;

      assert false
        report "Receiver: frame inserted into XAUI interface"
        severity note;

    end send_frame;

   begin
      while reset /= '0' loop
         send_idle;        
      end loop;

      -- wait for DCMs to lock and the MGTs to sync and align
                      
      while align_status /= '1' loop
        send_idle;
      end loop;

     for i in frame_data'low to frame_data'high loop
        send_frame(frame_data(i));
        send_idle;
        send_idle;
     end loop;  -- i

     while true loop
        send_idle;
     end loop;
  end process p_xaui_rx_stimulus;

-----------------------------------------------------------------------------
-- Receive monitor process. This process checks the data coming out
-- of the XGMII receiver to make sure that it matches that inserted.
-----------------------------------------------------------------------------
   p_xgmii_rx_monitor : process
      variable cached_column_valid : boolean := false;
      variable cached_column_data : std_logic_vector(31 downto 0);
      variable cached_column_ctrl : std_logic_vector(3 downto 0);

      procedure get_next_column (
         variable d : out std_logic_vector(31 downto 0);
         variable c : out std_logic_vector(3 downto 0)) is         
      begin  -- get_next_column
         if cached_column_valid then
            d := cached_column_data;
            c := cached_column_ctrl;
            cached_column_valid := false;
         else
            wait until refclk_p = '1';
            d := xgmii_rxd(31 downto 0);
            c := xgmii_rxc(3 downto 0);
            cached_column_data := xgmii_rxd(63 downto 32);
            cached_column_ctrl := xgmii_rxc(7 downto 4);
            cached_column_valid := true;
         end if;
      end get_next_column;

     procedure check_frame (
        constant frame : in frame_typ) is
        variable d : std_logic_vector(31 downto 0) := X"07070707";
        variable c : std_logic_vector(3 downto 0) := "1111";
        variable column_index, lane_index : integer;
     begin
        -- Wait for start code
        while not (d(7 downto 0) = X"FB" and c(0) = '1') loop
           get_next_column(d,c);
        end loop;

        column_index := 0;

        -- test all columns except the final
        while column_index < frame.length-1 loop
           if d /= to_stdlogicvector(frame.stim(column_index).d) then

              assert false
                 report "Receive fail: data mismatch at XGMII interface"
                 severity error;

              return; -- end of comparison for this frame
           end if;

           column_index := column_index + 1;
           get_next_column(d,c);
        end loop;

        -- now deal with the final partial column
        lane_index := 0;

        while frame.stim(column_index).c(lane_index) = '0' loop
           if d(lane_index*8+7 downto lane_index*8) /=
              to_stdlogicvector(frame.stim(column_index).d(lane_index*8+7 downto lane_index*8)) then

              assert false
                 report "Receive fail: data mismatch at XGMII interface"
                 severity error;

              return;                       -- end of comparison for this frame

           end if;

           lane_index := lane_index + 1;
        end loop;
              
        assert false
           report "Receiver: Frame completed at XGMII interface"
           severity note;

    end check_frame;
    
   begin
      for i in frame_data'low to frame_data'high loop
         check_frame(frame_data(i));
      end loop;  -- i

      rx_monitor_finished <= true;
      wait;
   end process p_xgmii_rx_monitor;

   p_reset : process
   begin
      -- reset the core
      assert false
         report "Resetting core..."
         severity note;
      reset <= '1';
      wait for 200 ns;
      reset <= '0';
      wait;
   end process p_reset;
  
   simulation_finished <= tx_monitor_finished and rx_monitor_finished;

   p_end_simulation : process
   begin
      wait until simulation_finished for 20 us;
      assert simulation_finished
         report "Error: Testbench timed out"
         severity failure;
      assert false
         report "Simulation Stopped."
         severity failure;
   end process p_end_simulation;
   
   p_timing_checks : process
   begin
       assert false
           report "Timing checks are not valid"
           severity note;
       wait for 3000 ps;
       assert false
           report "Timing checks are valid"
           severity note;
       wait;       
   end process p_timing_checks;

   -- workaround to reset GT11 smartmodel properly. GSR is located in the
   -- unisim.vcomponents package.
   p_gsr : process
   begin
     gsr <= '1';
     wait for 100 ns;
     gsr <= '0';
     wait;
   end process p_gsr;

   rocbuf_i : ROCBUF
     port map (
       I => gsr,
       O => open);
  
end behav;
