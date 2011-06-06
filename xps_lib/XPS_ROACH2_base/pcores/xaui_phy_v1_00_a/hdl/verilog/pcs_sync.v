/* This module checks if commas (commadet = 1) are found
   on all lanes, without too many errors occuring */
module pcs_sync(
    clk,
    reset,
    enable_align,
    signal_detect,
    commadet,
    codevalid,
    syncok,
    rxlock,
    lanesync
  );
  input  clk;
  input  reset;
  output [3:0] enable_align;
  input  [7:0] commadet;
  input  [7:0] codevalid;
  input  [3:0] syncok;
  /*
   * syncok ignored: TODO: fin out what it is used for
   */
  input  [3:0] rxlock;
  input  [3:0] signal_detect;
  output [3:0] lanesync;

  reg  [4*4 - 1:0] sync_state;
  wire [4*4 - 1:0] sync_state_int_0;
  wire [4*4 - 1:0] sync_state_int_1;

  reg  [4*2 - 1:0] good_cgs;
  wire [4*2 - 1:0] good_cgs_int_0;
  wire [4*2 - 1:0] good_cgs_int_1;

  wire [4*1 - 1:0] lanesync_0;
  wire [4*1 - 1:0] lanesync_1;
  assign lanesync = lanesync_1 & lanesync_0; //if both are true

  wire [4*1 - 1:0] enable_align_0;
  wire [4*1 - 1:0] enable_align_1;
  assign enable_align = enable_align_1 | enable_align_0; //if either are true

  /* as with all XAUI stuff 2 state transitions per cycle,
     hence 8 state processes, 1 per lane, 2 per cycle
     This almost certainly isn't necessary but it is mote compliant
  */
  sync_state sync_state_0_0(
    .reset(reset),
    .current_state(sync_state[3:0]),
    .next_state(sync_state_int_0[3:0]),
    .current_good_cgs(good_cgs[1:0]),
    .next_good_cgs(good_cgs_int_0[1:0]),
    .next_enable_align(enable_align_0[0]),
    .next_lanesync(lanesync_0[0]),
    .commadet(commadet[0]),
    .codevalid(codevalid[0]),
    .signal_detect(signal_detect[0]),
    .rxlock(rxlock[0])
  );

  sync_state sync_state_0_1(
    .reset(reset),
    .current_state(sync_state[7:4]),
    .next_state(sync_state_int_0[7:4]),
    .current_good_cgs(good_cgs[3:2]),
    .next_good_cgs(good_cgs_int_0[3:2]),
    .next_enable_align(enable_align_0[1]),
    .next_lanesync(lanesync_0[1]),
    .commadet(commadet[2]),
    .codevalid(codevalid[2]),
    .signal_detect(signal_detect[1]),
    .rxlock(rxlock[1])
  );

  sync_state sync_state_0_2(
    .reset(reset),
    .current_state(sync_state[11:8]),
    .next_state(sync_state_int_0[11:8]),
    .current_good_cgs(good_cgs[5:4]),
    .next_good_cgs(good_cgs_int_0[5:4]),
    .next_enable_align(enable_align_0[2]),
    .next_lanesync(lanesync_0[2]),
    .commadet(commadet[4]),
    .codevalid(codevalid[4]),
    .signal_detect(signal_detect[2]),
    .rxlock(rxlock[2])
  );

  sync_state sync_state_0_3(
    .reset(reset),
    .current_state(sync_state[15:12]),
    .next_state(sync_state_int_0[15:12]),
    .current_good_cgs(good_cgs[7:6]),
    .next_good_cgs(good_cgs_int_0[7:6]),
    .next_enable_align(enable_align_0[3]),
    .next_lanesync(lanesync_0[3]),
    .commadet(commadet[6]),
    .codevalid(codevalid[6]),
    .signal_detect(signal_detect[3]),
    .rxlock(rxlock[3])
  );

  sync_state sync_state_1_0(
    .reset(reset),
    .current_state(sync_state_int_0[3:0]),
    .next_state(sync_state_int_1[3:0]),
    .current_good_cgs(good_cgs_int_0[1:0]),
    .next_good_cgs(good_cgs_int_1[1:0]),
    .next_enable_align(enable_align_1[0]),
    .next_lanesync(lanesync_1[0]),
    .commadet(commadet[1]),
    .codevalid(codevalid[1]),
    .signal_detect(signal_detect[0]),
    .rxlock(rxlock[0])
  );

  sync_state sync_state_1_1(
    .reset(reset),
    .current_state(sync_state_int_0[7:4]),
    .next_state(sync_state_int_1[7:4]),
    .current_good_cgs(good_cgs_int_0[3:2]),
    .next_good_cgs(good_cgs_int_1[3:2]),
    .next_enable_align(enable_align_1[1]),
    .next_lanesync(lanesync_1[1]),
    .commadet(commadet[3]),
    .codevalid(codevalid[3]),
    .signal_detect(signal_detect[1]),
    .rxlock(rxlock[1])
  );

  sync_state sync_state_1_2(
    .reset(reset),
    .current_state(sync_state_int_0[11:8]),
    .next_state(sync_state_int_1[11:8]),
    .current_good_cgs(good_cgs_int_0[5:4]),
    .next_good_cgs(good_cgs_int_1[5:4]),
    .next_enable_align(enable_align_1[2]),
    .next_lanesync(lanesync_1[2]),
    .commadet(commadet[5]),
    .codevalid(codevalid[5]),
    .signal_detect(signal_detect[2]),
    .rxlock(rxlock[2])
  );

  sync_state sync_state_1_3(
    .reset(reset),
    .current_state(sync_state_int_0[15:12]),
    .next_state(sync_state_int_1[15:12]),
    .current_good_cgs(good_cgs_int_0[7:6]),
    .next_good_cgs(good_cgs_int_1[7:6]),
    .next_enable_align(enable_align_1[3]),
    .next_lanesync(lanesync_1[3]),
    .commadet(commadet[7]),
    .codevalid(codevalid[7]),
    .signal_detect(signal_detect[3]),
    .rxlock(rxlock[3])
  );


  always @(posedge clk) begin
    sync_state <= sync_state_int_1;
    good_cgs <= good_cgs_int_1;
  end


endmodule
