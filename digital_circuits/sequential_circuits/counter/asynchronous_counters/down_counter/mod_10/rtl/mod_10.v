module mod_10(
    input clk,
    input en,
    input areset_n,
    output reg [3:0] out
);

    reg [3:0] w;
    assign out = {w[3],w[2],w[1],w[0]};
    
    JK jk0(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .j(1),
        .k(1),
        .q(w[0])
    );
    
    JK jk1(
        .clk(w[0]),
        .en(en),
        .areset_n(areset_n),
        .j((w[1] | w[2] | w[3] )),
        .k(1),
        .q(w[1])
    );

    JK jk2(
        .clk(w[1]),
        .en(en),
        .areset_n(areset_n),
        .j(1),
        .k(1),
        .q(w[2])
    );

    JK jk3(
        .clk(w[0]),
        .en(en),
        .areset_n(areset_n),
        .j(~(w[1] | w[2])),
        .k(1),
        .q(w[3])
    );

endmodule
