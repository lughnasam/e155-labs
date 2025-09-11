/*
Name: Lughnasa Miller
Date: 9/11/25
Email: lumiller@hmc.edu
Description: FF module with reset and enable, reset active low
*/
module ff_enabled_tb;

    logic clk, reset, enable;
    logic [7:0] d, q;

    ff_enabled dut(.clk(clk), .reset(reset), .enable(enable), .d(d), .q(q));

    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    initial begin
        enable = 0;
        reset = 0; #22;
        reset = 1;
        d = 1; 
        #18;
        assert(q == 7'b0) else $error("writing while disabled");
        enable = 1;
        #20;
        assert(q == 7'b1) else $error("not writing when enabled");
        $finish;
    end

endmodule