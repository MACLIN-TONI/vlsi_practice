// TESTBENCH  : tb_full_adder
// COVERAGE   : All 8 input combinations (exhaustive for 3-input circuit)
// PATTERN    : Self-checking — no manual waveform reading needed
`timescale 1ns/1ps
module tb_full_adder;
    reg a, b, cin;
    wire sum, carry_out;

    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry_out(carry_out)
    );
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0, tb_full_adder);
    end
    integer pass_count=0;
    integer fail_count=0;
    task apply_and_check;
        input t_a, t_b, t_cin;
        input exp_sum, exp_cout;
        begin
            a=t_a; b=t_b; cin=t_cin;
            #10;
            if (sum === exp_sum && carry_out === exp_cout) 
            begin
                $display("PASS: a=%b b=%b cin=%b | sum=%b carry_out=%b", t_a, t_b, t_cin, sum, carry_out);
                pass_count = pass_count +1;
            end
            else
            begin
                $display("FAIL: a=%b b=%b cin=%b | sum=%b carry_out=%b | Expected sum=%b carry_out=%b", t_a, t_b, t_cin, sum, carry_out, exp_sum, exp_cout);
                fail_count = fail_count +1;
            end
        end
    endtask
    initial begin
        apply_and_check(0, 0, 0, 0, 0);
        apply_and_check(0, 0, 1, 1, 0);
        apply_and_check(0, 1, 0, 1, 0);
        apply_and_check(0, 1, 1, 0, 1);
        apply_and_check(1, 0, 0, 1, 0);
        apply_and_check(1, 0, 1, 0, 1);
        apply_and_check(1, 1, 0, 0, 1);
        apply_and_check(1, 1, 1, 1, 1);

        $display("Test Summary: %d Passed | %d Failed", pass_count, fail_count);
        $finish;
    end
endmodule