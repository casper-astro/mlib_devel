//////////////////////function description///////////////////////////////	 
//����ģʽ:  4ͨ��
//������:    1G
//����ʱ��:  2G   0dBm
//����ģ���ź� : A B C D ͨ������  ������500mVpp
//������ݸ�ʽ:
//�������ݰ� A C B D ��˳���4��ͨ�������ÿ��ͨ���ֳ�ȡΪ4·����16·���ݣ�����Aͨ����a_dataA��40bit��a_dataA[9:0]Ϊ
//��һ·���������ƣ�a_dataA[39:30]Ϊ��4·
/////////////////////////////////////////////////////////////////////////
module ad_top 
#(
     parameter a_adcmode  = 4'b0000,
     parameter a_outmode  = 1'b0,
//     parameter b_adcmode  = 4'b0000,
//     parameter b_outmode  = 1'b0,
     
     parameter a_offset_A = 16'h0200,
	 parameter a_offset_B = 16'h0200,
	 parameter a_offset_C = 16'h0200,
	 parameter a_offset_D = 16'h0200,
     parameter a_gain_A   = 16'h0200,
     parameter a_gain_B   = 16'h0200,
     parameter a_gain_C   = 16'h0200,
     parameter a_gain_D   = 16'h0200,
     parameter a_phase_A  = 16'h0200,
     parameter a_phase_B  = 16'h0200,
     parameter a_phase_C  = 16'h0200,
     parameter a_phase_D  = 16'h0200
     
//     parameter b_offset_A = 16'h0200,
//     parameter b_offset_B = 16'h0200,
//     parameter b_offset_C = 16'h0200,
//     parameter b_offset_D = 16'h0200,
//     parameter b_gain_A   = 16'h0200,
//     parameter b_gain_B   = 16'h0200,
//     parameter b_gain_C   = 16'h0200,
//     parameter b_gain_D   = 16'h0200,
//     parameter b_phase_A  = 16'h0200,
//     parameter b_phase_B  = 16'h0200,
//     parameter b_phase_C  = 16'h0200,
//     parameter b_phase_D  = 16'h0200     	 
 )
(
//---ϵͳʱ�Ӽ���λ----
	 sys_rst_n     ,
	 clk10m        ,
	 clk250m       ,
	 clk10m_locked ,
//     sys_clkp     ,
//     sys_clkn     ,
//========a_ADC���ź�========
     ADR_P      ,   //625MHz
     ADR_N      ,
//-----OR----- 
     AOR_P      ,
	 AOR_N      ,
	 BOR_P      ,
	 BOR_N      ,
	 COR_P      ,
     COR_N      ,
	 DOR_P      ,
	 DOR_N      ,
//---ADC�����ź�---- 
     adc_sclk      ,   
     adc_sen       ,
     adc_rst       ,
     adc_mosi      ,
	 adc_miso      ,
     adc_sync      ,
	 adc_sync_dir  ,
//----------ADC�ɼ�����-----------
	 A_P   ,
	 A_N   ,
	 B_P   ,
	 B_N   ,
	 C_P   ,
	 C_N   ,
	 D_P   ,
	 D_N   ,
////========b_ADC���ź�==========
//     ADR_P1      ,   //625MHz
//     ADR_N1      ,
////-----OR----- 
//     AOR_P1      ,
//     AOR_N1      ,
//     BOR_P1      ,
//     BOR_N1      ,
//     COR_P1      ,
//     COR_N1      ,
//     DOR_P1      ,
//     DOR_N1      ,
////---ADC�����ź�---- 
//     adc_sclk1      ,   
//     adc_sen1       ,
//     adc_rst1       ,
//     adc_mosi1      ,
//     adc_miso1      ,
     
//     adc_sync1      ,
//     adc_sync_dir1  ,
////----------ADC�ɼ�����-----------
//     A_P1   ,
//     A_N1   ,
//     B_P1   ,
//     B_N1   ,
//     C_P1   ,
//     C_N1   ,
//     D_P1   ,
//     D_N1   ,
//----------sync------
//     trig_dir,
//     trig_ext, 
//===============output==============
     a_dataA_0,
     a_dataA_1,
     a_dataA_2,
     a_dataA_3,
     a_dataB_0,
     a_dataB_1,
     a_dataB_2,
     a_dataB_3,
     a_dataC_0,
     a_dataC_1,
     a_dataC_2,
     a_dataC_3,
     a_dataD_0,
     a_dataD_1,
     a_dataD_2,
     a_dataD_3,

//     b_dataA_0,
//     b_dataA_1,
//     b_dataA_2,
//     b_dataA_3,
//     b_dataB_0,
//     b_dataB_1,
//     b_dataB_2,
//     b_dataB_3,
//     b_dataC_0,
//     b_dataC_1,
//     b_dataC_2,
//     b_dataC_3,
//     b_dataD_0,
//     b_dataD_1,
//     b_dataD_2,
//     b_dataD_3,
     data_valid,
     clk_data,
     a_data_or,
//     b_data_or,  
	//-----led flag----
	 flag_sync,
	 flag_clk10m,
	 flag_a_clk,
	 flag_b_clk	 
	 );

////////////input output////////////
input               sys_rst_n;
input               clk10m    ;
input               clk250m   ;
input               clk10m_locked;
//input               sys_clkp  ;
//input               sys_clkn  ;
//-----------a_ADC--------------
input               ADR_P      ;
input               ADR_N      ;

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
//-----------b_ADC--------------
//input               ADR_P1      ;
//input               ADR_N1      ;

//input               AOR_P1      ;
//input               AOR_N1      ;
//input               BOR_P1      ;
//input               BOR_N1      ;
//input               COR_P1      ;
//input               COR_N1      ;
//input               DOR_P1      ;
//input               DOR_N1      ;

