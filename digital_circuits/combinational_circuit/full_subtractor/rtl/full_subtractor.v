module full_subtractor (
    input a,
    input b,
    input borrow_in,
    output diff,
    output borrow_out
);
    wire half_diff, half_borrow_1, half_borrow_2;
    half_subtractor h1 (
        .a(a),
        .b(b),
        .diff(half_diff),
        .borrow(half_borrow_1)
    );
    half_subtractor h2 (
        .a(half_diff),
        .b(borrow_in),
        .diff(diff),
        .borrow(half_borrow_2)
    );
    assign borrow_out = half_borrow_1 | half_borrow_2;
endmodule

