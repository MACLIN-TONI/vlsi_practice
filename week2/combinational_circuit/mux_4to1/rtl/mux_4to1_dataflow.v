module mux_4to1_dataflow (
    input [3:0] a, b, c, d,
    input [1:0] sel,
    output [3:0] out
);
    //assign out = (sel[1]) ? (sel[0]?d:c): (sel[0]?b:a);
    assign out = (sel==2'b00) ? a :
             (sel==2'b01) ? b :
             (sel==2'b10) ? c : d;
endmodule

