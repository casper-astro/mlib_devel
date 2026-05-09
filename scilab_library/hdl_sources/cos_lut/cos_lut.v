// 1024-phase coherent cosine source for FFT debug.
// TONE_BIN selects the number of cosine cycles per 1024 output samples.
module cos_lut #(
    parameter OUTPUT_WIDTH = 16,
    parameter FFT_LENGTH = 1024,
    parameter TONE_BIN = 1,
    parameter AMPLITUDE = 32767
)(
    input clk,
    input rst,
    input en,
    output reg signed [OUTPUT_WIDTH-1:0] out
);

    localparam [9:0] PHASE_STEP = TONE_BIN % 1024;
    localparam signed [31:0] AMPLITUDE_SIGNED = AMPLITUDE;

    reg [9:0] phase1024;
    wire [1:0] quadrant = phase1024[9:8];
    wire [7:0] phase_in_quad = phase1024[7:0];
    wire [8:0] rom_addr = (quadrant[0] == 1'b0) ? {1'b0, phase_in_quad} : (9'd256 - {1'b0, phase_in_quad});

    reg signed [15:0] rom_value;
    reg signed [16:0] signed_rom_value;
    reg signed [47:0] scaled_value;
    reg signed [31:0] clipped_value;

    always @* begin
        case (rom_addr)
            9'd0: rom_value = 16'sd0;
            9'd1: rom_value = 16'sd201;
            9'd2: rom_value = 16'sd402;
            9'd3: rom_value = 16'sd603;
            9'd4: rom_value = 16'sd804;
            9'd5: rom_value = 16'sd1005;
            9'd6: rom_value = 16'sd1206;
            9'd7: rom_value = 16'sd1407;
            9'd8: rom_value = 16'sd1608;
            9'd9: rom_value = 16'sd1809;
            9'd10: rom_value = 16'sd2009;
            9'd11: rom_value = 16'sd2210;
            9'd12: rom_value = 16'sd2410;
            9'd13: rom_value = 16'sd2611;
            9'd14: rom_value = 16'sd2811;
            9'd15: rom_value = 16'sd3012;
            9'd16: rom_value = 16'sd3212;
            9'd17: rom_value = 16'sd3412;
            9'd18: rom_value = 16'sd3612;
            9'd19: rom_value = 16'sd3811;
            9'd20: rom_value = 16'sd4011;
            9'd21: rom_value = 16'sd4210;
            9'd22: rom_value = 16'sd4410;
            9'd23: rom_value = 16'sd4609;
            9'd24: rom_value = 16'sd4808;
            9'd25: rom_value = 16'sd5007;
            9'd26: rom_value = 16'sd5205;
            9'd27: rom_value = 16'sd5404;
            9'd28: rom_value = 16'sd5602;
            9'd29: rom_value = 16'sd5800;
            9'd30: rom_value = 16'sd5998;
            9'd31: rom_value = 16'sd6195;
            9'd32: rom_value = 16'sd6393;
            9'd33: rom_value = 16'sd6590;
            9'd34: rom_value = 16'sd6786;
            9'd35: rom_value = 16'sd6983;
            9'd36: rom_value = 16'sd7179;
            9'd37: rom_value = 16'sd7375;
            9'd38: rom_value = 16'sd7571;
            9'd39: rom_value = 16'sd7767;
            9'd40: rom_value = 16'sd7962;
            9'd41: rom_value = 16'sd8157;
            9'd42: rom_value = 16'sd8351;
            9'd43: rom_value = 16'sd8545;
            9'd44: rom_value = 16'sd8739;
            9'd45: rom_value = 16'sd8933;
            9'd46: rom_value = 16'sd9126;
            9'd47: rom_value = 16'sd9319;
            9'd48: rom_value = 16'sd9512;
            9'd49: rom_value = 16'sd9704;
            9'd50: rom_value = 16'sd9896;
            9'd51: rom_value = 16'sd10087;
            9'd52: rom_value = 16'sd10278;
            9'd53: rom_value = 16'sd10469;
            9'd54: rom_value = 16'sd10659;
            9'd55: rom_value = 16'sd10849;
            9'd56: rom_value = 16'sd11039;
            9'd57: rom_value = 16'sd11228;
            9'd58: rom_value = 16'sd11417;
            9'd59: rom_value = 16'sd11605;
            9'd60: rom_value = 16'sd11793;
            9'd61: rom_value = 16'sd11980;
            9'd62: rom_value = 16'sd12167;
            9'd63: rom_value = 16'sd12353;
            9'd64: rom_value = 16'sd12539;
            9'd65: rom_value = 16'sd12725;
            9'd66: rom_value = 16'sd12910;
            9'd67: rom_value = 16'sd13094;
            9'd68: rom_value = 16'sd13279;
            9'd69: rom_value = 16'sd13462;
            9'd70: rom_value = 16'sd13645;
            9'd71: rom_value = 16'sd13828;
            9'd72: rom_value = 16'sd14010;
            9'd73: rom_value = 16'sd14191;
            9'd74: rom_value = 16'sd14372;
            9'd75: rom_value = 16'sd14553;
            9'd76: rom_value = 16'sd14732;
            9'd77: rom_value = 16'sd14912;
            9'd78: rom_value = 16'sd15090;
            9'd79: rom_value = 16'sd15269;
            9'd80: rom_value = 16'sd15446;
            9'd81: rom_value = 16'sd15623;
            9'd82: rom_value = 16'sd15800;
            9'd83: rom_value = 16'sd15976;
            9'd84: rom_value = 16'sd16151;
            9'd85: rom_value = 16'sd16325;
            9'd86: rom_value = 16'sd16499;
            9'd87: rom_value = 16'sd16673;
            9'd88: rom_value = 16'sd16846;
            9'd89: rom_value = 16'sd17018;
            9'd90: rom_value = 16'sd17189;
            9'd91: rom_value = 16'sd17360;
            9'd92: rom_value = 16'sd17530;
            9'd93: rom_value = 16'sd17700;
            9'd94: rom_value = 16'sd17869;
            9'd95: rom_value = 16'sd18037;
            9'd96: rom_value = 16'sd18204;
            9'd97: rom_value = 16'sd18371;
            9'd98: rom_value = 16'sd18537;
            9'd99: rom_value = 16'sd18703;
            9'd100: rom_value = 16'sd18868;
            9'd101: rom_value = 16'sd19032;
            9'd102: rom_value = 16'sd19195;
            9'd103: rom_value = 16'sd19357;
            9'd104: rom_value = 16'sd19519;
            9'd105: rom_value = 16'sd19680;
            9'd106: rom_value = 16'sd19841;
            9'd107: rom_value = 16'sd20000;
            9'd108: rom_value = 16'sd20159;
            9'd109: rom_value = 16'sd20317;
            9'd110: rom_value = 16'sd20475;
            9'd111: rom_value = 16'sd20631;
            9'd112: rom_value = 16'sd20787;
            9'd113: rom_value = 16'sd20942;
            9'd114: rom_value = 16'sd21096;
            9'd115: rom_value = 16'sd21250;
            9'd116: rom_value = 16'sd21403;
            9'd117: rom_value = 16'sd21554;
            9'd118: rom_value = 16'sd21705;
            9'd119: rom_value = 16'sd21856;
            9'd120: rom_value = 16'sd22005;
            9'd121: rom_value = 16'sd22154;
            9'd122: rom_value = 16'sd22301;
            9'd123: rom_value = 16'sd22448;
            9'd124: rom_value = 16'sd22594;
            9'd125: rom_value = 16'sd22739;
            9'd126: rom_value = 16'sd22884;
            9'd127: rom_value = 16'sd23027;
            9'd128: rom_value = 16'sd23170;
            9'd129: rom_value = 16'sd23311;
            9'd130: rom_value = 16'sd23452;
            9'd131: rom_value = 16'sd23592;
            9'd132: rom_value = 16'sd23731;
            9'd133: rom_value = 16'sd23870;
            9'd134: rom_value = 16'sd24007;
            9'd135: rom_value = 16'sd24143;
            9'd136: rom_value = 16'sd24279;
            9'd137: rom_value = 16'sd24413;
            9'd138: rom_value = 16'sd24547;
            9'd139: rom_value = 16'sd24680;
            9'd140: rom_value = 16'sd24811;
            9'd141: rom_value = 16'sd24942;
            9'd142: rom_value = 16'sd25072;
            9'd143: rom_value = 16'sd25201;
            9'd144: rom_value = 16'sd25329;
            9'd145: rom_value = 16'sd25456;
            9'd146: rom_value = 16'sd25582;
            9'd147: rom_value = 16'sd25708;
            9'd148: rom_value = 16'sd25832;
            9'd149: rom_value = 16'sd25955;
            9'd150: rom_value = 16'sd26077;
            9'd151: rom_value = 16'sd26198;
            9'd152: rom_value = 16'sd26319;
            9'd153: rom_value = 16'sd26438;
            9'd154: rom_value = 16'sd26556;
            9'd155: rom_value = 16'sd26674;
            9'd156: rom_value = 16'sd26790;
            9'd157: rom_value = 16'sd26905;
            9'd158: rom_value = 16'sd27019;
            9'd159: rom_value = 16'sd27133;
            9'd160: rom_value = 16'sd27245;
            9'd161: rom_value = 16'sd27356;
            9'd162: rom_value = 16'sd27466;
            9'd163: rom_value = 16'sd27575;
            9'd164: rom_value = 16'sd27683;
            9'd165: rom_value = 16'sd27790;
            9'd166: rom_value = 16'sd27896;
            9'd167: rom_value = 16'sd28001;
            9'd168: rom_value = 16'sd28105;
            9'd169: rom_value = 16'sd28208;
            9'd170: rom_value = 16'sd28310;
            9'd171: rom_value = 16'sd28411;
            9'd172: rom_value = 16'sd28510;
            9'd173: rom_value = 16'sd28609;
            9'd174: rom_value = 16'sd28706;
            9'd175: rom_value = 16'sd28803;
            9'd176: rom_value = 16'sd28898;
            9'd177: rom_value = 16'sd28992;
            9'd178: rom_value = 16'sd29085;
            9'd179: rom_value = 16'sd29177;
            9'd180: rom_value = 16'sd29268;
            9'd181: rom_value = 16'sd29358;
            9'd182: rom_value = 16'sd29447;
            9'd183: rom_value = 16'sd29534;
            9'd184: rom_value = 16'sd29621;
            9'd185: rom_value = 16'sd29706;
            9'd186: rom_value = 16'sd29791;
            9'd187: rom_value = 16'sd29874;
            9'd188: rom_value = 16'sd29956;
            9'd189: rom_value = 16'sd30037;
            9'd190: rom_value = 16'sd30117;
            9'd191: rom_value = 16'sd30195;
            9'd192: rom_value = 16'sd30273;
            9'd193: rom_value = 16'sd30349;
            9'd194: rom_value = 16'sd30424;
            9'd195: rom_value = 16'sd30498;
            9'd196: rom_value = 16'sd30571;
            9'd197: rom_value = 16'sd30643;
            9'd198: rom_value = 16'sd30714;
            9'd199: rom_value = 16'sd30783;
            9'd200: rom_value = 16'sd30852;
            9'd201: rom_value = 16'sd30919;
            9'd202: rom_value = 16'sd30985;
            9'd203: rom_value = 16'sd31050;
            9'd204: rom_value = 16'sd31113;
            9'd205: rom_value = 16'sd31176;
            9'd206: rom_value = 16'sd31237;
            9'd207: rom_value = 16'sd31297;
            9'd208: rom_value = 16'sd31356;
            9'd209: rom_value = 16'sd31414;
            9'd210: rom_value = 16'sd31470;
            9'd211: rom_value = 16'sd31526;
            9'd212: rom_value = 16'sd31580;
            9'd213: rom_value = 16'sd31633;
            9'd214: rom_value = 16'sd31685;
            9'd215: rom_value = 16'sd31736;
            9'd216: rom_value = 16'sd31785;
            9'd217: rom_value = 16'sd31833;
            9'd218: rom_value = 16'sd31880;
            9'd219: rom_value = 16'sd31926;
            9'd220: rom_value = 16'sd31971;
            9'd221: rom_value = 16'sd32014;
            9'd222: rom_value = 16'sd32057;
            9'd223: rom_value = 16'sd32098;
            9'd224: rom_value = 16'sd32137;
            9'd225: rom_value = 16'sd32176;
            9'd226: rom_value = 16'sd32213;
            9'd227: rom_value = 16'sd32250;
            9'd228: rom_value = 16'sd32285;
            9'd229: rom_value = 16'sd32318;
            9'd230: rom_value = 16'sd32351;
            9'd231: rom_value = 16'sd32382;
            9'd232: rom_value = 16'sd32412;
            9'd233: rom_value = 16'sd32441;
            9'd234: rom_value = 16'sd32469;
            9'd235: rom_value = 16'sd32495;
            9'd236: rom_value = 16'sd32521;
            9'd237: rom_value = 16'sd32545;
            9'd238: rom_value = 16'sd32567;
            9'd239: rom_value = 16'sd32589;
            9'd240: rom_value = 16'sd32609;
            9'd241: rom_value = 16'sd32628;
            9'd242: rom_value = 16'sd32646;
            9'd243: rom_value = 16'sd32663;
            9'd244: rom_value = 16'sd32678;
            9'd245: rom_value = 16'sd32692;
            9'd246: rom_value = 16'sd32705;
            9'd247: rom_value = 16'sd32717;
            9'd248: rom_value = 16'sd32728;
            9'd249: rom_value = 16'sd32737;
            9'd250: rom_value = 16'sd32745;
            9'd251: rom_value = 16'sd32752;
            9'd252: rom_value = 16'sd32757;
            9'd253: rom_value = 16'sd32761;
            9'd254: rom_value = 16'sd32765;
            9'd255: rom_value = 16'sd32766;
            9'd256: rom_value = 16'sd32767;
            default: rom_value = 16'sd0;
        endcase
    end

    always @* begin
        signed_rom_value = quadrant[1] ? -$signed({1'b0, rom_value}) : $signed({1'b0, rom_value});
        scaled_value = signed_rom_value * AMPLITUDE_SIGNED;
        if (scaled_value < 0) begin
            clipped_value = -(((-scaled_value) + 48'sd16384) >>> 15);
        end else begin
            clipped_value = (scaled_value + 48'sd16384) >>> 15;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            phase1024 <= 10'd256;
            out <= {OUTPUT_WIDTH{1'b0}};
        end else if (en) begin
            out <= clipped_value[OUTPUT_WIDTH-1:0];
            phase1024 <= phase1024 + PHASE_STEP;
        end
    end

endmodule
