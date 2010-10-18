TABLE OF CONTENTS
  1) Peripheral Summary
  2) Description of Generated Files
  3) Description of Used IPIC Signals
  4) Description of Top Level Generics


================================================================================
*                             1) Peripheral Summary                            *
================================================================================
Peripheral summary

  XPS project / EDK repository               : /home/droz/XPS_iBOB_base
  logical library name                       : plb_sram_v1_00_a
  top name                                   : plb_sram
  version                                    : 1.00.a
  type                                       : PLB slave
  features                                   : slave attachement
                                               burst and cacheline
                                               user address ranges

Address Block for User Logic and IPIF Predefined Services

  User logic address range 0 service         : C_AR0_BASEADDR
                                             : C_AR0_HIGHADDR


================================================================================
*                          2) Description of Generated Files                   *
================================================================================
- HDL source file(s)
  /home/droz/XPS_iBOB_base/pcores/plb_sram_v1_00_a/hdl

  vhdl/plb_sram.vhd

    This is the template file for your peripheral's top design entity. It
    configures and instantiates the corresponding IPIF unit in the way you
    indicated in the wizard GUI and hooks it up to the stub user logic where
    the actual functionalites should get implemented. You are not expected to
    modify this template file except certain marked places for adding user
    specific generics and ports.

  vhdl/user_logic.vhd

    This is the template file for the stub user logic design entity, either in
    VHDL or Verilog, where the actual functionalities should get implemented.
    Some sample code snippet may be provided for demonstration purpose.


- XPS interface file(s)
  /home/droz/XPS_iBOB_base/pcores/plb_sram_v1_00_a/data

  plb_sram_v2_1_0.mpd

    This Microprocessor Peripheral Description file contains information of the
    interface of your peripheral, so that other EDK tools can recognize your
    peripheral.

  plb_sram_v2_1_0.pao

    This Peripheral Analysis Order file defines the analysis order of all the HDL
    source files that are used to compile your peripheral.


- BFM simulation project file(s)
  /home/droz/XPS_iBOB_base/pcores/plb_sram_v1_00_a/devl/bfmsim

  README.txt

    This is the BFM simulation guide file.

  bfm_system.mhs

    This is the BFM simulation platform description file, read by SimGen to
    generate the BFM behavioral simulation test benches.

  bfm_system.mss

    This is an empty Microprocessor Software System file to work around XPS warning.

  bfm_sim_xps.make

    This is the custom makefile for the XPS BFM simulation project, to compile BFM
    simulation models, compile sample BFL commands and start BFM simulation.

  bfm_sim_cmd.make

    This is the makefile for command line usage purpose, to compile BFM
    simulation models, compile sample BFL commands and start BFM simulation.

  bfm_system.xmp

    This is the XPS project file for this BFM simulation project.

  scripts/run.do

    This is the ModelSim Tcl command file to load models and start simulation.

  scripts/wave.do

    This is the ModelSim wave window signal list file.

  scripts/sample.bfl

    This is the sample BFL command file to test various features in the templates.
    It must be modified together with the IP testbench for synchronization purpose.


- BFM simulation IP testbench file(s)
  /home/droz/XPS_iBOB_base/pcores/plb_sram_v1_00_a/devl/bfmsim/pcores/plb_sram_tb_1_00_a

  hdl/vhdl/plb_sram_tb.vhd

    This is the peripheral IP testbench to be used in BFM or hardware simualtion.

  data/plb_sram_tb_v2_1_0.mpd

    This is Microprocessor Peripheral Description file for the peripheral IP testbench.

  data/plb_sram_tb_v2_1_0.pao

    This is Peripheral Analysis Order file for the peripheral IP testbench.


- Other misc file(s)
  /home/droz/XPS_iBOB_base/pcores/plb_sram_v1_00_a/devl

  ipwiz.opt

    This is the option setting file for the wizard batch mode, which should
    generate the same result as the wizard GUI mode.

  README.txt

    This README file for your peripheral.

  ipwiz.log

    This is the log file by operating on this wizard.


================================================================================
*                         3) Description of Used IPIC Signals                  *
================================================================================
For more information (usage, timing diagrams, etc.) regarding the IPIC signals
used in the templates, please refer to the following specifications (under
%XILINX_EDK%\doc for windows or $XILINX_EDK/doc for solaris and linux):
proc_ip_ref_guide.pdf - Processor IP Reference Guide (chapter 4 IPIF)
user_core_templates_ref_guide.pdf - User Core Templates Reference Guide

Bus2IP_Clk
    This is the clock input to the user logic. All IPIC signals are synchronous 
    to this clock. It is identical to the <bus>_Clk signal that is an input to 
    the user core. In an OPB core, Bus2IP_Clk is the same as OPB_Clk, and in a 
    PLB core, it is the same as PLB_Clk. No additional buffering is provided on 
    the clock; it is passed through as is. 

Bus2IP_Reset
    Signal to reset the User Logic; asserts whenever the <bus>_Rst signal does 
    and, if the Reset block is included, whenever there is a software-programmed 
    reset. 

Bus2IP_Addr
    This is the address bus from the IPIF to the user logic. This bus is the 
    same width as the host bus address bus. The Bus2IP_Addr bus can be used for 
    additional address decoding or as input to addressable memory devices. 

