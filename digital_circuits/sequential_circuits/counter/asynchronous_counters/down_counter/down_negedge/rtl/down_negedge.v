module down_negedge (
    input clk,
    input en,
    input areset_n,
    output reg [2:0] out
);

    wire [2:0] w;
    D_neg u2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .d(~w[2]),
        .q(w[2])        
    );

    D_neg u1(
        .clk(~w[2]),
        .en(en),
        .areset_n(areset_n),
        .d(~w[1]),
        .q(w[1])        
    );

    D_neg u0(
        .clk(~w[1]),
        .en(en),
        .areset_n(areset_n),
        .d(~w[0]),
        .q(w[0])        
    );

    assign {out[2],out[1],out[0]} = {w[0],w[1],w[2]};
    
endmodule