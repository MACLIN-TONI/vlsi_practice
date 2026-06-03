module ripple_carry_adder #(parameter N=4) (
    input [N-1:0] a, b,
    input cin,
    output reg [N-1:0] sum,
    output reg carry_out
); 

    wire [N:0] carry;
    assign carry[0] = cin;
    assign carry_out = carry[N];

    genvar i;

    generate
        for (i=0;i<N;i=i+1) begin : fa_stage
            full_adder dut (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .carry_out(carry[i+1])
            );
        end
    endgenerate 


endmodule