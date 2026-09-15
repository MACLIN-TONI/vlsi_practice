`timescale 1ns/1ps
module tb_JK_latch;
    reg  clk;
    reg areset_n;
    reg  j;
    reg  k;  
    wire q;
    wire qb;

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0, tb_JK_latch);
    end

    JK_latch dut (
        .clk(clk),
        .areset_n(areset_n),
        .j(j),
        .k(k),
        .q(q),
        .qb(qb)
    );

    
    initial begin
        clk = 1'b0;
        forever #2 clk= ~clk;
    end

    

    // Change j/k only while clk is low (latch opaque) to avoid
    // the transparent-latch race-around when j=k=1 during clk=1.
    task check;
        reg [2:0] a, b;
        begin
            for (a = 0; a < 2; a = a + 1) begin
                for (b = 0; b < 2; b = b + 1) begin
                    
                    @(negedge clk) j = a; 
                    @(negedge clk) k = b;
                    
                    #1;
                   
                    $display("j=%b | k=%b | q=%b | qb=%b", j, k, q, qb);
                end
            end
        end
    endtask

    initial begin
        j=0;
        k=0;
        areset_n=0;
    end

    initial begin
        #10 areset_n=1;
        check();
        check();

        #50 $finish;
        
    end

endmodule