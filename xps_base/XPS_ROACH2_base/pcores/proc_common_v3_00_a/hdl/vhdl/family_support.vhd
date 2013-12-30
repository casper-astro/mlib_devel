--------------------------------------------------------------------------------
-- $Id: family_support.vhd,v 1.5.2.1.2.1 2009/04/28 23:39:35 ostlerf Exp $
--------------------------------------------------------------------------------
-- family_support.vhd - package
--------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2005-2008 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
--------------------------------------------------------------------------------
-- Filename:   family_support.vhd
--
-- Description: 
--
--      FAMILIES, PRIMITIVES and PRIMITIVE AVAILABILITY GUARDS
--
--              This package allows to determine whether a given primitive
--              or set of primitives is available in an FPGA family of interest.
--
--              The key element is the function, 'supported', which is
--              available in four variants (overloads). Here are examples
--              of each:
--
--                supported(virtex2, u_RAMB16_S2)
--    
--                supported("Virtex2", u_RAMB16_S2)
--    
--                supported(spartan3, (u_MUXCY, u_XORCY, u_FD))
--
--                supported("spartan3", (u_MUXCY, u_XORCY, u_FD))
--
--              The 'supported' function returns true if and only
--              if all of the primitives being tested, as given in the
--              second argument, are available in the FPGA family that
--              is given in the first argument.
--
--              The first argument can be either one of the FPGA family
--              names from the enumeration type, 'families_type', or a
--              (case insensitive) string giving the same information.
--              The family name 'nofamily' is special and supports
--              none of the primitives.
--
--              The second argument is either a primitive or a list of
--              primitives. The set of primitive names that can be
--              tested is defined by the declaration of the
--              enumeration type, 'primitives_type'. The names are
--              the UNISIM-library names for the primitives, prefixed
--              by "u_". (The prefix avoids introducing a name that
--              conflicts with the component declaration for the primitive.)
--               
--              The array type, 'primitive_array_type' is the basis for
--              forming lists of primitives. Typically, a fixed list
--              of primitves is expressed as a VHDL aggregate, a
--              comma separated list of primitives enclosed in
--              parentheses. (See the last two examples, above.)
--
--              The 'supported' function can be used as a guard
--              condition for a piece of code that depends on primitives
--              (primitive availability guard). Here is an example:
--
--
--                  GEN : if supported(C_FAMILY, (u_MUXCY, u_XORCY)) generate
--                  begin
--                        ... Here, an implementation that depends on
--                        ... MUXCY and XORCY.
--                  end generate;
--
--
--              It can also be used in an assertion statement
--              to give warnings about problems that can arise from
--              attempting to implement into a family that does not
--              support all of the required primitives:
--
--
--                  assert supported(C_FAMILY, <primtive list>)
--                    report "This module cannot be implemnted " &
--                           "into family, " & C_FAMILY &
--                           ", because one or more of the primitives, " &
--                           "<primitive_list>" & ", is not supported."
--                    severity error;
--
--
--      A NOTE ON USAGE
--
--              It is probably best to take an exception to the coding
--              guidelines and make the names that are needed
--              from this package visible to a VHDL compilation unit by
--
--                  library <libname>;
--                  use     <libname>.family_support.all;
--
--              rather than by calling out individual names in use clauses.
--              (VHDL tools do not have a common interpretation at present
--              on whether
--
--                  use <libname>.family_support.primitives_type"
--
--              makes the enumeration literals visible.)

--
--      ADDITIONAL FEATURES
--
--            - A function, native_lut_size, is available to allow
--              the caller to query the largest sized LUT available in a given
--              FPGA family.
--
--            - A function, equalIgnoringCase, is available to compare strings
--              with case insensitivity. While this can be used to establish
--              whether the target family is some particular family, such
--              usage is discouraged and should be limited to legacy
--              situations or the rare situations where primitive
--              availability guards will not suffice.
--
--------------------------------------------------------------------------------
-- Author:     FLO
-- History:
-- FLO         2005Mar24         - First Version
--
-- FLO         11/30/05
-- ^^^^^^   
-- Virtex5 added.
-- ~~~~~~
-- TK          03/17/06          Corrected a Spartan3e issue in myimage
-- ~~~~~~
-- FLO         04/26/06
-- ^^^^^^   
--   Added the native_lut_size function.
-- ~~~~~~
-- FLO         08/10/06
-- ^^^^^^
--   Added support for families virtex, spartan2 and spartan2e.
-- ~~~~~~
-- FLO         08/25/06
-- ^^^^^^
--   Enhanced the warning in function str2fam. Now when a string that is
--   passed in the call as a parameter does not correspond to a supported fpga
--   family, the string value of the passed string is mentioned in the warning
--   and it is explicitly stated that the returned value is 'nofamily'.
-- ~~~~~~
-- FLO         08/26/06
-- ^^^^^^
--   - Updated the virtex5 primitive set to a more recent list and
--     removed primitives (TEMAC, PCIE, etc.) that are not present
--     in all virtex5 family members.
--   - Added function equalIgnoringCase and an admonition to use it
--     as little as possible.
--   - Made some improvements to descriptions inside comments.
-- ~~~~~~
-- FLO         08/28/06
-- ^^^^^^
--   Added support for families spartan3a and spartan3an. These are initially
--   taken to have the same primitives as spartan3e.
-- ~~~~~~
-- FLO         10/28/06
-- ^^^^^^
--   Changed function str2fam so that it no longer depends on the VHDL
--   attribute, 'VAL. This is an XST workaround.
-- ~~~~~~
-- FLO         03/08/07
-- ^^^^^^
--   Updated spartan3a and sparan3an.
--   Added spartan3adsp.
-- ~~~~~~
-- FLO         08/31/07
-- ^^^^^^
--   A performance XST workaround was implemented to address slowness
--   associated with primitive availability guards. The workaround changes
--   the way that the fam_has_prim constant is initialized (aggregate
--   rather than a system of function and procedure calls).
-- ~~~~~~
-- FLO         04/11/08
-- ^^^^^^
--   Added these families: aspartan3e, aspartan3a, aspartan3an, aspartan3adsp
-- ~~~~~~
-- FLO         04/14/08
-- ^^^^^^
--   Removed family: aspartan3an
-- ~~~~~~
-- FLO         06/25/08
-- ^^^^^^
--   Added these families: qvirtex4, qrvirtex4
-- ~~~~~~
-- FLO         07/26/08
-- ^^^^^^
--   The BSCAN primitive for spartan3e is now BSCAN_SPARTAN3 instead
--   of BSCAN_SPARTAN3E.
-- ~~~~~~
-- FLO         09/02/06
-- ^^^^^^
--   Added an initial approximation of primitives for spartan6 and virtex6.
-- ~~~~~~
-- FLO         09/04/28
-- ^^^^^^
--  -Removed primitive u_BSCAN_SPARTAN3A from spartan6.
--  -Added the 5 and 6 LUTs to spartan6.
-- ~~~~~~
--------------------------------------------------------------------------------
-- Naming Conventions:
--    active low signals: "*_n"
--    clock signals: "clk", "clk_div#", "clk_#x"
--    reset signals: "rst", "rst_n"
--    generics: "C_*"
--    user defined types: "*_TYPE"
--    state machine next state: "*_ns"
--    state machine current state: "*_cs"
--    combinational signals: "*_cmb"
--    pipelined or register delay signals: "*_d#"
--    counter signals: "*cnt*"
--    clock enable signals: "*_ce"
--    internal version of output port: "*_i"
--    device pins: "*_pin"
--    ports:- Names begin with Uppercase
--    processes: "*_PROCESS"
--    component instantiations: "<ENTITY_>I_<#|FUNC>
--------------------------------------------------------------------------------

