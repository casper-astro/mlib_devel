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

-- BEE2 blocks library
-- Written by Pierre-Yves Droz

-- Simple frame buffer for BEE2 DVI output

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity framebuffer_writer is
    generic (
       C_WIDE_DATA     : integer;
       C_HALF_BURST    : integer
    );
    port (
    	-- user interface
        R               : in  std_logic_vector(7 downto 0);
        G               : in  std_logic_vector(7 downto 0);
        B               : in  std_logic_vector(7 downto 0);
        X               : in  std_logic_vector(10 downto 0);
        Y               : in  std_logic_vector(9 downto 0);
        frame           : in  std_logic_vector(7 downto 0);
        valid           : in  std_logic;
        ack             : out std_logic;
        blank           : in  std_logic;
        display_frame   : in  std_logic_vector(7 downto 0);
    
        -- Memory command interface
        Mem_Clk         : in  std_logic;
        Mem_Cmd_Address : out std_logic_vector(31 downto 0);
        Mem_Cmd_RNW     : out std_logic;
        Mem_Cmd_Valid   : out std_logic;
        Mem_Cmd_Tag     : out std_logic_vector(31 downto 0);
        Mem_Cmd_Ack     : in  std_logic;
        Mem_Rd_Dout     : in  std_logic_vector(143 downto 0);
        Mem_Rd_Tag      : in  std_logic_vector(31  downto 0);
        Mem_Rd_Ack      : out std_logic;
        Mem_Rd_Valid    : in  std_logic;
        Mem_Wr_Din      : out std_logic_vector(143 downto 0);
        Mem_Wr_BE       : out std_logic_vector(17  downto 0);
        -- Framebuffer address and control
        fb_blank        : out std_logic;
        fb_addr         : out std_logic_vector(31 downto 0)
    );
end entity framebuffer_writer;

-- architecture portion

architecture framebuffer_writer_arch of framebuffer_writer is

    signal pixel_address       : std_logic_vector(31 downto 0);
    signal pixel_address_buffer: std_logic_vector(31 downto 0);
    signal pixel_buffer        : std_logic_vector(127 downto 0);
    signal enable_buffer       : std_logic_vector(3 downto 0);
    signal conflict            : std_logic;
    signal pixel_enable        : std_logic_vector(3 downto 0);
    signal current_pixel       : std_logic_vector(31 downto 0);
    signal X_buffer            : std_logic_vector(10 downto 0);
    signal Y_buffer            : std_logic_vector(9 downto 0);
    signal frame_buffer        : std_logic_vector(7 downto 0);
    signal display_frame_offset: std_logic_vector(31 downto 0);
    signal frame_offset        : std_logic_vector(31 downto 0);
    signal X_offset            : std_logic_vector(31 downto 0);
    signal Y_offset            : std_logic_vector(31 downto 0);

begin

-- main process
main_proc: process(Mem_Clk)
begin
	if Mem_Clk'event and Mem_Clk='1' then
		-- whenever we get an ack from the DDR, we can empty the old buffer
		if Mem_Cmd_Ack = '1' then
			enable_buffer <= (others => '0');
			pixel_buffer  <= (others => '0');
		end if;
		-- if there is no conflict or if we just flushed the buffer then we can store the current pixel
		if valid = '1' and (conflict = '0' or Mem_Cmd_Ack = '1') then
			if pixel_enable(0) = '1' then 
					pixel_buffer(31 downto 0)  <= current_pixel;
					enable_buffer(0)           <= '1';			
			end if;
			if pixel_enable(1) = '1' then 
					pixel_buffer(63 downto 32) <= current_pixel;
					enable_buffer(1)           <= '1';			
			end if;
			if pixel_enable(2) = '1' then 
					pixel_buffer(95 downto 64) <= current_pixel;
					enable_buffer(2)           <= '1';			
			end if;
			if pixel_enable(3) = '1' then 
					pixel_buffer(127 downto 96) <= current_pixel;
					enable_buffer(3)           <= '1';			
			end if;
			pixel_address_buffer <= pixel_address;
			X_buffer             <= X;
			Y_buffer             <= Y;
			frame_buffer         <= frame;
		end if;
	end if;
end process;

-- pass through the blank and the current buffer address
display_frame_offset  <= "0" & (("0" & display_frame & "00") + ("000" & display_frame)) & "00000000000000000000";
fb_blank              <= blank;
fb_addr               <= display_frame_offset;

-- request a write to the DDR whenever we have a conflict
Mem_Cmd_Valid   <= conflict;
Mem_Cmd_Address <= pixel_address_buffer;
Mem_Cmd_RNW     <= '0';
Mem_Cmd_Tag     <= (others => 'X');
Mem_Rd_Ack      <= '0';
Mem_Wr_Din      <= X"00" & pixel_buffer(95 downto 64) & pixel_buffer(127 downto 96) & X"00" & pixel_buffer(31 downto 0) & pixel_buffer(63 downto 32);
Mem_Wr_BE       <= "0" & 
                   enable_buffer(2) & enable_buffer(2) & enable_buffer(2) & enable_buffer(2) &
                   enable_buffer(3) & enable_buffer(3) & enable_buffer(3) & enable_buffer(3) &
                   "0" & 
                   enable_buffer(0) & enable_buffer(0) & enable_buffer(0) & enable_buffer(0) &
                   enable_buffer(1) & enable_buffer(1) & enable_buffer(1) & enable_buffer(1);

-- form the current pixel from RGB
current_pixel <= X"00" & B & G & R;

-- ack the received pixel if it does not cause a conflict, or if the buffer is flushed within the cycle
ack <= '1' when valid = '1' and (conflict = '0' or Mem_Cmd_Ack = '1') else '0';

-- compute the address for the pixel
frame_offset  <= "0" & (("0" & frame & "00") + ("000" & frame)) & "00000000000000000000";
Y_offset      <= "000000000" &      (("0" & Y & "00") + ("000" & Y))      & "0000000000";
X_offset      <= "0000000000000000000" &          X(10 downto 2)                & "0000";

pixel_address <= frame_offset + Y_offset + X_offset;

-- detect if the next pixel creates an address conflict
conflict <= '1' when valid = '1' and (X(10 downto 2) /= X_buffer(10 downto 2) or Y /= Y_buffer or frame /= frame_buffer) else '0';

-- generate the pixel enable from the last bits of the X address
pixel_enable(0) <= '1' when X(1 downto 0) = "00" else '0';
pixel_enable(1) <= '1' when X(1 downto 0) = "01" else '0';
pixel_enable(2) <= '1' when X(1 downto 0) = "10" else '0';
pixel_enable(3) <= '1' when X(1 downto 0) = "11" else '0';

end architecture framebuffer_writer_arch;

