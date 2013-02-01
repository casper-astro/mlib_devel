#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_processor_wave.do (Wed Feb  1 12:54:49 2006)
#
#  Module   bfm_processor_wrapper
#  Instance bfm_processor
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
set binopt {-logic}
set hexopt {-literal -hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

  eval add wave -noupdate -divider {"bfm_processor"}
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_CLK
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_RESET
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}SYNCH_OUT
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}SYNCH_IN
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MAddrAck
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}PLB_MSsize
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MRearbitrate
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MBusy
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MErr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MWrDAck
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}PLB_MRdDBus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}PLB_MRdWdAddr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MRdDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MRdBTerm
# eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}PLB_MWrBTerm
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_request
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_priority
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_buslock
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_RNW
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_BE
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_msize
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_size
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_type
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_compress
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_guarded
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_ordered
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_lockErr
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_abort
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_ABus
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_processor${ps}M_wrDBus
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_wrBurst
  eval add wave -noupdate $binopt $tbpath${ps}bfm_processor${ps}M_rdBurst

