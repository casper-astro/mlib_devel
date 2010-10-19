--  Copyright (c) 2005-2006, Regents of the University of California
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without modification,
--  are permitted provided that the following conditions are met:
--
--      - Redistributions of source code must retain the above copyright notice,
--          this list of conditions and the following disclaimer.
--      - Redistributions in binary form must reproduce the above copyright
--          notice, this list of conditions and the following disclaimer
--          in the documentation and/or other materials provided with the
--          distribution.
--      - Neither the name of the University of California, Berkeley nor the
--          names of its contributors may be used to endorse or promote
--          products derived from this software without specific prior
--          written permission.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
--  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
--  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--   #      ###    #####          #######
--  ##     #   #  #     #  #      #
-- # #    # #   # #        #      #
--   #    #  #  # #  ####  #####  #####
--   #    #   # # #     #  #    # #
--   #     #   #  #     #  #    # #
-- #####    ###    #####   #####  #######


-- 10GbEthernet core PLB attachment (Simulation model)

-- created by Pierre-Yves Droz 2006

------------------------------------------------------------------------------
-- plb_attach.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity plb_attach is
	generic(
		C_BASEADDR            : std_logic_vector     := X"FFFFFFFF";
		C_HIGHADDR            : std_logic_vector     := X"00000000";
		C_PLB_AWIDTH          : integer              := 32;
		C_PLB_DWIDTH          : integer              := 64;
		C_PLB_NUM_MASTERS     : integer              := 8;
		C_PLB_MID_WIDTH       : integer              := 3;
		C_FAMILY              : string               := "virtex2p"
	);
	port (
		-- local configuration
		local_mac             : out std_logic_vector(47 downto 0);
		local_ip              : out std_logic_vector(31 downto 0);
		local_gateway         : out std_logic_vector(7 downto 0);
		local_port            : out std_logic_vector(15 downto 0);
		local_valid           : out std_logic := '0';

		-- tx buffer
		tx_buffer_data_in     : out std_logic_vector(63 downto 0);
		tx_buffer_address     : out std_logic_vector(8 downto 0) := (others => '0');
		tx_buffer_we          : out std_logic;
		tx_buffer_data_out    : in  std_logic_vector(63 downto 0);
		tx_cpu_buffer_size    : out std_logic_vector(7 downto 0) := (others => '0');
		tx_cpu_free_buffer    : in  std_logic := '0';
		tx_cpu_buffer_filled  : out std_logic; 
		tx_cpu_buffer_select  : in  std_logic := '0';

		-- rx buffer
		rx_buffer_data_in     : out std_logic_vector(63 downto 0);
		rx_buffer_address     : out std_logic_vector(8 downto 0);
		rx_buffer_we          : out std_logic;
		rx_buffer_data_out    : in  std_logic_vector(63 downto 0);
		rx_cpu_buffer_size    : in  std_logic_vector(7 downto 0);
		rx_cpu_new_buffer     : in  std_logic;
		rx_cpu_buffer_cleared : out std_logic;
		rx_cpu_buffer_select  : in  std_logic;

		-- ARP cache
		arp_cache_data_in     : out std_logic_vector(47 downto 0);
		arp_cache_address     : out std_logic_vector( 7 downto 0); 
		arp_cache_we          : out std_logic;                    
		arp_cache_data_out    : in  std_logic_vector(47 downto 0);
	
		-- PLB attachment
		PLB_Clk               : in  std_logic;
		PLB_Rst               : in  std_logic;
		Sl_addrAck            : out std_logic;
		Sl_MBusy              : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_MErr               : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_rdBTerm            : out std_logic;
		Sl_rdComp             : out std_logic;
		Sl_rdDAck             : out std_logic;
		Sl_rdDBus             : out std_logic_vector(0 to C_PLB_DWIDTH-1);
		Sl_rdWdAddr           : out std_logic_vector(0 to 3);
		Sl_rearbitrate        : out std_logic;
		Sl_SSize              : out std_logic_vector(0 to 1);
		Sl_wait               : out std_logic;
		Sl_wrBTerm            : out std_logic;
		Sl_wrComp             : out std_logic;
		Sl_wrDAck             : out std_logic;
		PLB_abort             : in  std_logic;
		PLB_ABus              : in  std_logic_vector(0 to C_PLB_AWIDTH-1);
		PLB_BE                : in  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		PLB_busLock           : in  std_logic;
		PLB_compress          : in  std_logic;
		PLB_guarded           : in  std_logic;
		PLB_lockErr           : in  std_logic;
		PLB_masterID          : in  std_logic_vector(0 to C_PLB_MID_WIDTH-1);
		PLB_MSize             : in  std_logic_vector(0 to 1);
		PLB_ordered           : in  std_logic;
		PLB_PAValid           : in  std_logic;
		PLB_pendPri           : in  std_logic_vector(0 to 1);
		PLB_pendReq           : in  std_logic;
		PLB_rdBurst           : in  std_logic;
		PLB_rdPrim            : in  std_logic;
		PLB_reqPri            : in  std_logic_vector(0 to 1);
		PLB_RNW               : in  std_logic;
		PLB_SAValid           : in  std_logic;
		PLB_size              : in  std_logic_vector(0 to 3);
		PLB_type              : in  std_logic_vector(0 to 2);
		PLB_wrBurst           : in  std_logic;
		PLB_wrDBus            : in  std_logic_vector(0 to C_PLB_DWIDTH-1);
		PLB_wrPrim            : in  std_logic
	);
