-- This file is part of XML2VHDL
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
-- 
-- This program is free software: you can redistribute it and/or modify  
-- it under the terms of the GNU General Public License as published by  
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but 
-- WITHOUT ANY WARRANTY; without even the implied warranty of 
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License 
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;

package axi4lite_igmp_mode_control_pkg is 

   --##########################################################################
   --
   -- Register Records
   --
   --##########################################################################
   type t_axi4lite_igmp_mode_control_mcast_addr is array (0 to 256-1) of std_logic_vector(31 downto 0);

   type t_axi4lite_igmp_mode_control_igmp_control is record
      igmp_en: std_logic;
      igmp_ver: std_logic_vector(1 downto 0);
      igmp_sub: std_logic;
      igmp_rst: std_logic;
      igmp_num: std_logic_vector(7 downto 0);
   end record;

   type t_axi4lite_igmp_mode_control is record
      igmp_control: t_axi4lite_igmp_mode_control_igmp_control;
      mcast_addr: t_axi4lite_igmp_mode_control_mcast_addr;
   end record;

   --##########################################################################
   --
   -- Register Decoded Records
   --
   --##########################################################################
   type t_axi4lite_igmp_mode_control_mcast_addr_decoded is array (0 to 256-1) of std_logic;

   type t_axi4lite_igmp_mode_control_igmp_control_decoded is record
      igmp_en: std_logic;
      igmp_ver: std_logic;
      igmp_sub: std_logic;
      igmp_rst: std_logic;
      igmp_num: std_logic;
   end record;

   type t_axi4lite_igmp_mode_control_decoded is record
      igmp_control: t_axi4lite_igmp_mode_control_igmp_control_decoded;
      mcast_addr: t_axi4lite_igmp_mode_control_mcast_addr_decoded;
   end record;

   --##########################################################################
   --
   -- Register Descriptors
   --
   --##########################################################################
   type t_access_type is (r,w,rw);
   type t_reset_type is (async_reset,no_reset);
   
   type t_reg_descr is record
      offset: std_logic_vector(31 downto 0);
      bit_hi: natural;
      bit_lo: natural;
      rst_val: std_logic_vector(31 downto 0);
      reset_type: t_reset_type;
      decoder_mask: std_logic_vector(31 downto 0);
      access_type: t_access_type;
   end record;
   
   type t_axi4lite_igmp_mode_control_descr is record
      igmp_control_igmp_en: t_reg_descr;
      igmp_control_igmp_ver: t_reg_descr;
      igmp_control_igmp_sub: t_reg_descr;
      igmp_control_igmp_rst: t_reg_descr;
      igmp_control_igmp_num: t_reg_descr;
      mcast_addr_0_addr: t_reg_descr;
      mcast_addr_1_addr: t_reg_descr;
      mcast_addr_2_addr: t_reg_descr;
      mcast_addr_3_addr: t_reg_descr;
      mcast_addr_4_addr: t_reg_descr;
      mcast_addr_5_addr: t_reg_descr;
      mcast_addr_6_addr: t_reg_descr;
      mcast_addr_7_addr: t_reg_descr;
      mcast_addr_8_addr: t_reg_descr;
      mcast_addr_9_addr: t_reg_descr;
      mcast_addr_10_addr: t_reg_descr;
      mcast_addr_11_addr: t_reg_descr;
      mcast_addr_12_addr: t_reg_descr;
      mcast_addr_13_addr: t_reg_descr;
      mcast_addr_14_addr: t_reg_descr;
      mcast_addr_15_addr: t_reg_descr;
      mcast_addr_16_addr: t_reg_descr;
      mcast_addr_17_addr: t_reg_descr;
      mcast_addr_18_addr: t_reg_descr;
      mcast_addr_19_addr: t_reg_descr;
      mcast_addr_20_addr: t_reg_descr;
      mcast_addr_21_addr: t_reg_descr;
      mcast_addr_22_addr: t_reg_descr;
      mcast_addr_23_addr: t_reg_descr;
      mcast_addr_24_addr: t_reg_descr;
      mcast_addr_25_addr: t_reg_descr;
      mcast_addr_26_addr: t_reg_descr;
      mcast_addr_27_addr: t_reg_descr;
      mcast_addr_28_addr: t_reg_descr;
      mcast_addr_29_addr: t_reg_descr;
      mcast_addr_30_addr: t_reg_descr;
      mcast_addr_31_addr: t_reg_descr;
      mcast_addr_32_addr: t_reg_descr;
      mcast_addr_33_addr: t_reg_descr;
      mcast_addr_34_addr: t_reg_descr;
      mcast_addr_35_addr: t_reg_descr;
      mcast_addr_36_addr: t_reg_descr;
      mcast_addr_37_addr: t_reg_descr;
      mcast_addr_38_addr: t_reg_descr;
      mcast_addr_39_addr: t_reg_descr;
      mcast_addr_40_addr: t_reg_descr;
      mcast_addr_41_addr: t_reg_descr;
      mcast_addr_42_addr: t_reg_descr;
      mcast_addr_43_addr: t_reg_descr;
      mcast_addr_44_addr: t_reg_descr;
      mcast_addr_45_addr: t_reg_descr;
      mcast_addr_46_addr: t_reg_descr;
      mcast_addr_47_addr: t_reg_descr;
      mcast_addr_48_addr: t_reg_descr;
      mcast_addr_49_addr: t_reg_descr;
      mcast_addr_50_addr: t_reg_descr;
      mcast_addr_51_addr: t_reg_descr;
      mcast_addr_52_addr: t_reg_descr;
      mcast_addr_53_addr: t_reg_descr;
      mcast_addr_54_addr: t_reg_descr;
      mcast_addr_55_addr: t_reg_descr;
      mcast_addr_56_addr: t_reg_descr;
      mcast_addr_57_addr: t_reg_descr;
      mcast_addr_58_addr: t_reg_descr;
      mcast_addr_59_addr: t_reg_descr;
      mcast_addr_60_addr: t_reg_descr;
      mcast_addr_61_addr: t_reg_descr;
      mcast_addr_62_addr: t_reg_descr;
      mcast_addr_63_addr: t_reg_descr;
      mcast_addr_64_addr: t_reg_descr;
      mcast_addr_65_addr: t_reg_descr;
      mcast_addr_66_addr: t_reg_descr;
      mcast_addr_67_addr: t_reg_descr;
      mcast_addr_68_addr: t_reg_descr;
      mcast_addr_69_addr: t_reg_descr;
      mcast_addr_70_addr: t_reg_descr;
      mcast_addr_71_addr: t_reg_descr;
      mcast_addr_72_addr: t_reg_descr;
      mcast_addr_73_addr: t_reg_descr;
      mcast_addr_74_addr: t_reg_descr;
      mcast_addr_75_addr: t_reg_descr;
      mcast_addr_76_addr: t_reg_descr;
      mcast_addr_77_addr: t_reg_descr;
      mcast_addr_78_addr: t_reg_descr;
      mcast_addr_79_addr: t_reg_descr;
      mcast_addr_80_addr: t_reg_descr;
      mcast_addr_81_addr: t_reg_descr;
      mcast_addr_82_addr: t_reg_descr;
      mcast_addr_83_addr: t_reg_descr;
      mcast_addr_84_addr: t_reg_descr;
      mcast_addr_85_addr: t_reg_descr;
      mcast_addr_86_addr: t_reg_descr;
      mcast_addr_87_addr: t_reg_descr;
      mcast_addr_88_addr: t_reg_descr;
      mcast_addr_89_addr: t_reg_descr;
      mcast_addr_90_addr: t_reg_descr;
      mcast_addr_91_addr: t_reg_descr;
      mcast_addr_92_addr: t_reg_descr;
      mcast_addr_93_addr: t_reg_descr;
      mcast_addr_94_addr: t_reg_descr;
      mcast_addr_95_addr: t_reg_descr;
      mcast_addr_96_addr: t_reg_descr;
      mcast_addr_97_addr: t_reg_descr;
      mcast_addr_98_addr: t_reg_descr;
      mcast_addr_99_addr: t_reg_descr;
      mcast_addr_100_addr: t_reg_descr;
      mcast_addr_101_addr: t_reg_descr;
      mcast_addr_102_addr: t_reg_descr;
      mcast_addr_103_addr: t_reg_descr;
      mcast_addr_104_addr: t_reg_descr;
      mcast_addr_105_addr: t_reg_descr;
      mcast_addr_106_addr: t_reg_descr;
      mcast_addr_107_addr: t_reg_descr;
      mcast_addr_108_addr: t_reg_descr;
      mcast_addr_109_addr: t_reg_descr;
      mcast_addr_110_addr: t_reg_descr;
      mcast_addr_111_addr: t_reg_descr;
      mcast_addr_112_addr: t_reg_descr;
      mcast_addr_113_addr: t_reg_descr;
      mcast_addr_114_addr: t_reg_descr;
      mcast_addr_115_addr: t_reg_descr;
      mcast_addr_116_addr: t_reg_descr;
      mcast_addr_117_addr: t_reg_descr;
      mcast_addr_118_addr: t_reg_descr;
      mcast_addr_119_addr: t_reg_descr;
      mcast_addr_120_addr: t_reg_descr;
      mcast_addr_121_addr: t_reg_descr;
      mcast_addr_122_addr: t_reg_descr;
      mcast_addr_123_addr: t_reg_descr;
      mcast_addr_124_addr: t_reg_descr;
      mcast_addr_125_addr: t_reg_descr;
      mcast_addr_126_addr: t_reg_descr;
      mcast_addr_127_addr: t_reg_descr;
      mcast_addr_128_addr: t_reg_descr;
      mcast_addr_129_addr: t_reg_descr;
      mcast_addr_130_addr: t_reg_descr;
      mcast_addr_131_addr: t_reg_descr;
      mcast_addr_132_addr: t_reg_descr;
      mcast_addr_133_addr: t_reg_descr;
      mcast_addr_134_addr: t_reg_descr;
      mcast_addr_135_addr: t_reg_descr;
      mcast_addr_136_addr: t_reg_descr;
      mcast_addr_137_addr: t_reg_descr;
      mcast_addr_138_addr: t_reg_descr;
      mcast_addr_139_addr: t_reg_descr;
      mcast_addr_140_addr: t_reg_descr;
      mcast_addr_141_addr: t_reg_descr;
      mcast_addr_142_addr: t_reg_descr;
      mcast_addr_143_addr: t_reg_descr;
      mcast_addr_144_addr: t_reg_descr;
      mcast_addr_145_addr: t_reg_descr;
      mcast_addr_146_addr: t_reg_descr;
      mcast_addr_147_addr: t_reg_descr;
      mcast_addr_148_addr: t_reg_descr;
      mcast_addr_149_addr: t_reg_descr;
      mcast_addr_150_addr: t_reg_descr;
      mcast_addr_151_addr: t_reg_descr;
      mcast_addr_152_addr: t_reg_descr;
      mcast_addr_153_addr: t_reg_descr;
      mcast_addr_154_addr: t_reg_descr;
      mcast_addr_155_addr: t_reg_descr;
      mcast_addr_156_addr: t_reg_descr;
      mcast_addr_157_addr: t_reg_descr;
      mcast_addr_158_addr: t_reg_descr;
      mcast_addr_159_addr: t_reg_descr;
      mcast_addr_160_addr: t_reg_descr;
      mcast_addr_161_addr: t_reg_descr;
      mcast_addr_162_addr: t_reg_descr;
      mcast_addr_163_addr: t_reg_descr;
      mcast_addr_164_addr: t_reg_descr;
      mcast_addr_165_addr: t_reg_descr;
      mcast_addr_166_addr: t_reg_descr;
      mcast_addr_167_addr: t_reg_descr;
      mcast_addr_168_addr: t_reg_descr;
      mcast_addr_169_addr: t_reg_descr;
      mcast_addr_170_addr: t_reg_descr;
      mcast_addr_171_addr: t_reg_descr;
      mcast_addr_172_addr: t_reg_descr;
      mcast_addr_173_addr: t_reg_descr;
      mcast_addr_174_addr: t_reg_descr;
      mcast_addr_175_addr: t_reg_descr;
      mcast_addr_176_addr: t_reg_descr;
      mcast_addr_177_addr: t_reg_descr;
      mcast_addr_178_addr: t_reg_descr;
      mcast_addr_179_addr: t_reg_descr;
      mcast_addr_180_addr: t_reg_descr;
      mcast_addr_181_addr: t_reg_descr;
      mcast_addr_182_addr: t_reg_descr;
      mcast_addr_183_addr: t_reg_descr;
      mcast_addr_184_addr: t_reg_descr;
      mcast_addr_185_addr: t_reg_descr;
      mcast_addr_186_addr: t_reg_descr;
      mcast_addr_187_addr: t_reg_descr;
      mcast_addr_188_addr: t_reg_descr;
      mcast_addr_189_addr: t_reg_descr;
      mcast_addr_190_addr: t_reg_descr;
      mcast_addr_191_addr: t_reg_descr;
      mcast_addr_192_addr: t_reg_descr;
      mcast_addr_193_addr: t_reg_descr;
      mcast_addr_194_addr: t_reg_descr;
      mcast_addr_195_addr: t_reg_descr;
      mcast_addr_196_addr: t_reg_descr;
      mcast_addr_197_addr: t_reg_descr;
      mcast_addr_198_addr: t_reg_descr;
      mcast_addr_199_addr: t_reg_descr;
      mcast_addr_200_addr: t_reg_descr;
      mcast_addr_201_addr: t_reg_descr;
      mcast_addr_202_addr: t_reg_descr;
      mcast_addr_203_addr: t_reg_descr;
      mcast_addr_204_addr: t_reg_descr;
      mcast_addr_205_addr: t_reg_descr;
      mcast_addr_206_addr: t_reg_descr;
      mcast_addr_207_addr: t_reg_descr;
      mcast_addr_208_addr: t_reg_descr;
      mcast_addr_209_addr: t_reg_descr;
      mcast_addr_210_addr: t_reg_descr;
      mcast_addr_211_addr: t_reg_descr;
      mcast_addr_212_addr: t_reg_descr;
      mcast_addr_213_addr: t_reg_descr;
      mcast_addr_214_addr: t_reg_descr;
      mcast_addr_215_addr: t_reg_descr;
      mcast_addr_216_addr: t_reg_descr;
      mcast_addr_217_addr: t_reg_descr;
      mcast_addr_218_addr: t_reg_descr;
      mcast_addr_219_addr: t_reg_descr;
      mcast_addr_220_addr: t_reg_descr;
      mcast_addr_221_addr: t_reg_descr;
      mcast_addr_222_addr: t_reg_descr;
      mcast_addr_223_addr: t_reg_descr;
      mcast_addr_224_addr: t_reg_descr;
      mcast_addr_225_addr: t_reg_descr;
      mcast_addr_226_addr: t_reg_descr;
      mcast_addr_227_addr: t_reg_descr;
      mcast_addr_228_addr: t_reg_descr;
      mcast_addr_229_addr: t_reg_descr;
      mcast_addr_230_addr: t_reg_descr;
      mcast_addr_231_addr: t_reg_descr;
      mcast_addr_232_addr: t_reg_descr;
      mcast_addr_233_addr: t_reg_descr;
      mcast_addr_234_addr: t_reg_descr;
      mcast_addr_235_addr: t_reg_descr;
      mcast_addr_236_addr: t_reg_descr;
      mcast_addr_237_addr: t_reg_descr;
      mcast_addr_238_addr: t_reg_descr;
      mcast_addr_239_addr: t_reg_descr;
      mcast_addr_240_addr: t_reg_descr;
      mcast_addr_241_addr: t_reg_descr;
      mcast_addr_242_addr: t_reg_descr;
      mcast_addr_243_addr: t_reg_descr;
      mcast_addr_244_addr: t_reg_descr;
      mcast_addr_245_addr: t_reg_descr;
      mcast_addr_246_addr: t_reg_descr;
      mcast_addr_247_addr: t_reg_descr;
      mcast_addr_248_addr: t_reg_descr;
      mcast_addr_249_addr: t_reg_descr;
      mcast_addr_250_addr: t_reg_descr;
      mcast_addr_251_addr: t_reg_descr;
      mcast_addr_252_addr: t_reg_descr;
      mcast_addr_253_addr: t_reg_descr;
      mcast_addr_254_addr: t_reg_descr;
      mcast_addr_255_addr: t_reg_descr;
   end record;

   
   constant axi4lite_igmp_mode_control_descr: t_axi4lite_igmp_mode_control_descr := (
      igmp_control_igmp_en   => (X"00000000", 0, 0,X"00000000",async_reset,X"000007fc",rw),
      igmp_control_igmp_ver  => (X"00000000", 2, 1,X"00000002",async_reset,X"000007fc",rw),
      igmp_control_igmp_sub  => (X"00000000", 3, 3,X"00000000",async_reset,X"000007fc",rw),
      igmp_control_igmp_rst  => (X"00000000", 4, 4,X"00000000",async_reset,X"000007fc",rw),
      igmp_control_igmp_num  => (X"00000000",31,24,X"00000001",async_reset,X"000007fc",rw),
      mcast_addr_0_addr      => (X"00000004",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_1_addr      => (X"00000008",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_2_addr      => (X"0000000c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_3_addr      => (X"00000010",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_4_addr      => (X"00000014",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_5_addr      => (X"00000018",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_6_addr      => (X"0000001c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_7_addr      => (X"00000020",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_8_addr      => (X"00000024",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_9_addr      => (X"00000028",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_10_addr     => (X"0000002c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_11_addr     => (X"00000030",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_12_addr     => (X"00000034",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_13_addr     => (X"00000038",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_14_addr     => (X"0000003c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_15_addr     => (X"00000040",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_16_addr     => (X"00000044",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_17_addr     => (X"00000048",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_18_addr     => (X"0000004c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_19_addr     => (X"00000050",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_20_addr     => (X"00000054",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_21_addr     => (X"00000058",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_22_addr     => (X"0000005c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_23_addr     => (X"00000060",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_24_addr     => (X"00000064",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_25_addr     => (X"00000068",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_26_addr     => (X"0000006c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_27_addr     => (X"00000070",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_28_addr     => (X"00000074",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_29_addr     => (X"00000078",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_30_addr     => (X"0000007c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_31_addr     => (X"00000080",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_32_addr     => (X"00000084",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_33_addr     => (X"00000088",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_34_addr     => (X"0000008c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_35_addr     => (X"00000090",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_36_addr     => (X"00000094",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_37_addr     => (X"00000098",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_38_addr     => (X"0000009c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_39_addr     => (X"000000a0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_40_addr     => (X"000000a4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_41_addr     => (X"000000a8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_42_addr     => (X"000000ac",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_43_addr     => (X"000000b0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_44_addr     => (X"000000b4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_45_addr     => (X"000000b8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_46_addr     => (X"000000bc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_47_addr     => (X"000000c0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_48_addr     => (X"000000c4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_49_addr     => (X"000000c8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_50_addr     => (X"000000cc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_51_addr     => (X"000000d0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_52_addr     => (X"000000d4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_53_addr     => (X"000000d8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_54_addr     => (X"000000dc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_55_addr     => (X"000000e0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_56_addr     => (X"000000e4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_57_addr     => (X"000000e8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_58_addr     => (X"000000ec",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_59_addr     => (X"000000f0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_60_addr     => (X"000000f4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_61_addr     => (X"000000f8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_62_addr     => (X"000000fc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_63_addr     => (X"00000100",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_64_addr     => (X"00000104",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_65_addr     => (X"00000108",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_66_addr     => (X"0000010c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_67_addr     => (X"00000110",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_68_addr     => (X"00000114",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_69_addr     => (X"00000118",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_70_addr     => (X"0000011c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_71_addr     => (X"00000120",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_72_addr     => (X"00000124",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_73_addr     => (X"00000128",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_74_addr     => (X"0000012c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_75_addr     => (X"00000130",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_76_addr     => (X"00000134",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_77_addr     => (X"00000138",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_78_addr     => (X"0000013c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_79_addr     => (X"00000140",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_80_addr     => (X"00000144",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_81_addr     => (X"00000148",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_82_addr     => (X"0000014c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_83_addr     => (X"00000150",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_84_addr     => (X"00000154",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_85_addr     => (X"00000158",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_86_addr     => (X"0000015c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_87_addr     => (X"00000160",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_88_addr     => (X"00000164",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_89_addr     => (X"00000168",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_90_addr     => (X"0000016c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_91_addr     => (X"00000170",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_92_addr     => (X"00000174",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_93_addr     => (X"00000178",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_94_addr     => (X"0000017c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_95_addr     => (X"00000180",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_96_addr     => (X"00000184",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_97_addr     => (X"00000188",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_98_addr     => (X"0000018c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_99_addr     => (X"00000190",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_100_addr    => (X"00000194",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_101_addr    => (X"00000198",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_102_addr    => (X"0000019c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_103_addr    => (X"000001a0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_104_addr    => (X"000001a4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_105_addr    => (X"000001a8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_106_addr    => (X"000001ac",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_107_addr    => (X"000001b0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_108_addr    => (X"000001b4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_109_addr    => (X"000001b8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_110_addr    => (X"000001bc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_111_addr    => (X"000001c0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_112_addr    => (X"000001c4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_113_addr    => (X"000001c8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_114_addr    => (X"000001cc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_115_addr    => (X"000001d0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_116_addr    => (X"000001d4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_117_addr    => (X"000001d8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_118_addr    => (X"000001dc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_119_addr    => (X"000001e0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_120_addr    => (X"000001e4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_121_addr    => (X"000001e8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_122_addr    => (X"000001ec",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_123_addr    => (X"000001f0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_124_addr    => (X"000001f4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_125_addr    => (X"000001f8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_126_addr    => (X"000001fc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_127_addr    => (X"00000200",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_128_addr    => (X"00000204",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_129_addr    => (X"00000208",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_130_addr    => (X"0000020c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_131_addr    => (X"00000210",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_132_addr    => (X"00000214",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_133_addr    => (X"00000218",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_134_addr    => (X"0000021c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_135_addr    => (X"00000220",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_136_addr    => (X"00000224",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_137_addr    => (X"00000228",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_138_addr    => (X"0000022c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_139_addr    => (X"00000230",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_140_addr    => (X"00000234",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_141_addr    => (X"00000238",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_142_addr    => (X"0000023c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_143_addr    => (X"00000240",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_144_addr    => (X"00000244",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_145_addr    => (X"00000248",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_146_addr    => (X"0000024c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_147_addr    => (X"00000250",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_148_addr    => (X"00000254",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_149_addr    => (X"00000258",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_150_addr    => (X"0000025c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_151_addr    => (X"00000260",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_152_addr    => (X"00000264",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_153_addr    => (X"00000268",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_154_addr    => (X"0000026c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_155_addr    => (X"00000270",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_156_addr    => (X"00000274",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_157_addr    => (X"00000278",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_158_addr    => (X"0000027c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_159_addr    => (X"00000280",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_160_addr    => (X"00000284",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_161_addr    => (X"00000288",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_162_addr    => (X"0000028c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_163_addr    => (X"00000290",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_164_addr    => (X"00000294",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_165_addr    => (X"00000298",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_166_addr    => (X"0000029c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_167_addr    => (X"000002a0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_168_addr    => (X"000002a4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_169_addr    => (X"000002a8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_170_addr    => (X"000002ac",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_171_addr    => (X"000002b0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_172_addr    => (X"000002b4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_173_addr    => (X"000002b8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_174_addr    => (X"000002bc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_175_addr    => (X"000002c0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_176_addr    => (X"000002c4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_177_addr    => (X"000002c8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_178_addr    => (X"000002cc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_179_addr    => (X"000002d0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_180_addr    => (X"000002d4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_181_addr    => (X"000002d8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_182_addr    => (X"000002dc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_183_addr    => (X"000002e0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_184_addr    => (X"000002e4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_185_addr    => (X"000002e8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_186_addr    => (X"000002ec",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_187_addr    => (X"000002f0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_188_addr    => (X"000002f4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_189_addr    => (X"000002f8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_190_addr    => (X"000002fc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_191_addr    => (X"00000300",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_192_addr    => (X"00000304",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_193_addr    => (X"00000308",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_194_addr    => (X"0000030c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_195_addr    => (X"00000310",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_196_addr    => (X"00000314",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_197_addr    => (X"00000318",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_198_addr    => (X"0000031c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_199_addr    => (X"00000320",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_200_addr    => (X"00000324",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_201_addr    => (X"00000328",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_202_addr    => (X"0000032c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_203_addr    => (X"00000330",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_204_addr    => (X"00000334",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_205_addr    => (X"00000338",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_206_addr    => (X"0000033c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_207_addr    => (X"00000340",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_208_addr    => (X"00000344",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_209_addr    => (X"00000348",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_210_addr    => (X"0000034c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_211_addr    => (X"00000350",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_212_addr    => (X"00000354",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_213_addr    => (X"00000358",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_214_addr    => (X"0000035c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_215_addr    => (X"00000360",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_216_addr    => (X"00000364",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_217_addr    => (X"00000368",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_218_addr    => (X"0000036c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_219_addr    => (X"00000370",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_220_addr    => (X"00000374",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_221_addr    => (X"00000378",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_222_addr    => (X"0000037c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_223_addr    => (X"00000380",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_224_addr    => (X"00000384",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_225_addr    => (X"00000388",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_226_addr    => (X"0000038c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_227_addr    => (X"00000390",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_228_addr    => (X"00000394",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_229_addr    => (X"00000398",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_230_addr    => (X"0000039c",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_231_addr    => (X"000003a0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_232_addr    => (X"000003a4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_233_addr    => (X"000003a8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_234_addr    => (X"000003ac",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_235_addr    => (X"000003b0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_236_addr    => (X"000003b4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_237_addr    => (X"000003b8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_238_addr    => (X"000003bc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_239_addr    => (X"000003c0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_240_addr    => (X"000003c4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_241_addr    => (X"000003c8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_242_addr    => (X"000003cc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_243_addr    => (X"000003d0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_244_addr    => (X"000003d4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_245_addr    => (X"000003d8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_246_addr    => (X"000003dc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_247_addr    => (X"000003e0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_248_addr    => (X"000003e4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_249_addr    => (X"000003e8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_250_addr    => (X"000003ec",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_251_addr    => (X"000003f0",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_252_addr    => (X"000003f4",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_253_addr    => (X"000003f8",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_254_addr    => (X"000003fc",31, 0,X"00000000",async_reset,X"000007fc",rw),
      mcast_addr_255_addr    => (X"00000400",31, 0,X"00000000",async_reset,X"00000400",rw)
   );

   --##########################################################################
   --
   -- Constants
   --
   --##########################################################################
   constant c_nof_register_blocks: integer := 1;
   constant c_nof_memory_blocks: integer := 0;
   constant c_total_nof_blocks: integer := c_nof_memory_blocks+c_nof_register_blocks;
   
   type t_ipb_igmp_mode_control_mosi_arr is array (0 to c_total_nof_blocks-1) of t_ipb_mosi;
   type t_ipb_igmp_mode_control_miso_arr is array (0 to c_total_nof_blocks-1) of t_ipb_miso;
   


   --##########################################################################
   --
   -- Functions
   --
   --##########################################################################
   function axi4lite_igmp_mode_control_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean;
   
   function axi4lite_igmp_mode_control_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_igmp_mode_control_decoded;
   
   procedure axi4lite_igmp_mode_control_reset(signal igmp_mode_control: inout t_axi4lite_igmp_mode_control);
   procedure axi4lite_igmp_mode_control_default_decoded(signal igmp_mode_control: inout t_axi4lite_igmp_mode_control_decoded);
   procedure axi4lite_igmp_mode_control_write_reg(data: std_logic_vector; 
                                          signal igmp_mode_control_decoded: in t_axi4lite_igmp_mode_control_decoded;
                                          signal igmp_mode_control: inout t_axi4lite_igmp_mode_control);
   
   function axi4lite_igmp_mode_control_read_reg(signal igmp_mode_control_decoded: in t_axi4lite_igmp_mode_control_decoded;
                                        signal igmp_mode_control: t_axi4lite_igmp_mode_control) return std_logic_vector;
   
   function axi4lite_igmp_mode_control_demux(addr: std_logic_vector) return std_logic_vector;

end package;

package body axi4lite_igmp_mode_control_pkg is
   
   function axi4lite_igmp_mode_control_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean is
      variable ret: boolean:=true;
      variable bus_addr_i: std_logic_vector(addr'length-1 downto 0) := addr;
      variable mask_i: std_logic_vector(descr.decoder_mask'length-1 downto 0) := descr.decoder_mask;
      variable reg_addr_i: std_logic_vector(descr.offset'length-1 downto 0) := descr.offset;
   begin
      for n in 0 to bus_addr_i'length-1 loop
         if mask_i(n) = '1' and bus_addr_i(n) /= reg_addr_i(n) then
            ret := false;
         end if;
      end loop;
      return ret;
   end function;
   
   function axi4lite_igmp_mode_control_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_igmp_mode_control_decoded is
      variable igmp_mode_control_decoded: t_axi4lite_igmp_mode_control_decoded;
   begin
   
      igmp_mode_control_decoded.igmp_control.igmp_en := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.igmp_control_igmp_en,addr) = true and en = '1' then
         igmp_mode_control_decoded.igmp_control.igmp_en := '1';
      end if;
      
      igmp_mode_control_decoded.igmp_control.igmp_ver := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.igmp_control_igmp_ver,addr) = true and en = '1' then
         igmp_mode_control_decoded.igmp_control.igmp_ver := '1';
      end if;
      
      igmp_mode_control_decoded.igmp_control.igmp_sub := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.igmp_control_igmp_sub,addr) = true and en = '1' then
         igmp_mode_control_decoded.igmp_control.igmp_sub := '1';
      end if;
      
      igmp_mode_control_decoded.igmp_control.igmp_rst := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.igmp_control_igmp_rst,addr) = true and en = '1' then
         igmp_mode_control_decoded.igmp_control.igmp_rst := '1';
      end if;
      
      igmp_mode_control_decoded.igmp_control.igmp_num := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.igmp_control_igmp_num,addr) = true and en = '1' then
         igmp_mode_control_decoded.igmp_control.igmp_num := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(0) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_0_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(0) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(1) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_1_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(1) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(2) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_2_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(2) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(3) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_3_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(3) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(4) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_4_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(4) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(5) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_5_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(5) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(6) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_6_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(6) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(7) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_7_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(7) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(8) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_8_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(8) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(9) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_9_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(9) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(10) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_10_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(10) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(11) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_11_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(11) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(12) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_12_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(12) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(13) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_13_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(13) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(14) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_14_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(14) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(15) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_15_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(15) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(16) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_16_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(16) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(17) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_17_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(17) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(18) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_18_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(18) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(19) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_19_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(19) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(20) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_20_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(20) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(21) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_21_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(21) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(22) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_22_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(22) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(23) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_23_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(23) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(24) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_24_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(24) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(25) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_25_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(25) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(26) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_26_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(26) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(27) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_27_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(27) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(28) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_28_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(28) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(29) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_29_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(29) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(30) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_30_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(30) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(31) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_31_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(31) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(32) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_32_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(32) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(33) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_33_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(33) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(34) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_34_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(34) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(35) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_35_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(35) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(36) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_36_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(36) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(37) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_37_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(37) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(38) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_38_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(38) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(39) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_39_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(39) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(40) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_40_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(40) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(41) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_41_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(41) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(42) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_42_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(42) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(43) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_43_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(43) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(44) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_44_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(44) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(45) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_45_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(45) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(46) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_46_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(46) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(47) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_47_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(47) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(48) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_48_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(48) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(49) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_49_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(49) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(50) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_50_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(50) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(51) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_51_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(51) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(52) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_52_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(52) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(53) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_53_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(53) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(54) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_54_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(54) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(55) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_55_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(55) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(56) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_56_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(56) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(57) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_57_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(57) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(58) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_58_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(58) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(59) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_59_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(59) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(60) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_60_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(60) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(61) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_61_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(61) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(62) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_62_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(62) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(63) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_63_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(63) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(64) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_64_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(64) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(65) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_65_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(65) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(66) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_66_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(66) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(67) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_67_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(67) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(68) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_68_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(68) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(69) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_69_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(69) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(70) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_70_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(70) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(71) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_71_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(71) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(72) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_72_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(72) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(73) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_73_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(73) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(74) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_74_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(74) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(75) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_75_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(75) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(76) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_76_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(76) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(77) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_77_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(77) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(78) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_78_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(78) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(79) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_79_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(79) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(80) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_80_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(80) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(81) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_81_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(81) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(82) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_82_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(82) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(83) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_83_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(83) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(84) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_84_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(84) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(85) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_85_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(85) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(86) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_86_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(86) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(87) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_87_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(87) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(88) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_88_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(88) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(89) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_89_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(89) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(90) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_90_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(90) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(91) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_91_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(91) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(92) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_92_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(92) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(93) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_93_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(93) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(94) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_94_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(94) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(95) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_95_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(95) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(96) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_96_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(96) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(97) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_97_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(97) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(98) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_98_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(98) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(99) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_99_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(99) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(100) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_100_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(100) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(101) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_101_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(101) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(102) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_102_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(102) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(103) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_103_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(103) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(104) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_104_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(104) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(105) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_105_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(105) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(106) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_106_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(106) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(107) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_107_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(107) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(108) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_108_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(108) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(109) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_109_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(109) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(110) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_110_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(110) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(111) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_111_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(111) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(112) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_112_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(112) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(113) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_113_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(113) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(114) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_114_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(114) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(115) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_115_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(115) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(116) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_116_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(116) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(117) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_117_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(117) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(118) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_118_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(118) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(119) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_119_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(119) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(120) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_120_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(120) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(121) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_121_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(121) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(122) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_122_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(122) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(123) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_123_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(123) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(124) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_124_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(124) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(125) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_125_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(125) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(126) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_126_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(126) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(127) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_127_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(127) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(128) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_128_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(128) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(129) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_129_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(129) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(130) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_130_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(130) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(131) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_131_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(131) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(132) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_132_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(132) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(133) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_133_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(133) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(134) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_134_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(134) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(135) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_135_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(135) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(136) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_136_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(136) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(137) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_137_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(137) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(138) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_138_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(138) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(139) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_139_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(139) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(140) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_140_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(140) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(141) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_141_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(141) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(142) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_142_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(142) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(143) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_143_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(143) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(144) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_144_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(144) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(145) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_145_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(145) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(146) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_146_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(146) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(147) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_147_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(147) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(148) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_148_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(148) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(149) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_149_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(149) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(150) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_150_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(150) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(151) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_151_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(151) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(152) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_152_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(152) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(153) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_153_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(153) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(154) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_154_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(154) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(155) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_155_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(155) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(156) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_156_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(156) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(157) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_157_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(157) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(158) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_158_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(158) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(159) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_159_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(159) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(160) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_160_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(160) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(161) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_161_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(161) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(162) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_162_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(162) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(163) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_163_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(163) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(164) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_164_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(164) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(165) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_165_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(165) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(166) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_166_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(166) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(167) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_167_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(167) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(168) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_168_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(168) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(169) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_169_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(169) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(170) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_170_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(170) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(171) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_171_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(171) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(172) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_172_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(172) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(173) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_173_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(173) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(174) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_174_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(174) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(175) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_175_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(175) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(176) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_176_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(176) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(177) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_177_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(177) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(178) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_178_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(178) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(179) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_179_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(179) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(180) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_180_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(180) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(181) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_181_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(181) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(182) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_182_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(182) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(183) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_183_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(183) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(184) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_184_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(184) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(185) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_185_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(185) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(186) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_186_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(186) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(187) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_187_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(187) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(188) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_188_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(188) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(189) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_189_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(189) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(190) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_190_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(190) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(191) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_191_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(191) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(192) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_192_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(192) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(193) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_193_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(193) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(194) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_194_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(194) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(195) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_195_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(195) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(196) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_196_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(196) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(197) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_197_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(197) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(198) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_198_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(198) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(199) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_199_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(199) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(200) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_200_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(200) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(201) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_201_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(201) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(202) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_202_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(202) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(203) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_203_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(203) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(204) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_204_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(204) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(205) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_205_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(205) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(206) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_206_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(206) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(207) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_207_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(207) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(208) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_208_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(208) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(209) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_209_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(209) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(210) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_210_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(210) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(211) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_211_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(211) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(212) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_212_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(212) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(213) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_213_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(213) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(214) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_214_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(214) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(215) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_215_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(215) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(216) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_216_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(216) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(217) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_217_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(217) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(218) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_218_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(218) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(219) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_219_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(219) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(220) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_220_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(220) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(221) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_221_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(221) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(222) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_222_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(222) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(223) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_223_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(223) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(224) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_224_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(224) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(225) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_225_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(225) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(226) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_226_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(226) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(227) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_227_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(227) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(228) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_228_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(228) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(229) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_229_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(229) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(230) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_230_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(230) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(231) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_231_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(231) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(232) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_232_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(232) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(233) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_233_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(233) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(234) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_234_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(234) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(235) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_235_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(235) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(236) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_236_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(236) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(237) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_237_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(237) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(238) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_238_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(238) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(239) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_239_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(239) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(240) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_240_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(240) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(241) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_241_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(241) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(242) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_242_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(242) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(243) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_243_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(243) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(244) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_244_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(244) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(245) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_245_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(245) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(246) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_246_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(246) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(247) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_247_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(247) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(248) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_248_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(248) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(249) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_249_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(249) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(250) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_250_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(250) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(251) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_251_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(251) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(252) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_252_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(252) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(253) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_253_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(253) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(254) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_254_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(254) := '1';
      end if;
      
      igmp_mode_control_decoded.mcast_addr(255) := '0';
      if axi4lite_igmp_mode_control_decoder(axi4lite_igmp_mode_control_descr.mcast_addr_255_addr,addr) = true and en = '1' then
         igmp_mode_control_decoded.mcast_addr(255) := '1';
      end if;
      
      
      return igmp_mode_control_decoded;
   end function;
     
   procedure axi4lite_igmp_mode_control_reset(signal igmp_mode_control: inout t_axi4lite_igmp_mode_control) is
   begin
      
      igmp_mode_control.igmp_control.igmp_en <= axi4lite_igmp_mode_control_descr.igmp_control_igmp_en.rst_val(0);
      igmp_mode_control.igmp_control.igmp_ver <= axi4lite_igmp_mode_control_descr.igmp_control_igmp_ver.rst_val(1 downto 0);
      igmp_mode_control.igmp_control.igmp_sub <= axi4lite_igmp_mode_control_descr.igmp_control_igmp_sub.rst_val(0);
      igmp_mode_control.igmp_control.igmp_rst <= axi4lite_igmp_mode_control_descr.igmp_control_igmp_rst.rst_val(0);
      igmp_mode_control.igmp_control.igmp_num <= axi4lite_igmp_mode_control_descr.igmp_control_igmp_num.rst_val(7 downto 0);
      igmp_mode_control.mcast_addr(0) <= axi4lite_igmp_mode_control_descr.mcast_addr_0_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(1) <= axi4lite_igmp_mode_control_descr.mcast_addr_1_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(2) <= axi4lite_igmp_mode_control_descr.mcast_addr_2_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(3) <= axi4lite_igmp_mode_control_descr.mcast_addr_3_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(4) <= axi4lite_igmp_mode_control_descr.mcast_addr_4_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(5) <= axi4lite_igmp_mode_control_descr.mcast_addr_5_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(6) <= axi4lite_igmp_mode_control_descr.mcast_addr_6_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(7) <= axi4lite_igmp_mode_control_descr.mcast_addr_7_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(8) <= axi4lite_igmp_mode_control_descr.mcast_addr_8_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(9) <= axi4lite_igmp_mode_control_descr.mcast_addr_9_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(10) <= axi4lite_igmp_mode_control_descr.mcast_addr_10_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(11) <= axi4lite_igmp_mode_control_descr.mcast_addr_11_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(12) <= axi4lite_igmp_mode_control_descr.mcast_addr_12_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(13) <= axi4lite_igmp_mode_control_descr.mcast_addr_13_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(14) <= axi4lite_igmp_mode_control_descr.mcast_addr_14_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(15) <= axi4lite_igmp_mode_control_descr.mcast_addr_15_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(16) <= axi4lite_igmp_mode_control_descr.mcast_addr_16_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(17) <= axi4lite_igmp_mode_control_descr.mcast_addr_17_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(18) <= axi4lite_igmp_mode_control_descr.mcast_addr_18_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(19) <= axi4lite_igmp_mode_control_descr.mcast_addr_19_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(20) <= axi4lite_igmp_mode_control_descr.mcast_addr_20_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(21) <= axi4lite_igmp_mode_control_descr.mcast_addr_21_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(22) <= axi4lite_igmp_mode_control_descr.mcast_addr_22_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(23) <= axi4lite_igmp_mode_control_descr.mcast_addr_23_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(24) <= axi4lite_igmp_mode_control_descr.mcast_addr_24_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(25) <= axi4lite_igmp_mode_control_descr.mcast_addr_25_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(26) <= axi4lite_igmp_mode_control_descr.mcast_addr_26_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(27) <= axi4lite_igmp_mode_control_descr.mcast_addr_27_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(28) <= axi4lite_igmp_mode_control_descr.mcast_addr_28_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(29) <= axi4lite_igmp_mode_control_descr.mcast_addr_29_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(30) <= axi4lite_igmp_mode_control_descr.mcast_addr_30_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(31) <= axi4lite_igmp_mode_control_descr.mcast_addr_31_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(32) <= axi4lite_igmp_mode_control_descr.mcast_addr_32_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(33) <= axi4lite_igmp_mode_control_descr.mcast_addr_33_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(34) <= axi4lite_igmp_mode_control_descr.mcast_addr_34_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(35) <= axi4lite_igmp_mode_control_descr.mcast_addr_35_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(36) <= axi4lite_igmp_mode_control_descr.mcast_addr_36_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(37) <= axi4lite_igmp_mode_control_descr.mcast_addr_37_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(38) <= axi4lite_igmp_mode_control_descr.mcast_addr_38_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(39) <= axi4lite_igmp_mode_control_descr.mcast_addr_39_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(40) <= axi4lite_igmp_mode_control_descr.mcast_addr_40_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(41) <= axi4lite_igmp_mode_control_descr.mcast_addr_41_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(42) <= axi4lite_igmp_mode_control_descr.mcast_addr_42_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(43) <= axi4lite_igmp_mode_control_descr.mcast_addr_43_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(44) <= axi4lite_igmp_mode_control_descr.mcast_addr_44_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(45) <= axi4lite_igmp_mode_control_descr.mcast_addr_45_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(46) <= axi4lite_igmp_mode_control_descr.mcast_addr_46_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(47) <= axi4lite_igmp_mode_control_descr.mcast_addr_47_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(48) <= axi4lite_igmp_mode_control_descr.mcast_addr_48_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(49) <= axi4lite_igmp_mode_control_descr.mcast_addr_49_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(50) <= axi4lite_igmp_mode_control_descr.mcast_addr_50_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(51) <= axi4lite_igmp_mode_control_descr.mcast_addr_51_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(52) <= axi4lite_igmp_mode_control_descr.mcast_addr_52_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(53) <= axi4lite_igmp_mode_control_descr.mcast_addr_53_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(54) <= axi4lite_igmp_mode_control_descr.mcast_addr_54_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(55) <= axi4lite_igmp_mode_control_descr.mcast_addr_55_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(56) <= axi4lite_igmp_mode_control_descr.mcast_addr_56_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(57) <= axi4lite_igmp_mode_control_descr.mcast_addr_57_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(58) <= axi4lite_igmp_mode_control_descr.mcast_addr_58_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(59) <= axi4lite_igmp_mode_control_descr.mcast_addr_59_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(60) <= axi4lite_igmp_mode_control_descr.mcast_addr_60_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(61) <= axi4lite_igmp_mode_control_descr.mcast_addr_61_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(62) <= axi4lite_igmp_mode_control_descr.mcast_addr_62_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(63) <= axi4lite_igmp_mode_control_descr.mcast_addr_63_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(64) <= axi4lite_igmp_mode_control_descr.mcast_addr_64_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(65) <= axi4lite_igmp_mode_control_descr.mcast_addr_65_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(66) <= axi4lite_igmp_mode_control_descr.mcast_addr_66_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(67) <= axi4lite_igmp_mode_control_descr.mcast_addr_67_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(68) <= axi4lite_igmp_mode_control_descr.mcast_addr_68_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(69) <= axi4lite_igmp_mode_control_descr.mcast_addr_69_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(70) <= axi4lite_igmp_mode_control_descr.mcast_addr_70_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(71) <= axi4lite_igmp_mode_control_descr.mcast_addr_71_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(72) <= axi4lite_igmp_mode_control_descr.mcast_addr_72_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(73) <= axi4lite_igmp_mode_control_descr.mcast_addr_73_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(74) <= axi4lite_igmp_mode_control_descr.mcast_addr_74_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(75) <= axi4lite_igmp_mode_control_descr.mcast_addr_75_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(76) <= axi4lite_igmp_mode_control_descr.mcast_addr_76_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(77) <= axi4lite_igmp_mode_control_descr.mcast_addr_77_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(78) <= axi4lite_igmp_mode_control_descr.mcast_addr_78_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(79) <= axi4lite_igmp_mode_control_descr.mcast_addr_79_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(80) <= axi4lite_igmp_mode_control_descr.mcast_addr_80_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(81) <= axi4lite_igmp_mode_control_descr.mcast_addr_81_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(82) <= axi4lite_igmp_mode_control_descr.mcast_addr_82_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(83) <= axi4lite_igmp_mode_control_descr.mcast_addr_83_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(84) <= axi4lite_igmp_mode_control_descr.mcast_addr_84_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(85) <= axi4lite_igmp_mode_control_descr.mcast_addr_85_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(86) <= axi4lite_igmp_mode_control_descr.mcast_addr_86_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(87) <= axi4lite_igmp_mode_control_descr.mcast_addr_87_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(88) <= axi4lite_igmp_mode_control_descr.mcast_addr_88_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(89) <= axi4lite_igmp_mode_control_descr.mcast_addr_89_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(90) <= axi4lite_igmp_mode_control_descr.mcast_addr_90_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(91) <= axi4lite_igmp_mode_control_descr.mcast_addr_91_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(92) <= axi4lite_igmp_mode_control_descr.mcast_addr_92_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(93) <= axi4lite_igmp_mode_control_descr.mcast_addr_93_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(94) <= axi4lite_igmp_mode_control_descr.mcast_addr_94_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(95) <= axi4lite_igmp_mode_control_descr.mcast_addr_95_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(96) <= axi4lite_igmp_mode_control_descr.mcast_addr_96_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(97) <= axi4lite_igmp_mode_control_descr.mcast_addr_97_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(98) <= axi4lite_igmp_mode_control_descr.mcast_addr_98_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(99) <= axi4lite_igmp_mode_control_descr.mcast_addr_99_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(100) <= axi4lite_igmp_mode_control_descr.mcast_addr_100_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(101) <= axi4lite_igmp_mode_control_descr.mcast_addr_101_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(102) <= axi4lite_igmp_mode_control_descr.mcast_addr_102_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(103) <= axi4lite_igmp_mode_control_descr.mcast_addr_103_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(104) <= axi4lite_igmp_mode_control_descr.mcast_addr_104_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(105) <= axi4lite_igmp_mode_control_descr.mcast_addr_105_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(106) <= axi4lite_igmp_mode_control_descr.mcast_addr_106_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(107) <= axi4lite_igmp_mode_control_descr.mcast_addr_107_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(108) <= axi4lite_igmp_mode_control_descr.mcast_addr_108_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(109) <= axi4lite_igmp_mode_control_descr.mcast_addr_109_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(110) <= axi4lite_igmp_mode_control_descr.mcast_addr_110_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(111) <= axi4lite_igmp_mode_control_descr.mcast_addr_111_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(112) <= axi4lite_igmp_mode_control_descr.mcast_addr_112_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(113) <= axi4lite_igmp_mode_control_descr.mcast_addr_113_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(114) <= axi4lite_igmp_mode_control_descr.mcast_addr_114_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(115) <= axi4lite_igmp_mode_control_descr.mcast_addr_115_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(116) <= axi4lite_igmp_mode_control_descr.mcast_addr_116_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(117) <= axi4lite_igmp_mode_control_descr.mcast_addr_117_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(118) <= axi4lite_igmp_mode_control_descr.mcast_addr_118_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(119) <= axi4lite_igmp_mode_control_descr.mcast_addr_119_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(120) <= axi4lite_igmp_mode_control_descr.mcast_addr_120_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(121) <= axi4lite_igmp_mode_control_descr.mcast_addr_121_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(122) <= axi4lite_igmp_mode_control_descr.mcast_addr_122_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(123) <= axi4lite_igmp_mode_control_descr.mcast_addr_123_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(124) <= axi4lite_igmp_mode_control_descr.mcast_addr_124_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(125) <= axi4lite_igmp_mode_control_descr.mcast_addr_125_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(126) <= axi4lite_igmp_mode_control_descr.mcast_addr_126_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(127) <= axi4lite_igmp_mode_control_descr.mcast_addr_127_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(128) <= axi4lite_igmp_mode_control_descr.mcast_addr_128_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(129) <= axi4lite_igmp_mode_control_descr.mcast_addr_129_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(130) <= axi4lite_igmp_mode_control_descr.mcast_addr_130_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(131) <= axi4lite_igmp_mode_control_descr.mcast_addr_131_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(132) <= axi4lite_igmp_mode_control_descr.mcast_addr_132_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(133) <= axi4lite_igmp_mode_control_descr.mcast_addr_133_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(134) <= axi4lite_igmp_mode_control_descr.mcast_addr_134_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(135) <= axi4lite_igmp_mode_control_descr.mcast_addr_135_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(136) <= axi4lite_igmp_mode_control_descr.mcast_addr_136_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(137) <= axi4lite_igmp_mode_control_descr.mcast_addr_137_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(138) <= axi4lite_igmp_mode_control_descr.mcast_addr_138_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(139) <= axi4lite_igmp_mode_control_descr.mcast_addr_139_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(140) <= axi4lite_igmp_mode_control_descr.mcast_addr_140_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(141) <= axi4lite_igmp_mode_control_descr.mcast_addr_141_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(142) <= axi4lite_igmp_mode_control_descr.mcast_addr_142_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(143) <= axi4lite_igmp_mode_control_descr.mcast_addr_143_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(144) <= axi4lite_igmp_mode_control_descr.mcast_addr_144_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(145) <= axi4lite_igmp_mode_control_descr.mcast_addr_145_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(146) <= axi4lite_igmp_mode_control_descr.mcast_addr_146_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(147) <= axi4lite_igmp_mode_control_descr.mcast_addr_147_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(148) <= axi4lite_igmp_mode_control_descr.mcast_addr_148_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(149) <= axi4lite_igmp_mode_control_descr.mcast_addr_149_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(150) <= axi4lite_igmp_mode_control_descr.mcast_addr_150_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(151) <= axi4lite_igmp_mode_control_descr.mcast_addr_151_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(152) <= axi4lite_igmp_mode_control_descr.mcast_addr_152_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(153) <= axi4lite_igmp_mode_control_descr.mcast_addr_153_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(154) <= axi4lite_igmp_mode_control_descr.mcast_addr_154_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(155) <= axi4lite_igmp_mode_control_descr.mcast_addr_155_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(156) <= axi4lite_igmp_mode_control_descr.mcast_addr_156_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(157) <= axi4lite_igmp_mode_control_descr.mcast_addr_157_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(158) <= axi4lite_igmp_mode_control_descr.mcast_addr_158_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(159) <= axi4lite_igmp_mode_control_descr.mcast_addr_159_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(160) <= axi4lite_igmp_mode_control_descr.mcast_addr_160_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(161) <= axi4lite_igmp_mode_control_descr.mcast_addr_161_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(162) <= axi4lite_igmp_mode_control_descr.mcast_addr_162_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(163) <= axi4lite_igmp_mode_control_descr.mcast_addr_163_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(164) <= axi4lite_igmp_mode_control_descr.mcast_addr_164_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(165) <= axi4lite_igmp_mode_control_descr.mcast_addr_165_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(166) <= axi4lite_igmp_mode_control_descr.mcast_addr_166_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(167) <= axi4lite_igmp_mode_control_descr.mcast_addr_167_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(168) <= axi4lite_igmp_mode_control_descr.mcast_addr_168_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(169) <= axi4lite_igmp_mode_control_descr.mcast_addr_169_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(170) <= axi4lite_igmp_mode_control_descr.mcast_addr_170_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(171) <= axi4lite_igmp_mode_control_descr.mcast_addr_171_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(172) <= axi4lite_igmp_mode_control_descr.mcast_addr_172_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(173) <= axi4lite_igmp_mode_control_descr.mcast_addr_173_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(174) <= axi4lite_igmp_mode_control_descr.mcast_addr_174_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(175) <= axi4lite_igmp_mode_control_descr.mcast_addr_175_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(176) <= axi4lite_igmp_mode_control_descr.mcast_addr_176_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(177) <= axi4lite_igmp_mode_control_descr.mcast_addr_177_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(178) <= axi4lite_igmp_mode_control_descr.mcast_addr_178_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(179) <= axi4lite_igmp_mode_control_descr.mcast_addr_179_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(180) <= axi4lite_igmp_mode_control_descr.mcast_addr_180_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(181) <= axi4lite_igmp_mode_control_descr.mcast_addr_181_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(182) <= axi4lite_igmp_mode_control_descr.mcast_addr_182_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(183) <= axi4lite_igmp_mode_control_descr.mcast_addr_183_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(184) <= axi4lite_igmp_mode_control_descr.mcast_addr_184_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(185) <= axi4lite_igmp_mode_control_descr.mcast_addr_185_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(186) <= axi4lite_igmp_mode_control_descr.mcast_addr_186_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(187) <= axi4lite_igmp_mode_control_descr.mcast_addr_187_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(188) <= axi4lite_igmp_mode_control_descr.mcast_addr_188_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(189) <= axi4lite_igmp_mode_control_descr.mcast_addr_189_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(190) <= axi4lite_igmp_mode_control_descr.mcast_addr_190_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(191) <= axi4lite_igmp_mode_control_descr.mcast_addr_191_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(192) <= axi4lite_igmp_mode_control_descr.mcast_addr_192_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(193) <= axi4lite_igmp_mode_control_descr.mcast_addr_193_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(194) <= axi4lite_igmp_mode_control_descr.mcast_addr_194_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(195) <= axi4lite_igmp_mode_control_descr.mcast_addr_195_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(196) <= axi4lite_igmp_mode_control_descr.mcast_addr_196_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(197) <= axi4lite_igmp_mode_control_descr.mcast_addr_197_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(198) <= axi4lite_igmp_mode_control_descr.mcast_addr_198_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(199) <= axi4lite_igmp_mode_control_descr.mcast_addr_199_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(200) <= axi4lite_igmp_mode_control_descr.mcast_addr_200_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(201) <= axi4lite_igmp_mode_control_descr.mcast_addr_201_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(202) <= axi4lite_igmp_mode_control_descr.mcast_addr_202_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(203) <= axi4lite_igmp_mode_control_descr.mcast_addr_203_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(204) <= axi4lite_igmp_mode_control_descr.mcast_addr_204_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(205) <= axi4lite_igmp_mode_control_descr.mcast_addr_205_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(206) <= axi4lite_igmp_mode_control_descr.mcast_addr_206_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(207) <= axi4lite_igmp_mode_control_descr.mcast_addr_207_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(208) <= axi4lite_igmp_mode_control_descr.mcast_addr_208_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(209) <= axi4lite_igmp_mode_control_descr.mcast_addr_209_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(210) <= axi4lite_igmp_mode_control_descr.mcast_addr_210_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(211) <= axi4lite_igmp_mode_control_descr.mcast_addr_211_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(212) <= axi4lite_igmp_mode_control_descr.mcast_addr_212_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(213) <= axi4lite_igmp_mode_control_descr.mcast_addr_213_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(214) <= axi4lite_igmp_mode_control_descr.mcast_addr_214_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(215) <= axi4lite_igmp_mode_control_descr.mcast_addr_215_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(216) <= axi4lite_igmp_mode_control_descr.mcast_addr_216_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(217) <= axi4lite_igmp_mode_control_descr.mcast_addr_217_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(218) <= axi4lite_igmp_mode_control_descr.mcast_addr_218_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(219) <= axi4lite_igmp_mode_control_descr.mcast_addr_219_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(220) <= axi4lite_igmp_mode_control_descr.mcast_addr_220_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(221) <= axi4lite_igmp_mode_control_descr.mcast_addr_221_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(222) <= axi4lite_igmp_mode_control_descr.mcast_addr_222_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(223) <= axi4lite_igmp_mode_control_descr.mcast_addr_223_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(224) <= axi4lite_igmp_mode_control_descr.mcast_addr_224_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(225) <= axi4lite_igmp_mode_control_descr.mcast_addr_225_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(226) <= axi4lite_igmp_mode_control_descr.mcast_addr_226_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(227) <= axi4lite_igmp_mode_control_descr.mcast_addr_227_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(228) <= axi4lite_igmp_mode_control_descr.mcast_addr_228_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(229) <= axi4lite_igmp_mode_control_descr.mcast_addr_229_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(230) <= axi4lite_igmp_mode_control_descr.mcast_addr_230_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(231) <= axi4lite_igmp_mode_control_descr.mcast_addr_231_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(232) <= axi4lite_igmp_mode_control_descr.mcast_addr_232_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(233) <= axi4lite_igmp_mode_control_descr.mcast_addr_233_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(234) <= axi4lite_igmp_mode_control_descr.mcast_addr_234_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(235) <= axi4lite_igmp_mode_control_descr.mcast_addr_235_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(236) <= axi4lite_igmp_mode_control_descr.mcast_addr_236_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(237) <= axi4lite_igmp_mode_control_descr.mcast_addr_237_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(238) <= axi4lite_igmp_mode_control_descr.mcast_addr_238_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(239) <= axi4lite_igmp_mode_control_descr.mcast_addr_239_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(240) <= axi4lite_igmp_mode_control_descr.mcast_addr_240_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(241) <= axi4lite_igmp_mode_control_descr.mcast_addr_241_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(242) <= axi4lite_igmp_mode_control_descr.mcast_addr_242_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(243) <= axi4lite_igmp_mode_control_descr.mcast_addr_243_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(244) <= axi4lite_igmp_mode_control_descr.mcast_addr_244_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(245) <= axi4lite_igmp_mode_control_descr.mcast_addr_245_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(246) <= axi4lite_igmp_mode_control_descr.mcast_addr_246_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(247) <= axi4lite_igmp_mode_control_descr.mcast_addr_247_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(248) <= axi4lite_igmp_mode_control_descr.mcast_addr_248_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(249) <= axi4lite_igmp_mode_control_descr.mcast_addr_249_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(250) <= axi4lite_igmp_mode_control_descr.mcast_addr_250_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(251) <= axi4lite_igmp_mode_control_descr.mcast_addr_251_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(252) <= axi4lite_igmp_mode_control_descr.mcast_addr_252_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(253) <= axi4lite_igmp_mode_control_descr.mcast_addr_253_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(254) <= axi4lite_igmp_mode_control_descr.mcast_addr_254_addr.rst_val(31 downto 0);
      igmp_mode_control.mcast_addr(255) <= axi4lite_igmp_mode_control_descr.mcast_addr_255_addr.rst_val(31 downto 0);

   end procedure;
   
   procedure axi4lite_igmp_mode_control_default_decoded(signal igmp_mode_control: inout t_axi4lite_igmp_mode_control_decoded) is
   begin
      
      igmp_mode_control.igmp_control.igmp_en <= '0';
      igmp_mode_control.igmp_control.igmp_ver <= '0';
      igmp_mode_control.igmp_control.igmp_sub <= '0';
      igmp_mode_control.igmp_control.igmp_rst <= '0';
      igmp_mode_control.igmp_control.igmp_num <= '0';
      igmp_mode_control.mcast_addr(0) <= '0';
      igmp_mode_control.mcast_addr(1) <= '0';
      igmp_mode_control.mcast_addr(2) <= '0';
      igmp_mode_control.mcast_addr(3) <= '0';
      igmp_mode_control.mcast_addr(4) <= '0';
      igmp_mode_control.mcast_addr(5) <= '0';
      igmp_mode_control.mcast_addr(6) <= '0';
      igmp_mode_control.mcast_addr(7) <= '0';
      igmp_mode_control.mcast_addr(8) <= '0';
      igmp_mode_control.mcast_addr(9) <= '0';
      igmp_mode_control.mcast_addr(10) <= '0';
      igmp_mode_control.mcast_addr(11) <= '0';
      igmp_mode_control.mcast_addr(12) <= '0';
      igmp_mode_control.mcast_addr(13) <= '0';
      igmp_mode_control.mcast_addr(14) <= '0';
      igmp_mode_control.mcast_addr(15) <= '0';
      igmp_mode_control.mcast_addr(16) <= '0';
      igmp_mode_control.mcast_addr(17) <= '0';
      igmp_mode_control.mcast_addr(18) <= '0';
      igmp_mode_control.mcast_addr(19) <= '0';
      igmp_mode_control.mcast_addr(20) <= '0';
      igmp_mode_control.mcast_addr(21) <= '0';
      igmp_mode_control.mcast_addr(22) <= '0';
      igmp_mode_control.mcast_addr(23) <= '0';
      igmp_mode_control.mcast_addr(24) <= '0';
      igmp_mode_control.mcast_addr(25) <= '0';
      igmp_mode_control.mcast_addr(26) <= '0';
      igmp_mode_control.mcast_addr(27) <= '0';
      igmp_mode_control.mcast_addr(28) <= '0';
      igmp_mode_control.mcast_addr(29) <= '0';
      igmp_mode_control.mcast_addr(30) <= '0';
      igmp_mode_control.mcast_addr(31) <= '0';
      igmp_mode_control.mcast_addr(32) <= '0';
      igmp_mode_control.mcast_addr(33) <= '0';
      igmp_mode_control.mcast_addr(34) <= '0';
      igmp_mode_control.mcast_addr(35) <= '0';
      igmp_mode_control.mcast_addr(36) <= '0';
      igmp_mode_control.mcast_addr(37) <= '0';
      igmp_mode_control.mcast_addr(38) <= '0';
      igmp_mode_control.mcast_addr(39) <= '0';
      igmp_mode_control.mcast_addr(40) <= '0';
      igmp_mode_control.mcast_addr(41) <= '0';
      igmp_mode_control.mcast_addr(42) <= '0';
      igmp_mode_control.mcast_addr(43) <= '0';
      igmp_mode_control.mcast_addr(44) <= '0';
      igmp_mode_control.mcast_addr(45) <= '0';
      igmp_mode_control.mcast_addr(46) <= '0';
      igmp_mode_control.mcast_addr(47) <= '0';
      igmp_mode_control.mcast_addr(48) <= '0';
      igmp_mode_control.mcast_addr(49) <= '0';
      igmp_mode_control.mcast_addr(50) <= '0';
      igmp_mode_control.mcast_addr(51) <= '0';
      igmp_mode_control.mcast_addr(52) <= '0';
      igmp_mode_control.mcast_addr(53) <= '0';
      igmp_mode_control.mcast_addr(54) <= '0';
      igmp_mode_control.mcast_addr(55) <= '0';
      igmp_mode_control.mcast_addr(56) <= '0';
      igmp_mode_control.mcast_addr(57) <= '0';
      igmp_mode_control.mcast_addr(58) <= '0';
      igmp_mode_control.mcast_addr(59) <= '0';
      igmp_mode_control.mcast_addr(60) <= '0';
      igmp_mode_control.mcast_addr(61) <= '0';
      igmp_mode_control.mcast_addr(62) <= '0';
      igmp_mode_control.mcast_addr(63) <= '0';
      igmp_mode_control.mcast_addr(64) <= '0';
      igmp_mode_control.mcast_addr(65) <= '0';
      igmp_mode_control.mcast_addr(66) <= '0';
      igmp_mode_control.mcast_addr(67) <= '0';
      igmp_mode_control.mcast_addr(68) <= '0';
      igmp_mode_control.mcast_addr(69) <= '0';
      igmp_mode_control.mcast_addr(70) <= '0';
      igmp_mode_control.mcast_addr(71) <= '0';
      igmp_mode_control.mcast_addr(72) <= '0';
      igmp_mode_control.mcast_addr(73) <= '0';
      igmp_mode_control.mcast_addr(74) <= '0';
      igmp_mode_control.mcast_addr(75) <= '0';
      igmp_mode_control.mcast_addr(76) <= '0';
      igmp_mode_control.mcast_addr(77) <= '0';
      igmp_mode_control.mcast_addr(78) <= '0';
      igmp_mode_control.mcast_addr(79) <= '0';
      igmp_mode_control.mcast_addr(80) <= '0';
      igmp_mode_control.mcast_addr(81) <= '0';
      igmp_mode_control.mcast_addr(82) <= '0';
      igmp_mode_control.mcast_addr(83) <= '0';
      igmp_mode_control.mcast_addr(84) <= '0';
      igmp_mode_control.mcast_addr(85) <= '0';
      igmp_mode_control.mcast_addr(86) <= '0';
      igmp_mode_control.mcast_addr(87) <= '0';
      igmp_mode_control.mcast_addr(88) <= '0';
      igmp_mode_control.mcast_addr(89) <= '0';
      igmp_mode_control.mcast_addr(90) <= '0';
      igmp_mode_control.mcast_addr(91) <= '0';
      igmp_mode_control.mcast_addr(92) <= '0';
      igmp_mode_control.mcast_addr(93) <= '0';
      igmp_mode_control.mcast_addr(94) <= '0';
      igmp_mode_control.mcast_addr(95) <= '0';
      igmp_mode_control.mcast_addr(96) <= '0';
      igmp_mode_control.mcast_addr(97) <= '0';
      igmp_mode_control.mcast_addr(98) <= '0';
      igmp_mode_control.mcast_addr(99) <= '0';
      igmp_mode_control.mcast_addr(100) <= '0';
      igmp_mode_control.mcast_addr(101) <= '0';
      igmp_mode_control.mcast_addr(102) <= '0';
      igmp_mode_control.mcast_addr(103) <= '0';
      igmp_mode_control.mcast_addr(104) <= '0';
      igmp_mode_control.mcast_addr(105) <= '0';
      igmp_mode_control.mcast_addr(106) <= '0';
      igmp_mode_control.mcast_addr(107) <= '0';
      igmp_mode_control.mcast_addr(108) <= '0';
      igmp_mode_control.mcast_addr(109) <= '0';
      igmp_mode_control.mcast_addr(110) <= '0';
      igmp_mode_control.mcast_addr(111) <= '0';
      igmp_mode_control.mcast_addr(112) <= '0';
      igmp_mode_control.mcast_addr(113) <= '0';
      igmp_mode_control.mcast_addr(114) <= '0';
      igmp_mode_control.mcast_addr(115) <= '0';
      igmp_mode_control.mcast_addr(116) <= '0';
      igmp_mode_control.mcast_addr(117) <= '0';
      igmp_mode_control.mcast_addr(118) <= '0';
      igmp_mode_control.mcast_addr(119) <= '0';
      igmp_mode_control.mcast_addr(120) <= '0';
      igmp_mode_control.mcast_addr(121) <= '0';
      igmp_mode_control.mcast_addr(122) <= '0';
      igmp_mode_control.mcast_addr(123) <= '0';
      igmp_mode_control.mcast_addr(124) <= '0';
      igmp_mode_control.mcast_addr(125) <= '0';
      igmp_mode_control.mcast_addr(126) <= '0';
      igmp_mode_control.mcast_addr(127) <= '0';
      igmp_mode_control.mcast_addr(128) <= '0';
      igmp_mode_control.mcast_addr(129) <= '0';
      igmp_mode_control.mcast_addr(130) <= '0';
      igmp_mode_control.mcast_addr(131) <= '0';
      igmp_mode_control.mcast_addr(132) <= '0';
      igmp_mode_control.mcast_addr(133) <= '0';
      igmp_mode_control.mcast_addr(134) <= '0';
      igmp_mode_control.mcast_addr(135) <= '0';
      igmp_mode_control.mcast_addr(136) <= '0';
      igmp_mode_control.mcast_addr(137) <= '0';
      igmp_mode_control.mcast_addr(138) <= '0';
      igmp_mode_control.mcast_addr(139) <= '0';
      igmp_mode_control.mcast_addr(140) <= '0';
      igmp_mode_control.mcast_addr(141) <= '0';
      igmp_mode_control.mcast_addr(142) <= '0';
      igmp_mode_control.mcast_addr(143) <= '0';
      igmp_mode_control.mcast_addr(144) <= '0';
      igmp_mode_control.mcast_addr(145) <= '0';
      igmp_mode_control.mcast_addr(146) <= '0';
      igmp_mode_control.mcast_addr(147) <= '0';
      igmp_mode_control.mcast_addr(148) <= '0';
      igmp_mode_control.mcast_addr(149) <= '0';
      igmp_mode_control.mcast_addr(150) <= '0';
      igmp_mode_control.mcast_addr(151) <= '0';
      igmp_mode_control.mcast_addr(152) <= '0';
      igmp_mode_control.mcast_addr(153) <= '0';
      igmp_mode_control.mcast_addr(154) <= '0';
      igmp_mode_control.mcast_addr(155) <= '0';
      igmp_mode_control.mcast_addr(156) <= '0';
      igmp_mode_control.mcast_addr(157) <= '0';
      igmp_mode_control.mcast_addr(158) <= '0';
      igmp_mode_control.mcast_addr(159) <= '0';
      igmp_mode_control.mcast_addr(160) <= '0';
      igmp_mode_control.mcast_addr(161) <= '0';
      igmp_mode_control.mcast_addr(162) <= '0';
      igmp_mode_control.mcast_addr(163) <= '0';
      igmp_mode_control.mcast_addr(164) <= '0';
      igmp_mode_control.mcast_addr(165) <= '0';
      igmp_mode_control.mcast_addr(166) <= '0';
      igmp_mode_control.mcast_addr(167) <= '0';
      igmp_mode_control.mcast_addr(168) <= '0';
      igmp_mode_control.mcast_addr(169) <= '0';
      igmp_mode_control.mcast_addr(170) <= '0';
      igmp_mode_control.mcast_addr(171) <= '0';
      igmp_mode_control.mcast_addr(172) <= '0';
      igmp_mode_control.mcast_addr(173) <= '0';
      igmp_mode_control.mcast_addr(174) <= '0';
      igmp_mode_control.mcast_addr(175) <= '0';
      igmp_mode_control.mcast_addr(176) <= '0';
      igmp_mode_control.mcast_addr(177) <= '0';
      igmp_mode_control.mcast_addr(178) <= '0';
      igmp_mode_control.mcast_addr(179) <= '0';
      igmp_mode_control.mcast_addr(180) <= '0';
      igmp_mode_control.mcast_addr(181) <= '0';
      igmp_mode_control.mcast_addr(182) <= '0';
      igmp_mode_control.mcast_addr(183) <= '0';
      igmp_mode_control.mcast_addr(184) <= '0';
      igmp_mode_control.mcast_addr(185) <= '0';
      igmp_mode_control.mcast_addr(186) <= '0';
      igmp_mode_control.mcast_addr(187) <= '0';
      igmp_mode_control.mcast_addr(188) <= '0';
      igmp_mode_control.mcast_addr(189) <= '0';
      igmp_mode_control.mcast_addr(190) <= '0';
      igmp_mode_control.mcast_addr(191) <= '0';
      igmp_mode_control.mcast_addr(192) <= '0';
      igmp_mode_control.mcast_addr(193) <= '0';
      igmp_mode_control.mcast_addr(194) <= '0';
      igmp_mode_control.mcast_addr(195) <= '0';
      igmp_mode_control.mcast_addr(196) <= '0';
      igmp_mode_control.mcast_addr(197) <= '0';
      igmp_mode_control.mcast_addr(198) <= '0';
      igmp_mode_control.mcast_addr(199) <= '0';
      igmp_mode_control.mcast_addr(200) <= '0';
      igmp_mode_control.mcast_addr(201) <= '0';
      igmp_mode_control.mcast_addr(202) <= '0';
      igmp_mode_control.mcast_addr(203) <= '0';
      igmp_mode_control.mcast_addr(204) <= '0';
      igmp_mode_control.mcast_addr(205) <= '0';
      igmp_mode_control.mcast_addr(206) <= '0';
      igmp_mode_control.mcast_addr(207) <= '0';
      igmp_mode_control.mcast_addr(208) <= '0';
      igmp_mode_control.mcast_addr(209) <= '0';
      igmp_mode_control.mcast_addr(210) <= '0';
      igmp_mode_control.mcast_addr(211) <= '0';
      igmp_mode_control.mcast_addr(212) <= '0';
      igmp_mode_control.mcast_addr(213) <= '0';
      igmp_mode_control.mcast_addr(214) <= '0';
      igmp_mode_control.mcast_addr(215) <= '0';
      igmp_mode_control.mcast_addr(216) <= '0';
      igmp_mode_control.mcast_addr(217) <= '0';
      igmp_mode_control.mcast_addr(218) <= '0';
      igmp_mode_control.mcast_addr(219) <= '0';
      igmp_mode_control.mcast_addr(220) <= '0';
      igmp_mode_control.mcast_addr(221) <= '0';
      igmp_mode_control.mcast_addr(222) <= '0';
      igmp_mode_control.mcast_addr(223) <= '0';
      igmp_mode_control.mcast_addr(224) <= '0';
      igmp_mode_control.mcast_addr(225) <= '0';
      igmp_mode_control.mcast_addr(226) <= '0';
      igmp_mode_control.mcast_addr(227) <= '0';
      igmp_mode_control.mcast_addr(228) <= '0';
      igmp_mode_control.mcast_addr(229) <= '0';
      igmp_mode_control.mcast_addr(230) <= '0';
      igmp_mode_control.mcast_addr(231) <= '0';
      igmp_mode_control.mcast_addr(232) <= '0';
      igmp_mode_control.mcast_addr(233) <= '0';
      igmp_mode_control.mcast_addr(234) <= '0';
      igmp_mode_control.mcast_addr(235) <= '0';
      igmp_mode_control.mcast_addr(236) <= '0';
      igmp_mode_control.mcast_addr(237) <= '0';
      igmp_mode_control.mcast_addr(238) <= '0';
      igmp_mode_control.mcast_addr(239) <= '0';
      igmp_mode_control.mcast_addr(240) <= '0';
      igmp_mode_control.mcast_addr(241) <= '0';
      igmp_mode_control.mcast_addr(242) <= '0';
      igmp_mode_control.mcast_addr(243) <= '0';
      igmp_mode_control.mcast_addr(244) <= '0';
      igmp_mode_control.mcast_addr(245) <= '0';
      igmp_mode_control.mcast_addr(246) <= '0';
      igmp_mode_control.mcast_addr(247) <= '0';
      igmp_mode_control.mcast_addr(248) <= '0';
      igmp_mode_control.mcast_addr(249) <= '0';
      igmp_mode_control.mcast_addr(250) <= '0';
      igmp_mode_control.mcast_addr(251) <= '0';
      igmp_mode_control.mcast_addr(252) <= '0';
      igmp_mode_control.mcast_addr(253) <= '0';
      igmp_mode_control.mcast_addr(254) <= '0';
      igmp_mode_control.mcast_addr(255) <= '0';

   end procedure;

   procedure axi4lite_igmp_mode_control_write_reg(data: std_logic_vector; 
                                          signal igmp_mode_control_decoded: in t_axi4lite_igmp_mode_control_decoded;
                                          signal igmp_mode_control: inout t_axi4lite_igmp_mode_control) is
   begin
      
      if igmp_mode_control_decoded.igmp_control.igmp_en = '1' then
         igmp_mode_control.igmp_control.igmp_en <= data(0);
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_ver = '1' then
         igmp_mode_control.igmp_control.igmp_ver <= data(2 downto 1);
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_sub = '1' then
         igmp_mode_control.igmp_control.igmp_sub <= data(3);
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_rst = '1' then
         igmp_mode_control.igmp_control.igmp_rst <= data(4);
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_num = '1' then
         igmp_mode_control.igmp_control.igmp_num <= data(31 downto 24);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(0) = '1' then
         igmp_mode_control.mcast_addr(0) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(1) = '1' then
         igmp_mode_control.mcast_addr(1) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(2) = '1' then
         igmp_mode_control.mcast_addr(2) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(3) = '1' then
         igmp_mode_control.mcast_addr(3) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(4) = '1' then
         igmp_mode_control.mcast_addr(4) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(5) = '1' then
         igmp_mode_control.mcast_addr(5) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(6) = '1' then
         igmp_mode_control.mcast_addr(6) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(7) = '1' then
         igmp_mode_control.mcast_addr(7) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(8) = '1' then
         igmp_mode_control.mcast_addr(8) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(9) = '1' then
         igmp_mode_control.mcast_addr(9) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(10) = '1' then
         igmp_mode_control.mcast_addr(10) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(11) = '1' then
         igmp_mode_control.mcast_addr(11) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(12) = '1' then
         igmp_mode_control.mcast_addr(12) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(13) = '1' then
         igmp_mode_control.mcast_addr(13) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(14) = '1' then
         igmp_mode_control.mcast_addr(14) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(15) = '1' then
         igmp_mode_control.mcast_addr(15) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(16) = '1' then
         igmp_mode_control.mcast_addr(16) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(17) = '1' then
         igmp_mode_control.mcast_addr(17) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(18) = '1' then
         igmp_mode_control.mcast_addr(18) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(19) = '1' then
         igmp_mode_control.mcast_addr(19) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(20) = '1' then
         igmp_mode_control.mcast_addr(20) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(21) = '1' then
         igmp_mode_control.mcast_addr(21) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(22) = '1' then
         igmp_mode_control.mcast_addr(22) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(23) = '1' then
         igmp_mode_control.mcast_addr(23) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(24) = '1' then
         igmp_mode_control.mcast_addr(24) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(25) = '1' then
         igmp_mode_control.mcast_addr(25) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(26) = '1' then
         igmp_mode_control.mcast_addr(26) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(27) = '1' then
         igmp_mode_control.mcast_addr(27) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(28) = '1' then
         igmp_mode_control.mcast_addr(28) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(29) = '1' then
         igmp_mode_control.mcast_addr(29) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(30) = '1' then
         igmp_mode_control.mcast_addr(30) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(31) = '1' then
         igmp_mode_control.mcast_addr(31) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(32) = '1' then
         igmp_mode_control.mcast_addr(32) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(33) = '1' then
         igmp_mode_control.mcast_addr(33) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(34) = '1' then
         igmp_mode_control.mcast_addr(34) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(35) = '1' then
         igmp_mode_control.mcast_addr(35) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(36) = '1' then
         igmp_mode_control.mcast_addr(36) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(37) = '1' then
         igmp_mode_control.mcast_addr(37) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(38) = '1' then
         igmp_mode_control.mcast_addr(38) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(39) = '1' then
         igmp_mode_control.mcast_addr(39) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(40) = '1' then
         igmp_mode_control.mcast_addr(40) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(41) = '1' then
         igmp_mode_control.mcast_addr(41) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(42) = '1' then
         igmp_mode_control.mcast_addr(42) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(43) = '1' then
         igmp_mode_control.mcast_addr(43) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(44) = '1' then
         igmp_mode_control.mcast_addr(44) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(45) = '1' then
         igmp_mode_control.mcast_addr(45) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(46) = '1' then
         igmp_mode_control.mcast_addr(46) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(47) = '1' then
         igmp_mode_control.mcast_addr(47) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(48) = '1' then
         igmp_mode_control.mcast_addr(48) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(49) = '1' then
         igmp_mode_control.mcast_addr(49) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(50) = '1' then
         igmp_mode_control.mcast_addr(50) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(51) = '1' then
         igmp_mode_control.mcast_addr(51) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(52) = '1' then
         igmp_mode_control.mcast_addr(52) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(53) = '1' then
         igmp_mode_control.mcast_addr(53) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(54) = '1' then
         igmp_mode_control.mcast_addr(54) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(55) = '1' then
         igmp_mode_control.mcast_addr(55) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(56) = '1' then
         igmp_mode_control.mcast_addr(56) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(57) = '1' then
         igmp_mode_control.mcast_addr(57) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(58) = '1' then
         igmp_mode_control.mcast_addr(58) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(59) = '1' then
         igmp_mode_control.mcast_addr(59) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(60) = '1' then
         igmp_mode_control.mcast_addr(60) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(61) = '1' then
         igmp_mode_control.mcast_addr(61) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(62) = '1' then
         igmp_mode_control.mcast_addr(62) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(63) = '1' then
         igmp_mode_control.mcast_addr(63) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(64) = '1' then
         igmp_mode_control.mcast_addr(64) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(65) = '1' then
         igmp_mode_control.mcast_addr(65) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(66) = '1' then
         igmp_mode_control.mcast_addr(66) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(67) = '1' then
         igmp_mode_control.mcast_addr(67) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(68) = '1' then
         igmp_mode_control.mcast_addr(68) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(69) = '1' then
         igmp_mode_control.mcast_addr(69) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(70) = '1' then
         igmp_mode_control.mcast_addr(70) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(71) = '1' then
         igmp_mode_control.mcast_addr(71) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(72) = '1' then
         igmp_mode_control.mcast_addr(72) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(73) = '1' then
         igmp_mode_control.mcast_addr(73) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(74) = '1' then
         igmp_mode_control.mcast_addr(74) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(75) = '1' then
         igmp_mode_control.mcast_addr(75) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(76) = '1' then
         igmp_mode_control.mcast_addr(76) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(77) = '1' then
         igmp_mode_control.mcast_addr(77) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(78) = '1' then
         igmp_mode_control.mcast_addr(78) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(79) = '1' then
         igmp_mode_control.mcast_addr(79) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(80) = '1' then
         igmp_mode_control.mcast_addr(80) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(81) = '1' then
         igmp_mode_control.mcast_addr(81) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(82) = '1' then
         igmp_mode_control.mcast_addr(82) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(83) = '1' then
         igmp_mode_control.mcast_addr(83) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(84) = '1' then
         igmp_mode_control.mcast_addr(84) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(85) = '1' then
         igmp_mode_control.mcast_addr(85) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(86) = '1' then
         igmp_mode_control.mcast_addr(86) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(87) = '1' then
         igmp_mode_control.mcast_addr(87) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(88) = '1' then
         igmp_mode_control.mcast_addr(88) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(89) = '1' then
         igmp_mode_control.mcast_addr(89) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(90) = '1' then
         igmp_mode_control.mcast_addr(90) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(91) = '1' then
         igmp_mode_control.mcast_addr(91) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(92) = '1' then
         igmp_mode_control.mcast_addr(92) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(93) = '1' then
         igmp_mode_control.mcast_addr(93) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(94) = '1' then
         igmp_mode_control.mcast_addr(94) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(95) = '1' then
         igmp_mode_control.mcast_addr(95) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(96) = '1' then
         igmp_mode_control.mcast_addr(96) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(97) = '1' then
         igmp_mode_control.mcast_addr(97) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(98) = '1' then
         igmp_mode_control.mcast_addr(98) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(99) = '1' then
         igmp_mode_control.mcast_addr(99) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(100) = '1' then
         igmp_mode_control.mcast_addr(100) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(101) = '1' then
         igmp_mode_control.mcast_addr(101) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(102) = '1' then
         igmp_mode_control.mcast_addr(102) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(103) = '1' then
         igmp_mode_control.mcast_addr(103) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(104) = '1' then
         igmp_mode_control.mcast_addr(104) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(105) = '1' then
         igmp_mode_control.mcast_addr(105) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(106) = '1' then
         igmp_mode_control.mcast_addr(106) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(107) = '1' then
         igmp_mode_control.mcast_addr(107) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(108) = '1' then
         igmp_mode_control.mcast_addr(108) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(109) = '1' then
         igmp_mode_control.mcast_addr(109) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(110) = '1' then
         igmp_mode_control.mcast_addr(110) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(111) = '1' then
         igmp_mode_control.mcast_addr(111) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(112) = '1' then
         igmp_mode_control.mcast_addr(112) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(113) = '1' then
         igmp_mode_control.mcast_addr(113) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(114) = '1' then
         igmp_mode_control.mcast_addr(114) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(115) = '1' then
         igmp_mode_control.mcast_addr(115) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(116) = '1' then
         igmp_mode_control.mcast_addr(116) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(117) = '1' then
         igmp_mode_control.mcast_addr(117) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(118) = '1' then
         igmp_mode_control.mcast_addr(118) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(119) = '1' then
         igmp_mode_control.mcast_addr(119) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(120) = '1' then
         igmp_mode_control.mcast_addr(120) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(121) = '1' then
         igmp_mode_control.mcast_addr(121) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(122) = '1' then
         igmp_mode_control.mcast_addr(122) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(123) = '1' then
         igmp_mode_control.mcast_addr(123) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(124) = '1' then
         igmp_mode_control.mcast_addr(124) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(125) = '1' then
         igmp_mode_control.mcast_addr(125) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(126) = '1' then
         igmp_mode_control.mcast_addr(126) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(127) = '1' then
         igmp_mode_control.mcast_addr(127) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(128) = '1' then
         igmp_mode_control.mcast_addr(128) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(129) = '1' then
         igmp_mode_control.mcast_addr(129) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(130) = '1' then
         igmp_mode_control.mcast_addr(130) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(131) = '1' then
         igmp_mode_control.mcast_addr(131) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(132) = '1' then
         igmp_mode_control.mcast_addr(132) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(133) = '1' then
         igmp_mode_control.mcast_addr(133) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(134) = '1' then
         igmp_mode_control.mcast_addr(134) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(135) = '1' then
         igmp_mode_control.mcast_addr(135) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(136) = '1' then
         igmp_mode_control.mcast_addr(136) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(137) = '1' then
         igmp_mode_control.mcast_addr(137) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(138) = '1' then
         igmp_mode_control.mcast_addr(138) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(139) = '1' then
         igmp_mode_control.mcast_addr(139) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(140) = '1' then
         igmp_mode_control.mcast_addr(140) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(141) = '1' then
         igmp_mode_control.mcast_addr(141) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(142) = '1' then
         igmp_mode_control.mcast_addr(142) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(143) = '1' then
         igmp_mode_control.mcast_addr(143) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(144) = '1' then
         igmp_mode_control.mcast_addr(144) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(145) = '1' then
         igmp_mode_control.mcast_addr(145) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(146) = '1' then
         igmp_mode_control.mcast_addr(146) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(147) = '1' then
         igmp_mode_control.mcast_addr(147) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(148) = '1' then
         igmp_mode_control.mcast_addr(148) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(149) = '1' then
         igmp_mode_control.mcast_addr(149) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(150) = '1' then
         igmp_mode_control.mcast_addr(150) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(151) = '1' then
         igmp_mode_control.mcast_addr(151) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(152) = '1' then
         igmp_mode_control.mcast_addr(152) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(153) = '1' then
         igmp_mode_control.mcast_addr(153) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(154) = '1' then
         igmp_mode_control.mcast_addr(154) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(155) = '1' then
         igmp_mode_control.mcast_addr(155) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(156) = '1' then
         igmp_mode_control.mcast_addr(156) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(157) = '1' then
         igmp_mode_control.mcast_addr(157) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(158) = '1' then
         igmp_mode_control.mcast_addr(158) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(159) = '1' then
         igmp_mode_control.mcast_addr(159) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(160) = '1' then
         igmp_mode_control.mcast_addr(160) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(161) = '1' then
         igmp_mode_control.mcast_addr(161) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(162) = '1' then
         igmp_mode_control.mcast_addr(162) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(163) = '1' then
         igmp_mode_control.mcast_addr(163) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(164) = '1' then
         igmp_mode_control.mcast_addr(164) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(165) = '1' then
         igmp_mode_control.mcast_addr(165) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(166) = '1' then
         igmp_mode_control.mcast_addr(166) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(167) = '1' then
         igmp_mode_control.mcast_addr(167) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(168) = '1' then
         igmp_mode_control.mcast_addr(168) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(169) = '1' then
         igmp_mode_control.mcast_addr(169) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(170) = '1' then
         igmp_mode_control.mcast_addr(170) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(171) = '1' then
         igmp_mode_control.mcast_addr(171) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(172) = '1' then
         igmp_mode_control.mcast_addr(172) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(173) = '1' then
         igmp_mode_control.mcast_addr(173) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(174) = '1' then
         igmp_mode_control.mcast_addr(174) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(175) = '1' then
         igmp_mode_control.mcast_addr(175) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(176) = '1' then
         igmp_mode_control.mcast_addr(176) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(177) = '1' then
         igmp_mode_control.mcast_addr(177) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(178) = '1' then
         igmp_mode_control.mcast_addr(178) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(179) = '1' then
         igmp_mode_control.mcast_addr(179) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(180) = '1' then
         igmp_mode_control.mcast_addr(180) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(181) = '1' then
         igmp_mode_control.mcast_addr(181) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(182) = '1' then
         igmp_mode_control.mcast_addr(182) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(183) = '1' then
         igmp_mode_control.mcast_addr(183) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(184) = '1' then
         igmp_mode_control.mcast_addr(184) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(185) = '1' then
         igmp_mode_control.mcast_addr(185) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(186) = '1' then
         igmp_mode_control.mcast_addr(186) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(187) = '1' then
         igmp_mode_control.mcast_addr(187) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(188) = '1' then
         igmp_mode_control.mcast_addr(188) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(189) = '1' then
         igmp_mode_control.mcast_addr(189) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(190) = '1' then
         igmp_mode_control.mcast_addr(190) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(191) = '1' then
         igmp_mode_control.mcast_addr(191) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(192) = '1' then
         igmp_mode_control.mcast_addr(192) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(193) = '1' then
         igmp_mode_control.mcast_addr(193) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(194) = '1' then
         igmp_mode_control.mcast_addr(194) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(195) = '1' then
         igmp_mode_control.mcast_addr(195) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(196) = '1' then
         igmp_mode_control.mcast_addr(196) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(197) = '1' then
         igmp_mode_control.mcast_addr(197) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(198) = '1' then
         igmp_mode_control.mcast_addr(198) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(199) = '1' then
         igmp_mode_control.mcast_addr(199) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(200) = '1' then
         igmp_mode_control.mcast_addr(200) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(201) = '1' then
         igmp_mode_control.mcast_addr(201) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(202) = '1' then
         igmp_mode_control.mcast_addr(202) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(203) = '1' then
         igmp_mode_control.mcast_addr(203) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(204) = '1' then
         igmp_mode_control.mcast_addr(204) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(205) = '1' then
         igmp_mode_control.mcast_addr(205) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(206) = '1' then
         igmp_mode_control.mcast_addr(206) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(207) = '1' then
         igmp_mode_control.mcast_addr(207) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(208) = '1' then
         igmp_mode_control.mcast_addr(208) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(209) = '1' then
         igmp_mode_control.mcast_addr(209) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(210) = '1' then
         igmp_mode_control.mcast_addr(210) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(211) = '1' then
         igmp_mode_control.mcast_addr(211) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(212) = '1' then
         igmp_mode_control.mcast_addr(212) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(213) = '1' then
         igmp_mode_control.mcast_addr(213) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(214) = '1' then
         igmp_mode_control.mcast_addr(214) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(215) = '1' then
         igmp_mode_control.mcast_addr(215) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(216) = '1' then
         igmp_mode_control.mcast_addr(216) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(217) = '1' then
         igmp_mode_control.mcast_addr(217) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(218) = '1' then
         igmp_mode_control.mcast_addr(218) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(219) = '1' then
         igmp_mode_control.mcast_addr(219) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(220) = '1' then
         igmp_mode_control.mcast_addr(220) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(221) = '1' then
         igmp_mode_control.mcast_addr(221) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(222) = '1' then
         igmp_mode_control.mcast_addr(222) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(223) = '1' then
         igmp_mode_control.mcast_addr(223) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(224) = '1' then
         igmp_mode_control.mcast_addr(224) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(225) = '1' then
         igmp_mode_control.mcast_addr(225) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(226) = '1' then
         igmp_mode_control.mcast_addr(226) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(227) = '1' then
         igmp_mode_control.mcast_addr(227) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(228) = '1' then
         igmp_mode_control.mcast_addr(228) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(229) = '1' then
         igmp_mode_control.mcast_addr(229) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(230) = '1' then
         igmp_mode_control.mcast_addr(230) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(231) = '1' then
         igmp_mode_control.mcast_addr(231) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(232) = '1' then
         igmp_mode_control.mcast_addr(232) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(233) = '1' then
         igmp_mode_control.mcast_addr(233) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(234) = '1' then
         igmp_mode_control.mcast_addr(234) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(235) = '1' then
         igmp_mode_control.mcast_addr(235) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(236) = '1' then
         igmp_mode_control.mcast_addr(236) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(237) = '1' then
         igmp_mode_control.mcast_addr(237) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(238) = '1' then
         igmp_mode_control.mcast_addr(238) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(239) = '1' then
         igmp_mode_control.mcast_addr(239) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(240) = '1' then
         igmp_mode_control.mcast_addr(240) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(241) = '1' then
         igmp_mode_control.mcast_addr(241) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(242) = '1' then
         igmp_mode_control.mcast_addr(242) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(243) = '1' then
         igmp_mode_control.mcast_addr(243) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(244) = '1' then
         igmp_mode_control.mcast_addr(244) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(245) = '1' then
         igmp_mode_control.mcast_addr(245) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(246) = '1' then
         igmp_mode_control.mcast_addr(246) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(247) = '1' then
         igmp_mode_control.mcast_addr(247) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(248) = '1' then
         igmp_mode_control.mcast_addr(248) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(249) = '1' then
         igmp_mode_control.mcast_addr(249) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(250) = '1' then
         igmp_mode_control.mcast_addr(250) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(251) = '1' then
         igmp_mode_control.mcast_addr(251) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(252) = '1' then
         igmp_mode_control.mcast_addr(252) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(253) = '1' then
         igmp_mode_control.mcast_addr(253) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(254) = '1' then
         igmp_mode_control.mcast_addr(254) <= data(31 downto 0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(255) = '1' then
         igmp_mode_control.mcast_addr(255) <= data(31 downto 0);
      end if;
      

   end procedure;
   
   function axi4lite_igmp_mode_control_read_reg(signal igmp_mode_control_decoded: in t_axi4lite_igmp_mode_control_decoded;
                                        signal igmp_mode_control: t_axi4lite_igmp_mode_control) return std_logic_vector is
      variable ret: std_logic_vector(31 downto 0);
   begin
      ret := (others=>'0');
      
      if igmp_mode_control_decoded.igmp_control.igmp_en = '1' then
         ret(0) := igmp_mode_control.igmp_control.igmp_en;
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_ver = '1' then
         ret(2 downto 1) := igmp_mode_control.igmp_control.igmp_ver;
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_sub = '1' then
         ret(3) := igmp_mode_control.igmp_control.igmp_sub;
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_rst = '1' then
         ret(4) := igmp_mode_control.igmp_control.igmp_rst;
      end if;
      
      if igmp_mode_control_decoded.igmp_control.igmp_num = '1' then
         ret(31 downto 24) := igmp_mode_control.igmp_control.igmp_num;
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(0) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(0);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(1) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(1);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(2) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(2);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(3) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(3);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(4) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(4);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(5) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(5);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(6) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(6);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(7) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(7);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(8) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(8);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(9) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(9);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(10) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(10);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(11) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(11);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(12) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(12);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(13) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(13);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(14) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(14);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(15) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(15);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(16) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(16);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(17) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(17);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(18) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(18);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(19) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(19);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(20) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(20);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(21) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(21);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(22) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(22);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(23) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(23);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(24) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(24);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(25) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(25);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(26) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(26);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(27) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(27);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(28) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(28);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(29) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(29);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(30) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(30);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(31) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(31);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(32) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(32);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(33) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(33);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(34) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(34);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(35) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(35);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(36) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(36);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(37) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(37);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(38) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(38);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(39) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(39);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(40) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(40);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(41) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(41);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(42) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(42);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(43) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(43);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(44) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(44);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(45) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(45);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(46) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(46);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(47) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(47);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(48) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(48);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(49) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(49);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(50) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(50);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(51) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(51);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(52) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(52);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(53) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(53);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(54) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(54);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(55) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(55);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(56) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(56);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(57) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(57);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(58) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(58);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(59) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(59);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(60) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(60);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(61) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(61);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(62) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(62);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(63) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(63);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(64) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(64);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(65) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(65);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(66) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(66);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(67) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(67);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(68) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(68);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(69) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(69);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(70) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(70);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(71) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(71);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(72) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(72);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(73) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(73);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(74) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(74);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(75) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(75);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(76) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(76);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(77) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(77);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(78) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(78);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(79) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(79);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(80) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(80);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(81) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(81);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(82) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(82);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(83) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(83);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(84) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(84);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(85) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(85);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(86) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(86);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(87) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(87);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(88) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(88);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(89) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(89);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(90) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(90);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(91) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(91);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(92) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(92);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(93) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(93);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(94) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(94);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(95) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(95);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(96) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(96);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(97) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(97);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(98) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(98);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(99) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(99);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(100) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(100);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(101) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(101);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(102) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(102);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(103) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(103);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(104) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(104);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(105) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(105);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(106) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(106);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(107) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(107);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(108) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(108);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(109) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(109);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(110) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(110);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(111) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(111);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(112) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(112);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(113) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(113);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(114) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(114);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(115) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(115);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(116) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(116);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(117) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(117);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(118) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(118);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(119) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(119);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(120) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(120);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(121) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(121);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(122) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(122);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(123) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(123);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(124) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(124);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(125) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(125);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(126) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(126);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(127) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(127);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(128) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(128);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(129) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(129);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(130) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(130);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(131) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(131);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(132) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(132);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(133) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(133);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(134) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(134);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(135) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(135);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(136) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(136);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(137) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(137);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(138) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(138);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(139) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(139);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(140) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(140);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(141) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(141);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(142) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(142);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(143) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(143);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(144) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(144);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(145) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(145);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(146) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(146);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(147) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(147);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(148) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(148);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(149) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(149);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(150) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(150);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(151) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(151);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(152) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(152);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(153) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(153);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(154) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(154);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(155) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(155);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(156) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(156);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(157) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(157);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(158) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(158);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(159) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(159);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(160) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(160);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(161) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(161);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(162) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(162);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(163) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(163);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(164) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(164);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(165) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(165);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(166) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(166);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(167) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(167);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(168) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(168);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(169) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(169);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(170) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(170);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(171) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(171);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(172) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(172);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(173) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(173);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(174) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(174);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(175) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(175);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(176) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(176);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(177) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(177);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(178) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(178);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(179) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(179);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(180) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(180);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(181) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(181);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(182) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(182);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(183) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(183);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(184) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(184);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(185) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(185);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(186) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(186);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(187) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(187);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(188) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(188);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(189) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(189);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(190) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(190);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(191) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(191);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(192) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(192);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(193) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(193);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(194) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(194);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(195) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(195);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(196) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(196);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(197) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(197);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(198) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(198);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(199) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(199);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(200) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(200);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(201) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(201);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(202) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(202);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(203) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(203);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(204) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(204);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(205) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(205);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(206) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(206);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(207) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(207);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(208) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(208);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(209) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(209);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(210) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(210);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(211) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(211);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(212) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(212);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(213) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(213);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(214) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(214);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(215) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(215);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(216) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(216);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(217) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(217);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(218) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(218);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(219) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(219);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(220) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(220);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(221) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(221);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(222) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(222);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(223) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(223);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(224) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(224);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(225) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(225);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(226) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(226);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(227) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(227);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(228) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(228);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(229) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(229);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(230) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(230);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(231) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(231);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(232) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(232);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(233) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(233);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(234) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(234);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(235) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(235);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(236) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(236);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(237) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(237);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(238) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(238);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(239) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(239);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(240) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(240);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(241) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(241);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(242) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(242);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(243) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(243);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(244) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(244);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(245) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(245);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(246) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(246);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(247) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(247);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(248) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(248);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(249) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(249);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(250) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(250);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(251) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(251);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(252) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(252);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(253) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(253);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(254) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(254);
      end if;
      
      if igmp_mode_control_decoded.mcast_addr(255) = '1' then
         ret(31 downto 0) := igmp_mode_control.mcast_addr(255);
      end if;
      

      return ret;
   end function;
   
   function axi4lite_igmp_mode_control_demux(addr: std_logic_vector) return std_logic_vector is
      variable ret: std_logic_vector(c_total_nof_blocks-1 downto 0);
   begin
      ret := (others=>'0');
      if c_total_nof_blocks = 1 then
         ret := (others=>'1');
      else

  
      end if;
      return ret;
   end function;

end package body;

