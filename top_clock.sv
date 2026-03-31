module top_clock (
    input logic clk,
    input logic rst,
    input logic clock_set,
    input logic increment,
    input logic decrement,
    output logic [6:0] units_pin_s,
    output logic [6:0] tens_pins_s,
    output logic [6:0] units_pins_h,
    output logic [6:0] tens_pins_h,
    output logic [6:0] units_pins_m,
    output logic [6:0] tens_pins_m
);
logic tick;
logic increment_output, decrement_output, clock_set_output;
logic [1:0] changeD;
logic [5:0] secs;
logic [5:0] mins;
logic [4:0] hours;
logic [3:0] units_sec;
logic [3:0] tens_sec;
logic [3:0] units_hours;
logic [3:0] tens_hours;
logic [3:0] units_mins;
logic [3:0] tens_mins;
logic blink1,blink2,blink3;

always_comb begin
    blink1 =0; 
    blink2 = 0;
    blink3 = 0;
    case (changeD)
        00: blink1 = 1;
        01: blink2 = 1;
        10: blink3 = 1; 
        default: ;
    endcase
end
fsm control(.clk(clk), .rst(rst), .clock_set(clock_set), .increment(increment),
 .decrement(decrement), .increment_output(increment_output), .decrement_output(decrement_output), .clock_set_output(clock_set_output),
 .changeD(changeD)   
 );
clockDivider #(.DIVIDE_BY(10)) ticking(.clk(clk), .rst(rst), .tick(tick));
minCounter time_count(.clk(clk), .tick(tick), .rst(rst), .clock_set(clock_set_output), .increment(increment_output),
 .decrement(decrement_output), .changeD(changeD), .mins(mins), .hours(hours), .secs(secs)
);
binaryToBCD conv_secs(.number(secs), .units(units_sec), .tens(tens_sec));
binaryToBCD conv_mins(.number(mins), .units(units_mins), .tens(tens_mins));
binaryToBCD conv_hours(.number({1'b0,hours}), .units(units_hours), .tens(tens_hours));

clockDisplay disp_units_s(.num(units_sec),.pins(units_pins_s), .tick(tick), .blink(blink1));
clockDisplay disp_tens_s(.num(tens_sec),.pins(tens_pins_s), .tick(tick), .blink(blink1));
clockDisplay disp_units_m(.num(units_mins),.pins(units_pins_m), .tick(tick), .blink(blink2));
clockDisplay disp_tens_m(.num(tens_mins),.pins(tens_pins_m), .tick(tick), .blink(blink2));
clockDisplay disp_units_h(.num(units_hours),.pins(units_pins_h), .tick(tick), .blink(blink3));
clockDisplay disp_tens_h(.num(tens_hours),.pins(tens_pins_h), .tick(tick), .blink(blink3));
endmodule