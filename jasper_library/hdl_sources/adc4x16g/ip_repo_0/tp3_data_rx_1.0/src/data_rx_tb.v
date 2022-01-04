`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
Test bench for the dat_rx module.  Clock in serial data at 320MHz DDR (640 Mb/s)
on 8 serial lanes.  then stop and read out the 8 FIFOs
*/
//////////////////////////////////////////////////////////////////////////////////


module data_rx_tb();


   // Define file handle integer
   integer outfile;
parameter seed = 2;
   initial begin
   // Open file output.dat for writing
   outfile = $fopen("output.dat", "w");

   // Check if file was properly opened and if not, produce error and exit
   if (outfile == 0) begin
    $display("Error: File, output.dat could not be opened.\nExiting Simulation.");
    $finish;
   end

 
   end

					
	
reg data_clk;
reg data_clk_90;
reg rd_clk;
wire [7:0] ser_data;
reg fifo_reset;
reg [2:0]fifo_sel;
reg fifo_rd;
wire [7:0]fifo_dav;
wire [31:0] fifo_out;

data_rx UUT(
    .data_clk(data_clk_90),
    .rd_clk(rd_clk),
    .ser_data(ser_data),
    .write_inhibit(1'b0),
    .fifo_reset(fifo_reset),
    .fifo_sel(fifo_sel),
    .fifo_rd(fifo_rd),
    .fifo_dav(fifo_dav),
    .fifo_out(fifo_out)
    );
    
//40MHz data clock
parameter data_period = 25.0;
always begin
   data_clk = 1'b0;
   #(data_period/4) data_clk_90 = 1'b0;
   #(data_period/4) data_clk = 1'b1;
   #(data_period/4) data_clk_90 = 1'b1;
   #(data_period/4);
end

//100MHz system clock
parameter clk_period = 10.0;
always begin
   rd_clk = 1'b0;
   #(clk_period/2) rd_clk = 1'b1;
   #(clk_period/2);
end

//A few of the 10B values that encode to 8B values.
//The leftmost of the 10B value is actually the LS bit- the one that is to be transmitted first
//(This is the way the codes are listed in a table I found)
parameter code_D0_0_p = 10'h18b; //0x00
parameter code_D0_0_m = 10'h274; //0x00
parameter code_D0_1_p = 10'h189; //0x20
parameter code_D0_1_m = 10'h279; //0x20
parameter code_D3_0_p = 10'h314; //0x03
parameter code_D3_0_m = 10'h31b; //0x03
parameter code_D3_1_p = 10'h319; //0x23
parameter code_D3_1_m = 10'h319; //0x23
parameter code_K28_5_p = 10'h305; //comma
parameter code_K28_5_m = 10'h0fa; //comma

//A ROM to store some test words
   parameter ROM_WIDTH = 10;
   reg [ROM_WIDTH-1:0] ROM_data;
   reg [5:0] ROM_address = 0;
   always @(posedge data_clk)
         case (ROM_address)
            //6 bytes
            6'h0: ROM_data <= code_D3_1_p; //0x23
            6'h1: ROM_data <= code_D0_1_m;  //0x20
            6'h2: ROM_data <= code_D3_0_p;  //0x03
            6'h3: ROM_data <= code_D0_0_m;  //0x00
            6'h4: ROM_data <= code_D3_0_p; //0x03
            6'h5: ROM_data <= code_D3_0_p; //0x03
            //A comma
            6'h6: ROM_data <= code_K28_5_p; //comma
            //12 bytes
            6'h7: ROM_data <= code_D3_1_p; //0x23
            6'h8: ROM_data <= code_D0_1_p; //0x20
            6'h9: ROM_data <= code_D0_0_m; //0x00
            6'ha: ROM_data <= code_D0_1_p; //0x20
            6'hb: ROM_data <= code_D0_0_m; //0x00
            6'hc: ROM_data <= code_D0_1_m; //0x20
            
            6'hd: ROM_data <= code_D3_1_p; //0x23
            6'he: ROM_data <= code_D0_1_m; //0x20
            6'hf: ROM_data <= code_D0_1_m; //0x20
            6'h10: ROM_data <= code_D0_0_p;  //0x00
            6'h11: ROM_data <= code_D0_1_m;  //0x20
            6'h12: ROM_data <= code_D3_0_p;  //0x03
            //A bunch of commas
            6'h13: ROM_data <= code_K28_5_p; //comma
            6'h14: ROM_data <= code_K28_5_p; //comma
            6'h15: ROM_data <= code_K28_5_m; //comma
            6'h16: ROM_data <= code_K28_5_p; //comma
            6'h17: ROM_data <= code_K28_5_m; //comma
            //36 bytes
            6'h18: ROM_data <= code_D3_1_p; //0x23
            6'h19: ROM_data <= code_D0_0_m; //0x00
            6'h1a: ROM_data <= code_D0_1_p; //0x20
            6'h1b: ROM_data <= code_D0_0_m; //0x00
            6'h1c: ROM_data <= code_D3_0_p;  //0x03
            6'h1d: ROM_data <= code_D0_1_m; //0x20
            
            6'h1e: ROM_data <= code_D3_1_p; //0x23
            6'h1f: ROM_data <= code_D0_1_m; //0x20
            6'h20: ROM_data <= code_D0_0_p;  //0x00
            6'h21: ROM_data <= code_D0_1_m;  //0x20
            6'h22: ROM_data <= code_D3_0_p;  //0x03
            6'h23: ROM_data <= code_D0_0_m;  //0x00
            
            6'h24: ROM_data <= code_D3_1_p; //0x23
            6'h25: ROM_data <= code_D0_1_p; //0x20
            6'h26: ROM_data <= code_D0_1_p; //0x20
            6'h27: ROM_data <= code_D0_0_p;  //0x00
            6'h28: ROM_data <= code_D0_1_p; //0x20
            6'h29: ROM_data <= code_D0_0_m; //0x00
            
            6'h2a: ROM_data <= code_D3_1_m; //0x23
            6'h2b: ROM_data <= code_D0_0_m; //0x00
            6'h2c: ROM_data <= code_D0_1_m;  //0x20
            6'h2d: ROM_data <= code_D0_1_m; //0x20
            6'h2e: ROM_data <= code_D3_0_p;  //0x03
            6'h2f: ROM_data <= code_D0_1_m; //0x20
            
            6'h30: ROM_data <= code_D3_1_p; //0x23
            6'h31: ROM_data <= code_D0_1_m;  //0x20
            6'h32: ROM_data <= code_D3_0_p;  //0x03
            6'h33: ROM_data <= code_D0_0_m;  //0x00
            6'h34: ROM_data <= code_D0_1_m;  //0x20
            6'h35: ROM_data <= code_D0_1_m;  //0x20
            
            6'h36: ROM_data <= code_D3_1_m; //0x23
            6'h37: ROM_data <= code_D0_1_p; //0x20
            6'h38: ROM_data <= code_D0_1_p; //0x20
            6'h39: ROM_data <= code_D0_0_m; //0x00
            6'h3a: ROM_data <= code_D0_1_p; //0x20
            6'h3b: ROM_data <= code_D0_0_m; //0x00
            
            //four commas
            6'h3c: ROM_data <= code_K28_5_p; //comma
            6'h3d: ROM_data <= code_K28_5_m; //comma
            6'h3e: ROM_data <= code_K28_5_p; //comma
            6'h3f: ROM_data <= code_K28_5_m; //comma
         endcase
//A shift reg to output the data
reg [9:0] shift_reg;
reg [3:0] bit_count = 0;
wire SR_load;
reg data_gen_reset;
always @ (data_clk) begin
    if (data_gen_reset) begin
        ROM_address <= 0;
        bit_count <= 0;
    end
    else begin
        if (SR_load) shift_reg <= ROM_data;
        else shift_reg <= {shift_reg[8:0], 1'b0};
        if (bit_count == 4'h9) bit_count <= 0;
        else bit_count <= bit_count + 1; 
        if (bit_count == 4'h8) ROM_address <= ROM_address + 1;
    end
end
assign SR_load = (bit_count == 4'h9);

assign ser_data[7:1] = 7'h0;
assign ser_data[0] = shift_reg[9];

//A mechanism to check DAV of fifo 0 and read out data
wire dav = fifo_dav[0];
reg [31:0] channel0_out;
reg read_inhibit;
reg fifo_rd_d1;
always @ (posedge rd_clk)fifo_rd_d1 <= fifo_rd;

always @ (posedge rd_clk) begin
  if (!read_inhibit)
    if (fifo_dav[0]) begin
        fifo_rd <= 1;
        #30;
        fifo_rd <= 0;
        channel0_out <= fifo_out;
        $fwrite(outfile, "%h\n\r", channel0_out);
        #30;
    end
end

wire fifo_rd_pulse = fifo_rd && !fifo_rd_d1;

//Count the words in sets of 3 to get 96 bits = 2 packets
reg [1:0] word_count = 2;
reg [31:0] triple_count = 0;
always @ (word_count) if (word_count == 2) triple_count <= triple_count + 1;
reg [31:0] error_count = 0;
always @ (posedge rd_clk) begin
    if (fifo_rd_pulse) begin
        if (word_count == 2) word_count <= 0;
        else word_count <= word_count + 1;
    end
end
always @ (word_count) begin
        if ((word_count == 0) &&((fifo_out & 32'hff) != 32'h23)) begin
            error_count <= error_count + 1;
            $display(" Count = %d WordA = %h", triple_count, fifo_out);
        end
        else if ((word_count == 1) &&((fifo_out & 32'hff0000) != 32'h230000)) begin
            error_count <= error_count + 1;
            $display(" Count = %d WordB = %h", triple_count, fifo_out);
        end
end

    
integer ii;
initial begin
$srandom(seed);

    fifo_reset = 1;
    data_gen_reset = 1;
    read_inhibit = 1;
    fifo_sel = 0;
    fifo_rd = 0;
    #1000;
    fifo_reset = 0;
    data_gen_reset = 0;
    //Inhibit read 90% of the time for a long time so we get almost_full
    for (ii = 0; ii<200; ii = ii + 1) 
        begin
            #($urandom_range(10,5000));
            read_inhibit = 0;
            #($urandom_range(10,100));
            read_inhibit = 1;
        end
    read_inhibit = 0;
    //Start and stop data-taking randomly; should always get entire packets written
    for (ii = 0; ii<200; ii = ii + 1) 
        begin
            #($urandom_range(10,5000));
            read_inhibit = 0;
            #($urandom_range(10,1000));
            read_inhibit = 1;
        end
            #($urandom_range(10,1000));
    //Reset fifo a bunch of times and repeat
    for (ii = 0; ii<10; ii = ii + 1) 
    begin
        fifo_reset = 1;
        #($urandom_range(100,10000));
        fifo_reset = 0;
        #($urandom_range(1000,10000));
    end

    for (ii = 0; ii<100; ii = ii + 1) 
        begin
            #($urandom_range(10,5000));
            read_inhibit = 0;
            #($urandom_range(10,1000));
            read_inhibit = 1;
        end

   // Close file to end monitoring
    $fclose(outfile);
    $display("Error Count = %d", error_count);
    $stop;
end
endmodule
