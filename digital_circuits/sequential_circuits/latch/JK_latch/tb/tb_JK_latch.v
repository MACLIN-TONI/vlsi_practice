`timescale 1ns/1ps
module tb_JK_latch;
    reg  clk;
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
    // task check;
    //     reg [1:0] a, b;
    //     begin
    //         for (a = 0; a < 2; a = a + 1) begin
    //             for (b = 0; b < 2; b = b + 1) begin
                    
    //                 j = a; k = b;
                    
    //                 #6;
                   
    //                 $display("j=%b | k=%b | q=%b | qb=%b", j, k, q, qb);
    //             end
    //         end
    //     end
    // endtask

    initial begin
    
        #6 j=0; k=0; 
        #6 j=0;k=1;
        #6 j=1;k=0;
        #6 j=1;k=1;
        #6 j=0; k=0; 
        #6 j=0;k=1;
        #6 j=1;k=0;
        #6 j=1;k=1;

        #10 $finish;
        
    end

endmodule