//output              adc_sclk1       ;
//output              adc_sen1        ;
//output              adc_rst1        ;
//output              adc_mosi1       ;
//input               adc_miso1       ;

//output              adc_sync1       ;
//output              adc_sync_dir1   ;

//input    [9:0]        A_P1          ;
//input    [9:0]        A_N1          ;
//input    [9:0]        B_P1          ;
//input    [9:0]        B_N1          ;
//input    [9:0]        C_P1          ;
//input    [9:0]        C_N1          ;
//input    [9:0]        D_P1          ;
//input    [9:0]        D_N1          ;
//------------------------------------
//output trig_dir;
//output reg trig_ext;
//------------------------------------
output reg [9:0]     a_dataA_0;
output reg [9:0]     a_dataA_1;
output reg [9:0]     a_dataA_2;
output reg [9:0]     a_dataA_3;
output reg [9:0]     a_dataB_0;
output reg [9:0]     a_dataB_1;
output reg [9:0]     a_dataB_2;
output reg [9:0]     a_dataB_3;
output reg [9:0]     a_dataC_0;
output reg [9:0]     a_dataC_1;
output reg [9:0]     a_dataC_2;
output reg [9:0]     a_dataC_3;
output reg [9:0]     a_dataD_0;
output reg [9:0]     a_dataD_1;
output reg [9:0]     a_dataD_2;
output reg [9:0]     a_dataD_3;
//------------------------------------
//output [9:0]     b_dataA_0;
//output [9:0]     b_dataA_1;
//output [9:0]     b_dataA_2;
//output [9:0]     b_dataA_3;
//output [9:0]     b_dataB_0;
//output [9:0]     b_dataB_1;
//output [9:0]     b_dataB_2;
//output [9:0]     b_dataB_3;
//output [9:0]     b_dataC_0;
//output [9:0]     b_dataC_1;
//output [9:0]     b_dataC_2;
//output [9:0]     b_dataC_3;
//output [9:0]     b_dataD_0;
//output [9:0]     b_dataD_1;
//output [9:0]     b_dataD_2;
//output [9:0]     b_dataD_3;

output        data_valid;
output        clk_data;
output  [3:0] a_data_or;
//output  [3:0] b_data_or;
//--------------
output   flag_sync;
output   flag_clk10m;
output   flag_a_clk;
output   flag_b_clk;

//wire vio_sys_rst;
//wire vio_load;
////////////////////////clk//////////////////////////////////
// wire clk500m_locked;
// wire clk10m_new;
// wire clk500m;
 
//  clk_500M inst_clk
//   (
//    // Clock out ports
//    .clk_out1(clk10m_new),     // output clk_out1
//    .clk_out2(clk500m),     // output clk_out2
//    // Status and control signals
//    .reset(~clk10m_locked), // input reset
//    .locked(clk500m_locked),       // output locked
//   // Clock in ports
//    .clk_in1(clk10m)
//    );      // input clk_in1
    
    
//wire spi_clk;
//wire clk10m;
//wire clk10m_locked;
//wire clk500m;
 
//clk_ger inst_clk (
//    .sys_rst_n(sys_rst_n), 
//    .sys_clkp(sys_clkp), 
//    .sys_clkn(sys_clkn),
////    .sys_clk(sys_clk),
//    //-----------	 
//    .gclk10m_bufr(clk10m), 
//    .gclk10m_locked(clk10m_locked), 
////    .spi_clk(spi_clk),
//	 //-----------	 
//	 .clk_500m(clk500m) //10M
//    );
	
//assign adc_sclk1 =  clk10m;
//assign adc_sclk  =  clk10m;
//----------global reset------------- 
	 wire sys_rst_n_10M;	 
	 wire sysrst_nr0;
	 reg  sysrst_nr1;
	 reg  sysrst_nr2;	 
	 assign sysrst_nr0 = sys_rst_n & clk10m_locked ;
	 
	 always@(posedge clk10m or negedge sysrst_nr0)
		if(!sysrst_nr0)
			sysrst_nr1 <= 1'b0; 
		else
			sysrst_nr1 <= 1'b1;

	 always@(posedge clk10m or negedge sysrst_nr0)
	 if(!sysrst_nr0)
		 sysrst_nr2 <= 1'b0;
	 else
		 sysrst_nr2 <= sysrst_nr1;

	  assign sys_rst_n_10M = sysrst_nr2;
//////////////////////////////////////////////////////
//wire rst_bufg;
//wire clk_data;
//wire clk_data_locked;
wire gclk_sd_bufra;

clk_rst u_clk_rst(
	 //--------system clk and rst---------------	
//    .sys_rst_n       (    sys_rst_n_10M       ),
//    .bufg_rst        (    rst_bufg        ), //*** ***
//    .gclk10m_buf     (    gclk10m_buf    ),
	 //----input data clk-----
    .ADR_P           (    ADR_P           ),
    .ADR_N           (    ADR_N           ),
//    .ADR_P1          (    ADR_P1          ),
//    .ADR_N1          (    ADR_N1          ),
	 //-----------�ֲ�ʱ��---------------------	 
//    .gclk_sd_lockeda (    clk_data_locked ), 
    .gclk_sd_bufra   (    gclk_sd_bufra   ), //625M
    .clk_div_a       (    clk_data        ) //312.5M	 
);
//////////////////////////////////////////////////////
wire auto_seek_rsta;
wire auto_spi_rstan;
wire rst_SERDES;
wire sync_flag;

wire adc_ready;
wire a_adc_ready;
//wire b_adc_ready;
//assign adc_ready = a_adc_ready & b_adc_ready;
assign adc_ready = a_adc_ready ;

