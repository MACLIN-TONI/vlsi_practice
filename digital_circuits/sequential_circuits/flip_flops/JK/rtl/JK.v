module JK (
    input clk,
    input en,
    input areset_n,
    input j,
    input k,
    output reg q
);

    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            q <= 1'b0;
        end
        else if(!en) begin
            q <=q;
        end
        else begin
            case ({j,k}) 
                2'b00: q<=q;
                2'b01: q<=1'b0;
                2'b10: q<=1'b1;
                2'b11: q<=~q;
                default: q <= q;
            endcase
        end
    end
endmodule 