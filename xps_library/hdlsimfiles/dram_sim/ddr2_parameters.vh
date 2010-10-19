/****************************************************************************************
*
*   Disclaimer   This software code and all associated documentation, comments or other
*  of Warranty:  information (collectively "Software") is provided "AS IS" without
*                warranty of any kind. MICRON TECHNOLOGY, INC. ("MTI") EXPRESSLY
*                DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
*                TO, NONINFRINGEMENT OF THIRD PARTY RIGHTS, AND ANY IMPLIED WARRANTIES
*                OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. MTI DOES NOT
*                WARRANT THAT THE SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE
*                OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE.
*                FURTHERMORE, MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR
*                THE RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS,
*                ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT OF USE
*                OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO EVENT SHALL MTI,
*                ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE LIABLE FOR ANY DIRECT,
*                INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR SPECIAL DAMAGES (INCLUDING,
*                WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION,
*                OR LOSS OF INFORMATION) ARISING OUT OF YOUR USE OF OR INABILITY TO USE
*                THE SOFTWARE, EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
*                DAMAGES. Because some jurisdictions prohibit the exclusion or
*                limitation of liability for consequential or incidental damages, the
*                above limitation may not apply to you.
*
*                Copyright 2003 Micron Technology, Inc. All rights reserved.
*
****************************************************************************************/

    // Timing parameters based on Speed Grade

`define sg5E
`define x8

                                          // SYMBOL UNITS DESCRIPTION
                                          // ------ ----- -----------