end entity plb_attach;

architecture plb_attach_arch of plb_attach is
	signal tx_buffer_address_int     : std_logic_vector(8 downto 0) := (others => '0');
	signal tx_cpu_buffer_filled_int  : std_logic := '0';
	signal rx_cpu_buffer_cleared_int : std_logic := '0';
begin

	local_mac             <= X"BADCAFE4BEE2";
	local_ip              <= X"FEEDBEE2";
	local_gateway         <= X"01";
	local_port            <= X"1234";

	tx_buffer_data_in     <= X"FFFFFFFFFFFFFFFF" when tx_buffer_address_int(7 downto 0) = X"00" else "1010101010101010101010101010101010101010101010101010000" & tx_buffer_address_int;
	tx_buffer_we          <= '1';
	tx_buffer_address     <= tx_buffer_address_int;

	rx_buffer_data_in     <= (others => '0');
	rx_buffer_address     <= (others => '0');
	rx_buffer_we          <= '0';

	arp_cache_data_in     <= X"BADCAFE4BEE2";
	arp_cache_address     <= X"E2";
	arp_cache_we          <= '1';
	
process(PLB_Clk)
	variable cycle_count : integer := 0;
begin
	if PLB_Clk'event and PLB_Clk = '1' then
		if cycle_count > 1 then
			tx_buffer_address_int <= tx_buffer_address_int + 1;
		end if;
		cycle_count := cycle_count + 1;
		if cycle_count = 100 then
			local_valid  <= '1';
		end if;
		if cycle_count = 300 then
			tx_cpu_buffer_size       <= "01000000";
			tx_cpu_buffer_filled_int <= '1';
		end if;
		if cycle_count = 400 then
			tx_cpu_buffer_size       <= "10000000";
			tx_cpu_buffer_filled_int <= '1';
		end if;
		if cycle_count = 1000 then
			tx_cpu_buffer_size       <= "00100000";
			tx_cpu_buffer_filled_int <= '1';
		end if;
		if tx_cpu_buffer_filled_int = '1' and tx_cpu_free_buffer = '1' then
			tx_cpu_buffer_filled_int <= '0';
		end if;

		if rx_cpu_buffer_cleared_int = '0' and rx_cpu_new_buffer = '1' and cycle_count > 700 then
			rx_cpu_buffer_cleared_int <= '1';
		end if;

		if rx_cpu_buffer_cleared_int = '1' and rx_cpu_new_buffer = '0' then
			rx_cpu_buffer_cleared_int <= '0';
		end if;


	end if;
end process;
tx_cpu_buffer_filled  <= tx_cpu_buffer_filled_int;
rx_cpu_buffer_cleared <= rx_cpu_buffer_cleared_int;

end architecture;