module lab1_ly(input logic  [3:0] s,
               output logic [2:0] led,
               output logic [6:0] seg);

    logic [31:0] value;
    logic        int_osc, reset;

    HSOSC #(.CLKHF_DIV(2'b00)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    seven_seg_decoder          seven_seg(.s(s), .seg(seg));
    counter #(.WIDTH(32),
			  .P(215))         cnt(.clk(int_osc), .reset(reset), .value(value));
    led_decoder                led_dec(.pin(value[31]), .s(s), .led(led));

endmodule