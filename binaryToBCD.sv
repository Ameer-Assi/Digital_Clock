module binaryToBCD (
    input logic [5:0] number,
    output logic [3:0] units,
    output logic [3:0] tens
);

always_comb begin 
if (number >= 50) begin
    tens = 5;
    units = number - 50;
end
else if (number >= 40) begin
    units = number - 40;
    tens = 4;
end
else if (number >= 30) begin
    tens = 3;
    units = number - 30;
end
else if (number >= 20) begin
    tens = 2;
    units = number - 20;
end
else if (number >= 10)begin
    tens = 1;
    units = number - 10;
end
else begin
    tens = 0;
    units = number;
end

end
    
endmodule