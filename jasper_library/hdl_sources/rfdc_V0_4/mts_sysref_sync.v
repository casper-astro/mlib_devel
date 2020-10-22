`timescale 1ns / 1ps
/*
Created March 6, 2020 by Wesley Stirk

This file is for generating the needed sysref signal for the MTS of the ADCs on the RFSoC
*/

module mts_sysref_sync(
    input wire pl_sysref_p,
    input wire pl_sysref_n,
    input wire pl_clk,
    output wire sysref_adc
    );
    
    localparam NO_SRC_CLK = 0;
    localparam SYNC_FFS = 3;
    
    wire pl_sysref_single; //the single clock signal from the pl_sysref differential clock signal
    
    
    //////// Taking the Differential PL SYSREF to a single clock ///////
    
    //Instantiation of a basic Differntial Input Buffer Primitive
    IBUFDS #(
        .DQS_BIAS("FALSE")
    )
    IBUFDS_inst (
        .O(pl_sysref_single),
        .I(pl_sysref_p),
        .IB(pl_sysref_n)
    );
    
    
    
    
    //////////// Syncing Up the SysRef to the PL Clk ////////
    
    // xpm_cdc_single: Single-bit Synchronizer
    // Xilinx Parameterized Macro, version 2018.1
    xpm_cdc_single #(
    .DEST_SYNC_FF(SYNC_FFS), // DECIMAL; range: 2-10
    .INIT_SYNC_FF(1), // DECIMAL; integer; 0=disable simulation init values, 1=enable simulation init
    // values
    .SIM_ASSERT_CHK(1), // DECIMAL; integer; 0=disable simulation messages, 1=enable simulation messages
    .SRC_INPUT_REG(NO_SRC_CLK) // DECIMAL; integer; 0=do not register input, 1=register input
    )
    xpm_cdc_single_inst (
    .dest_out(sysref_adc), // 1-bit output: src_in synchronized to the destination clock domain. This output is
    // registered.
    .dest_clk(pl_clk), // 1-bit input: Clock signal for the destination clock domain.
    .src_clk(0), // 1-bit input: optional; required when SRC_INPUT_REG = 1
    .src_in(pl_sysref_single) // 1-bit input: Input signal to be synchronized to dest_clk domain.
    );
    // End of xpm_cdc_single_inst instantiation
    
endmodule
