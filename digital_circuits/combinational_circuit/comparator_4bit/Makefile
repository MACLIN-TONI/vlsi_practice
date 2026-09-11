DUT ?= comparator_4bit
RTL = rtl/$(DUT).v
TB = tb/tb_$(DUT).v
TOP = tb_$(DUT)
SIM = sim/sim.out
WAVE = waves/dump.vcd
LOG = docs/$(DUT).log

compile:
	iverilog -g2012 -o $(SIM) $(RTL) $(TB)

run: compile 
	vvp $(SIM) | tee $(LOG)

check: run
	@echo "---FAILURES---"
	@grep "FAIL" $(LOG) || echo "NONE"
	@echo "---SUMMARY---"
	@grep "summary\|PASS\|FAIL" $(LOG) | tail -2

wave: run
	gtkwave $(WAVE) &

clean:
	rm -f $(SIM) $(WAVE) $(LOG)

.PHONY: compile run check wave clean

