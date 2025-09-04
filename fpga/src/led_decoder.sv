module led_decoder(input logic        pin,
                   input logic  [3:0] s,
                   output logic [2:0] led);

    assign led[2] = pin;
    assign led[1] = s[1] ^ s[0];
    assign led[0] = s[3] & s[2];

endmodule