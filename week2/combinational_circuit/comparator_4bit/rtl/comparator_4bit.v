module comparator_4bit (
    input wire [3:0] a, b,
    output reg eq, lt, gt
);
    always @(*) begin
        eq = 0;
        lt = 0;
        gt = 0;
        
        eq = (a == b);
        lt = (a < b);
        gt = ~eq & ~lt;

    end

endmodule

