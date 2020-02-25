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
-- Module Name      : prconfigcontroller_tb - rtl                              -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates the ARP,Streaming Data over UDP -
--                    and the Partial Reconfiguration UDP Controller.          -
--                    TODO                                                     -
--                    Must connect a Microblaze module, which can do the ARP   -
--                    and control ARP,RARP,DHCP,and the AXI Lite bus.          -
--                                                                             -
-- Dependencies     : macifudpserver,arpmodule,axisthreeportfabricmultiplexer  -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity prconfigcontroller_tb is
end entity prconfigcontroller_tb;

architecture rtl of prconfigcontroller_tb is

    component prconfigcontroller is
        generic(
            G_SLOT_WIDTH      : natural                          := 4;
            G_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1) := 5;
            -- The address width is log2(2048/(512/8))=5 bits wide
            G_ADDR_WIDTH      : natural                          := 5
        );
        port(
            --312.50MHz system clock
            axis_clk          : in  STD_LOGIC;
            -- 95 MHz ICAP clock
            icap_clk          : in  STD_LOGIC;
            -- Module reset
            -- Must be synchronized internally for each clock domain
            axis_reset        : in  STD_LOGIC;
            -- Setup information
            ServerMACAddress  : in  STD_LOGIC_VECTOR(47 downto 0);
            ServerIPAddress   : in  STD_LOGIC_VECTOR(31 downto 0);
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata     : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid    : in  STD_LOGIC;
            axis_rx_tuser     : in  STD_LOGIC;
            axis_rx_tkeep     : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast     : in  STD_LOGIC;
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            axis_tx_tdata     : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid    : out STD_LOGIC;
            axis_tx_tready    : in  STD_LOGIC;
            axis_tx_tkeep     : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast     : out STD_LOGIC;
        	axis_prog_full    : in  STD_LOGIC;
        	axis_prog_empty   : in  STD_LOGIC;	
            axis_data_count   : in  STD_LOGIC_VECTOR(13 downto 0);                        			
            ICAP_PRDONE       : in  std_logic;
            ICAP_PRERROR      : in  std_logic;
            ICAP_AVAIL        : in  std_logic;
            ICAP_CSIB         : out std_logic;
            ICAP_RDWRB        : out std_logic;
            ICAP_DataOut      : in  std_logic_vector(31 downto 0);
            ICAP_DataIn       : out std_logic_vector(31 downto 0)
        );
    end component prconfigcontroller;

    constant G_SLOT_WIDTH     : natural                          := 4;
    constant G_EMAC_ADDR      : std_logic_vector(47 downto 0)    := X"000A_3502_4192";
    constant G_PR_SERVER_PORT : natural range 0 to ((2**16) - 1) := 10000;
    constant G_IP_ADDR        : std_logic_vector(31 downto 0)    := X"C0A8_640A"; --192.168.100.10
    signal axis_clk           : std_logic                        := '1';
    signal icap_clk           : std_logic                        := '1';
    signal axis_reset         : std_logic                        := '1';
    signal ICAP_PRDONE        : std_logic                        := '1';
    signal ICAP_PRERROR       : std_logic                        := '0';
    signal ICAP_AVAIL         : std_logic                        := '1';
    signal ICAP_CSIB          : std_logic;
    signal ICAP_RDWRB         : std_logic;
    signal ICAP_DataOut       : std_logic_vector(31 downto 0)    := (others => '0');
    signal ICAP_DataIn        : std_logic_vector(31 downto 0);

    signal axis_rx_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_rx_tvalid : STD_LOGIC;
    signal axis_rx_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_rx_tlast  : STD_LOGIC;
    signal axis_rx_tuser  : STD_LOGIC;
	
	signal axis_prog_full         : STD_LOGIC := '0';
    signal axis_prog_empty        : STD_LOGIC := '1';
    signal axis_data_count        : STD_LOGIC_VECTOR(13 downto 0) := (others => '0');                
    

    signal axis_tx_tpriority_1_pr : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
    signal axis_tx_tdata_1_pr     : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_tx_tvalid_1_pr    : STD_LOGIC;
    signal axis_tx_tkeep_1_pr     : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_tx_tlast_1_pr     : STD_LOGIC;
    signal axis_tx_tready_1_pr    : STD_LOGIC := '1';

    constant C_ICAP_CLK_PERIOD : time := 10.52 ns;
    constant C_CLK_PERIOD      : time := 3.2 ns;
