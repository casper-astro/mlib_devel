module adc_serial_setup (
  fsclk,
  reset,
  setup_done,
  sdata,
  scs,
  calibration_done
);


input fsclk;
input reset;
output setup_done;
output sdata;
output scs;
input calibration_done;

parameter fixed_header_pattern = 12'h1;
reg [31:0] word;
reg write_start;
wire word_write_done;

  adc083000_spi adc083000_spi (
    .clock(fsclk), 
    .reset(reset), 
    .done(word_write_done), 
    .sdata(sdata), 
    .word(word),
    .scs(scs), 
    .start(write_start) 
  );
   
  parameter state_idle = 4'd0;
  parameter state_write_configuration = 4'd1;
  parameter state_write_offset = 4'd2;
  parameter state_voltage_adjust = 4'd3;
  parameter state_write_phase_fine = 4'd4;
  parameter state_write_phase_coarse = 4'd5;
  parameter state_write_test_pattern = 4'd6;
  parameter state_done = 4'd7;
  
  reg [3:0] state, next_state;
  always @ (posedge fsclk) begin
    if (reset) begin
      state <= state_idle;
    end else begin
      state <= next_state;
    end
  end
  
  always @ ( * ) begin
    write_start = 1'b0;
    word = 32'h0;
    
    case (state)
      state_idle: begin
        if (calibration_done)
          next_state = state_write_configuration;
      end
      
      state_write_configuration: begin
        write_start = 1;
        word = {fixed_header_pattern, 4'h1, 16'h92ff};
        if (word_write_done) begin
          write_start = 0;
          next_state = state_write_offset;
        end
      end
      
      state_write_offset: begin
        write_start = 1;
        word = {fixed_header_pattern, 4'h2, 16'h007f};
        if (word_write_done) begin
          write_start = 0;
          next_state = state_voltage_adjust;
        end
      end
      
      state_voltage_adjust: begin
        write_start = 1;
        word = {fixed_header_pattern, 4'h3, 16'h807f};
        if (word_write_done) begin
          write_start = 0;
          next_state = state_write_phase_fine;
        end
      end
      
      state_write_phase_fine: begin
        word = {fixed_header_pattern, 4'hC, 16'h007f};
        write_start = 1;
        if (word_write_done) begin
          write_start = 0;
          next_state = state_write_phase_coarse;
        end
      end
      
      state_write_phase_coarse: begin
        word = {fixed_header_pattern, 4'hD, 16'h03ff};
        write_start = 1;
        if (word_write_done) begin
          write_start = 0;
          next_state = state_write_test_pattern;
        end
      end
      
      state_write_test_pattern: begin
        write_start = 1;
        word = {fixed_header_pattern, 4'hF, 16'hffff};
        if (word_write_done) begin
          write_start = 0;
          next_state = state_done;
        end
      end
      
      state_done: begin
        next_state = state_done;
      end
      
      default: begin
        next_state = state_idle;
      end
    endcase
  end
  
endmodule
  
