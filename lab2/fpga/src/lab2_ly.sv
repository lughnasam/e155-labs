module lab2_ly(input logic        reset,
               input logic  [3:0] sw0, sw1,
               output logic [6:0] display,
               output logic [4:0] led,
               output logic       l_seg_pwr, r_seg_pwr);
    
    logic        int_osc;
    logic [3:0]  sw_cur;
    logic [17:0] c_val;

    // create clock and timing
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    counter #(.WIDTH(18),
              .P(1))           count(.clk(int_osc), .reset(reset), .value(c_val));
    
    // select active switch
    assign sw_cur = c_val[17] ? sw0 : sw1;
    assign l_seg_pwr = c_val[17];
    assign r_seg_pwr = ~c_val[17];

    // determine active display output, calculate LED display
    seven_seg_decoder ssd(.s(sw_cur), .seg(display));
    assign led = {1'b0, sw0} + {1'b0, sw1};

endmodule