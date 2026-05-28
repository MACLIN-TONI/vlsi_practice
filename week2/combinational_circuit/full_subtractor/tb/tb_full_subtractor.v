`timescale 1ns/1ps
module tb_full_subtractor;
    reg a, b, borrow_in;
    wire diff, borrow_out;
    full_subtractor dut (
        .a(a),
        .b(b),
        .borrow_in(borrow_in),
        .diff(diff),
        .borrow_out(borrow_out)
    );
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_full_subtractor);
    end
    integer PASS=0;
    integer FAIL=0;
    //integer i; declare in initial block to avoid scope issues
    
    task check;
        input t_a, t_b, t_borrow_in;
        input exp_diff, exp_borrow_out;
        begin
            a = t_a; b = t_b; borrow_in = t_borrow_in;
            #10;
            if (diff === exp_diff && borrow_out === exp_borrow_out) begin
                $display("PASS | a=%b b=%b borrow_in=%b | diff=%b borrow_out=%b", t_a, t_b, t_borrow_in, diff, borrow_out);
                PASS = PASS + 1;
            end
            else begin
                $display("FAIL | a=%b b=%b borrow_in=%b | diff=%b borrow_out=%b | Expected diff=%b borrow_out=%b", t_a, t_b, t_borrow_in, diff, borrow_out, exp_diff, exp_borrow_out);
                FAIL = FAIL + 1;
            end
        end
    endtask
    initial begin
        integer i;
        for (i=0;i<8;i=i+1) begin
            check(i[2],i[1],i[0], (i[2]^i[1]^i[0]), ((~i[2]&i[1]) | (~i[2]&i[0]) | (i[1]&i[0])));
        end
        $display("Test summary: %d passed | %d failed", PASS, FAIL);
        $finish;
    end
endmodule
