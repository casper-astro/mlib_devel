module UA_adc_data_receive(
     adc_gclk        ,
	 clk_div         ,
	 rst_IODELAY     ,
	 rst_SERDES      ,
	 //-----------
	 dAp             ,
	 dAn             ,
	 dorp            ,
	 dorn            ,
	 //-----------
	 data            , 
     data_or	     ,
    //-------------
     load            
//     a_CNTVALUEIN    
//     a_CNTVALUEOUT 
    );

//---------
input               adc_gclk; //625M
input               clk_div ; //156.25M
input               rst_IODELAY;
input               rst_SERDES;
//---------
input       [9:0]   dAp     ;
input       [9:0]   dAn     ;
input               dorp    ;
input               dorn    ;
//---------
output  reg [39:0]  data    ;  
output              data_or ;
//----------
input        load;
//input  [8:0] a_CNTVALUEIN;
//output [8:0] a_CNTVALUEOUT;
//////////////////差分转单端/////////////////////////// 
wire [9:0] s_data;
ibufds_wrap_adc
     #(
       .DATA_WIDTH(10)
       )
Inst_ibufds_datain(
		      .din_p(dAp),
		      .din_n(dAn),
		      .dout(s_data)
		      );

ibufds_wrap_adc
     #(
       .DATA_WIDTH(1)
       )
Inst_ibufds_dataor (
		       .din_p(dorp),
		       .din_n(dorn),
		       .dout(data_or)
		       );
/////////////////////IODELAY//////////////////////////
//reg [8:0] CNTVALUEIN_r;
reg  load_r;
always@(posedge clk_div)
begin
//    CNTVALUEIN_r <= a_CNTVALUEIN;
    load_r       <= load;
end

wire [9:0]  data_delay_out;
//wire [89:0] a_CNTVALUEOUT_all;
//--------------IDELAY 0-4-------------
genvar m;
generate for(m=0;m<10;m=m+1)
   begin: iodelay_gen	
      DATA_IDELAY inst_delay (
        .rst            (rst_IODELAY), //*** *** 
        .clk_div        (clk_div),
        .load           (load_r),
        .data_in	    (s_data[m]),
        .data_out		(data_delay_out[m])  
//        .CNTVALUEIN	    (CNTVALUEIN_r) //
//        .CNTVALUEOUT    (a_CNTVALUEOUT_all[m*9+8:m*9])
        ); 
   end
endgenerate
     
//assign a_CNTVALUEOUT = a_CNTVALUEOUT_all[8:0];
//////////////////ISERDES接收数据//////////////////////
wire [39:0] p_data;
genvar i;
generate for(i=0;i<10;i=i+1)
   begin: iserdes_gen
	iserdes_wrap_adc
		  #(
	            .SERDES_RATIO(4)
		    )
	Inst_iserdes_wrap(
			  .rst(rst_SERDES),
			  .clk_div(clk_div),
			  .clk(adc_gclk),
			  .Q(p_data[(i+1)*4-1:i*4]),
			  .D(data_delay_out[i])		  
			  );
     end
endgenerate
//------------data realign--------------
	wire [39:0] p_data_relign;  //9:0 is the first channel

   genvar ii;
   generate 
      for(ii=0;ii<4;ii=ii+1)
	     begin : gen_realign
           assign p_data_relign[(ii+1)*10-1:ii*10] = data_realign(p_data,ii);
	     end
      
   endgenerate

//--------data realign function----------
   function [9:0] data_realign;
      input [39:0] din;
      input [4:0]  offset;
      integer 		 j;
      begin
         for(j=0;j<10;j=j+1)
           data_realign[j] = din[j*4+offset];
      end
   endfunction

//--------data register----------

reg [39:0] data_reg1;
reg [39:0] data_reg2;

always@(posedge clk_div)
begin
	data_reg1 <= p_data_relign;
end

always@(posedge clk_div)
begin
	data_reg2 <= data_reg1;
end

always@(posedge clk_div)
begin
	data <= data_reg2;
end


endmodule

