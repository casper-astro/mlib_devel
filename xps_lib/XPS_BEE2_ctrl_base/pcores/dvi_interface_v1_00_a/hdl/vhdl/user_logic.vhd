------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2004 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
-- ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
-- ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
-- ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
-- ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic module.
-- Date:              Sat Jan 15 18:37:34 2005 (by Create and Import Peripheral Wizard)
-- VHDL-Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
-- 	active low signals:                    "*_n"
-- 	clock signals:                         "clk", "clk_div#", "clk_#x"
-- 	reset signals:                         "rst", "rst_n"
-- 	generics:                              "C_*"
-- 	user defined types:                    "*_TYPE"
-- 	state machine next state:              "*_ns"
-- 	state machine current state:           "*_cs"
-- 	combinatorial signals:                 "*_com"
-- 	pipelined or register delay signals:   "*_d#"
-- 	counter signals:                       "*cnt*"
-- 	clock enable signals:                  "*_ce"
-- 	internal version of output port:       "*_i"
-- 	device pins:                           "*_pin"
-- 	ports:                                 "- Names begin with Uppercase"
-- 	processes:                             "*_PROCESS"
-- 	component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here
library dvi_interface_v1_00_a;
use dvi_interface_v1_00_a.all;

------------------------------------------------------------------------------
-- Definition of Generics:
--   C_DWIDTH                     -- User logic data bus width
--   C_NUM_CE                     -- User logic chip enable bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus for user logic
--   Bus2IP_BE                    -- Bus to IP byte enables for user logic
--   Bus2IP_RdCE                  -- Bus to IP read chip enable for user logic
--   Bus2IP_WrCE                  -- Bus to IP write chip enable for user logic
--   Bus2IP_RdReq                 -- Bus to IP read request
--   Bus2IP_WrReq                 -- Bus to IP write request
--   IP2Bus_Data                  -- IP to Bus data bus for user logic
--   IP2Bus_Retry                 -- IP to Bus retry response
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_ToutSup               -- IP to Bus timeout suppress
--   IP2Bus_Busy                  -- IP to Bus busy response
--   IP2Bus_Ack                 -- IP to Bus transfer acknowledgement
--
--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity user_logic is
	generic
	(
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		--USER generics added here
		-- ADD USER GENERICS ABOVE THIS LINE ---------------

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol parameters, do not add to or delete
		C_DWIDTH	: integer	:= 16;
		C_NUM_CE	: integer	:= 8
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
	port
	(
		-- ADD USER PORTS BELOW THIS LINE ------------------
		--USER ports added here
		-- ADD USER PORTS ABOVE THIS LINE ------------------
		-- control signals
		display_spectrum : in std_logic;

		-- spectrometer inputs
		spectro_address : in std_logic_vector(0 to 8);
		spectro_data : in std_logic_vector(0 to 17);
		spectro_wen : in std_logic;
		spectro_clk : in std_logic;

		-- ram for the char buffer
		charbuffer_rst : out std_logic;
		charbuffer_clk : out std_logic;
		charbuffer_en : out std_logic;
		charbuffer_wen : out std_logic_vector(0 to 3);
		charbuffer_addr : out std_logic_vector(0 to 31);
		charbuffer_din : in std_logic_vector(0 to 31);
		charbuffer_dout : out std_logic_vector(0 to 31);

		-- DVI chip interface
		dvi_data    : out std_logic_vector(0 to 11);
		dvi_idck_p  : out std_logic;
		dvi_idck_m  : out std_logic;
		dvi_vsync   : out std_logic;
		dvi_hsync   : out std_logic;
		dvi_de      : out std_logic;

		-- clock
		pixel_clk	: in std_logic;
		pixel_clk90	: in std_logic;

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add to or delete
		Bus2IP_Clk	: in	std_logic;
		Bus2IP_Reset	: in	std_logic;
		Bus2IP_Data	: in	std_logic_vector(0 to C_DWIDTH-1);
		Bus2IP_BE	: in	std_logic_vector(0 to C_DWIDTH/8-1);
		Bus2IP_RdCE	: in	std_logic_vector(0 to C_NUM_CE-1);
		Bus2IP_WrCE	: in	std_logic_vector(0 to C_NUM_CE-1);
		IP2Bus_Data	: out	std_logic_vector(0 to C_DWIDTH-1);
		IP2Bus_Ack	: out	std_logic;
		IP2Bus_Retry	: out	std_logic;
		IP2Bus_Error	: out	std_logic;
		IP2Bus_ToutSup	: out	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
end entity user_logic;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of user_logic is

	--USER signal declarations added here, as needed for user logic
	signal R		: std_logic_vector(0 to 7);
	signal G		: std_logic_vector(0 to 7);
	signal B		: std_logic_vector(0 to 7);
	signal req_pixel	: std_logic;
	signal endof_line	: std_logic;
	signal endof_frame	: std_logic;

	signal hsync	: std_logic;
	signal vsync	: std_logic;
	signal de		: std_logic;

	signal pixel_clk180	: std_logic;
	signal pixel_clk270	: std_logic;

	----------------------------------------
	-- Signals for user logic slave model s/w accessible register example
	----------------------------------------
	signal slv_reg0	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg1	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg2	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg3	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg4	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg5	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg6	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg7	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg_write_select	: std_logic_vector(0 to 7);
	signal slv_reg_read_select	: std_logic_vector(0 to 7);
	signal slv_ip2bus_data	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_read_ack	: std_logic;
	signal slv_write_ack	: std_logic;

	-- screen size parameters -- uses the XFree frame buffer naming convention
	signal HR		: std_logic_vector(0 to 15);
	signal SH1		: std_logic_vector(0 to 15);
	signal SH2		: std_logic_vector(0 to 15);
	signal HFL		: std_logic_vector(0 to 15);
	signal VR		: std_logic_vector(0 to 15);
	signal SV1		: std_logic_vector(0 to 15);
	signal SV2		: std_logic_vector(0 to 15);
	signal VFL		: std_logic_vector(0 to 15);

  -- delay for signals on pad
  signal hsync_reg : std_logic;
  signal vsync_reg : std_logic;
  signal de_reg    : std_logic;
	signal R_reg		 : std_logic_vector(0 to 7);
	signal G_reg		 : std_logic_vector(0 to 7);
	signal B_reg		 : std_logic_vector(0 to 7);

	signal one	    : std_logic;
	signal zero	    : std_logic;

	attribute iob      : string;
	attribute maxdelay : string;

	-- due to a pin assignment conflict (shared clock with ddr dimm) those signals cannot be put in the pad
	-- to solve this issue, we force the register outside of the pad, but really close to it
	attribute iob      of dvi_de_R      : label     is "false";
	attribute maxdelay of dvi_de        : signal    is "0.500"; 
	attribute iob      of dvi_data_11_R : label     is "false";
	attribute maxdelay of dvi_data      : signal    is "0.500"; 

begin

	--USER logic implementation added here

	zero <= '0';
	one <= '1';

	----------------------------------------
	-- Example code to read/write user logic slave model s/w accessible registers
	-- 
	-- Note:
	-- The example code presented here is to show you one way of reading/writing
	-- software accessible registers implemented in the user logic slave model.
	-- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
	-- to one software accessible register by the top level template. For example,
	-- if you have four 32 bit software accessible registers in the user logic, you
	-- are basically operating on the following memory mapped registers:
	-- 
	--    Bus2IP_WrCE or   Memory Mapped
	--       Bus2IP_RdCE   Register
	--            "1000"   C_BASEADDR + 0x0
	--            "0100"   C_BASEADDR + 0x4
	--            "0010"   C_BASEADDR + 0x8
	--            "0001"   C_BASEADDR + 0xC
	-- 
	----------------------------------------
	slv_reg_write_select <= Bus2IP_WrCE(0 to 7);
	slv_reg_read_select  <= Bus2IP_RdCE(0 to 7);
	slv_write_ack        <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3) or Bus2IP_WrCE(4) or Bus2IP_WrCE(5) or Bus2IP_WrCE(6) or Bus2IP_WrCE(7);
	slv_read_ack         <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3) or Bus2IP_RdCE(4) or Bus2IP_RdCE(5) or Bus2IP_RdCE(6) or Bus2IP_RdCE(7);

	SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
	begin

	  if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
	    if Bus2IP_Reset = '1' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	      slv_reg2 <= (others => '0');
	      slv_reg3 <= (others => '0');
	      slv_reg4 <= (others => '0');
	      slv_reg5 <= (others => '0');
	      slv_reg6 <= (others => '0');
	      slv_reg7 <= (others => '0');
	    else
	      case slv_reg_write_select is
	        when "10000000" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg0(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "01000000" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg1(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00100000" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg2(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00010000" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg3(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00001000" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg4(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00000100" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg5(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00000010" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg6(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
	        when "00000001" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg7(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
					when others => null;
				end case;
			end if;
		end if;

	end process SLAVE_REG_WRITE_PROC;

	SLAVE_REG_READ_PROC : process( slv_reg_read_select, slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7 ) is
	begin

		case slv_reg_read_select is
			when "10000000" => slv_ip2bus_data <= slv_reg0;
			when "01000000" => slv_ip2bus_data <= slv_reg1;
			when "00100000" => slv_ip2bus_data <= slv_reg2;
			when "00010000" => slv_ip2bus_data <= slv_reg3;
			when "00001000" => slv_ip2bus_data <= slv_reg4;
			when "00000100" => slv_ip2bus_data <= slv_reg5;
			when "00000010" => slv_ip2bus_data <= slv_reg6;
			when "00000001" => slv_ip2bus_data <= slv_reg7;
			when others => slv_ip2bus_data <= (others => '0');
		end case;

	end process SLAVE_REG_READ_PROC;

	-- register the constants on the pixel clock	
	REG_CONST : process(pixel_clk) is
	begin
	  if pixel_clk'event and pixel_clk = '1' then
	    HR	<= 	slv_reg0;
	    SH1	<=    slv_reg1;
	    SH2	<=    slv_reg2;
	    HFL	<=    slv_reg3;
	    VR	<= 	slv_reg4;
	    SV1	<=    slv_reg5;
	    SV2	<=    slv_reg6;
	    VFL	<=    slv_reg7;
                            
	  end if;
	end process REG_CONST;


	DVI_PIXELGEN_I : entity dvi_interface_v1_00_a.dvi_pixelgen
		port map
		(
		-- control signals
		display_spectrum => display_spectrum,

		-- spectrometer inputs
		spectro_address => spectro_address,
		spectro_data    => spectro_data   ,
		spectro_wen     => spectro_wen    ,
		spectro_clk     => spectro_clk    ,

		-- ram for the char buffer
		charbuffer_rst  => charbuffer_rst ,
		charbuffer_clk  => charbuffer_clk ,
		charbuffer_en   => charbuffer_en  ,
		charbuffer_wen  => charbuffer_wen ,
		charbuffer_addr => charbuffer_addr,
		charbuffer_din  => charbuffer_din ,
		charbuffer_dout => charbuffer_dout,

		-- pixel out interface
		R		=> R	,
		G		=> G	,
		B		=> B	,
		req_pixel	=> req_pixel,
		endof_line	=> endof_line	,
		endof_frame	=> endof_frame	,

		-- screen size parameters -- uses the XFree frame buffer naming convention
		HR	=> 	HR	,
		HFL	=>    HFL	,
		VR	=> 	VR	,
		VFL	=>    VFL	,

		-- pixel clock
		pixel_clk	=> pixel_clk

		);

	DVI_SYNCGEN_I : entity dvi_interface_v1_00_a.dvi_syncgen
		port map
		(
		-- Sync signals
		vsync	=> vsync	,
		hsync	=> hsync	,
		de	=> de	      ,

		-- screen size parameters -- uses the XFree frame buffer naming convention
		HR	=> 	HR	,
		SH1	=>    SH1	,
		SH2	=>    SH2	,
		HFL	=>    HFL	,
		VR	=> 	VR	,
		SV1	=>    SV1	,
		SV2	=>    SV2	,
		VFL	=>    VFL	,
                            
		-- pixel in interface
		req_pixel	=> req_pixel,	
		endof_line	=> endof_line	,
		endof_frame	=> endof_frame	,
                            
		-- clock        
		pixel_clk	=> pixel_clk

		);

	-- clocks inversion
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

  -- register all the signals before they reach the pads to increase timing margin
	REG_PADS_PROC : process( pixel_clk ) is
	begin
	  if pixel_clk'event and pixel_clk = '1' then
	    hsync_reg <= hsync;
	    vsync_reg <= vsync;
	    de_reg    <= de;
	    R_reg     <= R;
	    G_reg     <= G;
	    B_reg     <= B;
	  end if;
	end process REG_PADS_PROC;

	-- register all the sync in the pads or close to the pad to make sure we meet the timings
	dvi_hsync_R : FD port map (
		Q => dvi_hsync,
		C => pixel_clk,
		D => hsync_reg
	);
	dvi_vsync_R : FD port map (
		Q => dvi_vsync,
		C => pixel_clk,
		D => vsync_reg
	);
	dvi_de_R : FD port map (
		Q => dvi_de,
		C => pixel_clk,
		D => de_reg
	);

	-- the DDR output registers

	dvi_data_0_R : FDDRRSE port map (
		Q => dvi_data(0),
		D0 => R_reg(0),
		D1 => G_reg(4),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_1_R : FDDRRSE port map (
		Q => dvi_data(1),
		D0 => R_reg(1),
		D1 => G_reg(5),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_2_R : FDDRRSE port map (
		Q => dvi_data(2),
		D0 => R_reg(2),
		D1 => G_reg(6),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_3_R : FDDRRSE port map (
		Q => dvi_data(3),
		D0 => R_reg(3),
		D1 => G_reg(7),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_4_R : FDDRRSE port map (
		Q => dvi_data(4),
		D0 => R_reg(4),
		D1 => B_reg(0),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_5_R : FDDRRSE port map (
		Q => dvi_data(5),
		D0 => R_reg(5),
		D1 => B_reg(1),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_6_R : FDDRRSE port map (
		Q => dvi_data(6),
		D0 => R_reg(6),
		D1 => B_reg(2),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_7_R : FDDRRSE port map (
		Q => dvi_data(7),
		D0 => R_reg(7),
		D1 => B_reg(3),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_8_R : FDDRRSE port map (
		Q => dvi_data(8),
		D0 => G_reg(0),
		D1 => B_reg(4),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_9_R : FDDRRSE port map (
		Q => dvi_data(9),
		D0 => G_reg(1),
		D1 => B_reg(5),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	dvi_data_10_R : FDDRRSE port map (
		Q => dvi_data(10),
		D0 => G_reg(2),
		D1 => B_reg(6),
		C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );

	-- due to a pin assignment conflict (shared clock with ddr dimm) this bit cannot be a DDR bit
	-- to solve this issue, we will send Green bit 3 instead of blue bit 7, this substitution
	-- should not be noticeable to the user (most LCD screen use only 6 bits anyway).
	-- dvi_data_11_R : FDDRRSE port map (
	-- 	Q => dvi_data(11),
	-- 	D0 => G(3),
	-- 	D1 => B(7),
	-- 	C0 => pixel_clk, C1 => pixel_clk180, CE => one, R => zero, S => zero );
	dvi_data_11_R : FD port map (
		Q => dvi_data(11),
		C => pixel_clk,
		D => G_reg(3)
	);	

	----------------------------------------
	-- Example code to drive IP to Bus signals
	----------------------------------------
	IP2Bus_Data        <= slv_ip2bus_data;

	IP2Bus_Ack         <= slv_write_ack or slv_read_ack;
	IP2Bus_Error       <= '0';
	IP2Bus_Retry       <= '0';
	IP2Bus_ToutSup     <= '0';

end IMP;


