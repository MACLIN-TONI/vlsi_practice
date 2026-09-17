`timescale 1ns/1ps

module tb_mod_8;
    reg clk;
    reg en;
    reg areset_n;
    reg up_down;
    wire [2:0] out;

    mod_8 dut(
        .clk(clk),
        .en(en),
        .areset_n(areset_n),
        .up_down(up_down),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_mod_8);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en=0;
        areset_n=0;
        up_down=0;
    end


    task check;
        input reg in;
        begin
            up_down = in;
            #1;
            repeat(10) begin
                @(negedge clk)
                $display("en = %b | areset_n = %b | up_down = %b | out = %h", en,areset_n,up_down,out);
            end
        end
    endtask

    initial begin
        #6 en=1;
        #6 areset_n=1;
        #8;
        check(1);
        check(0);
        #20 $finish;
    end
endmodule 