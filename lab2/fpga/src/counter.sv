/*
Name: Lughnasa Miller
Date: 9/3/25
Email: lumiller@hmc.edu
Description: This module implements a basic counter with a variable bus width and 
    incrementing value (default 24 and 1, respectively).
*/
module counter 
	#(parameter WIDTH = 24,
	  parameter P = 1) 
	 (input logic              clk, reset,
      output logic [WIDTH-1:0] value);

    always_ff @ (posedge clk) begin
        if (~reset) value <= {WIDTH{1'b0}};
        else value <= value + P;
    end

endmodule