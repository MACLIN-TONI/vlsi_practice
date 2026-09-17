module s_1010_non_overlapping (
    input clk,
    input en,
    input areset_n,
    input in, 
    output reg out
);

    parameter a = 3'b000;
    parameter b = 3'b001;
    parameter c = 3'b010;
    parameter d = 3'b011;
    parameter e = 3'b100;

    reg [2:0] state, next;

    always @(posedge clk, negedge areset_n) begin
        if(~areset_n) begin
            state <= a;
        end
        else begin
            if(en) begin
                state <= next;
            end
            else begin
                state <= state;
            end
        end
    end

    always @(state, in) begin
        next = a;

        case (state) 
            a: begin
                if(in) begin
                    next = b;
                end
                else begin
                    next = a;
                end
            end

            b: begin
                if(in) begin
                    next = b;
                end
                else begin
                    next = c;
                end
            end

            c: begin
                if(in) begin
                    next = d;
                end
                else begin
                    next = a;
                end
            end

            d: begin
                if(in) begin
                    next = b;
                end
                else begin
                    next = e;
                end
            end

            e: begin
                if(in) begin
                    next = b;
                end
                else begin
                    next = a;
                end
            end
        endcase
    end

    always @(state) begin
        out = 0;
        if (state == e) begin
            out = 1;
        end
        else begin
            out = 0;
        end
    end

endmodule