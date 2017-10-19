-------------------------------------------------------------------------------
-- uartlite_tx - entity/architecture pair
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
-- Filename:        uartlite_tx.vhd
-- Version:         v2.0
-- Description:     UART Lite Transmit Interface Module
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
use IEEE.numeric_std.UNSIGNED;
use IEEE.numeric_std.to_unsigned;
use IEEE.numeric_std."-";

library lib_srl_fifo_v1_0_2;
-- dynshreg_i_f refered from proc_common_v4_0_20_a
library axi_uartlite_v2_0_13;
-- uartlite_core refered from axi_uartlite_v2_0_13
use axi_uartlite_v2_0_13.all;
-- srl_fifo_f refered from proc_common_v4_0_20_a
use lib_srl_fifo_v1_0_2.srl_fifo_f;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics :
-------------------------------------------------------------------------------
-- UART Lite generics
--  C_DATA_BITS     -- The number of data bits in the serial frame
--  C_USE_PARITY    -- Determines whether parity is used or not
--  C_ODD_PARITY    -- If parity is used determines whether parity
--                     is even or odd
-- System generics
--  C_FAMILY        -- Xilinx FPGA Family
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Ports :
-------------------------------------------------------------------------------
-- System Signals
--  Clk               --  Clock signal
--  Rst               --  Reset signal
-- UART Lite interface
--  TX                --  Transmit Data
-- Internal UART interface signals
--  EN_16x_Baud       --  Enable signal which is 16x times baud rate
--  Write_TX_FIFO     --  Write transmit FIFO
--  Reset_TX_FIFO     --  Reset transmit FIFO
--  TX_Data           --  Transmit data input
--  TX_Buffer_Full    --  Transmit buffer full
--  TX_Buffer_Empty   --  Transmit buffer empty
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                  Entity Section
-------------------------------------------------------------------------------
entity uartlite_tx is
  generic 
   (
    C_FAMILY        : string               := "virtex7";
    C_DATA_BITS     : integer range 5 to 8 := 8;
    C_USE_PARITY    : integer range 0 to 1 := 0;
    C_ODD_PARITY    : integer range 0 to 1 := 0
   );
  port
   (
    Clk             : in  std_logic;
    Reset           : in  std_logic;
    EN_16x_Baud     : in  std_logic;
    TX              : out std_logic;
    Write_TX_FIFO   : in  std_logic;
    Reset_TX_FIFO   : in  std_logic;
    TX_Data         : in  std_logic_vector(0 to C_DATA_BITS-1);
    TX_Buffer_Full  : out std_logic;
    TX_Buffer_Empty : out std_logic
   );
end entity uartlite_tx;

-------------------------------------------------------------------------------
-- Architecture Section
-------------------------------------------------------------------------------
architecture RTL of uartlite_tx is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

    type     bo2sl_type is array(boolean) of std_logic;
    constant bo2sl      :  bo2sl_type := (false => '0', true => '1');

    -------------------------------------------------------------------------
    --  Constant Declarations
    -------------------------------------------------------------------------
    constant MUX_SEL_INIT : std_logic_vector(0 to 2) :=
      std_logic_vector(to_unsigned(C_DATA_BITS-1, 3));

    -------------------------------------------------------------------------
    -- Signal Declarations
    -------------------------------------------------------------------------
    signal parity            : std_logic;
    signal tx_Run1           : std_logic;
    signal select_Parity     : std_logic;
    signal data_to_transfer  : std_logic_vector(0 to C_DATA_BITS-1);
    signal div16             : std_logic;
    signal tx_Data_Enable    : std_logic;
    signal tx_Start          : std_logic;
    signal tx_DataBits       : std_logic;
    signal tx_Run            : std_logic;
    signal mux_sel           : std_logic_vector(0 to 2);
    signal mux_sel_is_zero   : std_logic;
    signal mux_01            : std_logic;
    signal mux_23            : std_logic;
    signal mux_45            : std_logic;
    signal mux_67            : std_logic;
    signal mux_0123          : std_logic;
    signal mux_4567          : std_logic;
    signal mux_Out           : std_logic;
    signal serial_Data       : std_logic;
    signal fifo_Read         : std_logic;
    signal fifo_Data_Present : std_logic := '0';
    signal fifo_Data_Empty   : std_logic;
    signal fifo_DOut         : std_logic_vector(0 to C_DATA_BITS-1);
    signal fifo_wr           : std_logic;
    signal fifo_rd           : std_logic;
    signal tx_buffer_full_i  : std_logic;
    signal TX_FIFO_Reset     : std_logic;

