module D (
    input clk,
    input en,
    input areset_n,
    input d,
    output reg q
);

    always @(posedge clk, posedge areset_n) begin
        if(!areset_n) begin
            q <= 1'b0;
        end
        else if(en) begin
            q <= d;
        end
        else begin
            q <= q;
        end
    end

endmodule