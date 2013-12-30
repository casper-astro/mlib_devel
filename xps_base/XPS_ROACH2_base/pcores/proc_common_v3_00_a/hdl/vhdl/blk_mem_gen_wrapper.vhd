-------------------------------------------------------------------------------
-- $Id: blk_mem_gen_wrapper.vhd,v 1.1.20.3 2010/02/09 20:15:59 dougt Exp $
-------------------------------------------------------------------------------
-- blk_mem_gen_wrapper.vhd - entity/architecture pair
-------------------------------------------------------------------------------
--
-- ****************************************************************************
-- **  DISCLAIMER OF LIABILITY                                               **
-- **                                                                        **
-- **  This text/file contains proprietary, confidential                     **
-- **  information of Xilinx, Inc., is distributed under                     **
-- **  license from Xilinx, Inc., and may be used, copied                    **
-- **  and/or disclosed only pursuant to the terms of a valid                **
-- **  license agreement with Xilinx, Inc. Xilinx hereby                     **
-- **  grants you a license to use this text/file solely for                 **
-- **  design, simulation, implementation and creation of                    **
-- **  design files limited to Xilinx devices or technologies.               **
-- **  Use with non-Xilinx devices or technologies is expressly              **
-- **  prohibited and immediately terminates your license unless             **
-- **  covered by a separate agreement.                                      **
-- **                                                                        **
-- **  Xilinx is providing this design, code, or information                 **
-- **  "as-is" solely for use in developing programs and                     **
-- **  solutions for Xilinx devices, with no obligation on the               **
-- **  part of Xilinx to provide support. By providing this design,          **
-- **  code, or information as one possible implementation of                **
-- **  this feature, application or standard, Xilinx is making no            **
-- **  representation that this implementation is free from any              **
-- **  claims of infringement. You are responsible for obtaining             **
-- **  any rights you may require for your implementation.                   **
-- **  Xilinx expressly disclaims any warranty whatsoever with               **
-- **  respect to the adequacy of the implementation, including              **
-- **  but not limited to any warranties or representations that this        **
-- **  implementation is free from claims of infringement, implied           **
-- **  warranties of merchantability or fitness for a particular             **
-- **  purpose.                                                              **
-- **                                                                        **
-- **  Xilinx products are not intended for use in life support              **
-- **  appliances, devices, or systems. Use in such applications is          **
-- **  expressly prohibited.                                                 **
-- **                                                                        **
-- **  Any modifications that are made to the Source Code are                **
-- **  done at the users sole risk and will be unsupported.                  **
-- **  The Xilinx Support Hotline does not have access to source             **
-- **  code and therefore cannot answer specific questions related           **
-- **  to source HDL. The Xilinx Hotline support of original source          **
-- **  code IP shall only address issues and questions related               **
-- **  to the standard Netlist version of the core (and thus                 **
-- **  indirectly, the original core source).                                **
-- **                                                                        **
-- **  Copyright (c) 2008, 2009. 2010 Xilinx, Inc. All rights reserved.      **
-- **                                                                        **
-- **  This copyright and support notice must be retained as part            **
-- **  of this text at all times.                                            **
-- ****************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        blk_mem_gen_wrapper.vhd
-- Version:         v1.00a
-- Description:
--  This wrapper file performs the direct call to Block Memory Generator
--  during design implementation
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--              blk_mem_gen_wrapper.vhd
--                    |
--                    |-- blk_mem_gen_v2_7
--                    |
--                    |-- blk_mem_gen_v3_3
--
-------------------------------------------------------------------------------
-- Revision History:
--
--
-- Author:          MW
-- Revision:        $Revision: 1.1.20.3 $
-- Date:            $7/11/2008$
--
-- History:
--   MW   7/11/2008       Initial Version
--   MSH  2/26/2009       Add new blk_mem_gen version
--
--     DET     4/8/2009     EDK 11.2
-- ~~~~~~
--     - Added blk_mem_gen_v3_2 instance callout
-- ^^^^^^
--
--     DET     2/9/2010     for EDK 11.5
-- ~~~~~~
--     - Updated the the Blk Mem Gen version from blk_mem_gen_v3_2 
--       to blk_mem_gen_v3_3 (for the S6/V6 IfGen case)
-- ^^^^^^
--
-------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on

