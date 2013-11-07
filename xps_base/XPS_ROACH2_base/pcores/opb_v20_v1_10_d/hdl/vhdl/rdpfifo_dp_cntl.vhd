-------------------------------------------------------------------------------
-- $Id: rdpfifo_dp_cntl.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
--rdpfifo_dp_cntl.vhd
-------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2003,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        rdpfifo_dp_cntl.vhd
--
-- Description:     This VHDL design file is for the Mauna Loa Read Packet
--                  FIFO Dual Port Control block and the status
--                  calculations for the Occupancy, Vacancy, Full, and Empty.
--
-------------------------------------------------------------------------------
-- Structure:   This is the hierarchical structure of the RPFIFO design.
--
--
--              rdpfifo_dp_cntl.vhd
--                     |
--                     |
--                     |-- proc_common_v2_00_a.vhd
--                            |
--                            |-- pf_counter_top.vhd
--                            |        |
--                            |        |-- pf_counter.vhd
--                            |                 |
--                            |                 |-- pf_counter_bit.vhd
--                            |
--                            |
--                            |-- pf_occ_counter_top.vhd
--                            |        |
--                            |        |-- occ_counter.vhd
--                            |                 |
--                            |                 |-- pf_counter_bit.vhd
--                            |
--                            |-- pf_adder.vhd
--                                    |
--                                    |-- pf_adder_bit.vhd
--
--
--
-------------------------------------------------------------------------------
-- Author:      Doug Thorpe
--
-- History:
--  DET     August 15, 2001     -- Initial version adapted from pt design
--
--  DET     Sept. 21, 2001      -- Size Optimized redesign and parameterization
--
--
--     DET     4/1/2004     proc_common V2 conversion
-- ~~~~~~
--     - Added reference to proc_common_v2_00_a for support modules.
-- ^^^^^^
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
--
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
---------------------------------------------------------------------
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library opb_v20_v1_10_d;
Use opb_v20_v1_10_d.pf_counter_top;
Use opb_v20_v1_10_d.pf_occ_counter_top;
Use opb_v20_v1_10_d.pf_adder;

-------------------------------------------------------------------------------

entity rdpfifo_dp_cntl is
  Generic (
     C_DP_ADDRESS_WIDTH   : Integer := 9;
          -- number of bits needed for dual port addressing
          -- of requested FIFO depth

     C_INCLUDE_PACKET_MODE : Boolean := true;
          -- Select for inclusion/ommision of packet mode
          -- features

     C_INCLUDE_VACANCY    : Boolean := true
          -- Enable for Vacancy calc feature
       );
  port (

  -- Inputs
    Bus_rst       : In  std_logic;
    Bus_clk       : In  std_logic;
    Rdreq         : In  std_logic;
    Wrreq         : In  std_logic;
        Burst_rd_xfer : In  std_logic;
    Mark          : In  std_logic;
    Restore       : In  std_logic;
    Release       : In  std_logic;

  -- Outputs
    WrAck         : Out std_logic;
    RdAck         : Out std_logic;
    Full          : Out std_logic;
    Empty         : Out std_logic;
    Almost_Full   : Out std_logic;
    Almost_Empty  : Out std_logic;
        DeadLock      : Out std_logic;
    Occupancy     : Out std_logic_vector(0 to C_DP_ADDRESS_WIDTH);
    Vacancy       : Out std_logic_vector(0 to C_DP_ADDRESS_WIDTH);
    DP_core_wren  : Out std_logic;
    Wr_Addr       : Out std_logic_vector(0 to C_DP_ADDRESS_WIDTH-1);
    DP_core_rden  : Out std_logic;
    Rd_Addr       : Out std_logic_vector(0 to C_DP_ADDRESS_WIDTH-1)
    );
  end rdpfifo_dp_cntl ;

-------------------------------------------------------------------------------

architecture implementation of rdpfifo_dp_cntl is


-- Components





-- CONSTANTS

    Constant  OCC_CNTR_WIDTH    : integer   := C_DP_ADDRESS_WIDTH+1;
    Constant  ADDR_CNTR_WIDTH   : integer   := C_DP_ADDRESS_WIDTH;
    Constant  MAX_OCCUPANCY     : integer   := 2**ADDR_CNTR_WIDTH;
    Constant  LOGIC_LOW         : std_logic := '0';


  -- shared signals

     signal  sig_normal_occupancy   : std_logic_vector(0 to OCC_CNTR_WIDTH-1);




