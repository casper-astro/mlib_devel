/****************************************************************************************
*
*    File Name:  ddr2.v
*      Version:  3.30
*        Model:  BUS Functional
*
* Dependencies:  ddr2_parameters.vh
*
*  Description:  Micron SDRAM DDR2 (Double Data Rate 2)
*
*   Limitation:  - Doesn't check for refresh timings, except during Power Down
*                - Model assumes CLK and CLK_N crossing at same edges
*                - Model assumes DQS and DQS_N crossing at same edges
*                - Test Mode is not supported
*
*         Note:  - Set simulator resolution to "ps" accuracy
*                - Set Debug = 0 to disable $display messages
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
* Rev   Author   Date        Changes
* ---------------------------------------------------------------------------------------
* 1.00  JMK      07/29/03    Initial Release
* 1.10  JMK      08/09/03    Timing Parameter updates to tIS, tIH, tDS, tDH
* 2.20  JMK      08/07/03    General cleanup
* 2.30  JMK      11/26/03    Added cl_min, cl_max, wl_min and wl_max parameters.
*                            Added al_min and al_max parameters.
*                            Removed support for OCD.
* 2.40  JMK      01/15/04    Removed verilog 2001 constructs.
* 2.50  JMK      01/29/04    Removed tRP checks during Precharge command.
* 2.60  JMK      04/20/04    Fixed tWTR check.
* 2.70  JMK      04/30/04    Added tRFC maximum check.
*                            Combined Self Refresh and Power Down always blocks.
*                            Added Reset Function (CKE LOW Anytime).
* 2.80  JMK      08/19/04    Precharge is treated as NOP when bank is not active.  
*                            Added checks for tRAS, tWR, tRTP to any bank during Pre-All.
*                            tRFC maximum violation will only display one time.
* 2.90  JMK      11/05/04    Fixed DQS checking during write.
*                            Fixed false tRFC max assertion during power up and self ref.
*                            Added warning for 200us CKE low time during initialization.
*                            Added -3, -3E, and -37V speed grades to ddr2_parameters.v
* 3.00  JMK      04/22/05    Removed ODT off requirement during power down.
*                            Added tAOND, tAOFD, tANPD, tAXPD, tAONPD, and tAOFPD parameters.
*                            Added ODT status messages.
*                            Updated the initialization sequence.
*                            Disable ODT and CLK pins during self refresh.
*                            Disable cmd and addr pins during power down and self refresh.
* 3.10  JMK      06/07/05    Disable tRPA checking if the part does not have 8 banks.
*                            Changed tAXPD message from error to a warning.
*                            Added tDSS checking.
*                            Removed tDQSL checking during tWPRE and tWPST.
*                            Fixed a burst order error during writes.
*                            Renamed parameters file with .vh extension.
* 3.20  JMK      07/18/05    Removed 14 tCK requirement from LMR to READ.
* 3.30  JMK      08/03/05    Added check for interrupting a burst with auto precharge.
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USES "PS" RESOLUTION
`timescale 1ps / 1ps
`define mod_name ddr2

module `mod_name (
    CLK                         ,
    CLK_N                       ,
    CKE                         ,
    CS_N                        ,
    RAS_N                       ,
    CAS_N                       ,
    WE_N                        ,
    DM_RDQS                     ,
    BA                          ,
    ADDR                        ,
    DQ                          ,
    DQS                         ,
    DQS_N                       ,
    RDQS_N                      ,
    ODT                          
);

`include "ddr2_parameters.vh"

    input                         CLK                        ;
    input                         CLK_N                      ;
    input                         CKE                        ;
    input                         CS_N                       ;
    input                         RAS_N                      ;
    input                         CAS_N                      ;
    input                         WE_N                       ;
    inout       [DM_BITS - 1 : 0] DM_RDQS                    ;
    input       [BA_BITS - 1 : 0] BA                         ;
    input     [ADDR_BITS - 1 : 0] ADDR                       ;
    inout       [DQ_BITS - 1 : 0] DQ                         ;
    inout      [DQS_BITS - 1 : 0] DQS                        ;
    inout      [DQS_BITS - 1 : 0] DQS_N                      ;
    output      [DM_BITS - 1 : 0] RDQS_N                     ;
    input                         ODT                        ;

    reg                   [3 : 0] command [0 : MAX_CMD_QUEUE];
    reg        [COL_BITS - 1 : 0] col_addr [0 : MAX_CMD_QUEUE];
    reg         [BA_BITS - 1 : 0] bank_addr [0 : MAX_CMD_QUEUE];
    reg        [ROW_BITS - 1 : 0] bank_row_addr [0 : (1<<BA_BITS)-1];
    reg       [MODE_BITS - 1 : 0] mode_reg                   ;
    reg       [MODE_BITS - 1 : 0] ext_mode_reg_1             ;
    reg    [(1<<BA_BITS) - 1 : 0] precharged_banks           ;
    reg    [(1<<BA_BITS) - 1 : 0] activated_banks            ;
    reg    [(1<<BA_BITS) - 1 : 0] auto_precharge             ; // RW AutoPrecharge Bank
    reg    [(1<<BA_BITS) - 1 : 0] read_precharge             ; // R  AutoPrecharge Command
    reg    [(1<<BA_BITS) - 1 : 0] write_precharge            ; // W  AutoPrecharge Command
    reg         [DQ_BITS - 1 : 0] dq_out                     ;
    reg        [DQS_BITS - 1 : 0] dqs_out                    ;
    reg        [DQS_BITS - 1 : 0] dqs_n_out                  ;
    reg                   [7 : 0] dq_in_pos [3 : 0]          ;
    reg                   [7 : 0] dq_in_neg [3 : 0]          ;
    reg                  [31 : 0] dq_temp                    ;
    reg                   [3 : 0] dm_in_pos                  ;
    reg                   [3 : 0] dm_in_neg                  ;
    reg                     [3:0] check_dm_tdipw             ;
    reg                    [31:0] check_dq_tdipw             ;

    // Commands Decode
    integer                       read_latency               ; // Read latency is based on the write latency being passed in
    integer                       write_latency              ; // Write latency is based on the write latency being passed in
    integer                       burst_order                ; // Burst order (sequential = 0 / interleaved = 1)
    integer                       burst_clocks               ; // Burst length divided by 2 to give number of clk_in used in burst
    integer                       cas_latency_clocks         ; // Cas Latency
    integer                       add_latency_clocks         ; 
    integer                       write_recovery             ;
    integer                       i                          ; // temp variable for looping assignments
    reg                           low_power                  ;
    reg                   [3 : 0] check_write_postamble      ;
    reg                   [3 : 0] check_write_preamble       ;
    reg                   [3 : 0] check_write_dqs_high       ;
    reg                   [3 : 0] check_write_dqs_low        ;
    reg                           data_in_enable             ; // active high when receiving write data
    reg                           data_out_enable            ; // active high when sending read data
    reg                           data_dqs_out_enable        ;
    reg         [BA_BITS - 1 : 0] bank                       ;
    reg        [ROW_BITS - 1 : 0] row                        ;
    reg        [COL_BITS - 1 : 0] col                        ;
    reg        [COL_BITS - 1 : 0] col_brst                   ;
    integer                       burst_counter              ;
    reg                           dll_enabled                ;
    integer                       dll_reset_clocks           ;
    reg                           dll_reset                  ;
    reg                           dll_locked                 ;
    reg                           power_up_done              ;
    reg         [BA_BITS - 1 : 0] previous_bank              ;
    reg                           self_refresh_enter         ;
    reg                           power_down_enter           ;
    reg                           cke_in_one_clk_back        ;
    reg         [8*DQ_BITS-1 : 0] dq_burst                   ;
    reg                           found                      ;
`ifdef FULL_MEM
    reg         [8*DQ_BITS-1 : 0] MEM [0 : (1<<BA_BITS+ROW_BITS+COL_BITS-3)-1];
    reg  [BA_BITS+ROW_BITS+COL_BITS-3-1 : 0] mem_index;
`else
    reg         [8*DQ_BITS-1 : 0] MEM [0 : (1<<MEM_BITS)-1]  ;
    reg  [BA_BITS+ROW_BITS+COL_BITS-3-1 : 0] ADD [0 : (1<<MEM_BITS)-1];
    reg            [MEM_BITS : 0] mem_index                  ;
    reg            [MEM_BITS : 0] mem_used                   ;
`endif

    // DDR2 specific registers
    reg       [MODE_BITS - 1 : 0] ext_mode_reg_2             ;
    reg       [MODE_BITS - 1 : 0] ext_mode_reg_3             ;
    reg                           ext_mode_reg_2_set         ;
    reg                           ext_mode_reg_3_set         ;
    integer                       num_activated_banks        ;
    reg                           trfc_max_violation         ;
    reg                           dqs_n_enabled              ;
    reg                           rdqs_enabled               ;
    integer                       aref_count                 ;
    
    //******************************************************************************************
    // Registers for Delaying all inputs to the dram due to bus delay
    //******************************************************************************************
    reg                  [31 : 0] dq_in                      ;
    reg                   [3 : 0] dqs_in                     ;
    reg                   [3 : 0] dm_in                      ;
    reg                   [2 : 0] ba_in                      ;
    reg                  [15 : 0] addr_in                    ;
    reg                           clk_in                     ;
    reg                           cke_in                     ;
    reg                           cs_n_in                    ;
    reg                           ras_n_in                   ;
    reg                           cas_n_in                   ;
    reg                           we_n_in                    ;
    reg                           odt_in                     ;

    // Timing checks
    time                          tras_chk[(1<<BA_BITS) - 1 : 0];
    time                          twr_chk[(1<<BA_BITS) - 1 : 0] ;
    time                          tmrd_chk                   ;
    time                          trcd_chk[(1<<BA_BITS) - 1 : 0];
    time                          trp_chk[(1<<BA_BITS) - 1 : 0] ;
    time                          trpa_chk                   ;
    time                          tccd_chk                   ;
    time                          trc_chk[(1<<BA_BITS) - 1 : 0] ;
    time                          trrd_chk                   ;
    time                          trtw_chk                   ;
    time                          tdqss_chk                  ;
    time                          twtr_chk                   ;
    time                          tcke_chk                   ;
    time                          trtp_chk[(1<<BA_BITS) - 1 : 0];
    time                          twriteapre_chk[(1<<BA_BITS) - 1 : 0];
    time                          treadapre_chk[(1<<BA_BITS) - 1 : 0];
    time                          trfc_chk                   ;
    time                          txs_chk                    ;
    time                          txp_chk                    ;
    time                          txards_chk                 ;
    time                          tanpd_chk                  ;
    time                          prev_dqs_rise[3 : 0]       ;
    time                          prev_dqs_fall[3 : 0]       ;
    time                          cke_event                  ;
    time                          cs_n_event                 ;
    time                          cas_n_event                ;
    time                          ras_n_event                ;
    time                          we_n_event                 ;
    time                          ba_event [2 : 0]           ;
    time                          addr_event [15 : 0]        ;
    time                          dqs_event [3 : 0]          ;
    time                          dm_event [3 : 0]           ;
    time                          dq_event [31 : 0]          ;
    time                          odt_event                  ;
    time                          clk_rise_event             ;
    time                          clk_fall_event             ;

    //Commands Operation
    `define   LMR       4'h0
    `define   REF       4'h1
    `define   PRE       4'h2
    `define   ACT       4'h3
    `define   WRITE     4'h4
    `define   READ      4'h5
    `define   NOP       4'h7

    wire [3:0] cmd = (~cs_n_in) ? {cs_n_in, ras_n_in, cas_n_in, we_n_in} : `NOP;
    reg  [3:0] cmd_prev;
    time       cmd_chk;

    // ODT variables
    reg odt_enabled;
    reg [0 : MAX_CMD_QUEUE] odt_in_pipe;
    reg data_in_valid;
    reg odt_data;

    reg outputs_enabled;
    assign DQ      = outputs_enabled ? dq_out    :  {DQ_BITS{1'bz}};
    assign DQS     = outputs_enabled ? dqs_out   : {DQS_BITS{1'bz}};
    assign DQS_N   = (outputs_enabled & dqs_n_enabled) ? dqs_n_out : {DQS_BITS{1'bz}};
    assign DM_RDQS = (outputs_enabled & rdqs_enabled)  ? dqs_out   : {DQS_BITS{1'bz}};
    assign RDQS_N  = (outputs_enabled & rdqs_enabled & dqs_n_enabled) ? dqs_n_out : {DQS_BITS{1'bz}};

    initial begin
        reset_task;
`ifdef FULL_MEM
`else
        mem_used                =                 0 ;
        if (MEM_BITS > BA_BITS+ROW_BITS+COL_BITS-3)
            $display ("%m WARNING: You have allocated more memory space than necessary.");
`endif
        if (DM_BITS < 0 || DM_BITS > 4)
            $display ("%m ERROR:  DM_BITS parameter must be between 0 and 4");
        if (DQS_BITS < 0 || DQS_BITS > 4)
            $display ("%m ERROR:  DQS_BITS parameter must be between 0 and 4");
        if (DQ_BITS !== 4 && DQ_BITS !== 8 && DQ_BITS !== 16 && DQ_BITS !== 32)
            $display ("%m ERROR:  DQ_BITS parameter must be 4, 8, 16, or 32");
        if (ADDR_BITS < 0 || ADDR_BITS > 16)
            $display ("%m ERROR:  ADDR_BITS parameter must be between 0 and 16");
        if (BA_BITS < 0 || BA_BITS > 3)
            $display ("%m ERROR:  BA_BITS parameter must be between 0 and 3");
        $timeformat (-12, 1, " ps", 1)              ;
    end


    //**************************************************
    // Delaying all inputs to the dram due to bus delay
    //**************************************************
    always @(DQ or DQS or DM_RDQS or BA or ADDR or CLK or CKE or CS_N or RAS_N or CAS_N or WE_N or ODT) begin
        dq_in    <= #bus_delay {{32-DQ_BITS{1'b0}}, DQ};
        dqs_in   <= #bus_delay {{4-DQS_BITS{1'b0}}, DQS};
        dm_in    <= #bus_delay {{4-DM_BITS{1'b0}}, DM_RDQS};
        ba_in    <= #bus_delay {{3-BA_BITS{1'b0}}, BA};
        addr_in  <= #bus_delay {{16-ADDR_BITS{1'b0}}, ADDR};
        clk_in   <= #bus_delay     CLK;
        cke_in   <= #bus_delay     CKE;
        cs_n_in  <= #bus_delay    CS_N;
        ras_n_in <= #bus_delay   RAS_N;
        cas_n_in <= #bus_delay   CAS_N;
        we_n_in  <= #bus_delay    WE_N;
        odt_in   <= #bus_delay     ODT;
    end

    // report ODT status
    always @(odt_data) begin
        if (odt_data) begin
            if (debug) $display ("%m: at time %t : On-Die Termination for Data is ON", $time);
        end else begin
            if (debug) $display ("%m: at time %t : On-Die Termination for Data is OFF", $time);
        end
    end

    always @(cas_latency_clocks or add_latency_clocks) begin
        read_latency = cas_latency_clocks + add_latency_clocks;
        write_latency = read_latency - 1;
        if ((read_latency*2 > MAX_CMD_QUEUE) || (write_latency*2 > MAX_CMD_QUEUE)) begin
            $display("%m at time %t ERROR: Command Queue Overflow.  You must increase the MAX_CMD_QUEUE parameter.", $time);
            if (!no_halt) $stop(0);
        end
    end

    // Check the initialization sequence
    always @ (posedge cke_in_one_clk_back) begin
        if (!power_up_done) begin
`ifdef FULL_MEM
            for (i=0; i<=((1<<BA_BITS+ROW_BITS+COL_BITS-3)-1); i=i+1) begin //erase memory ... one address at a time
                MEM[i] <= 'bx;
            end
`else
            mem_used <= 0;                                                  //erase memory
`endif
            if (200000000 > $time) 
				// DROZ: removed to remove warning at simulation start when startup reset counter time is reduced to 0
                // $display ("%m at time %t WARNING: A 200 us delay is required before CKE can transition HIGH.", $time);
            if ((cmd_chk + 200000000 > $time) || (cmd !== `NOP))
				// DROZ: removed to remove warning at simulation start when startup reset counter time is reduced to 0
                // $display("%m: at time %t WARNING:  NOP or DESELECT should be maintained for 200 us before CKE transitions HIGH", $time);
            @ (posedge dll_enabled) begin                                   //Enable the DLL
                @ (posedge dll_reset) begin                                 //Reset the DLL
                    wait (ext_mode_reg_2_set && ext_mode_reg_3_set) begin
                        aref_count        <= 0;                                     
                        precharged_banks   =                  0;
                        activated_banks    = {1<<BA_BITS{1'b1}};            //require PRECHARGE commands or PRECHARGE ALL
                        wait (aref_count >= 2) begin                        //2 or more Refresh commands
                            wait (ext_mode_reg_1[9:7] == 3'b111) begin      //OCD Default
                                wait (ext_mode_reg_1[9:7] == 3'b000) begin  //OCD Exit
                                    wait(!dll_reset) begin                  //clear DLL reset in MR
                                        if (debug) $display ("%m: at time %t MEMORY:  Power Up and Initialization Sequence is complete", $time);
                                        power_up_done <= 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    // Main always loop
    always @(clk_in) begin
        data_task;
        if (clk_in) begin
            cmd_task;

            // check setup of command signals
            if ($time > tis) begin
                if (cke_event + tis > $time) 
                    $display ("%m: at time %t ERROR: tIS violation on CKE by %t", $time, cke_event + tis - $time);
                if (cke_in) begin
                    if (cs_n_event + tis > $time) 
                        $display ("%m: at time %t ERROR: tIS violation on CS_N by %t", $time, cs_n_event + tis - $time);
                    if (ras_n_event + tis > $time) 
                        $display ("%m: at time %t ERROR: tIS violation on RAS_N by %t", $time, ras_n_event + tis - $time);
                    if (cas_n_event + tis > $time) 
                        $display ("%m: at time %t ERROR: tIS violation on CAS_N by %t", $time, cas_n_event + tis - $time);
                    if (we_n_event + tis > $time) 
                        $display ("%m: at time %t ERROR: tIS violation on WE_N by %t", $time, we_n_event + tis - $time);
                    for (i=0; i< 3; i=i+1) begin
                        if (ba_event[i] + tis > $time) 
                            $display ("%m: at time %t ERROR: tIS violation on BA bit %d by %t", $time, i, ba_event[i] + tis - $time);
                    end
                    for (i=0; i<16; i=i+1) begin
                        if (addr_event[i] + tis > $time) 
                            $display ("%m: at time %t ERROR: tIS violation on ADDR bit %d by %t", $time, i, addr_event[i] + tis - $time);
                    end
                end
            end

            clk_rise_event <= $time;
        end else begin
            odt_in_pipe[0] = odt_in_pipe[1];
            clk_fall_event = $time;
        end

        // ODT
        if (!self_refresh_enter && odt_enabled) begin
            // async ODT mode applies:
            // 1.) during slow exit power down
            // 2.) during precharge power down
            // 3.) until tAXPD has been satisfied
            if ((power_down_enter && (low_power || &precharged_banks)) || (txp_chk + taxpd*tck > $time)) begin
                if (odt_in_pipe[0]) begin
                    odt_data = #(taonpd) 1'b1;
                end else begin
                    odt_data = #(taofpd) 1'b0;
                end
            // sync ODT mode applies:
            // 1.) during normal operation
            // 2.) during fast exit power down
            end else begin
                if (odt_in_pipe[$rtoi(taond*2.0)]) begin
                    odt_data = 1'b1;
                end else if (~odt_in_pipe[$rtoi(taofd*2.0)]) begin
                    odt_data = 1'b0;
                end
            end
        end
    end

    always @(dqs_in[0]) dqs_receiver(0);
    always @(dqs_in[1]) dqs_receiver(1);
    always @(dqs_in[2]) dqs_receiver(2);
    always @(dqs_in[3]) dqs_receiver(3);

    task dqs_receiver;
    input i;
    integer i;
    begin
        if (dqs_in[i]) begin
            case (i)
                0: dq_in_pos[i] <= dq_in[ 7: 0];
                1: dq_in_pos[i] <= dq_in[15: 8];
                2: dq_in_pos[i] <= dq_in[23:16];
                3: dq_in_pos[i] <= dq_in[31:24];
            endcase
            dm_in_pos[i] <= dm_in[i];
        end else if (!dqs_in[i]) begin
            case (i)
                0: dq_in_neg[i] <= dq_in[ 7: 0];
                1: dq_in_neg[i] <= dq_in[15: 8];
                2: dq_in_neg[i] <= dq_in[23:16];
                3: dq_in_neg[i] <= dq_in[31:24];
            endcase
            dm_in_neg[i] <= dm_in[i];  
        end
    end
    endtask

    task reset_task;
        begin
            // disable inputs
            data_in_enable      =                  0;
            data_in_valid       =                  0;
            // disable outputs
            outputs_enabled     =                  0;
            dqs_n_enabled       =                  0;
            rdqs_enabled        =                  0;
            // disable ODT
            odt_enabled         =                  0;
            odt_data            =                  0;
            // reset bank state
            precharged_banks    =                  0;
            activated_banks     = {1<<BA_BITS{1'b1}};
            auto_precharge      =                  0;
            // require initialization sequence
            power_up_done      <=                  0;
            ext_mode_reg_2_set  =                  0;
            ext_mode_reg_3_set  =                  0;
            // reset DLL
            dll_reset           =                  0;
            dll_enabled         =                  0;
            dll_locked          =                  0;
            // exit power down and self refresh
            power_down_enter    =                  0;
            self_refresh_enter  =                  0;
        end
    endtask
    
    task get_mem_index;
        input [BA_BITS+ROW_BITS+COL_BITS-3-1 : 0] add;
        begin
`ifdef FULL_MEM
            mem_index = add;
            found = 1;
`else
            mem_index = 0;
            found = 0;
            while ((mem_index < mem_used) && !found) begin
                if (ADD[mem_index] === add)
                    found = 1;
                else
                    mem_index = mem_index + 1;
            end
`endif
        end
    endtask

    task write_mem;
        input [BA_BITS+ROW_BITS+COL_BITS-3-1 : 0] add;
        input    [8*DQ_BITS - 1 : 0] data;
        begin
            get_mem_index(add);
`ifdef FULL_MEM
`else
            if (!found) begin
                if (mem_used === (1<<MEM_BITS)) begin
                    $display ("%m: at time %t ERROR: Memory overflow.  Write to Address %h with Data %h will be lost.", $time, add, data);
                    $display ("%m: You must increase the MEM_BITS parameter or define FULL_MEM.");
                    if (!no_halt) $stop(0);
                end else
                    mem_used = mem_used + 1;
                ADD[mem_index] = add;
            end
`endif
            MEM[mem_index] = data;
        end
    endtask

    task read_mem;
        input  [BA_BITS+ROW_BITS+COL_BITS-3-1 : 0] add;
        output    [8*DQ_BITS - 1 : 0] data;
        begin
            get_mem_index(add);
            if (found)
                data = MEM[mem_index];
            else
                data = {8*DQ_BITS{1'bx}};
        end
    endtask

    // task that runs at every positive edge of clk_in
    task cmd_task;
        begin

            // clk and odt pins are disabled during self refresh
            if (!self_refresh_enter) begin
                // ODT
                if (odt_enabled) begin
                    if (odt_event + tis > $time) 
                        $display ("%m: at time %t ERROR: tIS violation on ODT by %t", $time, odt_event + tis - $time);
                    odt_in_pipe[0] = odt_in;
                    if (odt_in_pipe[1] ^ odt_in) begin
                        if (txp_chk + taxpd*tck > $time)
                            $display ("%m: at time %t WARNING: tAXPD violation during ODT transition", $time);
                        tanpd_chk = $time;
                        if (tmrd_chk > 0) if (tmrd_chk + 8*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during ODT transition.  8 clocks are required.", $time);
                    end
                end
            end

            if (cmd !== cmd_prev) begin  
                cmd_chk = $time;
            end
            cmd_prev = cmd;

            // DLL Reset Check
            if (dll_reset) begin
                dll_reset_clocks = dll_reset_clocks + 1;
                if (dll_reset_clocks >= tdllk) begin
                    dll_locked = 1;
                    dll_reset = 0;
                end
            end

            // tRFC max check
            if (!trfc_max_violation) begin
                if (trfc_chk > 0) if ($time - trfc_chk > trfc_max) begin
                    $display ("%m: at time %t ERROR: tRFC maximum violation", $time);
                    if (!no_halt) $stop(0);
                    trfc_max_violation = 1;
                end
            end

            for (i=0; i<(1<<BA_BITS); i=i+1) begin
                // Indicate that the bank is precharged at the end of the tRP time
                if (trp_chk[i] > 0) if (trp_chk[i] + trp <= $time) begin
                    precharged_banks[i] = 1'b1;
                    trp_chk[i] = 0;
                end
            end

            //  Read with Auto Precharge Calculation
            //      The device start internal precharge:
            //          1.  Additive Latency PLUS 2 cycles after Read command
            //          2.  Meet minimum tRAS requirement
            //          3.  Additive Latency PLUS tRTP cycles after Read command
            for (i=0; i<(1<<BA_BITS); i=i+1) begin
                if ((auto_precharge[i]) && (read_precharge[i]) && (($time - tras_chk[i]) >= tras_min)) begin
                    if ((($time - treadapre_chk[i]) >= (add_latency_clocks + burst_clocks - 2)*tck + trtp) && (($time - treadapre_chk[i]) >= (add_latency_clocks + 2)*tck)) begin
                        activated_banks[i]  = 1'b0;
                        auto_precharge[i] = 1'b0;
                        read_precharge[i] = 1'b0;
                        trp_chk[i] = tras_chk[i] + tras_min;
                        if ((treadapre_chk[i] + (add_latency_clocks + 2)*tck) > trp_chk[i]) begin
                            trp_chk[i] = (treadapre_chk[i] + (add_latency_clocks + 2)*tck);
                        end
                        if ((treadapre_chk[i] + (add_latency_clocks + burst_clocks - 2)*tck + trtp) > trp_chk[i]) begin
                            trp_chk[i] = (treadapre_chk[i] + (add_latency_clocks + burst_clocks - 2)*tck + trtp);
                        end
                        if (debug) $display ("%m: at time %t APRE : Start Internal Read Auto Precharge for Bank %d", $time, i);
                    end
                end
            end

            //  Write with Auto Precharge Calculation
            //      The device start internal precharge
            //          1.  CAS Write Latency PLUS BL/2 cycles PLUS WR after Write command
            //          2.  Meet minimum tRAS requirement
            for (i=0; i<(1<<BA_BITS); i=i+1) begin
                if ((auto_precharge[i]) && (write_precharge[i]) && (($time - tras_chk[i]) >= tras_min)) begin
                    if (($time - twr_chk[i]) >= (write_latency + burst_clocks + write_recovery)*tck) begin
                        activated_banks[i]  = 1'b0;
                        auto_precharge[i] = 1'b0;
                        write_precharge[i] = 1'b0;
                        trp_chk[i] = tras_chk[i] + tras_min;
                        if ((twriteapre_chk[i] + (write_latency + burst_clocks + write_recovery)*tck) > trp_chk[i]) begin
                            trp_chk[i] = (twriteapre_chk[i] + (write_latency + burst_clocks + write_recovery)*tck);
                        end
                        if (debug) $display ("%m: at time %t APRE : Start Internal Write Auto Precharge for Bank %d", $time, i);
                    end
                end
            end

            // Command Decode
            if (cke_in) begin
                case (cmd)
                    `LMR : begin // Load Mode Register
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during Load Mode Register %d", $time, ba_in);
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                            $display ("%m: at time %t ERROR: tRFC violation during Load Mode Register %d", $time, ba_in);
                        for (i=0; i<(1<<BA_BITS); i=i+1) begin
                            if (trp_chk[i] > 0) if ((trp_chk[i] + trp > $time))
                                $display ("%m: at time %t ERROR: tRP violation during Load Mode Register %d", $time, ba_in);
                        end
                        if (trpa_chk > 0) if (trpa_chk + trpa > $time)
                            $display ("%m: at time %t ERROR: tRPA violation during Load Mode Register %d", $time, ba_in);
                        if (txp_chk + txp*tck > $time)
                            $display ("%m: at time %t ERROR: tXP violation during Load Mode Register %d", $time, ba_in);
                        if (($time > txsnr) && (txs_chk + txsnr > $time))
                            $display ("%m: at time %t ERROR: tXSNR violation during Load Mode Register %d", $time, ba_in);

                        if (&precharged_banks) begin // All banks precharged?
                            case (ba_in)
                                0 : begin
                                    mode_reg = addr_in & {{MODE_BITS-9{1'b1}}, 9'h0FF}; // FILL THE MODE REGISTER
                                    if (debug) $display ("%m: at time %t LMR  : Load Mode Register", $time);
                                    // Burst Length
                                    if (mode_reg[2:0] == 3'b010) begin
                                        if (debug) $display ("%m: at time %t LMR  : Burst Length = 4", $time);
                                        burst_clocks = 2;
                                    end else if (mode_reg[2:0] == 3'b011) begin
                                        if (debug) $display ("%m: at time %t LMR  : Burst Length = 8", $time);
                                        burst_clocks = 4;
                                    end else begin
                                        $display ("%m: at time %t ERROR: BURST LENGTH SPECIFIED NOT SUPPORTED", $time);
                                    end
                                    // Burst Type
                                    if (mode_reg[3]) begin
                                        if (debug) $display ("%m: at time %t LMR  : Burst Type = Interleaved", $time);
                                        burst_order = 1;
                                    end else begin
                                        if (debug) $display ("%m: at time %t LMR  : Burst Type = Sequential", $time);
                                        burst_order = 0;
                                    end
                                    // CAS Latency
                                    if ((mode_reg[6:4] >= cl_min) && (mode_reg[6:4] <= cl_max)) begin
                                        if (debug) $display ("%m: at time %t LMR  : CAS Latency = %d", $time, mode_reg[6:4]);
                                        cas_latency_clocks = mode_reg[6:4];
                                    end else begin
                                        $display ("%m: at time %t ERROR: CAS LATENCY SPECIFIED NOT SUPPORTED", $time);
                                    end
                                    // Test
                                    if (mode_reg[7]) begin
                                        $display ("%m: at time %t ERROR: TEST MODE IS NOT SUPPORTED", $time);
                                    end else begin
                                        if (debug) $display ("%m: at time %t LMR  : Normal Mode", $time);
                                    end
                                    // DLL Reset
                                    if (addr_in[8]) begin
                                        if (!dll_enabled)
                                            $display ("%m: at time %t ERROR: DLL must be enabled in EMR prior to DLL reset.", $time);
                                        if (debug) $display ("%m: at time %t LMR  : Normal Operation/Reset DLL", $time);
                                        dll_locked = 0;
                                        dll_reset = 1;
                                        dll_reset_clocks = 0;
                                    end else begin
                                        if (debug) $display ("%m: at time %t LMR  : Normal Operation", $time);
                                    end
                                    // Write Recovery
                                    if ((mode_reg[11:9] + 1 >= wr_min) && (mode_reg[11:9] + 1 <= wr_max)) begin
                                        if (debug) $display ("%m: at time %t LMR  : Write Recovery = %d", $time, mode_reg[11:9] + 1);
                                        write_recovery  = mode_reg[11:9] + 1;
                                    end else begin
                                        $display ("%m: at time %t ERROR: WRITE RECOVERY SPECIFIED NOT SUPPORTED", $time);
                                    end
                                    // Check to make sure write recovery was programmed greater or equal to the twr parameter
                                    if (write_recovery < twr/tck) begin
                                        $display ("%m: at time %t ERROR: WR in MR cannot be less than twr/tck", $time);
                                    end 
                                    // power down mode
                                    if (mode_reg[12]) begin
                                        if (debug) $display ("%m: at time %t LMR  : Power Down Mode = Fast Exit", $time);
                                        low_power = 1'b0;
                                    end else begin
                                        if (debug) $display ("%m: at time %t LMR  : Power Down Mode = Slow Exit", $time);
                                        low_power = 1'b1;
                                    end
                                end
                                1 : begin
                                    ext_mode_reg_1 = addr_in; // FILL THE EXTENDED MODE REGISTER
                                    if (debug) $display ("%m: at time %t EMR  : Load Extended Mode Register 1", $time);
                                    // Report the status of the DLL
                                    if (!ext_mode_reg_1[0]) begin
                                        if (debug) $display ("%m: at time %t EMR  : Enable DLL", $time);
                                        dll_enabled = 1;
                                    end else begin
                                        if (debug) $display ("%m: at time %t EMR  : Disable DLL", $time);
                                        dll_enabled = 0;
                                    end
                                    // Report the Output Drive Strength
                                    if (ext_mode_reg_1[1]) begin
                                        if (debug) $display ("%m: at time %t EMR  : Normal Drive Strength", $time);
                                    end else begin
                                        if (debug) $display ("%m: at time %t EMR  : Weak Drive Strength", $time);
                                    end
                                    // Report the Rtt for ODT
                                    if ({ext_mode_reg_1[6], ext_mode_reg_1[2]} == 2'b00) begin
                                        if (debug) $display ("%m: at time %t EMR  : ODT Rtt Disabled", $time);
                                        odt_enabled = 0;
                                    end else if ({ext_mode_reg_1[6], ext_mode_reg_1[2]} == 2'b01) begin
                                        if (debug) $display ("%m: at time %t EMR  : ODT Rtt = 75 Ohm", $time);
                                        odt_enabled = 1;
                                    end else if ({ext_mode_reg_1[6], ext_mode_reg_1[2]} == 2'b10) begin
                                        if (debug) $display ("%m: at time %t EMR  : ODT Rtt = 150 Ohm", $time);
                                        odt_enabled = 1;
                                    end else begin
                                        $display ("%m: at time %t ERROR: ODT Rtt VALUE SPECIFIED NOT SUPPORTED", $time);
                                        odt_enabled = 0;
                                    end
                                    // Report the additive latency value
                                    if ((ext_mode_reg_1[5:3] >= al_min) && (ext_mode_reg_1[5:3] <= al_max)) begin
                                        if (debug) $display ("%m: at time %t EMR  : Additive Latency = %d", $time, ext_mode_reg_1[5:3]);
                                        add_latency_clocks = ext_mode_reg_1[5:3];
                                    end else begin
                                        $display ("%m: at time %t ERROR: ADDITIVE LATENCY SPECIFIED NOT SUPPORTED", $time);
                                    end
                                    // Report the DQS_N Enable Status
                                    if (!ext_mode_reg_1[10]) begin
                                        if (debug) $display ("%m: at time %t EMR  : DQS_N Enabled", $time);
                                        dqs_n_enabled = 1;
                                    end else begin
                                        if (debug) $display ("%m: at time %t EMR  : DQS_N Disabled", $time);
                                        dqs_n_enabled = 0;
                                    end 
                                    // Report the RDQS Enable Status
                                    if (ext_mode_reg_1[11]) begin
                                        if (debug) $display ("%m: at time %t EMR  : RDQS Enabled", $time);
                                        rdqs_enabled = 1;
                                        if ((DQ_BITS == 4) || (DQ_BITS == 16))
                                            $display ("%m: at time %t ERROR: RDQS Enabled - RDQS doesn't exist in a x4 or x16 part", $time);
                                    end else begin
                                        if (debug) $display ("%m: at time %t EMR  : RDQS Disabled", $time);
                                        rdqs_enabled = 0;
                                    end 
                                    // Report Output Enable/Disable Status
                                    if (!ext_mode_reg_1[12]) begin
                                        if (debug) $display ("%m: at time %t EMR  : Outputs Enabled", $time);
                                        outputs_enabled = 1;
                                    end else begin
                                        if (debug) $display ("%m: at time %t EMR  : Outputs Disabled", $time);
                                        outputs_enabled = 0;
                                    end 
                                    // Check for reserved bits being used
                                    if (ext_mode_reg_1[14:13] !== 4'h0) begin
                                        $display ("%m: at time %t ERROR : Reserved bits in EMR must be programmed to zero.", $time);
                                    end
                                end
                                2 : begin
                                    ext_mode_reg_2 = addr_in; // FILL THE EXTENDED MODE REGISTER 2
                                    if (debug) $display ("%m: at time %t EMR  : Load Extended Mode Register 2", $time);
                                    // Check for reserved bits being used
                                    if (ext_mode_reg_2[12:0] !== 0) begin
                                        $display ("%m: at time %t ERROR : Reserved bits in EMR 2 must be programmed to zero.", $time);
                                    end
                                    ext_mode_reg_2_set = 1;
                                end
                                3 : begin
                                    ext_mode_reg_3 = addr_in; // FILL THE EXTENDED MODE REGISTER 3
                                    if (debug) $display ("%m: at time %t EMR  : Load Extended Mode Register 3", $time);
                                    // Check for reserved bits being used
                                    if (ext_mode_reg_3 !== 0) begin
                                        $display ("%m: at time %t ERROR : Reserved bits in EMR 3 must be programmed to zero.", $time);
                                    end
                                    ext_mode_reg_3_set = 1;
                                end
                            endcase
                        end else begin
                            $display ("%m: at time %t ERROR: All banks must be Precharged before Load Mode Register Command", $time);
                            if (!no_halt) $stop (0);
                        end
                        tmrd_chk <= $time;
                    end

                    `REF : begin // Refresh
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during Refresh", $time);
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                            $display ("%m: at time %t ERROR: tRFC violation during Refresh", $time);
                        for (i=0; i<(1<<BA_BITS); i=i+1) begin
                            if (trp_chk[i] > 0) if (trp_chk[i] + trp > $time)
                                $display ("%m: at time %t ERROR: tRP violation during Refresh", $time);
                        end
                        if (trpa_chk > 0) if (trpa_chk + trpa > $time)
                            $display ("%m: at time %t ERROR: tRPA violation during Refresh", $time);
                        for (i=0; i<(1<<BA_BITS); i=i+1) begin
                            if (trc_chk[i] > 0) if (trc_chk[i] + trc > $time)
                                $display ("%m: at time %t ERROR: tRC violation during Refresh", $time);
                        end
                        if (txp_chk + txp*tck > $time)
                            $display ("%m: at time %t ERROR: tXP violation during Refresh", $time);
                        if (($time > txsnr) && (txs_chk + txsnr > $time) )
                            $display ("%m: at time %t ERROR: tXSNR violation during Refresh", $time);

                        if (&precharged_banks) begin // All banks precharged?
                            // Display Debug Message
                            if (debug) $display ("%m: at time %t AREF : Refresh", $time);
                        end else begin
                            $display ("%m: at time %t ERROR: All banks must be Precharged before an Refresh", $time);
                            if (!no_halt) $stop (0);
                        end
                        trfc_chk = $time;
                        trfc_max_violation = 0;
                        aref_count <= aref_count + 1;
                    end

                    `PRE : begin // Precharge
                        if (!power_up_done && (tcke_chk + 400000 > $time))
                            $display ("%m at time %t WARNING: A 400 ns delay is required before Precharge All can be issued after CKE transitions HIGH.", $time);

                        if (auto_precharge[ba_in]) begin
                            $display ("%m: at time %t ERROR: Cannot Precharge - Auto Precharge is scheduled to Bank %d", $time, ba_in);
                            if (!no_halt) $stop (0);
                        end else begin
                            if (addr_in[10]) begin
                                if (debug) $display ("%m: at time %t PRE  : Precharge All Banks", $time);
                            end else begin
                                if (debug) $display ("%m: at time %t PRE  : Precharge Bank %d", $time, ba_in);
                            end
                            for (i=0; i<(1<<BA_BITS); i=i+1) begin
                                if (activated_banks[i] && (addr_in[10] || (i == ba_in))) begin
                                    if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                                        $display ("%m: at time %t ERROR: tMRD violation during Precharge", $time);
                                    if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                                        $display ("%m: at time %t ERROR: tRFC violation during Precharge", $time);
                                    if (tras_chk[i] > 0) if (tras_chk[i] + tras_min > $time) 
                                        $display ("%m: at time %t ERROR: tRAS minimum violation during Precharge to Bank %d", $time, i);
                                    if (twr_chk[i] > 0) if ((twr_chk[i] + (write_latency + burst_clocks)*tck + twr) > $time) 
                                        $display ("%m: at time %t ERROR: tWR violation during Precharge to Bank %d", $time, i);
                                    if (trtp_chk[i] > 0) if ((trtp_chk[i] + (add_latency_clocks + burst_clocks - 2)*tck + trtp) > $time) 
                                        $display ("%m: at time %t ERROR: tRTP violation during Precharge to Bank %d", $time, i);
                                    if (trtp_chk[i] > 0) if ((trtp_chk[i] + (add_latency_clocks + 2)*tck) > $time) 
                                        $display ("%m: at time %t ERROR: Read to Precharge violation during Precharge to Bank %d", $time, i);
                                    if (txp_chk + txp*tck > $time)
                                        $display ("%m: at time %t ERROR: tXP violation during Precharge", $time);
                                    if (($time > txsnr) && (txs_chk + txsnr > $time))
                                        $display ("%m: at time %t ERROR: tXSNR violation during Precharge", $time);
                                    activated_banks[i]  = 1'b0;
                                    trp_chk[i] = $time;
                                    if (addr_in[10] && (BA_BITS == 8)) begin
                                        trpa_chk = $time;
                                    end
                                end
                            end
                        end
                    end
         
                    `ACT : begin             // Activate
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during Activate", $time);
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                            $display ("%m: at time %t ERROR: tRFC violation during Activate", $time);
                        if (trp_chk[ba_in] > 0) if (trp_chk[ba_in]  + trp > $time) 
                            $display ("%m: at time %t ERROR: tRP violation during Activate to Bank %d", $time, ba_in);
                        if (trpa_chk > 0) if (trpa_chk + trpa > $time)
                            $display ("%m: at time %t ERROR: tRPA violation during Activate to Bank %d", $time, ba_in);
                        if (trc_chk[ba_in] > 0) if (trc_chk[ba_in]  + trc > $time) 
                            $display ("%m: at time %t ERROR: tRC violation during Activate to Bank %d", $time, ba_in);
                        if (trrd_chk > 0) if ((previous_bank != ba_in) && (trrd_chk + trrd > $time))
                            $display ("%m: at time %t ERROR: tRRD violation during Activate bank = %d", $time, ba_in);
                        if (txp_chk + txp*tck > $time)
                            $display ("%m: at time %t ERROR: tXP violation during Activate", $time);
                        if (($time > txsnr) && (txs_chk + txsnr > $time))
                            $display ("%m: at time %t ERROR: tXSNR violation during Activate", $time);

                        if (!power_up_done) begin
                            $display ("%m: at time %t ERROR: Power Up and Initialization Sequence not complete", $time);
                            if (!no_halt) $stop (0);
                        end else if (precharged_banks[ba_in]) begin
                            activated_banks[ba_in]  = 1'b1;
                            precharged_banks[ba_in] = 1'b0;
                            bank_row_addr[ba_in] = addr_in; 
                            if (debug) $display ("%m: at time %t ACT  : Bank = %d Row = %d",$time, ba_in, addr_in);
                        end else begin
                            $display ("%m: at time %t ERROR: Activate to Bank %d Failed, Bank %d is not Precharged.", $time, ba_in, ba_in);
                            if (!no_halt) $stop (0);
                        end
                        tras_chk[ba_in] = $time;
                        trcd_chk[ba_in] = $time;
                        trc_chk[ba_in]  = $time;
                        trrd_chk = $time;
                        previous_bank = ba_in;
                        // Check to make sure that the 8 bank devices don't have more that 4 sequential activates within a (4*tRRD + 2*tCK) window of time
                        if ((1<<BA_BITS) == 8) begin
                            num_activated_banks = 0;
                            for (i=0; i<(1<<BA_BITS); i=i+1) begin
                                if (tras_chk[i] + tfaw > $time) begin
                                    num_activated_banks = num_activated_banks + 1;
                                end 
                            end
                            if (num_activated_banks > 4) $display ("%m: at time %t ERROR: tFAW violation during Activate to Bank %d", $time, ba_in[BA_BITS -1 : 0]);
                        end
                    end

                    `WRITE : begin // Write
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during Write", $time);
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                            $display ("%m: at time %t ERROR: tRFC violation during Write", $time);
                        if (trp_chk[ba_in] > 0) if (trp_chk[ba_in]  + trp > $time) 
                            $display ("%m: at time %t ERROR: tRP violation during Write", $time);
                        if (trpa_chk > 0) if (trpa_chk + trpa > $time)
                            $display ("%m: at time %t ERROR: tRPA violation during Write", $time);
                        if (trcd_chk[ba_in] > 0) if (trcd_chk[ba_in] - add_latency_clocks*tck + trcd > $time) 
                            $display ("%m: at time %t ERROR: tRCD violation during Write to Bank %d", $time, ba_in);
                        if (tccd_chk > 0) if (tccd_chk + (tccd*tck) > $time) 
                            $display ("%m: at time %t ERROR: tCCD violation during Write to Bank %d", $time, ba_in);  
                        if (trtw_chk > 0) if (trtw_chk + (read_latency + burst_clocks + 1 - write_latency)*tck > $time)
                            $display ("%m: at time %t ERROR: tRTW violation during Write", $time);
                        if (txp_chk + txp*tck > $time)
                            $display ("%m: at time %t ERROR: tXP violation during Write", $time);
                        if (($time > txsnr) && (txs_chk + txsnr > $time))
                            $display ("%m: at time %t ERROR: tXSNR violation during Write", $time);

                        if (!power_up_done) begin
                            $display ("%m: at time %t ERROR: Power Up and Initialization Sequence not complete", $time);
                            if (!no_halt) $stop (0);
                        end else if (auto_precharge[ba_in]) begin
                            $display ("%m: at time %t ERROR: Cannot Write - Auto Precharge is scheduled to Bank %d", $time, ba_in);
                            if (!no_halt) $stop (0);
                        end else if (!activated_banks[ba_in]) begin
                            $display ("%m: at time %t ERROR: Cannot Write - Bank %d is not Activated", $time, ba_in);
                            if (!no_halt) $stop (0);
                        end else if ((command[write_latency*2-2] == `WRITE) || ((burst_clocks == 4) && (command[write_latency*2-6] == `WRITE))) begin
                            $display ("%m: at time %t ERROR: You cannot interrupt a Write Burst except at 2*tCK from the previous Write command", $time);
                            if (!no_halt) $stop (0);
                        end else if ((burst_clocks == 4) && (command[write_latency*2-4] == `WRITE) && |auto_precharge) begin
                            $display ("%m: at time %t ERROR: A Write with Auto Precharge cannot be interrupted.", $time);
                            if (!no_halt) $stop (0);
                        end else begin
                            // Place the write command in the pipeline
                            if (addr_in[10]) begin
                                // If auto precharge, get the auto precharge ready
                                auto_precharge[ba_in] = 1'b1;
                                write_precharge [ba_in] = 1'b1;
                                twriteapre_chk[ba_in] = $time;
                            end
                            command[write_latency*2] = `WRITE;
                            col_addr[write_latency*2] = {addr_in[15:13], addr_in[11], addr_in[9:0]};
                            bank_addr[write_latency*2] = ba_in;
                            if (debug) $display ("%m: at time %t WRITE: Bank = %d Column = %d",$time, ba_in, col_addr[write_latency*2]);
                        end
                        twtr_chk = $time;
                        twr_chk[ba_in] = $time;
                        tccd_chk = $time;
                    end

                    `READ : begin // Read
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time)
                            $display ("%m: at time %t ERROR: tMRD violation during Read", $time);
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) 
                            $display ("%m: at time %t ERROR: tRFC violation during Read", $time);
                        if (trp_chk[ba_in] > 0) if (trp_chk[ba_in]  + trp > $time) 
                            $display ("%m: at time %t ERROR: tRP violation during Read", $time);
                        if (trpa_chk > 0) if (trpa_chk + trpa > $time) 
                            $display ("%m: at time %t ERROR: tRPA violation during Read", $time);
                        if (trcd_chk[ba_in] > 0) if (trcd_chk[ba_in] - add_latency_clocks*tck + trcd > $time) 
                            $display ("%m: at time %t ERROR: tRCD violation during Read to Bank %d", $time, ba_in);
                        if (twtr_chk > 0) if ((twtr_chk + (write_latency - add_latency_clocks + burst_clocks)*tck + twtr) > $time)
                            $display ("%m: at time %t ERROR: tWTR violation during Read", $time);
                        if (twtr_chk > 0) if ((twtr_chk + (write_latency - add_latency_clocks + burst_clocks + 2)*tck) > $time)
                            $display ("%m: at time %t ERROR: Write to Read violation during Read", $time);
                        if (tccd_chk > 0) if (tccd_chk + (tccd*tck) > $time) 
                            $display ("%m: at time %t ERROR: tCCD violation during Read to Bank %d", $time, ba_in);  
                        if (txards_chk + txards*tck - add_latency_clocks*tck > $time)
                            $display ("%m: at time %t ERROR: tXARDS violation during Read", $time);
                        else if (txp_chk + txard*tck > $time)
                            $display ("%m: at time %t ERROR: tXARD violation during Read", $time);
                        if (($time > txsrd) && (txs_chk + txsrd*tck > $time))
                            $display ("%m: at time %t ERROR: tXSRD violation during Read", $time);

                        if (!power_up_done) begin
                            $display ("%m: at time %t ERROR: Power Up and Initialization Sequence not complete", $time);
                            if (!no_halt) $stop (0);
                        end else if (!dll_locked) begin
                            $display ("%m: at time %t ERROR: DLL is not ready for READ.", $time);
                            if (!no_halt) $stop (0);
                        end else if (auto_precharge[ba_in]) begin
                            $display ("%m: at time %t ERROR: Cannot Read - Auto Precharge is scheduled to Bank %d", $time, ba_in);
                            if (!no_halt) $stop (0);
                        end else if (!activated_banks[ba_in]) begin
                            $display ("%m: at time %t ERROR: Cannot Read - Bank %d is not Activated", $time, ba_in);
                            if (!no_halt) $stop (0);
                        end else if ((command[read_latency*2-2] == `READ) || ((burst_clocks == 4) && (command[read_latency*2-6] == `READ))) begin
                            $display ("%m: at time %t ERROR: You cannot interrupt a Read Burst except at 2*tCK from the previous Read command", $time);
                            if (!no_halt) $stop (0);
                        end else if ((burst_clocks == 4) && (command[read_latency*2-4] == `READ) && |auto_precharge) begin
                            $display ("%m: at time %t ERROR: A Read with Auto Precharge cannot be interrupted.", $time);
                            if (!no_halt) $stop (0);
                        end else begin
                            // Place the read command in the pipeline
                            if (addr_in[10]) begin
                                // If auto precharge, get the auto precharge ready
                                auto_precharge [ba_in] = 1'b1;
                                read_precharge[ba_in] = 1'b1;
                                treadapre_chk[ba_in] = $time;
                            end
                            command[read_latency*2] = `READ;
                            col_addr[read_latency*2] = {addr_in[15:13], addr_in[11], addr_in[9:0]};
                            bank_addr[read_latency*2] = ba_in;
                            if (debug) $display ("%m: at time %t READ : Bank = %d Column = %d",$time, ba_in, col_addr[read_latency*2]);
                        end
                        tccd_chk = $time;
                        trtp_chk[ba_in] = $time;
                        trtw_chk = $time;
                    end

                    `NOP : begin
                        // Exit Power Down/Self Refresh
                        if (!cke_in_one_clk_back) begin
                            if (power_down_enter) begin
                                if (debug) $display ("%m: at time %t PWR  : Exit Power Down", $time);
                                power_down_enter = 1'b0;
                                txp_chk = $time;
                                if (|activated_banks && low_power) // active power down with slow exit
                                    txards_chk = $time;
                            end else if (self_refresh_enter) begin
                                if (cke_event + tisxr > $time)
                                    $display ("%m: at time %t ERROR: tISXR violation on CKE during Self Refresh Exit", $time);
                                if (debug) $display ("%m: at time %t SREF : Exit Self Refresh", $time);
                                trfc_chk = $time;   // avoid trfc_max violation by updating the trfc time
                                dll_reset = 1;      // re-lock the DLL
                                dll_reset_clocks = 0; 
                                txs_chk = $time;
                                self_refresh_enter = 1'b0; 
                            end 
                        end
                    end
                    default : begin
                        // Check to make sure that we have a Deselect or NOP command on the bus when CKE is brought high
                        if (!cke_in_one_clk_back) begin
                            $display ("%m: at time %t ERROR:  You must have a Deselect or NOP command applied when the Clock Enable is brought high.", $time);
                            if (!no_halt) $stop (0);
                        end
                    end
                endcase
            end else if (cke_in_one_clk_back) begin
                if (!power_up_done) begin
                    $display ("%m: at time %t ERROR: CKE must remain high until the initialization sequence is complete.", $time);
                    if (!no_halt) $stop (0);
                end

                // Enter Power Down/Self Refresh
                case (cmd)
                    `NOP : begin
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time) begin
                            $display ("%m: at time %t ERROR: tMRD violation during Power Down", $time);
                            power_up_done = 0;
                        end
                        // refresh to power down = 1 tCK
                        // precharge to power down = 1 tCK
                        // activate to power down = 1 tCK
                        if (twtr_chk > 0) if ((twtr_chk + (write_latency + burst_clocks)*tck + twtr) > $time) begin
                            $display ("%m: at time %t ERROR: Trying to enter Power Down too close to the previous Write command", $time);
                            power_up_done = 0;
                        end
                        if (trtw_chk > 0) if ((trtw_chk + (read_latency + burst_clocks + 1)*tck) > $time) begin
                            $display ("%m: at time %t ERROR: Trying to enter Power Down too close to the previous Read command", $time);
                            power_up_done = 0;
                        end
                        if (|auto_precharge) begin
                            $display ("%m: at time %t ERROR: There is an Auto Precharge scheduled so you can not enter Power Down", $time);
                            power_up_done = 0;
                        end
                        if (tanpd_chk > 0) if (tanpd_chk + tanpd*tck > $time) begin
                            $display ("%m: at time %t ERROR: tANPD violation during Power Down", $time);
                            power_up_done = 0;
                        end
                        if (|activated_banks) begin // All banks precharged?
                            if (debug) $display ("%m: at time %t PWR  : Entering Active Power Down", $time);
                        end else begin
                            if (debug) $display ("%m: at time %t PWR  : Entering Precharge Power Down", $time);
                        end
                        power_down_enter = 1'b1;
                    end
                    `REF: begin
                        if (tmrd_chk > 0) if (tmrd_chk + tmrd*tck > $time) begin
                            $display ("%m: at time %t ERROR: tMRD violation during Self Refresh", $time);
                            power_up_done = 0;
                        end
                        if (trfc_chk > 0) if (trfc_chk + trfc_min > $time) begin
                            $display ("%m: at time %t ERROR: tRFC violation during Self Refresh", $time);
                            power_up_done = 0;
                        end
                        if (~&precharged_banks) begin// All banks precharged?
                            $display ("%m: at time %t ERROR: All banks must be Precharged before a Self Refresh", $time);
                            power_up_done = 0;
                        end 
                        if (odt_data & odt_enabled) begin
                            $display ("%m: at time %t ERROR: ODT must be off prior to entering Self Refresh", $time);
                            power_up_done = 0;
                        end
                        if (debug) $display ("%m: at time %t SREF : Entering Self Refresh", $time);
                        dll_locked = 0;
                        self_refresh_enter = 1'b1;
                    end
                    default :
                        power_up_done = 0;
                endcase
                if ((!power_down_enter && !self_refresh_enter) || !power_up_done) begin
                    if (debug) $display ("%m: at time %t RST  : Reset has occurred.", $time);
                    reset_task;
                end
            end
            if (cke_in ^ cke_in_one_clk_back) begin
                if ($time > tcke) if (tcke_chk + tcke > $time) 
                    $display ("%m: at time %t ERROR: tCKE violation on CKE by %t", $time, tcke_chk + tcke - $time);
                tcke_chk = $time;
            end
            cke_in_one_clk_back <= cke_in;
        end
    endtask

    task data_task;
        begin
            if (clk_in) begin
                if (data_in_valid) begin
                    for (i=0; i<DQS_BITS; i=i+1) begin
                        if (prev_dqs_fall[i] + tdss*tck > $time) 
                            $display ("%m: at time %t ERROR: tDSS violation on DQS bit %d", $time, i); 
                        if (check_write_dqs_high[i])
                            $display ("%m: at time %t ERROR: There should have been a DQS bit %d falling edge during the preceding clock period.", $time, i);
                    end
                end
                check_write_dqs_high <= 4'h0;

                if (burst_counter == burst_clocks*2-1) begin
                    data_in_valid = 1'b0;
                end
                // end the read data phase
                if (burst_counter == burst_clocks*2) begin
                    data_out_enable = 1'b0;
                    data_dqs_out_enable = 1'b0;
                end
                // start the write preamble
                if (command[1] == `WRITE) begin
                    data_in_valid = 1'b1;
                end
                // start the read preamble
                if (command[3] == `READ) begin
                    data_dqs_out_enable = 1'b1;
                end
                // start the read data phase
                if (command[1] == `READ) begin
                    bank          = bank_addr[1]               ;
                    row           = bank_row_addr[bank_addr[1]];
                    col           = col_addr[1]                ;
                    col_brst      = col                        ;
                    burst_counter = 0                          ;
                    data_out_enable = 1'b1                     ;
                    data_dqs_out_enable = 1'b1                 ;
                    read_mem({bank, row, col[COL_BITS-1:3]}, dq_burst);
                end
            end else begin
                if (data_in_valid) begin
                    for (i=0; i<DQS_BITS; i=i+1) begin
                        if (check_write_dqs_low[i]) begin
                            $display ("%m: at time %t ERROR: There should have been a DQS bit %d rising edge during the preceding clock period", $time, i);
                        end
                    end
                end
                check_write_preamble <= 4'h0;
                check_write_postamble <= 4'h0;
                check_write_dqs_low <= 4'h0;

                // end the wirte data phase
                if (burst_counter == burst_clocks*2) begin
                    data_in_enable = 1'b0;
                end
                // start the write preamble
                if (command[2] == `WRITE) begin
                    data_in_valid = 1'b1;
                end
                // start the write data phase
                if (command[0] == `WRITE) begin
                    bank          = bank_addr[0]               ;
                    row           = bank_row_addr[bank_addr[0]];
                    col           = col_addr[0]                ;
                    burst_counter = 0                          ;
                    col_brst      = col                        ;
                    data_in_enable = 1'b1                      ;
                    read_mem({bank, row, col[COL_BITS-1:3]}, dq_burst);
                end
            end
            // check tDQSS
            if (clk_in) begin
                tdqss_chk = $time;
            end else begin
                if (data_in_enable) begin
                    for (i=0; i<DQS_BITS; i=i+1) begin
                        if ((prev_dqs_rise[i] < (tdqss_chk - tdqss*tck)) || (prev_dqs_rise[i] > (tdqss_chk + tdqss*tck)))
                            $display ("%m: at time %t ERROR: tDQSS violation on DQS bit %d during Write", $time, i);
                    end
                end
            end

            // Read DQ Generator
            if (data_out_enable) begin
                dqs_out = ~dqs_out;
                dqs_n_out = ~dqs_out;
                if ({bank, row, col} > (1<<(BA_BITS+ROW_BITS+COL_BITS))-1) begin
                    $display ("%m: at time %t ERROR: bank = %d col = %d row = %d does not exist.  Maximum bank = %d col = %d row = %d ", $time, bank, row, col, (1<<BA_BITS)-1, (1<<ROW_BITS)-1, (1<<COL_BITS)-1);
                end else begin
                    case (col[2:0])
                        0: dq_out = dq_burst[DQ_BITS*1-1:DQ_BITS*0];
                        1: dq_out = dq_burst[DQ_BITS*2-1:DQ_BITS*1];
                        2: dq_out = dq_burst[DQ_BITS*3-1:DQ_BITS*2];
                        3: dq_out = dq_burst[DQ_BITS*4-1:DQ_BITS*3];
                        4: dq_out = dq_burst[DQ_BITS*5-1:DQ_BITS*4];
                        5: dq_out = dq_burst[DQ_BITS*6-1:DQ_BITS*5];
                        6: dq_out = dq_burst[DQ_BITS*7-1:DQ_BITS*6];
                        7: dq_out = dq_burst[DQ_BITS*8-1:DQ_BITS*7];
                    endcase
                    if (found) begin
                        if (debug) $display ("%m: at time %t READ @ DQS= bank = %d col = %d row = %d data = %h mem array index = %d",$time, bank, col, row, dq_out, mem_index);
                    end else begin
                        if (debug) $display ("%m: at time %t READ @ DQS= bank = %d col = %d row = %d data = %h",$time, bank, col, row, dq_out);
                    end
                end
            end else if (data_dqs_out_enable) begin
                dqs_out = {DQS_BITS{1'b0}};
                dqs_n_out = {DQS_BITS{1'b1}};
                dq_out = {DQ_BITS  {1'bz}};
            end else begin
                dq_out = {DQ_BITS  {1'bz}};
                dqs_out = {DQS_BITS{1'bz}};
                dqs_n_out = {DQS_BITS{1'bz}};
            end

            // Capture the write data from negative dqs edge on the rising clk edge
            if (clk_in) begin
                if (data_in_enable) begin
                    if ({bank, row, col} > (1<<(BA_BITS+ROW_BITS+COL_BITS))-1) begin
                        $display ("%m: at time %t ERROR: bank = %d col = %d row = %d does not exist.  Maximum bank = %d col = %d row = %d ", $time, bank, row, col, (1<<BA_BITS)-1, (1<<ROW_BITS)-1, (1<<COL_BITS)-1);
                    end else begin
                        case (col[2:0])
                            0: dq_temp = dq_burst[DQ_BITS*1-1:DQ_BITS*0];
                            1: dq_temp = dq_burst[DQ_BITS*2-1:DQ_BITS*1];
                            2: dq_temp = dq_burst[DQ_BITS*3-1:DQ_BITS*2];
                            3: dq_temp = dq_burst[DQ_BITS*4-1:DQ_BITS*3];
                            4: dq_temp = dq_burst[DQ_BITS*5-1:DQ_BITS*4];
                            5: dq_temp = dq_burst[DQ_BITS*6-1:DQ_BITS*5];
                            6: dq_temp = dq_burst[DQ_BITS*7-1:DQ_BITS*6];
                            7: dq_temp = dq_burst[DQ_BITS*8-1:DQ_BITS*7];
                        endcase
                        for (i=0; i<DM_BITS; i=i+1) begin
                            if (!dm_in_neg[i]) begin
                                case (i)
                                    0: dq_temp[ 7: 0] = dq_in_neg[0];
                                    1: dq_temp[15: 8] = dq_in_neg[1];
                                    2: dq_temp[23:16] = dq_in_neg[2];
                                    3: dq_temp[31:24] = dq_in_neg[3];
                                endcase
                            end
                        end
                        case (col[2:0])
                            0: dq_burst[DQ_BITS*1-1:DQ_BITS*0] = dq_temp;
                            1: dq_burst[DQ_BITS*2-1:DQ_BITS*1] = dq_temp;
                            2: dq_burst[DQ_BITS*3-1:DQ_BITS*2] = dq_temp;
                            3: dq_burst[DQ_BITS*4-1:DQ_BITS*3] = dq_temp;
                            4: dq_burst[DQ_BITS*5-1:DQ_BITS*4] = dq_temp;
                            5: dq_burst[DQ_BITS*6-1:DQ_BITS*5] = dq_temp;
                            6: dq_burst[DQ_BITS*7-1:DQ_BITS*6] = dq_temp;
                            7: dq_burst[DQ_BITS*8-1:DQ_BITS*7] = dq_temp;
                        endcase
                        if (burst_counter%4 == 3) begin
                            write_mem({bank, row, col[COL_BITS-1:3]}, dq_burst);
                        end
                        if (debug) $display ("%m: at time %t WRITE @ DQS= bank = %d col = %d row = %d data = %h mem array index = %d",$time, bank, col, row, dq_temp[DQ_BITS-1: 0], mem_index);
                    end
                end
            // Capture the write data from positive dqs edge on the falling clk edge
            end else begin
                if (data_in_enable) begin
                    if ({bank, row, col} > (1<<(BA_BITS+ROW_BITS+COL_BITS))-1) begin
                        $display ("%m: at time %t ERROR: bank = %d col = %d row = %d does not exist.  Maximum bank = %d col = %d row = %d ", $time, bank, row, col, (1<<BA_BITS)-1, (1<<ROW_BITS)-1, (1<<COL_BITS)-1);
                    end else begin
                        case (col[2:0])
                            0: dq_temp = dq_burst[DQ_BITS*1-1:DQ_BITS*0];
                            1: dq_temp = dq_burst[DQ_BITS*2-1:DQ_BITS*1];
                            2: dq_temp = dq_burst[DQ_BITS*3-1:DQ_BITS*2];
                            3: dq_temp = dq_burst[DQ_BITS*4-1:DQ_BITS*3];
                            4: dq_temp = dq_burst[DQ_BITS*5-1:DQ_BITS*4];
                            5: dq_temp = dq_burst[DQ_BITS*6-1:DQ_BITS*5];
                            6: dq_temp = dq_burst[DQ_BITS*7-1:DQ_BITS*6];
                            7: dq_temp = dq_burst[DQ_BITS*8-1:DQ_BITS*7];
                        endcase
                        for (i=0; i<DM_BITS; i=i+1) begin
                            if (!dm_in_pos[i]) begin
                                case (i)
                                    0: dq_temp[ 7: 0] = dq_in_pos[0];
                                    1: dq_temp[15: 8] = dq_in_pos[1];
                                    2: dq_temp[23:16] = dq_in_pos[2];
                                    3: dq_temp[31:24] = dq_in_pos[3];
                                endcase
                            end
                        end
                        case (col[2:0])
                            0: dq_burst[DQ_BITS*1-1:DQ_BITS*0] = dq_temp;
                            1: dq_burst[DQ_BITS*2-1:DQ_BITS*1] = dq_temp;
                            2: dq_burst[DQ_BITS*3-1:DQ_BITS*2] = dq_temp;
                            3: dq_burst[DQ_BITS*4-1:DQ_BITS*3] = dq_temp;
                            4: dq_burst[DQ_BITS*5-1:DQ_BITS*4] = dq_temp;
                            5: dq_burst[DQ_BITS*6-1:DQ_BITS*5] = dq_temp;
                            6: dq_burst[DQ_BITS*7-1:DQ_BITS*6] = dq_temp;
                            7: dq_burst[DQ_BITS*8-1:DQ_BITS*7] = dq_temp;
                        endcase
                        if (debug) $display ("%m: at time %t WRITE @ DQS= bank = %d col = %d row = %d data = %h mem array index = %d",$time, bank, col, row, dq_temp[DQ_BITS-1: 0], mem_index);
                    end
                end
            end

            if (command[2] == `WRITE) begin
                if (!data_in_enable) begin
                    check_write_preamble <= {DQS_BITS{1'b1}};
                end
            end else if (data_in_valid && (burst_counter == burst_clocks*2-2)) begin
                check_write_postamble <= {DQS_BITS{1'b1}};
            end

            if (data_in_valid) begin
                if (clk_in) begin
                    check_write_dqs_high <= {DQS_BITS{1'b1}};
                end else begin
                    check_write_dqs_low <= {DQS_BITS{1'b1}};
                end
            end

            // Advance Burst Counter
            if (burst_counter < burst_clocks*2) begin
                burst_counter = burst_counter + 1;
                // Interleaved Burst
                col[2:0] = burst_counter[2:0] ^ col_brst[2:0];
                // Sequential Burst
                if (!burst_order) begin 
                    col[1:0] = burst_counter + col_brst;
                end
            end

            // shift pipelines
            for (i=0; i<=MAX_CMD_QUEUE; i=i+1) begin
                command[i] = command[i+1];
                col_addr[i] = col_addr[i+1];
                bank_addr[i] = bank_addr[i+1];
            end
            odt_in_pipe = odt_in_pipe >> 1;
            col_addr[MAX_CMD_QUEUE] = {COL_BITS{1'b0}};
            bank_addr[MAX_CMD_QUEUE] = {BA_BITS{1'b0}};
        end
    endtask

    // Processes to check hold and pulse width of control signals
    always @(cke_in) begin
		// DROZ: "+1000" added to get rid of warnings caused by bus delay at the beginning of the simulation
        if ($time > tih + 1000) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on CKE by %t", $time, clk_rise_event + tih - $time);
        end
        if ($time > tipw*tck) begin
            if (cke_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on CKE by %t", $time, cke_event + tipw*tck - $time);
        end
        cke_event <= $time;
    end
    always @(odt_in) begin
        if (odt_enabled && !self_refresh_enter) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on ODT by %t", $time, clk_rise_event + tih - $time);
            if (odt_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on ODT by %t", $time, odt_event + tipw*tck - $time);
        end
        odt_event <= $time;
    end
    always @(cs_n_in) begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on CS_N by %t", $time, clk_rise_event + tih - $time);
            if (cs_n_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on CS_N by %t", $time, cs_n_event + tipw*tck - $time);
        end
        cs_n_event <= $time;
    end
    always @(ras_n_in) begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on RAS_N by %t", $time, clk_rise_event + tih - $time);
            if (ras_n_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on RAS_N by %t", $time, ras_n_event + tipw*tck - $time);
        end
        ras_n_event <= $time;
    end
    always @(cas_n_in) begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on CAS_N by %t", $time, clk_rise_event + tih - $time);
            if (cas_n_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on CAS_N by %t", $time, cas_n_event + tipw*tck - $time);
        end
        cas_n_event <= $time;
    end
    always @(we_n_in) begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on WE_N by %t", $time, clk_rise_event + tih - $time);
            if (we_n_event + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on WE_N by %t", $time, we_n_event + tipw*tck - $time);
        end
        we_n_event <= $time;
    end

    task ba_timing_check;
    input i;
    integer i;
    begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on BA bit %d by %t", $time, i, clk_rise_event + tih - $time);
            if (ba_event[i] + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on BA bit %d by %t", $time, i,  ba_event[i] + tipw*tck - $time);
        end
        ba_event[i] <= $time;
    end
    endtask

    always @(ba_in[0]) ba_timing_check(0);
    always @(ba_in[1]) ba_timing_check(1);
    always @(ba_in[2]) ba_timing_check(2);

    task addr_timing_check;
    input i;
    integer i;
    begin
        if (cke_in_one_clk_back) begin
            if (clk_rise_event + tih > $time) 
                $display ("%m: at time %t ERROR: tIH violation on ADDR bit %d by %t", $time, i, clk_rise_event + tih - $time);
            if (addr_event[i] + tipw*tck > $time) 
                $display ("%m: at time %t ERROR: tIPW violation on ADDR bit %d by %t", $time, i, addr_event[i] + tipw*tck - $time);
        end
        addr_event[i] <= $time;
    end
    endtask

    always @(addr_in[ 0]) addr_timing_check( 0);
    always @(addr_in[ 1]) addr_timing_check( 1);
    always @(addr_in[ 2]) addr_timing_check( 2);
    always @(addr_in[ 3]) addr_timing_check( 3);
    always @(addr_in[ 4]) addr_timing_check( 4);
    always @(addr_in[ 5]) addr_timing_check( 5);
    always @(addr_in[ 6]) addr_timing_check( 6);
    always @(addr_in[ 7]) addr_timing_check( 7);
    always @(addr_in[ 8]) addr_timing_check( 8);
    always @(addr_in[ 9]) addr_timing_check( 9);
    always @(addr_in[10]) addr_timing_check(10);
    always @(addr_in[11]) addr_timing_check(11);
    always @(addr_in[12]) addr_timing_check(12);
    always @(addr_in[13]) addr_timing_check(13);
    always @(addr_in[14]) addr_timing_check(14);
    always @(addr_in[15]) addr_timing_check(15);

    // Processes to check setup and hold of data signals
    task dm_timing_check;
    input i;
    integer i;
    begin
        if (data_in_valid) begin
            if (dqs_event[i] + tdh > $time) 
                $display ("%m: at time %t ERROR: tDH violation on DM bit %d by %t", $time, i, dqs_event[i] + tdh - $time);
            if (check_dm_tdipw[i]) begin
                if (dm_event[i] + tdipw*tck > $time) 
                    $display ("%m: at time %t ERROR: tDIPW violation on DM bit %d by %t", $time, i, dm_event[i] + tdipw*tck - $time);
            end
        end
        check_dm_tdipw[i] <= 1'b0;
        dm_event[i] <= $time;
    end
    endtask

    always @(dm_in[0]) dm_timing_check(0);
    always @(dm_in[1]) dm_timing_check(1);
    always @(dm_in[2]) dm_timing_check(2);
    always @(dm_in[3]) dm_timing_check(3);

    task dq_timing_check;
    input i;
    integer i;
    begin
        if (data_in_valid) begin
            if (dqs_event[i/8] + tdh > $time) 
                $display ("%m: at time %t ERROR: tDH violation on DQ bit %d by %t", $time, i, dqs_event[i/8] + tdh - $time);
            if (check_dq_tdipw[i]) begin
                if (dq_event[i] + tdipw*tck > $time) 
                    $display ("%m: at time %t ERROR: tDIPW violation on DQ bit %d by %t", $time, i, dq_event[i] + tdipw*tck - $time);
            end
        end
        check_dq_tdipw[i] <= 1'b0;
        dq_event[i] <= $time;
    end 
    endtask

    always @(dq_in[ 0]) dq_timing_check( 0);
    always @(dq_in[ 1]) dq_timing_check( 1);
    always @(dq_in[ 2]) dq_timing_check( 2);
    always @(dq_in[ 3]) dq_timing_check( 3);
    always @(dq_in[ 4]) dq_timing_check( 4);
    always @(dq_in[ 5]) dq_timing_check( 5);
    always @(dq_in[ 6]) dq_timing_check( 6);
    always @(dq_in[ 7]) dq_timing_check( 7);
    always @(dq_in[ 8]) dq_timing_check( 8);
    always @(dq_in[ 9]) dq_timing_check( 9);
    always @(dq_in[10]) dq_timing_check(10);
    always @(dq_in[11]) dq_timing_check(11);
    always @(dq_in[12]) dq_timing_check(12);
    always @(dq_in[13]) dq_timing_check(13);
    always @(dq_in[14]) dq_timing_check(14);
    always @(dq_in[15]) dq_timing_check(15);
    always @(dq_in[16]) dq_timing_check(16);
    always @(dq_in[17]) dq_timing_check(17);
    always @(dq_in[18]) dq_timing_check(18);
    always @(dq_in[19]) dq_timing_check(19);
    always @(dq_in[20]) dq_timing_check(20);
    always @(dq_in[21]) dq_timing_check(21);
    always @(dq_in[22]) dq_timing_check(22);
    always @(dq_in[23]) dq_timing_check(23);
    always @(dq_in[24]) dq_timing_check(24);
    always @(dq_in[25]) dq_timing_check(25);
    always @(dq_in[26]) dq_timing_check(26);
    always @(dq_in[27]) dq_timing_check(27);
    always @(dq_in[28]) dq_timing_check(28);
    always @(dq_in[29]) dq_timing_check(29);
    always @(dq_in[30]) dq_timing_check(30);
    always @(dq_in[31]) dq_timing_check(31);

    task dqs_timing_check;
    input i;
    integer i;
    integer j;
    begin
        if (dqs_in[i]) begin
            if (check_write_preamble[i]) begin
                if (prev_dqs_fall[i] + twpre*tck > $time) 
                    $display ("%m: at time %t ERROR: tWPRE violation on DQS bit %d", $time, i);
            end else if (check_write_postamble[i]) begin
                if (prev_dqs_fall[i] + twpst_min*tck > $time) 
                    $display ("%m: at time %t ERROR: tWPST minimum violation on DQS bit %d by %t", $time, i, prev_dqs_fall[i] + twpst_min*tck - $time);
            end else if (data_in_valid) begin
                if (prev_dqs_fall[i] + tdqsl*tck > $time) 
                    $display ("%m: at time %t ERROR: tDQSL violation on DQS bit %d by %t", $time, i, prev_dqs_fall[i] + tdqsl*tck - $time);
            end
            check_write_preamble[i] <= 1'b0;
            check_write_dqs_low[i] <= 1'b0;
            prev_dqs_rise[i] <= $time;
        end else if (!dqs_in[i]) begin
            if (data_in_valid && !check_write_preamble[i]) begin
                if (prev_dqs_rise[i] + tdqsh*tck > $time) 
                    $display ("%m: at time %t ERROR: tDQSH violation on DQS bit %d by %t", $time, i, prev_dqs_rise[i] + tdqsh*tck - $time);
                if (clk_rise_event + tdsh*tck > $time) 
                    $display ("%m: at time %t ERROR: tDSH violation on DQS bit %d", $time, i); 
            end
            check_write_dqs_high[i] <= 1'b0;
            prev_dqs_fall[i] <= $time;
        end
        if (data_in_valid) begin
            if (dm_event[i] + tds > $time) 
                $display ("%m: at time %t ERROR: tDS violation on DM bit %d by %t", $time, i,  dm_event[i] + tds - $time);
            check_dm_tdipw[i] <= 1'b1;
            for (j=0; j<8; j=j+1) begin
                if (dq_event[i*8+j] + tds > $time) 
                    $display ("%m: at time %t ERROR: tDS violation on DQ bit %d by %t", $time, i*8+j, dq_event[i*8+j] + tds - $time);
                check_dq_tdipw[i*8+j] <= 1'b1;
            end
        end
        dqs_event[i] <= $time;
    end
    endtask

    always @(dqs_in[0]) dqs_timing_check(0);
    always @(dqs_in[1]) dqs_timing_check(1);
    always @(dqs_in[2]) dqs_timing_check(2);
    always @(dqs_in[3]) dqs_timing_check(3);

endmodule
