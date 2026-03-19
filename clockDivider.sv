module clockDivider #(
    parameter DIVIDE_BY = 1
) (
    input logic clk,
    input logic rst,
    output logic new_clk
);
logic [31:0] counter;
always_ff @(posedge clk ) begin 
    if(rst == 1) begin
        new_clk <= 0;
        counter <= 0;
    end
    else begin
        if(counter == DIVIDE_BY - 1) begin // assuming DIVIDE_BY is an int
            new_clk <= 1;
            counter <= 0;
    end
        else begin
            new_clk <= 0;
            counter <= counter + 1;
        end
    end
end
endmodule