begin
    icap_clk   <= not icap_clk after C_ICAP_CLK_PERIOD / 2;
    axis_clk   <= not axis_clk after C_CLK_PERIOD / 2;
    axis_reset <= '1', '0' after C_ICAP_CLK_PERIOD * 20;

    Stimproc : process
    begin
        axis_rx_tdata  <= (others => '0');
        axis_rx_tvalid <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= (others => '0');
        axis_rx_tlast  <= '0';
        wait for C_ICAP_CLK_PERIOD * 30;
        
        axis_data_count <= "00" & X"100";
        
        -- 1
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
		

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
		
        
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        -- Send DWORD 3 AA99_5566 : Sequence 0000_0014 - This is an error packet
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"2ac843fa0000000000000000aa9955660000001401da4deb1200102778b50a64a8c09664a8c015da11400040c016260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';



        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        
        
        
        
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        -- Send DWORD 3 AA99_5566 : Sequence 0000_0014 - This is an error packet
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"2ac843fa0000000000000000aa9955660000001401da4deb1200102778b50a64a8c09664a8c015da11400040c016260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';



        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        
        
        
        
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        -- Send DWORD 3 AA99_5566 : Sequence 0000_0014 - This is an error packet
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"2ac843fa0000000000000000aa9955660000001401da4deb1200102778b50a64a8c09664a8c015da11400040c016260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';



        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        
                        

        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 20;		
		
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 20;      
		

        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 20;      
        
		

		
		
        
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 20;      
        
        -- Send DWORD 3 AA99_5566 : Sequence 0000_0014 - This is an error packet
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"2ac843fa0000000000000000aa9955660000001401da4deb1200102778b50a64a8c09664a8c015da11400040c016260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 30;      


        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;
        
        




        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_CLK_PERIOD*4;		
        wait for C_ICAP_CLK_PERIOD * 10;
		

        

        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
		
        --  Send DFRAME: DFRAME_LENGTH = 0x09
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000800000009ad100a32001027a6d60a64a8c09664a8c0150e11400040a0e2460000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e000000000000001e000000000000000093a06e360000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"00000000000fffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        



        --  Send DFRAME: DFRAME_LENGTH = 0x15
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001400000015ad980862001027a6d60a64a8c09664a8c0d90d11400040ace2760000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e0000000000000000bbed99aa0000200000000000200000000000200000000000bbed99aa00002000";
        axis_rx_tkeep  <= X"000000000000000f";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 100;


        --  Send DFRAME: DFRAME_LENGTH = 0x16
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001500000016ad6e0866001027a6d60a64a8c09664a8c0d40d11400040ade27a0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e000000000000001e00000000f6928ad1200000000000200000000000200000002000000000002000";
        axis_rx_tkeep  <= X"00000000000000ff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;




        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        --  Send DFRAME: DFRAME_LENGTH = 0x18
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001700000018ad3a086e001027a6d60a64a8c09664a8c0ca0d11400040afe2820000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"000000000000000000000000000000000000000000000000000000000000001e000000000000001e000000008697b2d000002000000000002000000000002000";
        axis_rx_tkeep  <= X"000000000000ffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
		



        --  Send DFRAME: DFRAME_LENGTH = 0x01
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"883be4970000000000000000ffffffff0000000001ad200b12001027a6d60a64a8c09664a8c03d0e1140004098e2260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 100;


        --  Send DFRAME: DFRAME_LENGTH = 0x02
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"af55fc1d00000000ffff0000ffffffff0100000002ad160b16001027a6d60a64a8c09664a8c0380e1140004099e22a0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        


        --  Send DFRAME: DFRAME_LENGTH = 0x03
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"c919b12c0000ffffffff0000ffffffff0200000003ad0c0b1a001027a6d60a64a8c09664a8c0330e114000409ae22e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        

        --  Send DFRAME: DFRAME_LENGTH = 0x04
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"ffffffff0000ffffffff0000ffffffff0300000004ad020b1e001027a6d60a64a8c09664a8c02e0e114000409be2320000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        
        --  Send DFRAME: DFRAME_LENGTH = 0x05
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"ffffffff0000ffffffff0000ffffffff0400000005adf80a22001027a6d60a64a8c09664a8c0290e114000409ce2360000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000006286ecb4ffff0000ffffffff0000ffffffff0000ffffffff0400000005adf80a6286ecb4ffff0000";
        axis_rx_tkeep  <= X"000000000000000f";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        


        --  Send DFRAME: DFRAME_LENGTH = 0x06
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"112200440000000000bb0000ffffffff0500000006addbe926001027a6d60a64a8c09664a8c0240e114000409de23a0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e000000000000001e000000000000001e000000000000001e00000000362742e20000ffffffff0000";
        axis_rx_tkeep  <= X"00000000000000ff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        --  Send DFRAME: DFRAME_LENGTH = 0x07
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000600000007ad440a2a001027a6d60a64a8c09664a8c01f0e114000409ee23e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"000000000000000000000000000000000000000000000000000000000000001e000000000000001e00000000000000004f95557d200000000000200000000000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        --  Send DFRAME: DFRAME_LENGTH = 0x08
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000700000008ad3a0a2e001027a6d60a64a8c09664a8c01a0e114000409fe2420000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000009924af3a000000002000000000002000000000002000000000002000000000002000000000000000200000000000200000000000";
        axis_rx_tkeep  <= X"000000000000ffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        

        --  Send DFRAME: DFRAME_LENGTH = 0x24
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000300000024ad354a9e00102753930a64a8c09664a8c0b6d9114000409316b20000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;

        --  Send DFRAME: DFRAME_LENGTH = 0x25
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000400000025ad10ffa200102753930a64a8c09664a8c0b1d9114000409416b60000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"0000ffffffff0000ffffffff0000ffffffff000050000a3f00003003c00000002000000000002000000000000000000700003000800100002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"000000000000000000000000000000000000000000000000eac42f69ffffffff0000ffffffff0000ffffffff0000ffffffff000050000a3feac42f69ffffffff";
        axis_rx_tkeep  <= X"000000000000000f";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;

        --  Send DFRAME: DFRAME_LENGTH = 0x26
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"ffffffff0000112200440000000000bb0500000026ad8f29a600102753930a64a8c09664a8c0acd9114000409516ba0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000aa9955660000ffffffff0000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e000000000000001e000000000000001e000000000000001e000000004d2a179d0000000020000000";
        axis_rx_tkeep  <= X"00000000000000ff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        -- Send FRAME 3 FFFF_FFFF : Sequence 0000_00152
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000c0900000000003133000405d0000015262a56d7c9601102774830a64a8c09664a8c0ca281140004087c6aa0100450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000007ff500000000000000000000c0e800000000031500000000000000000000000000000000c120000000001ff9000000007ff5000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000007ffd00000000000000000000080000000000006000000000000000000000000000000000c1200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000002f4000000007ffd0000000000000000000064100000000000000000000000000000000000000000000000010000000002f300000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000002f2f000000002f2f00000000000000000000000000000000000000000000ff00000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000e54dbd23000000000000000000000000000000000000000010bd00000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"00ffffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;



        --  Send DFRAME: DFRAME_LENGTH = 0x09
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000000800000009ad100a32001027a6d60a64a8c09664a8c0150e11400040a0e2460000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000001e000000000000001e000000000000000093a06e360000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"00000000000fffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        
        --  Send DFRAME: DFRAME_LENGTH = 0x17
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"200000000000200000000000200000001600000017ad64086a001027a6d60a64a8c09664a8c0cf0d11400040aee27e0000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000cacd6be500000000200000000000200000000000200000000000200000000000cacd6be5000000002000000000002000";
        axis_rx_tkeep  <= X"0000000000000fff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;
        
        
        -- Send FRAME 3 FFFF_FFFF : Sequence 0000_00152
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000c0900000000003133000405d0000015262a56d7c9601102774830a64a8c09664a8c0ca281140004087c6aa0100450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000007ff500000000000000000000c0e800000000031500000000000000000000000000000000c120000000001ff9000000007ff5000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000007ffd00000000000000000000080000000000006000000000000000000000000000000000c1200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000002f4000000007ffd0000000000000000000064100000000000000000000000000000000000000000000000010000000002f300000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000002f2f000000002f2f00000000000000000000000000000000000000000000ff00000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000e54dbd23000000000000000000000000000000000000000010bd00000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"00ffffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 40;


        -- Send DFRAME: DFRAME_LENGTH = 0xF4
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"2000000000002000000040002000000001000000f4adef94de03102749ba0a64a8c09664a8c0f768114000401284f20300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000004000200000000000200000004000200000000000200000004000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"04002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000003020000000010020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"c001000000000000000030008001000004b220930000300180010000200000000000200000000000000000070000300080010000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00003003000100000020000000003000c00100000002000000003003000100000002000000003000c00100000000040000003000a00100000000050000003000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"0040000000000000004000000000000000000040000000003000405d00000004580d000030002001000020000000000000000001000030008001000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00400000000000000000000000200000002000400000000100000000adf400000000000000400000000000000000004000000000000000400000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000002000000020000000000000000000000000002000000020004000000000000000000000002000000020004000000000000000000000002000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"00000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 400;


		
        -- Send DFRAME: DFRAME_LENGTH = 0xF3
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad0033da03102749ba0a64a8c09664a8c0fc68114000401184ee0300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"ffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"0020200000000000200000000020200000000000aa9955660020ffffffff0000ffffffff0020112200440000000000bb0020ffffffff0000ffffffff0020ffff";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"20000000002020000000070020000000003020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"0000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff2000000000c0";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"002020000000000020000000002020000000000020000000002020000000000020000000002020000000ffff20000000ffff20000000bb0020000000ffff2000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"20000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"00000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000002020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"0000000000002000bb000000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"0000000000000020000000200000000020000000000000000020000099aa00000000200066550000ffffffff0000ffff000000002000ffff0000440022110000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"00000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"243a993e00000000002000000020ffff0000ffff000000000000002000000020c000000020000000000000000020000000200007000030000000000000000020";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_CLK_PERIOD*4;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 400;
		
		
		
        -- Send FRAME 3 FFFF_FFFF : Sequence 0000_00152
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000c0900000000003133000405d0000015262a56d7c9601102774830a64a8c09664a8c0ca281140004087c6aa0100450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000007ff500000000000000000000c0e800000000031500000000000000000000000000000000c120000000001ff9000000007ff5000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000007ffd00000000000000000000080000000000006000000000000000000000000000000000c1200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000002f4000000007ffd0000000000000000000064100000000000000000000000000000000000000000000000010000000002f300000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000002f2f000000002f2f00000000000000000000000000000000000000000000ff00000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000e54dbd23000000000000000000000000000000000000000010bd00000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"00ffffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 500;
		
		

		-- Send DFRAME: DFRAME_LENGTH = 0xF5
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"0000000000000000000000000000000002000000f5adbbd2e203102749ba0a64a8c09664a8c0f268114000401384f60300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000aa0200000000003000000000012000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"eaae00003000000100000004580d0000300020010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"00000040000000000000004000000000000000000040000000003000405d000000045a0d000030002001000020000000000000000001000030008001000078ce";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"00000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000004000000000000000400000000000000000004000000000000000400000000000000000004000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"000044040000000004040000000000000000000000000000000000000000000000000d5a00000000003000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000200000000adf500000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000002aa00003000000000000000000000000000200100000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 17
        axis_rx_tdata  <= X"00000000000000000000000000000000891272630000000000000000000000000000000000000000000000000000000000000000000000008912726300000000";
        axis_rx_tkeep  <= X"000000000000000f";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_CLK_PERIOD*4;
        wait for C_ICAP_CLK_PERIOD * 400;



       -- Send DFRAME: DFRAME_LENGTH = 0xF4
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"2000000000002000000040002000000001000000f4adef94de03102749ba0a64a8c09664a8c0f768114000401284f20300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000004000200000000000200000004000200000000000200000004000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"04002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000003020000000010020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"c001000000000000000030008001000004b220930000300180010000200000000000200000000000000000070000300080010000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00003003000100000020000000003000c00100000002000000003003000100000002000000003000c00100000000040000003000a00100000000050000003000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"0040000000000000004000000000000000000040000000003000405d00000004580d000030002001000020000000000000000001000030008001000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00400000000000000000000000200000002000400000000100000000adf400000000000000400000000000000000004000000000000000400000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000002000000020000000000000000000000000002000000020004000000000000000000000002000000020004000000000000000000000002000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"00000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_CLK_PERIOD*4;
        wait for C_ICAP_CLK_PERIOD * 400;

        
       -- Send DFRAME: DFRAME_LENGTH = 0xF4
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"2000000000002000000040002000000001000000f4adef94de03102749ba0a64a8c09664a8c0f768114000401284f20300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000004000200000000000200000004000200000000000200000004000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"04002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000003020000000010020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"c001000000000000000030008001000004b220930000300180010000200000000000200000000000000000070000300080010000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00003003000100000020000000003000c00100000002000000003003000100000002000000003000c00100000000040000003000a00100000000050000003000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"0040000000000000004000000000000000000040000000003000405d00000004580d000030002001000020000000000000000001000030008001000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00400000000000000000000000200000002000400000000100000000adf400000000000000400000000000000000004000000000000000400000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000002000000020000000000000000000000000002000000020004000000000000000000000002000000020004000000000000000000000002000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"00000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_CLK_PERIOD*4;
        wait for C_ICAP_CLK_PERIOD * 400;

        
        
        

       -- Send DFRAME: DFRAME_LENGTH = 0xF4
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"2000000000002000000040002000000001000000f4adef94de03102749ba0a64a8c09664a8c0f768114000401284f20300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000004000200000000000200000004000200000000000200000004000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"00000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"04002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000000040002000000000002000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000003020000000010020000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"c001000000000000000030008001000004b220930000300180010000200000000000200000000000000000070000300080010000200000000000200000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00003003000100000020000000003000c00100000002000000003003000100000002000000003000c00100000000040000003000a00100000000050000003000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"0040000000000000004000000000000000000040000000003000405d00000004580d000030002001000020000000000000000001000030008001000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00400000000000000000000000200000002000400000000100000000adf400000000000000400000000000000000004000000000000000400000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000002000000020000000000000000000000000002000000020004000000000000000000000002000000020004000000000000000000000002000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000002000000000000000000000000000200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"00000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000000000000000002000000020000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020000000200000000000000000000000000020";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 400;



        -- Send DFRAME: DFRAME_LENGTH = 0xF5
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        -- 1 
        axis_rx_tdata  <= X"0000000000000000000000000000000002000000f5adbbd2e203102749ba0a64a8c09664a8c0f268114000401384f60300450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 2
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 3 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 4 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000aa0200000000003000000000012000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 5 
        axis_rx_tdata  <= X"eaae00003000000100000004580d0000300020010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 6
        axis_rx_tdata  <= X"00000040000000000000004000000000000000000040000000003000405d000000045a0d000030002001000020000000000000000001000030008001000078ce";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 7
        axis_rx_tdata  <= X"00000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 8 
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000004000000000000000400000000000000000004000000000000000400000000000000000004000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 9
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 10
        axis_rx_tdata  <= X"000044040000000004040000000000000000000000000000000000000000000000000d5a00000000003000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 11
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000200000000adf500000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 12
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 13
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 14
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 15
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000002aa00003000000000000000000000000000200100000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 16
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        -- 17
        axis_rx_tdata  <= X"000000000000000000000000000000008912726300000000000000000000000000000000000000000000000000000000000000000000000089127263bb1122aa";
        axis_rx_tkeep  <= X"000000000000000f";
        axis_rx_tlast  <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 300;


        -- Send FRAME 3 FFFF_FFFF : Sequence 0000_00152
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000c0900000000003133000405d0000015262a56d7c9601102774830a64a8c09664a8c0ca281140004087c6aa0100450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000007ff500000000000000000000c0e800000000031500000000000000000000000000000000c120000000001ff9000000007ff5000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000007ffd00000000000000000000080000000000006000000000000000000000000000000000c1200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000002f4000000007ffd0000000000000000000064100000000000000000000000000000000000000000000000010000000002f300000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000002f2f000000002f2f00000000000000000000000000000000000000000000ff00000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000e54dbd23000000000000000000000000000000000000000010bd00000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"00ffffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 300;
		
	    axis_prog_full <= '1';
        -- Send DWORD 1 FFFF_FFFF : Sequence 0000_0001
        axis_rx_tdata  <= X"f0a90c0f0000000000000000ffffffff0000000101da4dfe1200102778b50a64a8c09664a8c028da11400040ad16260000450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        wait for C_ICAP_CLK_PERIOD * 10;

                        
        -- Send FRAME 3 FFFF_FFFF : Sequence 0000_00152
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000c0900000000003133000405d0000015262a56d7c9601102774830a64a8c09664a8c0ca281140004087c6aa0100450008acfbc34b6b50924102350a00";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000007ff500000000000000000000c0e800000000031500000000000000000000000000000000c120000000001ff9000000007ff5000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000000000007ffd00000000000000000000080000000000006000000000000000000000000000000000c1200000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"0000000000000000000002f4000000007ffd0000000000000000000064100000000000000000000000000000000000000000000000010000000002f300000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000002f2f000000002f2f00000000000000000000000000000000000000000000ff00000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"ffffffffffffffff";
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata  <= X"00000000e54dbd23000000000000000000000000000000000000000010bd00000000000000000000000000000000000000000000000000000000000000000000";
        axis_rx_tkeep  <= X"00ffffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tvalid <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tlast  <= '0';
        axis_rx_tvalid <= '0';
        axis_prog_full <= '0';
        wait for C_ICAP_CLK_PERIOD * 1000;
        
        wait;
    end process stimproc;
    UUT_i : prconfigcontroller
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_UDP_SERVER_PORT => G_PR_SERVER_PORT,
            G_ADDR_WIDTH      => 5
        )
        port map(
            axis_clk          => axis_clk,
            -- 95 MHz ICAP Clock 
            icap_clk          => icap_clk,
            axis_reset        => axis_reset,
            -- Setup information
            ServerMACAddress  => G_EMAC_ADDR,
            ServerIPAddress   => G_IP_ADDR,
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority => axis_tx_tpriority_1_pr,
            axis_tx_tdata     => axis_tx_tdata_1_pr,
            axis_tx_tvalid    => axis_tx_tvalid_1_pr,
            axis_tx_tready    => axis_tx_tready_1_pr,
            axis_tx_tkeep     => axis_tx_tkeep_1_pr,
            axis_tx_tlast     => axis_tx_tlast_1_pr,
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata     => axis_rx_tdata,
            axis_rx_tvalid    => axis_rx_tvalid,
            axis_rx_tuser     => axis_rx_tuser,
            axis_rx_tkeep     => axis_rx_tkeep,
            axis_rx_tlast     => axis_rx_tlast,
			axis_prog_full    => axis_prog_full,
			axis_prog_empty   => axis_prog_empty,
			axis_data_count   => axis_data_count,
            ICAP_PRDONE       => ICAP_PRDONE,
            ICAP_PRERROR      => ICAP_PRERROR,
            ICAP_AVAIL        => ICAP_AVAIL,
            ICAP_CSIB         => ICAP_CSIB,
            ICAP_RDWRB        => ICAP_RDWRB,
            ICAP_DataOut      => ICAP_DataOut,
            ICAP_DataIn       => ICAP_DataIn
        );

end architecture rtl;
