`timescale 1ns/1ps

module tb_bit3_BCD;
    reg clk;
    reg en;
    reg areset_n;
    wire [11:0] out;

    bit3_BCD dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_bit3_BCD);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en=0;
        areset_n=0;
    end

    task check;
        begin
            $display("en = %b | areset_n = %b | out = %h",en,areset_n,out);
        end
    endtask


    initial begin
        #14 en = 1;
        #7 areset_n=1;
        repeat (1000) begin
            @(negedge clk) check();
        end

        #50 $finish;
    end
    
endmodule