-------------------------------------------------------------------------------
----------------- start architecture logic ------------------------------------

begin


 ------------------------------------------------------------------------------
 --  Generate the Read PFIFO with packetizing features included
 ------------------------------------------------------------------------------
 INCLUDE_PACKET_FEATURES : if (C_INCLUDE_PACKET_MODE = true) generate



   --TYPES
        type   transition_state_type is (
                                     reset1,
                                     normal_op,
                                     packet_op,
                                     rest1,
                                     mark1,
                                     rls1,
                                     pkt_update,
                                     nml_update
                                     );




   --INTERNAL SIGNALS

    signal  int_full                : std_logic;
    signal  int_full_dly1           : std_logic;
    signal  int_full_dly2           : std_logic;
    signal  int_almost_full         : std_logic;
    signal  int_empty               : std_logic;
    signal  int_almost_empty        : std_logic;
    Signal  int_almost_empty_dly1   : std_logic;
    Signal  int_empty_dly1          : std_logic;
    Signal  trans_state             : transition_state_type;
    signal  hold_ack                : std_logic;

    Signal  inc_rd_addr             : std_logic;
    Signal  decr_rd_addr            : std_logic;
    Signal  inc_wr_addr             : std_logic;
    Signal  inc_mark_addr           : std_logic;
    Signal  rd_backup               : std_logic;

    Signal  dummy_empty             : std_logic;
    Signal  dummy_almost_empty      : std_logic;
    Signal  dummy_full              : std_logic;
    Signal  dummy_almost_full       : std_logic;

    signal  ld_occ_norm_into_mark   : std_logic;
    signal  ld_addr_mark_into_write : std_logic;
    signal  ld_addr_write_into_mark : std_logic;
    signal  ld_occ_mark_into_norm   : std_logic;
    signal  enable_mark_addr_inc    : std_logic;
    signal  enable_wr_addr_inc      : std_logic;
    signal  enable_rd_addr_inc      : std_logic;
    signal  enable_rd_addr_decr     : std_logic;

    signal  sig_mark_occupancy      : std_logic_vector(0 to OCC_CNTR_WIDTH-1);
    signal  write_address           : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);
    signal  mark_address            : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);
    signal  read_address            : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);
    signal  sig_zeros               : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);

    signal  inc_nocc                : std_logic;
    signal  inc_mocc                : std_logic;
    signal  inc_nocc_by_2           : std_logic;
    signal  inc_mocc_by_2           : std_logic;






