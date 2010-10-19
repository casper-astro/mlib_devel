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

entity framebuffer is
	generic (
		-- framebuffer resolution parameters as defined in the XFree framebuffer documentation
		-- default parameters correspond to 1280x1024 resolution
		HR		: integer := 1280;
		SH1		: integer := 1328;
		SH2		: integer := 1512;
		HFL		: integer := 1712;
		VR		: integer := 1024;
		SV1		: integer := 1025;
		SV2		: integer := 1028;
		VFL		: integer := 1054
	);
	port (
		-- DVI ports
		dvi_data        : out std_logic_vector(0 to 11);
		dvi_idck_p      : out std_logic;
		dvi_idck_m      : out std_logic;
		dvi_vsync       : out std_logic;
		dvi_hsync       : out std_logic;
		dvi_de          : out std_logic;
		-- Clocks
		pixel_clk       : in  std_logic;
		pixel_clk90     : in  std_logic;
		ddr_clk         : in  std_logic;
		-- DDR controller interface
		ddr_data        : in  std_logic_vector(143 downto 0);
		ddr_data_valid  : in  std_logic;
		ddr_address     : out std_logic_vector(31 downto 0);
		ddr_read        : out std_logic;
		ddr_ready       : in  std_logic;
		-- Framebuffer address
		fb_address      : in  std_logic_vector(31 downto 0)
	);
end entity framebuffer;

-- architecture portion

architecture framebuffer_arch of framebuffer is

--            #                              ##
--                                            #
--                                            #
--  #####   ###     ###### ## ##    ####      #     #####
-- #     #    #    #    #   ##  #       #     #    #     #
--  ###       #    #    #   #   #   #####     #     ###
--     ##     #    #    #   #   #  #    #     #        ##
-- #     #    #     #####   #   #  #    #     #    #     #
--  #####   #####       #  ### ###  #### #  #####   #####
--                      #
--                  ####

	-- pixel position counter
	signal hcnt               : std_logic_vector(15 downto 0) := (others => '0');	-- horizontal pixel counter
	signal vcnt               : std_logic_vector(15 downto 0) := (others => '0');	-- vertical line counter

	-- sync signals
	signal vsync              : std_logic := '1';
	signal hsync              : std_logic := '1';
	signal de                 : std_logic := '1';

	-- pixel reader control
	signal get_pixel          : std_logic := '1';
	signal pixel_addr         : std_logic_vector(10 downto 0) := (others => '0');
	signal pixel_data         : std_logic_vector(15 downto 0) := (others => '0');

	-- ddr reader control
	signal ddr_address_int    : std_logic_vector(31 downto 0) := (others => '0');
	signal ddr_line_cntr      : std_logic_vector(6 downto 0)  := (others => '0');
	signal ddr_read_int       : std_logic := '0';
	signal ddr_buf_address    : std_logic_vector( 7 downto 0) := (others => '0');

	-- handshake signals
	signal pixel_endof_line   : std_logic := '0';
	signal pixel_endof_frame  : std_logic := '0';
	signal ddr_endof_line     : std_logic := '0';
	signal ddr_endof_frame    : std_logic := '0';
	signal req_endof_line     : std_logic := '0';
	signal req_endof_frame    : std_logic := '0';
	signal ack_endof_line     : std_logic := '0';
	signal ack_endof_frame    : std_logic := '0';

	-- RGB signals
	signal R                  : std_logic_vector(0 to 7);
	signal G                  : std_logic_vector(0 to 7);
	signal B                  : std_logic_vector(0 to 7);

	-- pixel clocks
	signal pixel_clk180	      : std_logic;
	signal pixel_clk270	      : std_logic;

	-- constants
	signal one                : std_logic := '0';
	signal zero               : std_logic := '1';

--                                                                   #
--                                                                   #
--  #####   #####  ### #   ######   #####  ## ##    #####  ## ##    ####    #####
-- #     # #     #  # # #   #    # #     #  ##  #  #     #  ##  #    #     #     #
-- #       #     #  # # #   #    # #     #  #   #  #######  #   #    #      ###
-- #       #     #  # # #   #    # #     #  #   #  #        #   #    #         ##
-- #     # #     #  # # #   #    # #     #  #   #  #     #  #   #    #  #  #     #
--  #####   #####  ## # ##  #####   #####  ### ###  #####  ### ###    ##    #####
--                          #
--                         ###

	component pixel_ram
		port (
			addra : in  std_logic_vector(10 downto 0);
			addrb : in  std_logic_vector( 7 downto 0);
			clka  : in  std_logic;
			clkb  : in  std_logic;
			dinb  : in  std_logic_vector(127 downto 0);
			douta : out std_logic_vector( 15 downto 0);
			web   : in  std_logic
		);
	end component;

