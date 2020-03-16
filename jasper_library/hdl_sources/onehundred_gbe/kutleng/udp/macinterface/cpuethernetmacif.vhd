--------------------------------------------------------------------------------
-- Legal & Copyright:   (c) 2018 Kutleng Engineering Technologies (Pty) Ltd    - 
--                                                                             -
-- This program is the proprietary software of Kutleng Engineering Technologies-
-- and/or its licensors, and may only be used, duplicated, modified or         -
-- distributed pursuant to the terms and conditions of a separate, written     -
-- license agreement executed between you and Kutleng (an "Authorized License")-
-- Except as set forth in an Authorized License, Kutleng grants no license     -
-- (express or implied), right to use, or waiver of any kind with respect to   -
-- the Software, and Kutleng expressly reserves all rights in and to the       -
-- Software and all intellectual property rights therein.  IF YOU HAVE NO      -
-- AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, -
-- AND SHOULD IMMEDIATELY NOTIFY KUTLENG AND DISCONTINUE ALL USE OF THE        -
-- SOFTWARE.                                                                   -
--                                                                             -
-- Except as expressly set forth in the Authorized License,                    -
--                                                                             -
-- 1.     This program, including its structure, sequence and organization,    -
-- constitutes the valuable trade secrets of Kutleng, and you shall use all    -
-- reasonable efforts to protect the confidentiality thereof,and to use this   -
-- information only in connection with South African Radio Astronomy           -
-- Observatory (SARAO) products.                                               -
--                                                                             -
-- 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED     -
-- "AS IS" AND WITH ALL FAULTS AND KUTLENG MAKES NO PROMISES, REPRESENTATIONS  -
-- OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH       -
-- RESPECT TO THE SOFTWARE.  KUTLENG SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED-
-- WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A        -
-- PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET        -
-- ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE-
-- ENJOYMENT, QUIET POSSESSION USE OR PERFORMANCE OF THE SOFTWARE.             -
--                                                                             -
-- 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL KUTLENG OR -
-- ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT-
-- , OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO  -
-- YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF KUTLENG HAS BEEN       -
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF -
-- THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR ZAR R1, WHICHEVER IS    -
-- GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF       -
-- ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.                                    -
-- --------------------------------------------------------------------------- -
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS                    -
-- PART OF THIS FILE AT ALL TIMES.                                             -
--=============================================================================-
-- Company          : Kutleng Dynamic Electronics Systems (Pty) Ltd            -
-- Engineer         : Benjamin Hector Hlophe                                   -
--                                                                             -
-- Design Name      : CASPER BSP                                               -
-- Module Name      : cpuethernetmacif - rtl                                   -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : The cpuethernetmacif module receives and send UDP/IP data-
--                    from the CPU interface.It uses YX and RX 2K ringbuffers. -
-- Dependencies     : cpumacifudpsender,macifudpreceiver                       -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpuethernetmacif is
    generic(
        G_SLOT_WIDTH               : natural := 4;
        G_AXIS_DATA_WIDTH          : natural := 512;
        G_CPU_TX_DATA_BUFFER_ASIZE : natural := 13;
        G_CPU_RX_DATA_BUFFER_ASIZE : natural := 13
    );
    port(
        axis_clk                                     : in  STD_LOGIC;
        aximm_clk                                    : in  STD_LOGIC;
        axis_reset                                   : in  STD_LOGIC;
        aximm_gmac_reg_mac_address                   : in  STD_LOGIC_VECTOR(47 downto 0);
        aximm_gmac_reg_udp_port                      : in  STD_LOGIC_VECTOR(15 downto 0);
        aximm_gmac_reg_udp_port_mask                 : in  STD_LOGIC_VECTOR(15 downto 0);
        aximm_gmac_reg_mac_promiscous_mode           : in  STD_LOGIC;
        aximm_gmac_reg_local_ip_address              : in  STD_LOGIC_VECTOR(31 downto 0);
        ------------------------------------------------------------------------
        -- Transmit Ring Buffer Interface according to EthernetCore Memory MAP--
        ------------------------------------------------------------------------ 
        aximm_gmac_tx_data_write_enable              : in  STD_LOGIC;
        aximm_gmac_tx_data_read_enable               : in  STD_LOGIC;
        aximm_gmac_tx_data_write_data                : in  STD_LOGIC_VECTOR(7 downto 0);
        -- The Byte Enable is as follows
        -- Bit (0) Byte Enables
        -- Bit (1) Maps to TLAST (To terminate the data stream).
        aximm_gmac_tx_data_write_byte_enable         : in  STD_LOGIC_VECTOR(1 downto 0);
        aximm_gmac_tx_data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
        -- The Byte Enable is as follows
        -- Bit (0) Byte Enables
        -- Bit (1) Maps to TLAST (To terminate the data stream).
        aximm_gmac_tx_data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
        aximm_gmac_tx_data_write_address             : in  STD_LOGIC_VECTOR(G_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
        aximm_gmac_tx_data_read_address              : in  STD_LOGIC_VECTOR(G_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
        aximm_gmac_tx_ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        aximm_gmac_tx_ringbuffer_slot_set            : in  STD_LOGIC;
        aximm_gmac_tx_ringbuffer_slot_status         : out STD_LOGIC;
        aximm_gmac_tx_ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        ------------------------------------------------------------------------
        -- Receive Ring Buffer Interface according to EthernetCore Memory MAP --
        ------------------------------------------------------------------------ 
        aximm_gmac_rx_data_read_enable               : in  STD_LOGIC;
        aximm_gmac_rx_data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
        -- The Byte Enable is as follows
        -- Bit (0) Byte Enables
        -- Bit (1) Maps to TLAST (To terminate the data stream).		
        aximm_gmac_rx_data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
        aximm_gmac_rx_data_read_address              : in  STD_LOGIC_VECTOR(G_CPU_RX_DATA_BUFFER_ASIZE - 1 downto 0);
        aximm_gmac_rx_ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        aximm_gmac_rx_ringbuffer_slot_clear          : in  STD_LOGIC;
        aximm_gmac_rx_ringbuffer_slot_status         : out STD_LOGIC;
        aximm_gmac_rx_ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        --Inputs from AXIS bus of the MAC side
        --Outputs to AXIS bus MAC side 
        axis_tx_tpriority                            : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        axis_tx_tdata                                : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_tx_tvalid                               : out STD_LOGIC;
        axis_tx_tready                               : in  STD_LOGIC;
        axis_tx_tkeep                                : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_tx_tlast                                : out STD_LOGIC;
        --Inputs from AXIS bus of the MAC side
        axis_rx_tdata                                : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_rx_tvalid                               : in  STD_LOGIC;
        axis_rx_tuser                                : in  STD_LOGIC;
        axis_rx_tkeep                                : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_rx_tlast                                : in  STD_LOGIC
    );
end entity cpuethernetmacif;

architecture rtl of cpuethernetmacif is
    component cpumacifudpsender is
        generic(
            G_SLOT_WIDTH      : natural := 4;
            G_AXIS_DATA_WIDTH : natural := 512;
            -- The address width is log2(2048/(512/8))=5 bits wide
            G_ADDR_WIDTH      : natural := 5
        );
        port(
            axis_clk                       : in  STD_LOGIC;
            aximm_clk                      : in  STD_LOGIC;
            axis_reset                     : in  STD_LOGIC;
            -- Packet Write in addressed bus format
            -- Packet Readout in addressed bus format
            data_write_enable              : in  STD_LOGIC;
            data_read_enable               : in  STD_LOGIC;
            data_write_data                : in  STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0) Byte Enables
            -- Bit (1) Maps to TLAST (To terminate the data stream).
            data_write_byte_enable         : in  STD_LOGIC_VECTOR(1 downto 0);
            data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0) Byte Enables
            -- Bit (1) Maps to TLAST (To terminate the data stream).
            data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
            data_write_address             : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            data_read_address              : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            ringbuffer_slot_set            : in  STD_LOGIC;
            ringbuffer_slot_status         : out STD_LOGIC;
            ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            --Inputs from AXIS bus of the MAC side
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority              : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            axis_tx_tdata                  : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_tx_tvalid                 : out STD_LOGIC;
            axis_tx_tready                 : in  STD_LOGIC;
            axis_tx_tkeep                  : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_tx_tlast                  : out STD_LOGIC
        );
    end component cpumacifudpsender;

    component cpumacifudpreceiver is
        generic(
            G_SLOT_WIDTH      : natural := 4;
            G_AXIS_DATA_WIDTH : natural := 512;
            -- The address width is log2(2048/(512/8))=5 bits wide
            G_ADDR_WIDTH      : natural := 5
        );
        port(
            axis_clk                       : in  STD_LOGIC;
            aximm_clk                      : in  STD_LOGIC;
            axis_reset                     : in  STD_LOGIC;
            -- Setup information
            reg_mac_address                : in  STD_LOGIC_VECTOR(47 downto 0);
            reg_udp_port                   : in  STD_LOGIC_VECTOR(15 downto 0);
            reg_udp_port_mask              : in  STD_LOGIC_VECTOR(15 downto 0);
            reg_promiscous_mode            : in  STD_LOGIC;
            reg_local_ip_address           : in  STD_LOGIC_VECTOR(31 downto 0);
            -- Packet Readout in addressed bus format
            data_read_enable               : in  STD_LOGIC;
            -- The Byte Enable is as follows
            -- Bit (0) Byte Enables
            -- Bit (1) Maps to TLAST (To terminate the data stream).		
            data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0) Byte Enables
            -- Bit (1) Maps to TLAST (To terminate the data stream).		
            data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
            data_read_address              : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            ringbuffer_slot_clear          : in  STD_LOGIC;
            ringbuffer_slot_status         : out STD_LOGIC;
            ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata                  : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_rx_tvalid                 : in  STD_LOGIC;
            axis_rx_tuser                  : in  STD_LOGIC;
            axis_rx_tkeep                  : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_rx_tlast                  : in  STD_LOGIC
        );
    end component cpumacifudpreceiver;