`ifdef sg3E
    parameter tck              =    3000; // tCK    ps    Nominal Clock Cycle Time
    parameter tck_min          =    3000; // tCK    ps    Minimum Clock Cycle Time
    parameter tac_min          =    -450; // tAC    ps    DQ output access time from CK/CK#
    parameter tds              =     100; // tDS    ps    DQ and DM input setup time relative to DQS
    parameter tdh              =     175; // tDH    ps    DQ and DM input hold time relative to DQS
    parameter tdqsq            =     240; // tDQSQ  ps    DQS-DQ skew, DQS to last DQ valid, per group, per access
    parameter twpre            =    0.35; // tWPRE  tCK   DQS Write Preamble
    parameter tis              =     200; // tIS    ps    Input Setup Time
    parameter tih              =     275; // tIH    ps    Input Hold Time
    parameter trc              =   54000; // tRC    ps    Active to Active/Auto Refresh command time
    parameter trcd             =   12000; // tRCD   ps    Active to Read/Write command time
    parameter trp              =   12000; // tRP    ps    Precharge command period
    parameter twtr             =    7500; // tWTR   ps    Write to Read command delay
    parameter txards           =       7; // tXARDS tCK   Exit low power active power down to a read command (the model subtracts the additive latency since that is programmable)
    parameter cl_min           =       4; // CL     tCK   Minimum CAS Latency
`else `ifdef sg3
    parameter tck              =    3000; // tCK    ps    Nominal Clock Cycle Time
    parameter tck_min          =    3000; // tCK    ps    Minimum Clock Cycle Time
    parameter tac_min          =    -450; // tAC    ps    DQ output access time from CK/CK#
    parameter tds              =     100; // tDS    ps    DQ and DM input setup time relative to DQS
    parameter tdh              =     175; // tDH    ps    DQ and DM input hold time relative to DQS
    parameter tdqsq            =     240; // tDQSQ  ps    DQS-DQ skew, DQS to last DQ valid, per group, per access
    parameter twpre            =    0.35; // tWPRE  tCK   DQS Write Preamble
    parameter tis              =     200; // tIS    ps    Input Setup Time
    parameter tih              =     275; // tIH    ps    Input Hold Time
    parameter trc              =   55000; // tRC    ps    Active to Active/Auto Refresh command time
    parameter trcd             =   15000; // tRCD   ps    Active to Read/Write command time
    parameter trp              =   15000; // tRP    ps    Precharge command period
    parameter twtr             =    7500; // tWTR   ps    Write to Read command delay
    parameter txards           =       7; // tXARDS tCK   Exit low power active power down to a read command (the model subtracts the additive latency since that is programmable)
    parameter cl_min           =       5; // CL     tCK   Minimum CAS Latency
`else `ifdef sg37V
    parameter tck              =    3750; // tCK    ps    Nominal Clock Cycle Time
    parameter tck_min          =    3750; // tCK    ps    Minimum Clock Cycle Time
    parameter tac_min          =    -500; // tAC    ps    DQ output access time from CK/CK#
    parameter tds              =     100; // tDS    ps    DQ and DM input setup time relative to DQS
    parameter tdh              =     225; // tDH    ps    DQ and DM input hold time relative to DQS
    parameter tdqsq            =     300; // tDQSQ  ps    DQS-DQ skew, DQS to last DQ valid, per group, per access
    parameter twpre            =    0.25; // tWPRE  tCK   DQS Write Preamble
    parameter tis              =     250; // tIS    ps    Input Setup Time
    parameter tih              =     375; // tIH    ps    Input Hold Time
    parameter trc              =   55000; // tRC    ps    Active to Active/Auto Refresh command time
    parameter trcd             =   11250; // tRCD   ps    Active to Read/Write command time
    parameter trp              =   11250; // tRP    ps    Precharge command period
    parameter twtr             =    7500; // tWTR   ps    Write to Read command delay
    parameter txards           =       6; // tXARDS tCK   Exit low power active power down to a read command (the model subtracts the additive latency since that is programmable)
    parameter cl_min           =       3; // CL     tCK   Minimum CAS Latency
`else `ifdef sg37E
    parameter tck              =    3750; // tCK    ps    Nominal Clock Cycle Time
    parameter tck_min          =    3750; // tCK    ps    Minimum Clock Cycle Time
    parameter tac_min          =    -500; // tAC    ps    DQ output access time from CK/CK#
    parameter tds              =     100; // tDS    ps    DQ and DM input setup time relative to DQS
    parameter tdh              =     225; // tDH    ps    DQ and DM input hold time relative to DQS
    parameter tdqsq            =     300; // tDQSQ  ps    DQS-DQ skew, DQS to last DQ valid, per group, per access
    parameter twpre            =    0.25; // tWPRE  tCK   DQS Write Preamble
    parameter tis              =     250; // tIS    ps    Input Setup Time
    parameter tih              =     375; // tIH    ps    Input Hold Time
    parameter trc              =   55000; // tRC    ps    Active to Active/Auto Refresh command time
    parameter trcd             =   15000; // tRCD   ps    Active to Read/Write command time
    parameter trp              =   15000; // tRP    ps    Precharge command period
    parameter twtr             =    7500; // tWTR   ps    Write to Read command delay
    parameter txards           =       6; // tXARDS tCK   Exit low power active power down to a read command (the model subtracts the additive latency since that is programmable)
    parameter cl_min           =       4; // CL     tCK   Minimum CAS Latency
`else `define sg5E
    parameter tck              =    5000/TIMESCALER; // tCK    ps    Nominal Clock Cycle Time
    parameter tck_min          =    5000/TIMESCALER; // tCK    ps    Minimum Clock Cycle Time
    parameter tac_min          =    -600/TIMESCALER; // tAC    ps    DQ output access time from CK/CK#
    parameter tds              =     150/TIMESCALER; // tDS    ps    DQ and DM input setup time relative to DQS
    parameter tdh              =     275/TIMESCALER; // tDH    ps    DQ and DM input hold time relative to DQS
    parameter tdqsq            =     350/TIMESCALER; // tDQSQ  ps    DQS-DQ skew, DQS to last DQ valid, per group, per access
    parameter twpre            =    0.25;            // tWPRE  tCK   DQS Write Preamble
    parameter tis              =     350/TIMESCALER; // tIS    ps    Input Setup Time
    parameter tih              =     475/TIMESCALER; // tIH    ps    Input Hold Time
    parameter trc              =   55000/TIMESCALER; // tRC    ps    Active to Active/Auto Refresh command time
    parameter trcd             =   15000/TIMESCALER; // tRCD   ps    Active to Read/Write command time
    parameter trp              =   15000/TIMESCALER; // tRP    ps    Precharge command period
    parameter twtr             =   10000/TIMESCALER; // tWTR   ps    Write to Read command delay
    parameter txards           =       6;            // tXARDS tCK   Exit low power active power down to a read command (the model subtracts the additive latency since that is programmable)
    parameter cl_min           =       3;            // CL     tCK   Minimum CAS Latency
`endif `endif `endif `endif

    // Timing Parameters

    // Mode Register
    parameter al_min           =       0;            // AL     tCK   Minimum Additive Latency
    parameter al_max           =       5;            // AL     tCK   Maximum Additive Latency
    parameter cl_max           =       6;            // CL     tCK   Maximum CAS Latency
    parameter wr_min           =       2;            // WR     tCK   Minimum Write Recovery
    parameter wr_max           =       6;            // WR     tCK   Maximum Write Recovery
    // Clock
    parameter tck_max          =    8000/TIMESCALER; // tCK    ps    Maximum Clock Cycle Time
    parameter tch_min          =    0.45;            // tCH    tCK   Minimum Clock High-Level Pulse Width
    parameter tch_max          =    0.55;            // tCH    tCK   Maximum Clock High-Level Pulse Width
    parameter tcl_min          =    0.45;            // tCL    tCK   Minimum Clock Low-Level Pulse Width
    parameter tcl_max          =    0.55;            // tCL    tCK   Maximum Clock Low-Level Pulse Width
    // Data
    parameter tdipw            =    0.35;            // tDIPW  tCK   DQ and DM input Pulse Width
    // Data Strobe
    parameter tdqsh            =    0.35;            // tDQSH  tCK   DQS input High Pulse Width
    parameter tdqsl            =    0.35;            // tDQSL  tCK   DQS input Low Pulse Width
    parameter tdss             =    0.20;            // tDSS   tCK   DQS falling edge to CLK rising (setup time)
    parameter tdsh             =    0.20;            // tDSH   tCK   DQS falling edge from CLK rising (hold time)
    parameter twpst_min        =    0.40;            // tWPST  tCK   Minimum DQS Write Postamble
    parameter tdqss            =    0.25;            // tDQSS  tCK   Rising clock edge to DQS/DQS# latching transition
    // Command and Address
    parameter tipw             =     0.6;            // tIPW   tCK   Control and Address input Pulse Width
    parameter tccd             =       2;            // tCCD   tCK   Cas to Cas command delay
    parameter tras_min         =   40000/TIMESCALER; // tRAS   ps    Minimum Active to Precharge command time
    parameter tras_max         =70000000/TIMESCALER; // tRAS   ps    Maximum Active to Precharge command time
    parameter trtp             =    7500/TIMESCALER; // tRTP   ps    Read to Precharge command delay
    parameter twr              =   15000/TIMESCALER; // tWR    ps    Write recovery time
    parameter trpa             = trp+tck;            // tRPA   ps    Precharge all command period
    parameter tmrd             =       2;            // tMRD   tCK   Load Mode Register command cycle time
    parameter tdllk            =     200;            // tDLLK  tCK   DLL locking time
    // Refresh
    parameter trfc_min         =  105000/TIMESCALER; // tRFC   ps    Refresh to Refresh Command interval minimum value
    parameter trfc_max         =70000000/TIMESCALER; // tRFC   ps    Refresh to Refresh Command Interval maximum value
    // Self Refresh
    parameter txsnr   = trfc_min + 10000/TIMESCALER; // tXSNR  ps    Exit self refesh to a non-read command
    parameter txsrd            =     200;            // tXSRD  tCK   Exit self refresh to a read command
    parameter tisxr            =     tis;            // tISXR  ps    CKE setup time during self refresh exit.
    // ODT
    parameter taond            =       2;            // tAONPD tCK   ODT turn-on delay
    parameter taofd            =     2.5;            // tAONPD tCK   ODT turn-off delay
    parameter taonpd    = tac_min + 2000/TIMESCALER; // tAONPD ps    ODT turn-on (precharge power-down mode)
    parameter taofpd    = tac_min + 2000/TIMESCALER; // tAONPD ps    ODT turn-off (precharge power-down mode)
    parameter tanpd            =       3;            // tANPD  tCK   ODT to power-down entry latency
    parameter taxpd            =       8;            // tAXPD  tCk   ODT power-down exit latency
    // Power Down
    parameter txard            =       2;            // tXARD  tCK   Exit active power down to a read command
    parameter txp              =       2;            // tXP    tCK   Exit power down to a non-read command
    parameter tcke             =       3;            // tCKE   tCK   CKE minimum high or low pulse width

    // Size Parameters based on Part Width

`ifdef x4
    parameter DM_BITS          =       1;            // Set this parameter to control how many Data Mask bits are used
    parameter ADDR_BITS        =      14;            // MAX Address Bits
    parameter ROW_BITS         =      14;            // Set this parameter to control how many Address bits are used
    parameter COL_BITS         =      11;            // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =       4;            // Set this parameter to control how many Data bits are used       **Same as part bit width**
    parameter DQS_BITS         =       1;            // Set this parameter to control how many Dqs bits are used
    parameter trrd             =    7500/TIMESCALER; // tRRD   ps    Active bank a to Active bank b command time
    parameter tfaw             =   37500/TIMESCALER; // tFAW   ps    Four access window time for the number of activates in an 8 bank device
