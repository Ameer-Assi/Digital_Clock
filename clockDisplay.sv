module clockDisplay (
    input logic [3:0] num,
    output logic [6:0] pins // 7 segment display, active-high 
);
always_comb begin
    case (num)
        0: pins = 7'b0111111;
        1: pins = 7'b0000110;
        2: pins = 7'b1011011;
        3: pins = 7'b1001111;
        4: pins = 7'b1100110;
        5: pins = 7'b1101101;
        6: pins = 7'b1111101;
        7: pins = 7'b0000111;
        8: pins = 7'b1111111;
        9: pins = 7'b1100111;
        default: pins = 7'b1111111;
    endcase
end
endmodule