--                                                            #
--                                   #                                       #
--                                   #                                       #
--  #####   #####  ## ##    #####   ####   ### ##   ####    ###    ## ##    ####
-- #     # #     #  ##  #  #     #   #       ##  #      #     #     ##  #    #
-- #       #     #  #   #   ###      #       #      #####     #     #   #    #
-- #       #     #  #   #      ##    #       #     #    #     #     #   #    #
-- #     # #     #  #   #  #     #   #  #    #     #    #     #     #   #    #  #
--  #####   #####  ### ###  #####     ##   #####    #### #  #####  ### ###    ##

	attribute iob      : string;
	attribute maxdelay : string;

	-- due to a pin assignment conflict (shared clock with ddr dimm) those signals cannot be put in the pad
	-- to solve this issue, we force the register outside of the pad, and constraint the path from the register
	attribute iob      of dvi_de_R      : label     is "false";
	attribute maxdelay of dvi_de        : signal    is "0.500";
	attribute iob      of dvi_data_11_R : label     is "false";
	attribute maxdelay of dvi_data      : signal    is "0.500";

begin

--  #####  ### ### ## ##    #####   #####
-- #     #  #   #   ##  #  #     # #     #
--  ###     #   #   #   #  #        ###
--     ##    # #    #   #  #           ##
-- #     #   # #    #   #  #     # #     #
--  #####     #    ### ###  #####   #####
--            #
--          ##

