module lab3_lm(input logic reset,
               input logic [3:0] cols, 
               output logic [3:0] rows,
               output logic [6:0] segout,
               output logic lpwr, rpwr);

    logic        clk, new_key;
    logic [3:0]  cols_nk;
	logic [6:0]  cur_in, cur_num, prev_num;
    logic [7:0]  new_num;
    logic [17:0] c_val;

    // fsm and button handler
    input_fsm scanner(.clk(clk), .reset(reset), .cols(cols), .new_key(new_key), .row_pwr(rows), .cols_newkey(cols_nk));

    // create clock and timing
    HSOSC #(.CLKHF_DIV(2'b01)) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
    counter #(.WIDTH(18))      count(.clk(clk), .reset(reset), .value(c_val));
    
    // power state determined by ctr
    assign l_seg_pwr = c_val[17];
    assign r_seg_pwr = ~c_val[17];

    // decode button into seg
    button_decoder bd(.rows(rows), .cols(cols_nk), .seg(cur_in));

    // shift register setup to store previous two outputs
    ff_enabled #(.WIDTH(7)) ff_r(.clk(clk), .reset(reset), .enable(new_key), .d(cur_in), .q(cur_num));
    ff_enabled #(.WIDTH(7)) ff_l(.clk(clk), .reset(reset), .enable(new_key), .d(cur_num), .q(prev_num));

    // when ctr[17] == 1, power and output left side, else power and output right
    assign lpwr = c_val[17];
    assign rpwr = ~c_val[17];
    assign segout = c_val[17] ? prev_num : cur_num;

endmodule