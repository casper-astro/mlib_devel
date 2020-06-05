#!/usr/bin/env python

# **********************************************************************************************************************************************************
# jtag_axil_master_fpg_to_tcl.py
#
# Henno Kriel (henno@ska.ac.za)
#
# Assumtions / prerequisites:
# ---------------------------
# This file assume that you have the JTAG to AXI Lite Master bridge (called hw_axi_1) in your FPGA design
# and that it is indeed the AXI Lite Memory Mapped master of your CAM bus.
# The fpg file generated for your design will be used to create tcl commands that can 
# read and write to your design registers and anything else connected to the AXIL bus.
# 
# Function:
# This funciton loads a JASPER generated fpga fpg file and parses the registers 
# to create a Vivado tcl file with register read and write tcl commands which
# can be executed in Vivado tcl console after connecting via the hardware manager.
# All registers found will get a single 32 bit write and read tcl function generated.
# ie for read:
# create_hw_axi_txn duty_cycle_rd [get_hw_axis hw_axi_1] -type READ -address 10010000 -len 1 -force
# followed by executing this read transaction:
# run_hw_axi [get_hw_axi_txns duty_cycle_rd]
# ie for write:
# create_hw_axi_txn duty_cycle_wr [get_hw_axis hw_axi_1] -type WRITE -address 10010000 -len 1 -data 00000000 -force
# the write transaction will not be issued, since the data to write is unkown - you must populate the data field with a 32 bit wide hex value.
#
# input: your fpg file
# output: generated tcl file with same name as fpg file, with a list of tcl commands that can be execute in Vivado tcl console:
# source my_generated_tcl_file.tcl
#
# **********************************************************************************************************************************************************
 

import csv,sys
from optparse import OptionParser

lcl = locals() # registers from fpg will be stored here

# Global variables
verbose = True

############### Exeption handles
def exit_fail():
    print 'FAILURE DETECTED. Log entries:\n',
    try:
        a = 1
    except:       
        pass
    if verbose:
        raise
    exit()

def exit_clean():
    try:
        print "Closing file."
    except:
        pass
    exit()

if __name__ == '__main__':
    from optparse import OptionParser

    p = OptionParser()
    p.set_usage('jtag_axil_master_fpg_to_tcl -f filename.fpg')
    p.set_description(__doc__)
    p.add_option('-f', '--fpg_file', dest='fpg_file', type='str',
        help='Specify the fpg file for the current firmware, eg -f m1130_1042sdp_rev2_00_of_2018_May_25_1235.fpg')
    opts, args = p.parse_args(sys.argv[1:])
   
try:
  
  if opts.fpg_file == None:
    print ('Error! no fpg file specified - usage: jtag_axil_master_fpg_to_tcl -f filename.fpg')   
    exit_clean() 
  
  tcl_file = open(opts.fpg_file+'.tcl', 'w')
  # populate registers with names and addresses from fpg file
  with open(opts.fpg_file) as f:
    content = csv.reader(f,delimiter='\t')
    for row in content:
        if row[0] == '?meta':
          break
        if row[0] == '?register':
          # create local function variables for registers in case you want to do someting else with it
          lcl[row[1]] = (int(row[2],16))  # example: ?register gbe0_rx_err_cnt_reg 0x10010004  0x4  will create local var  gbe0_rx_err_cnt_reg = 268500996
          # create tcl read command for register
          tcl_file.write('create_hw_axi_txn '+row[1]+'_rd [get_hw_axis hw_axi_1] -type READ -address '+row[2][2:]+' -len 1 -force\n') 
          # execute a read to this register
          tcl_file.write('run_hw_axi [get_hw_axi_txns '+row[1]+'_rd]\n') 
          # create tcl write command for this register
          tcl_file.write('create_hw_axi_txn '+str(row[1])+'_wr [get_hw_axis hw_axi_1] -type WRITE -address '+str(row[2][2:])+' -len 1 -data 00000000 -force\n') 
          # the write command will not be executed - you must copy and paste it and modify -data field with the write data (must be in hex and all 8 chars must be there (expect 32 bits))
          # tcl_file.write('run_hw_axi [get_hw_axi_txns '+row[1]+'_wr]\n') 
  tcl_file.close()
  f.close()
  print ('tcl file '+opts.fpg_file+'.tcl'+' generated')

except KeyboardInterrupt:
    exit_clean()
except:
    exit_fail()

exit_clean()

