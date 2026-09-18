module mod_10(
    input clk,
    input en,
    input areset_n,
    output [3:0] out
);

    wire [3:0] w;
    wire load9;

    assign load9 = w[3] & w[2] & w[1] & w[0];
    
    assign {out[3],out[2],out[1],out[0]}= {w[0],w[1],w[2],w[3]};


    wire [3:0] rst, lo;

    assign rst = (load9)?4'b1001:4'b1111;
    assign lo = (load9)?4'b1001:4'b0000;

    D u3(
        .clk(clk),
        .en(en),
        .areset_n(areset_n & rst[3]),
        .preset(lo[3]),
        .d(~w[3]),
        .q(w[3])
    );
    
    

    D u2(
        .clk(w[3]),
        .en(en),
        .areset_n(areset_n & rst[2]),
        .preset(lo[2]),
        .d(~w[2]),
        .q(w[2])
    );

    D u1(
        .clk(w[2]),
        .en(en),
        .areset_n(areset_n & rst[1]),
        .preset(lo[1]),
        .d(~w[1]),
        .q(w[1])
    );

    D u0(
        .clk(w[1]),
        .en(en),
        .areset_n(areset_n & rst[0]),
        .preset(lo[0]),
        .d(~w[0]),
        .q(w[0])
    );

    

endmodule 
