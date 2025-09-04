/*
Name: Lughnasa Miller
Date: 9/3/25
Email: lumiller@hmc.edu
Description: Given a 4 bit switch input, this module determines the 
    output on a seven-segment display.
*/
module seven_seg_decoder(input  logic [3:0] s,
						 output logic [6:0] seg);

    always_comb begin
        case(s)
        4'b0000: seg = 7'b000_0001;
        4'b0001: seg = 7'b100_1111;
        4'b0010: seg = 7'b001_0010;
        4'b0011: seg = 7'b000_0110;
        4'b0100: seg = 7'b100_1100;
        4'b0101: seg = 7'b010_0100;
        4'b0110: seg = 7'b010_0000;
        4'b0111: seg = 7'b000_1111;
        4'b1000: seg = 7'b000_0000;
        4'b1001: seg = 7'b000_0100;
        4'b1010: seg = 7'b000_1000;
        4'b1011: seg = 7'b110_0000;
        4'b1100: seg = 7'b111_0010;
        4'b1101: seg = 7'b100_0010;
        4'b1110: seg = 7'b001_0000;
        4'b1111: seg = 7'b011_1000;
        default: seg = 7'b111_1111;
        endcase
    end

endmodule