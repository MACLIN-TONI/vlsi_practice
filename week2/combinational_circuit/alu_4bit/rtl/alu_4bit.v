module alu_4bit (
    input signed [3:0] a, b,
    input [2:0] opcode,
    output zero,
    output negative,
    output reg overflow,
    output reg carry_out,
    output reg [3:0] out
);

    assign zero = (out == 4'b0000);
    assign negative = (out[3] == 1'b1);
    

    always @(*) begin
        out = 4'b0000;
        carry_out = 1'b0;
        overflow = 1'b0;
        
        case (opcode)
            3'b000: begin
                {carry_out,out} = {1'b0,a} + {1'b0,b};
                overflow = (a[3] == b[3]) && (a[3] != out[3]);
            end
            
            3'b001: begin
                {carry_out,out} = {1'b0,a} - {1'b0,b};
                overflow = (a[3] != b[3]) && (a[3] != out[3]);
            end
            3'b010: out = a&b;
            3'b011: out = a | b;
            3'b100: out = a ^ b;
            3'b101: out = ~a;
            3'b110: begin
                // a - 1 1 1 1 -> 1 1 1 0
                out = a << 1;
                carry_out = a[3];
            end 
            3'b111: begin
                // a - 1 1 1 1 -> 0 1 1 1
                out = a >>> 1;
                carry_out = a[0];
            end
            default: begin
                out= 4'bxxxx;
                carry_out = 1'bx;
                overflow= 1'bx;
            end
        endcase
    end


endmodule