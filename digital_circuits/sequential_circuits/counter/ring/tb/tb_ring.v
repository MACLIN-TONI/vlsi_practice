`timescale 1ns/1ps

module tb_ring;

    reg clk;
    reg en;
    reg areset_n;
    reg load_shift;
    wire [3:0] out;

    ring dut (
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .load_shift(load_shift),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_ring);

    end

    initial begin
        clk = 0;
        en=0;
        areset_n =0;
        load_shift = 0;
        forever #5 clk = ~clk;
    end

    task check;
        begin
            $display("en = %b | areset_n = %b | out = %b",en,areset_n,out);
        end
    endtask

    initial begin
        #7 areset_n = 1;
        #7 en = 1;
        #7 load_shift=1;
        #7 load_shift = 0;
        #7;
        repeat (10) begin
            @(negedge clk) check();
        end 

        #10 $finish;
    end
endmodule