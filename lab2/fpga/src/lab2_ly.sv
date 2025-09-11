/*
Name: Lughnasa Miller
Date: 9/10/25
Email: lumiller@hmc.edu
Description: Top level module for lab 2, E155.
*/
module lab2_ly(input logic        reset,
               input logic  [3:0] sw0, sw1,
               output logic [6:0] segout,
               output logic [4:0] led,
               output logic       l_seg_pwr, r_seg_pwr);
    
    logic        int_osc;
    logic [3:0]  sw0_store, sw1_store, sw_cur;
    logic [17:0] c_val;

    // create clock and timing
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    counter #(.WIDTH(18))      count(.clk(int_osc), .reset(reset), .value(c_val));
    
    //state determined by ctr
    assign l_seg_pwr = c_val[17];
    assign r_seg_pwr = ~c_val[17];
    
    //store state values for FFs
	ff_enabled #(.WIDTH(4)) ff0(.clk(int_osc), .reset(reset), .enable(l_seg_pwr), .d(sw0), .q(sw0_store));
	ff_enabled #(.WIDTH(4)) ff1(.clk(int_osc), .reset(reset), .enable(r_seg_pwr), .d(sw1), .q(sw1_store));
	
    // select active switch
    assign sw_cur = c_val[17] ? sw0_store : sw1_store;

    // determine active display output, calculate LED display
    seven_seg_decoder ssd(.s(sw_cur), .seg(segout));
    assign led = {1'b0, sw0} + {1'b0, sw1};

endmodule