library proc_common_v3_00_a;
use proc_common_v3_00_a.coregen_comp_defs.all;
use proc_common_v3_00_a.family_support.all;


------------------------------------------------------------------------------
-- Port Declaration
------------------------------------------------------------------------------
entity blk_mem_gen_wrapper is
   generic
      (
      -- Device Family
      c_family                 : string  := "virtex5";
         -- "Virtex2"
         -- "Virtex4"
         -- "Virtex5"
      c_xdevicefamily          : string  := "virtex5";
         -- Finest Resolution Device Family
            -- "Virtex2"
            -- "Virtex2-Pro"
            -- "Virtex4"
            -- "Virtex5"
            -- "Spartan-3A"
            -- "Spartan-3A DSP"

      -- Memory Specific Configurations
      c_mem_type               : integer := 2;
         -- This wrapper only supports the True Dual Port RAM
         -- 0: Single Port RAM
         -- 1: Simple Dual Port RAM
         -- 2: True Dual Port RAM
         -- 3: Single Port Rom
         -- 4: Dual Port RAM
      c_algorithm              : integer := 1;
         -- 0: Selectable Primative
         -- 1: Minimum Area
      c_prim_type              : integer := 1;
         -- 0: ( 1-bit wide)
         -- 1: ( 2-bit wide)
         -- 2: ( 4-bit wide)
         -- 3: ( 9-bit wide)
         -- 4: (18-bit wide)
         -- 5: (36-bit wide)
         -- 6: (72-bit wide, single port only)
      c_byte_size              : integer := 9;   -- 8 or 9

      -- Simulation Behavior Options
      c_sim_collision_check    : string  :=  "NONE";
         -- "None"
         -- "Generate_X"
         -- "All"
         -- "Warnings_only"
      c_common_clk             : integer := 1;   -- 0, 1
      c_disable_warn_bhv_coll  : integer := 0;   -- 0, 1
      c_disable_warn_bhv_range : integer := 0;   -- 0, 1

      -- Initialization Configuration Options
      c_load_init_file         : integer := 0;
      c_init_file_name         : string  := "no_coe_file_loaded";
      c_use_default_data       : integer := 0;   -- 0, 1
      c_default_data           : string  := "0"; -- "..."

      -- Port A Specific Configurations
      c_has_mem_output_regs_a  : integer := 0;   -- 0, 1
      c_has_mux_output_regs_a  : integer := 0;   -- 0, 1
      c_write_width_a          : integer := 32;  -- 1 to 1152
      c_read_width_a           : integer := 32;  -- 1 to 1152
      c_write_depth_a          : integer := 64;  -- 2 to 9011200
      c_read_depth_a           : integer := 64;  -- 2 to 9011200
      c_addra_width            : integer := 6;   -- 1 to 24
      c_write_mode_a           : string  := "WRITE_FIRST";
         -- "Write_First"
         -- "Read_first"
         -- "No_Change"
      c_has_ena                : integer := 1;   -- 0, 1
      c_has_regcea             : integer := 0;   -- 0, 1
      c_has_ssra               : integer := 0;   -- 0, 1
      c_sinita_val             : string  := "0"; --"..."
      c_use_byte_wea           : integer := 0;   -- 0, 1
      c_wea_width              : integer := 1;   -- 1 to 128

      -- Port B Specific Configurations
      c_has_mem_output_regs_b  : integer := 0;   -- 0, 1
      c_has_mux_output_regs_b  : integer := 0;   -- 0, 1
      c_write_width_b          : integer := 32;  -- 1 to 1152
      c_read_width_b           : integer := 32;  -- 1 to 1152
      c_write_depth_b          : integer := 64;  -- 2 to 9011200
      c_read_depth_b           : integer := 64;  -- 2 to 9011200
      c_addrb_width            : integer := 6;   -- 1 to 24
      c_write_mode_b           : string  := "WRITE_FIRST";
         -- "Write_First"
         -- "Read_first"
         -- "No_Change"
      c_has_enb                : integer := 1;   -- 0, 1
      c_has_regceb             : integer := 0;   -- 0, 1
      c_has_ssrb               : integer := 0;   -- 0, 1
      c_sinitb_val             : string  := "0"; -- "..."
      c_use_byte_web           : integer := 0;   -- 0, 1
      c_web_width              : integer := 1;   -- 1 to 128

      -- Other Miscellaneous Configurations
      c_mux_pipeline_stages    : integer := 0;   -- 0, 1, 2, 3
         -- The number of pipeline stages within the MUX
         --    for both Port A and Port B
      c_use_ecc                : integer := 0;
         -- See DS512 for the limited core option selections for ECC support
      c_use_ramb16bwer_rst_bhv : integer := 0--;   --0, 1
--      c_corename               : string  := "blk_mem_gen_v2_7"
      --Uncommenting the above parameter (C_CORENAME) will cause
      --the a failure in NGCBuild!!!

      );
   port
      (
      clka    : in  std_logic;
      ssra    : in  std_logic := '0';
      dina    : in  std_logic_vector(c_write_width_a-1 downto 0) := (OTHERS => '0');
      addra   : in  std_logic_vector(c_addra_width-1   downto 0);
      ena     : in  std_logic := '1';
      regcea  : in  std_logic := '1';
      wea     : in  std_logic_vector(c_wea_width-1     downto 0) := (OTHERS => '0');
      douta   : out std_logic_vector(c_read_width_a-1  downto 0);


      clkb    : in  std_logic := '0';
      ssrb    : in  std_logic := '0';
      dinb    : in  std_logic_vector(c_write_width_b-1 downto 0) := (OTHERS => '0');
      addrb   : in  std_logic_vector(c_addrb_width-1   downto 0) := (OTHERS => '0');
      enb     : in  std_logic := '1';
      regceb  : in  std_logic := '1';
      web     : in  std_logic_vector(c_web_width-1     downto 0) := (OTHERS => '0');
      doutb   : out std_logic_vector(c_read_width_b-1  downto 0);

      dbiterr : out std_logic;
         -- Double bit error that that cannot be auto corrected by ECC
      sbiterr : out std_logic
         -- Single Bit Error that has been auto corrected on the output bus        
      );