-- sync signals generation process
syncgen: process(pixel_clk)
begin
	if (pixel_clk'event and pixel_clk = '1') then
		-- control the increment and overflow of the horizontal pixel count
		-- horiz. counter restarts after the horizontal period
		if hcnt < HFL then
			hcnt <= hcnt + 1;
		else
			hcnt <= (others => '0');
		end if;

		-- control the increment and overflow of the vertical line counter after every horizontal line
		-- vert. line counter increments after every horiz. line
		-- vert. line counter rolls-over after the set number of lines
		if hcnt = SH2 then
			if vcnt < VFL then
				vcnt <= vcnt + 1;
			else
				vcnt <= (others => '0');
			end if;
		end if;

		-- set the horizontal sync high time and low time according to the constants
		-- horiz. sync is low in this interval to signal start of a new line
		if (hcnt > SH1 + 1 and hcnt <= SH2 + 1) then
			hsync <= '0';
		else
			hsync <= '1';
		end if;

		-- set the vertical sync high time and low time according to the constants
		-- vertical sync is recomputed at the end of every line of pixels
		-- vert. sync is low in this interval to signal start of a new frame
		if hcnt = SH2 + 2 then
			if (vcnt > SV1 and vcnt <= SV2) then
				vsync <= '0';
			else
				vsync <= '1';
			end if;
		end if;

		-- asserts the get pixel signal, to request data from the RAM reader
		-- if we are outside the visible range on the screen then tell the phy to disable data transmit
		-- in this section by putting enable low
		if hcnt >= HR or vcnt >= VR then
			get_pixel <= '0';
		else
		 	get_pixel <= '1';
		end if;

		-- generate data enable signal from get pixel
		de <= get_pixel;

		-- control the pixel_endof_line signal
		if hcnt = HR and vcnt < VR then
			pixel_endof_line <= '1';
		else
			pixel_endof_line <= '0';
		end if;

		-- control the pixel_endof_frame signal
		if hcnt = HR and vcnt = VR then
			pixel_endof_frame <= '1';
		else
			pixel_endof_frame <= '0';
		end if;
	end if;
end process;

-- ##                          ##          ##              ##
--  #                           #           #               #
--  #                           #           #               #
--  # ##    ####   ## ##    #####   #####   # ##    ####    #  ##   #####
--  ##  #       #   ##  #  #    #  #     #  ##  #       #   #  #   #     #
--  #   #   #####   #   #  #    #   ###     #   #   #####   # #    #######
--  #   #  #    #   #   #  #    #      ##   #   #  #    #   ###    #
--  #   #  #    #   #   #  #    #  #     #  #   #  #    #   #  #   #     #
-- ### ###  #### # ### ###  ######  #####  ### ###  #### # ##   ##  #####

-- four way handshake for the clock interface between the ram reader and the pixel ouput
handshake_pixel: process(pixel_clk)
begin
	if (pixel_clk'event and pixel_clk = '1') then
		-- endof_line handshake
		if pixel_endof_line = '1' and ack_endof_line = '0' then
			req_endof_line <= '1';
		end if;
		if req_endof_line = '1' and ack_endof_line = '1' then
			req_endof_line <= '0';
		end if;

		-- endof_frame handshake
		if pixel_endof_frame = '1' and ack_endof_frame = '0' then
			req_endof_frame <= '1';
		end if;
		if req_endof_frame = '1' and ack_endof_frame = '1' then
			req_endof_frame <= '0';
		end if;

	end if;
end process;

handshake_ddr: process(ddr_clk)
begin
	if (ddr_clk'event and ddr_clk = '1') then
		-- make sure that ddr_endof_line and ddr_endof_frame are asserted only during one cycle
		ddr_endof_line  <= '0';
		ddr_endof_frame <= '0';

		-- endof_line handshake
		if req_endof_line = '1' and ack_endof_line = '0' then
			ack_endof_line <= '1';
			ddr_endof_line <= '1';
		end if;
		if req_endof_line = '0' and ack_endof_line = '1' then
			ack_endof_line <= '0';
		end if;

		-- endof_frame handshake
		if req_endof_frame = '1' and ack_endof_frame = '0' then
			ack_endof_frame <= '1';
			ddr_endof_frame <= '1';
		end if;
		if req_endof_frame = '0' and ack_endof_frame = '1' then
			ack_endof_frame <= '0';
		end if;
	end if;
end process;

--            #                    ##                 ##      ##
--                                  #                #       #
--                                  #                #       #
-- ######   ###    ### ###          #####  ##  ##   ####    ####    #####  ### ##
--  #    #    #     #   #           #    #  #   #    #       #     #     #   ##  #
--  #    #    #      ###            #    #  #   #    #       #     #######   #
--  #    #    #      ###            #    #  #   #    #       #     #         #
--  #    #    #     #   #           #    #  #  ##    #       #     #     #   #
--  #####   #####  ### ###         ######    ## ##  ####    ####    #####  #####
--  #
-- ###

pix_buffer : pixel_ram
	port map (
		-- ddr port
		addrb => ddr_buf_address,
		dinb  => ddr_data(127 downto 0),
		web   => ddr_data_valid ,
		clkb  => ddr_clk        ,

		-- phy port
		addra => pixel_addr     ,
		douta => pixel_data     ,
		clka  => pixel_clk
	);

--     ##      ##                                              ##
--      #       #                                               #
--      #       #                                               #
--  #####   #####  ### ##          ### ##   #####   ####    #####   #####  ### ##
-- #    #  #    #    ##  #           ##  # #     #      #  #    #  #     #   ##  #
-- #    #  #    #    #               #     #######  #####  #    #  #######   #
-- #    #  #    #    #               #     #       #    #  #    #  #         #
-- #    #  #    #    #               #     #     # #    #  #    #  #     #   #
--  ######  ###### #####           #####    #####   #### #  ######  #####  #####

ddr_reader: process(ddr_clk)
begin
	if ddr_clk'event and ddr_clk = '1' then
		-- if a read request is accepted then increment the address counter for the next request
		if ddr_ready = '1' and ddr_read_int = '1' then
			ddr_address_int <= ddr_address_int + 32;
                        ddr_line_cntr   <= ddr_line_cntr + 1;
		end if;

		-- when the buffer is full we stop reading
                if ddr_line_cntr = HR / 16 then
			ddr_read_int <= '0';
		end if;

		-- when we get new data we increment the buffer address counter
		if ddr_data_valid = '1' then
			ddr_buf_address <= ddr_buf_address + 1;
		end if;

		-- at the end of a frame we read the new frame buffer address, we zero the buffer address and start reading
		if ddr_endof_frame = '1' then
			ddr_address_int <= fb_address;
			ddr_buf_address <= (others => '0');
                        ddr_line_cntr   <= (others => '0');
			ddr_read_int    <= '1';
		end if;
		-- at the end of the line we zero the buffer address
		if ddr_endof_line = '1' then
			ddr_buf_address <= (others => '0');
                        ddr_line_cntr   <= (others => '0');
                  	ddr_read_int    <= '1';
		end if;
	end if;
end process;
ddr_address <= ddr_address_int;
ddr_read    <= ddr_read_int;

--            #                                                ##
--                                                              #
--                                                              #
-- ######   ###    ### ###         ### ##   #####   ####    #####   #####  ### ##
--  #    #    #     #   #            ##  # #     #      #  #    #  #     #   ##  #
--  #    #    #      ###             #     #######  #####  #    #  #######   #
--  #    #    #      ###             #     #       #    #  #    #  #         #
--  #    #    #     #   #            #     #     # #    #  #    #  #     #   #
--  #####   #####  ### ###         #####    #####   #### #  ######  #####  #####
--  #
-- ###

-- this process reads data out of the pixel buffer
pixel_reader: process(pixel_clk)
begin
	if pixel_clk'event and pixel_clk = '1' then
		if get_pixel = '1' then
			pixel_addr      <= pixel_addr + 1;
		end if;
		if pixel_endof_line = '1' then
			pixel_addr      <= (others => '0');
		end if;
	end if;
end process;
-- assign the RGB values
R <= pixel_data(15 downto 11) & "000";
G <= pixel_data(10 downto 5 ) & "00";
B <= pixel_data(4  downto 0 ) & "000";

--         ##
--          #
--          #
-- ######   # ##   ### ###
--  #    #  ##  #   #   #
--  #    #  #   #   #   #
--  #    #  #   #    # #
--  #    #  #   #    # #
--  #####  ### ###    #
--  #                 #
-- ###              ##

-- DVI phy interface

-- constants
one  <= '1';
zero <= '0';

-- local clocks inversion
pixel_clk180 <= not pixel_clk;
pixel_clk270 <= not pixel_clk90;

-- clock output - use DDR registers to generate differential clock pair
dvi_idck_p_R : FDDRRSE port map (
	Q => dvi_idck_p,
	D0 => one,
	D1 => zero,
	C0 => pixel_clk90, C1 => pixel_clk270, CE => one, R => zero, S => zero );

dvi_idck_m_R : FDDRRSE port map (
	Q => dvi_idck_m,
	D0 => zero,
	D1 => one,
	C0 => pixel_clk90, C1 => pixel_clk270, CE => one, R => zero, S => zero );

-- register all the sync in the pads or close to the pad to make sure we meet the timing spec
dvi_hsync_R : FD port map (
	Q => dvi_hsync,
	C => pixel_clk,
	D => hsync
);
dvi_vsync_R : FD port map (
	Q => dvi_vsync,
	C => pixel_clk,
	D => vsync
);
dvi_de_R : FD port map (
	Q => dvi_de,
	C => pixel_clk,
	D => de
);

-- the DDR output registers

dvi_data_0_R : FDDRRSE port map (
	Q => dvi_data(0),
	D0 => R(0),
	D1 => G(4),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_1_R : FDDRRSE port map (
	Q => dvi_data(1),
	D0 => R(1),
	D1 => G(5),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_2_R : FDDRRSE port map (
	Q => dvi_data(2),
	D0 => R(2),
	D1 => G(6),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_3_R : FDDRRSE port map (
	Q => dvi_data(3),
	D0 => R(3),
	D1 => G(7),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_4_R : FDDRRSE port map (
	Q => dvi_data(4),
	D0 => R(4),
	D1 => B(0),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_5_R : FDDRRSE port map (
	Q => dvi_data(5),
	D0 => R(5),
	D1 => B(1),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_6_R : FDDRRSE port map (
	Q => dvi_data(6),
	D0 => R(6),
	D1 => B(2),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_7_R : FDDRRSE port map (
	Q => dvi_data(7),
	D0 => R(7),
	D1 => B(3),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_8_R : FDDRRSE port map (
	Q => dvi_data(8),
	D0 => G(0),
	D1 => B(4),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_9_R : FDDRRSE port map (
	Q => dvi_data(9),
	D0 => G(1),
	D1 => B(5),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

dvi_data_10_R : FDDRRSE port map (
	Q => dvi_data(10),
	D0 => G(2),
	D1 => B(6),
	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

-- due to a pin assignment conflict (shared clock with ddr dimm) this bit cannot be a DDR bit
-- to solve this issue, we will send Green bit 3 instead of blue, this substitution
-- should not be noticeable to the user (most LCD screen use only 6 bits anyway).
-- dvi_data_11_R : FDDRRSE port map (
-- 	Q => dvi_data(11),
-- 	D0 => G(3),
-- 	D1 => B(7),
-- 	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );
dvi_data_11_R : FD port map (
	Q => dvi_data(11),
	C => pixel_clk,
	D => G(3)
);


end architecture framebuffer_arch;

