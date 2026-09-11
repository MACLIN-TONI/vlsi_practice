module fsm (
    input in,
    input clk,
    input rst,
    output reg out
);


    parameter s0=2'b00;
    parameter s1=2'b01;
    parameter s10=2'b10;
    parameter s101=2'b11;

    reg [1:0] state, next;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state <= s0;
        end
        else begin
            state <= next;
        end

    end

    always @(*) begin
        
        out = 1'b0;
        next = s0;

        case (state) 
            s0: begin
                if(in) begin
                   next = s1;

                end
                else begin
                    next = s0;
                end

            end

            s1: begin
                if(in) begin
                   next = s1;

                end
                else begin
                    next = s10;
                end

            end

            s10: begin
                if(in) begin
                   next = s101;

                end
                else begin
                    next = s0;
                end

            end

            s101: begin
                if(in) begin
                   next = s1;

                end
                else begin
                    next = s10;
                    out = 1'b1;
                end

            end
            default: begin
                out = 1'b0;
                next = s0;
            end
        endcase

    end



endmodule