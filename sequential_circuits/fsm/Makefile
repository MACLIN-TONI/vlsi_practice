RTL = rtl/fsm.v 
TB = tb/tb_fsm.v
TOP = tb_fsm
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