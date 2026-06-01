DUT ?= priority_encoder_4to2
RTL = rtl/$(DUT).v
TB = tb/tb_$(DUT).v
TOP = tb_$(DUT)
SIM = sim/sim.out
WAVE = waves/dump.vcd
LOG = docs/$(DUT).log

compile: 
	iverilog -g2012 -o  $(SIM) $(RTL) $(TB)

run: compile
	vvp $(SIM) | tee $(LOG)

wave: run
	gtkwave $(WAVE) &

clean:
	rm -f $(SIM) $(WAVE) $(LOG)

.PHONY: compile run wave clean
