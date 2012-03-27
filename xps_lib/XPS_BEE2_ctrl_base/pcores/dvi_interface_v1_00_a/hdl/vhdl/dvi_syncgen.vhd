-- BEE2 Test suite
-- DVI Sync signal generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

library dvi_interface_v1_00_a;
use dvi_interface_v1_00_a.all;

--------------------------------------------------------------------------------
-- Entity declaration
--------------------------------------------------------------------------------

-- Based largely on a version on the XESS (www.xess.com) page.  Thanks to XESS.
-- Creates SVGA timing signals to a monitor.


entity dvi_syncgen is
	port
	(
		-- Sync signals
		vsync	: out std_logic;
		hsync	: out std_logic;
		de	: out std_logic;

		-- screen size parameters -- uses the XFree frame buffer naming convention
		HR		: in std_logic_vector(0 to 15);
		SH1		: in std_logic_vector(0 to 15);
		SH2		: in std_logic_vector(0 to 15);
		HFL		: in std_logic_vector(0 to 15);

		VR		: in std_logic_vector(0 to 15);
		SV1		: in std_logic_vector(0 to 15);
		SV2		: in std_logic_vector(0 to 15);
		VFL		: in std_logic_vector(0 to 15);

		-- pixel in interface
		req_pixel	: out std_logic;
		endof_line	: out std_logic;
		endof_frame	: out std_logic;

		-- clock
		pixel_clk		: in std_logic

	);
end entity dvi_syncgen;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of dvi_syncgen is

-- one of the sync signals
--
--                    |<------- Active Region ------------>|<----------- Blanking Region ---------->|
--                    |           (Pixels)                 |                                        |
--                    |                                    |                                        |
--                    |                                    |                                        |
--        ------------+-------------- ... -----------------+-------------             --------------+--------
--        |           |                                    |            |             |             |
--        |           |                                    |<--Front    |<---Sync     |<---Back     |
--        |           |                                    |    Porch-->|     Time--->|    Porch--->|
--  -------           |                                    |            ---------------             |
--                    |                                    |                                        |
--                    |<-------------------------------- Period ----------------------------------->|
--

signal hcnt: std_logic_vector(15 downto 0);	-- horizontal pixel counter
signal vcnt: std_logic_vector(15 downto 0);	-- vertical line counter

signal vsync_buf: std_logic;
signal hsync_buf: std_logic;
signal de_buf: std_logic;

signal vsync_sig0: std_logic;
signal hsync_sig0: std_logic;

signal endof_line_sig0: std_logic;
signal endof_frame_sig0: std_logic;
signal endof_line_sig1: std_logic;
signal endof_frame_sig1: std_logic;

begin

-- control the increment and overflow of the horizontal pixel count
A: process(pixel_clk)
begin
	-- horiz. counter increments on rising edge of dot clock
	if (pixel_clk'event and pixel_clk = '1') then
		-- horiz. counter restarts after the horizontal period (set by the constants)
		if hcnt < HFL then
			hcnt <= hcnt + 1;
		else
			hcnt <= (others => '0');
		end if;
	end if;
end process;

-- control the increment and overflow of the vertical line counter after every horizontal line
B: process(hsync_buf)
begin
	-- vert. line counter increments after every horiz. line
	if (hsync_buf'event and hsync_buf = '1') then
		-- vert. line counter rolls-over after the set number of lines (set by the constants)
		if vcnt < VFL then
			vcnt <= vcnt + 1;
		else
			vcnt <= (others => '0');
		end if;
	end if;
end process;

-- set the horizontal sync high time and low time according to the constants
C: process(pixel_clk)
begin
	-- horizontal sync is recomputed on the rising edge of every dot clock
	if (pixel_clk'event and pixel_clk = '1') then
		-- horiz. sync is low in this interval to signal start of a new line
		if (hcnt >= SH1 and hcnt < SH2) then
			hsync_buf <= '0';
		else
			hsync_buf <= '1';
		end if;
	end if;
end process;

-- set the vertical sync high time and low time according to the constants
D: process(hsync_buf)
begin
	-- vertical sync is recomputed at the end of every line of pixels
	if (hsync_buf'event and hsync_buf = '1') then
		-- vert. sync is low in this interval to signal start of a new frame
		if (vcnt >= SV1 and vcnt < SV2) then
			vsync_buf <= '0';
		else
			vsync_buf <= '1';
		end if;
	end if;
end process;

-- asserts the blaking signal (active low)
E: process (pixel_clk)
begin
	if pixel_clk'EVENT and pixel_clk = '1' then
		-- if we are outside the visible range on the screen then tell the RAMDAC to blank
		-- in this section by putting enable low
		if hcnt >= HR or vcnt >= VR then
			de_buf <= '0';
		 else 
		 	de_buf <= '1';
		 end if;
	end if;
end process;

-- buffer the sync signals to get enough time to get the pixel from the RAMDAC
F: process (pixel_clk)
begin
	if pixel_clk'EVENT and pixel_clk = '1' then
		hsync_sig0 <= hsync_buf;
		vsync_sig0 <= vsync_buf;
		hsync <= hsync_sig0;
		vsync <= vsync_sig0;
		endof_line_sig1 <= endof_line_sig0;
		endof_frame_sig1 <= endof_frame_sig0;
		de <= de_buf;
	end if;
end process;

-- control the endof_line signal end
G: process (pixel_clk)
begin
	if hcnt = HR and vcnt < VR then
		endof_line_sig0 <= '1';
	else
		endof_line_sig0 <= '0';
	end if;
end process;

-- control the endof_frame signal end
H: process (pixel_clk)
begin
	if hcnt = HR and vcnt = VR then
		endof_frame_sig0 <= '1';
	else
		endof_frame_sig0 <= '0';
	end if;
end process;

endof_line <= endof_line_sig1;
endof_frame <= endof_frame_sig1;
req_pixel <= de_buf;

end IMP;
