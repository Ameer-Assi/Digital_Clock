module minCounter (
    input logic clk,
    input logic rst,
    input logic tick,
    input logic clock_set,
    input logic increment,
    input logic decrement,
    input logic[1:0] changeD, // which time to change: seconds, minutes or hours.
    output logic [5:0] mins,
    output logic [5:0] secs,
    output logic [4:0] hours
);
logic inc_edge; //posedge detector for increment
logic dec_edge; //posedge detector for decrement
    always_ff @(posedge clk) begin 
        if (rst == 1)begin
            mins <= 0;
            secs <= 0;
            hours <= 0;
            inc_edge <= 0;
            dec_edge <= 0;
        end
        else if(clock_set == 1)begin
            if(increment == 1 && decrement == 0 && inc_edge == 0) begin
                case (changeD)
                    2'b00: begin
                        if (secs == 59)
                            secs <= 0;
                        else
                            secs <= secs + 1;
                    end
                    2'b01: begin
                        if (mins == 59)
                            mins <= 0;
                        else
                            mins <= mins + 1;
                    end
                    2'b10: begin
                        if (hours == 23)
                            hours <= 0;
                        else
                            hours <= hours + 1;
                    end
                endcase
            end
            else if(decrement == 1 && dec_edge == 0) begin
                case (changeD)
                    2'b00: begin
                        if (secs == 0)
                            secs <= 59;
                        else
                            secs <= secs - 1;
                    end
                    2'b01: begin
                        if (mins == 0)
                            mins <= 59;
                        else
                            mins <= mins - 1;
                    end
                    2'b10: begin
                        if (hours == 0)
                            hours <= 23;
                        else
                            hours <= hours - 1;
                    end
                endcase
            end
        end
        else if(tick == 1) begin
            if (secs == 59) begin
                secs <= 0;
                if(mins == 59) begin
                    mins <= 0;
                    if (hours == 23)
                        hours <= 0;
                    else
                    hours <= hours + 1;
                end
                else
                    mins <= mins + 1;

            end
            else
                secs <= secs + 1;
        end
        inc_edge <= increment;
        dec_edge <= decrement;
    end
endmodule