adc_AUTO_SEEK_D_WIN u_auto_seek_win (
    .gclk10m_buf			(clk10m), //10M ״̬��ʱ��
    .rst     				(~sys_rst_n_10M),     
	 //----channel----
    .auto_seek_rst		    (auto_seek_rsta), //��λIOdelay�ĸ�λ�źţ��������¼����ӳټ���ֵ
   //-----------adc------------- 
    .auto_spi_rstn          (auto_spi_rstan),   //����ADC�߼��ĸ�λ�ź�
//   .work_mode               (work_mode),   
   //-------------    
    .adc_ddrrst             (rst_SERDES),   //��λISERDES	
//    .bufg_rst               (rst_bufg),       //��λBUFG_DIVIDE
    .adc_ready              (adc_ready), 
	 //-------------
	.win_ok_all             (data_valid),
	//--------------
	.sync_flag              (sync_flag)
//	.win_ok(win_ok),
//	.sync_flag_all(sync_flag_all)
//	.data_sync_flag(data_sync_flag),
//	.data_sync_all(data_sync_all)
    );

//////////////AD interface////////////////////////////
//===================ADC_U72=========================
//---------data-----------
//wire  a_flag;
wire  [39:0] a_dataA;
wire  [39:0] a_dataB;
wire  [39:0] a_dataC;
wire  [39:0] a_dataD;
//wire  [3:0]  a_data_or;

//wire  a_clk_data;
//wire  a_clk_data_locked;

//wire  a_sync_flag;
//wire  a_win_ok;
//reg   sync_flag_all_a;
//reg   data_sync_all_a;
//reg   data_sync_flag_a;

//wire [8:0] a_CNTVALUEIN_A;
//wire [8:0] a_CNTVALUEIN_B;
//wire [8:0] a_CNTVALUEIN_C;
//wire [8:0] a_CNTVALUEIN_D;
//wire       vio_load;

//assign  a_CNTVALUEIN_A = 9'd9;
//assign  a_CNTVALUEIN_B = 9'd9;
//assign  a_CNTVALUEIN_C = 9'd9;
//assign  a_CNTVALUEIN_D = 9'd9;
//assign  vio_load       = 1'b0; 
//--------------------------
ad_fun 
     #(
         .adcmode(a_adcmode),
         .outmode(a_outmode),
         .offset_A(a_offset_A),
		 .offset_B(a_offset_B),
		 .offset_C(a_offset_C),
		 .offset_D(a_offset_D ),
		 .gain_A(a_gain_A),
         .gain_B(a_gain_B),
         .gain_C(a_gain_C),
         .gain_D(a_gain_D),
		 .phase_A(a_phase_A),
         .phase_B(a_phase_B),
         .phase_C(a_phase_C),
         .phase_D(a_phase_D)
       )
 inst_AD_u72  (
	 //INPUT
	//---------------- 
    .gclk10m_buf(clk10m), 
    .sys_rst_n(sys_rst_n_10M), 
    //-----------------     
//    .ADR_P(ADR_P), 
//    .ADR_N(ADR_N), 
    .AOR_P(AOR_P), 
    .AOR_N(AOR_N), 
    .BOR_P(BOR_P), 
    .BOR_N(BOR_N), 
    .COR_P(COR_P), 
    .COR_N(COR_N), 
    .DOR_P(DOR_P), 
    .DOR_N(DOR_N),  
    .A_P(A_P), 
    .A_N(A_N), 
    .B_P(B_P), 
    .B_N(B_N), 
    .C_P(C_P), 
    .C_N(C_N), 
    .D_P(D_P), 
    .D_N(D_N),
	 //OUTPUT
	 //-------AD-----------
	.adc_sclk(adc_sclk), 
    .adc_sen(adc_sen), 
    .adc_rst(adc_rst), 
    .adc_mosi(adc_mosi), 
    .adc_miso(adc_miso), 
    .adc_sync(adc_sync), 
    .adc_sync_dir(adc_sync_dir),
	 //-----������ݼ�ʱ���ź�------
//    .flag(a_flag),	 
    .dataA_out(a_dataA), 
    .dataB_out(a_dataB), 
    .dataC_out(a_dataC), 
    .dataD_out(a_dataD), 
    .data_or(a_data_or), 
//    .clk_data(a_clk_data), 
//    .clk_data_locked(a_clk_data_locked),
    .gclk_sd_bufra(gclk_sd_bufra),
    .clk_div_a(clk_data),
//    .rst_bufg(rst_bufg),
    .rst_SERDES(rst_SERDES),
    .auto_seek_rsta(auto_seek_rsta),
    .auto_spi_rstan(auto_spi_rstan),
    .adc_ready(a_adc_ready)
    //---------sync----------
//    .sync_flag(a_sync_flag),
//    .sync_flag_all(sync_flag_all_a),
//    .win_ok(a_win_ok),
//    .data_sync_all(data_sync_all_a),
//    .data_sync_flag(data_sync_flag_a),
//    .CNTVALUEIN_A(a_CNTVALUEIN_A),
//    .CNTVALUEIN_B(a_CNTVALUEIN_B),
//    .CNTVALUEIN_C(a_CNTVALUEIN_C),
//    .CNTVALUEIN_D(a_CNTVALUEIN_D),
//    .vio_load(vio_load)
    );
//===================ADC_U73=========================
//---------data-----------
////wire  b_flag;
//wire  [39:0] b_dataA;
//wire  [39:0] b_dataB;
//wire  [39:0] b_dataC;
//wire  [39:0] b_dataD;
////wire  [3:0]  b_data_or;

