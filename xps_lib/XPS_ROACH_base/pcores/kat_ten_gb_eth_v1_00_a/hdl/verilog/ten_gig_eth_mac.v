`timescale 1ns/1ps
/*
 *  Copyright (c) 2005-2006, Regents of the University of California
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 *      - Redistributions of source code must retain the above copyright notice,
 *          this list of conditions and the following disclaimer.
 *      - Redistributions in binary form must reproduce the above copyright
 *          notice, this list of conditions and the following disclaimer
 *          in the documentation and/or other materials provided with the
 *          distribution.
 *      - Neither the name of the University of California, Berkeley nor the
 *          names of its contributors may be used to endorse or --          products derived from this software without specific prior
 *          written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 *  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *   #      ###    #####          #######
 *  ##     #   #  #     #  #      #
 * # #    # #   # #        #      #
 *   #    #  #  # #  ####  #####  #####
 *   #    #   # # #     #  #    # #
 *   #     #   #  #     #  #    # #
 * #####    ###    #####   #####  #######
 *
 *
 * 10GbEthernet core MAC
 *
 * *********************************************************************
 * * THIS CORE IS INTENDED TO BE USED WITH THE UCB 10GB INTERFACE      *
 * * IT SUPPORTS ONLY A VERY LIMITED RANGE OF THE FUNCTIONALITIES      *
 * * THAT A REAL MAC SHOULD SUPPORT. FOR A FULL SUPPORT OF 10GB,       *
 * * USE THE XILINX MAC.                                               *
 * * NOT SUPPORTED:                                                    *
 * *   - no configuration                                              *
 * *   - no statistics vectors                                         *
 * *   - no interframe minimization                                    *
 * *   - supports only full words or 16 bits word at the input         *
 * *   - no flow control                                               *
 * *********************************************************************
 *
 * created by Pierre-Yves Droz 2006
 * CRC + verilogization by David George 2008/9
 *
 *----------------------------------------------------------------------------
 * mac.v
 *----------------------------------------------------------------------------
 */

module ten_gig_eth_mac(
    input         reset,
    //Transmit user I/F
    input         tx_clk0,
    input         tx_dcm_lock,
    input         tx_underrun,
    input  [63:0] tx_data,
    input   [7:0] tx_data_valid,
    input         tx_start,
    output        tx_ack,
    input   [7:0] tx_ifg_delay,    
    output [24:0] tx_statistics_vector,
    output        tx_statistics_valid,
    //Receive user I/F
    input         rx_clk0,
    input         rx_dcm_lock,
    output [63:0] rx_data,
    output  [7:0] rx_data_valid,
    output        rx_good_frame,
    output        rx_bad_frame,
    output [28:0] rx_statistics_vector,
    output  [7:0] rx_statistics_valid,
    // Misc
    input  [15:0] pause_val,
    input         pause_req,
    input  [66:0] configuration_vector,
    //XGMII I/Fs
    output [63:0] xgmii_txd,
    output  [7:0] xgmii_txc,
    input  [63:0] xgmii_rxd,
    input   [7:0] xgmii_rxc
  );

  mac_tx #(
    .USE_HARD_CRC(1)
  ) mac_tx_inst (
    .xgmii_txd            (xgmii_txd),
    .xgmii_txc            (xgmii_txc),

    .reset                (reset),
    .tx_clk               (tx_clk0),
    .tx_dcm_lock          (tx_dcm_lock),
    .tx_underrun          (tx_underrun),
    .tx_data              (tx_data),
    .tx_data_valid        (tx_data_valid),
    .tx_start             (tx_start),
    .tx_ack               (tx_ack),
    .tx_ifg_delay         (tx_ifg_delay),    
    .tx_statistics_vector (tx_statistics_vector),
    .tx_statistics_valid  (tx_statistics_valid)

  );

  mac_rx #(
    .USE_HARD_CRC(1)
  ) mac_rx_inst (
    .xgmii_rxd            (xgmii_rxd),
    .xgmii_rxc            (xgmii_rxc),

    .reset                (reset),
    .rx_clk               (rx_clk0),
    .rx_dcm_lock          (rx_dcm_lock),
    .rx_data              (rx_data),
    .rx_data_valid        (rx_data_valid),
    .rx_good_frame        (rx_good_frame),
    .rx_bad_frame         (rx_bad_frame),
    .rx_statistics_vector (rx_statistics_vector),
    .rx_statistics_valid  (rx_statistics_valid)
  );


endmodule
