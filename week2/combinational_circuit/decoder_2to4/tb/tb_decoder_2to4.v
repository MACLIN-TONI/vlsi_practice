`timescale 1ns/1ps
module tb_decoder_2to4;
    reg en;
    reg [1:0] din;
    wire [3:0] out;
    decoder_2to4 dut (
        .en(en),
        .din(din),
        .out(out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_decoder_2to4);
    end
    integer pass=0;
    integer fail=0;
    task check;
        integer i,j;
        integer exp_out;
        begin
            for(i=0;i<2;i=i+1) begin 
                en=i;
                for(j=0;j<4;j=j+1) begin
                    din=j;
                    exp_out=i?1<<j:0;

                    #10;
                    if(exp_out === out) begin
                        $display("PASS: en=%b din=%b out=%b",en,din,out);
                        pass=pass+1;
                    end
                    else begin
                        $display("FAIL: en=%b din=%b out=%b | exp_out=%b", en,din,out,exp_out);
                        fail=fail+1;
                    end

                end
            end
        end
    endtask

    initial begin
        check();
        $display("TEST SUMMARY:");
        $display("PASS:%d", pass);
        $display("FAIL:%d", fail);
        $finish;
    end

endmodule