////wire  b_clk_data;
////wire  b_clk_data_locked;

////wire  b_sync_flag;
////wire  b_win_ok;
////reg   data_sync_flag_b;
////reg   data_sync_all_b;
////reg   sync_flag_all_b;

////wire [8:0] b_CNTVALUEIN_A;
////wire [8:0] b_CNTVALUEIN_B;
////wire [8:0] b_CNTVALUEIN_C;
////wire [8:0] b_CNTVALUEIN_D;

////assign  b_CNTVALUEIN_A = 9'd9;
////assign  b_CNTVALUEIN_B = 9'd9;
////assign  b_CNTVALUEIN_C = 9'd9;
////assign  b_CNTVALUEIN_D = 9'd9;
////--------------------------
//ad_fun 
//   #(
//        .adcmode(b_adcmode),
//        .outmode(b_outmode),
//        .offset_A(b_offset_A),
//        .offset_B(b_offset_B ),
//        .offset_C(b_offset_C),
//        .offset_D(b_offset_D),
//        .gain_A(b_gain_A ),
//        .gain_B(b_gain_B),
//        .gain_C(b_gain_C),
//        .gain_D(b_gain_D ),
//        .phase_A(b_phase_A),
//        .phase_B(b_phase_B),
//        .phase_C(b_phase_C),
//        .phase_D(b_phase_D)
//    )
//inst_AD_u73 (
//    //INPUT 
//	//---------------- 
//    .gclk10m_buf(clk10m), 
//    .sys_rst_n(sys_rst_n_10M),
//    //-----------------      
////    .ADR_P(ADR_P1), 
////    .ADR_N(ADR_N1), 
//    .AOR_P(AOR_P1), 
//    .AOR_N(AOR_N1), 
//    .BOR_P(BOR_P1), 
//    .BOR_N(BOR_N1), 
//    .COR_P(COR_P1), 
//    .COR_N(COR_N1), 
//    .DOR_P(DOR_P1), 
//    .DOR_N(DOR_N1),  
//    .A_P(A_P1), 
//    .A_N(A_N1), 
//    .B_P(B_P1), 
//    .B_N(B_N1), 
//    .C_P(C_P1), 
//    .C_N(C_N1), 
//    .D_P(D_P1), 
//    .D_N(D_N1),
//	 //OUTPUT
//	 //-------AD-----------
//	.adc_sclk(adc_sclk1), 
//    .adc_sen(adc_sen1), 
//    .adc_rst(adc_rst1), 
//    .adc_mosi(adc_mosi1), 
//    .adc_miso(adc_miso1), 
//    .adc_sync(adc_sync1), 
//    .adc_sync_dir(adc_sync_dir1),
//	 //-----������ݼ�ʱ���ź�------
////    .flag(b_flag),	 
//    .dataA_out(b_dataA), 
//    .dataB_out(b_dataB), 
//    .dataC_out(b_dataC), 
//    .dataD_out(b_dataD), 
//    .data_or(b_data_or), 
////    .clk_data(b_clk_data), 
////    .clk_data_locked(b_clk_data_locked),
//    .gclk_sd_bufra(gclk_sd_bufra),
//    .clk_div_a(clk_data),
////    .rst_bufg( ),
//    .rst_SERDES(rst_SERDES),
//    .auto_seek_rsta(auto_seek_rsta),
//    .auto_spi_rstan(auto_spi_rstan),
//    .adc_ready(b_adc_ready)
//    //-------sync-------
////    .sync_flag(b_sync_flag),
////    .sync_flag_all(sync_flag_all_b),
////    .win_ok(b_win_ok),
////    .data_sync_all(data_sync_all_b),
////    .data_sync_flag(data_sync_flag_b),
////    .CNTVALUEIN_A(b_CNTVALUEIN_A),
////    .CNTVALUEIN_B(b_CNTVALUEIN_B),
////    .CNTVALUEIN_C(b_CNTVALUEIN_C),
////    .CNTVALUEIN_D(b_CNTVALUEIN_D),
////    .vio_load(vio_load)
//    );
always @(*)begin
   if(a_adcmode==4'b1000)begin   //1-Channel
     a_dataA_0<=a_dataA[9:0];
     a_dataA_1<=a_dataC[9:0];
     a_dataA_2<=a_dataB[9:0];
     a_dataA_3<=a_dataD[9:0];
                
     a_dataB_0<=a_dataA[19:10];
     a_dataB_1<=a_dataC[19:10];
     a_dataB_2<=a_dataB[19:10];
     a_dataB_3<=a_dataD[19:10];
   
     a_dataC_0<=a_dataA[29:20];
     a_dataC_1<=a_dataC[29:20];
     a_dataC_2<=a_dataB[29:20];
     a_dataC_3<=a_dataD[29:20];
   
     a_dataD_0<=a_dataA[39:30];
     a_dataD_1<=a_dataC[39:30];
     a_dataD_2<=a_dataB[39:30];
     a_dataD_3<=a_dataD[39:30]; 
   end else if(a_adcmode==4'b0100)begin   //2-Channel  
     a_dataA_0<=a_dataA[9:0];
     a_dataA_1<=a_dataB[9:0];
     a_dataA_2<=a_dataA[19:10];
     a_dataA_3<=a_dataB[19:10];
                
     a_dataB_0<=a_dataA[29:20];
     a_dataB_1<=a_dataB[29:20];
     a_dataB_2<=a_dataA[39:30];
     a_dataB_3<=a_dataB[39:30];
   
     a_dataC_0<=a_dataC[9:0];
     a_dataC_1<=a_dataD[9:0];
     a_dataC_2<=a_dataC[19:10];
     a_dataC_3<=a_dataD[19:10];
   
     a_dataD_0<=a_dataC[29:20];
     a_dataD_1<=a_dataD[29:20];
     a_dataD_2<=a_dataC[39:30];
     a_dataD_3<=a_dataD[39:30];                
   end else begin //4-hannel
     a_dataA_0<=a_dataA[9:0];
     a_dataA_1<=a_dataA[19:10];
     a_dataA_2<=a_dataA[29:20];
     a_dataA_3<=a_dataA[39:30];
                      
     a_dataB_0<=a_dataB[9:0];
     a_dataB_1<=a_dataB[19:10];
     a_dataB_2<=a_dataB[29:20];
     a_dataB_3<=a_dataB[39:30];
    
     a_dataC_0<=a_dataC[9:0];
     a_dataC_1<=a_dataC[19:10];
     a_dataC_2<=a_dataC[29:20];
     a_dataC_3<=a_dataC[39:30];
       
     a_dataD_0<=a_dataD[9:0];
     a_dataD_1<=a_dataD[19:10];
     a_dataD_2<=a_dataD[29:20];
     a_dataD_3<=a_dataD[39:30];
   end
end        
                                      
    
//    assign b_dataA_0=b_dataA[9:0];
//    assign b_dataA_1=b_dataA[19:10];
//    assign b_dataA_2=b_dataA[29:20];
//    assign b_dataA_3=b_dataA[39:30];
       
//    assign b_dataB_0=b_dataB[9:0];
//    assign b_dataB_1=b_dataB[19:10];
//    assign b_dataB_2=b_dataB[29:20];
//    assign b_dataB_3=b_dataB[39:30];
       
//    assign b_dataC_0=b_dataC[9:0];
//    assign b_dataC_1=b_dataC[19:10];
//    assign b_dataC_2=b_dataC[29:20];
//    assign b_dataC_3=b_dataC[39:30];
          
//    assign b_dataD_0=b_dataD[9:0];
//    assign b_dataD_1=b_dataD[19:10];
//    assign b_dataD_2=b_dataD[29:20];
//    assign b_dataD_3=b_dataD[39:30]; 
//==================================================
//reg a_sync_flag_r1;
//reg a_sync_flag_r2;
//reg a_sync_flag_r3;
//always@(posedge clk10m)
//    begin
//        a_sync_flag_r1 <= a_sync_flag;
//        a_sync_flag_r2 <= a_sync_flag_r1;
//        a_sync_flag_r3 <= a_sync_flag_r2;
//    end
//    reg b_sync_flag_r1;
//    reg b_sync_flag_r2;
//    reg b_sync_flag_r3;
//    always@(posedge clk10m)
//        begin
//            b_sync_flag_r1 <= b_sync_flag;
//            b_sync_flag_r2 <= b_sync_flag_r1;
//            b_sync_flag_r3 <= b_sync_flag_r2;
//        end    
//---------------------------------------------
//    wire sync_all;
//    assign sync_all = a_sync_flag_r3 & b_sync_flag_r3;
//    reg sync_all_r1;
//    reg sync_all_r2;
//    always@(posedge clk10m)
//    begin
//        sync_all_r1 <= sync_flag;
//        sync_all_r2 <= sync_all_r1;
//    end
//    reg sync_all_a1;
//    reg sync_all_a2;
//    always@(posedge clk10m)
//    begin
//        sync_all_a1 <= sync_all_r2;
//        sync_all_a2 <= sync_all_a1;
//        sync_flag_all_a <= sync_all_a2;
//    end
//    reg sync_all_b1;
//    reg sync_all_b2;
//        always@(posedge clk10m)
//        begin
//            sync_all_b1 <= sync_all_r2;
//            sync_all_b2 <= sync_all_b1;
//            sync_flag_all_b <= sync_all_b2;
//        end
 //--------------------------------------------      
//    assign trig_dir = 1;
    
//    reg trig_ext_r;
//    reg trig_ext_rr;
//    always@(posedge clk250m)
//    begin
//        trig_ext_r    <= sync_all_r2;
//        trig_ext_rr   <= trig_ext_r;
////        trig_ext      <= trig_ext_rr;
//    end
//    always@(posedge clk250m or negedge sys_rst_n_10M)
//    begin
//        if(~sys_rst_n_10M)
//            begin
//               trig_ext <= 0; 
//            end
//        else if((trig_ext_rr==0)&&(trig_ext_r==1))
//            begin
//               trig_ext <= 1; 
//            end
//        else
//            begin
//               trig_ext <= 0; 
//            end   
//    end
//---------------------------------------------------- 
//reg a_win_ok_r1;
//reg a_win_ok_r2;
//reg a_win_ok_r3;
//always@(posedge clk10m)
//    begin
//        a_win_ok_r1 <= a_win_ok;
//        a_win_ok_r2 <= a_win_ok_r1;
//        a_win_ok_r3 <= a_win_ok_r2;
//    end 
//    reg b_win_ok_r1;
//    reg b_win_ok_r2;
//    reg b_win_ok_r3;
//    always@(posedge clk10m)
//        begin
//            b_win_ok_r1 <= b_win_ok;
//            b_win_ok_r2 <= b_win_ok_r1;
//            b_win_ok_r3 <= b_win_ok_r2;
//        end        
     
//    wire win_ok_all;
//    assign win_ok_all = a_win_ok_r3 & b_win_ok_r3;
//    reg win_ok_r1;
//    reg win_ok_r2;
//    always@(posedge clk10m)
//    begin
//        win_ok_r1 <= win_ok_all;
//        win_ok_r2 <= win_ok_r1;
//    end 
//     reg data_sync_all_a1;
//     reg data_sync_all_a2;
//      always@(posedge clk10m)
//      begin
//          data_sync_all_a1 <= win_ok_r2;
//          data_sync_all_a2 <= data_sync_all_a1;
//          data_sync_all_a <= data_sync_all_a2;
//      end 
//     reg data_sync_all_b1;
//     reg data_sync_all_b2;
//     always@(posedge clk10m)
//        begin
//           data_sync_all_b1 <= win_ok_r2;
//           data_sync_all_b2 <= data_sync_all_b1;
//           data_sync_all_b <= data_sync_all_b2;
//        end 
    //--------------------------------
//    wire data_sync_out;
//    reg  data_sync_r;
//    always@(posedge clk10m)
//    begin
//        data_sync_r <= data_sync_out;
//    end
//    reg  data_sync_flag_a1;
//    reg  data_sync_flag_a2;
//    always@(posedge clk10m) 
//    begin
//        data_sync_flag_a1 <= data_sync_r;
//        data_sync_flag_a2 <= data_sync_flag_a1;
//        data_sync_flag_a <= data_sync_flag_a2;
//    end
//    reg  data_sync_flag_b1;
//    reg  data_sync_flag_b2;
//    always@(posedge clk10m) 
//    begin
//        data_sync_flag_b1 <= data_sync_r;
//        data_sync_flag_b2 <= data_sync_flag_b1;
//        data_sync_flag_b <= data_sync_flag_b2;
//    end
//////////////CLOCK REGION/////////////
//wire [159:0] a_data_in;
//assign a_data_in = {a_dataA_out,a_dataB_out,a_dataC_out,a_dataD_out};
//wire [159:0] b_data_in;
//assign b_data_in = {b_dataA_out,b_dataB_out,b_dataC_out,b_dataD_out};                   

//wire [159:0] a_data_out;
//wire [159:0] b_data_out;
//wire data_valid;
    
//clock_region inst_clk_trans (
//    //--------input--------
//    .a_rst(~clk_data_locked),
////    .b_rst(~clk_data_locked),
//    .a_clk_in(clk_data),
////    .b_clk_in(clk_data),
//    .a_data_in(a_data_in),
//    .b_data_in(b_data_in),
////    .a_flag(a_flag),
//    //--------sync----------
////    .win_ok_in(win_ok_r2),
////    .data_sync_out(data_sync_out),
//    //--------output--------
//    .a_data_out(a_data_out),
//    .b_data_out(b_data_out)
////    .data_valid(data_valid)
//    );

//wire [39:0] a_dataA;
//wire [39:0] a_dataB;
//wire [39:0] a_dataC;
//wire [39:0] a_dataD;

//wire [39:0] b_dataA;
//wire [39:0] b_dataB;
//wire [39:0] b_dataC;
//wire [39:0] b_dataD;  

//assign a_dataA = a_data_out[159:120];
//assign a_dataB = a_data_out[119:80];
//assign a_dataC = a_data_out[79:40];
//assign a_dataD = a_data_out[39:0];

//assign b_dataA = b_data_out[159:120];
//assign b_dataB = b_data_out[119:80];
//assign b_dataC = b_data_out[79:40];
//assign b_dataD = b_data_out[39:0]; 
  
///////////////LED/////////////// 
assign flag_sync = data_valid ;

LED inst_led (
    .gclk10m_buf(clk10m), 
    .clk_div_a(clk_data),
//    .clk_div_b(clk_data), 
    .gclk10m_locked(clk10m_locked), 
//    .gclk_sd_lockeda(clk_data_locked),
//    .gclk_sd_lockedb(clk_data_locked), 
    .LED1(flag_clk10m), 
    .LED2(flag_a_clk),
    .LED3(flag_b_clk)
    );
///////////////////////////debug/////////////////////////////////
//reg [9:0] a_dataA1;
//reg [9:0] a_dataB1;
//reg [9:0] a_dataC1;
//reg [9:0] a_dataD1;
//reg [9:0] b_dataA1;
//reg [9:0] b_dataB1;
//reg [9:0] b_dataC1;
//reg [9:0] b_dataD1;

//reg [9:0] a_dataA2;
//reg [9:0] a_dataB2;
//reg [9:0] a_dataC2;
//reg [9:0] a_dataD2;
//reg [9:0] b_dataA2;
//reg [9:0] b_dataB2;
//reg [9:0] b_dataC2;
//reg [9:0] b_dataD2;

//reg [9:0] a_dataA3;
//reg [9:0] a_dataB3;
//reg [9:0] a_dataC3;
//reg [9:0] a_dataD3;
//reg [9:0] b_dataA3;
//reg [9:0] b_dataB3;
//reg [9:0] b_dataC3;
//reg [9:0] b_dataD3;

//reg [9:0] a_dataA4;
//reg [9:0] a_dataB4;
//reg [9:0] a_dataC4;
//reg [9:0] a_dataD4;
//reg [9:0] b_dataA4;
//reg [9:0] b_dataB4;
//reg [9:0] b_dataC4;
//reg [9:0] b_dataD4;
//always@(posedge clk_data)
//begin
//    a_dataA1 <= a_dataA[9:0];
//    a_dataB1 <= a_dataB[9:0];
//    a_dataC1 <= a_dataC[9:0];
//    a_dataD1 <= a_dataD[9:0];
//    b_dataA1 <= b_dataA[9:0];
//    b_dataB1 <= b_dataB[9:0];
//    b_dataC1 <= b_dataC[9:0];
//    b_dataD1 <= b_dataD[9:0];
    
//    a_dataA2 <= a_dataA[19:10];
//    a_dataB2 <= a_dataB[19:10];
//    a_dataC2 <= a_dataC[19:10];
//    a_dataD2 <= a_dataD[19:10];
//    b_dataA2 <= b_dataA[19:10];
//    b_dataB2 <= b_dataB[19:10];
//    b_dataC2 <= b_dataC[19:10];
//    b_dataD2 <= b_dataD[19:10];
    
//    a_dataA3 <= a_dataA[29:20];
//    a_dataB3 <= a_dataB[29:20];
//    a_dataC3 <= a_dataC[29:20];
//    a_dataD3 <= a_dataD[29:20];
//    b_dataA3 <= b_dataA[29:20];
//    b_dataB3 <= b_dataB[29:20];
//    b_dataC3 <= b_dataC[29:20];
//    b_dataD3 <= b_dataD[29:20];
    
//    a_dataA4 <= a_dataA[39:30];
//    a_dataB4 <= a_dataB[39:30];
//    a_dataC4 <= a_dataC[39:30];
//    a_dataD4 <= a_dataD[39:30];
//    b_dataA4 <= b_dataA[39:30];
//    b_dataB4 <= b_dataB[39:30];
//    b_dataC4 <= b_dataC[39:30];
//    b_dataD4 <= b_dataD[39:30];      
//end

//reg [9:0] a_dataA1_r;
//reg [9:0] a_dataB1_r;
//reg [9:0] a_dataC1_r;
//reg [9:0] a_dataD1_r;
//reg [9:0] b_dataA1_r;
//reg [9:0] b_dataB1_r;
//reg [9:0] b_dataC1_r;
//reg [9:0] b_dataD1_r;

//reg [9:0] a_dataA2_r;
//reg [9:0] a_dataB2_r;
//reg [9:0] a_dataC2_r;
//reg [9:0] a_dataD2_r;
//reg [9:0] b_dataA2_r;
//reg [9:0] b_dataB2_r;
//reg [9:0] b_dataC2_r;
//reg [9:0] b_dataD2_r;

//reg [9:0] a_dataA3_r;
//reg [9:0] a_dataB3_r;
//reg [9:0] a_dataC3_r;
//reg [9:0] a_dataD3_r;
//reg [9:0] b_dataA3_r;
//reg [9:0] b_dataB3_r;
//reg [9:0] b_dataC3_r;
//reg [9:0] b_dataD3_r;

//reg [9:0] a_dataA4_r;
//reg [9:0] a_dataB4_r;
//reg [9:0] a_dataC4_r;
//reg [9:0] a_dataD4_r;
//reg [9:0] b_dataA4_r;
//reg [9:0] b_dataB4_r;
//reg [9:0] b_dataC4_r;
//reg [9:0] b_dataD4_r;

//always@(posedge clk_data)
//begin
//    a_dataA1_r <= a_dataA1;
//    a_dataB1_r <= a_dataB1;
//    a_dataC1_r <= a_dataC1;
//    a_dataD1_r <= a_dataD1;
//    b_dataA1_r <= b_dataA1;
//    b_dataB1_r <= b_dataB1;
//    b_dataC1_r <= b_dataC1;
//    b_dataD1_r <= b_dataD1;
    
//    a_dataA2_r <= a_dataA2;
//    a_dataB2_r <= a_dataB2;
//    a_dataC2_r <= a_dataC2;
//    a_dataD2_r <= a_dataD2;
//    b_dataA2_r <= b_dataA2;
//    b_dataB2_r <= b_dataB2;
//    b_dataC2_r <= b_dataC2;
//    b_dataD2_r <= b_dataD2;
    
//    a_dataA3_r <= a_dataA3;
//    a_dataB3_r <= a_dataB3;
//    a_dataC3_r <= a_dataC3;
//    a_dataD3_r <= a_dataD3;
//    b_dataA3_r <= b_dataA3;
//    b_dataB3_r <= b_dataB3;
//    b_dataC3_r <= b_dataC3;
//    b_dataD3_r <= b_dataD3;
    
//    a_dataA4_r <= a_dataA4;
//    a_dataB4_r <= a_dataB4;
//    a_dataC4_r <= a_dataC4;
//    a_dataD4_r <= a_dataD4;
//    b_dataA4_r <= b_dataA4;
//    b_dataB4_r <= b_dataB4;
//    b_dataC4_r <= b_dataC4;
//    b_dataD4_r <= b_dataD4;      
//end

//reg [9:0] a_dataA1_rr;
//reg [9:0] a_dataB1_rr;
//reg [9:0] a_dataC1_rr;
//reg [9:0] a_dataD1_rr;
//reg [9:0] b_dataA1_rr;
//reg [9:0] b_dataB1_rr;
//reg [9:0] b_dataC1_rr;
//reg [9:0] b_dataD1_rr;

//reg [9:0] a_dataA2_rr;
//reg [9:0] a_dataB2_rr;
//reg [9:0] a_dataC2_rr;
//reg [9:0] a_dataD2_rr;
//reg [9:0] b_dataA2_rr;
//reg [9:0] b_dataB2_rr;
//reg [9:0] b_dataC2_rr;
//reg [9:0] b_dataD2_rr;

//reg [9:0] a_dataA3_rr;
//reg [9:0] a_dataB3_rr;
//reg [9:0] a_dataC3_rr;
//reg [9:0] a_dataD3_rr;
//reg [9:0] b_dataA3_rr;
//reg [9:0] b_dataB3_rr;
//reg [9:0] b_dataC3_rr;
//reg [9:0] b_dataD3_rr;

//reg [9:0] a_dataA4_rr;
//reg [9:0] a_dataB4_rr;
//reg [9:0] a_dataC4_rr;
//reg [9:0] a_dataD4_rr;
//reg [9:0] b_dataA4_rr;
//reg [9:0] b_dataB4_rr;
//reg [9:0] b_dataC4_rr;
//reg [9:0] b_dataD4_rr;

//always@(posedge a_clk_data)
//begin
//    a_dataA1_rr <= a_dataA1_r;
//    a_dataB1_rr <= a_dataB1_r;
//    a_dataC1_rr <= a_dataC1_r;
//    a_dataD1_rr <= a_dataD1_r;
//    b_dataA1_rr <= b_dataA1_r;
//    b_dataB1_rr <= b_dataB1_r;
//    b_dataC1_rr <= b_dataC1_r;
//    b_dataD1_rr <= b_dataD1_r;
    
//    a_dataA2_rr <= a_dataA2_r;
//    a_dataB2_rr <= a_dataB2_r;
//    a_dataC2_rr <= a_dataC2_r;
//    a_dataD2_rr <= a_dataD2_r;
//    b_dataA2_rr <= b_dataA2_r;
//    b_dataB2_rr <= b_dataB2_r;
//    b_dataC2_rr <= b_dataC2_r;
//    b_dataD2_rr <= b_dataD2_r;
    
//    a_dataA3_rr <= a_dataA3_r;
//    a_dataB3_rr <= a_dataB3_r;
//    a_dataC3_rr <= a_dataC3_r;
//    a_dataD3_rr <= a_dataD3_r;
//    b_dataA3_rr <= b_dataA3_r;
//    b_dataB3_rr <= b_dataB3_r;
//    b_dataC3_rr <= b_dataC3_r;
//    b_dataD3_rr <= b_dataD3_r;
    
//    a_dataA4_rr <= a_dataA4_r;
//    a_dataB4_rr <= a_dataB4_r;
//    a_dataC4_rr <= a_dataC4_r;
//    a_dataD4_rr <= a_dataD4_r;
//    b_dataA4_rr <= b_dataA4_r;
//    b_dataB4_rr <= b_dataB4_r;
//    b_dataC4_rr <= b_dataC4_r;
//    b_dataD4_rr <= b_dataD4_r;      
//end

//ila_1 inst_data_b (
//	.clk(clk_data), // input wire clk
//	.probe0(a_dataA1_r), // input wire [9:0]  probe0  
//	.probe1(b_dataA1_r), // input wire [9:0]  probe1 
//	.probe2(a_dataC1_r), // input wire [9:0]  probe2 
//	.probe3(b_dataC1_r), // input wire [9:0]  probe3 
//	.probe4(a_dataB1_r), // input wire [9:0]  probe4 
//	.probe5(b_dataB1_r), // input wire [9:0]  probe5 
//	.probe6(a_dataD1_r), // input wire [9:0]  probe6 
//	.probe7(b_dataD1_r),  // input wire [9:0]  probe7 
//	.probe8(a_dataA2_r), // input wire [9:0]  probe8 
//	.probe9(b_dataA2_r), // input wire [9:0]  probe9 
//	.probe10(a_dataC2_r), // input wire [9:0]  probe10 
//	.probe11(b_dataC2_r), // input wire [9:0]  probe11 
//	.probe12(a_dataB2_r), // input wire [9:0]  probe12 
//	.probe13(b_dataB2_r), // input wire [9:0]  probe13 
//	.probe14(a_dataD2_r), // input wire [9:0]  probe14 
//	.probe15(b_dataD2_r), // input wire [9:0]  probe15 
//	.probe16(a_dataA3_r), // input wire [9:0]  probe16 
//	.probe17(b_dataA3_r), // input wire [9:0]  probe17 
//	.probe18(a_dataC3_r), // input wire [9:0]  probe18 
//	.probe19(b_dataC3_r), // input wire [9:0]  probe19 
//	.probe20(a_dataB3_r), // input wire [9:0]  probe20 
//	.probe21(b_dataB3_r), // input wire [9:0]  probe21 
//	.probe22(a_dataD3_r), // input wire [9:0]  probe22 
//	.probe23(b_dataD3_r), // input wire [9:0]  probe23 
//	.probe24(a_dataA4_r), // input wire [9:0]  probe24 
//	.probe25(b_dataA4_r), // input wire [9:0]  probe25 
//	.probe26(a_dataC4_r), // input wire [9:0]  probe26 
//	.probe27(b_dataC4_r), // input wire [9:0]  probe27 
//	.probe28(a_dataB4_r), // input wire [9:0]  probe28 
//	.probe29(b_dataB4_r), // input wire [9:0]  probe29 
//	.probe30(a_dataD4_r), // input wire [9:0]  probe30 
//	.probe31(b_dataD4_r) // input wire [9:0]  probe31
//);

//vio_0 inst_vio (
//  .clk(clk_data),                // input wire clk
//  .probe_out0(vio_sys_rst),  // output wire [0 : 0] probe_out0
//  .probe_out1(vio_load),  // output wire [0 : 0] probe_out1
//  .probe_out2(a_CNTVALUEIN_A),  // output wire [8 : 0] probe_out2
//  .probe_out3(a_CNTVALUEIN_B),  // output wire [8 : 0] probe_out3
//  .probe_out4(a_CNTVALUEIN_C),  // output wire [8 : 0] probe_out4
//  .probe_out5(a_CNTVALUEIN_D),  // output wire [8 : 0] probe_out5
//  .probe_out6(b_CNTVALUEIN_A),  // output wire [8 : 0] probe_out6
//  .probe_out7(b_CNTVALUEIN_B),  // output wire [8 : 0] probe_out7
//  .probe_out8(b_CNTVALUEIN_C),  // output wire [8 : 0] probe_out8
//  .probe_out9(b_CNTVALUEIN_D)  // output wire [8 : 0] probe_out9
//);

endmodule
