module snapshot #(
    parameter integer DATA_WIDTH = 32,
    parameter integer ADDR_WIDTH = 10
) (
    input                       clk,
    input                       rst,
    input  [DATA_WIDTH-1:0]     din,
    input                       we,
    input                       trig,
    input                       arm,
    output                      busy,
    output reg                  done,
    output [ADDR_WIDTH-1:0]     mem_addr,
    output [DATA_WIDTH-1:0]     mem_wdat,
    output                      mem_we
);

    localparam integer DEPTH = (1 << ADDR_WIDTH);
    localparam [ADDR_WIDTH-1:0] LAST_ADDR = DEPTH - 1;

    reg [DATA_WIDTH-1:0] din_d1;
    reg [DATA_WIDTH-1:0] din_d2;
    reg                  we_d1;
    reg                  we_d2;
    reg                  trig_d1;
    reg                  arm_d1;

    reg                  armed;
    reg                  capture_active;
    reg [ADDR_WIDTH-1:0] sample_count;

    wire arm_rise;
    wire start_capture;
    wire write_sample;
    wire last_sample;

    assign busy          = capture_active;
    assign arm_rise      = arm & ~arm_d1;
    assign start_capture = armed & trig_d1;
    assign write_sample  = capture_active & we_d2;
    assign last_sample   = write_sample & (sample_count == LAST_ADDR);
    assign mem_addr      = sample_count;
    assign mem_wdat      = din_d2;
    assign mem_we        = write_sample;

    // Delay the incoming stream so the BRAM write pointer can be reset on the
    // trigger cycle and still store the first captured sample at address 0.
    always @(posedge clk) begin
        if (rst) begin
            din_d1   <= {DATA_WIDTH{1'b0}};
            din_d2   <= {DATA_WIDTH{1'b0}};
            we_d1    <= 1'b0;
            we_d2    <= 1'b0;
            trig_d1  <= 1'b0;
            arm_d1   <= 1'b0;
        end else begin
            din_d1   <= din;
            din_d2   <= din_d1;
            we_d1    <= we;
            we_d2    <= we_d1;
            trig_d1  <= trig;
            arm_d1   <= arm;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            armed          <= 1'b0;
            capture_active <= 1'b0;
            sample_count   <= {ADDR_WIDTH{1'b0}};
            done           <= 1'b0;
        end else begin
            if (arm_rise) begin
                armed <= 1'b1;
                done  <= 1'b0;
            end

            if (start_capture) begin
                armed          <= 1'b0;
                capture_active <= 1'b1;
                sample_count   <= {ADDR_WIDTH{1'b0}};
            end else if (write_sample) begin
                sample_count <= sample_count + 1'b1;
                if (last_sample) begin
                    capture_active <= 1'b0;
                    done           <= 1'b1;
                end
            end
        end
    end

endmodule
