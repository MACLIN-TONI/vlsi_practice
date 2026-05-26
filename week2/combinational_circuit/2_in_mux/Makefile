RTL= rtl/mux_2in.v
TB= tb/tb_2_in_mux.v
TOP= tb_2_in_mux
SIM= sim/sim.out
WAVES=waves/dump.vcd

compile:
	iverilog -g2012 -o $(SIM) $(RTL) $(TB)

run: compile
	vvp $(SIM)

wave: run
	gtkwave $(WAVES) &

clean:
	rm -f $(SIM) $(WAVES)

.PHONY: compile run wave clean