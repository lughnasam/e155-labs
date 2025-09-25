module input_fsm(input clk, reset,
                 input [3:0] cols,
                 output new_key,
                 output [3:0] row_pwr, cols_newkey);

    typedef enum logic [3:0] {row0_pwr, row1_pwr, row2_pwr, row3_pwr, debounce, intake, depress, pause} statetype;
    statetype state, next_state;
    logic [23:0] count;

    // check debounce state
    logic debounce_on;
    assign debounce_on = ~(state == debounce);

    
    logic       row0on, row1on, row2on, row3on, scanning_on;
    logic [3:0] rows_read, rows_synced, cols_synced, cols_saved, rows_saved;
    
    // check which rows are active to read into
    assign row0on = (state == row0_pwr);
    assign row1on = (state == row1_pwr);
    assign row2on = (state == row2_pwr);
    assign row3on = (state == row3_pwr);
    assign rows_read = {row3on, row2on, row1on, row0on};
    assign scanning = |rows_read;


    // new key on intake only
    assign new_key = (state == intake);
	



    // debounce counter, synchronizer for rows and cols, ffs to save current pressed inputs
    counter debounce_counter(.clk(clk), .reset(debounce_on), .value(count));
    synchronizer #(.WIDTH(4)) rows_sync(.clk(clk), .reset(reset), .d(rows_read), .q(rows_synced));
    synchronizer #(.WIDTH(4)) cols_sync(.clk(clk), .reset(reset), .d(cols), .q(cols_synced));
    ff_enabled   #(.WIDTH(4)) rows_save(.clk(clk), .reset(reset), .enable(scanning), .d(rows_read), .q(rows_saved));
    ff_enabled   #(.WIDTH(4)) col_saved(.clk(clk), .reset(reset), .enable(new_key), .d(cols), .q(cols_saved));
	
	// state register
	always_ff @(posedge clk, posedge reset) begin
		if (~reset) state <= row0_pwr;
		else        state <= next_state;
	end
	
	// next state logic
    always_comb begin
        case(state) 
            row0_pwr: if(cols != 4'b0)          next_state = pause;
                      else                      next_state = row1_pwr;
            row1_pwr: if(cols != 4'b0)          next_state = pause;
                      else                      next_state = row2_pwr;
            row2_pwr: if(cols != 4'b0)          next_state = pause;
                      else                      next_state = row3_pwr;
            row3_pwr: if(cols != 4'b0)          next_state = pause;
                      else                      next_state = row0_pwr;
            pause:                              next_state = intake;
            intake:                             next_state = debounce;
            debounce: if(count < 24'd1920000)   next_state = debounce;
                      else                      next_state = depress;
            depress:  if(cols_saved & cols != cols)
                                                next_state = row0_pwr;
            default:                            next_state = row0_pwr;
        endcase
        
    end

    // if scanning, oscillate through rows, else constant power one row
    assign row_pwr = scanning ? rows_read : rows_synced;

    // cols out is only active on press
    assign cols_newkey = cols_synced;

    endmodule