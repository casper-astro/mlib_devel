module xaui_rx_steer #(
    parameter LANE_STEER = 8'b0000_0000
  ) (
    input  [8*64-1:0] rxdata_in,
    input   [8*8-1:0] rxcharisk_in,
    input   [8*8-1:0] rxcodecomma_in,
    input   [8*4-1:0] rxencommaalign_in,
    input   [8*4-1:0] rxsyncok_in,
    input   [8*8-1:0] rxcodevalid_in,
    input   [8*4-1:0] rxlock_in,
    input   [8*4-1:0] rxelecidle_in,
    input   [8*4-1:0] rxbufferr_in,
    output [8*64-1:0] rxdata_out,
    output  [8*8-1:0] rxcharisk_out,
    output  [8*8-1:0] rxcodecomma_out,
    output  [8*4-1:0] rxencommaalign_out,
    output  [8*4-1:0] rxsyncok_out,
    output  [8*8-1:0] rxcodevalid_out,
    output  [8*4-1:0] rxlock_out,
    output  [8*4-1:0] rxelecidle_out,
    output  [8*4-1:0] rxbufferr_out
  );

  wire [7:0] lane_steer = LANE_STEER;

  genvar J;
generate for (J=0; J < 8; J=J+1) begin : steer_wrap_gen

  assign  rxdata_out[J*64+:64] = !lane_steer[J] ? rxdata_in[J*64+:64]:
                                 {rxdata_in[J*64 +  0+:16],
                                  rxdata_in[J*64 + 16+:16],
                                  rxdata_in[J*64 + 32+:16],
                                  rxdata_in[J*64 + 48+:16]};

  assign  rxcharisk_out[J*8+:8] = !lane_steer[J] ? rxcharisk_in[J*8+:8]:
                                  {rxcharisk_in[J*8 + 0+:2], 
                                   rxcharisk_in[J*8 + 2+:2], 
                                   rxcharisk_in[J*8 + 4+:2], 
                                   rxcharisk_in[J*8 + 6+:2]};

  assign  rxcodecomma_out[J*8+:8] = !lane_steer[J] ? rxcodecomma_in[J*8+:8]:
                                    {rxcodecomma_in[J*8 + 0+:2], 
                                     rxcodecomma_in[J*8 + 2+:2], 
                                     rxcodecomma_in[J*8 + 4+:2], 
                                     rxcodecomma_in[J*8 + 6+:2]};

  assign  rxsyncok_out[J*4+:4] = !lane_steer[J] ? rxsyncok_in[J*4+:4]:
                                 {rxsyncok_in[J*4 + 0], 
                                  rxsyncok_in[J*4 + 1], 
                                  rxsyncok_in[J*4 + 2], 
                                  rxsyncok_in[J*4 + 3]};

  assign  rxcodevalid_out[J*8+:8] = !lane_steer[J] ? rxcodevalid_in[J*8+:8]:
                                    {rxcodevalid_in[J*8 + 0+:2],
                                     rxcodevalid_in[J*8 + 2+:2],
                                     rxcodevalid_in[J*8 + 4+:2],
                                     rxcodevalid_in[J*8 + 6+:2]};

  assign  rxbufferr_out[J*4+:4] = !lane_steer[J] ? rxbufferr_in[J*4+:4]:
                                  {rxbufferr_in[J*4 + 0],
                                   rxbufferr_in[J*4 + 1],
                                   rxbufferr_in[J*4 + 2],
                                   rxbufferr_in[J*4 + 3]};

  assign  rxelecidle_out[J*4+:4] = !lane_steer[J] ? rxelecidle_in[J*4+:4]:
                                   {rxelecidle_in[J*4 + 0],
                                    rxelecidle_in[J*4 + 1],
                                    rxelecidle_in[J*4 + 2],
                                    rxelecidle_in[J*4 + 3]};

  assign  rxlock_out[J*4+:4] = !lane_steer[J] ? rxlock_in[J*4+:4]:
                               {rxlock_in[J*4 + 0],
                                rxlock_in[J*4 + 1],
                                rxlock_in[J*4 + 2],
                                rxlock_in[J*4 + 3]};


  assign rxencommaalign_out[J*4+:4] = !lane_steer[J] ? rxencommaalign_in[J*4+:4]:
                                      {rxencommaalign_in[J*4 + 0],
                                       rxencommaalign_in[J*4 + 1],
                                       rxencommaalign_in[J*4 + 2],
                                       rxencommaalign_in[J*4 + 3]};

end endgenerate // steer_wrap_gen

endmodule
