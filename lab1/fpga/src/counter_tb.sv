module testbench:

    logic clk, reset;
    logic [23:0] value;

    counter dut(.clk(clk), .reset(reset), .value(value));

    always begin
        clk = 0; #5; clk = 1; #5;
    end

    begin initial

    reset = 1; #5;
    assert (value == 32'b0)
    else $display("error on reset");
    #10;
    assert (value == 32'b1)
    else $display("error on increment");
    
    end

endmodule