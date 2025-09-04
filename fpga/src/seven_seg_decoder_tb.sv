/*
Name: Lughnasa Miller
Date: 9/3/25
Email: lumiller@hmc.edu
Description: This module implements a testbench for the seven-segment LED decoder for lab 1.
*/
module testbench;

    logic [3:0] s;
    logic [6:0] seg;

    seven_seg_decoder dut(.s(s), .seg(seg));

    initial begin

    s = 4'b0000; #10;
    assert (seg == 7'b000_0001) 
    else   $display("error on %b", s);
    s = 4'b0001; #10;
    assert (seg == 7'b100_1111)
    else   $display("error on %b", s);
    s = 4'b0010; #10;
    assert (seg == 7'b001_0010)
    else   $display("error on %b", s);
    s = 4'b0011; #10;
    assert (seg == 7'b000_0110)
    else   $display("error on %b", s);
    s = 4'b0100; #10;
    assert (seg == 7'b100_1100)
    else   $display("error on %b", s);
    s = 4'b0101; #10;
    assert (seg == 7'b010_0100)
    else   $display("error on %b", s);
    s = 4'b0110; #10;
    assert (seg == 7'b010_0000)
    else   $display("error on %b", s);
    s = 4'b0111; #10;
    assert (seg == 7'b000_1111)
    else   $display("error on %b", s);
    s = 4'b1000; #10;
    assert (seg == 7'b000_0000)
    else   $display("error on %b", s);
    s = 4'b1001; #10;
    assert (seg == 7'b000_0100)
    else   $display("error on %b", s);
    s = 4'b1010; #10;
    assert (seg == 7'b000_1000) 
    else   $display("error on %b", s);
    s = 4'b1011; #10;
    assert (seg == 7'b110_0000) 
    else   $display("error on %b", s);
    s = 4'b1100; #10;
    assert (seg == 7'b111_0010) 
    else   $display("error on %b", s);
    s = 4'b1101; #10;
    assert (seg == 7'b100_0010) 
    else   $display("error on %b", s);
    s = 4'b1110; #10;
    assert (seg == 7'b001_0000) 
    else   $display("error on %b", s);
    s = 4'b1111; #10;
    assert (seg == 7'b011_1000) 
    else   $display("error on %b", s);

    end

endmodule