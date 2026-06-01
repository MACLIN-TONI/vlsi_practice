`timescale 1ns/1ps
module tb_encoder_4to2;

    reg [3:0] d_in;
    wire [1:0] d_out;
    wire valid;

    encoder_4to2 dut(
        .d_in(d_in),
        .d_out(d_out),
        .valid(valid)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_encoder_4to2);
    end

    integer pass=0;
    integer fail=0;

    task check;
        reg [1:0] i,j,k,l;
        reg [1:0] exp_out;
        reg exp_valid;
        begin
            for(i=0;i<2;i=i+1) begin 
                d_in[3] = i;
                for(j=0;j<2;j=j+1) begin 
                    d_in[2] = j;
                    for(k=0;k<2;k=k+1) begin
                        d_in[1] = k;
                        for(l=0;l<2;l=l+1) begin
                            d_in[0] = l;
                            exp_valid=1'b1;
                            case(d_in)
                                4'b0001:exp_out = 2'b00;
                                4'b0010:exp_out = 2'b01;
                                4'b0100:exp_out = 2'b10;
                                4'b1000:exp_out = 2'b11;
                                default: begin
                                    exp_valid = 1'b0;
                                    exp_out = 2'b00;
                                end

                            endcase
                            #10; 
                            if(exp_out === d_out && exp_valid === valid) begin
                                $display("PASS: d_in=%b d_out=%b valid=%b",d_in,d_out,valid);
                                pass=pass+1;
                            end
                            else begin
                                $display("FAIL: d_in=%b d_out=%b valid=%b | exp_out=%b exp_valid=%b",d_in,d_out,valid,exp_out,exp_valid);
                                fail=fail+1;
                            end
                            
                        end
                    end
                end
            end
        end
    
    endtask

    initial begin
        check();

        $display("Test Summary");
        $display("PASS: %d", pass);
        $display("FAIL: %d", fail);
    end


endmodule