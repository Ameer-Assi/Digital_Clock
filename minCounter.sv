module minCounter (
    input logic clk,
    input logic rst,
    input logic tick,
    output logic [5:0] mins,
    output logic [5:0] secs,
    output logic [4:0] hours
);
    always_ff @(posedge clk) begin 
        if (rst == 1)begin
            mins <= 0;
            secs <= 0;
        end
        else if(tick == 1) begin
            if (secs == 59) begin
                secs <= 0;
                if(mins == 59) begin
                    mins <= 0;
                    if(hours == 23)
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
    end
endmodule