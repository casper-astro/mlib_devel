#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_monitor_wave.do (Wed Feb  1 12:54:49 2006)
#
#  Module   bfm_monitor_wrapper
#  Instance bfm_monitor
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
set binopt {-logic}
set hexopt {-literal -hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

  eval add wave -noupdate -divider {"bfm_monitor"}
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_CLK
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_RESET
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}SYNCH_OUT
  eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}SYNCH_IN
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_request
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_priority
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_buslock
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_RNW
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_BE
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_msize
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_size
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_type
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_compress
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_guarded
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_ordered
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_lockErr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_abort
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_ABus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}M_wrDBus
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_wrBurst
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}M_rdBurst
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MAddrAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MRearbitrate
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MBusy
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MErr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MWrDAck
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_MRdDBus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_MRdWdAddr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MRdDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MRdBTerm
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MWrBTerm
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_Mssize
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_PAValid
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SAValid
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_rdPrim
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_wrPrim
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_MasterID
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_abort
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_busLock
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_RNW
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_BE
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_msize
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_size
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_type
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_compress
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_guarded
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_ordered
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_lockErr
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_ABus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_wrDBus
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_wrBurst
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_rdBurst
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_pendReq
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_pendPri
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_reqPri
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_addrAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_wait
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_rearbitrate
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_wrDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_wrComp
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_wrBTerm
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}Sl_rdDBus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}Sl_rdWdAddr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_rdDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_rdComp
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_rdBTerm
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_MBusy
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}Sl_MErr
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}Sl_ssize
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SaddrAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_Swait
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_Srearbitrate
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SwrDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SwrComp
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SwrBTerm
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_SrdDBus
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_SrdWdAddr
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SrdDAck
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SrdComp
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SrdBTerm
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SMBusy
# eval add wave -noupdate $binopt $tbpath${ps}bfm_monitor${ps}PLB_SMErr
# eval add wave -noupdate $hexopt $tbpath${ps}bfm_monitor${ps}PLB_Sssize

