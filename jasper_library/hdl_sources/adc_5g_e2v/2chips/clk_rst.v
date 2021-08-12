module clk_rst(

//---rst------
//     sys_rst_n  ,
//     gclk10m_buf,
//     bufg_rst   ,
//------时钟信号输入------
     ADR_P      ,   //625MHz
     ADR_N      ,
     ADR_P1     ,   //625MHz
     ADR_N1     ,
//   BDR_P      ,
//   BDR_N      ,
//	 CDR_P      ,   
//   CDR_N      ,
//   DDR_P      ,
//   DDR_N      ,
//---局部时钟-----------	 
//	 gclk_sd_lockeda,
	 gclk_sd_bufra  ,
	 clk_div_a      			
);
//input               sys_rst_n  ;
//input               gclk10m_buf;
//input               bufg_rst   ;
input               ADR_P      ;
input               ADR_N      ;
input               ADR_P1     ;
input               ADR_N1     ;
//input               BDR_P      ;
//input               BDR_N      ;
//input               CDR_P      ;
//input               CDR_N      ;
//input               DDR_P      ;
//input               DDR_N      ;
output              clk_div_a;   //156.25M
//output   reg        gclk_sd_lockeda;
output              gclk_sd_bufra  ; //625M

//======================reset=============================
//reg bufg_rst_r1;
//reg bufg_rst_r2;
//always@(posedge gclk10m_buf) 
//begin
//	bufg_rst_r1 <= bufg_rst;
//	bufg_rst_r2 <= bufg_rst_r1;
//end

//=====================时钟输入及延时======================
//----channel A clk IOdelay----
wire                a_adc_clk       ;	
   IBUFDS IBUFDS_sys_clka
         (
           .O  (a_adc_clk),
           .I  (ADR_P),
           .IB (ADR_N)
         ); 	
	BUFG gclk_sd_buf
   (
		 .O (gclk_sd_bufra),
		 .I (a_adc_clk)
	 );	
//----channel A clk IOdelay----
     wire                b_adc_clk       ;    
        IBUFDS IBUFDS_sys_clkb
              (
                .O  (b_adc_clk),
                .I  (ADR_P1),
                .IB (ADR_N1)
              );               
 //----------------------------------------         	
	BUFGCE_DIV #(
          .BUFGCE_DIVIDE(2),      // 1-8
          // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
          .IS_CE_INVERTED(1'b0),  // Optional inversion for CE
          .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
          .IS_I_INVERTED(1'b0)    // Optional inversion for I
       )
       a_BUFGCE_DIVIDE (
          .O(clk_div_a),     // 1-bit output: Buffer
          .CE(1'b1),   // 1-bit input: Buffer enable
          .CLR(1'b0), // 1-bit input: Asynchronous clear
          .I(a_adc_clk)      // 1-bit input: Buffer
       );      		    
//===============locked=================
//reg rst_r1;
//reg rst_r2;
//reg rst_r3;
//always@(posedge clk_div_a)
//begin
//    rst_r1 <= bufg_rst;
//    rst_r2 <= rst_r1;
//    rst_r3 <= rst_r2;
//end

//////------lockeda------
//	reg [9:0] cnt_lockeda;
//	wire rst_lockeda;
//	assign rst_lockeda = bufg_rst; 
	
//	always@(posedge clk_div_a or posedge rst_lockeda)
//		if(rst_lockeda)
//			begin
//				gclk_sd_lockeda <= 1'b0;
//				cnt_lockeda     <= 10'd0;
//			end
//		else if(cnt_lockeda[8] == 1'd1)
//			begin				
//				gclk_sd_lockeda <= 1'b1;
//                cnt_lockeda     <= cnt_lockeda;
//			end
//		else
//			begin
//                gclk_sd_lockeda <= 1'b0;
//                cnt_lockeda     <= cnt_lockeda + 1;
//			end


endmodule
