module ad_spi_cfg
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
    clk             ,
    sys_rst_n       ,		//系统复位
    adc_rst         ,    	//AD复位  低电平有效  
    adc_mosi        ,    	//spi配置AD的数据线      write  
    adc_sen         ,      //spi配置AD的使能信号 
    adc_sclk        ,	   //spi配置AD的时钟  
	adc_miso        ,      //spi配置AD的数据线      read
    adc_sync        ,
    adc_sync_dir    ,	 
	//----------------	 
//    work_mode       ,
//    clk_ctrl        ,      //与AD相关的控制管脚
    cfg_reday                 
	
	);

//=============input output================
input               clk             ;
input               sys_rst_n       ;
//input               work_mode       ;
//input   [1:0]       clk_ctrl        ;
output                 adc_rst      ;    	//AD复位  低电平有效  
output                 adc_mosi     ;    	//spi配置AD的数据线   
output                 adc_sen      ;     //spi配置AD的使能信号 
output                 adc_sclk     ;	   //spi配置AD的时钟 
input                  adc_miso     ;     //AD芯片进入Power Down
output reg             cfg_reday    ;
output                 adc_sync_dir ;
output                 adc_sync     ;

//=============register definition==========
reg [9:0] cnt_fre_divde;
reg clk_spi;

