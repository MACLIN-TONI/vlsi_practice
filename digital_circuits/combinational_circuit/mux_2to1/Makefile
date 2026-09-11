DUT ?= mux_2to1_dataflow
RTL = rtl/$(DUT).v
TB = tb/tb_$(DUT).v
TOP = tb_$(DUT)
SIM = sim/sim.out
WAVES = waves/dump.vcd

compile:
	iverilog -g2012 -o $(SIM) $(RTL) $(TB)

run: compile
	vvp $(SIM)

wave: run 
	gtkwave $(WAVES) &

clean:
	rm -f $(SIM) $(WAVES)


.PHONY: compile run wave clean
