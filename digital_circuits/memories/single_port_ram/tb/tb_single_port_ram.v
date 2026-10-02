`timescale 1ns/1ps

module tb_single_port_ram;
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    reg [7:0] t_mem [0:15];
    reg [7:0] exp_dout;
    integer PASS;
    integer FAIL;
    integer i;
    reg [7:0] pattern;

    single_port_ram dut(
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_single_port_ram);
    end

    initial begin
        clk = 0;
        we = 0;
        addr = 4'h0;
        din = 8'h00;
        exp_dout = 8'hxx;
        PASS = 0;
        FAIL = 0;

        pattern = 8'h00;

        forever #5 clk = ~clk;
    end


    task read;
        input [3:0] t_addr;
        begin
           
            @(negedge clk) begin
                we = 0;
                addr = t_addr;
                
            end
            

            @(posedge clk) begin
                exp_dout = t_mem[t_addr];
                #1;
                if(dout === exp_dout) begin
                    $display("PASS | addr = %h | dout = %h | exp_dout = %h", addr,dout, exp_dout);
                    PASS = PASS + 1;
                end
                else begin
                    $display("FAIL | addr = %h | dout = %h | exp_dout = %h", addr,dout, exp_dout);
                    FAIL = FAIL + 1;
                end
                
            end
        end

    endtask



    task write;
        input [3:0] t_addr;
        input [7:0] t_din;
        begin
            
            @(negedge clk) begin
                we = 1;
                addr = t_addr;
                din = t_din;
                
            end

         
            
            @(posedge clk) begin
                t_mem[t_addr] = t_din;
                // #1;
                // exp_dout = t_mem[t_addr];
                // #1;
                // if(dout == t_mem[t_addr]) begin
                //     $display("PASS | addr = %h | dout = %h | exp_dout = %h", addr,dout, exp_dout);
                //     PASS = PASS + 1;
                // end
                // else begin
                //     $display("FAIL | addr = %h | dout = %h | exp_dout = %h", addr,dout, exp_dout);
                //     FAIL = FAIL + 1;
                // end
            end
        end
    endtask

    initial begin
        #7;
        
        write (4'h0, 8'h00);
        for(i=1;i<16;i=i+1) begin
            case (i) 
                1: pattern = 8'hFF;
                2: pattern = 8'h0F;
                3: pattern = 8'hF0;
                4: pattern = 8'h88;
                5: pattern = 8'h11;
                6: pattern = 8'h99;
                7: pattern = 8'h10;
                8: pattern = 8'h01;
                default: pattern = 8'h20 + i;

            endcase
            write (i,pattern);
        end

        #10;
        for(i=0; i<16; i=i+1) begin
            read(i);
        end
        #10;
        write(4'h3,8'hCC);
        read(4'h3);
        read(4'h2);
        read(4'h4);

        #10;
        read(4'h6);
        write(4'h7, 8'h22);
        @(posedge clk) begin
            #1;
            if(dout === 8'h99) begin
                $display("PASS | addr = %6 | dout = %h | exp_dout = %h", addr,dout, 8'h99);
                PASS = PASS + 1;
            end
            else begin
                $display("FAIL | addr = %6 | dout = %h | exp_dout = %h", addr,dout, 8'h99);
                FAIL = FAIL + 1;
            end
        end

        $display("SUMMARY:");
        $display("PASS = %d",PASS);
        $display("FAIL = %d",FAIL);


        #20;
        $finish;
    end



endmodule 