#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     plb_bus_list.do (Wed Feb  1 12:54:49 2006)
#
#  Module   plb_bus_wrapper
#  Instance plb_bus
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
set binopt {-bin}
set hexopt {-hex}
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

# eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_Clk
# eval add list $binopt $tbpath${ps}plb_bus${ps}SYS_Rst
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_Rst
# eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_dcrAck
# eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_dcrDBus
# eval add list $hexopt $tbpath${ps}plb_bus${ps}DCR_ABus
# eval add list $hexopt $tbpath${ps}plb_bus${ps}DCR_DBus
# eval add list $binopt $tbpath${ps}plb_bus${ps}DCR_Read
# eval add list $binopt $tbpath${ps}plb_bus${ps}DCR_Write
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_ABus
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_BE
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_RNW
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_abort
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_busLock
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_compress
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_guarded
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_lockErr
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_MSize
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_ordered
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_priority
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_rdBurst
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_request
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_size
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_type
# eval add list $binopt $tbpath${ps}plb_bus${ps}M_wrBurst
# eval add list $hexopt $tbpath${ps}plb_bus${ps}M_wrDBus
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_addrAck
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_MErr
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_MBusy
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_rdBTerm
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_rdComp
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_rdDAck
# eval add list $hexopt $tbpath${ps}plb_bus${ps}Sl_rdDBus
# eval add list $hexopt $tbpath${ps}plb_bus${ps}Sl_rdWdAddr
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_rearbitrate
# eval add list $hexopt $tbpath${ps}plb_bus${ps}Sl_SSize
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_wait
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_wrBTerm
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_wrComp
# eval add list $binopt $tbpath${ps}plb_bus${ps}Sl_wrDAck
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_ABus
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_BE
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MAddrAck
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MBusy
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MErr
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MRdBTerm
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MRdDAck
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_MRdDBus
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_MRdWdAddr
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MRearbitrate
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MWrBTerm
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_MWrDAck
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_MSSize
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_PAValid
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_RNW
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SAValid
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_abort
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_busLock
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_compress
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_guarded
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_lockErr
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_masterID
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_MSize
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_ordered
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_pendPri
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_pendReq
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_rdBurst
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_rdPrim
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_reqPri
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_size
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_type
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_wrBurst
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_wrDBus
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_wrPrim
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SaddrAck
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SMErr
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SMBusy
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SrdBTerm
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SrdComp
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SrdDAck
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_SrdDBus
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_SrdWdAddr
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_Srearbitrate
  eval add list $hexopt $tbpath${ps}plb_bus${ps}PLB_Sssize
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_Swait
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SwrBTerm
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SwrComp
  eval add list $binopt $tbpath${ps}plb_bus${ps}PLB_SwrDAck
# eval add list $binopt $tbpath${ps}plb_bus${ps}PLB2OPB_rearb
# eval add list $binopt $tbpath${ps}plb_bus${ps}ArbAddrVldReg
# eval add list $binopt $tbpath${ps}plb_bus${ps}Bus_Error_Det

