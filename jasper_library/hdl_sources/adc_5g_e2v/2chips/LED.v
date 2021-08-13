`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:31 07/24/2014 
// Design Name: 
// Module Name:    LED 
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
module LED(
	input gclk10m_buf,
	input clk_div_a,
//	input clk_div_b,
	input gclk10m_locked,
//	input gclk_sd_lockeda,
//	input gclk_sd_lockedb,
	output reg LED1,
	output reg LED2,
	output  LED3
    );
	 
reg [31:0] led_cnt1;
always@(posedge gclk10m_buf)
begin
	if(~gclk10m_locked)
		begin
			LED1 <= 0;
			led_cnt1 <= 32'd0;
		end
	else
		begin
			if(led_cnt1 == 32'd5000000)
				begin
					LED1 <= ~LED1;
			      led_cnt1 <= 32'd0;
				end
			else
				begin
					LED1 <= LED1;
			      led_cnt1 <= led_cnt1 + 1;
				end
		end
end

reg [31:0] led_cnt2;
always@(posedge clk_div_a)
begin
	if(~gclk10m_locked)
		begin
			LED2 <= 0;
			led_cnt2 <= 32'd0;
		end
	else
		begin
			if(led_cnt2 == 32'd125000000)
				begin
					LED2 <= ~LED2;
			      led_cnt2 <= 32'd0;
				end
			else
				begin
					LED2 <= LED2;
			      led_cnt2 <= led_cnt2 + 1;
				end
		end
end 

//reg [31:0] led_cnt3;
//always@(posedge clk_div_b)
//begin
//	if(~gclk_sd_lockedb)
//		begin
//			LED3 <= 0;
//			led_cnt3 <= 32'd0;
//		end
//	else
//		begin
//			if(led_cnt3 == 32'd125000000)
//				begin
//					LED3 <= ~LED3;
//			      led_cnt3 <= 32'd0;
//				end
//			else
//				begin
//					LED3 <= LED3;
//			      led_cnt3 <= led_cnt3 + 1;
//				end
//		end
//end 

assign LED3 = LED2;

endmodule
