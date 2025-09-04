module testbench;
    
    logic pin;
    logic [2:0] led;
    logic [3:0] s;

    led_decoder dut(.pin(pin));

    initial begin

    s = 4'b0000; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b0001; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b0010; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b0011; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b0100; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b0101; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b0110; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b0111; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b1000; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b1001; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b1010; #10;
    assert (led[1:0] == 2'b01) 
    else   $display("error on led %b", s);
    s = 4'b1011; #10;
    assert (led[1:0] == 2'b00) 
    else   $display("error on led %b", s);
    s = 4'b1100; #10;
    assert (led[1:0] == 2'b10) 
    else   $display("error on led %b", s);
    s = 4'b1101; #10;
    assert (led[1:0] == 2'b11) 
    else   $display("error on led %b", s);
    s = 4'b1110; #10;
    assert (led[1:0] == 2'b11) 
    else   $display("error on led %b", s);
    s = 4'b1111; #10;
    assert (led[1:0] == 2'b10) 
    else   $display("error on led %b", s);
    pin = 1'b1;
    assert (led == 3'b110)
    else   $display("error on led pin change");

    end

endmodule