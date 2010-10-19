#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     plb_ddr2_wave.do (Wed Feb  1 12:54:49 2006)
#
#  Module   plb_ddr2_wrapper
#  Instance plb_ddr2
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
set binopt {-logic}
set hexopt {-literal -hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

  eval add wave -noupdate -divider {"plb_ddr2"}
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_Clk
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_Rst
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_addrAck
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_MBusy
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_MErr
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_rdBTerm
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_rdComp
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_rdDAck
  eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}Sl_rdDBus
  eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}Sl_rdWdAddr
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_rearbitrate
  eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}Sl_SSize
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_wait
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_wrBTerm
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_wrComp
  eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}Sl_wrDAck
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_abort
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_ABus
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_BE
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_busLock
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_compress
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_guarded
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_lockErr
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_masterID
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_MSize
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_ordered
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_PAValid
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_pendPri
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_pendReq
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_rdBurst
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_rdPrim
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_reqPri
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_RNW
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_SAValid
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_size
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_type
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_wrBurst
# eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}PLB_wrDBus
# eval add wave -noupdate $binopt $tbpath${ps}plb_ddr2${ps}PLB_wrPrim
  eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}SYNCH_IN
  eval add wave -noupdate $hexopt $tbpath${ps}plb_ddr2${ps}SYNCH_OUT

