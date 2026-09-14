`timescale 1ns/1ps

module tb_SISO;
    reg clk;
    reg en;
    reg areset_n;
    reg in;
    wire out;

    SISO dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_SISO);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;

    end

    // task check;
    //     reg [2:0] i,j; 
    //     begin
    //         for(i=0;i<2;i=i+1) begin
    //             for(j=0;j<2;j=j+1) begin
    //                 @(negedge clk) en=i;
    //                 @(negedge clk) areset_n=j;
    //                 @(negedge clk) in = $urandom_range(0,1);
    //                 #1;
    //                 $display("en = %b | areset_n = %b | in = %b | out = %b ", en,areset_n,in,out);

    //             end
    //         end        
    //     end

    // endtask
    initial begin
        en=0;
        areset_n=0;      
    end

    initial begin

        #5; en=1;
        #5; areset_n=1;
        repeat(4) begin
            @(negedge clk) in = $urandom_range(0,1); 
        end
        #5; en=1;
        #5; areset_n=0;
        #10; areset_n=1;
        repeat(4) begin
            @(negedge clk) in = $urandom_range(0,1); 
        end
        #50;
        $finish;
    end

endmodule