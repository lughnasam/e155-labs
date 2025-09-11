module counter
    #(parameter WIDTH = 8)
     (input logic              clk, reset, enable,
      input logic [WIDTH-1:0]  d,
      output logic [WIDTH-1:0] q);

always_ff begin
    if (reset) Q <= 0;
    else if (enable) Q <= D;
end

endmodule