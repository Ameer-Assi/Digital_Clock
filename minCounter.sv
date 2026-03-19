module minCounter (
    input logic clk,
    input logic rst,
    output logic [3:0] mins
);
    logic [3:0] sec_Counter;
    always_ff @(posedge clk) begin 
        if (rst == 1)begin
            mins <= 0;
            sec_Counter <= 0;
        end
        else begin
            if (sec_Counter == 59) begin
                sec_Counter <= 0;
                mins <= mins + 1;
            end
            sec_Counter <= sec_Counter + 1;
        end
    end

endmodule