module SR_latch_NAND (
    input clk,
    input s,
    input r,
    output reg q,
    output reg qb
);
    
    wire w1,w2;

    nand (w1,s,clk);
    nand (w2,r,clk);

    nand (q,w1,qb);
    nand (qb,w2,q);




    
endmodule 