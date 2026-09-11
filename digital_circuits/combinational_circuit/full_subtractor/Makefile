RTL = rtl/half_subtractor.v rtl/full_subtractor.v
TB = tb/tb_full_subtractor.v
TOP = tb_full_subtractor
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

