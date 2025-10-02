module button_decoder(input  [3:0] rows, cols,
                      output [6:0] seg);

logic [7:0] keypad;
logic [3:0] number;

assign keypad = {rows, cols};

always_comb begin
    case(keypad)
        8'b1000_0001: number = 4'b1110;
        8'b1000_0010: number = 4'b0000;
        8'b1000_0100: number = 4'b1111; 
        8'b1000_1000: number = 4'b1101;
        8'b0100_0001: number = 4'b0111;
        8'b0100_0010: number = 4'b1000;
        8'b0100_0100: number = 4'b1001;
        8'b0100_1000: number = 4'b1100;
        8'b0010_0001: number = 4'b0100;
        8'b0010_0010: number = 4'b0101;
        8'b0010_0100: number = 4'b0110;
        8'b0010_1000: number = 4'b1011;
        8'b0001_0001: number = 4'b0001;
        8'b0001_0010: number = 4'b0010;
        8'b0001_0100: number = 4'b0011;
        8'b0001_1000: number = 4'b1010;
        default:      number = 4'b0000;
    endcase
end

seven_seg_decoder ssd(.s(number), .seg(seg));

endmodule
