module full_adder (
    input a,
    input b,
    input cin,
    output sum, 
    output carry_out
);
    wire sum1, c1, c2;
    half_adder ha1 (.a(a), .b(b), .sum(sum1), .carry_out(c1) );
    half_adder ha2 (.a(sum1), .b(cin), .sum(sum), .carry_out(c2) );
    assign carry_out = c1 | c2;
endmodule

