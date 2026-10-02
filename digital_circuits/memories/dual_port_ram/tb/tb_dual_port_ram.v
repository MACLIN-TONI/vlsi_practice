`timescale 1ns/1ps
module tb_dual_port_ram;
    reg clk;
    reg we;
    reg [3:0] wr_addr;
    reg [7:0] wr_data;
    reg re;
    reg [3:0] rd_addr;
    wire [7:0] rd_data;


    reg [7:0] exp_rd_data;
    reg [7:0] pattern;
    integer PASS;
    integer FAIL;
    integer i;
    reg [7:0] t_mem [0:15];

    dual_port_ram#(
        .DEPTH(16),
        .WIDTH(8)
    ) dut
    (
        .clk(clk),
        .we(we),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .re(re),
        .rd_addr(rd_addr),
        .rd_data(rd_data)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_dual_port_ram);
    end

    initial begin
        clk = 0;
        we = 0;
        wr_addr = 4'h0;
        wr_data = 8'h00;
        re = 0;
        rd_addr = 4'h0;
        exp_rd_data = 8'hxx;
        PASS = 0;
        FAIL = 0;
        pattern = 0;
        forever #5 clk = ~clk;
    end

    task read;
        input [3:0] t_addr;
        begin
            @(negedge clk) rd_addr = t_addr;

            @(posedge clk) begin
                if(re) exp_rd_data = t_mem[t_addr];
                #1;
                if(rd_data === exp_rd_data) begin
                    $display("PASS | re = %b | rd_addr = %h | rd_data = %h | exp_rd_data = %h",re, rd_addr, rd_data,exp_rd_data);
                    PASS = PASS + 1;
                end
                else begin
                    $display("FAIL | re = %b | rd_addr = %h | rd_data = %h | exp_rd_data = %h",re, rd_addr, rd_data,exp_rd_data);
                    FAIL = FAIL + 1;
                end
            end

        end
    endtask

    task write;
        input [3:0] t_addr;
        input [7:0] t_wr_data;
        begin
            @(negedge clk) begin
                wr_addr = t_addr;
                wr_data = t_wr_data;
            end

            @(posedge clk) begin
                if(we) t_mem[t_addr] = t_wr_data;
            end
        end
    endtask

    initial begin
        #2;
        we =1;
        for(i=0;i<16;i=i+1) begin
            case(i)
                0: pattern = 8'hFF;
                1: pattern = 8'h00;
                2: pattern = 8'hF0;
                3: pattern = 8'h0F;
                4: pattern = 8'hAA;
                5: pattern = 8'h55;
                6: pattern = 8'h10;
                7: pattern = 8'h01;
                8: pattern = 8'h80;
                9: pattern = 8'h08;
                default: pattern = 8'h90 + i;
            endcase
            write(i,pattern);
        end
        we =0;
        #3;
        re = 1;
        for(i=0;i<16;i=i+1) begin
            read(i);
        end

        #7; re =1; we =1;
        read(4'h5);
        write(4'h5,8'h77);
        read(4'h5);

        #7; re = 0;
        read(4'h9);

        #8; we=0;
        write(4'h9,8'hFF);
        re=1;
        read(4'h9);


        $display("SUMMARY");
        $display("PASS = %d",PASS);
        $display("FAIL = %d",FAIL);

        #10;
        $finish;
    end

endmodule