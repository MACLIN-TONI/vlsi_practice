`timescale 1ns/1ps
module tb_mux_2to1_dataflow;
    reg a;
    reg b;
    reg sel;
    wire out;
    mux_2to1_dataflow dut(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );
    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_mux_2to1_dataflow);
    end
    
    integer passed=0;
    integer failed=0;
    

    task check;
        input t_a, t_b, t_sel;
        input exp_out;
        begin
            a = t_a;
            b = t_b;
            sel =t_sel;
            #10;
            if(out === exp_out) begin
                $display("PASS: a=%b b=%b sel=%b out=%b", a,b,sel,out);
                passed=passed+1;
            end
            else begin
                $display("FAILED: a=%b b=%b sel=%b out=%b | exp_out=5%b", a,b,sel,out,exp_out);
                failed=failed+1;
            end
        end
    endtask
    initial begin
        integer i;
        for(i=0;i<8;i=i+1) begin
            check(i[2],i[1],i[0],((i[0])?i[1]:i[2]));
        end
        $display("Test summary: %d passed, %d failed", passed, failed);
        $finish;
    end
endmodule


