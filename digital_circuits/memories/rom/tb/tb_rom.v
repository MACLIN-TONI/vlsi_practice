`timescale 1ns/1ps
module tb_rom;
    reg [3:0] addr;
    wire [7:0] data;
    reg [7:0] exp_data;

    integer PASS;
    integer FAIL;
    integer i;

    rom dut(
        .addr(addr),
        .data(data)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_rom);
    end

    task check;
        input [3:0] t_addr;
        begin
            addr = t_addr;
            case (t_addr)
            0: exp_data = 8'h3F;
            1: exp_data = 8'h06;
            2: exp_data = 8'h5B;
            3: exp_data = 8'h4F;
            4: exp_data = 8'h66;
            5: exp_data = 8'h6D;
            6: exp_data = 8'h7D;
            7: exp_data = 8'h07;
            8: exp_data = 8'h7F;
            9: exp_data = 8'h6F;
            4'hA: exp_data = 8'h77;
            4'hB: exp_data = 8'h7C;
            4'hC: exp_data = 8'h39;
            4'hD: exp_data = 8'h5E;
            4'hE: exp_data = 8'h79;
            4'hF: exp_data = 8'h71;
            default: exp_data = 8'h00;

        endcase
        #1;
        if(exp_data === data) begin
            $display("PASS | addr = %h | data = %h | exp_data = %h", addr, data, exp_data);
            PASS = PASS + 1;
        end
        else begin
            $display("FAIL | addr = %h | data = %h | exp_data = %h", addr, data, exp_data);
            FAIL = FAIL + 1;
        end
        end
    endtask

    initial begin
        PASS = 0;
        FAIL = 0;
        for(i=0;i<16;i=i+1) begin
            check(i);
            #5;
        end

        $display("SUMMARY");
        $display("PASS = %d",PASS);
        $display("FAIL = %d",FAIL);
        
        #20;
        $finish;
    end
endmodule