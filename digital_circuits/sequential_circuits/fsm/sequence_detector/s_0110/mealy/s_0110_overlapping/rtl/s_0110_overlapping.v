module s_0110_overlapping(
    input clk,
    input en,
    input areset_n,
    input in,
    output reg out
);
    parameter a=2'b00;
    parameter b=2'b01;
    parameter c=2'b10;
    parameter d=2'b11;

    reg [1:0] state, next;

    always @(posedge clk, negedge areset_n) begin
        if(~areset_n) begin
            state <= a;
        end
        else begin
            if (en) begin
                state <= next;
            end
            else begin
                state <= state;
            end
        end
    end

    always @(state, in) begin
        next = a;
        out = 1'b0;

        case (state)
            a: begin
                if(in) begin
                    next = a;
                    out = 0;
                end
                else begin
                    next = b;
                    out = 0;
                end
            end

            b: begin
                if(in) begin
                    next = c;
                    out = 0;
                end
                else begin
                    next = b;
                    out = 0;
                end
            end

            c: begin
                if(in) begin
                    next = d;
                    out = 0;
                end
                else begin
                    next = b;
                    out = 0;
                end
            end

            d: begin
                if(in) begin
                    next = a;
                    out = 0;
                end
                else begin
                    next = b;
                    out = 1;
                end
            end

            default: begin
                next = a;
                out = 0;
            end
        endcase
    end 

endmodule