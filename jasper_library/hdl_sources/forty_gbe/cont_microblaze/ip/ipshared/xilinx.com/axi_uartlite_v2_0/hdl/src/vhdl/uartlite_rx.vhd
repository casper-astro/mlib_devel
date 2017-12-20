-------------------------------------------------------------------------------
-- uartlite_rx - entity/architecture pair
-------------------------------------------------------------------------------
--
   -- *******************************************************************
-- -- ** (c) Copyright [2007] - [2011] Xilinx, Inc. All rights reserved.*
-- -- **                                                                *
-- -- ** This file contains confidential and proprietary information    *
-- -- ** of Xilinx, Inc. and is protected under U.S. and                *
-- -- ** international copyright and other intellectual property        *
-- -- ** laws.                                                          *
-- -- **                                                                *
-- -- ** DISCLAIMER                                                     *
-- -- ** This disclaimer is not a license and does not grant any        *
-- -- ** rights to the materials distributed herewith. Except as        *
-- -- ** otherwise provided in a valid license issued to you by         *
-- -- ** Xilinx, and to the maximum extent permitted by applicable      *
-- -- ** law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND        *
-- -- ** WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES    *
-- -- ** AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING      *
-- -- ** BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-         *
-- -- ** INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and       *
-- -- ** (2) Xilinx shall not be liable (whether in contract or tort,   *
-- -- ** including negligence, or under any other theory of             *
-- -- ** liability) for any loss or damage of any kind or nature        *
-- -- ** related to, arising under or in connection with these          *
-- -- ** materials, including for any direct, or any indirect,          *
-- -- ** special, incidental, or consequential loss or damage           *
-- -- ** (including loss of data, profits, goodwill, or any type of     *
-- -- ** loss or damage suffered as a result of any action brought      *
-- -- ** by a third party) even if such damage or loss was              *
-- -- ** reasonably foreseeable or Xilinx had been advised of the       *
-- -- ** possibility of the same.                                       *
-- -- **                                                                *
-- -- ** CRITICAL APPLICATIONS                                          *
-- -- ** Xilinx products are not designed or intended to be fail-       *
-- -- ** safe, or for use in any application requiring fail-safe        *
-- -- ** performance, such as life-support or safety devices or         *
-- -- ** systems, Class III medical devices, nuclear facilities,        *
-- -- ** applications related to the deployment of airbags, or any      *
-- -- ** other applications that could lead to death, personal          *
-- -- ** injury, or severe property or environmental damage             *
-- -- ** (individually and collectively, "Critical                      *
-- -- ** Applications"). Customer assumes the sole risk and             *
-- -- ** liability of any use of Xilinx products in Critical            *
-- -- ** Applications, subject only to applicable laws and              *
-- -- ** regulations governing limitations on product liability.        *
-- -- **                                                                *
-- -- ** THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS       *
-- -- ** PART OF THIS FILE AT ALL TIMES.                                *
   -- *******************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        uartlite_rx.vhd
-- Version:         v2.0
-- Description:     UART Lite Receive Interface Module
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library lib_srl_fifo_v1_0_2;
library lib_cdc_v1_0_2;
use lib_cdc_v1_0_2.cdc_sync;

-- dynshreg_i_f refered from proc_common_v4_0_2
-- srl_fifo_f refered from proc_common_v4_0_2
use lib_srl_fifo_v1_0_2.srl_fifo_f;

library axi_uartlite_v2_0_13;
-- uartlite_core refered from axi_uartlite_v2_0_13
use axi_uartlite_v2_0_13.all;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics :
-------------------------------------------------------------------------------
-- UART Lite generics
--  C_DATA_BITS           -- The number of data bits in the serial frame
--  C_USE_PARITY          -- Determines whether parity is used or not
--  C_ODD_PARITY          -- If parity is used determines whether parity
--                           is even or odd
--
-- System generics
--  C_FAMILY              -- Xilinx FPGA Family
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports :
-------------------------------------------------------------------------------
-- System Signals
--  Clk                 --  Clock signal
--  Rst                 --  Reset signal
-- UART Lite interface
--  RX                  --  Receive Data

-- Internal UART interface signals
--  EN_16x_Baud         --  Enable signal which is 16x times baud rate
--  Read_RX_FIFO        --  Read receive FIFO
--  Reset_RX_FIFO       --  Reset receive FIFO
--  RX_Data             --  Receive data output
--  RX_Data_Present     --  Receive data present
--  RX_Buffer_Full      --  Receive buffer full
--  RX_Frame_Error      --  Receive frame error
--  RX_Overrun_Error    --  Receive overrun error
--  RX_Parity_Error     --  Receive parity error

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                  Entity Section
-------------------------------------------------------------------------------
entity uartlite_rx is
  generic 
   (
    C_FAMILY         : string               := "virtex7";
    C_DATA_BITS      : integer range 5 to 8 := 8;
    C_USE_PARITY     : integer range 0 to 1 := 0;
    C_ODD_PARITY     : integer range 0 to 1 := 0
   );
  port 
   (
    Clk              : in  std_logic;
    Reset            : in  std_logic;
    EN_16x_Baud      : in  std_logic;
    RX               : in  std_logic;
    Read_RX_FIFO     : in  std_logic;
    Reset_RX_FIFO    : in  std_logic;
    RX_Data          : out std_logic_vector(0 to C_DATA_BITS-1);
    RX_Data_Present  : out std_logic;
    RX_Buffer_Full   : out std_logic;
    RX_Frame_Error   : out std_logic;
    RX_Overrun_Error : out std_logic;
    RX_Parity_Error  : out std_logic
   );
end entity uartlite_rx;

-------------------------------------------------------------------------------
-- Architecture Section
-------------------------------------------------------------------------------
architecture RTL of uartlite_rx is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

    type     bo2sl_type is array(boolean) of std_logic;
    
    constant bo2sl      :  bo2sl_type := (false => '0', true => '1');

    ---------------------------------------------------------------------------
    -- Constant declarations
    ---------------------------------------------------------------------------
    constant SERIAL_TO_PAR_LENGTH : integer := 
                                    C_DATA_BITS + C_USE_PARITY;
    constant STOP_BIT_POS         : integer := SERIAL_TO_PAR_LENGTH;
    constant DATA_LSB_POS         : integer := SERIAL_TO_PAR_LENGTH;
    constant CALC_PAR_POS         : integer := SERIAL_TO_PAR_LENGTH;

    ---------------------------------------------------------------------------
    -- Signal declarations
    ---------------------------------------------------------------------------
    signal start_Edge_Detected     : boolean;
    signal start_Edge_Detected_Bit : std_logic;
    signal running                 : boolean;
    signal recycle                 : std_logic;
    signal sample_Point            : std_logic;
    signal stop_Bit_Position       : std_logic;
    signal fifo_Write              : std_logic;
    
    signal fifo_din             : std_logic_vector(0 to SERIAL_TO_PAR_LENGTH);
    signal serial_to_Par        : std_logic_vector(1 to SERIAL_TO_PAR_LENGTH);
    signal calc_parity          : std_logic;
    signal parity               : std_logic;
    signal RX_Buffer_Full_I     : std_logic;
    signal RX_D1                : std_logic;
    signal RX_D2                : std_logic;
    signal rx_1                 : std_logic;
    signal rx_2                 : std_logic;
    signal rx_3                 : std_logic;
    signal rx_4                 : std_logic;
    signal rx_5                 : std_logic;
    signal rx_6                 : std_logic;
    signal rx_7                 : std_logic;
    signal rx_8                 : std_logic;
    signal rx_9                 : std_logic;
    signal rx_Data_Empty        : std_logic := '0';
    signal fifo_wr              : std_logic;
    signal fifo_rd              : std_logic;
    signal RX_FIFO_Reset        : std_logic;
    signal valid_rx             : std_logic;
    signal valid_start          : std_logic;
    signal frame_err_ocrd       : std_logic;
    signal frame_err            : std_logic;

begin  -- architecture RTL

    ---------------------------------------------------------------------------
    -- RX_SAMPLING : Double sample RX to avoid meta-stability
    ---------------------------------------------------------------------------
INPUT_DOUBLE_REGS3 : entity lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => 4
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => RX,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => Clk,
        scndry_resetn              => '0',
        scndry_out                 => RX_D2,
        scndry_vect_out            => open
    );


