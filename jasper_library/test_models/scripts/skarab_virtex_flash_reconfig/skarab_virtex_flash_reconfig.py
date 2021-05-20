#--------------------------------------------------------------------------------------
# COMPANY              : PERALEX ELECTRONICS (PTY) LTD
#--------------------------------------------------------------------------------------
# COPYRIGHT NOTICE :
#
# The copyright, manufacturing and patent rights stemming from this document
# in any form are vested in PERALEX ELECTRONICS (PTY) LTD.
#
# (c) PERALEX ELECTRONICS (PTY) LTD 2021
#
# PERALEX ELECTRONICS (PTY) LTD has ceded these rights to its clients
# where contractually agreed.
#--------------------------------------------------------------------------------------
# DESCRIPTION :
#
# This script is used to program the flash of the Virtex-7 FPGA on a SKARAB 
# with new firmware (hex file).
#
# The programming takes approximately 10 minutes to complete.
#
# After the programming is complete, the SKARAB can be rebooted so that it
# can boot with its new firmware.
#
# Set the script configuration (under "1. SCRIPT CONFIG") as required.
# 
#--------------------------------------------------------------------------------------

import casperfpga

# ---------------------------------------------------------------
# 1. SCRIPT CONFIG
# ---------------------------------------------------------------
# SKARAB IP ADDRESS
skarab_ip_address = '10.0.7.3'
# HEX FILE NAME (SHOULD BE UNDER SAME DIRECTORY AS THIS SCRIPT)
hex_file_name = 'frm123701u1r4_mez3.hex'

# ---------------------------------------------------------------
# 2. RECONFIGURE VIRTEX-7 FPGA FLASH ON SKARAB
# ---------------------------------------------------------------
fpga = casperfpga.CasperFpga(skarab_ip_address)
print("Programming Virtex 7 FPGA flash on SKARAB (the process takes approximately 10 minutes to complete)...")
fpga.transport.virtex_flash_reconfig('frm123701u1r4_mez3.hex')
print("Programming complete...")
