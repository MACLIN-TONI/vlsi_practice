module PIPO (
    input clk,
    input en,
    input areset_n,
    input [3:0] in,
    output reg [3:0] out
);
    
    D dff3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in[3]),
        .q(out[3])
    );

    D dff2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in[2]),
        .q(out[2])
    );

    D dff1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in[1]),
        .q(out[1])
    );

    D dff0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in[0]),
        .q(out[0])
    );

endmodule