/*
Name: Lughnasa Miller
Date: 9/10/25
Email: lumiller@hmc.edu
Description: Testbench for top level module of lab 2
*/

`timescale 1ns/1ns

module lab2_ly_tb;

logic [3:0] sw0, sw1;
logic [4:0] sum, led;
logic [6:0] display;
logic reset, lpwr, rpwr;

lab2_ly dut(.reset(reset), .sw0(sw0), .sw1(sw1), .l_seg_pwr(lpwr), .r_seg_pwr(rpwr), .led(led), .segout(display));

initial begin
    reset = 1; #22;
    reset = 0;
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
            #40;
            sw0 = i;
            sw1 = j;
            sum = {1'b0, sw0} + {1'b0, sw1};
            #20
            assert(sum == led) else $error();
        end
    end

    #1000000;
end
endmodule