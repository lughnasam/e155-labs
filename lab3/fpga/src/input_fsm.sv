module input_fsm(input clk, reset,
                 input [3:0] cols,
                 output new_key,
                 output [3:0] row_pwr);

typedef enum logic {row0_pwr, row1_pwr, row2_pwr, row3_pwr, debounce, intake, depress} statetype;
statetype state, next_state;

counter debounce_counter()

always_comb begin
    case(state) 
        row0_pwr: if(cols != 4'b0)          next_state = debounce;
                  else                      next_state = row1_pwr;
        row1_pwr: if(cols != 4'b0)          next_state = debounce;
                  else                      next_state = row2_pwr;
        row2_pwr: if(cols != 4'b0)          next_state = debounce;
                  else                      next_state = row3_pwr;
        row3_pwr: if(cols != 4'b0)          next_state = debounce;
                  else                      next_state = row0_pwr;
        debounce: if(counter < 21'd1920000) next_state = debounce;
                  else                      next_state = intake;
        intake:                             next_state = depress;
        depress:  if(cols != 4'b0)          next_state = depress;
                  else                      next_state = row0_pwr;
        default:                            next_state = row0_pwr;
    endcase
    
end

endmodule