`else `ifdef x8
    parameter DM_BITS          =       1;            // Set this parameter to control how many Data Mask bits are used
    parameter ADDR_BITS        =      14;            // MAX Address Bits
    parameter ROW_BITS         =      14;            // Set this parameter to control how many Address bits are used
    parameter COL_BITS         =      10;            // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =       8;            // Set this parameter to control how many Data bits are used       **Same as part bit width**
    parameter DQS_BITS         =       1;            // Set this parameter to control how many Dqs bits are used
    parameter trrd             =    7500/TIMESCALER; // tRRD   ps    Active bank a to Active bank b command time
    parameter tfaw             =   37500/TIMESCALER; // tFAW   ps    Four access window time for the number of activates in an 8 bank device
`else `define x16
    parameter DM_BITS          =       2;            // Set this parameter to control how many Data Mask bits are used
    parameter ADDR_BITS        =      13;            // MAX Address Bits
    parameter ROW_BITS         =      13;            // Set this parameter to control how many Address bits are used
    parameter COL_BITS         =      10;            // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =      16;            // Set this parameter to control how many Data bits are used       **Same as part bit width**
    parameter DQS_BITS         =       2;            // Set this parameter to control how many Dqs bits are used
    parameter trrd             =   10000/TIMESCALER; // tRRD   ps    Active bank a to Active bank b command time
    parameter tfaw             =   50000/TIMESCALER; // tFAW   ps    Four access window time for the number of activates in an 8 bank device
`endif `endif

    // Size Parameters

    parameter MODE_BITS        =      14; // Set this parameter to control how many bits are in the mode register and extended mode register
    parameter BA_BITS          =       2; // Set this parmaeter to control how many Bank Address bits are used
    parameter MAX_CMD_QUEUE    = (cl_max+al_max)*2; // This number represents the max number of clk edges that a command could be queued up for.
    parameter MEM_BITS         =      16; // Set this parameter to control how many write data bursts can be stored in memory.  The default is 2^10=1024.

    // Simulation parameters

    parameter no_halt          =       0; // If set to 1, the model won't halt on command sequence/major errors
    parameter debug            =       0; // Turn on Debug messages
    parameter bus_delay        =       0; // delay in nanoseconds
