module cla_adder #(parameter N) (
    input [N-1:0] a, b,
    input cin,
    output [N-1:0] sum,
    output carry_out
);
    reg [($clog2(N))+1:0] i;
    reg [N:0] carry;
    reg [N-1:0] P, G;
    
    always @(*) begin
        carry[0] = cin;
        for(i=0; i<N ;i=i+1) begin
            P[i] = a[i] ^ b[i];
            G[i] = a[i] & b[i];
            carry[i+1] = G[i] | (carry[i] & P[i]);
        end
    end

    assign sum = P ^ carry;
    assign carry_out = carry[N];


endmodule