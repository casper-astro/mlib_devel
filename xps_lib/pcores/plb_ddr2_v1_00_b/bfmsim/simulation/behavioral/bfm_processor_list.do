#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_processor_list.do (Wed Feb  1 12:54:49 2006)
#
#  Module   bfm_processor_wrapper
#  Instance bfm_processor
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
set binopt {-bin}
set hexopt {-hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_CLK
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_RESET
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}SYNCH_OUT
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}SYNCH_IN
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MAddrAck
# eval add list $hexopt $tbpath${ps}bfm_processor${ps}PLB_MSsize
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MRearbitrate
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MBusy
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MErr
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MWrDAck
# eval add list $hexopt $tbpath${ps}bfm_processor${ps}PLB_MRdDBus
# eval add list $hexopt $tbpath${ps}bfm_processor${ps}PLB_MRdWdAddr
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MRdDAck
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MRdBTerm
# eval add list $binopt $tbpath${ps}bfm_processor${ps}PLB_MWrBTerm
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_request
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_priority
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_buslock
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_RNW
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_BE
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_msize
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_size
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_type
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_compress
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_guarded
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_ordered
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_lockErr
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_abort
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_ABus
  eval add list $hexopt $tbpath${ps}bfm_processor${ps}M_wrDBus
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_wrBurst
  eval add list $binopt $tbpath${ps}bfm_processor${ps}M_rdBurst