always@(posedge clk or negedge sys_rst_n)
begin
	if(!sys_rst_n)
		begin
			cnt_fre_divde <= 10'd0;
			clk_spi <= 0;
		end
	else if(cnt_fre_divde == 10'd200) //分频倍数200 500KHz
		begin
			cnt_fre_divde <= 10'd1;
			clk_spi <= ~clk_spi;
		end
	else
		begin
			cnt_fre_divde <= cnt_fre_divde + 1;
			clk_spi <= clk_spi;
		end
end              
//=============register definition==========
localparam	                    Idle       = 5'd0,
								Ctr_cfg    = 5'd1,	  Idle1      = 5'd2,	  Test_mode_cfg = 5'd3,	     Idle2       = 5'd4,
								Sync_Y_cfg = 5'd5,	  Idle3      = 5'd6,	  Sel_cfg       = 5'd7,	     Idle4       = 5'd8,
								offset_cfg = 5'd9,	  Idle5      = 5'd10,	  offset_cal    = 5'd11,     offset_Idle = 5'd12,   
								offset_wait= 5'd13,   gain_cfg   = 5'd14,	  Idle6         = 5'd15,     gain_cal    = 5'd16, 
								gain_Idle  = 5'd17,   gain_wait  = 5'd18,     phase_cfg     = 5'd19,     Idle7       = 5'd20,	      
								phase_cal  = 5'd21,   phase_Idle = 5'd22,     phase_wait    = 5'd23,     cfg_wait    = 5'd24,     
								Sync_sig   = 5'd25,   Sync_wait  = 5'd26,     Final         = 5'd27;
localparam	//-----注意地址的最高位控制着读写 高为写 低为读----------
				ADD_STEP1 = 8'h84,				REG_STEP1 = 16'h0001,  //soware reset
				ADD_STEP2 = 8'h81,				ADCMODE   = 4'b0000,   //1000 1 Channel mode (channel A, 5 Gsps) //1100  Common input mode, simultaneous sampling (channel A)
				                                                       //0000 4 Channel mode
				ADD_STEP3 = 8'h85,				REG_STEP3 = 16'h0000,  //test mode 
				ADD_STEP4 = 8'h86,				REG_STEP4 = 16'h000F,  //SYNC register
				//-----------------gain offset phase----------------
				ADD_STEP5 = 8'h8F,				REG_STEP5 = 16'h0001,  //channel selector
				ADD_STEP6 = 8'h90,				REG_STEP6 = 16'h00A8,  //CAL contrl register
				ADD_STEP7 = 8'h11,				/*REG_STEP7 = 16'h0000,*/  //CAL contrl register mail box (read only)
				ADD_STEP8 = 8'h12,				/*REG_STEP8 = 16'h0000,*/  //global status (read only)
				ADD_STEP9 = 8'h93,				REG_STEP9  = 16'h0007,  //trimmer register
				ADD_STEP10 = 8'hA0,				REG_STEP10 = 16'h0200,  //External Offset Registers
				ADD_STEP11 = 8'h21,				/*REG_STEP11 = 16'h0000,*/ //Offset Registers(read only)
				ADD_STEP12 = 8'hA2,				REG_STEP12 = 16'h0200,  //External gain Registers
				ADD_STEP13 = 8'h23,				/*REG_STEP13 = 16'h0000,*/  //gain Registers(read only)
				ADD_STEP14 = 8'hA4,				REG_STEP14 = 16'h0200,  //External phase Registers
				ADD_STEP15 = 8'h25;				/*REG_STEP15 = 16'h0000,*/  //phase Registers(read only)
//=============configuration================
assign   adc_rst = 1;      //active  low
assign   adc_sync_dir = 1; //config SN79 A to B
assign   adc_sync = 0; 
//------start config-------
(* KEEP="TRUE" *)reg config_start;
reg [2:0] conf_cnt;
always@(posedge clk_spi or negedge sys_rst_n)
	if(~sys_rst_n)
		begin
			config_start <= 1'b0;
			conf_cnt     <= 3'd0; 
		end
	else if(conf_cnt < 3'd5)
		begin
			config_start <= 1'b1;
			conf_cnt     <= conf_cnt + 1; 
		end
	else
		begin
			config_start <= 1'b0;
			conf_cnt     <= conf_cnt; 
		end
 
//--------Phase Offset Gain----------
reg [15:0] offset_in[3:0];
reg [15:0] gain_in[3:0];
reg [15:0] phase_in[3:0];

//-----------start config------------
(* KEEP="TRUE" *) wire       spi_Idle_flag;
(* KEEP="TRUE" *) reg        start_spi; 
(* KEEP="TRUE" *) reg [7:0]  config_addr ;
(* KEEP="TRUE" *) reg [15:0] config_data ;
(* KEEP="TRUE" *) reg [4:0]  config_state;
(* KEEP="TRUE" *) reg [9:0]  delay_cnt;
reg [2:0]  index_N;

always @ (posedge clk_spi or negedge sys_rst_n)
begin
	if(~sys_rst_n)
		begin
				config_addr   <= 8'd0;
				config_data   <= 16'd0;
				start_spi     <= 1'b0;
				config_state  <= Idle;		
				cfg_reday     <= 1'b0;
				delay_cnt     <= 10'd0;
				offset_in[0]  <= offset_A; //channelA
				offset_in[1]  <= offset_B; //channelB
				offset_in[2]  <= offset_C; //channelC
				offset_in[3]  <= offset_D; //channelD
				gain_in[0]    <= gain_A; //01D9
				gain_in[1]    <= gain_B; //FIXED
				gain_in[2]    <= gain_C; //01F0
				gain_in[3]    <= gain_D; //FIXED
				phase_in[0]   <= phase_A;
				phase_in[1]   <= phase_B;
				phase_in[2]   <= phase_C;
				phase_in[3]   <= phase_D;
				index_N       <= 3'd0;				
		end
	else case(config_state)
		Idle:
		begin
				if(config_start & spi_Idle_flag)
					begin
						config_state  <= Ctr_cfg;
						cfg_reday     <= 0;
					end
				else
					begin
						config_state  <= Idle;	
						cfg_reday     <= cfg_reday;
					end
				start_spi  <= 1'b0;
				delay_cnt  <= 10'd0;
				index_N    <= 3'd0;
		end
		Ctr_cfg:
		begin  
				if(spi_Idle_flag) 
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP2;    //contrl register
						config_data   <= {3'd0,outmode,8'd0,adcmode}; //channel A
						//config_data   <= REG_STEP2;
						config_state  <= Ctr_cfg;
					end
				else 
					begin
						config_state  <= Idle1;
					end
		end
		Idle1:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= Sync_Y_cfg; 
					end
				else 
					begin
						config_state  <= Idle1;
					end	
				start_spi     <= 0;
		end
//------------------------------------------------------
//		Test_mode_cfg:
//		begin
//				if(spi_Idle_flag)
//					begin
//						start_spi     <= 1;
//						config_addr   <= ADD_STEP3;   //test mode 
//						config_data   <= REG_STEP3;
//						config_state  <= Test_mode_cfg;
//					end
//				else 
//					begin
//						config_state  <= Idle2;
//					end	
//		end
//		Idle2:
//		begin
//				if(spi_Idle_flag)
//					begin
//						config_state  <= Sync_Y_cfg;
//					end
//				else 
//					begin
//						config_state  <= Idle2;
//					end	
//				start_spi     <= 0;
//		end
//----------------------------------------------------------------------
	   Sync_Y_cfg:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP4;  //SYNC register
						config_data   <= REG_STEP4;
						config_state  <= Sync_Y_cfg;
					end
				else 
					begin
						config_state  <= Idle3;
					end	
		end
      Idle3:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= Sel_cfg;  //
					end
				else 
					begin
						config_state  <= Idle3;
					end	
				start_spi     <= 0;
		end
		//---------------------channel config--------------------------
		Sel_cfg:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP5;  //channel select
						config_data   <= REG_STEP5 + {13'd0,index_N};
						config_state  <= Sel_cfg;
					end
				else 
					begin
						config_state  <= Idle4;
					end		
		end
		Idle4:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= offset_cfg;
					end
				else 
					begin
						config_state  <= Idle4;
					end	
				start_spi     <= 0;
		end
		//-----------------------------
		offset_cfg:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP10;  //offset  config
						config_data   <= offset_in[index_N];
						config_state  <= offset_cfg;
					end
				else 
					begin
						config_state  <= Idle5;
					end		
		end
		Idle5:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= offset_cal; 
					end
				else 
					begin
						config_state  <= Idle5;
					end	
				start_spi     <= 0;
		end
		offset_cal:
		begin
		      if(spi_Idle_flag)
                 begin
                    start_spi     <= 1;
                    config_addr   <= ADD_STEP6;  //****************CAL control register
                    config_data   <= 16'h0008;
                    config_state  <= offset_cal;
                 end
              else 
                 begin
                    config_state  <= offset_Idle;
                 end        
		end
		offset_Idle:
		begin
                if(spi_Idle_flag)
                    begin
                        config_state  <= offset_wait;
                    end
                else 
                    begin
                        config_state  <= offset_Idle;
                    end    
                start_spi     <= 0;
        end
       offset_wait:
       begin
            if(delay_cnt[9]==1)
                begin
                    delay_cnt <= 10'd0;
                    config_state <= gain_cfg;
                end
            else
                begin
                  delay_cnt <= delay_cnt +1;
                  config_state <= offset_wait;  
                end
       end        		
		gain_cfg:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP12;  //gain config
						config_data   <= gain_in[index_N];
						config_state  <= gain_cfg;
					end
				else 
					begin
						config_state  <= Idle6;
					end		
		end
		Idle6:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= gain_cal;
					end
				else 
					begin
						config_state  <= Idle6;
					end	
				start_spi     <= 0;
		end		
		gain_cal:
        begin
              if(spi_Idle_flag)
                 begin
                    start_spi     <= 1;
                    config_addr   <= ADD_STEP6;  //****************CAL control register
                    config_data   <= 16'h0020;
                    config_state  <= gain_cal;
                 end
              else 
                 begin
                    config_state  <= gain_Idle;
                 end        
        end
        gain_Idle:
        begin
                if(spi_Idle_flag)
                    begin
                        config_state  <= gain_wait;
                    end
                else 
                    begin
                        config_state  <= gain_Idle;
                    end    
                start_spi     <= 0;
        end 
       gain_wait:
         begin
              if(delay_cnt[9]==1)
                  begin
                      delay_cnt <= 10'd0;
                      config_state <= phase_cfg;
                  end
              else
                  begin
                      delay_cnt <= delay_cnt +1;
                      config_state <= gain_wait;  
                  end
         end                                   				
		phase_cfg:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP14;  //phase config
						config_data   <= phase_in[index_N];
						config_state  <= phase_cfg;
					end
				else 
					begin
						config_state  <= Idle7;
					end		
		end
		Idle7:
		begin
				if(spi_Idle_flag)
					begin
						config_state  <= phase_cal;
					end
				else 
					begin
						config_state  <= Idle7;
					end	
				start_spi     <= 0;
		end
		phase_cal:
		begin
				if(spi_Idle_flag)
					begin
						start_spi     <= 1;
						config_addr   <= ADD_STEP6;  //****************CAL control register
						config_data   <= 16'h0080;
						config_state  <= phase_cal;
					end
				else 
					begin
						config_state  <= phase_Idle;
					end		
		end
        phase_Idle:
        begin
                if(spi_Idle_flag)
                    begin
                        config_state  <= phase_wait;
                    end
                else 
                    begin
                        config_state  <= phase_Idle;
                    end    
                start_spi     <= 0;
        end 		
		phase_wait:
		begin
				if(delay_cnt[9]==1)
					begin
					    delay_cnt <= 10'd0;
						if(index_N==3'd3)
							begin
								config_state  <= Final;
							end
						else
							begin
								config_state  <= Sel_cfg;
								index_N <= index_N + 1;
							end
					end
				else 
					begin
						config_state  <= phase_wait;
						delay_cnt <= delay_cnt +1;
					end	
				start_spi     <= 0;
		end	
//--------------------------------------------------------------	
//		cfg_wait:
//		begin
//			    if(work_mode == 1'b1)              // wait for sync 
//					begin
//					    cfg_reday     <= 1'b0;
//						config_state  <= Sync_sig;
//					end
//				else 
//					begin
//						config_state  <= cfg_wait;
//						cfg_reday     <= 1'b1;
//					end		
//		end
////--------------------------------------------------------------
//      Sync_sig:
//		begin
//				 if(spi_Idle_flag) 
//                            begin
//                                start_spi     <= 1;
//                                config_addr   <= ADD_STEP2;    //contrl register
//                                config_data   <= {3'd0,1'd0,8'd0,ADCMODE}; //channel A
//                                //config_data   <= REG_STEP2;
//                                config_state  <= Sync_sig;
//                            end
//                 else 
//                            begin
//                                config_state  <= Sync_wait;
//                            end
//		end 
//		Sync_wait:
//		begin
//				 if(spi_Idle_flag)
//                     begin
//                         config_state  <= Final; 
//                     end
//                 else 
//                     begin
//                          config_state  <= Sync_wait;
//                     end    
//                        start_spi     <= 0;
//		end
		Final:
		begin
		       config_state  <= Final; 
		       cfg_reday     <= 1'b1;  
		end
		default:
		begin
				config_addr   <= 8'd0;
				config_data   <= 16'd0;
				start_spi     <= 1'b0;
				config_state  <= Idle;		
				cfg_reday     <= 1'b0;
				delay_cnt     <= 10'd0;
				offset_in[0]  <= offset_A; //channelA
                offset_in[1]  <= offset_B; //channelB
                offset_in[2]  <= offset_C; //channelC
                offset_in[3]  <= offset_D; //channelD
                gain_in[0]    <= gain_A; // 
                gain_in[1]    <= gain_B; // 
                gain_in[2]    <= gain_C; // 
                gain_in[3]    <= gain_D; // 
                phase_in[0]   <= phase_A;
                phase_in[1]   <= phase_B;
                phase_in[2]   <= phase_C;
                phase_in[3]   <= phase_D;
                index_N       <= 3'd0;            
		end
	endcase
end


//----------------vio select-----------------
	wire [7:0]  config_addr_sel;
	wire [15:0] config_data_sel;
	wire        start_spi_sel;
	
	assign  config_addr_sel = config_addr;
	assign  config_data_sel = config_data;
	assign  start_spi_sel   = start_spi;
	
//----------------------data transmit-----------------------
(* KEEP="TRUE" *)	wire [15:0] data_rd_out;
(* KEEP="TRUE" *)	wire        data_rd_rdy;
//(* KEEP="TRUE" *)	wire        adc_sclk_out;

   data_transmit_spi ad_spi_data (
				      .clk(clk_spi), 
				      .reset(~sys_rst_n), 
				      .reg_addr(config_addr_sel), 
				      .config_value(config_data_sel), 
				      .start_spi(start_spi_sel), 
				      .data_read_out(data_rd_out), 
				      .data_read_rdy(data_rd_rdy),
					  .Idle_flag(spi_Idle_flag),
				      .spi_miso_i(adc_miso), 
				      .spi_sclk_o(adc_sclk), 
				      .spi_mosi_o(adc_mosi), 
				      .spi_csb_o (adc_sen)
						);						
//------------spi_clk delay------------------
//parameter DELAY = 10;

//reg adc_sclk_delay[39:0];

//always@(posedge clk200m)
//begin
//	adc_sclk_delay[0] <= adc_sclk_out;
//end

//genvar 		i;  
//generate for(i=0;i<DELAY;i=i+1)
//	begin: spi_clk_delay

//		always@(posedge clk200m)
//			begin
//				adc_sclk_delay[i+1] <= adc_sclk_delay[i];
//			end
//	end
//endgenerate	

//always@(posedge clk200m)
//begin
//	adc_sclk <= adc_sclk_delay[DELAY];
//end



endmodule 