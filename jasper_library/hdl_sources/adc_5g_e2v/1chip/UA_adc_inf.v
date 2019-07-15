module UA_adc_inf(
    //--------------
	 clk10m          , 
	 //----------------
     a_adc_gclk      , //625M
	 clk_div_a       , //156.25M
	 rst_IODELAY     ,
	 rst_SERDES      ,
	 //--------------
     A_P          , //channel 1
	 A_N          ,
	 B_P          ,
	 B_N          ,
	 C_P          , //channel 2
	 C_N          ,
	 D_P          ,
	 D_N          ,
	 //---------------
	 AOR_P      ,
	 AOR_N      ,
	 BOR_P      ,
	 BOR_N      ,
	 COR_P      ,
     COR_N      ,
	 DOR_P      ,
	 DOR_N      ,
	 //----------------
	 dataA        ,
	 dataB        ,
	 dataC        ,
	 dataD        ,
	 //----------------
     data_or	  ,
    //-----------------
     load         
//     CNTVALUEIN_A ,
//     CNTVALUEIN_B ,
//     CNTVALUEIN_C ,
//     CNTVALUEIN_D 
);


//----------input output-------------
input               clk10m          ; 
input               a_adc_gclk      ;
input            	clk_div_a       ; 
input	            rst_IODELAY     ;
input               rst_SERDES      ;
//------------data-------
input     [9:0]         A_P          ;
input     [9:0]         A_N          ;
input     [9:0]         B_P          ;
input     [9:0]         B_N          ;
input     [9:0]         C_P          ;
input     [9:0]         C_N          ;
input     [9:0]         D_P          ;
input     [9:0]         D_N          ;
//-----------------------
input               AOR_P      ;
input               AOR_N      ;
input               BOR_P      ;
input               BOR_N      ;
input               COR_P      ;
input               COR_N      ;
input               DOR_P      ;
input               DOR_N      ;
//--------------------
output    [39:0]    dataA       ;
output    [39:0]    dataB       ;
output    [39:0]    dataC       ;
output    [39:0]    dataD       ;
//--------------------
output    [3:0]     data_or     ;
//--------------------
input               load;
//input     [8:0]     CNTVALUEIN_A;
//input     [8:0]     CNTVALUEIN_B;
//input     [8:0]     CNTVALUEIN_C;
//input     [8:0]     CNTVALUEIN_D;
//output    [8:0]     a_CNTVALUEOUT; 
      
/////////time domain translation//////////
reg  load_IN;
reg  load_10m;
reg  load_ra;
reg  load_rb;

always@(posedge clk10m)
begin
    load_IN       <= load;
    load_10m      <= load_IN;
    load_ra       <= load_10m;
    load_rb       <= load_10m;
end

//reg [8:0] CNTVALUEIN_rar;
reg  load_rar;
//reg [8:0] CNTVALUEIN_rbr;
reg  load_rbr;
//reg [8:0] CNTVALUEIN_rcr;
reg  load_rcr;
//reg [8:0] CNTVALUEIN_rdr;
reg  load_rdr;
always@(posedge clk_div_a)
begin
//    CNTVALUEIN_rar <= CNTVALUEIN_A;
    load_rar       <= load_ra;
//    CNTVALUEIN_rbr <= CNTVALUEIN_B;
    load_rbr       <= load_ra;
//    CNTVALUEIN_rcr <= CNTVALUEIN_C;
    load_rcr       <= load_rb;
//    CNTVALUEIN_rdr <= CNTVALUEIN_D;
    load_rdr       <= load_rb;
end

//reg [8:0] CNTVALUEIN_r0;
//reg [8:0] CNTVALUEIN_r1;
//reg [8:0] CNTVALUEIN_r2;
//reg [8:0] CNTVALUEIN_r3;
reg  load_r0;
reg  load_r1;
reg  load_r2;
reg  load_r3;
always@(posedge clk_div_a)
begin
//    CNTVALUEIN_r0 <= CNTVALUEIN_rar;
    load_r0       <= load_rar;
    
//    CNTVALUEIN_r1 <= CNTVALUEIN_rbr;
    load_r1       <= load_rbr;
    
//    CNTVALUEIN_r2 <= CNTVALUEIN_rcr;
    load_r2       <= load_rcr;
    
//    CNTVALUEIN_r3 <= CNTVALUEIN_rdr;
    load_r3       <= load_rdr;
