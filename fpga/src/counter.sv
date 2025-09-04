module #(parameter WIDTH = 24) 
            counter(input logic              toggle, reset,
                    output logic [WIDTH-1:0] value);

    always_ff @ (posedge osc) begin
        if (reset) value <= {WIDTH{1'b0}}
        else value <= value + 1;
    end

endmodule