/*
Name: Lughnasa Miller
Date: 9/10/25
Email: lumiller@hmc.edu
Description: Simple synchronizer circuit implemented using two flipflops in series
*/
module synchronizer
    #(parameter WIDTH = 8)
    (input logic clk, reset,
     input logic [WIDTH-1:0] d,
     output logic [WIDTH-1:0] q);

    logic [WIDTH-1:0] d1;

    ff_enabled #(.WIDTH(WIDTH)) ff1(.clk(clk), .reset(reset), .enable(1'b1), .d(d), .q(d1));
    ff_enabled #(.WIDTH(WIDTH)) ff2(.clk(clk), .reset(reset), .enable(1'b1), .d(d1), .q(q));

endmodule