RTL = rtl/half_adder.v rtl/full_adder.v
TB = tb/tb_full_adder.v
TOP = tb_full_adder
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