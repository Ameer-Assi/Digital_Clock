module minCounter (
    input logic clk,
    input logic rst,
    output logic [5:0] mins
    output logic [5:0] secs
);
    always_ff @(posedge clk) begin 
        if (rst == 1)begin
            mins <= 0;
            secs <= 0;
        end
        else begin
            if (secs == 59) begin
                secs <= 0;
                mins <= mins + 1;
            end
            else
                secs <= secs + 1;
        end
    end

endmodule