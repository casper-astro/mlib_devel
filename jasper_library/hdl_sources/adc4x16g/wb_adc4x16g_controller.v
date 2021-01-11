/*

 Modified version of: 
 mlib_devel/jasper_library/hdl_sources/wb_adc5g_controller/wb_adc5g_controller.v--Author: Rurik Primiani and Jack Hickish
 
 Modified by Wei Liu on Jan. 08 2021 to for the 16GSps ADC alignment.
 Modifications include:

 - The controller provides snap_req, snap_we and snap_addr for wb_bram
 
 */
module wb_adc4x16g_controller(
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,

    input         user_clk,
    input         rst,
    output [5:0]  snap_addr,
    output        snap_we
  );

  /************ Mem Map ***************/
  // reg0--adc_snap_ctrl
  //        bit0: snap_req. 
  //        bit31-bit1: reserved.
  
  /************ WB Logic ***************/

  reg wb_ack;

  /*** Registers ****/
  
  reg [31:0] adc_snap_ctrl;

  /***  Signal   ****/ 

  reg [31:0] wb_data_out_reg;

  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;
    if (wb_rst_i) 
      begin
      end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) 
        begin
        if (wb_we_i) begin
          case (wb_adr_i[4:2])
            0:  begin
	       wb_ack <= 1'b1;
               if (wb_sel_i[0]) 
                begin
                  adc_snap_ctrl[7:0] <= wb_dat_i[7:0];
	              end
	            if (wb_sel_i[1])
                begin
                  adc_snap_ctrl[15:8] <= wb_dat_i[15:8];
	              end
              if (wb_sel_i[2])
                begin
                  adc_snap_ctrl[23:16] <= wb_dat_i[23:16];
	              end
              if (wb_sel_i[3])
                begin
                  adc_snap_ctrl[31:24] <= wb_dat_i[31:24];
	              end
            end
          endcase
        end else begin // if (wb_we_i)
	  case (wb_adr_i[4:2])
	    0: begin
	       wb_ack <= 1'b1;
	       wb_data_out_reg <= adc_snap_ctrl;
	    end
	  endcase
	end
      end
    end
  end

  assign wb_dat_o  = wb_ack_o ? wb_data_out_reg: 32'b0;
  assign wb_err_o  = 1'b0;
  assign wb_ack_o  = wb_ack;

/********************** snapshot logic *********************/
// snap_addr logic and snap_we logic are here.

wire snap_req;
assign snap_req = adc_snap_ctrl[0:0];

reg [6:0] s_snap_counter;
reg [1:0] s_snap_req;

always @(posedge user_clk)
  begin
    if(rst)
      begin
        s_snap_req <= 0;
      end
    else
      begin
        s_snap_req <= {s_snap_req[0:0], snap_req};
      end
  end
assign snap_we = ~s_snap_counter[6:6];

always @(posedge user_clk)
  begin
    if(rst)
      begin
        s_snap_counter <= 0;
      end
    else if(s_snap_req == 2'b10)
      begin
        s_snap_counter <= 0;
      end
    else if(s_snap_counter[6:6]==1'b0)
      begin
        s_snap_counter <= s_snap_counter + 1;
      end
    else
      begin
        s_snap_counter <= s_snap_counter;
      end
  end

assign snap_addr = s_snap_counter[5:0];

endmodule
