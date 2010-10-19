-- BEE2 Test suite
-- Sample DVI pixel signal generator

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

library dvi_interface_v1_00_a;
use dvi_interface_v1_00_a.all;

--------------------------------------------------------------------------------
-- Entity declaration
--------------------------------------------------------------------------------

entity dvi_pixelgen is
	port
	(

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

		-- pixel out interface
		R		: out std_logic_vector(0 to 7);
		G		: out std_logic_vector(0 to 7);
		B		: out std_logic_vector(0 to 7);
		req_pixel	: in std_logic;
		endof_line	: in std_logic;
		endof_frame	: in std_logic;

		-- screen size parameters -- uses the XFree frame buffer naming convention
		HR		: in std_logic_vector(0 to 15);
		HFL		: in std_logic_vector(0 to 15);
		VR		: in std_logic_vector(0 to 15);
		VFL		: in std_logic_vector(0 to 15);

		-- clock
		pixel_clk	: in std_logic
	);
end entity dvi_pixelgen;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of dvi_pixelgen is

	signal R_count : std_logic_vector(0 to 7);
	signal G_count : std_logic_vector(0 to 7);
	signal B_count : std_logic_vector(0 to 7);

	signal R_count_R : std_logic_vector(0 to 7);
	signal G_count_R : std_logic_vector(0 to 7);
	signal B_count_R : std_logic_vector(0 to 7);

	signal R_screen : std_logic_vector(0 to 7);
	signal G_screen : std_logic_vector(0 to 7);
	signal B_screen : std_logic_vector(0 to 7);

	signal X_count : std_logic_vector(0 to 15);
	signal Y_count : std_logic_vector(0 to 15);
	signal Y_decount : std_logic_vector(0 to 15);

	signal Xcharpix_count : std_logic_vector(0 to 2);
	signal Ycharpix_count : std_logic_vector(0 to 3);
	signal Xcharpix_count_R : std_logic_vector(0 to 2);
	signal Ycharpix_count_R : std_logic_vector(0 to 3);
	signal Xcharpix_count_RR : std_logic_vector(0 to 2);
	signal Ycharpix_count_RR : std_logic_vector(0 to 3);
	signal memchar_count : std_logic_vector(0 to 13);
	signal memchar_count_R : std_logic_vector(0 to 13);
	signal memchar_base : std_logic_vector(0 to 13);

	signal VR_M : std_logic_vector(0 to 15);
	signal HR_M : std_logic_vector(0 to 15);

	signal long_charval : std_logic_vector(0 to 31);
	signal char_number : std_logic_vector(0 to 7);

	signal logo_mask : std_logic_vector(0 downto 0);
	signal rom_address : std_logic_vector(13 downto 0);

	signal textmap_mask : std_logic_vector(0 downto 0);
	signal textmap_address : std_logic_vector(13 downto 0);

	signal blink_letters : std_logic_vector(0 to 25);
	signal letter_mask : std_logic;

	signal data_in : std_logic_vector(0 to 8);

	-- double buffer selection
	signal select_buffer : std_logic;
	signal select_buffer_n : std_logic;

	signal spectro_bram_counter : std_logic_vector(0 to 9);
	signal bram_is_counting : std_logic;
	signal bram_is_counting_R : std_logic;
	signal bram_is_counting_RR : std_logic;
	signal bram_is_counting_RRR : std_logic;

	signal spectroram_doa : std_logic_vector(0 to 7);
	signal spectroram_dopa : std_logic_vector(0 to 0);
	signal spectroram_addra : std_logic_vector(0 to 10);
	signal spectroram_addrb : std_logic_vector(0 to 9);
	signal spectroram_dib : std_logic_vector(0 to 15);
	signal spectroram_dipb : std_logic_vector(0 to 1);

	attribute INIT_00 : string; 
	attribute INIT_01 : string; 
	attribute INIT_02 : string; 
	attribute INIT_03 : string; 
	attribute INIT_04 : string; 
	attribute INIT_05 : string; 
	attribute INIT_06 : string; 
	attribute INIT_07 : string; 
	attribute INIT_08 : string; 
	attribute INIT_09 : string; 
	attribute INIT_0A : string; 
	attribute INIT_0B : string; 
	attribute INIT_0C : string; 
	attribute INIT_0D : string; 
	attribute INIT_0E : string; 
	attribute INIT_0F : string; 
	attribute INIT_10 : string; 
	attribute INIT_11 : string; 
	attribute INIT_12 : string; 
	attribute INIT_13 : string; 
	attribute INIT_14 : string; 
	attribute INIT_15 : string; 
	attribute INIT_16 : string; 
	attribute INIT_17 : string; 
	attribute INIT_18 : string; 
	attribute INIT_19 : string; 
	attribute INIT_1A : string; 
	attribute INIT_1B : string; 
	attribute INIT_1C : string; 
	attribute INIT_1D : string; 
	attribute INIT_1E : string; 
	attribute INIT_1F : string; 
	attribute INIT_20 : string; 
	attribute INIT_21 : string; 
	attribute INIT_22 : string; 
	attribute INIT_23 : string; 
	attribute INIT_24 : string; 
	attribute INIT_25 : string; 
	attribute INIT_26 : string; 
	attribute INIT_27 : string; 
	attribute INIT_28 : string; 
	attribute INIT_29 : string; 
	attribute INIT_2A : string; 
	attribute INIT_2B : string; 
	attribute INIT_2C : string; 
	attribute INIT_2D : string; 
	attribute INIT_2E : string; 
	attribute INIT_2F : string; 
	attribute INIT_30 : string; 
	attribute INIT_31 : string; 
	attribute INIT_32 : string; 
	attribute INIT_33 : string; 
	attribute INIT_34 : string; 
	attribute INIT_35 : string; 
	attribute INIT_36 : string; 
	attribute INIT_37 : string; 
	attribute INIT_38 : string; 
	attribute INIT_39 : string; 
	attribute INIT_3A : string; 
	attribute INIT_3B : string; 
	attribute INIT_3C : string; 
	attribute INIT_3D : string; 
	attribute INIT_3E : string; 
	attribute INIT_3F : string;

	attribute INIT_00 of logo_rom : label is "FFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_01 of logo_rom : label is "FFFFFFFFFFFFFFFFFFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFFFFFFFFFFF";
	attribute INIT_02 of logo_rom : label is "FFFFFFF807FFFFFFFFC7FFFFFFFFFFFFFFFFFFF07FFFFFFFFFC7FFFFFFFFFFFF";
	attribute INIT_03 of logo_rom : label is "FFFFFFFFE0FFFFFFFFE3FFFFFFFFFFFFFFFFFFFE03FFFFFFFFE7FFFFFFFFFFFF";
	attribute INIT_04 of logo_rom : label is "FFFFFFFFFC3FFFFFFFE3FFFFFFFFFFFFFFFFFFFFF87FFFFFFFE3FFFFFFFFFFFF";
	attribute INIT_05 of logo_rom : label is "FFFFFFFFFF8FFFFFFFE78F1FF9FF99F9FFFFFFFFFF1FFFFFFFE7C03C01C01C01";
	attribute INIT_06 of logo_rom : label is "FFFFFFFFFFCFFFFFFFC79FFFF9FF99F9FFFFFFFFFF8FFFFFFFC79F9FF9FF99F9";
	attribute INIT_07 of logo_rom : label is "FFFFFFFFFFE3FFFFFFCF8FFFF9FF99F9FFFFFFFFFFE7FFFFFFC79FFE01E01801";
	attribute INIT_08 of logo_rom : label is "FFFFFFFFFFF3FFFFFF1FF1FFF9FF99F9FFFFFFFFFFE3FFFFFF8FE3FFF9FF99F9";
	attribute INIT_09 of logo_rom : label is "FFFFFFFFFFF9FFFFFC7FFE3FF9FF99F9FFFFFFFFFFF3FFFFFF3FFC7FF9FF99F9";
	attribute INIT_0A of logo_rom : label is "FFFFFFFFFFF8FFFFF8FFFFFFFFFFFFFFFFFFFFFFFFF9FFFFF8FF801C01C01C01";
	attribute INIT_0B of logo_rom : label is "FFFFFFFFFFFCFFFF87FFFFFFFFFFFFFFFFFFFFFFFFF9FFFFE1FFFFFFFFFFFFFF";
	attribute INIT_0C of logo_rom : label is "FFFFFFFFFFFC7FFE1FFFFFFFFFFFFFFFFFFFFFFFFFFC7FFF8FFFFFFFFFFFFFFF";
	attribute INIT_0D of logo_rom : label is "FFFFFFFFFFFE7FF87FFFFFFFFFFFFFFFFFFFFFFFFFFC7FFC7FFFFFFFFFFFFFFF";
	attribute INIT_0E of logo_rom : label is "FFFFFFFFFFFE03C3FFFFFFFFFFFFFFFFFFFFFFFFFFFE0BE0FFFFFFFFFFFFFFFF";
	attribute INIT_0F of logo_rom : label is "FFFFFFFFFF03A407FFFFFFFFFFFFFFFFFFFFFFFFFF800107FFFFFFFFFFFFFFFF";
	attribute INIT_10 of logo_rom : label is "FFFFFFFFFC003671FFF8FFE007FFFFFFFFFFFFFFFE003DE3FFFCFFFFFFFFFFFF";
	attribute INIT_11 of logo_rom : label is "FFFFFFFFF80F00003FE3E003FFFFFFFFFFFFFFFFFC000200FFF1FC0001FFFFFF";
	attribute INIT_12 of logo_rom : label is "FFFFFFFFF83FC00FEFDF8FFFFFF1FFFFFFFFFFFFF81FC0039FEFC3FFFFFFFFFF";
	attribute INIT_13 of logo_rom : label is "FFFFFFFFFC7FE03FF7FEFFE0003E1FFFFFFFFFFFFC7FE01FE7BF3FFF80007FFF";
	attribute INIT_14 of logo_rom : label is "FFFFFFFFFC7F603FF3F7F007FFFFF1FFFFFFFFFFFC7FE03FF3F9FE001FFFC7FF";
	attribute INIT_15 of logo_rom : label is "FFFFFFFFFE3FE03F33FE07FFF1FFFF3FFFFFFFFFFC7F203FB3FF807FFFFFFCFF";
	attribute INIT_16 of logo_rom : label is "FFFFFC1C1F0F801FE7F0FFF000FFFFF3FFFFFF807E1FC03FF7FC3FFE00FFFFCF";
	attribute INIT_17 of logo_rom : label is "FFE04703338000001F8FFFFFFFFFC3FFFFF9F0F84700000F8FC3FFBFFBFFBFFF";
	attribute INIT_18 of logo_rom : label is "FFEC03FF8E600000FFFFFFFFFFFFF0FFFFEE000F98C000007E7FFFFFFFFFF07F";
	attribute INIT_19 of logo_rom : label is "FFC3FFFFE3800F01FFFFFFFFFFFFFFFFFFE1FFFFC7201000FFFFFFFFFFFFE7FF";
	attribute INIT_1A of logo_rom : label is "FFFFFFFFFC060003FFFFFFFFFFFFFF8FFFC7FFFFF9800003FFFFFFFFFFFFFFFB";
	attribute INIT_1B of logo_rom : label is "FFFFFE001F1F800000F803FFFFFC01FFFFFFFFFFFF0F00000FFEFFFFFFFFC03F";
	attribute INIT_1C of logo_rom : label is "FFFF0000000FF9C00F1FFFFFFFFFFFFFFFFFE0000307C000FC3FFFFFFFF07FFF";
	attribute INIT_1D of logo_rom : label is "FFF00FFFFC07FFC01003FFFFFFFFFFFFFFFC03FE001FFFC001C7FFFFFFFFFFFF";
	attribute INIT_1E of logo_rom : label is "FC61FFC0040067000603FFFFFFFFFFFFFE003FEFBC077F000F01FFFFFFFFFFFF";
	attribute INIT_1F of logo_rom : label is "F01FFFC8E0000200410FFFFFFFFFFFFFF84FFFDC000042000007FFFFFFFFFFFF";
	attribute INIT_20 of logo_rom : label is "FFBFFFC1FC0000000C007F7FFFFFFFFFF91FFFC0F8000001C21FFFFFFFFFFFFF";
	attribute INIT_21 of logo_rom : label is "FFFFFFFFF800001EF180000FFFFFFFFFFFFFFFFFFC0000083800043FFFFFFFFF";
	attribute INIT_22 of logo_rom : label is "FFFFFFFFFF00000000FFFC0FFFFFFFFFFFFFFFFFFC00001F81FC0007FFFFFFFF";
	attribute INIT_23 of logo_rom : label is "FFFFFFFFFFE00000F847FFFFFFFFFFFFFFFFFFFFFF000000703FFE1FFFFFFFFF";
	attribute INIT_24 of logo_rom : label is "FFFFFFFFFFF00000F81CFFFFFFFFFFFFFFFFFFFFFFE00000F871FFFFFFFFFFFF";
	attribute INIT_25 of logo_rom : label is "FFFFFFFFFFFFE001F8041FFFFFFFFFFFFFFFFFFFFFFC0000F8003FFFFFFFFFFF";
	attribute INIT_26 of logo_rom : label is "FFFFFFFFFFFFC003F073CCFFFFFFFFFFFFFFFFFFFFFFC001F86783FFFFFFFFFF";
	attribute INIT_27 of logo_rom : label is "FFFFFFFFFFFF8007E071F38FFFFFFFFFFFFFFFFFFFFFC003F071E63FFFFFFFFF";
	attribute INIT_28 of logo_rom : label is "FFFFFFFFFFFF801F00F0FF801FFFFFFFFFFFFFFFFFFF800FC071FCE3FFFFFFFF";
	attribute INIT_29 of logo_rom : label is "FFFFFFFFFFFF000003F1FFF87FFFFFFFFFFFFFFFFFFF003801F1FFE00FFFFFFF";
	attribute INIT_2A of logo_rom : label is "FFFFFFFFFFFF00000FE1FFFFFFFFFFFFFFFFFFFFFFFF000007F1FFFCFFFFFFFF";
	attribute INIT_2B of logo_rom : label is "FFFFFFFFFFFF80007F81FFFFFFFFFFFFFFFFFFFFFFFF80001FC1FFFFFFFFFFFF";
	attribute INIT_2C of logo_rom : label is "FFFFFFFFFFFF8001F001FFFFFFFFFFFFFFFFFFFFFFFF8000FF01FFFFFFFFFFFF";
	attribute INIT_2D of logo_rom : label is "FFFFFFFFFFFF80000013FFFFFFFFFFFFFFFFFFFFFFFF80000003FFFFFFFFFFFF";
	attribute INIT_2E of logo_rom : label is "FFFFFFFFFFFF800000E7FFFFFFFFFFFFFFFFFFFFFFFF80000023FFFFFFFFFFFF";
	attribute INIT_2F of logo_rom : label is "FFFFFFFFFFFF80000FCFFFFFFFFFFFFFFFFFFFFFFFFF800001CFFFFFFFFFFFFF";
	attribute INIT_30 of logo_rom : label is "FFFFFFFFFFFFC000FE3FFFFFFFFFFFFFFFFFFFFFFFFFC007FF9FFFFFFFFFFFFF";
	attribute INIT_31 of logo_rom : label is "FFFFFFFFFFFFC00000FFFFFFFFFFFFFFFFFFFFFFFFFFC000007FFFFFFFFFFFFF";
	attribute INIT_32 of logo_rom : label is "FFFFFFFFFFFFF00001FFFFFFFFFFFFFFFFFFFFFFFFFFE00000FFFFFFFFFFFFFF";
	attribute INIT_33 of logo_rom : label is "FFFFFFFFFFFFF81FF3FFFFFFFFFFFFFFFFFFFFFFFFFFF82001FFFFFFFFFFFFFF";
	attribute INIT_34 of logo_rom : label is "FFFFFFFFFFFFF8001FFFFFFFFFFFFFFFFFFFFFFFFFFFF807E7FFFFFFFFFFFFFF";
	attribute INIT_35 of logo_rom : label is "FFFFFFFFFFFFF807FFFFFFFFFFFFFFFFFFFFFFFFFFFFF801FFFFFFFFFFFFFFFF";
	attribute INIT_36 of logo_rom : label is "FFFFFFFFFFFFF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80FFFFFFFFFFFFFFFFF";
	attribute INIT_37 of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_38 of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_39 of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3A of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3B of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3C of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3D of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3E of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
	attribute INIT_3F of logo_rom : label is "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";

	attribute INIT_00 of textmap_rom : label is "00FE003CF8000000000000242400240000000000000000000000002424002400";
	attribute INIT_01 of textmap_rom : label is "00FE0066B8000000000000442200240000C60066E00000000000002424002400";
	attribute INIT_02 of textmap_rom : label is "00C6003C3E00000000300C081000240000C600669C00000000C0038811FF2400";
	attribute INIT_03 of textmap_rom : label is "00E6007E66000000008811C003FF240000C6001866000000000810300C002400";
	attribute INIT_04 of textmap_rom : label is "006700183C000000002424000000240000E70018660000000044220000002400";
	attribute INIT_05 of textmap_rom : label is "0000000000000000002424000000240000030000000000000024240000002400";
	attribute INIT_06 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_07 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_08 of textmap_rom : label is "000000000000181818007EFE6618400100000000000000000000000000000000";
	attribute INIT_09 of textmap_rom : label is "00007F082418187E7E000CDB667E700700007F080000183C3C00C6DB663C6003";
	attribute INIT_0A of textmap_rom : label is "00003E1CFF7F1818180066DE66187F7F00003E1C6630181818003CDB66187C1F";
	attribute INIT_0B of textmap_rom : label is "00001C3E24187E187E7F3CD8007E700700001C3E66301818180066D800187C1F";
	attribute INIT_0C of textmap_rom : label is "0000087F00001818187F63D8661840010000087F00003C183C7F30D8663C6003";
	attribute INIT_0D of textmap_rom : label is "0000000000000000000000000000000000000000000000007E007E0000000000";
	attribute INIT_0E of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_0F of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_10 of textmap_rom : label is "00000000000006300C0E000C36660C0000000000000000000000000C00000000";
	attribute INIT_11 of textmap_rom : label is "600000001866180C0C1B23037F661E004000000000000C180C1B003E36661E00";
	attribute INIT_12 of textmap_rom : label is "18007F007EFF3006005F181E36000C0030000000183C3006060E330336241E00";
	attribute INIT_13 of textmap_rom : label is "060000001866180C003306307F0000000C000000183C3006007B0C3036000C00";
	attribute INIT_14 of textmap_rom : label is "011C001C00000630006E310C36000C00031C001C00000C18003B331F36000C00";
	attribute INIT_15 of textmap_rom : label is "0000000000000000000000000000000000000006000000000000000C00000000";
	attribute INIT_16 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_17 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_18 of textmap_rom : label is "1E06003000001E1E7F1C3F301E1E083E00000000000000000000000000000000";
	attribute INIT_19 of textmap_rom : label is "3018000C1C1C33336303033C30330F73330C0018000033336306033833330C63";
	attribute INIT_1A of textmap_rom : label is "0C60000300003E1E301F1F331C180C6B18307E061C1C33376003033630300C7B";
	attribute INIT_1B of textmap_rom : label is "0018000C1C1C18330C33303030060C670C307E060000183B1833307F300C0C6F";
	attribute INIT_1C of textmap_rom : label is "0C06003018000E1E0C1E1E781E3F3F3E0C0C00181C1C0C330C33333033330C63";
	attribute INIT_1D of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_1E of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_1F of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_20 of textmap_rom : label is "1C63630F67781E333C7F7F1F3C3F0C3E00000000000000000000000000000000";
	attribute INIT_21 of textmap_rom : label is "63677F0636300C3363460666636633633663770666300C336666463666661E63";
	attribute INIT_22 of textmap_rom : label is "637F6B061E300C3F033E3E66033E337B636F7F0636300C33032626660366337B";
	attribute INIT_23 of textmap_rom : label is "6373636636330C336306066663663303637B634636330C337326266603663F7B";
	attribute INIT_24 of textmap_rom : label is "1C63637F671E1E337C0F7F1F3C3F333E3663636666330C336606463666663303";
	attribute INIT_25 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_26 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_27 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_28 of textmap_rom : label is "001C3C003C7F33336333333F1E3F1C3F00000000000000000000000000000000";
	attribute INIT_29 of textmap_rom : label is "006330030C1933336333330C33666366003630010C7333336333332D33663666";
	attribute INIT_2A of textmap_rom : label is "0000300C0C0C1E0C6B33330C0E3E633E000030060C18331E6333330C03666366";
	attribute INIT_2B of textmap_rom : label is "000030300C460C333633330C33667B06000030180C060C1E6B33330C18367306";
	attribute INIT_2C of textmap_rom : label is "00003C403C7F1E33360C1E1E1E67300F000030600C630C33361E330C33663E06";
	attribute INIT_2D of textmap_rom : label is "000000000000000000000000000000007F000000000000000000000000007800";
	attribute INIT_2E of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_2F of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_30 of textmap_rom : label is "0000001E07301807001C00380007000C0000000000000000000000000000000C";
	attribute INIT_31 of textmap_rom : label is "0000001806000006000600300006000000000018063018060036003000060018";
	attribute INIT_32 of textmap_rom : label is "33336B183630186E331F3333336630001E1F3F18663C1E366E061E3E1E3E1E00";
	attribute INIT_33 of textmap_rom : label is "33336B1836301866330603330366330033336B181E30186633063F3303663E00";
	attribute INIT_34 of textmap_rom : label is "1E33637E67337E67300F1E6E1E3B6E0033336B18663018663E06333333663300";
	attribute INIT_35 of textmap_rom : label is "00000000001E00001E0000000000000000000000003300003300000000000000";
	attribute INIT_36 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_37 of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_38 of textmap_rom : label is "00CE071838000000000000000000000000000000000000000000000000000000";
	attribute INIT_39 of textmap_rom : label is "08730C180C0000000000000600000000005B0C180C0000000000000400000000";
	attribute INIT_3A of textmap_rom : label is "360030000331663663333306337633661C001818063F66636333333F1E376E3B";
	attribute INIT_3B of textmap_rom : label is "63000C180C06661C6B33330618063366630018180618661C6B333306066E3366";
	attribute INIT_3C of textmap_rom : label is "00000718383F3063360C6E1C1E0F3E3E7F000C180C233C36361E333633063366";
	attribute INIT_3D of textmap_rom : label is "0000000000000F00000000000000780F00000000000018000000000000003006";
	attribute INIT_3E of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";
	attribute INIT_3F of textmap_rom : label is "0000000000000000000000000000000000000000000000000000000000000000";