end entity blk_mem_gen_wrapper;

architecture implementation of blk_mem_gen_wrapper is

begin

  NOT_V6_OR_S6: if((equalIgnoringCase(C_FAMILY, "virtex6")= FALSE) and (equalIgnoringCase(C_FAMILY, "spartan6")= FALSE)) generate
  begin
   I_TRUE_DUAL_PORT_BLK_MEM_GEN : blk_mem_gen_v2_7
      generic map
         (
         -- Device Family
         c_family                 => c_family                ,     
         c_xdevicefamily          => c_xdevicefamily         ,     
                                                                                     
         -- Memory Specific Configurations                               
         c_mem_type               => c_mem_type              ,     
         c_algorithm              => c_algorithm             ,     
         c_prim_type              => c_prim_type             ,     
         c_byte_size              => c_byte_size             ,     
                                                                                                    
         -- Simulation Behavior Options                                                             
         c_sim_collision_check    => c_sim_collision_check   ,                                      
         c_common_clk             => c_common_clk            ,                                      
         c_disable_warn_bhv_coll  => c_disable_warn_bhv_coll ,                                      
         c_disable_warn_bhv_range => c_disable_warn_bhv_range,                                      
                                                                                                    
         -- Initialization Configuration Options                                                    
         c_load_init_file         => c_load_init_file        ,                                      
         c_init_file_name         => c_init_file_name        ,                                      
         c_use_default_data       => c_use_default_data      ,                                      
         c_default_data           => c_default_data          ,                                      
                                                                                                    
         -- Port A Specific Configurations                                                          
         c_has_mem_output_regs_a  => c_has_mem_output_regs_a ,                                      
         c_has_mux_output_regs_a  => c_has_mux_output_regs_a ,                                                                                     
         c_write_width_a          => c_write_width_a         ,                               
         c_read_width_a           => c_read_width_a          ,                               
         c_write_depth_a          => c_write_depth_a         ,                               
         c_read_depth_a           => c_read_depth_a          ,                               
         c_addra_width            => c_addra_width           ,                               
         c_write_mode_a           => c_write_mode_a          ,                               
         c_has_ena                => c_has_ena               ,                               
         c_has_regcea             => c_has_regcea            ,                               
         c_has_ssra               => c_has_ssra              ,                               
         c_sinita_val             => c_sinita_val            ,                               
         c_use_byte_wea           => c_use_byte_wea          ,                                
         c_wea_width              => c_wea_width             ,                                
                                                                                              
         -- Port B Specific Configurations                             
         c_has_mem_output_regs_b  => c_has_mem_output_regs_b ,         
         c_has_mux_output_regs_b  => c_has_mux_output_regs_b ,         
         c_write_width_b          => c_write_width_b         ,         
         c_read_width_b           => c_read_width_b          ,         
         c_write_depth_b          => c_write_depth_b         ,         
         c_read_depth_b           => c_read_depth_b          ,         
         c_addrb_width            => c_addrb_width           ,         
         c_write_mode_b           => c_write_mode_b          ,         
         c_has_enb                => c_has_enb               ,         
         c_has_regceb             => c_has_regceb            ,         
         c_has_ssrb               => c_has_ssrb              ,         
         c_sinitb_val             => c_sinitb_val            ,         
         c_use_byte_web           => c_use_byte_web          ,         
         c_web_width              => c_web_width             ,         
                                                                       
         -- Other Miscellaneous Configurations                         
         c_mux_pipeline_stages    => c_mux_pipeline_stages   ,         
         c_use_ecc                => c_use_ecc               ,         
         c_use_ramb16bwer_rst_bhv => c_use_ramb16bwer_rst_bhv         
--         c_corename               => c_corename 
         --Uncommenting the above parameter (C_CORENAME) will cause
         --the a failure in NGCBuild!!!                       
         )                                                              
                                                                        
      port map                                                          
         (                                                              
         clka    => clka,                                           
         ssra    => ssra,                                           
         dina    => dina,                                           
         addra   => addra,                                          
         ena     => ena,                                            
         regcea  => regcea,                                         
         wea     => wea,                                            
         douta   => douta,                                          
                                                                    
                                                                    
         clkb    => clkb,                                           
         ssrb    => ssrb,                                           
         dinb    => dinb,                                           
         addrb   => addrb,                                          
         enb     => enb,                                            
         regceb  => regceb,                                         
         web     => web,                                            
         doutb   => doutb,                                        
                                                                     
         dbiterr => dbiterr,                                         
         sbiterr => sbiterr                                          
         );                                                              
  end generate NOT_V6_OR_S6;

  YES_V6_OR_S6: if((equalIgnoringCase(C_FAMILY, "virtex6")= TRUE) or (equalIgnoringCase(C_FAMILY, "spartan6")= TRUE)) generate
  begin
   I_TRUE_DUAL_PORT_BLK_MEM_GEN : blk_mem_gen_v3_3
      generic map
         (
         -- Device Family
         c_family                 => c_family                ,     
         c_xdevicefamily          => c_xdevicefamily         ,     
                                                                                     
         -- Memory Specific Configurations                               
         c_mem_type               => c_mem_type              ,     
         c_algorithm              => c_algorithm             ,     
         c_prim_type              => c_prim_type             ,     
         c_byte_size              => c_byte_size             ,     
                                                                                                    
         -- Simulation Behavior Options                                                             
         c_sim_collision_check    => c_sim_collision_check   ,                                      
         c_common_clk             => c_common_clk            ,                                      
         c_disable_warn_bhv_coll  => c_disable_warn_bhv_coll ,                                      
         c_disable_warn_bhv_range => c_disable_warn_bhv_range,                                      
                                                                                                    
         -- Initialization Configuration Options                                                    
         c_load_init_file         => c_load_init_file        ,                                      
         c_init_file_name         => c_init_file_name        ,                                      
         c_use_default_data       => c_use_default_data      ,                                      
         c_default_data           => c_default_data          ,                                      
                                                                                                    
         -- Port A Specific Configurations                                                          
         c_has_mem_output_regs_a  => c_has_mem_output_regs_a ,                                      
         c_has_mux_output_regs_a  => c_has_mux_output_regs_a ,                                                                                     
         c_write_width_a          => c_write_width_a         ,                               
         c_read_width_a           => c_read_width_a          ,                               
         c_write_depth_a          => c_write_depth_a         ,                               
         c_read_depth_a           => c_read_depth_a          ,                               
         c_addra_width            => c_addra_width           ,                               
         c_write_mode_a           => c_write_mode_a          ,                               
         c_has_ena                => c_has_ena               ,                               
         c_has_regcea             => c_has_regcea            ,                               
         c_has_rsta               => c_has_ssra              ,                               
         c_inita_val              => c_sinita_val            ,                               
         c_use_byte_wea           => c_use_byte_wea          ,                                
         c_wea_width              => c_wea_width             ,                                
                                                                                              
         -- Port B Specific Configurations                             
         c_has_mem_output_regs_b  => c_has_mem_output_regs_b ,         
         c_has_mux_output_regs_b  => c_has_mux_output_regs_b ,         
         c_write_width_b          => c_write_width_b         ,         
         c_read_width_b           => c_read_width_b          ,         
         c_write_depth_b          => c_write_depth_b         ,         
         c_read_depth_b           => c_read_depth_b          ,         
         c_addrb_width            => c_addrb_width           ,         
         c_write_mode_b           => c_write_mode_b          ,         
         c_has_enb                => c_has_enb               ,         
         c_has_regceb             => c_has_regceb            ,         
         c_has_rstb               => c_has_ssrb              ,         
         c_initb_val              => c_sinitb_val            ,         
         c_use_byte_web           => c_use_byte_web          ,         
         c_web_width              => c_web_width             ,         
                                                                       
         -- Other Miscellaneous Configurations                         
         c_mux_pipeline_stages    => c_mux_pipeline_stages   ,         
         c_use_ecc                => c_use_ecc               ,         
         c_rst_priority_b         =>  "CE"                   ,
         c_rst_priority_a         =>  "CE"                                                               
                                                               
       -- Use component defaults (see coregen_comp_defs.vhd) for these unused params                                                        
         --c_has_injecterr          => 0,                                                      
         --c_corename               => c_corename                                                     
         )                                                              
                                                                        
      port map                                                          
         (                                                              
         clka    => clka,                                           
         rsta    => ssra,                                           
         dina    => dina,                                           
         addra   => addra,                                          
         ena     => ena,                                            
         regcea  => regcea,                                         
         wea     => wea,                                            
         douta   => douta,                                          
                                                                    
                                                                    
         clkb    => clkb,                                           
         rstb    => ssrb,                                           
         dinb    => dinb,                                           
         addrb   => addrb,                                          
         enb     => enb,                                            
         regceb  => regceb,                                         
         web     => web,                                            
         doutb   => doutb,                                        
                                                                     
         dbiterr => dbiterr,                                         
         sbiterr => sbiterr,                                          
         
       -- New ports, unused by legacy users  
         INJECTSBITERR => '0',  -- input
         INJECTDBITERR => '0',  -- input
         RDADDRECC     => open  -- output
         
         
         );                                                              
  end generate YES_V6_OR_S6;
end implementation;                                                      

























