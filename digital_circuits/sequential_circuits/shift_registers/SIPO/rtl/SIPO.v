module SIPO (
    input clk,
    input en,
    input areset_n,
    input in,
    output reg [3:0] out
);
    wire [3:0] w;
    
    D dff1(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(in),
        .q(w[3])
    );

    D dff2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w[3]),
        .q(w[2])
    );

    D dff3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w[2]),
        .q(w[1])
    );

    D dff4(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(w[1]),
        .q(w[0])
    );
    
    assign out = w;

endmodule