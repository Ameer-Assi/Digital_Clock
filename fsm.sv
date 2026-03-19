module fsm (
    input logic clk,
    input logic rst,
    input logic clock_set,
    input logic increment,
    input logic decrement,
    output logic clock_set_output,
    output logic increment_output,
    output logic decrement_output,
    output logic [1:0] changeD
);
    typedef enum {initial_st, seconds_st, minutes_st, hours_st } state;
    state cur_st;
    state next_st;
    logic clock_set_edge;
    
    always_ff @( posedge clk ) begin 
        if(rst == 1) begin
            cur_st <= initial_st;
        end
        else begin
            cur_st <= next_st;
        end
        clock_set_edge <= clock_set;
    end

    always_comb begin 
        next_st = cur_st;
        clock_set_output = 1;
        increment_output = 0;
        decrement_output = 0;
        changeD = cur_st - 1;
        case (cur_st)
            initial_st: begin
                if (clock_set == 0)
                    clock_set_output = 0;
                else if(clock_set_edge == 0) begin
                    next_st = seconds_st;
                    changeD = cur_st;
                end
            end 
            seconds_st: begin
                if(clock_set == 1  && clock_set_edge == 0) begin
                    next_st = minutes_st;
                    changeD = cur_st;
                end
                increment_output = increment;
                decrement_output = decrement;

            end
            minutes_st: begin
                if(clock_set == 1 && clock_set_edge == 0) begin
                    next_st = hours_st;
                    changeD = cur_st;
                end
                increment_output = increment;
                decrement_output = decrement;
            end
            hours_st: begin
                if(clock_set == 1 && clock_set_edge == 0) begin
                    next_st = initial_st;
                    changeD = cur_st;
                end
                increment_output = increment;
                decrement_output = decrement;
            end
        endcase
    end

endmodule