begin  -- architecture IMP

    ---------------------------------------------------------------------------
    --MID_START_BIT_SRL16_I : Shift register is used to generate div16 that
    --                        gets shifted for 16 times(as Addr = 15) when 
    --                        EN_16x_Baud is high.
    ---------------------------------------------------------------------------
    MID_START_BIT_SRL16_I : entity axi_uartlite_v2_0_13.dynshreg_i_f
      generic map
       (
        C_DEPTH      => 16,
        C_DWIDTH     => 1,
        C_INIT_VALUE => X"8000",
        C_FAMILY     => C_FAMILY
       )
      port map
       (
        Clk      => Clk,
        Clken    => EN_16x_Baud,
        Addr     => "1111",
        Din(0)   => div16,
        Dout(0)  => div16
       );

    ------------------------------------------------------------------------
    -- TX_DATA_ENABLE_DFF : tx_Data_Enable is '1' when div16 is 1 and
    --                      EN_16x_Baud is 1. It will deasserted in the
    --                      next clock cycle.
    ------------------------------------------------------------------------
    TX_DATA_ENABLE_DFF: Process (Clk) is
    begin
        if (Clk'event and Clk = '1') then -- rising clock edge
             if Reset = '1' then          -- synchronous reset (active high)
               tx_Data_Enable <= '0';
             else
                if (tx_Data_Enable = '1') then
                    tx_Data_Enable <= '0';
                elsif (EN_16x_Baud = '1') then
                    tx_Data_Enable <= div16;
                end if;
             end if;
        end if;
    end process TX_DATA_ENABLE_DFF;

    ------------------------------------------------------------------------
    -- TX_START_DFF : tx_start is '1' for the start bit in a transmission
    ------------------------------------------------------------------------
    TX_START_DFF : process (Clk) is
    begin
        if Clk'event and Clk = '1' then -- rising clock edge
            if Reset = '1' then         -- synchronous reset (active high)
                tx_Start <= '0';
            else 
                tx_Start <= (not(tx_Run) and (tx_Start or 
                               (fifo_Data_Present and tx_Data_Enable)));
            end if;
        end if;
    end process TX_START_DFF;

    --------------------------------------------------------------------------
    -- TX_DATA_DFF : tx_DataBits is '1' during all databits transmission
    --------------------------------------------------------------------------
    TX_DATA_DFF : process (Clk) is
    begin
        if Clk'event and Clk = '1' then -- rising clock edge
            if Reset = '1' then         -- synchronous reset (active high)
                tx_DataBits <= '0';
            else 
                tx_DataBits <= (not(fifo_Read) and (tx_DataBits or 
                                           (tx_Start and tx_Data_Enable)));
            end if;
        end if;
    end process TX_DATA_DFF;

    -------------------------------------------------------------------------
    -- COUNTER : If mux_sel is zero then reload with the init value else if 
    --           tx_DataBits = '1', decrement
    -------------------------------------------------------------------------
    COUNTER : process (Clk) is
    begin  -- process Mux_Addr_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if Reset = '1' then         -- synchronous reset (active high)
                mux_sel <= std_logic_vector(to_unsigned(C_DATA_BITS-1, 
                                            mux_sel'length));
            elsif (tx_Data_Enable = '1') then
                if (mux_sel_is_zero = '1') then
                    mux_sel <= MUX_SEL_INIT;
                elsif (tx_DataBits = '1') then
                    mux_sel <= std_logic_vector(UNSIGNED(mux_sel) - 1);
                end if;
            end if;
        end if;
    end process COUNTER;

    ------------------------------------------------------------------------
    -- Detecting when mux_sel is zero, i.e. all data bits are transfered
    ------------------------------------------------------------------------
    mux_sel_is_zero <= '1' when mux_sel = "000" else '0';

    --------------------------------------------------------------------------
    -- FIFO_READ_DFF : Read out the next data from the transmit fifo when the 
    --                 data has been transmitted
    --------------------------------------------------------------------------
    FIFO_READ_DFF : process (Clk) is
    begin  -- process FIFO_Read_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if Reset = '1' then         -- synchronous reset (active high)
                fifo_Read <= '0';
            else
                fifo_Read <= tx_Data_Enable and mux_sel_is_zero;
            end if;
        end if;
    end process FIFO_READ_DFF;
    --------------------------------------------------------------------------
    -- Select which bit within the data word to transmit
    --------------------------------------------------------------------------

    --------------------------------------------------------------------------
    -- PARITY_BIT_INSERTION : Need special treatment for inserting the parity 
    --                        bit because of parity generation
    --------------------------------------------------------------------------

    data_to_transfer(0 to C_DATA_BITS-2) <= fifo_DOut(0 to C_DATA_BITS-2);

    data_to_transfer(C_DATA_BITS-1) <= parity when select_Parity = '1' else
                                       fifo_DOut(C_DATA_BITS-1);
    
    mux_01 <= data_to_transfer(1) when mux_sel(2) = '1' else 
              data_to_transfer(0);
    mux_23 <= data_to_transfer(3) when mux_sel(2) = '1' else
              data_to_transfer(2);

    --------------------------------------------------------------------------
    -- DATA_BITS_IS_5 : Select total 5 data bits when C_DATA_BITS = 5
    --------------------------------------------------------------------------
    DATA_BITS_IS_5 : if (C_DATA_BITS = 5) generate
        mux_45 <= data_to_transfer(4);
        mux_67 <= '0';
    end generate DATA_BITS_IS_5;

    --------------------------------------------------------------------------
    -- DATA_BITS_IS_6 : Select total 6 data bits when C_DATA_BITS = 6
    --------------------------------------------------------------------------
    DATA_BITS_IS_6 : if (C_DATA_BITS = 6) generate
        mux_45 <= data_to_transfer(5) when mux_sel(2) = '1' else 
                  data_to_transfer(4);
        mux_67 <= '0';
    end generate DATA_BITS_IS_6;

    --------------------------------------------------------------------------
    -- DATA_BITS_IS_7 : Select total 7 data bits when C_DATA_BITS = 7
    --------------------------------------------------------------------------
    DATA_BITS_IS_7 : if (C_DATA_BITS = 7) generate
        mux_45 <= data_to_transfer(5) when mux_sel(2) = '1' else 
                  data_to_transfer(4);
        mux_67 <= data_to_transfer(6);
    end generate DATA_BITS_IS_7;

    --------------------------------------------------------------------------
    -- DATA_BITS_IS_8 : Select total 8 data bits when C_DATA_BITS = 8
    --------------------------------------------------------------------------
    DATA_BITS_IS_8 : if (C_DATA_BITS = 8) generate
      mux_45 <= data_to_transfer(5) when mux_sel(2) = '1' else 
                data_to_transfer(4);
      mux_67 <= data_to_transfer(7) when mux_sel(2) = '1' else 
                data_to_transfer(6);
    end generate DATA_BITS_IS_8;

    mux_0123 <= mux_23   when mux_sel(1) = '1' else mux_01;
    mux_4567 <= mux_67   when mux_sel(1) = '1' else mux_45;
    mux_Out  <= mux_4567 when mux_sel(0) = '1' else mux_0123;

    --------------------------------------------------------------------------
    -- SERIAL_DATA_DFF : Register the mux_Out
    --------------------------------------------------------------------------
    SERIAL_DATA_DFF : process (Clk) is
    begin
        if Clk'event and Clk = '1' then  -- rising clock edge
            if Reset = '1' then          -- synchronous reset (active high)
                serial_Data <= '0';
            else 
                serial_Data <= mux_Out;
            end if;
        end if;
    end process SERIAL_DATA_DFF;

    --------------------------------------------------------------------------
    -- SERIAL_OUT_DFF :Force a '0' when tx_start is '1', Start_bit
    --                 Force a '1' when tx_run is '0',   Idle
    --                 otherwise put out the serial_data
    --------------------------------------------------------------------------
    SERIAL_OUT_DFF : process (Clk) is
    begin  -- process Serial_Out_DFF
        if Clk'event and Clk = '1' then -- rising clock edge
            if Reset = '1' then         -- synchronous reset (active high)
                TX <= '1';
            else 
                TX <= (not(tx_Run) or serial_Data) and (not(tx_Start));
            end if;
        end if;
    end process SERIAL_OUT_DFF;

    --------------------------------------------------------------------------
    -- USING_PARITY : Generate parity handling when C_USE_PARITY = 1
    --------------------------------------------------------------------------
    USING_PARITY : if (C_USE_PARITY = 1) generate

        PARITY_DFF: Process (Clk) is
        begin
            if (Clk'event and Clk = '1') then
                if (tx_Start = '1') then
                    parity <=  bo2sl(C_ODD_PARITY = 1);
                elsif (tx_Data_Enable = '1') then
                    parity <= parity xor serial_Data;
                end if;
            end if;
        end process PARITY_DFF;

        TX_RUN1_DFF : process (Clk) is
        begin
            if Clk'event and Clk = '1' then -- rising clock edge
                if Reset = '1' then         -- synchronous reset (active high)
                    tx_Run1 <= '0';
                elsif (tx_Data_Enable = '1') then
                    tx_Run1 <= tx_DataBits;
                end if;
            end if;
        end process TX_RUN1_DFF;

        tx_Run <= tx_Run1 or tx_DataBits;

        SELECT_PARITY_DFF : process (Clk) is
        begin
            if Clk'event and Clk = '1' then  -- rising clock edge
                if Reset = '1' then          -- synchronous reset (active high)
                    select_Parity <= '0';
                elsif (tx_Data_Enable = '1') then
                    select_Parity <= mux_sel_is_zero;
                end if;
            end if;
        end process SELECT_PARITY_DFF;

    end generate USING_PARITY;

    --------------------------------------------------------------------------
    -- NO_PARITY : When C_USE_PARITY = 0 select parity as '0'
    --------------------------------------------------------------------------
    NO_PARITY : if (C_USE_PARITY = 0) generate
        tx_Run        <= tx_DataBits;
        select_Parity <= '0';
    end generate NO_PARITY;

    --------------------------------------------------------------------------
    -- Write TX FIFO when FIFO is not full when AXI writes data in TX FIFO
    --------------------------------------------------------------------------
    fifo_wr <= Write_TX_FIFO and (not tx_buffer_full_i);
    
    --------------------------------------------------------------------------
    -- Read TX FIFO when FIFO is not empty when AXI reads data from TX FIFO
    --------------------------------------------------------------------------
    fifo_rd <= fifo_Read and (not fifo_Data_Empty);
    
    --------------------------------------------------------------------------
    -- Reset TX FIFO when requested from the control register or system reset
    --------------------------------------------------------------------------
    TX_FIFO_Reset <= Reset_TX_FIFO or Reset;
    
    --------------------------------------------------------------------------
    -- SRL_FIFO_I : Transmit FIFO Interface
    --------------------------------------------------------------------------
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
        Reset      => TX_FIFO_Reset,
        FIFO_Write => fifo_wr,
        Data_In    => TX_Data,
        FIFO_Read  => fifo_rd,
        Data_Out   => fifo_DOut,
        FIFO_Full  => tx_buffer_full_i,
        FIFO_Empty => fifo_Data_Empty
       );

    TX_Buffer_Full    <= tx_buffer_full_i;
    TX_Buffer_Empty   <= fifo_Data_Empty;
    fifo_Data_Present <= not fifo_Data_Empty;

end architecture RTL;
