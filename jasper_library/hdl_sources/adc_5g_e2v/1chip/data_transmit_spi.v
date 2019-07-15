`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:40 11/19/2012 
// Design Name: 
// Module Name:    data_transmit_spi 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_transmit_spi( /*AUTOARG*/
			  // Outputs
			  Idle_flag,
			  data_read_out,
			  data_read_rdy,
			  spi_sclk_o,
			  spi_mosi_o,
			  spi_csb_o,
			  // Inputs

			  clk,
			  reset,
			  reg_addr,
			  config_value,
			  start_spi,
			  spi_miso_i
			  );
   //-----------interface to fpga fabric-----------
   input                   clk;
   input                   reset;
   input [7:0] 		      reg_addr;
   input [15:0] 	         config_value;
   input                   start_spi; //high active
   output reg [15:0] 	   data_read_out;
   output reg              data_read_rdy;
   output reg              Idle_flag;
   //-----------spi interface to adc-----------
   input                   spi_miso_i;
   output                  spi_sclk_o;
   output 		            spi_mosi_o;
   output 		            spi_csb_o;
   

   parameter VCC = 1'b1;
   parameter GND = 1'b0;
   parameter Idle  = 2'b00,
             Write = 2'b01,
             Read  = 2'b10,
             Clear = 2'b11;

(*keep="true"*)   reg 			      spi_mosi;
(*keep="true"*)   wire 		         spi_miso;
(*keep="true"*)   reg 			      spi_csb;
(*keep="true"*)   reg 			      data_out_rdy;
(*keep="true"*)   reg [23 : 0] 	   data_to_send;
(*keep="true"*)   reg [15 : 0] 	   data_to_receive;
(*keep="true"*)   reg [1 : 0] 		state;
(*keep="true"*)   reg [4 : 0] 	   cnt_index;
(*keep="true"*)   reg [4 : 0] 		cnt_index_1;

assign spi_sclk_o = clk;
//开始spi传输
always@(posedge clk)
begin
	if(reset)
		  begin
			  spi_mosi <= GND;
			  spi_csb  <= VCC;
			  data_out_rdy <= 0;
			  cnt_index <= 5'd0;
			  cnt_index_1   <= 5'd0;
			  data_to_send <= {24{1'b0}};
			  data_to_receive <= {16{1'b0}};
			  state <= Idle;
			  Idle_flag <= 1'b0;
		  end
	else
			begin
				  case(state)
				  Idle:
					 begin
						 if(start_spi)
							begin
									Idle_flag <= 1'b0;
									data_to_send <= {reg_addr,config_value};
									if(~reg_addr[7]) //0_read
										begin
											state <= Read;
										end
									else        //1_write
										begin
											state <= Write;
										end
							end
						 else
							begin
									 data_to_send <= data_to_send;
									 state <= Idle;
									 Idle_flag <= 1'b1;
							end
					 end
				 Write:
				   begin
							spi_csb  <= GND;
							spi_mosi <= data_to_send[23];   //spi_csb要输出24个clk
							cnt_index <= cnt_index+1;
							data_to_send <= data_to_send << 1;		
							if(cnt_index == 5'd23)            
								state <= Clear;
							else 
								state <= Write;
				   end

				 Read:
				   begin
							 if(cnt_index == 5'd8)            
								 begin
									 if(cnt_index_1 == 5'd17)  //*************16*************
										begin
											spi_csb <= VCC;
											state <= Clear;
											data_out_rdy <=1'b1;
										end
									else
										begin   
											data_to_receive <= { {data_to_receive[14:0]}, spi_miso };    
											cnt_index_1 <= cnt_index_1+1;
										end  
								 end
							 else 
								  begin
									  spi_csb  <= GND; 
									  spi_mosi <= data_to_send[23]; 
									  data_to_send <= data_to_send << 1;		
									  cnt_index <= cnt_index+1;
									  state <= Read;
								  end
				   end
					 
				Clear:
				  begin
								  spi_csb <= VCC;
								  spi_mosi <= GND;
								  data_out_rdy <= 0;
								  cnt_index   <= 5'd0;
								  cnt_index_1 <= 5'd0;
								  data_to_send <= {24{1'b0}};
								  data_to_receive  <= data_to_receive ;
					           state <= Idle;
				 end
				endcase
			end
     end
   //-----------pipeline output and input-----------
   always @(posedge clk)
     begin
        if (reset)
          begin
             data_read_out <= 0;
             data_read_rdy <= 0;
          end
        else
          begin
             if(data_out_rdy == 1)
               begin
                  data_read_out <= data_to_receive;	
                  data_read_rdy <= data_out_rdy;
               end
				 else
					begin
						data_read_out <= data_read_out;
						data_read_rdy <= data_out_rdy;
					end
          end
     end
   assign spi_mosi_o = spi_mosi;
   assign spi_csb_o  = spi_csb;
   assign spi_miso   = spi_miso_i;


endmodule

