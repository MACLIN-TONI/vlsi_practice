`timescale 1ns/1ps

module tb_mux_4to1_dataflow;

    reg [3:0] a,b,c,d;
    reg [1:0] sel;
    wire [3:0] out;

    mux_4to1_dataflow uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );

    initial begin 
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_mux_4to1_dataflow);
    end

    integer passed = 0;
    integer failed = 0;

    task check;
        input [3:0] t_a, t_b, t_c, t_d;
        input [1:0] t_sel;
        input [3:0] exp_output;

        begin
            a = t_a;
            b = t_b;
            c = t_c;
            d = t_d;
            sel = t_sel;

            #10;

            if (out === exp_output) begin
                $display("PASS: a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b",
                         a, b, c, d, sel, out);
                passed = passed + 1;
            end
            else begin
                $display("FAIL: a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b (expected %b)",
                         a, b, c, d, sel, out, exp_output);
                failed = failed + 1;
            end
        end
    endtask

    

    initial begin
        integer i, j, k, l, m;
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                for (k = 0; k < 4; k = k + 1) begin
                    for (l = 0; l < 4; l = l + 1) begin
                        for (m = 0; m < 4; m = m + 1) begin

                            check(
                                i, j, k, l,
                                m,
                                (m[1]) ?
                                    (m[0] ? l : k) :
                                    (m[0] ? j : i)
                            );

                        end
                    end
                end
            end
        end

        $display("Total tests passed: %d, Total tests failed: %d",
                 passed, failed);

        $finish;
    end

endmodule