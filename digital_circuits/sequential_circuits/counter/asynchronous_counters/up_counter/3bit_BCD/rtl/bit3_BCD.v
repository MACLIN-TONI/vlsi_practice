module bit3_BCD(
    input clk,
    input en,
    input areset_n,
    output [11:0] out
);

    wire [11:0] w;
    wire [2:0] rst_out;
    mod_10 bcd2(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .out(w[11:8]),
        .rst_out(rst_out[2])
    );

    mod_10 bcd1(
        .clk(rst_out[2]),
        .en(en),
        .areset_n(areset_n),
        .out(w[7:4]),
        .rst_out(rst_out[1])
    );

    mod_10 bcd0(
        .clk(rst_out[1]),
        .en(en),
        .areset_n(areset_n),
        .out(w[3:0]),
        .rst_out(rst_out[0])
    );

    assign out = {w[3:0], w[7:4], w[11:8]};

endmodule