begin


     --Misc I/O Assignments


       Full          <=  int_full;
       Almost_Full   <=  int_almost_full;

       Empty         <=  int_empty; -- Align Empty flag with the DP occupancy
       Almost_Empty  <=  int_almost_empty; -- Align Almost_Empty flag with the
                                           -- DP occupancy
       Occupancy     <=  sig_mark_occupancy;

       Wr_Addr       <=  write_address;
       Rd_Addr       <=  read_address;

       WrAck         <=  inc_wr_addr; -- currently combinitorial
       RdAck         <=  inc_rd_addr; -- currently combinitorial

       DeadLock      <=  int_full and int_empty; -- both full and empty at
                                                 -- the same time

       DP_core_rden  <=  not(int_empty)-- assert read enable when not empty
                         or Bus_rst;   -- or during reset

       DP_core_wren  <=  not(int_full)  -- assert write enable when not full
                         or Bus_rst;    -- or during reset


     -----------------------------------------------------------------------
     -- Main Transition sequence state machine
     -----------------------------------------------------------------------
      TRANSITION_STATE_PROCESS : process (Bus_rst, Bus_Clk)
       Begin
         If (Bus_rst = '1') Then
            trans_state              <= reset1;
            hold_ack                 <= '1';
            ld_occ_norm_into_mark    <= '0';
            ld_addr_mark_into_write  <= '0';
            ld_addr_write_into_mark  <= '0';
            ld_occ_mark_into_norm    <= '0';
            enable_mark_addr_inc     <= '0';
            enable_wr_addr_inc       <= '0';
            enable_rd_addr_inc       <= '0';
            enable_rd_addr_decr      <= '0';


         Elsif (Bus_Clk'event and Bus_Clk = '1') Then

           -- set default values
            trans_state              <= reset1;
            hold_ack                 <= '1';
            ld_occ_norm_into_mark    <= '0';
            ld_addr_mark_into_write  <= '0';
            ld_addr_write_into_mark  <= '0';
            ld_occ_mark_into_norm    <= '0';
            enable_mark_addr_inc     <= '0';
            enable_wr_addr_inc       <= '0';
            enable_rd_addr_inc       <= '1';
            enable_rd_addr_decr      <= '1';

            Case trans_state Is
              When reset1 =>
                 trans_state           <= normal_op;
                 hold_ack              <= '1';
                 enable_rd_addr_inc    <= '0';
                 enable_rd_addr_decr   <= '0';

              When normal_op =>     -- Ignore restore and release inputs
                                    -- during normal op
                enable_mark_addr_inc     <= '1';
                enable_wr_addr_inc       <= '1';
                enable_rd_addr_inc       <= '1';
                enable_rd_addr_decr      <= '1';

                If (Mark = '1') Then   -- transition to packet op on a
                                       -- Mark command
                   trans_state <= mark1;
                   hold_ack    <= '1';
                else
                   trans_state <= normal_op;
                   hold_ack    <= '0';
                End if;


              When packet_op =>

                 enable_wr_addr_inc       <= '1';
                 enable_rd_addr_inc       <= '1';
                 enable_rd_addr_decr      <= '1';

                If (Restore = '1') Then
                   trans_state <= rest1;
                   hold_ack    <= '1';
                Elsif (Mark = '1') Then
                   trans_state <= mark1;
                   hold_ack    <= '1';
                Elsif (Release = '1') Then
                   trans_state <= rls1;
                   hold_ack    <= '1';
                else
                   trans_state <= packet_op;
                   hold_ack    <= '0';
                End if;

              When rest1 =>
                 trans_state <= pkt_update;
                 hold_ack    <= '1';

                 ld_addr_mark_into_write <= '1'; -- load the mark address into
                                                 -- the wr cntr

                 ld_occ_mark_into_norm   <= '1'; -- load the marked occupancy
                                                 -- into the normal occupancy
                                                 -- cntr

              When mark1 =>
                 trans_state             <= pkt_update;
                 hold_ack                <= '1';

                 ld_occ_norm_into_mark   <= '1'; -- load the normal occupancy
                                                 -- into mark occupancy cntr

                 ld_addr_write_into_mark <= '1'; -- load the write address
                                                 -- into mark register

              When rls1 =>
                 trans_state             <= nml_update;
                 hold_ack                <= '1';

                 ld_occ_norm_into_mark   <= '1'; -- load the normal occupancy
                                                 -- into mark occupancy cntr

                 ld_addr_write_into_mark <= '1'; -- load the write address
                                                 -- into mark register

              When nml_update =>
                 trans_state <= normal_op;
                 hold_ack    <= '0';

              When pkt_update =>
                 trans_state <= packet_op;
                 hold_ack    <= '0';

              When others   =>
                 trans_state <= normal_op;
                 hold_ack    <= '0';

            End case;
         Else
            null;
         End if;
       End process; -- TRANSITION_STATE_PROCESS





     --------------------------------------------------------------------------
     -- Instantiate the Occupancy Counter relative to marking operations
     -- This counter establishes the empty flag states
     --------------------------------------------------------------------------
     inc_mocc_by_2 <= decr_rd_addr and inc_mark_addr;
     inc_mocc      <= decr_rd_addr or inc_mark_addr;

     I_MARK_OCCUPANCY : entity opb_v20_v1_10_d.pf_occ_counter_top
       generic map(
         C_COUNT_WIDTH =>  OCC_CNTR_WIDTH
         )
       port map(
         Clk           =>  Bus_clk,
         Rst           =>  Bus_rst,
         Load_Enable   =>  ld_occ_norm_into_mark,
         Load_value    =>  sig_normal_occupancy,
         Count_Down    =>  inc_rd_addr,
         Count_Up      =>  inc_mocc,
         By_2          =>  inc_mocc_by_2,
         Count_Out     =>  sig_mark_occupancy,
         almost_full   =>  dummy_almost_full,
         full          =>  dummy_full,
         almost_empty  =>  int_almost_empty,
         empty         =>  int_empty
        );




     --------------------------------------------------------------------------
     -- Instantiate the Occupancy Counter relative to normal operations
     -- This counter establishes the full flag states.
     --------------------------------------------------------------------------

     inc_nocc_by_2 <= decr_rd_addr and inc_wr_addr;
     inc_nocc      <= decr_rd_addr or  inc_wr_addr;

     I_NORMAL_OCCUPANCY : entity opb_v20_v1_10_d.pf_occ_counter_top
       generic map(
         C_COUNT_WIDTH =>  OCC_CNTR_WIDTH
         )
       port map(
         Clk           =>  Bus_clk,
         Rst           =>  Bus_rst,
         Load_Enable   =>  ld_occ_mark_into_norm,
         Load_value    =>  sig_mark_occupancy,
         Count_Down    =>  inc_rd_addr,
         Count_Up      =>  inc_nocc,
         By_2          =>  inc_nocc_by_2,
         Count_Out     =>  sig_normal_occupancy,
         almost_full   =>  int_almost_full,
         full          =>  int_full,
         almost_empty  =>  dummy_almost_empty,
         empty         =>  dummy_empty
        );




     --------------------------------------------------------------------------
     -- Register and delay Full/Empty flags
     --------------------------------------------------------------------------
      REGISTER_FLAG_PROCESS : process (Bus_rst, Bus_Clk)
       Begin
         If (Bus_rst = '1') Then
            int_full_dly1         <= '0';
            int_full_dly2         <= '0';
            int_almost_empty_dly1 <= '0';
            int_empty_dly1        <= '1';

         Elsif (Bus_Clk'event and Bus_Clk = '1') Then

            int_full_dly1         <=  int_full;
            int_full_dly2         <=  int_full_dly1;
            int_almost_empty_dly1 <=  int_almost_empty;
            int_empty_dly1        <=  int_empty;

         Else
            null;
         End if;
       End process; -- REGISTER_FLAG_PROCESS






     --------------------------------------------------------------------------
     -- Write Address Counter Logic

    inc_wr_addr <= WrReq
                   and not(int_full)
                   and not(int_full_dly1)
                   and not(int_full_dly2)
                   and not(hold_ack)
                   and not(rd_backup and int_almost_full)
                   and enable_wr_addr_inc;






     I_WRITE_ADDR_CNTR : entity opb_v20_v1_10_d.pf_counter_top
         Generic Map (
            C_COUNT_WIDTH => ADDR_CNTR_WIDTH
            )
         Port Map (
           Clk          =>  Bus_Clk,
           Rst          =>  Bus_rst,
           Load_Enable  =>  ld_addr_mark_into_write,
           Load_value   =>  mark_address,
           Count_Down   =>  '0',
           Count_Up     =>  inc_wr_addr,
           Count_Out    =>  write_address
           );



     -- end of write counter logic
     --------------------------------------------------------------------------








     --------------------------------------------------------------------------
     -- Read Address Counter Logic

        -----------------------------------------------------------------------
        -- Detect end of burst read by IP and set backup condition
        -----------------------------------------------------------------------
        DETECT_RDCNT_BACKUP : process (Burst_rd_xfer, RdReq, int_empty_dly1)
            Begin
               if (Burst_rd_xfer = '1'
                   and RdReq = '0'
                   and int_empty_dly1 = '0') then

                  rd_backup <= '1';

                else

                  rd_backup <= '0';

                end if;

            End process; -- DETECT_RDCNT_BACKUP



        inc_rd_addr <= RdReq
                       and not(int_empty)
                       and not(int_empty_dly1)
                       and enable_rd_addr_inc;

        decr_rd_addr <=  rd_backup
                         and enable_rd_addr_decr;


        sig_zeros    <= (others => '0');



        I_READ_ADDR_CNTR : entity opb_v20_v1_10_d.pf_counter_top
            Generic Map ( C_COUNT_WIDTH => ADDR_CNTR_WIDTH
                     )
            Port Map (
              Clk          =>  Bus_Clk,
              Rst          =>  Bus_rst,
              Load_Enable  =>  '0',
              Load_value   =>  sig_zeros,
              Count_Down   =>  decr_rd_addr,
              Count_Up     =>  inc_rd_addr,
              Count_Out    =>  read_address
              );



     -- end read address counter logic
     --------------------------------------------------------------------------





     --------------------------------------------------------------------------
     -- Mark Register Control

         inc_mark_addr  <= inc_wr_addr
                           and enable_mark_addr_inc;




         I_MARKREG_ADDR_CNTR : entity opb_v20_v1_10_d.pf_counter_top
            Generic Map ( C_COUNT_WIDTH => ADDR_CNTR_WIDTH
                     )
            Port Map (
              Clk          =>  Bus_Clk,
              Rst          =>  Bus_rst,
              Load_Enable  =>  ld_addr_write_into_mark,
              Load_value   =>  write_address,
              Count_Down   =>  '0',
              Count_Up     =>  inc_mark_addr,
              Count_Out    =>  mark_address
              );


     -- end mark address counter logic
     --------------------------------------------------------------------------



end generate INCLUDE_PACKET_FEATURES;








 ------------------------------------------------------------------------------
 --  Generate the Read PFIFO with no packetizing features
 ------------------------------------------------------------------------------
 OMIT_PACKET_FEATURES : if (C_INCLUDE_PACKET_MODE = false) generate


   --Internal Signals

    signal  int_almost_full        : std_logic;
    signal  int_full               : std_logic;
    signal  int_full_dly1          : std_logic;
    signal  int_full_dly2          : std_logic;
    signal  int_empty              : std_logic;
    signal  int_almost_empty       : std_logic;
    Signal  int_almost_empty_dly1  : std_logic;
    Signal  int_empty_dly1         : std_logic;

    Signal  inc_rd_addr            : std_logic;
    Signal  decr_rd_addr           : std_logic;
    Signal  inc_wr_addr            : std_logic;

    Signal  rd_backup              : std_logic;

    Signal  dummy_empty            : std_logic;
    Signal  dummy_almost_empty     : std_logic;
    Signal  dummy_full             : std_logic;
    Signal  dummy_almost_full      : std_logic;

    signal  write_address          : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);
    signal  read_address           : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);
    signal  sig_zeros              : std_logic_vector(0 to ADDR_CNTR_WIDTH-1);

    signal  inc_nocc               : std_logic;
    signal  inc_nocc_by_2          : std_logic;
    signal  occ_load_value         : std_logic_vector(0 to OCC_CNTR_WIDTH-1);



 begin


     --Misc I/O Assignments


       Full          <=  int_full;
       Almost_Full   <=  int_almost_full;

       Empty         <=  int_empty; -- Align Empty flag with the DP occupancy
       Almost_Empty  <=  int_almost_empty; -- Align Almost_Empty flag with the
                                           -- DP occupancy
       Occupancy     <=  sig_normal_occupancy;

       Wr_Addr       <=  write_address;
       Rd_Addr       <=  read_address;

       WrAck         <=  inc_wr_addr; -- currently combinitorial
       RdAck         <=  inc_rd_addr; -- currently combinitorial

       DeadLock      <=  int_full and int_empty; -- both full and empty at the
                                                 -- same time

       DP_core_rden  <=  not(int_empty)-- assert read enable when not empty
                         or Bus_rst;   -- or during reset

       DP_core_wren  <=  not(int_full)  -- assert write enable when not full
                         or Bus_rst;    -- or during reset




     --------------------------------------------------------------------------
     -- Instantiate the Occupancy Counter relative to normal operations
     -- This counter establishes the empty and full flag states.
     --------------------------------------------------------------------------

     inc_nocc_by_2  <= decr_rd_addr and inc_wr_addr;
     inc_nocc       <= decr_rd_addr or  inc_wr_addr;
     occ_load_value <= (others => '0');


     I_NORMAL_OCCUPANCY : entity opb_v20_v1_10_d.pf_occ_counter_top
       generic map(
         C_COUNT_WIDTH =>  OCC_CNTR_WIDTH
         )
       port map(
         Clk           =>  Bus_clk,
         Rst           =>  Bus_rst,
         Load_Enable   =>  '0',
         Load_value    =>  occ_load_value,
         Count_Down    =>  inc_rd_addr,
         Count_Up      =>  inc_nocc,
         By_2          =>  inc_nocc_by_2,
         Count_Out     =>  sig_normal_occupancy,
         almost_full   =>  int_almost_full,
         full          =>  int_full,
         almost_empty  =>  int_almost_empty,
         empty         =>  int_empty
        );



     --------------------------------------------------------------------------
     -- Register and delay Full/Empty flags
     --------------------------------------------------------------------------
      REGISTER_FLAG_PROCESS : process (Bus_rst, Bus_Clk)
       Begin
         If (Bus_rst = '1') Then
            int_full_dly1         <= '0';
            int_full_dly2         <= '0';
            int_almost_empty_dly1 <= '0';
            int_empty_dly1        <= '1';

         Elsif (Bus_Clk'event and Bus_Clk = '1') Then

            int_full_dly1         <=  int_full;
            int_full_dly2         <=  int_full_dly1;
            int_almost_empty_dly1 <=  int_almost_empty;
            int_empty_dly1        <=  int_empty;

         Else
            null;
         End if;
       End process; -- TRANSITION_STATE_PROCESS






     -----------------------------------------------------------------------
     -- Write Address Counter Logic


     inc_wr_addr <= WrReq
                    and not(int_full)
                    and not(int_full_dly1)
                    and not(int_full_dly2)
                    and not(rd_backup and int_almost_full);




     I_WRITE_ADDR_CNTR : entity opb_v20_v1_10_d.pf_counter_top
         Generic Map (
            C_COUNT_WIDTH => ADDR_CNTR_WIDTH
            )
         Port Map (
           Clk          =>  Bus_Clk,
           Rst          =>  Bus_rst,
           Load_Enable  =>  '0',
           Load_value   =>  sig_zeros,
           Count_Down   =>  '0',
           Count_Up     =>  inc_wr_addr,
           Count_Out    =>  write_address
           );



     -- end of write counter logic
     -------------------------------------------------------------------------








     -----------------------------------------------------------------------
     -- Read Address Counter Logic


        --------------------------------------------------------------------
        -- Detect end of burst read by IP and set backup condition
        --------------------------------------------------------------------
        DETECT_RDCNT_BACKUP : process (Burst_rd_xfer, RdReq, int_empty_dly1)
            Begin
               if (Burst_rd_xfer = '1'
                   and RdReq = '0'
                   and int_empty_dly1 = '0') then

                  rd_backup <= '1';

                else

                  rd_backup <= '0';

                end if;

            End process; -- DETECT_RDCNT_BACKUP



        inc_rd_addr <= RdReq
                       and not(int_empty)
                       and not(int_empty_dly1);

        decr_rd_addr <=  rd_backup;


        sig_zeros    <= (others => '0');



        I_READ_ADDR_CNTR : entity opb_v20_v1_10_d.pf_counter_top
            Generic Map ( C_COUNT_WIDTH => ADDR_CNTR_WIDTH
                     )
            Port Map (
              Clk          =>  Bus_Clk,
              Rst          =>  Bus_rst,
              Load_Enable  =>  '0',
              Load_value   =>  sig_zeros,
              Count_Down   =>  decr_rd_addr,
              Count_Up     =>  inc_rd_addr,
              Count_Out    =>  read_address
              );

     -- end read address counter logic
     ----------------------------------------------------------------



 end generate OMIT_PACKET_FEATURES;







   INCLUDE_VACANCY : if (C_INCLUDE_VACANCY = true) generate

       Constant REGISTER_VACANCY : boolean := false;

       Signal  slv_max_vacancy  : std_logic_vector(0 to OCC_CNTR_WIDTH-1);
       Signal  int_vacancy      : std_logic_vector(0 to OCC_CNTR_WIDTH-1);



   begin

       Vacancy         <=  int_vacancy; -- set to zeroes for now.


       slv_max_vacancy <= CONV_STD_LOGIC_VECTOR(MAX_OCCUPANCY, OCC_CNTR_WIDTH);

       I_VAC_CALC : entity opb_v20_v1_10_d.pf_adder
       generic map(
         C_REGISTERED_RESULT => REGISTER_VACANCY,
         C_COUNT_WIDTH       => OCC_CNTR_WIDTH
         )
       port map (
         Clk           =>  Bus_Clk,
         Rst           =>  Bus_rst,
         --Carry_Out   =>  ,
         Ain           =>  slv_max_vacancy,
         Bin           =>  sig_normal_occupancy,
         Add_sub_n     =>  '0', -- always subtract
         result_out    =>  int_vacancy
         );


   end generate; -- INCLUDE_VACANCY





   OMIT_VACANCY : if (C_INCLUDE_VACANCY = false) generate

        Signal int_vacancy : std_logic_vector(0 to OCC_CNTR_WIDTH-1);

   begin

       int_vacancy <= (others => '0');

       Vacancy     <=  int_vacancy; -- set to zeroes for now.

   end generate; -- INCLUDE_VACANCY





  end implementation;








