module mux_2to1_procedural(
    input a,
    input b,
    input sel,
    output reg out
);
    always @(a or b or sel) begin
        out=sel?b:a;
    end
endmodule