--    RX_SAMPLING: process (Clk) is
--    begin  -- process RX_Sampling
--        if Clk'event and Clk = '1' then -- rising clock edge
--            if Reset = '1' then         -- synchronous reset (active high)
--                RX_D1 <= '1';
--                RX_D2 <= '1';
--            else 
--                RX_D1 <= RX;
--                RX_D2 <= RX_D1;
--            end if;
--        end if;
--    end process RX_SAMPLING;

-------------------------------------------------------------------------------
-- Detect a falling edge on RX and start a new reception if idle
-------------------------------------------------------------------------------

    ---------------------------------------------------------------------------
     -- detect the start of the frame 
    ---------------------------------------------------------------------------
    RX_DFFS : process (Clk) is
    begin  -- process Prev_RX_DFFS
        if Clk'event and Clk = '1' then  -- rising clock edge
            if (Reset = '1') then
                rx_1 <= '0';
                rx_2 <= '0';
                rx_3 <= '0';
                rx_4 <= '0';
                rx_5 <= '0';
                rx_6 <= '0';
                rx_7 <= '0';
                rx_8 <= '0';
                rx_9 <= '0';
            elsif (EN_16x_Baud = '1') then
                rx_1 <= RX_D2;
                rx_2 <= rx_1;
                rx_3 <= rx_2;
                rx_4 <= rx_3;
                rx_5 <= rx_4;
                rx_6 <= rx_5;
                rx_7 <= rx_6;
                rx_8 <= rx_7;
                rx_9 <= rx_8;
            end if;
        end if;
    end process RX_DFFS;

    ---------------------------------------------------------------------------
     -- Start bit valid when RX is continuously low for atleast 8 samples 
    ---------------------------------------------------------------------------

    valid_start <= rx_8 or rx_7 or rx_6 or rx_5 or 
                   rx_4 or rx_3 or rx_2 or rx_1;
    
    ---------------------------------------------------------------------------
    -- START_EDGE_DFF : Start a new reception if idle
    ---------------------------------------------------------------------------
    START_EDGE_DFF : process (Clk) is
    begin  -- process Start_Edge_DFF
        if Clk'event and Clk = '1' then  -- rising clock edge
            if (Reset = '1') then
                start_Edge_Detected <= false;
            elsif (EN_16x_Baud = '1') then
                start_Edge_Detected <= ((not running) and 
                                        (frame_err_ocrd = '0') and 
                                        (rx_9 = '1') and 
                                        (valid_start = '0'));
            end if;
        end if;
    end process START_EDGE_DFF;
    
    ---------------------------------------------------------------------------
    -- FRAME_ERR_CAPTURE : frame_err_ocrd is '1' when a frame error is occured
    --                     and deasserted when the next low to high on RX
    ---------------------------------------------------------------------------
    FRAME_ERR_CAPTURE : process (Clk) is
    begin  -- process valid_rx_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if (Reset = '1') then         -- synchronous reset (active high)
                frame_err_ocrd <= '0';
            elsif (frame_err = '1') then
                    frame_err_ocrd <= '1';
            elsif (RX_D2 = '1') then
                    frame_err_ocrd <= '0';
            end if;           
        end if;
    end process FRAME_ERR_CAPTURE;
    
    ---------------------------------------------------------------------------
    -- VALID_XFER : valid_rx is '1' when a valid start edge detected
    ---------------------------------------------------------------------------
    VALID_XFER : process (Clk) is
    begin  -- process valid_rx_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if (Reset = '1') then         -- synchronous reset (active high)
                valid_rx <= '0';
            elsif (start_Edge_Detected = true) then
                    valid_rx <= '1';
            elsif (fifo_Write = '1') then
                    valid_rx <= '0';
            end if;           
        end if;
    end process VALID_XFER;

    ---------------------------------------------------------------------------
    -- RUNNING_DFF : Running is '1' during a reception
    ---------------------------------------------------------------------------
    RUNNING_DFF : process (Clk) is
    begin  -- process Running_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if (Reset = '1') then         -- synchronous reset (active high)
                running <= false;
            elsif (EN_16x_Baud = '1') then
                if (start_Edge_Detected) then
                    running <= true;
                elsif ((sample_Point = '1') and (stop_Bit_Position = '1')) then
                    running <= false;
                end if;
            end if;
        end if;
    end process RUNNING_DFF;

    ---------------------------------------------------------------------------
    -- Boolean to std logic conversion of start edge
    ---------------------------------------------------------------------------

    start_Edge_Detected_Bit <= '1' when start_Edge_Detected else '0';

    ---------------------------------------------------------------------------
    -- After the start edge is detected, generate recycle to generate sample
    -- point
    ---------------------------------------------------------------------------

    recycle <= (valid_rx and (not stop_Bit_Position) and 
                            (start_Edge_Detected_Bit or sample_Point));

    -------------------------------------------------------------------------
    -- DELAY_16_I : Keep regenerating new values into the 16 clock delay, 
    -- Starting with the first start_Edge_Detected_Bit and for every new 
    -- sample_points until stop_Bit_Position is reached
    -------------------------------------------------------------------------
    DELAY_16_I : entity axi_uartlite_v2_0_13.dynshreg_i_f
      generic map 
       (
        C_DEPTH  => 16,
        C_DWIDTH => 1,
        C_FAMILY => C_FAMILY
       )
      port map
       (
        Clk      => Clk,
        Clken    => EN_16x_Baud,
        Addr     => "1111",
        Din(0)   => recycle,
        Dout(0)  => sample_Point
       );

    ---------------------------------------------------------------------------
    -- STOP_BIT_HANDLER : Detect when the stop bit is received
    ---------------------------------------------------------------------------
    STOP_BIT_HANDLER : process (Clk) is
    begin  -- process Stop_Bit_Handler
        if Clk'event and Clk = '1' then -- rising clock edge
            if (Reset = '1') then       -- synchronous reset (active high)
                stop_Bit_Position <= '0';
            elsif (EN_16x_Baud = '1') then
                if (stop_Bit_Position = '0') then
                  -- Start bit has reached the end of the shift register 
                  -- (Stop bit position)
                    stop_Bit_Position <= sample_Point and 
                                         fifo_din(STOP_BIT_POS);
                elsif (sample_Point = '1') then
                  -- if stop_Bit_Position is 1 clear it at next sample_Point
                    stop_Bit_Position <= '0';
                end if;
            end if;
        end if;
    end process STOP_BIT_HANDLER;

    USING_PARITY_NO : if (C_USE_PARITY = 0) generate
        RX_Parity_Error <= '0' ;
    end generate USING_PARITY_NO;
    ---------------------------------------------------------------------------
    -- USING_PARITY : Generate parity handling when C_USE_PARITY = 1
    ---------------------------------------------------------------------------
    USING_PARITY : if (C_USE_PARITY = 1) generate

        PARITY_DFF: Process (Clk) is
        begin
            if (Clk'event and Clk = '1') then
                if (Reset = '1' or start_Edge_Detected_Bit = '1') then
                    parity <=  bo2sl(C_ODD_PARITY = 1);
                elsif (EN_16x_Baud = '1') then
                    parity <= calc_parity;
                end if;
            end if;
        end process PARITY_DFF;
      
        calc_parity <= parity when (stop_Bit_Position or 
                                   (not sample_Point)) = '1'
                       else parity xor RX_D2;

        RX_Parity_Error <= (EN_16x_Baud and sample_Point) and
                           (fifo_din(CALC_PAR_POS)) and not stop_Bit_Position
                           when running and (RX_D2 /= parity) else '0';

    end generate USING_PARITY;

    fifo_din(0) <= RX_D2 and not Reset;

    ---------------------------------------------------------------------------
    -- SERIAL_TO_PARALLEL : Serial to parrallel conversion data part
    ---------------------------------------------------------------------------
    SERIAL_TO_PARALLEL : for i in 1 to serial_to_Par'length generate
    
        serial_to_Par(i) <= fifo_din(i) when (stop_Bit_Position or 
                                              not sample_Point) = '1'
                            else fifo_din(i-1);

        BIT_I: Process (Clk) is
        begin
            if (Clk'event and Clk = '1') then
              if (Reset = '1') then
                    fifo_din(i) <= '0'; -- Bit STOP_BIT_POS resets to '0'; 
              else                                 -- others to '1'
                if (start_Edge_Detected_Bit = '1') then
                    fifo_din(i) <= bo2sl(i=1); -- Bit 1 resets to '1'; 
                                               -- others to '0'
                elsif (EN_16x_Baud = '1') then
                    fifo_din(i) <= serial_to_Par(i);
                end if;
              end if;
            end if;
        end process BIT_I;

    end generate SERIAL_TO_PARALLEL;

    --------------------------------------------------------------------------
    -- FIFO_WRITE_DFF : Write in the received word when the stop_bit has been 
    --                  received and it is a '1'
    --------------------------------------------------------------------------
    FIFO_WRITE_DFF : process (Clk) is
    begin  -- process FIFO_Write_DFF
        if Clk'event and Clk = '1' then  -- rising clock edge
            if Reset = '1' then          -- synchronous reset (active high)
                fifo_Write <= '0';
            else
                fifo_Write <= stop_Bit_Position and RX_D2 and sample_Point 
                                                and EN_16x_Baud;
            end if;
        end if;
    end process FIFO_WRITE_DFF;

    frame_err <= stop_Bit_Position and sample_Point and EN_16x_Baud 
                      and not RX_D2;

    RX_Frame_Error <= frame_err;
    
    --------------------------------------------------------------------------
    -- Write RX FIFO when FIFO is not full when valid data is reveived
    --------------------------------------------------------------------------
    fifo_wr <= fifo_Write and (not RX_Buffer_Full_I) and valid_rx;

    --------------------------------------------------------------------------
    -- Read RX FIFO when FIFO is not empty when AXI reads data from RX FIFO
    --------------------------------------------------------------------------
    fifo_rd <= Read_RX_FIFO and (not rx_Data_Empty);

    --------------------------------------------------------------------------
    -- Reset RX FIFO when requested from the control register or system reset
    --------------------------------------------------------------------------
    RX_FIFO_Reset <= Reset_RX_FIFO or Reset;
    
    ---------------------------------------------------------------------------
    -- SRL_FIFO_I : Receive FIFO Interface
    ---------------------------------------------------------------------------
    SRL_FIFO_I : entity lib_srl_fifo_v1_0_2.srl_fifo_f
      generic map
       (
        C_DWIDTH   => C_DATA_BITS,
        C_DEPTH    => 16,
        C_FAMILY   => C_FAMILY
       )
      port map
       (
        Clk        => Clk,
        Reset      => RX_FIFO_Reset,
        FIFO_Write => fifo_wr,
        Data_In    => fifo_din((DATA_LSB_POS-C_DATA_BITS + 1) to DATA_LSB_POS),
        FIFO_Read  => fifo_rd,
        Data_Out   => RX_Data,
        FIFO_Full  => RX_Buffer_Full_I,
        FIFO_Empty => rx_Data_Empty,
        Addr       => open
       );

    RX_Data_Present  <= not rx_Data_Empty;
    RX_Overrun_Error <= RX_Buffer_Full_I and fifo_Write;  -- Note that if
        -- the RX FIFO is read on the same cycle as it is written while full,
        -- there is no loss of data. However this case is not optimized and
        -- is also reported as an overrun.
    RX_Buffer_Full   <= RX_Buffer_Full_I;

end architecture RTL; 