begin

    UDPSender_i : cpumacifudpsender
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_AXIS_DATA_WIDTH => G_AXIS_DATA_WIDTH,
            G_ADDR_WIDTH      => G_CPU_TX_DATA_BUFFER_ASIZE
        )
        port map(
            axis_clk                       => axis_clk,
            aximm_clk                      => aximm_clk,
            axis_reset                     => axis_reset,
            data_write_enable              => aximm_gmac_tx_data_write_enable,
            data_read_enable               => aximm_gmac_tx_data_read_enable,
            data_write_data                => aximm_gmac_tx_data_write_data,
            data_write_byte_enable         => aximm_gmac_tx_data_write_byte_enable,
            data_read_data                 => aximm_gmac_tx_data_read_data,
            data_read_byte_enable          => aximm_gmac_tx_data_read_byte_enable,
            data_write_address             => aximm_gmac_tx_data_write_address,
            data_read_address              => aximm_gmac_tx_data_read_address,
            ringbuffer_slot_id             => aximm_gmac_tx_ringbuffer_slot_id,
            ringbuffer_slot_set            => aximm_gmac_tx_ringbuffer_slot_set,
            ringbuffer_slot_status         => aximm_gmac_tx_ringbuffer_slot_status,
            ringbuffer_number_slots_filled => aximm_gmac_tx_ringbuffer_number_slots_filled,
            axis_tx_tpriority              => axis_tx_tpriority,
            axis_tx_tdata                  => axis_tx_tdata,
            axis_tx_tvalid                 => axis_tx_tvalid,
            axis_tx_tready                 => axis_tx_tready,
            axis_tx_tkeep                  => axis_tx_tkeep,
            axis_tx_tlast                  => axis_tx_tlast
        );

    UDPReceiver_i : cpumacifudpreceiver
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_AXIS_DATA_WIDTH => G_AXIS_DATA_WIDTH,
            G_ADDR_WIDTH      => G_CPU_RX_DATA_BUFFER_ASIZE
        )
        port map(
            axis_clk                       => axis_clk,
            aximm_clk                      => aximm_clk,
            axis_reset                     => axis_reset,
            reg_mac_address                => aximm_gmac_reg_mac_address,
            reg_udp_port                   => aximm_gmac_reg_udp_port,
            reg_udp_port_mask              => aximm_gmac_reg_udp_port_mask,
            reg_promiscous_mode            => aximm_gmac_reg_mac_promiscous_mode,
            reg_local_ip_address           => aximm_gmac_reg_local_ip_address,
            data_read_enable               => aximm_gmac_rx_data_read_enable,
            data_read_data                 => aximm_gmac_rx_data_read_data,
            data_read_byte_enable          => aximm_gmac_rx_data_read_byte_enable,
            data_read_address              => aximm_gmac_rx_data_read_address,
            ringbuffer_slot_id             => aximm_gmac_rx_ringbuffer_slot_id,
            ringbuffer_slot_clear          => aximm_gmac_rx_ringbuffer_slot_clear,
            ringbuffer_slot_status         => aximm_gmac_rx_ringbuffer_slot_status,
            ringbuffer_number_slots_filled => aximm_gmac_rx_ringbuffer_number_slots_filled,
            axis_rx_tdata                  => axis_rx_tdata,
            axis_rx_tvalid                 => axis_rx_tvalid,
            axis_rx_tuser                  => axis_rx_tuser,
            axis_rx_tkeep                  => axis_rx_tkeep,
            axis_rx_tlast                  => axis_rx_tlast
        );
end architecture rtl;
