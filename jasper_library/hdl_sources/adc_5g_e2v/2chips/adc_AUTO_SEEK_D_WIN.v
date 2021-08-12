`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:12 04/18/2013 
// Design Name: 
// Module Name:    AUTO_SEEK_D_WIN 
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
module adc_AUTO_SEEK_D_WIN 
    (
	gclk10m_buf,
    rst,
    //---------
    auto_seek_rst,
    auto_spi_rstn,   //ADC chip rst
//    work_mode,    
    adc_ready,       
    adc_ddrrst,
//    bufg_rst,
     //---------
    win_ok_all,
    //----------
    sync_flag
//    sync_flag_all
//    data_sync_all,
//    data_sync_flag,
//    win_ok
    );
//========================================
    input      rst;
    input      gclk10m_buf;
    //---------------------
    output reg  auto_seek_rst;
    output reg  adc_ddrrst;
//    output reg  bufg_rst;
    output reg  auto_spi_rstn;
//    output reg  work_mode;
    input       adc_ready;
    //----------------------    
    output reg win_ok_all;
    //-----------------------
    output reg sync_flag;
//    output reg win_ok;
//    input sync_flag_all;
//    input data_sync_flag;
//    input data_sync_all;    
//------------debug------------
    

///////////////////////////////////////////////////////////////////////////////////////////////        
reg [4:0]   seek_win_state ; 
reg [15:0]  delay_cnt      ;
reg [7:0]   sync_cnt       ;
//reg         win_ok         ;
//-------------state machine------------
localparam IDEL                     = 5'd0 ;
//--------------------
localparam SYNC_POPWER              = 5'd1 ;
//localparam SYNC_ALL_POWER           = 5'd2 ;
localparam SYNC_POWER_WAIT1         = 5'd3 ;
localparam SYNC_POWER_WAIT2         = 5'd4 ;
//--------------------
localparam INIT_CLKMODE_SET_PARA    = 5'd5 ;
localparam INIT_AD_CONF_DELAY       = 5'd6 ;
//---------------------
localparam SYNC_RST                 = 5'd7;
//localparam SYNC_RST_ALL             = 5'd8;
localparam SYNC_WAIT1               = 5'd9;
localparam SYNC_WAIT2               = 5'd10;
localparam BUFG_WAIT1               = 5'd11;
//--------------------- 
localparam INIT_DVALUE_WAIT_PARA    = 5'd12 ;
localparam INIT_DVALUE_DELAY        = 5'd13;  
//localparam SETCLKIDELAY_D           = 5'd14;
//------------------------------------------
//localparam WIN_OK_ALL               = 5'd15;
//localparam SYNC_WAIT3               = 5'd16;
//localparam SYNC_DATA                = 5'd17;  
////------------------------------------------
//localparam AD_RESET                 = 5'd18;
//localparam AD_DELAY                 = 5'd19;
////------------------------------------------  
// localparam SERDES_DELAY            = 5'd20;
 localparam NORMAL_OP               = 5'd15;
//------------------------------------------
    
     
always@(posedge gclk10m_buf or posedge rst)
if(rst)  
    begin 
        seek_win_state  <=IDEL;
        
        auto_seek_rst   <=1; //   IOdelay 复位
        auto_spi_rstn   <=0; //   AD配置模块复位
        adc_ddrrst      <=1; //   接收数据模块复位
//        bufg_rst        <=1; //   bufg复位 
                     
        win_ok_all      <=0;
//        win_ok          <=0;
        delay_cnt       <=16'd0;            
//        work_mode       <=1'b0;                             
        sync_flag       <=0; 
        sync_cnt        <= 8'd0;  
    end
else
    case(seek_win_state)
         IDEL:
                        begin   
                            seek_win_state  <= SYNC_POPWER;
                            auto_seek_rst   <=1;   //IOdelay 结束复位
                            auto_spi_rstn   <=0;   //AD配置模块复位
                            adc_ddrrst      <=1;   //接收数据复位无效 
//                            bufg_rst        <=1; //   bufg复位
                            
                            win_ok_all      <=0;
//                            win_ok          <=0;
                            delay_cnt       <=16'd0;                           
//                            work_mode       <=1'b0;  
                            sync_flag       <=0;  
                        end    
       //------------------powerup sync--------------------- 
          SYNC_POPWER:
                          begin
                              sync_flag <= 1;
                              seek_win_state  <=SYNC_POWER_WAIT1;
                          end
//          SYNC_ALL_POWER:
//                          begin
//                              if(sync_flag_all)
//                                  begin
//                                      seek_win_state  <=SYNC_POWER_WAIT1;
//                                  end
//                              else
//                                  begin
//                                      seek_win_state  <=SYNC_ALL_POWER;
//                                  end
//                          end
           SYNC_POWER_WAIT1:
                          begin
                              if(delay_cnt[4] == 1)
                                  begin
                                      seek_win_state  <=SYNC_POWER_WAIT2; 
                                      delay_cnt <= 16'd0;
                                      sync_flag <= 0;
                                  end
                              else
                                  begin
                                     delay_cnt <= delay_cnt +1; 
                                     seek_win_state  <=SYNC_POWER_WAIT1; 
                                  end
                          end   
             SYNC_POWER_WAIT2:
                          begin
                             if(delay_cnt[8] == 1)
                                  begin
                                      seek_win_state  <=INIT_CLKMODE_SET_PARA; 
                                      delay_cnt <= 16'd0;
                                  end
                             else
                                  begin
                                      seek_win_state  <=SYNC_POWER_WAIT2; 
                                      delay_cnt <= delay_cnt +1;                               
                                  end                 
                          end
    //------------------------------------------------------------             
    INIT_CLKMODE_SET_PARA:
                   begin 
                        if(sync_cnt == 8'd3)
                        begin
                            seek_win_state  <=INIT_AD_CONF_DELAY;
                            auto_spi_rstn   <=1;      //AD配置复位无效，开始配置AD芯片 
                            sync_cnt        <= 8'd0; 
                        end
                        else
                        begin
                            seek_win_state  <=SYNC_POPWER;
                            sync_cnt        <= sync_cnt +1;
                        end                                                                                                 
                   end
     INIT_AD_CONF_DELAY:
                    begin 
                       if(adc_ready) //延时等待256个10M时钟周期 等待AD配置完成，接收数据模块复位完成
                           begin
                           seek_win_state  <=SYNC_RST;
                           end
                       else
                           begin
                           seek_win_state  <=INIT_AD_CONF_DELAY;
                           end
                   end  
    //------------------sync--------------------- 
    SYNC_RST:
                    begin
                        sync_flag <= 1;
                        seek_win_state  <=SYNC_WAIT1;
                    end
//    SYNC_RST_ALL:
//                    begin
//                        if(sync_flag_all)
//                            begin
//                                seek_win_state  <=SYNC_WAIT1;
//                            end
//                        else
//                            begin
//                                seek_win_state  <=SYNC_RST_ALL;
//                            end
//                    end
     SYNC_WAIT1:
                    begin
                        if(delay_cnt[4] == 1)
                            begin
                                seek_win_state  <=SYNC_WAIT2; 
                                delay_cnt <= 16'd0;
                                sync_flag <= 0;
                            end
                        else
                            begin
                               delay_cnt <= delay_cnt +1; 
                               seek_win_state  <=SYNC_WAIT1; 
                            end
                    end   
       SYNC_WAIT2:
                    begin
                       if(delay_cnt[8] == 1)
                            begin
                                seek_win_state  <= BUFG_WAIT1; 
                                delay_cnt <= 16'd0;
                            end
                       else
                            begin
                                seek_win_state  <=SYNC_WAIT2; 
                                delay_cnt <= delay_cnt +1;                               
                            end                 
                    end 
       BUFG_WAIT1:
                    begin
                       if(sync_cnt == 8'd3)
                             begin
                                 seek_win_state  <= INIT_DVALUE_WAIT_PARA; 
                                 sync_cnt <= 8'd0;
//                                 bufg_rst  <= 0; //   bufg复位
                             end
                        else
                             begin
                                 seek_win_state  <=SYNC_RST; 
                                 sync_cnt <= sync_cnt +1;                               
                             end                         
                   end                           
    //-------------------------------------------                              
    INIT_DVALUE_WAIT_PARA:
                   begin 
                       if(delay_cnt[8] == 1)
                       begin
                            auto_seek_rst   <= 0; //IOdelay 复位结束
                            seek_win_state  <= INIT_DVALUE_DELAY;
                            delay_cnt <= 8'd0;
                       end
                       else
                       begin
                           seek_win_state  <= INIT_DVALUE_WAIT_PARA;
                           delay_cnt <= delay_cnt +1;
                       end
                       
                   end
    INIT_DVALUE_DELAY:
                   begin 
                       if(delay_cnt[9]==1) //延时等待512个10M时钟周期 ,接收数据模块复位完成
                           begin
                           delay_cnt       <=16'd0; 
                           seek_win_state  <=NORMAL_OP;
                           adc_ddrrst      <=0;
                           end
                       else
                           begin
                           delay_cnt       <=delay_cnt+1; 
                           seek_win_state  <=INIT_DVALUE_DELAY;
                           end
                   end                 
//    SETCLKIDELAY_D   :
//                  if(delay_cnt[9]==1) //延时保证IOdelay正常工作,ADC采到的数据也已调整正常
//                       begin
//                           delay_cnt       <=16'd0; 
//                           seek_win_state  <=NORMAL_OP; // WIN_OK_ALL
////                           win_ok          <=1;
//                       end
//                  else
//                       begin                          
//                           delay_cnt       <=delay_cnt+1; 
//                           seek_win_state  <=SETCLKIDELAY_D;
//                       end
    //--------------------------------------
//     WIN_OK_ALL:
//                 begin
//                       if(data_sync_all)
//                           begin
//                               seek_win_state  <=SYNC_WAIT3;
//                           end
//                       else
//                           begin
//                               seek_win_state  <=WIN_OK_ALL;
//                           end
//                 end
//         SYNC_WAIT3:
//                 begin
//                                 if(delay_cnt[9] == 1)
//                                     begin
//                                         seek_win_state  <=SYNC_DATA; 
//                                         delay_cnt <= 16'd0;
//                                     end
//                                 else
//                                     begin
//                                        delay_cnt       <= delay_cnt +1; 
//                                        seek_win_state  <=SYNC_WAIT3; 
//                                     end
//               end 
//          SYNC_DATA:
//                  begin
//                       if(data_sync_flag == 1)
//                          begin
//                              seek_win_state  <= AD_RESET; 
//                          end
//                       else
//                          begin
//                               seek_win_state  <= SYNC_RST; 
//                               auto_seek_rst   <=1;   //IOdelay 结束复位
//                               adc_ddrrst      <=1;   //接收数据复位无效 
//                               bufg_rst        <=1; //   bufg复位
                               
//                               win_ok_all      <=0;
//                               win_ok          <=0;
//                               delay_cnt       <=16'd0;                           
//                               work_mode       <=1'b0;   //0: normalwork      1:test mode                              
//                          end                  
//                  end                                               
//     //-------------------------------------
//     AD_RESET:
//                    begin
//                        auto_seek_rst   <=0; //   IOdelay 复位     //*** ***
//                        adc_ddrrst      <=0; //   接收数据模块复位 //*** ***
//                        bufg_rst        <=0; //   bufg复位         //*** ***
//                        if(delay_cnt[7]==1 ) 
//                            begin
//                                seek_win_state  <= AD_DELAY;
//                                delay_cnt       <=16'd0;                                
//                                work_mode       <=1'b0;   //*** ***                                                                 
//                            end
//                        else
//                            begin
//                                seek_win_state  <= AD_RESET;
//                                work_mode       <=1'b1;  //*** ***
//                                delay_cnt       <=delay_cnt+1;                              
//                            end
//                    end
//     AD_DELAY:
//                   begin 
//                       if(adc_ready) //延时等待AD配置完成
//                           begin
//                           seek_win_state  <=SERDES_DELAY; 
//                           end
//                       else
//                           begin 
//                           seek_win_state  <=AD_DELAY;
//                           end
//                   end 
////------------------------------------------------------------                       
//        SERDES_DELAY:
//                   begin 
//                       if(delay_cnt[8]==1) //等待IESRDES已经调整完毕
//                           begin
//                           seek_win_state  <=NORMAL_OP;
//                           delay_cnt<=16'd0;
//                           end
//                       else
//                           begin
//                           delay_cnt       <=delay_cnt+1; 
//                           seek_win_state  <=SERDES_DELAY;
//                           end
//                   end              
     //------------------------------------
    NORMAL_OP:                         
                    begin 
                           win_ok_all      <=1;
                           seek_win_state  <=NORMAL_OP;  
                    end  
    default:
        begin
                seek_win_state  <=IDEL;
                
                auto_seek_rst   <=1; //   IOdelay 复位
                auto_spi_rstn   <=0; //   AD配置模块复位
                adc_ddrrst      <=1; //   接收数据模块复位
//                bufg_rst        <=1; //   bufg复位 
                             
                win_ok_all      <=0;
//                win_ok          <=0;
                delay_cnt       <=16'd0;            
//                work_mode       <=1'b0;                             
                sync_flag       <=0;  
                sync_cnt        <= 8'd0;
        end
    endcase
                 

//wire [4:0] list;
//assign  list = seek_win_state_a & seek_win_state_b &seek_win_state_c;
//assign test_sign=detectOK & first_win_v & end_win_v & win_ok & seek_over;//list[0]&list[1]&list[2]&list[3]&list[4];    
 
endmodule