package family_support is

    type families_type is
    (
       nofamily
     , virtex
     , spartan2
     , spartan2e
     , virtexe
     , virtex2
     , qvirtex2    -- Taken to be identical to the virtex2 primitive set.
     , qrvirtex2   -- Taken to be identical to the virtex2 primitive set.
     , virtex2p
     , spartan3
     , aspartan3
     , virtex4
     , virtex4lx
     , virtex4fx
     , virtex4sx
     , spartan3e
     , virtex5
     , spartan3a
     , spartan3an
     , spartan3adsp
     , aspartan3e
     , aspartan3a
     , aspartan3adsp
     , qvirtex4
     , qrvirtex4
     , spartan6
     , virtex6
    );


    type primitives_type is
    (
       u_AND2
     , u_AND2B1L
     , u_AND3
     , u_AND4
     , u_AUTOBUF
     , u_BSCAN_SPARTAN2
     , u_BSCAN_SPARTAN3
     , u_BSCAN_SPARTAN3A
     , u_BSCAN_SPARTAN3E
     , u_BSCAN_SPARTAN6
     , u_BSCAN_VIRTEX
     , u_BSCAN_VIRTEX2
     , u_BSCAN_VIRTEX4
     , u_BSCAN_VIRTEX5
     , u_BSCAN_VIRTEX6
     , u_BUF
     , u_BUFCF
     , u_BUFE
     , u_BUFG
     , u_BUFGCE
     , u_BUFGCE_1
     , u_BUFGCTRL
     , u_BUFGDLL
     , u_BUFGMUX
     , u_BUFGMUX_1
     , u_BUFGMUX_CTRL
     , u_BUFGMUX_VIRTEX4
     , u_BUFGP
     , u_BUFH
     , u_BUFHCE
     , u_BUFIO
     , u_BUFIO2
     , u_BUFIO2_2CLK
     , u_BUFIO2FB
     , u_BUFIO2FB_2CLK
     , u_BUFIODQS
     , u_BUFPLL
     , u_BUFPLL_MCB
     , u_BUFR
     , u_BUFT
     , u_CAPTURE_SPARTAN2
     , u_CAPTURE_SPARTAN3
     , u_CAPTURE_SPARTAN3A
     , u_CAPTURE_SPARTAN3E
     , u_CAPTURE_VIRTEX
     , u_CAPTURE_VIRTEX2
     , u_CAPTURE_VIRTEX4
     , u_CAPTURE_VIRTEX5
     , u_CAPTURE_VIRTEX6
     , u_CARRY4
     , u_CFGLUT5
     , u_CLKDLL
     , u_CLKDLLE
     , u_CLKDLLHF
     , u_CRC32
     , u_CRC64
     , u_DCIRESET
     , u_DCM
     , u_DCM_ADV
     , u_DCM_BASE
     , u_DCM_CLKGEN
     , u_DCM_PS
     , u_DNA_PORT
     , u_DSP48
     , u_DSP48A
     , u_DSP48A1
     , u_DSP48E
     , u_DSP48E1
     , u_DUMMY_INV
     , u_DUMMY_NOR2
     , u_EFUSE_USR
     , u_EMAC
     , u_FD
     , u_FD_1
     , u_FDC
     , u_FDC_1
     , u_FDCE
     , u_FDCE_1
     , u_FDCP
     , u_FDCP_1
     , u_FDCPE
     , u_FDCPE_1
     , u_FDDRCPE
     , u_FDDRRSE
     , u_FDE
     , u_FDE_1
     , u_FDP
     , u_FDP_1
     , u_FDPE
     , u_FDPE_1
     , u_FDR
     , u_FDR_1
     , u_FDRE
     , u_FDRE_1
     , u_FDRS
     , u_FDRS_1
     , u_FDRSE
     , u_FDRSE_1
     , u_FDS
     , u_FDS_1
     , u_FDSE
     , u_FDSE_1
     , u_FIFO16
     , u_FIFO18
     , u_FIFO18_36
     , u_FIFO18E1
     , u_FIFO36
     , u_FIFO36_72
     , u_FIFO36E1
     , u_FMAP
     , u_FRAME_ECC_VIRTEX4
     , u_FRAME_ECC_VIRTEX5
     , u_FRAME_ECC_VIRTEX6
     , u_GND
     , u_GT10_10GE_4
     , u_GT10_10GE_8
     , u_GT10_10GFC_4
     , u_GT10_10GFC_8
     , u_GT10_AURORA_1
     , u_GT10_AURORA_2
     , u_GT10_AURORA_4
     , u_GT10_AURORAX_4
     , u_GT10_AURORAX_8
     , u_GT10_CUSTOM
     , u_GT10_INFINIBAND_1
     , u_GT10_INFINIBAND_2
     , u_GT10_INFINIBAND_4
     , u_GT10_OC192_4
     , u_GT10_OC192_8
     , u_GT10_OC48_1
     , u_GT10_OC48_2
     , u_GT10_OC48_4
     , u_GT10_PCI_EXPRESS_1
     , u_GT10_PCI_EXPRESS_2
     , u_GT10_PCI_EXPRESS_4
     , u_GT10_XAUI_1
     , u_GT10_XAUI_2
     , u_GT10_XAUI_4
     , u_GT11CLK
     , u_GT11CLK_MGT
     , u_GT11_CUSTOM
     , u_GT_AURORA_1
     , u_GT_AURORA_2
     , u_GT_AURORA_4
     , u_GT_CUSTOM
     , u_GT_ETHERNET_1
     , u_GT_ETHERNET_2
     , u_GT_ETHERNET_4
     , u_GT_FIBRE_CHAN_1
     , u_GT_FIBRE_CHAN_2
     , u_GT_FIBRE_CHAN_4
     , u_GT_INFINIBAND_1
     , u_GT_INFINIBAND_2
     , u_GT_INFINIBAND_4
     , u_GTPA1_DUAL
     , u_GT_XAUI_1
     , u_GT_XAUI_2
     , u_GT_XAUI_4
     , u_GTXE1
     , u_IBUF
     , u_IBUF_AGP
     , u_IBUF_CTT
     , u_IBUF_DLY_ADJ
     , u_IBUFDS
     , u_IBUFDS_DIFF_OUT
     , u_IBUFDS_DLY_ADJ
     , u_IBUFDS_GTXE1
     , u_IBUFG
     , u_IBUFG_AGP
     , u_IBUFG_CTT
     , u_IBUFGDS
     , u_IBUFGDS_DIFF_OUT
     , u_IBUFG_GTL
     , u_IBUFG_GTLP
     , u_IBUFG_HSTL_I
     , u_IBUFG_HSTL_III
     , u_IBUFG_HSTL_IV
     , u_IBUFG_LVCMOS18
     , u_IBUFG_LVCMOS2
     , u_IBUFG_LVDS
     , u_IBUFG_LVPECL
     , u_IBUFG_PCI33_3
     , u_IBUFG_PCI33_5
     , u_IBUFG_PCI66_3
     , u_IBUFG_PCIX66_3
     , u_IBUFG_SSTL2_I
     , u_IBUFG_SSTL2_II
     , u_IBUFG_SSTL3_I
     , u_IBUFG_SSTL3_II
     , u_IBUF_GTL
     , u_IBUF_GTLP
     , u_IBUF_HSTL_I
     , u_IBUF_HSTL_III
     , u_IBUF_HSTL_IV
     , u_IBUF_LVCMOS18
     , u_IBUF_LVCMOS2
     , u_IBUF_LVDS
     , u_IBUF_LVPECL
     , u_IBUF_PCI33_3
     , u_IBUF_PCI33_5
     , u_IBUF_PCI66_3
     , u_IBUF_PCIX66_3
     , u_IBUF_SSTL2_I
     , u_IBUF_SSTL2_II
     , u_IBUF_SSTL3_I
     , u_IBUF_SSTL3_II
     , u_ICAP_SPARTAN3A
     , u_ICAP_SPARTAN6
     , u_ICAP_VIRTEX2
     , u_ICAP_VIRTEX4
     , u_ICAP_VIRTEX5
     , u_ICAP_VIRTEX6
     , u_IDDR
     , u_IDDR2
     , u_IDDR_2CLK
     , u_IDELAY
     , u_IDELAYCTRL
     , u_IFDDRCPE
     , u_IFDDRRSE
     , u_INV
     , u_IOBUF
     , u_IOBUF_AGP
     , u_IOBUF_CTT
     , u_IOBUFDS
     , u_IOBUFDS_DIFF_OUT
     , u_IOBUF_F_12
     , u_IOBUF_F_16
     , u_IOBUF_F_2
     , u_IOBUF_F_24
     , u_IOBUF_F_4
     , u_IOBUF_F_6
     , u_IOBUF_F_8
     , u_IOBUF_GTL
     , u_IOBUF_GTLP
     , u_IOBUF_HSTL_I
     , u_IOBUF_HSTL_III
     , u_IOBUF_HSTL_IV
     , u_IOBUF_LVCMOS18
     , u_IOBUF_LVCMOS2
     , u_IOBUF_LVDS
     , u_IOBUF_LVPECL
     , u_IOBUF_PCI33_3
     , u_IOBUF_PCI33_5
     , u_IOBUF_PCI66_3
     , u_IOBUF_PCIX66_3
     , u_IOBUF_S_12
     , u_IOBUF_S_16
     , u_IOBUF_S_2
     , u_IOBUF_S_24
     , u_IOBUF_S_4
     , u_IOBUF_S_6
     , u_IOBUF_S_8
     , u_IOBUF_SSTL2_I
     , u_IOBUF_SSTL2_II
     , u_IOBUF_SSTL3_I
     , u_IOBUF_SSTL3_II
     , u_IODELAY
     , u_IODELAY2
     , u_IODELAYE1
     , u_IODRP2
     , u_IODRP2_MCB
     , u_ISERDES
     , u_ISERDES2
     , u_ISERDESE1
     , u_ISERDES_NODELAY
     , u_JTAGPPC
     , u_JTAG_SIM_SPARTAN6
     , u_JTAG_SIM_VIRTEX6
     , u_KEEPER
     , u_KEY_CLEAR
     , u_LD
     , u_LD_1
     , u_LDC
     , u_LDC_1
     , u_LDCE
     , u_LDCE_1
     , u_LDCP
     , u_LDCP_1
     , u_LDCPE
     , u_LDCPE_1
     , u_LDE
     , u_LDE_1
     , u_LDP
     , u_LDP_1
     , u_LDPE
     , u_LDPE_1
     , u_LUT1
     , u_LUT1_D
     , u_LUT1_L
     , u_LUT2
     , u_LUT2_D
     , u_LUT2_L
     , u_LUT3
     , u_LUT3_D
     , u_LUT3_L
     , u_LUT4
     , u_LUT4_D
     , u_LUT4_L
     , u_LUT5
     , u_LUT5_D
     , u_LUT5_L
     , u_LUT6
     , u_LUT6_D
     , u_LUT6_L
     , u_MCB
     , u_MMCM_ADV
     , u_MMCM_BASE
     , u_MULT18X18
     , u_MULT18X18S
     , u_MULT18X18SIO
     , u_MULT_AND
     , u_MUXCY
     , u_MUXCY_D
     , u_MUXCY_L
     , u_MUXF5
     , u_MUXF5_D
     , u_MUXF5_L
     , u_MUXF6
     , u_MUXF6_D
     , u_MUXF6_L
     , u_MUXF7
     , u_MUXF7_D
     , u_MUXF7_L
     , u_MUXF8
     , u_MUXF8_D
     , u_MUXF8_L
     , u_NAND2
     , u_NAND3
     , u_NAND4
     , u_NOR2
     , u_NOR3
     , u_NOR4
     , u_OBUF
     , u_OBUF_AGP
     , u_OBUF_CTT
     , u_OBUFDS
     , u_OBUF_F_12
     , u_OBUF_F_16
     , u_OBUF_F_2
     , u_OBUF_F_24
     , u_OBUF_F_4
     , u_OBUF_F_6
     , u_OBUF_F_8
     , u_OBUF_GTL
     , u_OBUF_GTLP
     , u_OBUF_HSTL_I
     , u_OBUF_HSTL_III
     , u_OBUF_HSTL_IV
     , u_OBUF_LVCMOS18
     , u_OBUF_LVCMOS2
     , u_OBUF_LVDS
     , u_OBUF_LVPECL
     , u_OBUF_PCI33_3
     , u_OBUF_PCI33_5
     , u_OBUF_PCI66_3
     , u_OBUF_PCIX66_3
     , u_OBUF_S_12
     , u_OBUF_S_16
     , u_OBUF_S_2
     , u_OBUF_S_24
     , u_OBUF_S_4
     , u_OBUF_S_6
     , u_OBUF_S_8
     , u_OBUF_SSTL2_I
     , u_OBUF_SSTL2_II
     , u_OBUF_SSTL3_I
     , u_OBUF_SSTL3_II
     , u_OBUFT
     , u_OBUFT_AGP
     , u_OBUFT_CTT
     , u_OBUFTDS
     , u_OBUFT_F_12
     , u_OBUFT_F_16
     , u_OBUFT_F_2
     , u_OBUFT_F_24
     , u_OBUFT_F_4
     , u_OBUFT_F_6
     , u_OBUFT_F_8
     , u_OBUFT_GTL
     , u_OBUFT_GTLP
     , u_OBUFT_HSTL_I
     , u_OBUFT_HSTL_III
     , u_OBUFT_HSTL_IV
     , u_OBUFT_LVCMOS18
     , u_OBUFT_LVCMOS2
     , u_OBUFT_LVDS
     , u_OBUFT_LVPECL
     , u_OBUFT_PCI33_3
     , u_OBUFT_PCI33_5
     , u_OBUFT_PCI66_3
     , u_OBUFT_PCIX66_3
     , u_OBUFT_S_12
     , u_OBUFT_S_16
     , u_OBUFT_S_2
     , u_OBUFT_S_24
     , u_OBUFT_S_4
     , u_OBUFT_S_6
     , u_OBUFT_S_8
     , u_OBUFT_SSTL2_I
     , u_OBUFT_SSTL2_II
     , u_OBUFT_SSTL3_I
     , u_OBUFT_SSTL3_II
     , u_OCT_CALIBRATE
     , u_ODDR
     , u_ODDR2
     , u_OFDDRCPE
     , u_OFDDRRSE
     , u_OFDDRTCPE
     , u_OFDDRTRSE
     , u_OR2
     , u_OR2L
     , u_OR3
     , u_OR4
     , u_ORCY
     , u_OSERDES
     , u_OSERDES2
     , u_OSERDESE1
     , u_PCIE_2_0
     , u_PCIE_A1
     , u_PLL_ADV
     , u_PLL_BASE
     , u_PMCD
     , u_POST_CRC_INTERNAL
     , u_PPC405
     , u_PPC405_ADV
     , u_PPR_FRAME
     , u_PULLDOWN
     , u_PULLUP
     , u_RAM128X1D
     , u_RAM128X1S
     , u_RAM128X1S_1
     , u_RAM16X1D
     , u_RAM16X1D_1
     , u_RAM16X1S
     , u_RAM16X1S_1
     , u_RAM16X2S
     , u_RAM16X4S
     , u_RAM16X8S
     , u_RAM256X1S
     , u_RAM32M
     , u_RAM32X1D
     , u_RAM32X1D_1
     , u_RAM32X1S
     , u_RAM32X1S_1
     , u_RAM32X2S
     , u_RAM32X4S
     , u_RAM32X8S
     , u_RAM64M
     , u_RAM64X1D
     , u_RAM64X1D_1
     , u_RAM64X1S
     , u_RAM64X1S_1
     , u_RAM64X2S
     , u_RAMB16
     , u_RAMB16BWE
     , u_RAMB16BWER
     , u_RAMB16BWE_S18
     , u_RAMB16BWE_S18_S18
     , u_RAMB16BWE_S18_S9
     , u_RAMB16BWE_S36
     , u_RAMB16BWE_S36_S18
     , u_RAMB16BWE_S36_S36
     , u_RAMB16BWE_S36_S9
     , u_RAMB16_S1
     , u_RAMB16_S18
     , u_RAMB16_S18_S18
     , u_RAMB16_S18_S36
     , u_RAMB16_S1_S1
     , u_RAMB16_S1_S18
     , u_RAMB16_S1_S2
     , u_RAMB16_S1_S36
     , u_RAMB16_S1_S4
     , u_RAMB16_S1_S9
     , u_RAMB16_S2
     , u_RAMB16_S2_S18
     , u_RAMB16_S2_S2
     , u_RAMB16_S2_S36
     , u_RAMB16_S2_S4
     , u_RAMB16_S2_S9
     , u_RAMB16_S36
     , u_RAMB16_S36_S36
     , u_RAMB16_S4
     , u_RAMB16_S4_S18
     , u_RAMB16_S4_S36
     , u_RAMB16_S4_S4
     , u_RAMB16_S4_S9
     , u_RAMB16_S9
     , u_RAMB16_S9_S18
     , u_RAMB16_S9_S36
     , u_RAMB16_S9_S9
     , u_RAMB18
     , u_RAMB18E1
     , u_RAMB18SDP
     , u_RAMB32_S64_ECC
     , u_RAMB36
     , u_RAMB36E1
     , u_RAMB36_EXP
     , u_RAMB36SDP
     , u_RAMB36SDP_EXP
     , u_RAMB4_S1
     , u_RAMB4_S16
     , u_RAMB4_S16_S16
     , u_RAMB4_S1_S1
     , u_RAMB4_S1_S16
     , u_RAMB4_S1_S2
     , u_RAMB4_S1_S4
     , u_RAMB4_S1_S8
     , u_RAMB4_S2
     , u_RAMB4_S2_S16
     , u_RAMB4_S2_S2
     , u_RAMB4_S2_S4
     , u_RAMB4_S2_S8
     , u_RAMB4_S4
     , u_RAMB4_S4_S16
     , u_RAMB4_S4_S4
     , u_RAMB4_S4_S8
     , u_RAMB4_S8
     , u_RAMB4_S8_S16
     , u_RAMB4_S8_S8
     , u_RAMB8BWER
     , u_ROM128X1
     , u_ROM16X1
     , u_ROM256X1
     , u_ROM32X1
     , u_ROM64X1
     , u_SLAVE_SPI
     , u_SPI_ACCESS
     , u_SRL16
     , u_SRL16_1
     , u_SRL16E
     , u_SRL16E_1
     , u_SRLC16
     , u_SRLC16_1
     , u_SRLC16E
     , u_SRLC16E_1
     , u_SRLC32E
     , u_STARTBUF_SPARTAN2
     , u_STARTBUF_SPARTAN3
     , u_STARTBUF_SPARTAN3E
     , u_STARTBUF_VIRTEX
     , u_STARTBUF_VIRTEX2
     , u_STARTBUF_VIRTEX4
     , u_STARTUP_SPARTAN2
     , u_STARTUP_SPARTAN3
     , u_STARTUP_SPARTAN3A
     , u_STARTUP_SPARTAN3E
     , u_STARTUP_SPARTAN6
     , u_STARTUP_VIRTEX
     , u_STARTUP_VIRTEX2
     , u_STARTUP_VIRTEX4
     , u_STARTUP_VIRTEX5
     , u_STARTUP_VIRTEX6
     , u_SUSPEND_SYNC
     , u_SYSMON
     , u_TEMAC_SINGLE
     , u_TOC
     , u_TOCBUF
     , u_USR_ACCESS_VIRTEX4
     , u_USR_ACCESS_VIRTEX5
     , u_USR_ACCESS_VIRTEX6
     , u_VCC
     , u_XNOR2
     , u_XNOR3
     , u_XNOR4
     , u_XOR2
     , u_XOR3
     , u_XOR4
     , u_XORCY
     , u_XORCY_D
     , u_XORCY_L
    );

    type primitive_array_type is array (natural range <>) of primitives_type;


    ---------------------------------------------------------------------------- 
    -- Returns true if primitive is available in family.
    --
    -- Examples:
    --
    --     supported(virtex2, u_RAMB16_S2) returns true because the RAMB16_S2
    --                                     primitive is available in the
    --                                     virtex2 family.
    --
    --     supported(spartan3, u_RAM4B_S4) returns false because the RAMB4_S4
    --                                     primitive is not available in the
    --                                     spartan3 family.
    ---------------------------------------------------------------------------- 
    function supported( family         : families_type;
                        primitive      : primitives_type
                      ) return boolean;


    ---------------------------------------------------------------------------- 
    -- This is an overload of function 'supported' (see above). It allows a list
    -- of primitives to be tested.
    --
    -- Returns true if all of primitives in the list are available in family.
    --
    -- Example:        supported(spartan3, (u_MUXCY, u_XORCY, u_FD))
    -- is
    -- equivalent to:  supported(spartan3, u_MUXCY) and
    --                 supported(spartan3, u_XORCY) and
    --                 supported(spartan3, u_FD);
    ---------------------------------------------------------------------------- 
    function supported( family         : families_type;
                        primitives     : primitive_array_type
                      ) return boolean;


    ---------------------------------------------------------------------------- 
    -- Below, are overloads of function 'supported' that allow the family
    -- parameter to be passed as a string. These correspond to the above two
    -- functions otherwise.
    ---------------------------------------------------------------------------- 
    function supported( fam_as_str     : string;
                        primitive      : primitives_type
                      ) return boolean;


    function supported( fam_as_str     : string;
                        primitives     : primitive_array_type
                      ) return boolean;



    ---------------------------------------------------------------------------- 
    -- Conversions from/to STRING to/from families_type.
    -- These are convenience functions that are not normally needed when
    -- using the 'supported' functions.
    ---------------------------------------------------------------------------- 
    function str2fam( fam_as_string  : string ) return families_type;


    function fam2str( fam :  families_type ) return string;

    ---------------------------------------------------------------------------- 
    -- Function: native_lut_size
    --
    -- Returns the largest LUT size available in FPGA family, fam.
    -- If no LUT is available in fam, then returns zero by default, unless
    -- the call specifies a no_lut_return_val, in which case this value
    -- is returned.
    --
    -- The function is available in two overload versions, one for each
    -- way of passing the fam argument.
    ---------------------------------------------------------------------------- 
    function native_lut_size( fam : families_type;
                              no_lut_return_val : natural := 0
                            ) return natural;

    function native_lut_size( fam_as_string : string;
                              no_lut_return_val : natural := 0
                            ) return natural;
                      

    ---------------------------------------------------------------------------- 
    -- Function: equalIgnoringCase
    --
    -- Compare one string against another for equality with case insensitivity.
    -- Can be used to test see if a family, C_FAMILY, is equal to some
    -- family. However such usage is discouraged. Use instead availability
    -- primitive guards based on the function, 'supported', wherever possible.
    ---------------------------------------------------------------------------- 
    function equalIgnoringCase( str1, str2 : string ) return boolean;