end
//---------------------------
//wire [8:0] CNTVALUEOUT;
//reg  [8:0] CNTVALUEOUT_r1;
//reg  [8:0] CNTVALUEOUT_r2;
//always@(posedge clk10m)
//begin
//    CNTVALUEOUT_r1 <= CNTVALUEOUT;
//    CNTVALUEOUT_r2 <= CNTVALUEOUT_r1;
//end
//assign a_CNTVALUEOUT = CNTVALUEOUT_r2;
//-----------------------------
reg rst_r1;
reg rst_r2;
always@(posedge clk_div_a or posedge rst_IODELAY)
    if(rst_IODELAY)
        rst_r1 <= 1'b1;
    else
        rst_r1 <= 1'b0;

always@(posedge clk_div_a or posedge rst_IODELAY)
    if(rst_IODELAY)
        rst_r2 <= 1'b1;
    else
        rst_r2 <= rst_r1;
                             
reg rst_r3;
reg rst_r4;
always@(posedge clk_div_a or posedge rst_SERDES)
    if(rst_SERDES)
        rst_r3 <= 1'b1;
    else
        rst_r3 <= 1'b0;
        
always@(posedge clk_div_a or posedge rst_SERDES)
    if(rst_SERDES)
        rst_r4 <= 1'b1;
    else
        rst_r4 <= rst_r3;
               
wire rst_serdes;
wire rst_iodelay;
  assign rst_serdes = rst_r4;
  assign rst_iodelay= rst_r2;    
/////////////////接收数据//////////////////
//-----通道0-------
UA_adc_data_receive u0_adc_data_receive(
    .adc_gclk        (    a_adc_gclk   ),
	.clk_div         (    clk_div_a    ),
    .rst_IODELAY     (    rst_iodelay  ),
    .rst_SERDES      (    rst_serdes   ),
	 //----------
    .dAp             (    A_P          ),
    .dAn             (    A_N          ),
	 //----------
    .dorp            (    AOR_P        ),
	.dorn            (    AOR_N        ),
	 //----------
	.data            (    dataA        ),
    .data_or         (    data_or[0]   ),
    //-------------
    .load            (    load_r0       )
//    .a_CNTVALUEIN    (    CNTVALUEIN_r0 )
//    .a_CNTVALUEOUT   (    CNTVALUEOUT )	 
    );
//-----通道1-------
UA_adc_data_receive u1_adc_data_receive(
    .adc_gclk        (    a_adc_gclk    ),
	.clk_div         (    clk_div_a     ),	
    .rst_IODELAY     (    rst_iodelay   ),
    .rst_SERDES      (    rst_serdes    ),
    .dAp             (    B_P           ),
    .dAn             (    B_N           ),
	 //----------
	.dorp            (    BOR_P         ),
	.dorn            (    BOR_N         ),
	 //-----------
    .data            (    dataB         ),
    .data_or         (    data_or[1]    ),
    //-------------
    .load            (    load_r1       )
//    .a_CNTVALUEIN    (    CNTVALUEIN_r1 )
//    .a_CNTVALUEOUT   (                  )        	 
    );
//-----通道2-------
UA_adc_data_receive u2_adc_data_receive(
    .adc_gclk        (    a_adc_gclk    ),
	.clk_div         (    clk_div_a     ),
    .rst_IODELAY     (    rst_iodelay   ),
    .rst_SERDES      (    rst_serdes    ),
	 //----------
    .dAp             (    C_P           ),
    .dAn             (    C_N           ),
	 //----------
    .dorp            (    COR_P         ),
	.dorn            (    COR_N         ),
	 //----------
	.data            (    dataC         ),
    .data_or         (    data_or[2]    ),
    //------------
    .load            (    load_r2       )
//    .a_CNTVALUEIN    (    CNTVALUEIN_r2 )
//    .a_CNTVALUEOUT   (                  )              	 
    );
//-----通道3-------
UA_adc_data_receive u3_adc_data_receive(
    .adc_gclk        (    a_adc_gclk    ),
	.clk_div         (    clk_div_a     ),
    .rst_IODELAY     (    rst_iodelay  ),
    .rst_SERDES      (    rst_serdes   ),
	 //----------
    .dAp             (    D_P           ),
    .dAn             (    D_N           ),
	 //----------
	.dorp            (    DOR_P         ),
	.dorn            (    DOR_N         ),
	 //----------
	.data            (    dataD         ),
    .data_or         (    data_or[3]    ),
    //------------
    .load            (    load_r3       )
//    .a_CNTVALUEIN    (    CNTVALUEIN_r3 )
//    .a_CNTVALUEOUT   (                  )           
    );



endmodule
