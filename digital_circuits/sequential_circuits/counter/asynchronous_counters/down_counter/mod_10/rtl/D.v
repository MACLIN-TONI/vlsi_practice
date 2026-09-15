module D (
    input clk,
    input en,
    input areset_n,
    input apreset,
    input d,
    output reg q
);

    always @(posedge clk, negedge areset_n, posedge apreset) begin
        if(!areset_n) begin
            q <= 1'b0;
        end
        else if(apreset) begin
            q <= 1'b1;
        end
        else if(en) begin
            q <= d;
        end
        else begin
            q <= q;
        end
    end

endmodule