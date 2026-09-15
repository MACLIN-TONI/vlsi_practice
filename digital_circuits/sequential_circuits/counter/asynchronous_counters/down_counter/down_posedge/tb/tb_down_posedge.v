`timescale 1ns/1ps

module tb_down_posedge;
    reg clk;
    reg en;
    reg areset_n;
    wire [2:0] out;

    down_posedge dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_down_posedge);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 0;
        areset_n = 0;
    end

    task check;
        begin
            $display("en = %b | areset_n = %b | out = %b",en,areset_n,out);
        end
    endtask

    initial begin
        #10 areset_n = 1;
        #7 en = 1;

        repeat(20) begin
            @(negedge clk) check();
        end

        #10 $finish; 
    end
endmodule