/*
Name: Lughnasa Miller
Date: 9/10/25
Email: lumiller@hmc.edu
Description: FF module with reset and enable
*/
module ff_enabled
    #(parameter WIDTH = 8)
     (input logic              clk, reset, enable,
      input logic  [WIDTH-1:0] d,
      output logic [WIDTH-1:0] q);

always_ff @(posedge clk) begin
    if (~reset) q <= 0;
    else if (enable) q <= d;
end

endmodule