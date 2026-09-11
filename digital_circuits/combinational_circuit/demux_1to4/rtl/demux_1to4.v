module demux_1to4 (
    input in,
    input [1:0] sel,
    output reg a, b, c, d
);
    always @(*) begin
        a=1'b0;
        b=1'b0;
        c=1'b0;
        d=1'b0;
        case(sel)
            2'b00:a=in;
            2'b01:b=in;
            2'b10:c=in;
            2'b11:d=in;
        endcase
    end
endmodule
