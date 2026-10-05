`timescale 1ns/1ps
module tb_register_file;
    parameter DEPTH = 16;
    parameter WIDTH = 8;
    reg clk;
    reg we;
    reg [$clog2(DEPTH)-1:0] wr_addr;
    reg [WIDTH-1:0] wr_data;
    reg [$clog2(DEPTH)-1:0] rd_addr_a;
    wire [WIDTH-1:0] rd_data_a;
    reg [$clog2(DEPTH)-1:0] rd_addr_b;
    wire [WIDTH-1:0] rd_data_b;

    reg [WIDTH-1:0] exp_rd_data_a;
    reg [WIDTH-1:0] exp_rd_data_b;
    reg [WIDTH-1:0] t_mem [0:DEPTH-1];
    reg [WIDTH-1:0] pattern;

    integer PASS = 0;
    integer FAIL = 0;
    integer i;

    register_file #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH)
    ) dut(
        .clk(clk),
        .we(we),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .rd_addr_a(rd_addr_a),
        .rd_data_a(rd_data_a),
        .rd_addr_b(rd_addr_b),
        .rd_data_b(rd_data_b)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_register_file);
    end

    initial begin
        clk = 0;
        we = 0;
        wr_addr = 0;
        wr_data = 0;
        rd_addr_a = 0;
        rd_addr_b = 0;
        exp_rd_data_a=8'hxx;
        exp_rd_data_b=8'hxx;
        forever #5 clk = ~clk;
    end

    task read_a;
        input [3:0] t_addr;
        begin
            rd_addr_a = t_addr;
            exp_rd_data_a = t_mem[t_addr];

            #1;
            if(rd_data_a === exp_rd_data_a) begin
                $display("PASS | rd_addr_a = %h | rd_data_a = %h | exp_rd_data_a = %h",rd_addr_a, rd_data_a,exp_rd_data_a);
                PASS = PASS + 1;
            end
            else begin
                $display("FAIL | rd_addr_a = %h | rd_data_a = %h | exp_rd_data_a = %h",rd_addr_a, rd_data_a,exp_rd_data_a);
                FAIL = FAIL + 1;
            end

        end
    endtask

    task read_b;
        input [3:0] t_addr;
        begin
            rd_addr_b = t_addr;
            exp_rd_data_b = t_mem[t_addr];

            #1;
            if(rd_data_b === exp_rd_data_b) begin
                $display("PASS | rd_addr_b = %h | rd_data_b = %h | exp_rd_data_b = %h",rd_addr_b, rd_data_b,exp_rd_data_b);
                PASS = PASS + 1;
            end                         
            else begin
                $display("FAIL | rd_addr_b = %h | rd_data_b = %h | exp_rd_data_b = %h",rd_addr_b, rd_data_b,exp_rd_data_b);
                FAIL = FAIL + 1;
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
        #3;
        we = 1;
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

        we = 0;
        #8;
        for(i=0;i<8;i=i+1) begin
            #5;
            read_a(i*2);
            #5;
            read_b((i*2)+1);
        end

        #8;
        rd_addr_a = 4'h7;
        exp_rd_data_a = t_mem[4'h7];
        rd_addr_b = 4'h7;
        exp_rd_data_b = t_mem[4'h7];
        #1;
        if(exp_rd_data_a === exp_rd_data_b && rd_data_a === rd_data_b) begin
            $display("PASS | address = %h | rd_data_a = %h | rd_data_b = %h",4'h7, rd_data_a,rd_data_b);
            PASS = PASS + 1;
        end                         
        else begin
            $display("FAIL | address = %h | rd_data_a = %h | rd_data_b = %h",4'h7, rd_data_a,rd_data_b);
            FAIL = FAIL + 1;
        end

        #12;
        wr_addr = 4'h7;
        wr_data = 8'hFF;
        rd_addr_a = 4'h7;
        #20;
        #12;
        we=1;
        wr_addr = 4'h7;
        wr_data = 8'hFF;
        rd_addr_a = 4'h7;
        #20;


        

        $display("SUMMARY");
        $display("PASS = %d",PASS);
        $display("FAIL = %d",FAIL);

        #10;
        $finish;
    end
    

endmodule