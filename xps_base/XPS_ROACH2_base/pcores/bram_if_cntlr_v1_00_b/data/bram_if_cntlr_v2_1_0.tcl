###############################################################################
##
## Copyright (c) 2005 Xilinx, Inc. All Rights Reserved.
## DO NOT COPY OR MODIFY THIS FILE. 
## THIS IS IN AN EXPERIMENTAL STAGE AND MIGHT CHANGE IN FUTURE RELEASE.
##
## bram_if_cntlr_v2_1_0.tcl
##
###############################################################################

## @BEGIN_CHANGELOG EDK_I
##
## - enforce addresses to be set
##	  C_BASEADDR != 0xFFFFFFFF
##        C_HIGHADDR != 0x00000000
##
## @END_CHANGELOG


# @param   mhsinst    the mhs instance handle
# @param   bus_name   valid value might be PLB, OPB, or LMB
#
proc check_address {mhsinst bus_name} {

    ##
    ## enforce users to set C_HIGHADDR and C_BASEADDR
    ##
    set instname   [xget_hw_parameter_value $mhsinst "INSTANCE"]

    set base_param "C_BASEADDR"
    set high_param "C_HIGHADDR"

    set base_addr  [xget_hw_parameter_value $mhsinst $base_param]
    set high_addr  [xget_hw_parameter_value $mhsinst $high_param]

    # convert to hexadecimal format
    set base_addr  [xformat_addr_string $base_addr $base_param]
    set high_addr  [xformat_addr_string $high_addr $high_param]


    if {[compare_unsigned_addr_strings $base_addr $base_param $high_addr $high_param] == 1} {

        error "Invalid $instname parameter:\nYou must set the value for $base_param and $high_param" "" "libgen_error"

    }

}