end package family_support;



package body family_support is

    type     prim_status_type is (
                                    n  -- no
                                  , y  -- yes
                                  , u  -- unknown, not used. However, we use
                                       -- an enumeration to allow for
                                       -- possible future enhancement.
                                 );

    type     fam_prim_status is array (primitives_type) of prim_status_type;

    type     fam_has_prim_type is array (families_type) of fam_prim_status;

-- Performance workaround (XST procedure and function handling).
-- The fam_has_prim constant is initialized by an aggregate rather than by the
-- following function. A version of this file with this function not
-- commented was employed in building the aggregate. So, what is below still
-- defines the family-primitive matirix.
--#    ----------------------------------------------------------------------------
--#    --  This function is used to populate the matrix of family/primitive values.
--#    ----------------------------------------------------------------------------
--#    ---(
--#    function prim_population return fam_has_prim_type is
--#        variable pp : fam_has_prim_type := (others => (others => n));
--#
--#        procedure set_to(  stat      : prim_status_type
--#                         ; fam       : families_type
--#                         ; prim_list : primitive_array_type
--#                        ) is
--#        begin
--#            for i in prim_list'range loop
--#                pp(fam)(prim_list(i)) := stat;
--#            end loop;
--#        end set_to;
--#
--#    begin
--#        set_to(y, virtex, (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGDLL
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_VIRTEX
--#                            , u_CLKDLL
--#                            , u_CLKDLLHF
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFG
--#                            , u_IBUFG_AGP
--#                            , u_IBUFG_CTT
--#                            , u_IBUFG_GTL
--#                            , u_IBUFG_GTLP
--#                            , u_IBUFG_HSTL_I
--#                            , u_IBUFG_HSTL_III
--#                            , u_IBUFG_HSTL_IV
--#                            , u_IBUFG_LVCMOS2
--#                            , u_IBUFG_PCI33_3
--#                            , u_IBUFG_PCI33_5
--#                            , u_IBUFG_PCI66_3
--#                            , u_IBUFG_SSTL2_I
--#                            , u_IBUFG_SSTL2_II
--#                            , u_IBUFG_SSTL3_I
--#                            , u_IBUFG_SSTL3_II
--#                            , u_IBUF_AGP
--#                            , u_IBUF_CTT
--#                            , u_IBUF_GTL
--#                            , u_IBUF_GTLP
--#                            , u_IBUF_HSTL_I
--#                            , u_IBUF_HSTL_III
--#                            , u_IBUF_HSTL_IV
--#                            , u_IBUF_LVCMOS2
--#                            , u_IBUF_PCI33_3
--#                            , u_IBUF_PCI33_5
--#                            , u_IBUF_PCI66_3
--#                            , u_IBUF_SSTL2_I
--#                            , u_IBUF_SSTL2_II
--#                            , u_IBUF_SSTL3_I
--#                            , u_IBUF_SSTL3_II
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUF_AGP
--#                            , u_IOBUF_CTT
--#                            , u_IOBUF_F_12
--#                            , u_IOBUF_F_16
--#                            , u_IOBUF_F_2
--#                            , u_IOBUF_F_24
--#                            , u_IOBUF_F_4
--#                            , u_IOBUF_F_6
--#                            , u_IOBUF_F_8
--#                            , u_IOBUF_GTL
--#                            , u_IOBUF_GTLP
--#                            , u_IOBUF_HSTL_I
--#                            , u_IOBUF_HSTL_III
--#                            , u_IOBUF_HSTL_IV
--#                            , u_IOBUF_LVCMOS2
--#                            , u_IOBUF_PCI33_3
--#                            , u_IOBUF_PCI33_5
--#                            , u_IOBUF_PCI66_3
--#                            , u_IOBUF_SSTL2_I
--#                            , u_IOBUF_SSTL2_II
--#                            , u_IOBUF_SSTL3_I
--#                            , u_IOBUF_SSTL3_II
--#                            , u_IOBUF_S_12
--#                            , u_IOBUF_S_16
--#                            , u_IOBUF_S_2
--#                            , u_IOBUF_S_24
--#                            , u_IOBUF_S_4
--#                            , u_IOBUF_S_6
--#                            , u_IOBUF_S_8
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFT
--#                            , u_OBUFT_AGP
--#                            , u_OBUFT_CTT
--#                            , u_OBUFT_F_12
--#                            , u_OBUFT_F_16
--#                            , u_OBUFT_F_2
--#                            , u_OBUFT_F_24
--#                            , u_OBUFT_F_4
--#                            , u_OBUFT_F_6
--#                            , u_OBUFT_F_8
--#                            , u_OBUFT_GTL
--#                            , u_OBUFT_GTLP
--#                            , u_OBUFT_HSTL_I
--#                            , u_OBUFT_HSTL_III
--#                            , u_OBUFT_HSTL_IV
--#                            , u_OBUFT_LVCMOS2
--#                            , u_OBUFT_PCI33_3
--#                            , u_OBUFT_PCI33_5
--#                            , u_OBUFT_PCI66_3
--#                            , u_OBUFT_SSTL2_I
--#                            , u_OBUFT_SSTL2_II
--#                            , u_OBUFT_SSTL3_I
--#                            , u_OBUFT_SSTL3_II
--#                            , u_OBUFT_S_12
--#                            , u_OBUFT_S_16
--#                            , u_OBUFT_S_2
--#                            , u_OBUFT_S_24
--#                            , u_OBUFT_S_4
--#                            , u_OBUFT_S_6
--#                            , u_OBUFT_S_8
--#                            , u_OBUF_AGP
--#                            , u_OBUF_CTT
--#                            , u_OBUF_F_12
--#                            , u_OBUF_F_16
--#                            , u_OBUF_F_2
--#                            , u_OBUF_F_24
--#                            , u_OBUF_F_4
--#                            , u_OBUF_F_6
--#                            , u_OBUF_F_8
--#                            , u_OBUF_GTL
--#                            , u_OBUF_GTLP
--#                            , u_OBUF_HSTL_I
--#                            , u_OBUF_HSTL_III
--#                            , u_OBUF_HSTL_IV
--#                            , u_OBUF_LVCMOS2
--#                            , u_OBUF_PCI33_3
--#                            , u_OBUF_PCI33_5
--#                            , u_OBUF_PCI66_3
--#                            , u_OBUF_SSTL2_I
--#                            , u_OBUF_SSTL2_II
--#                            , u_OBUF_SSTL3_I
--#                            , u_OBUF_SSTL3_II
--#                            , u_OBUF_S_12
--#                            , u_OBUF_S_16
--#                            , u_OBUF_S_2
--#                            , u_OBUF_S_24
--#                            , u_OBUF_S_4
--#                            , u_OBUF_S_6
--#                            , u_OBUF_S_8
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAMB4_S1
--#                            , u_RAMB4_S16
--#                            , u_RAMB4_S16_S16
--#                            , u_RAMB4_S1_S1
--#                            , u_RAMB4_S1_S16
--#                            , u_RAMB4_S1_S2
--#                            , u_RAMB4_S1_S4
--#                            , u_RAMB4_S1_S8
--#                            , u_RAMB4_S2
--#                            , u_RAMB4_S2_S16
--#                            , u_RAMB4_S2_S2
--#                            , u_RAMB4_S2_S4
--#                            , u_RAMB4_S2_S8
--#                            , u_RAMB4_S4
--#                            , u_RAMB4_S4_S16
--#                            , u_RAMB4_S4_S4
--#                            , u_RAMB4_S4_S8
--#                            , u_RAMB4_S8
--#                            , u_RAMB4_S8_S16
--#                            , u_RAMB4_S8_S8
--#                            , u_ROM16X1
--#                            , u_ROM32X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_STARTBUF_VIRTEX
--#                            , u_STARTUP_VIRTEX
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        set_to(y, spartan2, (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_SPARTAN2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGDLL
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_SPARTAN2
--#                            , u_CLKDLL
--#                            , u_CLKDLLHF
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFG
--#                            , u_IBUFG_AGP
--#                            , u_IBUFG_CTT
--#                            , u_IBUFG_GTL
--#                            , u_IBUFG_GTLP
--#                            , u_IBUFG_HSTL_I
--#                            , u_IBUFG_HSTL_III
--#                            , u_IBUFG_HSTL_IV
--#                            , u_IBUFG_LVCMOS2
--#                            , u_IBUFG_PCI33_3
--#                            , u_IBUFG_PCI33_5
--#                            , u_IBUFG_PCI66_3
--#                            , u_IBUFG_SSTL2_I
--#                            , u_IBUFG_SSTL2_II
--#                            , u_IBUFG_SSTL3_I
--#                            , u_IBUFG_SSTL3_II
--#                            , u_IBUF_AGP
--#                            , u_IBUF_CTT
--#                            , u_IBUF_GTL
--#                            , u_IBUF_GTLP
--#                            , u_IBUF_HSTL_I
--#                            , u_IBUF_HSTL_III
--#                            , u_IBUF_HSTL_IV
--#                            , u_IBUF_LVCMOS2
--#                            , u_IBUF_PCI33_3
--#                            , u_IBUF_PCI33_5
--#                            , u_IBUF_PCI66_3
--#                            , u_IBUF_SSTL2_I
--#                            , u_IBUF_SSTL2_II
--#                            , u_IBUF_SSTL3_I
--#                            , u_IBUF_SSTL3_II
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUF_AGP
--#                            , u_IOBUF_CTT
--#                            , u_IOBUF_F_12
--#                            , u_IOBUF_F_16
--#                            , u_IOBUF_F_2
--#                            , u_IOBUF_F_24
--#                            , u_IOBUF_F_4
--#                            , u_IOBUF_F_6
--#                            , u_IOBUF_F_8
--#                            , u_IOBUF_GTL
--#                            , u_IOBUF_GTLP
--#                            , u_IOBUF_HSTL_I
--#                            , u_IOBUF_HSTL_III
--#                            , u_IOBUF_HSTL_IV
--#                            , u_IOBUF_LVCMOS2
--#                            , u_IOBUF_PCI33_3
--#                            , u_IOBUF_PCI33_5
--#                            , u_IOBUF_PCI66_3
--#                            , u_IOBUF_SSTL2_I
--#                            , u_IOBUF_SSTL2_II
--#                            , u_IOBUF_SSTL3_I
--#                            , u_IOBUF_SSTL3_II
--#                            , u_IOBUF_S_12
--#                            , u_IOBUF_S_16
--#                            , u_IOBUF_S_2
--#                            , u_IOBUF_S_24
--#                            , u_IOBUF_S_4
--#                            , u_IOBUF_S_6
--#                            , u_IOBUF_S_8
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFT
--#                            , u_OBUFT_AGP
--#                            , u_OBUFT_CTT
--#                            , u_OBUFT_F_12
--#                            , u_OBUFT_F_16
--#                            , u_OBUFT_F_2
--#                            , u_OBUFT_F_24
--#                            , u_OBUFT_F_4
--#                            , u_OBUFT_F_6
--#                            , u_OBUFT_F_8
--#                            , u_OBUFT_GTL
--#                            , u_OBUFT_GTLP
--#                            , u_OBUFT_HSTL_I
--#                            , u_OBUFT_HSTL_III
--#                            , u_OBUFT_HSTL_IV
--#                            , u_OBUFT_LVCMOS2
--#                            , u_OBUFT_PCI33_3
--#                            , u_OBUFT_PCI33_5
--#                            , u_OBUFT_PCI66_3
--#                            , u_OBUFT_SSTL2_I
--#                            , u_OBUFT_SSTL2_II
--#                            , u_OBUFT_SSTL3_I
--#                            , u_OBUFT_SSTL3_II
--#                            , u_OBUFT_S_12
--#                            , u_OBUFT_S_16
--#                            , u_OBUFT_S_2
--#                            , u_OBUFT_S_24
--#                            , u_OBUFT_S_4
--#                            , u_OBUFT_S_6
--#                            , u_OBUFT_S_8
--#                            , u_OBUF_AGP
--#                            , u_OBUF_CTT
--#                            , u_OBUF_F_12
--#                            , u_OBUF_F_16
--#                            , u_OBUF_F_2
--#                            , u_OBUF_F_24
--#                            , u_OBUF_F_4
--#                            , u_OBUF_F_6
--#                            , u_OBUF_F_8
--#                            , u_OBUF_GTL
--#                            , u_OBUF_GTLP
--#                            , u_OBUF_HSTL_I
--#                            , u_OBUF_HSTL_III
--#                            , u_OBUF_HSTL_IV
--#                            , u_OBUF_LVCMOS2
--#                            , u_OBUF_PCI33_3
--#                            , u_OBUF_PCI33_5
--#                            , u_OBUF_PCI66_3
--#                            , u_OBUF_SSTL2_I
--#                            , u_OBUF_SSTL2_II
--#                            , u_OBUF_SSTL3_I
--#                            , u_OBUF_SSTL3_II
--#                            , u_OBUF_S_12
--#                            , u_OBUF_S_16
--#                            , u_OBUF_S_2
--#                            , u_OBUF_S_24
--#                            , u_OBUF_S_4
--#                            , u_OBUF_S_6
--#                            , u_OBUF_S_8
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAMB4_S1
--#                            , u_RAMB4_S16
--#                            , u_RAMB4_S16_S16
--#                            , u_RAMB4_S1_S1
--#                            , u_RAMB4_S1_S16
--#                            , u_RAMB4_S1_S2
--#                            , u_RAMB4_S1_S4
--#                            , u_RAMB4_S1_S8
--#                            , u_RAMB4_S2
--#                            , u_RAMB4_S2_S16
--#                            , u_RAMB4_S2_S2
--#                            , u_RAMB4_S2_S4
--#                            , u_RAMB4_S2_S8
--#                            , u_RAMB4_S4
--#                            , u_RAMB4_S4_S16
--#                            , u_RAMB4_S4_S4
--#                            , u_RAMB4_S4_S8
--#                            , u_RAMB4_S8
--#                            , u_RAMB4_S8_S16
--#                            , u_RAMB4_S8_S8
--#                            , u_ROM16X1
--#                            , u_ROM32X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_STARTBUF_SPARTAN2
--#                            , u_STARTUP_SPARTAN2
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        set_to(y, spartan2e, (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_SPARTAN2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGDLL
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_SPARTAN2
--#                            , u_CLKDLL
--#                            , u_CLKDLLE
--#                            , u_CLKDLLHF
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFG
--#                            , u_IBUFG_AGP
--#                            , u_IBUFG_CTT
--#                            , u_IBUFG_GTL
--#                            , u_IBUFG_GTLP
--#                            , u_IBUFG_HSTL_I
--#                            , u_IBUFG_HSTL_III
--#                            , u_IBUFG_HSTL_IV
--#                            , u_IBUFG_LVCMOS18
--#                            , u_IBUFG_LVCMOS2
--#                            , u_IBUFG_LVDS
--#                            , u_IBUFG_LVPECL
--#                            , u_IBUFG_PCI33_3
--#                            , u_IBUFG_PCI66_3
--#                            , u_IBUFG_PCIX66_3
--#                            , u_IBUFG_SSTL2_I
--#                            , u_IBUFG_SSTL2_II
--#                            , u_IBUFG_SSTL3_I
--#                            , u_IBUFG_SSTL3_II
--#                            , u_IBUF_AGP
--#                            , u_IBUF_CTT
--#                            , u_IBUF_GTL
--#                            , u_IBUF_GTLP
--#                            , u_IBUF_HSTL_I
--#                            , u_IBUF_HSTL_III
--#                            , u_IBUF_HSTL_IV
--#                            , u_IBUF_LVCMOS18
--#                            , u_IBUF_LVCMOS2
--#                            , u_IBUF_LVDS
--#                            , u_IBUF_LVPECL
--#                            , u_IBUF_PCI33_3
--#                            , u_IBUF_PCI66_3
--#                            , u_IBUF_PCIX66_3
--#                            , u_IBUF_SSTL2_I
--#                            , u_IBUF_SSTL2_II
--#                            , u_IBUF_SSTL3_I
--#                            , u_IBUF_SSTL3_II
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUF_AGP
--#                            , u_IOBUF_CTT
--#                            , u_IOBUF_F_12
--#                            , u_IOBUF_F_16
--#                            , u_IOBUF_F_2
--#                            , u_IOBUF_F_24
--#                            , u_IOBUF_F_4
--#                            , u_IOBUF_F_6
--#                            , u_IOBUF_F_8
--#                            , u_IOBUF_GTL
--#                            , u_IOBUF_GTLP
--#                            , u_IOBUF_HSTL_I
--#                            , u_IOBUF_HSTL_III
--#                            , u_IOBUF_HSTL_IV
--#                            , u_IOBUF_LVCMOS18
--#                            , u_IOBUF_LVCMOS2
--#                            , u_IOBUF_LVDS
--#                            , u_IOBUF_LVPECL
--#                            , u_IOBUF_PCI33_3
--#                            , u_IOBUF_PCI66_3
--#                            , u_IOBUF_PCIX66_3
--#                            , u_IOBUF_SSTL2_I
--#                            , u_IOBUF_SSTL2_II
--#                            , u_IOBUF_SSTL3_I
--#                            , u_IOBUF_SSTL3_II
--#                            , u_IOBUF_S_12
--#                            , u_IOBUF_S_16
--#                            , u_IOBUF_S_2
--#                            , u_IOBUF_S_24
--#                            , u_IOBUF_S_4
--#                            , u_IOBUF_S_6
--#                            , u_IOBUF_S_8
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFT
--#                            , u_OBUFT_AGP
--#                            , u_OBUFT_CTT
--#                            , u_OBUFT_F_12
--#                            , u_OBUFT_F_16
--#                            , u_OBUFT_F_2
--#                            , u_OBUFT_F_24
--#                            , u_OBUFT_F_4
--#                            , u_OBUFT_F_6
--#                            , u_OBUFT_F_8
--#                            , u_OBUFT_GTL
--#                            , u_OBUFT_GTLP
--#                            , u_OBUFT_HSTL_I
--#                            , u_OBUFT_HSTL_III
--#                            , u_OBUFT_HSTL_IV
--#                            , u_OBUFT_LVCMOS18
--#                            , u_OBUFT_LVCMOS2
--#                            , u_OBUFT_LVDS
--#                            , u_OBUFT_LVPECL
--#                            , u_OBUFT_PCI33_3
--#                            , u_OBUFT_PCI66_3
--#                            , u_OBUFT_PCIX66_3
--#                            , u_OBUFT_SSTL2_I
--#                            , u_OBUFT_SSTL2_II
--#                            , u_OBUFT_SSTL3_I
--#                            , u_OBUFT_SSTL3_II
--#                            , u_OBUFT_S_12
--#                            , u_OBUFT_S_16
--#                            , u_OBUFT_S_2
--#                            , u_OBUFT_S_24
--#                            , u_OBUFT_S_4
--#                            , u_OBUFT_S_6
--#                            , u_OBUFT_S_8
--#                            , u_OBUF_AGP
--#                            , u_OBUF_CTT
--#                            , u_OBUF_F_12
--#                            , u_OBUF_F_16
--#                            , u_OBUF_F_2
--#                            , u_OBUF_F_24
--#                            , u_OBUF_F_4
--#                            , u_OBUF_F_6
--#                            , u_OBUF_F_8
--#                            , u_OBUF_GTL
--#                            , u_OBUF_GTLP
--#                            , u_OBUF_HSTL_I
--#                            , u_OBUF_HSTL_III
--#                            , u_OBUF_HSTL_IV
--#                            , u_OBUF_LVCMOS18
--#                            , u_OBUF_LVCMOS2
--#                            , u_OBUF_LVDS
--#                            , u_OBUF_LVPECL
--#                            , u_OBUF_PCI33_3
--#                            , u_OBUF_PCI66_3
--#                            , u_OBUF_PCIX66_3
--#                            , u_OBUF_SSTL2_I
--#                            , u_OBUF_SSTL2_II
--#                            , u_OBUF_SSTL3_I
--#                            , u_OBUF_SSTL3_II
--#                            , u_OBUF_S_12
--#                            , u_OBUF_S_16
--#                            , u_OBUF_S_2
--#                            , u_OBUF_S_24
--#                            , u_OBUF_S_4
--#                            , u_OBUF_S_6
--#                            , u_OBUF_S_8
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAMB4_S1
--#                            , u_RAMB4_S16
--#                            , u_RAMB4_S16_S16
--#                            , u_RAMB4_S1_S1
--#                            , u_RAMB4_S1_S16
--#                            , u_RAMB4_S1_S2
--#                            , u_RAMB4_S1_S4
--#                            , u_RAMB4_S1_S8
--#                            , u_RAMB4_S2
--#                            , u_RAMB4_S2_S16
--#                            , u_RAMB4_S2_S2
--#                            , u_RAMB4_S2_S4
--#                            , u_RAMB4_S2_S8
--#                            , u_RAMB4_S4
--#                            , u_RAMB4_S4_S16
--#                            , u_RAMB4_S4_S4
--#                            , u_RAMB4_S4_S8
--#                            , u_RAMB4_S8
--#                            , u_RAMB4_S8_S16
--#                            , u_RAMB4_S8_S8
--#                            , u_ROM16X1
--#                            , u_ROM32X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_STARTBUF_SPARTAN2
--#                            , u_STARTUP_SPARTAN2
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        set_to(y, virtexe, (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGDLL
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_VIRTEX
--#                            , u_CLKDLL
--#                            , u_CLKDLLE
--#                            , u_CLKDLLHF
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFG
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFT
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAMB4_S1
--#                            , u_RAMB4_S16
--#                            , u_RAMB4_S16_S16
--#                            , u_RAMB4_S1_S1
--#                            , u_RAMB4_S1_S16
--#                            , u_RAMB4_S1_S2
--#                            , u_RAMB4_S1_S4
--#                            , u_RAMB4_S1_S8
--#                            , u_RAMB4_S2
--#                            , u_RAMB4_S2_S16
--#                            , u_RAMB4_S2_S2
--#                            , u_RAMB4_S2_S4
--#                            , u_RAMB4_S2_S8
--#                            , u_RAMB4_S4
--#                            , u_RAMB4_S4_S16
--#                            , u_RAMB4_S4_S4
--#                            , u_RAMB4_S4_S8
--#                            , u_RAMB4_S8
--#                            , u_RAMB4_S8_S16
--#                            , u_RAMB4_S8_S8
--#                            , u_ROM16X1
--#                            , u_ROM32X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_STARTBUF_VIRTEX
--#                            , u_STARTUP_VIRTEX
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#                );
--#        --
--#        set_to(y, virtex2, (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGDLL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_VIRTEX2
--#                            , u_CLKDLL
--#                            , u_CLKDLLE
--#                            , u_CLKDLLHF
--#                            , u_DCM
--#                            , u_DUMMY_INV
--#                            , u_DUMMY_NOR2
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDDRCPE
--#                            , u_FDDRRSE
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_ICAP_VIRTEX2
--#                            , u_IFDDRCPE
--#                            , u_IFDDRRSE
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_OFDDRCPE
--#                            , u_OFDDRRSE
--#                            , u_OFDDRTCPE
--#                            , u_OFDDRTRSE
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_ORCY
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM128X1S
--#                            , u_RAM128X1S_1
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM32X1D
--#                            , u_RAM32X1D_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64X1D
--#                            , u_RAM64X1D_1
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_STARTBUF_VIRTEX2
--#                            , u_STARTUP_VIRTEX2
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        pp(qvirtex2)   := pp(virtex2);
--#        --
--#        pp(qrvirtex2)  := pp(virtex2);
--#        --
--#        set_to(y, virtex2p,
--#                           (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX2
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFE
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGDLL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_BUFT
--#                            , u_CAPTURE_VIRTEX2
--#                            , u_CLKDLL
--#                            , u_CLKDLLE
--#                            , u_CLKDLLHF
--#                            , u_DCM
--#                            , u_DUMMY_INV
--#                            , u_DUMMY_NOR2
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDDRCPE
--#                            , u_FDDRRSE
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_GT10_10GE_4
--#                            , u_GT10_10GE_8
--#                            , u_GT10_10GFC_4
--#                            , u_GT10_10GFC_8
--#                            , u_GT10_AURORAX_4
--#                            , u_GT10_AURORAX_8
--#                            , u_GT10_AURORA_1
--#                            , u_GT10_AURORA_2
--#                            , u_GT10_AURORA_4
--#                            , u_GT10_CUSTOM
--#                            , u_GT10_INFINIBAND_1
--#                            , u_GT10_INFINIBAND_2
--#                            , u_GT10_INFINIBAND_4
--#                            , u_GT10_OC192_4
--#                            , u_GT10_OC192_8
--#                            , u_GT10_OC48_1
--#                            , u_GT10_OC48_2
--#                            , u_GT10_OC48_4
--#                            , u_GT10_PCI_EXPRESS_1
--#                            , u_GT10_PCI_EXPRESS_2
--#                            , u_GT10_PCI_EXPRESS_4
--#                            , u_GT10_XAUI_1
--#                            , u_GT10_XAUI_2
--#                            , u_GT10_XAUI_4
--#                            , u_GT_AURORA_1
--#                            , u_GT_AURORA_2
--#                            , u_GT_AURORA_4
--#                            , u_GT_CUSTOM
--#                            , u_GT_ETHERNET_1
--#                            , u_GT_ETHERNET_2
--#                            , u_GT_ETHERNET_4
--#                            , u_GT_FIBRE_CHAN_1
--#                            , u_GT_FIBRE_CHAN_2
--#                            , u_GT_FIBRE_CHAN_4
--#                            , u_GT_INFINIBAND_1
--#                            , u_GT_INFINIBAND_2
--#                            , u_GT_INFINIBAND_4
--#                            , u_GT_XAUI_1
--#                            , u_GT_XAUI_2
--#                            , u_GT_XAUI_4
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_ICAP_VIRTEX2
--#                            , u_IFDDRCPE
--#                            , u_IFDDRRSE
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_JTAGPPC
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_OFDDRCPE
--#                            , u_OFDDRRSE
--#                            , u_OFDDRTCPE
--#                            , u_OFDDRTRSE
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_ORCY
--#                            , u_PPC405
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM128X1S
--#                            , u_RAM128X1S_1
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM32X1D
--#                            , u_RAM32X1D_1
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64X1D
--#                            , u_RAM64X1D_1
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_STARTBUF_VIRTEX2
--#                            , u_STARTUP_VIRTEX2
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        set_to(y, spartan3,
--#                           (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_SPARTAN3
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGDLL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_CAPTURE_SPARTAN3
--#                            , u_DCM
--#                            , u_DUMMY_INV
--#                            , u_DUMMY_NOR2
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDDRCPE
--#                            , u_FDDRRSE
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_IFDDRCPE
--#                            , u_IFDDRRSE
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_OFDDRCPE
--#                            , u_OFDDRRSE
--#                            , u_OFDDRTCPE
--#                            , u_OFDDRTRSE
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_ORCY
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_STARTBUF_SPARTAN3
--#                            , u_STARTUP_SPARTAN3
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        pp(aspartan3)   := pp(spartan3);
--#        --
--#        set_to(y, spartan3e,
--#                           (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_SPARTAN3
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGDLL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGP
--#                            , u_CAPTURE_SPARTAN3E
--#                            , u_DCM
--#                            , u_DUMMY_INV
--#                            , u_DUMMY_NOR2
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDDRCPE
--#                            , u_FDDRRSE
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FMAP
--#                            , u_GND
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_IDDR2
--#                            , u_IFDDRCPE
--#                            , u_IFDDRRSE
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT18X18SIO
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_ODDR2
--#                            , u_OFDDRCPE
--#                            , u_OFDDRRSE
--#                            , u_OFDDRTCPE
--#                            , u_OFDDRTRSE
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_ORCY
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_STARTBUF_SPARTAN3E
--#                            , u_STARTUP_SPARTAN3E
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        pp(aspartan3e)   := pp(spartan3e);
--#        --
--#        set_to(y, virtex4fx,
--#                           (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX4
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGCTRL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGMUX_VIRTEX4
--#                            , u_BUFGP
--#                            , u_BUFGP
--#                            , u_BUFIO
--#                            , u_BUFR
--#                            , u_CAPTURE_VIRTEX4
--#                            , u_DCIRESET
--#                            , u_DCM
--#                            , u_DCM_ADV
--#                            , u_DCM_BASE
--#                            , u_DCM_PS
--#                            , u_DSP48
--#                            , u_EMAC
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FIFO16
--#                            , u_FMAP
--#                            , u_FRAME_ECC_VIRTEX4
--#                            , u_GND
--#                            , u_GT11CLK
--#                            , u_GT11CLK_MGT
--#                            , u_GT11_CUSTOM
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_ICAP_VIRTEX4
--#                            , u_IDDR
--#                            , u_IDELAY
--#                            , u_IDELAYCTRL
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_ISERDES
--#                            , u_JTAGPPC
--#                            , u_KEEPER
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_ODDR
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_OSERDES
--#                            , u_PMCD
--#                            , u_PPC405
--#                            , u_PPC405_ADV
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_RAMB32_S64_ECC
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_STARTBUF_VIRTEX4
--#                            , u_STARTUP_VIRTEX4
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_USR_ACCESS_VIRTEX4
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        pp(virtex4sx) := pp(virtex4fx);
--#        --
--#        pp(virtex4lx) := pp(virtex4fx);
--#        set_to(n, virtex4lx, (u_EMAC,
--#                               u_GT11CLK, u_GT11CLK_MGT, u_GT11_CUSTOM,
--#                               u_JTAGPPC, u_PPC405, u_PPC405_ADV
--#              )               );
--#        --
--#        pp(virtex4) := pp(virtex4lx); -- virtex4 is defined as the largest set
--#                                       -- of primitives that EVERY virtex4
--#                                       -- device supports, i.e.. a design that uses
--#                                       -- the virtex4 subset of primitives
--#                                       -- is compatible with any variant of
--#                                       -- the virtex4 family.
--#        --
--#        pp(qvirtex4) := pp(virtex4);
--#        --
--#        pp(qrvirtex4) := pp(virtex4);
--#        --
--#        set_to(y, virtex5,
--#                           (
--#                              u_AND2
--#                            , u_AND3
--#                            , u_AND4
--#                            , u_BSCAN_VIRTEX5
--#                            , u_BUF
--#                            , u_BUFCF
--#                            , u_BUFG
--#                            , u_BUFGCE
--#                            , u_BUFGCE_1
--#                            , u_BUFGCTRL
--#                            , u_BUFGMUX
--#                            , u_BUFGMUX_1
--#                            , u_BUFGMUX_CTRL
--#                            , u_BUFGP
--#                            , u_BUFIO
--#                            , u_BUFR
--#                            , u_CAPTURE_VIRTEX5
--#                            , u_CARRY4
--#                            , u_CFGLUT5
--#                            , u_CRC32
--#                            , u_CRC64
--#                            , u_DCIRESET
--#                            , u_DCM
--#                            , u_DCM_ADV
--#                            , u_DCM_BASE
--#                            , u_DCM_PS
--#                            , u_DSP48
--#                            , u_DSP48E
--#                            , u_EMAC
--#                            , u_FD
--#                            , u_FDC
--#                            , u_FDCE
--#                            , u_FDCE_1
--#                            , u_FDCP
--#                            , u_FDCPE
--#                            , u_FDCPE_1
--#                            , u_FDCP_1
--#                            , u_FDC_1
--#                            , u_FDDRCPE
--#                            , u_FDDRRSE
--#                            , u_FDE
--#                            , u_FDE_1
--#                            , u_FDP
--#                            , u_FDPE
--#                            , u_FDPE_1
--#                            , u_FDP_1
--#                            , u_FDR
--#                            , u_FDRE
--#                            , u_FDRE_1
--#                            , u_FDRS
--#                            , u_FDRSE
--#                            , u_FDRSE_1
--#                            , u_FDRS_1
--#                            , u_FDR_1
--#                            , u_FDS
--#                            , u_FDSE
--#                            , u_FDSE_1
--#                            , u_FDS_1
--#                            , u_FD_1
--#                            , u_FIFO16
--#                            , u_FIFO18
--#                            , u_FIFO18_36
--#                            , u_FIFO36
--#                            , u_FIFO36_72
--#                            , u_FMAP
--#                            , u_FRAME_ECC_VIRTEX5
--#                            , u_GND
--#                            , u_GT11CLK
--#                            , u_GT11CLK_MGT
--#                            , u_GT11_CUSTOM
--#                            , u_IBUF
--#                            , u_IBUFDS
--#                            , u_IBUFDS_DIFF_OUT
--#                            , u_IBUFG
--#                            , u_IBUFGDS
--#                            , u_IBUFGDS_DIFF_OUT
--#                            , u_ICAP_VIRTEX5
--#                            , u_IDDR
--#                            , u_IDDR_2CLK
--#                            , u_IDELAY
--#                            , u_IDELAYCTRL
--#                            , u_IFDDRCPE
--#                            , u_IFDDRRSE
--#                            , u_INV
--#                            , u_IOBUF
--#                            , u_IOBUFDS
--#                            , u_IODELAY
--#                            , u_ISERDES
--#                            , u_ISERDES_NODELAY
--#                            , u_KEEPER
--#                            , u_KEY_CLEAR
--#                            , u_LD
--#                            , u_LDC
--#                            , u_LDCE
--#                            , u_LDCE_1
--#                            , u_LDCP
--#                            , u_LDCPE
--#                            , u_LDCPE_1
--#                            , u_LDCP_1
--#                            , u_LDC_1
--#                            , u_LDE
--#                            , u_LDE_1
--#                            , u_LDP
--#                            , u_LDPE
--#                            , u_LDPE_1
--#                            , u_LDP_1
--#                            , u_LD_1
--#                            , u_LUT1
--#                            , u_LUT1_D
--#                            , u_LUT1_L
--#                            , u_LUT2
--#                            , u_LUT2_D
--#                            , u_LUT2_L
--#                            , u_LUT3
--#                            , u_LUT3_D
--#                            , u_LUT3_L
--#                            , u_LUT4
--#                            , u_LUT4_D
--#                            , u_LUT4_L
--#                            , u_LUT5
--#                            , u_LUT5_D
--#                            , u_LUT5_L
--#                            , u_LUT6
--#                            , u_LUT6_D
--#                            , u_LUT6_L
--#                            , u_MULT18X18
--#                            , u_MULT18X18S
--#                            , u_MULT_AND
--#                            , u_MUXCY
--#                            , u_MUXCY_D
--#                            , u_MUXCY_L
--#                            , u_MUXF5
--#                            , u_MUXF5_D
--#                            , u_MUXF5_L
--#                            , u_MUXF6
--#                            , u_MUXF6_D
--#                            , u_MUXF6_L
--#                            , u_MUXF7
--#                            , u_MUXF7_D
--#                            , u_MUXF7_L
--#                            , u_MUXF8
--#                            , u_MUXF8_D
--#                            , u_MUXF8_L
--#                            , u_NAND2
--#                            , u_NAND3
--#                            , u_NAND4
--#                            , u_NOR2
--#                            , u_NOR3
--#                            , u_NOR4
--#                            , u_OBUF
--#                            , u_OBUFDS
--#                            , u_OBUFT
--#                            , u_OBUFTDS
--#                            , u_ODDR
--#                            , u_OFDDRCPE
--#                            , u_OFDDRRSE
--#                            , u_OFDDRTCPE
--#                            , u_OFDDRTRSE
--#                            , u_OR2
--#                            , u_OR3
--#                            , u_OR4
--#                            , u_OSERDES
--#                            , u_PLL_ADV
--#                            , u_PLL_BASE
--#                            , u_PMCD
--#                            , u_PULLDOWN
--#                            , u_PULLUP
--#                            , u_RAM128X1D
--#                            , u_RAM128X1S
--#                            , u_RAM16X1D
--#                            , u_RAM16X1D_1
--#                            , u_RAM16X1S
--#                            , u_RAM16X1S_1
--#                            , u_RAM16X2S
--#                            , u_RAM16X4S
--#                            , u_RAM16X8S
--#                            , u_RAM256X1S
--#                            , u_RAM32M
--#                            , u_RAM32X1S
--#                            , u_RAM32X1S_1
--#                            , u_RAM32X2S
--#                            , u_RAM32X4S
--#                            , u_RAM32X8S
--#                            , u_RAM64M
--#                            , u_RAM64X1D
--#                            , u_RAM64X1S
--#                            , u_RAM64X1S_1
--#                            , u_RAM64X2S
--#                            , u_RAMB16
--#                            , u_RAMB16_S1
--#                            , u_RAMB16_S18
--#                            , u_RAMB16_S18_S18
--#                            , u_RAMB16_S18_S36
--#                            , u_RAMB16_S1_S1
--#                            , u_RAMB16_S1_S18
--#                            , u_RAMB16_S1_S2
--#                            , u_RAMB16_S1_S36
--#                            , u_RAMB16_S1_S4
--#                            , u_RAMB16_S1_S9
--#                            , u_RAMB16_S2
--#                            , u_RAMB16_S2_S18
--#                            , u_RAMB16_S2_S2
--#                            , u_RAMB16_S2_S36
--#                            , u_RAMB16_S2_S4
--#                            , u_RAMB16_S2_S9
--#                            , u_RAMB16_S36
--#                            , u_RAMB16_S36_S36
--#                            , u_RAMB16_S4
--#                            , u_RAMB16_S4_S18
--#                            , u_RAMB16_S4_S36
--#                            , u_RAMB16_S4_S4
--#                            , u_RAMB16_S4_S9
--#                            , u_RAMB16_S9
--#                            , u_RAMB16_S9_S18
--#                            , u_RAMB16_S9_S36
--#                            , u_RAMB16_S9_S9
--#                            , u_RAMB18
--#                            , u_RAMB18SDP
--#                            , u_RAMB32_S64_ECC
--#                            , u_RAMB36
--#                            , u_RAMB36SDP
--#                            , u_RAMB36SDP_EXP
--#                            , u_RAMB36_EXP
--#                            , u_ROM128X1
--#                            , u_ROM16X1
--#                            , u_ROM256X1
--#                            , u_ROM32X1
--#                            , u_ROM64X1
--#                            , u_SRL16
--#                            , u_SRL16E
--#                            , u_SRL16E_1
--#                            , u_SRL16_1
--#                            , u_SRLC16
--#                            , u_SRLC16E
--#                            , u_SRLC16E_1
--#                            , u_SRLC16_1
--#                            , u_SRLC32E
--#                            , u_STARTUP_VIRTEX5
--#                            , u_SYSMON
--#                            , u_TOC
--#                            , u_TOCBUF
--#                            , u_USR_ACCESS_VIRTEX5
--#                            , u_VCC
--#                            , u_XNOR2
--#                            , u_XNOR3
--#                            , u_XNOR4
--#                            , u_XOR2
--#                            , u_XOR3
--#                            , u_XOR4
--#                            , u_XORCY
--#                            , u_XORCY_D
--#                            , u_XORCY_L
--#                           )
--#              );
--#        --
--#        pp(spartan3a)  := pp(spartan3e); -- Populate spartan3a by taking
--#                                         -- differences from spartan3e.
--#        set_to(n, spartan3a, (
--#                               u_BSCAN_SPARTAN3
--#                             , u_CAPTURE_SPARTAN3E
--#                             , u_DUMMY_INV
--#                             , u_DUMMY_NOR2
--#                             , u_STARTBUF_SPARTAN3E
--#                             , u_STARTUP_SPARTAN3E
--#              )              );
--#        set_to(y, spartan3a, (
--#                               u_BSCAN_SPARTAN3A
--#                             , u_CAPTURE_SPARTAN3A
--#                             , u_DCM_PS
--#                             , u_DNA_PORT
--#                             , u_IBUF_DLY_ADJ
--#                             , u_IBUFDS_DLY_ADJ
--#                             , u_ICAP_SPARTAN3A
--#                             , u_RAMB16BWE
--#                             , u_RAMB16BWE_S18
--#                             , u_RAMB16BWE_S18_S18
--#                             , u_RAMB16BWE_S18_S9
--#                             , u_RAMB16BWE_S36
--#                             , u_RAMB16BWE_S36_S18
--#                             , u_RAMB16BWE_S36_S36
--#                             , u_RAMB16BWE_S36_S9
--#                             , u_SPI_ACCESS
--#                             , u_STARTUP_SPARTAN3A
--#              )              );
--#
--#        --
--#        pp(aspartan3a)   := pp(spartan3a);
--#        --
--#        pp(spartan3an) := pp(spartan3a);
--#        --
--#        pp(spartan3adsp) := pp(spartan3a);
--#        set_to(y, spartan3adsp, (
--#                                  u_DSP48A
--#                                , u_RAMB16BWER
--#              )                 );
--#        --
--#        pp(aspartan3adsp) := pp(spartan3adsp);
--#        --
--#        set_to(y, spartan6,  (
--#                               u_AND2
--#                             , u_AND2B1L
--#                             , u_AND3
--#                             , u_AND4
--#                             , u_AUTOBUF
--#                             , u_BSCAN_SPARTAN6
--#                             , u_BUF
--#                             , u_BUFCF
--#                             , u_BUFG
--#                             , u_BUFGCE
--#                             , u_BUFGCE_1
--#                             , u_BUFGDLL
--#                             , u_BUFGMUX
--#                             , u_BUFGMUX
--#                             , u_BUFGMUX_1
--#                             , u_BUFGMUX_1
--#                             , u_BUFGP
--#                             , u_BUFH
--#                             , u_BUFIO2
--#                             , u_BUFIO2_2CLK
--#                             , u_BUFIO2FB
--#                             , u_BUFIO2FB_2CLK
--#                             , u_BUFPLL
--#                             , u_BUFPLL_MCB
--#                             , u_CAPTURE_SPARTAN3A
--#                             , u_DCM
--#                             , u_DCM_CLKGEN
--#                             , u_DCM_PS
--#                             , u_DNA_PORT
--#                             , u_DSP48A1
--#                             , u_FD
--#                             , u_FD_1
--#                             , u_FDC
--#                             , u_FDC_1
--#                             , u_FDCE
--#                             , u_FDCE_1
--#                             , u_FDCP
--#                             , u_FDCP_1
--#                             , u_FDCPE
--#                             , u_FDCPE_1
--#                             , u_FDDRCPE
--#                             , u_FDDRRSE
--#                             , u_FDE
--#                             , u_FDE_1
--#                             , u_FDP
--#                             , u_FDP_1
--#                             , u_FDPE
--#                             , u_FDPE_1
--#                             , u_FDR
--#                             , u_FDR_1
--#                             , u_FDRE
--#                             , u_FDRE_1
--#                             , u_FDRS
--#                             , u_FDRS_1
--#                             , u_FDRSE
--#                             , u_FDRSE_1
--#                             , u_FDS
--#                             , u_FDS_1
--#                             , u_FDSE
--#                             , u_FDSE_1
--#                             , u_FMAP
--#                             , u_GND
--#                             , u_GTPA1_DUAL
--#                             , u_IBUF
--#                             , u_IBUF_DLY_ADJ
--#                             , u_IBUFDS
--#                             , u_IBUFDS_DIFF_OUT
--#                             , u_IBUFDS_DLY_ADJ
--#                             , u_IBUFG
--#                             , u_IBUFGDS
--#                             , u_IBUFGDS_DIFF_OUT
--#                             , u_ICAP_SPARTAN3A
--#                             , u_ICAP_SPARTAN6
--#                             , u_IDDR2
--#                             , u_IFDDRCPE
--#                             , u_IFDDRRSE
--#                             , u_INV
--#                             , u_IOBUF
--#                             , u_IOBUFDS
--#                             , u_IODELAY2
--#                             , u_IODRP2
--#                             , u_IODRP2_MCB
--#                             , u_ISERDES2
--#                             , u_JTAG_SIM_SPARTAN6
--#                             , u_KEEPER
--#                             , u_LD
--#                             , u_LD_1
--#                             , u_LDC
--#                             , u_LDC_1
--#                             , u_LDCE
--#                             , u_LDCE_1
--#                             , u_LDCP
--#                             , u_LDCP_1
--#                             , u_LDCPE
--#                             , u_LDCPE_1
--#                             , u_LDE
--#                             , u_LDE_1
--#                             , u_LDP
--#                             , u_LDP_1
--#                             , u_LDPE
--#                             , u_LDPE_1
--#                             , u_LUT1
--#                             , u_LUT1_D
--#                             , u_LUT1_L
--#                             , u_LUT2
--#                             , u_LUT2_D
--#                             , u_LUT2_L
--#                             , u_LUT3
--#                             , u_LUT3_D
--#                             , u_LUT3_L
--#                             , u_LUT4
--#                             , u_LUT4_D
--#                             , u_LUT4_L
--#                             , u_LUT5
--#                             , u_LUT5_D
--#                             , u_LUT5_L
--#                             , u_LUT6
--#                             , u_LUT6_D
--#                             , u_LUT6_L
--#                             , u_MCB
--#                             , u_MULT18X18
--#                             , u_MULT18X18S
--#                             , u_MULT18X18SIO
--#                             , u_MULT_AND
--#                             , u_MUXCY
--#                             , u_MUXCY_D
--#                             , u_MUXCY_L
--#                             , u_MUXF5
--#                             , u_MUXF5_D
--#                             , u_MUXF5_L
--#                             , u_MUXF6
--#                             , u_MUXF6_D
--#                             , u_MUXF6_L
--#                             , u_MUXF7
--#                             , u_MUXF7_D
--#                             , u_MUXF7_L
--#                             , u_MUXF8
--#                             , u_MUXF8_D
--#                             , u_MUXF8_L
--#                             , u_NAND2
--#                             , u_NAND3
--#                             , u_NAND4
--#                             , u_NOR2
--#                             , u_NOR3
--#                             , u_NOR4
--#                             , u_OBUF
--#                             , u_OBUFDS
--#                             , u_OBUFT
--#                             , u_OBUFTDS
--#                             , u_OCT_CALIBRATE
--#                             , u_ODDR2
--#                             , u_OFDDRCPE
--#                             , u_OFDDRRSE
--#                             , u_OFDDRTCPE
--#                             , u_OFDDRTRSE
--#                             , u_OR2
--#                             , u_OR2L
--#                             , u_OR3
--#                             , u_OR4
--#                             , u_ORCY
--#                             , u_OSERDES2
--#                             , u_PCIE_A1
--#                             , u_PLL_ADV
--#                             , u_POST_CRC_INTERNAL
--#                             , u_PULLDOWN
--#                             , u_PULLUP
--#                             , u_RAM16X1D
--#                             , u_RAM16X1D_1
--#                             , u_RAM16X1S
--#                             , u_RAM16X1S_1
--#                             , u_RAM16X2S
--#                             , u_RAM16X4S
--#                             , u_RAM32X1S
--#                             , u_RAM32X1S_1
--#                             , u_RAM32X2S
--#                             , u_RAM64X1S
--#                             , u_RAM64X1S_1
--#                             , u_RAMB16BWE
--#                             , u_RAMB16BWE_S18
--#                             , u_RAMB16BWE_S18_S18
--#                             , u_RAMB16BWE_S18_S9
--#                             , u_RAMB16BWE_S36
--#                             , u_RAMB16BWE_S36_S18
--#                             , u_RAMB16BWE_S36_S36
--#                             , u_RAMB16BWE_S36_S9
--#                             , u_RAMB16_S1
--#                             , u_RAMB16_S18
--#                             , u_RAMB16_S18_S18
--#                             , u_RAMB16_S18_S36
--#                             , u_RAMB16_S1_S1
--#                             , u_RAMB16_S1_S18
--#                             , u_RAMB16_S1_S2
--#                             , u_RAMB16_S1_S36
--#                             , u_RAMB16_S1_S4
--#                             , u_RAMB16_S1_S9
--#                             , u_RAMB16_S2
--#                             , u_RAMB16_S2_S18
--#                             , u_RAMB16_S2_S2
--#                             , u_RAMB16_S2_S36
--#                             , u_RAMB16_S2_S4
--#                             , u_RAMB16_S2_S9
--#                             , u_RAMB16_S36
--#                             , u_RAMB16_S36_S36
--#                             , u_RAMB16_S4
--#                             , u_RAMB16_S4_S18
--#                             , u_RAMB16_S4_S36
--#                             , u_RAMB16_S4_S4
--#                             , u_RAMB16_S4_S9
--#                             , u_RAMB16_S9
--#                             , u_RAMB16_S9_S18
--#                             , u_RAMB16_S9_S36
--#                             , u_RAMB16_S9_S9
--#                             , u_RAMB8BWER
--#                             , u_ROM128X1
--#                             , u_ROM16X1
--#                             , u_ROM256X1
--#                             , u_ROM32X1
--#                             , u_ROM64X1
--#                             , u_SLAVE_SPI
--#                             , u_SPI_ACCESS
--#                             , u_SRL16
--#                             , u_SRL16_1
--#                             , u_SRL16E
--#                             , u_SRL16E_1
--#                             , u_SRLC16
--#                             , u_SRLC16_1
--#                             , u_SRLC16E
--#                             , u_SRLC16E_1
--#                             , u_STARTUP_SPARTAN3A
--#                             , u_STARTUP_SPARTAN6
--#                             , u_SUSPEND_SYNC
--#                             , u_TOC
--#                             , u_TOCBUF
--#                             , u_VCC
--#                             , u_XNOR2
--#                             , u_XNOR3
--#                             , u_XNOR4
--#                             , u_XOR2
--#                             , u_XOR3
--#                             , u_XOR4
--#                             , u_XORCY
--#                             , u_XORCY_D
--#                             , u_XORCY_L
--#              )              );
--#        --
--#        --
--#        set_to(y, virtex6,   (
--#                               u_AND2
--#                             , u_AND2B1L
--#                             , u_AND3
--#                             , u_AND4
--#                             , u_AUTOBUF
--#                             , u_BSCAN_VIRTEX5
--#                             , u_BSCAN_VIRTEX6
--#                             , u_BUF
--#                             , u_BUFCF
--#                             , u_BUFG
--#                             , u_BUFGCE
--#                             , u_BUFGCE_1
--#                             , u_BUFGCTRL
--#                             , u_BUFGMUX
--#                             , u_BUFGMUX_1
--#                             , u_BUFGMUX_CTRL
--#                             , u_BUFGP
--#                             , u_BUFH
--#                             , u_BUFHCE
--#                             , u_BUFIO
--#                             , u_BUFIODQS
--#                             , u_BUFR
--#                             , u_CAPTURE_VIRTEX5
--#                             , u_CAPTURE_VIRTEX6
--#                             , u_CARRY4
--#                             , u_CFGLUT5
--#                             , u_CRC32
--#                             , u_CRC64
--#                             , u_DCIRESET
--#                             , u_DCIRESET
--#                             , u_DCM
--#                             , u_DCM_ADV
--#                             , u_DCM_BASE
--#                             , u_DCM_PS
--#                             , u_DSP48
--#                             , u_DSP48E
--#                             , u_DSP48E1
--#                             , u_EFUSE_USR
--#                             , u_EMAC
--#                             , u_FD
--#                             , u_FD_1
--#                             , u_FDC
--#                             , u_FDC_1
--#                             , u_FDCE
--#                             , u_FDCE_1
--#                             , u_FDCP
--#                             , u_FDCP_1
--#                             , u_FDCPE
--#                             , u_FDCPE_1
--#                             , u_FDDRCPE
--#                             , u_FDDRRSE
--#                             , u_FDE
--#                             , u_FDE_1
--#                             , u_FDP
--#                             , u_FDP_1
--#                             , u_FDPE
--#                             , u_FDPE_1
--#                             , u_FDR
--#                             , u_FDR_1
--#                             , u_FDRE
--#                             , u_FDRE_1
--#                             , u_FDRS
--#                             , u_FDRS_1
--#                             , u_FDRSE
--#                             , u_FDRSE_1
--#                             , u_FDS
--#                             , u_FDS_1
--#                             , u_FDSE
--#                             , u_FDSE_1
--#                             , u_FIFO16
--#                             , u_FIFO18
--#                             , u_FIFO18_36
--#                             , u_FIFO18E1
--#                             , u_FIFO36
--#                             , u_FIFO36_72
--#                             , u_FIFO36E1
--#                             , u_FMAP
--#                             , u_FRAME_ECC_VIRTEX5
--#                             , u_FRAME_ECC_VIRTEX6
--#                             , u_GND
--#                             , u_GT11CLK
--#                             , u_GT11CLK_MGT
--#                             , u_GT11_CUSTOM
--#                             , u_GTXE1
--#                             , u_IBUF
--#                             , u_IBUF
--#                             , u_IBUFDS
--#                             , u_IBUFDS
--#                             , u_IBUFDS_DIFF_OUT
--#                             , u_IBUFDS_GTXE1
--#                             , u_IBUFG
--#                             , u_IBUFG
--#                             , u_IBUFGDS
--#                             , u_IBUFGDS
--#                             , u_IBUFGDS_DIFF_OUT
--#                             , u_ICAP_VIRTEX5
--#                             , u_ICAP_VIRTEX6
--#                             , u_IDDR
--#                             , u_IDDR_2CLK
--#                             , u_IDELAY
--#                             , u_IDELAYCTRL
--#                             , u_IFDDRCPE
--#                             , u_IFDDRRSE
--#                             , u_INV
--#                             , u_IOBUF
--#                             , u_IOBUF
--#                             , u_IOBUFDS
--#                             , u_IOBUFDS
--#                             , u_IOBUFDS_DIFF_OUT
--#                             , u_IODELAY
--#                             , u_IODELAYE1
--#                             , u_ISERDES
--#                             , u_ISERDESE1
--#                             , u_ISERDES_NODELAY
--#                             , u_JTAG_SIM_VIRTEX6
--#                             , u_KEEPER
--#                             , u_KEY_CLEAR
--#                             , u_LD
--#                             , u_LD_1
--#                             , u_LDC
--#                             , u_LDC_1
--#                             , u_LDCE
--#                             , u_LDCE_1
--#                             , u_LDCP
--#                             , u_LDCP_1
--#                             , u_LDCPE
--#                             , u_LDCPE_1
--#                             , u_LDE
--#                             , u_LDE_1
--#                             , u_LDP
--#                             , u_LDP_1
--#                             , u_LDPE
--#                             , u_LDPE_1
--#                             , u_LUT1
--#                             , u_LUT1_D
--#                             , u_LUT1_L
--#                             , u_LUT2
--#                             , u_LUT2_D
--#                             , u_LUT2_L
--#                             , u_LUT3
--#                             , u_LUT3_D
--#                             , u_LUT3_L
--#                             , u_LUT4
--#                             , u_LUT4_D
--#                             , u_LUT4_L
--#                             , u_LUT5
--#                             , u_LUT5_D
--#                             , u_LUT5_L
--#                             , u_LUT6
--#                             , u_LUT6_D
--#                             , u_LUT6_L
--#                             , u_MMCM_ADV
--#                             , u_MMCM_BASE
--#                             , u_MULT18X18
--#                             , u_MULT18X18S
--#                             , u_MULT_AND
--#                             , u_MUXCY
--#                             , u_MUXCY_D
--#                             , u_MUXCY_L
--#                             , u_MUXF5
--#                             , u_MUXF5_D
--#                             , u_MUXF5_L
--#                             , u_MUXF6
--#                             , u_MUXF6_D
--#                             , u_MUXF6_L
--#                             , u_MUXF7
--#                             , u_MUXF7_D
--#                             , u_MUXF7_L
--#                             , u_MUXF8
--#                             , u_MUXF8_D
--#                             , u_MUXF8_L
--#                             , u_NAND2
--#                             , u_NAND3
--#                             , u_NAND4
--#                             , u_NOR2
--#                             , u_NOR3
--#                             , u_NOR4
--#                             , u_OBUF
--#                             , u_OBUFDS
--#                             , u_OBUFT
--#                             , u_OBUFTDS
--#                             , u_ODDR
--#                             , u_OFDDRCPE
--#                             , u_OFDDRRSE
--#                             , u_OFDDRTCPE
--#                             , u_OFDDRTRSE
--#                             , u_OR2
--#                             , u_OR2L
--#                             , u_OR3
--#                             , u_OR4
--#                             , u_OSERDES
--#                             , u_OSERDESE1
--#                             , u_PCIE_2_0
--#                             , u_PLL_ADV
--#                             , u_PLL_BASE
--#                             , u_PMCD
--#                             , u_PPR_FRAME
--#                             , u_PULLDOWN
--#                             , u_PULLUP
--#                             , u_RAM128X1D
--#                             , u_RAM128X1S
--#                             , u_RAM16X1D
--#                             , u_RAM16X1D_1
--#                             , u_RAM16X1S
--#                             , u_RAM16X1S_1
--#                             , u_RAM16X2S
--#                             , u_RAM16X4S
--#                             , u_RAM16X8S
--#                             , u_RAM256X1S
--#                             , u_RAM32M
--#                             , u_RAM32X1S
--#                             , u_RAM32X1S_1
--#                             , u_RAM32X2S
--#                             , u_RAM32X4S
--#                             , u_RAM32X8S
--#                             , u_RAM64M
--#                             , u_RAM64X1D
--#                             , u_RAM64X1S
--#                             , u_RAM64X1S_1
--#                             , u_RAM64X2S
--#                             , u_RAMB16
--#                             , u_RAMB16_S1
--#                             , u_RAMB16_S18
--#                             , u_RAMB16_S18_S18
--#                             , u_RAMB16_S18_S36
--#                             , u_RAMB16_S1_S1
--#                             , u_RAMB16_S1_S18
--#                             , u_RAMB16_S1_S2
--#                             , u_RAMB16_S1_S36
--#                             , u_RAMB16_S1_S4
--#                             , u_RAMB16_S1_S9
--#                             , u_RAMB16_S2
--#                             , u_RAMB16_S2_S18
--#                             , u_RAMB16_S2_S2
--#                             , u_RAMB16_S2_S36
--#                             , u_RAMB16_S2_S4
--#                             , u_RAMB16_S2_S9
--#                             , u_RAMB16_S36
--#                             , u_RAMB16_S36_S36
--#                             , u_RAMB16_S4
--#                             , u_RAMB16_S4_S18
--#                             , u_RAMB16_S4_S36
--#                             , u_RAMB16_S4_S4
--#                             , u_RAMB16_S4_S9
--#                             , u_RAMB16_S9
--#                             , u_RAMB16_S9_S18
--#                             , u_RAMB16_S9_S36
--#                             , u_RAMB16_S9_S9
--#                             , u_RAMB18
--#                             , u_RAMB18E1
--#                             , u_RAMB18SDP
--#                             , u_RAMB32_S64_ECC
--#                             , u_RAMB36
--#                             , u_RAMB36E1
--#                             , u_RAMB36_EXP
--#                             , u_RAMB36SDP
--#                             , u_RAMB36SDP_EXP
--#                             , u_ROM128X1
--#                             , u_ROM16X1
--#                             , u_ROM256X1
--#                             , u_ROM32X1
--#                             , u_ROM64X1
--#                             , u_SRL16
--#                             , u_SRL16_1
--#                             , u_SRL16E
--#                             , u_SRL16E_1
--#                             , u_SRLC16
--#                             , u_SRLC16_1
--#                             , u_SRLC16E
--#                             , u_SRLC16E_1
--#                             , u_SRLC32E
--#                             , u_STARTUP_VIRTEX5
--#                             , u_STARTUP_VIRTEX6
--#                             , u_SYSMON
--#                             , u_SYSMON
--#                             , u_TEMAC_SINGLE
--#                             , u_TOC
--#                             , u_TOCBUF
--#                             , u_USR_ACCESS_VIRTEX5
--#                             , u_USR_ACCESS_VIRTEX6
--#                             , u_VCC
--#                             , u_XNOR2
--#                             , u_XNOR3
--#                             , u_XNOR4
--#                             , u_XOR2
--#                             , u_XOR3
--#                             , u_XOR4
--#                             , u_XORCY
--#                             , u_XORCY_D
--#                             , u_XORCY_L
--#              )              );
--#        return pp;
--#    end prim_population;
--#    ---)
--#
--# constant fam_has_prim :  fam_has_prim_type := prim_population;
    constant fam_has_prim :  fam_has_prim_type := 
(
     nofamily => (
 n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n), 
     virtex => (
 y, n, y, y, n, n, n, n, n, n, y, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan2 => (
 y, n, y, y, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan2e => (
 y, n, y, y, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtexe => (
 y, n, y, y, n, n, n, n, n, n, y, n, n, n, n, y, y, y, y, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex2 => (
 y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     qvirtex2 => (
 y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     qrvirtex2 => (
 y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex2p => (
 y, n, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan3 => (
 y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     aspartan3 => (
 y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex4 => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex4lx => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex4fx => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, y, y, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex4sx => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, y, y, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan3e => (
 y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex5 => (
 y, n, y, y, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, y, y, y, n, y, y, y, n, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, y, n, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, n, y, n, y, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, n, y, y, n, y, n, n, n, n, y, y, y, n, n, n, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, y, y, n, y, n, y, y, y, y, y, y, y, y, y, y), 
     spartan3a => (
 y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan3an => (
 y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan3adsp => (
 y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     aspartan3e => (
 y, n, y, y, n, n, y, n, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     aspartan3a => (
 y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     aspartan3adsp => (
 y, n, y, y, n, n, n, y, n, n, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, y, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     qvirtex4 => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     qrvirtex4 => (
 y, n, y, y, n, n, n, n, n, n, n, n, y, n, n, y, y, n, y, y, y, y, n, y, y, n, y, y, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, n, n, n, n, y, y, y, y, n, y, n, y, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, y, y, n, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, y, y, n, n, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, n, y, n, y, y, n, y, n, n, n, n, n, n, y, n, n, n, n, y, y, n, n, n, y, y, y, y, y, y, y, n, n, n, n, y, y, y, y, y, n, n, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, n, n, n, n, n, n, y, n, n, n, n, n, n, n, y, n, n, n, n, n, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y), 
     spartan6 => (
 y, y, y, y, y, n, n, n, n, y, n, n, n, n, n, y, y, n, y, y, y, n, y, y, y, n, n, y, y, n, n, y, y, y, y, n, y, y, n, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, y, y, n, n, y, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, y, n, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, n, n, y, n, n, y, y, y, y, n, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, n, n, y, n, n, n, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, n, y, n, n, n, y, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, y, y, n, y, n, n, y, y, n, n, y, n, n, n, y, y, n, n, n, y, y, y, y, y, y, n, n, n, n, n, y, y, y, n, n, n, n, n, y, y, n, n, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, y, n, y, n, n, n, n, n, y, n, n, y, y, n, n, n, y, y, y, y, y, y, y, y, y, y), 
     virtex6 => (
 y, y, y, y, y, n, n, n, n, n, n, n, n, y, y, y, y, n, y, y, y, y, n, y, y, y, n, y, y, y, y, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, y, y, y, y, n, n, n, y, y, y, y, y, y, n, y, n, y, n, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, n, n, y, y, n, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, n, y, y, y, y, y, y, y, n, n, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, n, n, y, n, y, y, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, n, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, n, y, y, y, y, y, y, y, y, n, y, n, y, y, n, y, y, y, n, n, n, y, y, y, y, y, n, y, y, y, y, y, y, y, y, y, n, n, y, y, y, y, y, y, y, n, y, y, y, y, n, n, n, n, n, n, n, n, n, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, y, y, y, n, n, y, y, y, y, y, y, y, y, y, n, n, n, n, n, n, n, n, n, n, n, n, n, n, y, y, n, y, y, y, y, n, y, y, y, y, y, y, y, y, y, y, y, y) 
);

    function supported( family         : families_type;
                        primitive      : primitives_type
                      ) return boolean is
    begin
        return  fam_has_prim(family)(primitive) = y;
    end supported;


    function supported( family         : families_type;
                        primitives     : primitive_array_type
                      ) return boolean is
    begin
        for i in primitives'range loop
            if fam_has_prim(family)(primitives(i)) /= y then
                return false;
            end if;
        end loop;
        return true;
    end supported;

    ----------------------------------------------------------------------------
    -- This function is used as alternative to the 'IMAGE attribute, which
    -- is not correctly interpretted by some vhdl tools.
    ----------------------------------------------------------------------------
    function myimage (fam_type :  families_type) return string is 
      variable temp : families_type :=fam_type;
    begin 
    case temp is 
      when nofamily      => return "nofamily";
      when virtex        => return "virtex";
      when spartan2      => return "spartan2";
      when spartan2e     => return "spartan2e";
      when virtexe       => return "virtexe";
      when virtex2       => return "virtex2";
      when qvirtex2      => return "qvirtex2";
      when qrvirtex2     => return "qrvirtex2";
      when virtex2p      => return "virtex2p";
      when spartan3      => return "spartan3";
      when aspartan3     => return "aspartan3";
      when spartan3e     => return "spartan3e";
      when virtex4       => return "virtex4";
      when virtex4lx     => return "virtex4lx";
      when virtex4fx     => return "virtex4fx";
      when virtex4sx     => return "virtex4sx";
      when virtex5       => return "virtex5";
      when spartan3a     => return "spartan3a";
      when spartan3an    => return "spartan3an";
      when spartan3adsp  => return "spartan3adsp";
      when aspartan3e    => return "aspartan3e";
      when aspartan3a    => return "aspartan3a";
      when aspartan3adsp => return "aspartan3adsp";
      when qvirtex4      => return "qvirtex4";
      when qrvirtex4     => return "qrvirtex4";
      when spartan6      => return "spartan6";
      when virtex6       => return "virtex6";
    end case;
    end myimage;


    function toLowerCaseChar( char : character ) return character is
    begin
       -- If char is not an upper case letter then return char
       if char < 'A' OR char > 'Z' then
         return char;
       end if;
       -- Otherwise map char to its corresponding lower case character and
       -- return that
       case char is
         when 'A' => return 'a';
         when 'B' => return 'b';
         when 'C' => return 'c';
         when 'D' => return 'd';
         when 'E' => return 'e';
         when 'F' => return 'f';
         when 'G' => return 'g';
         when 'H' => return 'h';
         when 'I' => return 'i';
         when 'J' => return 'j';
         when 'K' => return 'k';
         when 'L' => return 'l';
         when 'M' => return 'm';
         when 'N' => return 'n';
         when 'O' => return 'o';
         when 'P' => return 'p';
         when 'Q' => return 'q';
         when 'R' => return 'r';
         when 'S' => return 's';
         when 'T' => return 't';
         when 'U' => return 'u';
         when 'V' => return 'v';
         when 'W' => return 'w';
         when 'X' => return 'x';
         when 'Y' => return 'y';
         when 'Z' => return 'z';
         when others => return char;
       end case;
    end toLowerCaseChar;


    function equalIgnoringCase( str1, str2 : string ) return boolean is
      constant LEN1 : integer := str1'length;
      constant LEN2 : integer := str2'length;
      variable equal : boolean := TRUE;
    begin
       if not (LEN1 = LEN2) then
         equal := FALSE;
       else
         for i in str1'range loop
           if not (toLowerCaseChar(str1(i)) = toLowerCaseChar(str2(i))) then
             equal := FALSE;
           end if;
         end loop;
       end if;
       return equal;
    end equalIgnoringCase;


    function str2fam( fam_as_string  : string ) return families_type is
        --
        variable fas : string(1 to fam_as_string'length) := fam_as_string;
        variable fam  : families_type;
        --
    begin
        -- Search for and return the corresponding family.
        for fam in families_type'low to families_type'high loop
            if equalIgnoringCase(fas, myimage(fam)) then return fam; end if;
        end loop;
        -- If there is no matching family, report a warning and return nofamily.
        assert false
          report "Package family_support: Function str2fam called" &
                 " with string parameter, " & fam_as_string &
                 ", that does not correspond" &
                 " to a supported family. Returning nofamily."
          severity warning;
        return nofamily;
    end str2fam;


    function fam2str( fam :  families_type) return string is
    begin
      --return families_type'IMAGE(fam);
        return myimage(fam);
    end fam2str;

    function supported( fam_as_str     : string;
                        primitive      : primitives_type
                      ) return boolean is
    begin
        return supported(str2fam(fam_as_str), primitive);
    end supported;


    function supported( fam_as_str     : string;
                        primitives     : primitive_array_type
                      ) return boolean is
    begin
        return supported(str2fam(fam_as_str), primitives);
    end supported;


    ---------------------------------------------------------------------------- 
    -- Function: native_lut_size, two overloads.
    ---------------------------------------------------------------------------- 
    function native_lut_size( fam : families_type;
                              no_lut_return_val : natural := 0
                            ) return natural is
    begin
        if    supported(fam, u_LUT6) then return  6;
        elsif supported(fam, u_LUT5) then return  5;
        elsif supported(fam, u_LUT4) then return  4;
        elsif supported(fam, u_LUT3) then return  3;
        elsif supported(fam, u_LUT2) then return  2;
        elsif supported(fam, u_LUT1) then return  1;
        else                              return no_lut_return_val;
        end if;
    end;


    function native_lut_size( fam_as_string : string;
                              no_lut_return_val : natural := 0
                            ) return natural is
    begin
        return native_lut_size( fam => str2fam(fam_as_string),
                                no_lut_return_val => no_lut_return_val
                              );
    end;


end package body family_support;
