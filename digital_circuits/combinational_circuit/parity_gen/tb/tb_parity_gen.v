`timescale 1ns/1ps
module tb_parity_gen;
    reg [7:0] data;
    wire even_parity, odd_parity;

    parity_gen dut (
        .data(data),
        .even_parity(even_parity),
        .odd_parity(odd_parity)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_parity_gen);
    end

    integer pass=0;
    integer fail=0;

    task check;
        input reg [63:0] case_type;
        input reg [7:0] t_data;
        reg exp_even_parity, exp_odd_parity;
        begin
            data=t_data;
            $display("%s case",case_type);

            exp_even_parity=^data;
            exp_odd_parity=~exp_even_parity;
            #10;
            if(exp_even_parity === even_parity && exp_odd_parity === odd_parity) begin
                $display("PASS: data=%b even_parity=%b odd_parity=%b",data,even_parity,odd_parity);
                pass=pass+1;

            end
            else begin
                $display("FAIL: data=%b even_parity=%b odd_parity=%b | exp_even_parity=%b exp_odd_parity=%b",data,even_parity,odd_parity,exp_even_parity,exp_odd_parity);
                fail=fail+1;
            end
            
        end
    endtask

    initial begin
        check("Boundary",8'h00);
        check("Boundary",8'hFF);

        check("Control",8'b0010_0000);
        check("Control",8'b0000_0100);
        check("Control",8'b0001_0100);
        check("Control",8'b0000_0101);

        check("Isolation",8'b0000_0001);
        check("Isolation",8'b1000_0000);

        check("Transition",8'b0000_0011);
        check("Transition",8'b0000_0001);

        $display("Test summary:");
        $display("PASS:%d",pass);
        $display("FAIL:%d",fail);
    end


endmodule
