module lab1_ly(input logic        clk, reset
               input logic  [3:0] s,
               output logic [2:0] led,
               output logic [6:0] seg);

    logic [23:0] value;
    logic        int_osc;

    HSOSC #(.CLKHF_DIV(2'b00)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    seven_seg_decoder          7seg(.s(s), .seg(seg));
    counter #(WIDTH = 24)      cnt(.osc(int_osc), .reset(reset), .value(value));
    led_decoder                led(.toggle(value[23]), .s(s), .led(led));

endmodule