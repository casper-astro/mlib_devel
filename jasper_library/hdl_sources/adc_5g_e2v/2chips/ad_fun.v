`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:26 10/14/2014 
// Design Name: 
// Module Name:    ad_fun 
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
module ad_fun
#(
     parameter adcmode  = 4'b0000,
     parameter outmode  = 1'b0,
     parameter offset_A = 16'h0200,
	 parameter offset_B = 16'h0200,
	 parameter offset_C = 16'h0200,
	 parameter offset_D = 16'h0200,
     parameter gain_A = 16'h0200,
     parameter gain_B = 16'h0200,
     parameter gain_C = 16'h0200,
     parameter gain_D = 16'h0200,
     parameter phase_A = 16'h0200,
     parameter phase_B = 16'h0200,
     parameter phase_C = 16'h0200,
     parameter phase_D = 16'h0200     	 
 )
(
    gclk10m_buf,
    sys_rst_n  ,   //系统复位
	 //---ADC的时钟信号----
//    ADR_P      ,   //625MHz
//    ADR_N      ,
	 //---OR---- 
    AOR_P      ,
	AOR_N      ,
	BOR_P      ,
	BOR_N      ,
	COR_P      ,
    COR_N      ,
	DOR_P      ,
    DOR_N      ,
	A_P   ,
    A_N   ,
    B_P   ,
    B_N   ,
    C_P   ,
    C_N   ,
    D_P   ,
    D_N   ,    
	 //---ADC配置信号---- 
    adc_sclk      ,   
    adc_sen       ,
    adc_rst       ,
    adc_mosi      ,
	adc_miso      ,

    adc_sync      ,
	adc_sync_dir  ,
	 //----------ADC采集数据-----------

	 //-------data output--------
//	 flag,
	 dataA_out,
	 dataB_out,
	 dataC_out,
	 dataD_out, 
	 data_or,
	 //------------
//	 clk_data,
//	 clk_data_locked,
     gclk_sd_bufra,
     clk_div_a,
//     rst_bufg,
     rst_SERDES,
     auto_seek_rsta,
     auto_spi_rstan,
     adc_ready
	 //------------
//	 sync_flag,
//	 sync_flag_all,	 
//	 win_ok,
//	 data_sync_flag,
//	 data_sync_all,
//	 CNTVALUEIN_A ,
//     CNTVALUEIN_B ,
//     CNTVALUEIN_C ,
//     CNTVALUEIN_D ,
//     vio_load 
	 );

/////////// input output////////////
input               gclk10m_buf     ;
input               sys_rst_n       ;

//input               ADR_P      ;
//input               ADR_N      ;

input               AOR_P      ;
input               AOR_N      ;
input               BOR_P      ;
input               BOR_N      ;
input               COR_P      ;
input               COR_N      ;
input               DOR_P      ;
input               DOR_N      ;

output              adc_sclk       ;
output              adc_sen        ;
output              adc_rst        ;
output              adc_mosi       ;
input               adc_miso       ;

output              adc_sync       ;
output              adc_sync_dir   ;

input    [9:0]        A_P          ;
input    [9:0]        A_N          ;
input    [9:0]        B_P          ;
input    [9:0]        B_N          ;
input    [9:0]        C_P          ;
input    [9:0]        C_N          ;
input    [9:0]        D_P          ;
input    [9:0]        D_N          ;

//output  flag;
output  [39:0] dataA_out;
output  [39:0] dataB_out;
output  [39:0] dataC_out;
output  [39:0] dataD_out;
output  [3:0]  data_or;
//output  clk_data;
//output  clk_data_locked;
input          gclk_sd_bufra;
input          clk_div_a;
//output         rst_bufg;
input          rst_SERDES;
input          auto_seek_rsta;
output         adc_ready;
//output  sync_flag;
//input   sync_flag_all;
input   auto_spi_rstan;
//output  win_ok;
//input   data_sync_flag;
//input   data_sync_all;
//input     [8:0]     CNTVALUEIN_A;
//input     [8:0]     CNTVALUEIN_B;
//input     [8:0]     CNTVALUEIN_C;
//input     [8:0]     CNTVALUEIN_D;

//input vio_load;
/////////////////wire///////////////////
wire    [39:0]       dataA         ;  //unsigned data
wire    [39:0]       dataB         ;
wire    [39:0]       dataC         ;
wire    [39:0]       dataD         ;
//wire                 data_valid    ;

//wire                gclk_sd_bufra   ;
//wire                gclk_sd_lockeda ;
//wire                clk_div_a      ;

//wire                adc_ready     ;
//wire                work_mode     ; 

//wire                auto_seek_rsta	; //复位IOdelay的复位信号，用于重新加载延迟计数值 也会复位MMCM单元
//wire                a_adc_ddrrst;    //用于构成接收数据的复位信号 复位serdes
//wire                auto_spi_rstan;  //配置ADC逻辑的复位信号

//wire [8:0]    	a_CNTVALUEIN	;
//wire [8:0]        a_CNTVALUEOUT	;
//wire    [1:0]     clk_ctrl        ;

//wire              iodelay_rdy     ;
//============================================
//assign  clk_data = clk_div_a;
//assign  clk_data_locked = gclk_sd_lockeda;
///////////////////////reset sequencer////////////////////
//wire rst_IDELAYCTRL;
//wire rst_IODELAY;
//wire rst_pro;

//wire rst_SERDES_init;
//wire rst_BUFG_init;

//  reset_sequence inst_reset_ctr (
//      .sys_rst_n(sys_rst_n),
//      .clk10m(gclk10m_buf),
//      .iodelay_rdy(iodelay_rdy),
      //--------
//      .rst_IDELAYCTRL(rst_IDELAYCTRL),
//      .rst_BUFG_init(rst_BUFG_init),
//      .rst_IODELAY(rst_IODELAY),
//      .rst_SERDES(rst_SERDES_init),
//      .rst_pro(rst_pro)
//      );
////////////////////////IDELAYCTRL/////////////////////////// 
//   IDELAYCTRL_GROUP inst_idelayctrl_group (
//        .REFCLK(gclk200m_buf),
//        .RST(rst_IDELAYCTRL),
//        .RDY(iodelay_rdy)    
//   ); 
//    assign iodelay_rdy = 1'b1;
///////////////////完成自动调整延时的功能/////////////////////
//wire rst_SERDES_seek;
//wire rst_BUFG_seek;

//adc_AUTO_SEEK_D_WIN u_auto_seek_win (
//    .gclk10m_buf			(gclk10m_buf), //10M 状态机时钟
//    .rst     				(rst_pro),     
//	 //----channel----
//    .auto_seek_rst		    (auto_seek_rsta), //复位IOdelay的复位信号，用于重新加载延迟计数值
//   //-----------adc------------- 
//   .auto_spi_rstn           (auto_spi_rstan),   //配置ADC逻辑的复位信号
////   .work_mode               (work_mode),   
//   .adc_ready               (adc_ready), 
//   //-------------    
//    .adc_ddrrst             (rst_SERDES_seek),   //复位ISERDES	
//    .bufg_rst               (rst_BUFG_seek),       //复位BUFG_DIVIDE
//	 //-------------
//	.win_ok_all            (data_valid),
//	//--------------
//	.sync_flag(sync_flag),
////	.win_ok(win_ok),
//	.sync_flag_all(sync_flag_all)
////	.data_sync_flag(data_sync_flag),
////	.data_sync_all(data_sync_all)
//    );
	 
//wire rst_bufg;
//assign 	  rst_bufg = rst_BUFG_seek | rst_BUFG_init;
////////////////////时钟信号的产生////////////////////
//clk_rst u_clk_rst(
//	 //--------system clk and rst---------------	
//    .sys_rst_n       (    sys_rst_n       ),
//    .bufg_rst        (    rst_bufg        ), //*** ***
//    .gclk10m_buf     (    gclk10m_buf    ),
//	 //----input data clk-----
//    .ADR_P           (    ADR_P           ),
//    .ADR_N           (    ADR_N           ),
//	 //-----------局部时钟---------------------	 
//    .gclk_sd_lockeda (    gclk_sd_lockeda ), 
//    .gclk_sd_bufra   (    gclk_sd_bufra   ), //625M
//    .clk_div_a       (    clk_div_a       ) //312.5M	 
//);
//////////////////配置	ADC//////////////////
ad_spi_cfg 
  #(
    .adcmode(adcmode),
    .outmode(outmode),
    .offset_A(offset_A),
    .offset_B(offset_B),
    .offset_C(offset_C),
    .offset_D(offset_D),
    .gain_A(gain_A),
    .gain_B(gain_B),
    .gain_C(gain_C),
    .gain_D(gain_D),
    .phase_A(phase_A),
    .phase_B(phase_B),
    .phase_C(phase_C),
    .phase_D(phase_D)
  )
u_ad_spi_cfg(
    .clk             (    gclk10m_buf     ),
    .sys_rst_n       (    auto_spi_rstan  ), //reset AD config
	 //------------
    .adc_rst         (    adc_rst         ), //reset AD chip
    .adc_mosi        (    adc_mosi        ),
    .adc_sen         (    adc_sen         ),
    .adc_sclk        (    adc_sclk        ),
	.adc_miso        (    adc_miso        ),
	.adc_sync        (    adc_sync        ),
	.adc_sync_dir    (    adc_sync_dir    ),
	 //------------
//    .work_mode       (    work_mode       ),
//    .clk_ctrl        (    clk_ctrl        ),
    .cfg_reday       (    adc_ready       )
	); 
////////////////////接收数据//////////////////// 
//--------------------------------------
//wire  rst_SERDES;
//assign  rst_SERDES = rst_SERDES_seek;

UA_adc_inf adc_inf(
	.clk10m          (    gclk10m_buf     ), //10M 
	 //-----channel A B C D receive data---------
	.a_adc_gclk      (    gclk_sd_bufra   ),
	.clk_div_a       (    clk_div_a       ),
    .rst_IODELAY     (    ~sys_rst_n     ),// power up one time
    .rst_SERDES      (    rst_SERDES      ),// depend on clk_div
	 //----data in------
    .A_P             (    A_P          ),
    .A_N             (    A_N          ),
    .B_P             (    B_P          ),
    .B_N             (    B_N          ),
	.C_P             (    C_P          ),
    .C_N             (    C_N          ),
    .D_P             (    D_P          ),
    .D_N             (    D_N          ),
	 //----out of range-----
    .AOR_P           (    AOR_P           ),
    .AOR_N           (    AOR_N           ),
    .BOR_P           (    BOR_P           ),
    .BOR_N           (    BOR_N           ),
    .COR_P           (    COR_P           ),
    .COR_N           (    COR_N           ),
	.DOR_P           (    DOR_P           ),
    .DOR_N           (    DOR_N           ),
	 //----data output-----
    .dataA           (    dataA        ),
    .dataB           (    dataB        ),
    .dataC           (    dataC        ),
	.dataD           (    dataD        ),	 
	 //-----------
    .data_or         (	  data_or      ),
    //------------
    .load            (	  auto_seek_rsta )
//    .CNTVALUEIN_A    (    CNTVALUEIN_A  ),
//    .CNTVALUEIN_B    (    CNTVALUEIN_B  ),
//    .CNTVALUEIN_C    (    CNTVALUEIN_C  ),
//    .CNTVALUEIN_D    (    CNTVALUEIN_D  )
);
//----------接收数据复位信号的产生------------

/////////////////////////data process////////////////////////////

data_process 
      #(
		 .SERDES_RATIO(  4    )
       )
inst_process (
//    .rst(~data_valid), //go into normal operation 
    .clk_div_a(clk_div_a),
//    .clk10m(gclk10m_buf), 
    .dataA(dataA), 
    .dataB(dataB), 
    .dataC(dataC),  
    .dataD(dataD),
	 //-----output-----
	 .dataA_out(dataA_out),
	 .dataB_out(dataB_out),
	 .dataC_out(dataC_out),
	 .dataD_out(dataD_out)
//	 .flag(flag)
    );	 

endmodule
