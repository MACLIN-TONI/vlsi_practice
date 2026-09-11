DUT ?= mux_4to1_dataflow
RTL = rtl/$(DUT).v
TB = tb/tb_$(DUT).v
TOP = tb_$(DUT)
SIM = sim/sim.out
WAVE = waves/dump.vcd

compile:
	iverilog -g2012 -o $(SIM) $(RTL) $(TB)

run: compile 
	vvp $(SIM)

wave: run
	gtkwave $(WAVE) &

clean:
	rm -f $(SIM) $(WAVE)

.PHONY: compile run wave clean