Bus2IP_Burst
    The Bus2IP_Burst signal from the IPIF to the user logic indicates that the 
    current transaction is a burst transaction. 

Bus2IP_RNW
    Bus2IP_RNW is an input to the user logic that indicates the transaction type 
    (read or write). Bus2IP_RNW = 1 indicates a read transaction and Bus2IP_RNW 
    = 0 indicates a write transaction. It is valid whenever at least one 
    Bus2IP_CS is active. 

Bus2IP_RdReq
    The Bus2IP_RdReq signal is an input to the user logic indicating that the 
    requested transaction is a read transfer. Normally you don't have to use the 
    Bus2IP_RdReq signal. 

Bus2IP_WrReq
    The Bus2IP_WrReq signal is an input to the user logic indicating that the 
    requested transaction is a write transfer. Normally you don't have to use 
    the Bus2IP_WrReq signal, except in the burst write transaction, you need to 
    check on Bus2IP_WrReq for data validity. PLB IPIF incorporate a write buffer 
    for burst to solve some timing issue, which causes the data to be valid 2~3 
    cycles after the CS/CE/RNW signals are asserted, so only when Bus2IP_WrReq 
    is asserted that means data is valid. 

IP2Bus_Retry
    IP2Bus_Retry is a response from the user logic to the IPIF that indicates 
    the currently requested transaction cannot be completed at this time and 
    that the requesting master should retry the operation. If the IP2Bus_Retry 
    signal will be delayed more than 8 clocks, then the IP2Bus_ToutSup (timeout 
    suppress) signal must also be asserted to prevent a timeout on the host bus. 
    Note: this signal is unused by PLB IPIF. 

IP2Bus_Error
    This signal from the user logic to the IPIF indicates an error has occurred 
    during the current transaction. It is valid when IP2Bus_Ack is asserted. 

IP2Bus_ToutSup
    The IP2Bus_ToutSup must be asserted by the user logic whenever its 
    acknowledgement or retry response will take longer than 8 clock cycles. 

IP2Bus_AddrAck
    The IP2Bus_AddrAck signal advances the IPIF address counter and request 
    state during multiple data beat transfers, s.t. bursting. 

IP2Bus_Busy
    IP2Bus_Busy indicating the user logic is busy and cannot respond to any new 
    requests. This signal causes the IPIF to reply with a rearbitrate to any new 
    PLB requests that are received from the PLB and meet address decoding 
    criteria. 

IP2Bus_RdAck
    The IP2Bus_RdAck signal provide the read acknowledgement from the user logic 
    to the IPIF. It indicates that valid data is available. For immediate 
    acknowledgement (such as for a register read), this signal can be tied to 
    '1'. Wait states can be inserted in the transaction by delaying the 
    assertion of the acknowledgement. 

IP2Bus_WrAck
    The IP2Bus_WrAck signal provide the write acknowledgement from the user 
    logic to the IPIF. It indicates the data has been taken by the user logic. 
    For immediate acknowledgement (such as for a register write), this signal 
    can be tied to '1'. Wait states can be inserted in the transaction by 
    delaying the assertion of the acknowledgement. 

Bus2IP_ArData
    Similar to Bus2IP_Data, but this data bus is only used to access user logic 
    address ranges. 

Bus2IP_ArBE
    Similar to Bus2IP_BE, but this byte enable bus is only used for user logic 
    address range data bus. 

Bus2IP_ArCS
    Similar to Bus2IP_CS, but each bit corresponds to a particular user logic 
    address range. It indicates a decode within a block of user address range 
    addresses defined by a address range base address and a address range high 
    address. 

IP2Bus_ArData
    Similar to IP2Bus_Data, but this data bus is only used to access user logic 
    address ranges. 

================================================================================
*                     4) Description of Top Level Generics                     *
================================================================================
C_BASEADDR/C_HIGHADDR
    These two generics are used to define the memory mapped address space for
    the peripheral registers, including Reset/MIR register, Interrupt Source
    Controller registers, Read/Write FIFO control/data registers, user logic
    software accessible registers and etc., but excluding those user logic
    address ranges if ever used. When instantiation, the address space size
    determined by these two generics must be a power of 2 (e.g. 2^k =
    C_HIGHADDR - C_BASEADDR + 1), a factor of C_BASEADDR and larger than the
    minimum size as indicated in the template.

C_PLB_DWIDTH
    This is the data bus width for Processor Local Bus (PLB). It should
    always be set to 64 as of today.

C_PLB_AWIDTH
    This is the address bus width for Processor Local Bus (PLB). It should
    always be set to 32 as of today.

C_FAMILY
    This is to set the target FPGA architecture, s.t. virtex2, virtex2p, etc.

C_ARn_BASEADDR/C_ARn_HIGHADDR (n = 0, 1, 2, etc.)
    These two generics are used to define the memory mapped address space for
    user logic address range n, which are typically used in peripherals like
    memory controllers, bridges, that need to access address blocks other
    than local register space. When instantiation, the address space size
    determined by these two generics should be a power of 2 (e.g. 2^k =
    C_ARn_HIGHADDR - C_ARn_BASEADDR + 1) and a factor of C_ARn_BASEADDR.