begin
	PIXELGEN_PROC : process( pixel_clk ) is
	begin
		if pixel_clk'event and pixel_clk = '1' then

			-- match the pixel pipeline latency

			bram_is_counting_R <= bram_is_counting;
			bram_is_counting_RR <= bram_is_counting_R;
			bram_is_counting_RRR <= bram_is_counting_RR;

			-- generates the RGB values -- pipeline latency = 2
			if data_in >= Y_decount(7 to 15) and display_spectrum = '1' and bram_is_counting_RR = '1' then
				R_count_R <= Y_decount(7 to 14);
				G_count_R <= Y_count(7 to 14);
				B_count_R <= X"00";
			else
				R_count_R <= X"00";
				G_count_R <= X"00";
				B_count_R <= X"7F";
			end if;

			-- counters for the display of the spectrum values
			if (X_count = X"00FE") then
				bram_is_counting <= '1';
				spectro_bram_counter <= "0000000000";
			end if;
			if (bram_is_counting_R = '1') then
				spectro_bram_counter <= spectro_bram_counter + 1;
			end if;

			if (X_count(0 to 8) = "000000000") and (Y_count(0 to 8) = "000000000") and (logo_mask="0") then
				R_screen <= X"FF";
				G_screen <= X"FF";
				B_screen <= X"00";
			else
				R_screen <= R_count_R;
				G_screen <= G_count_R;
				B_screen <= B_count_R;
			end if;

			blink_letters <= blink_letters + 1;
			if req_pixel = '1' then
				Xcharpix_count <= Xcharpix_count+1;
				if Xcharpix_count="111" then
					Xcharpix_count <= "000";
					memchar_count <= memchar_count + 1;
				end if;
				X_count <= X_count + 1;
				R_count <= R_count + 1;
			end if;

			if endof_line = '1' then
				bram_is_counting <= '0';
				Ycharpix_count <= Ycharpix_count+1;
				if Ycharpix_count="1011" then
					Ycharpix_count <= "0000";
					memchar_base <= memchar_count;
				else
					memchar_count <= memchar_base;
				end if;
				Xcharpix_count <= "000";
				X_count <= X"0001";
				Y_count <= Y_count + 1;
				Y_decount <= Y_decount - 1;
				R_count <= "00000000";
				G_count <= G_count + 1;
			end if;

			if endof_frame = '1' then
				select_buffer <= not select_buffer;
				memchar_base <= "00000000000000";
				Ycharpix_count <= "0000";
				Y_count <= X"0001";
				Y_decount <= (VR-1);
				R_count <= "00000000";
				G_count <= "00000000";
				B_count <= B_count + 1;
			end if;

			-- addresses generation to address the BRAMs
			memchar_count_R <= memchar_count;
	      	case memchar_count_R(12 to 13) is
	        		when "00" => char_number <= 	long_charval(0 to 7);
	        		when "01" => char_number <= 	long_charval(8 to 15);
	        		when "10" => char_number <= 	long_charval(16 to 23);
	        		when "11" => char_number <= 	long_charval(24 to 31);
				when others => char_number <= "00000000";
			end case;		

			-- delays the X and Y textmap address to match the BRAM latency
			Xcharpix_count_R <= Xcharpix_count;
			Ycharpix_count_R <= Ycharpix_count;
			Xcharpix_count_RR <= Xcharpix_count_R;
			Ycharpix_count_RR <= Ycharpix_count_R;
		end if;

	end process PIXELGEN_PROC;

	ADDRLATCH_PROC : process( spectro_clk ) is
	begin
		if spectro_clk'event and spectro_clk = '1' then
			select_buffer_n <= not select_buffer;
		end if;
	end process ADDRLATCH_PROC;

	textmap_address <= char_number(1 to 3) & Ycharpix_count_RR(0 to 3) & char_number(4 to 7) & Xcharpix_count_RR(0 to 2);
	rom_address <= Y_count(9 to 15) & X_count(9 to 15);

	data_in <= spectroram_doa & spectroram_dopa;
	spectroram_addra <= select_buffer & spectro_bram_counter;
	spectroram_addrb <= select_buffer_n & spectro_address;
	spectroram_dib <=  spectro_data(9 to 16) & spectro_data(0 to 7);
	spectroram_dipb <= spectro_data(17) & spectro_data(8);

	-- the BRAM for the spectrometer data
	spectro_ram : RAMB16_S9_S18
	port map(
		DOA => spectroram_doa,
		DOB => open,
		DOPA => spectroram_dopa,
		DOPB => open,
		ADDRA => spectroram_addra,
		ADDRB => spectroram_addrb,
		CLKA => pixel_clk,
		CLKB => spectro_clk,
		DIA => "00000000",
		DIB => spectroram_dib,
		DIPA => "0",
		DIPB => spectroram_dipb,
		ENA => '1',
		ENB => '1',
		SSRA => '0',
		SSRB => '0',
		WEA => '0',
		WEB => spectro_wen
	);

	-- the BRAM for the bee picture
	logo_rom : RAMB16_S1
	port map(
		DI => "0",    
		EN => '1',
		WE => '0',
		SSR => '0',
		CLK => pixel_clk,
		ADDR => rom_address,
		DO => logo_mask
	); 

	-- the BRAM for the textmaps
	textmap_rom : RAMB16_S1
	port map(
		DI => "0",    
		EN => '1',
		WE => '0',
		SSR => '0',
		CLK => pixel_clk,
		ADDR => textmap_address,
		DO => textmap_mask
	); 

	-- the BRAM signals for the char buffer
	charbuffer_rst <= '0';
	charbuffer_clk <= pixel_clk;
	charbuffer_en <= '1';
	charbuffer_wen <= "0000";
	charbuffer_addr <= "000000000000000000" & memchar_count(0 to 11) & "00";
	long_charval <= charbuffer_din;
	charbuffer_dout <= X"00000000";

	-- the RGB generation
	letter_mask <= textmap_mask(0) when (char_number(0)='0') else (textmap_mask(0) and blink_letters(0));

	R <= X"FF" when (letter_mask = '1') else R_screen;
	G <= X"FF" when (letter_mask = '1') else G_screen;
	B <= X"FF" when (letter_mask = '1') else B_screen;

end IMP;
