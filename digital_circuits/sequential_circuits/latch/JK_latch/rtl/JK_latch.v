module JK_latch (
    input clk,
    input j,
    input k,
    output q,
    output qb
);
    wire w1, w2;

    nand (w1, j, clk, qb);
    nand (w2, k, clk, q);

    nand(q, w1, qb);
    nand(qb, w2, q);

endmodule
