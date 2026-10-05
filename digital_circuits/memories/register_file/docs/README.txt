Register File: Concept and Learning Notes
========================================

What is a register file?
------------------------

A register file is a small collection of addressable words used as a fast
storage bank inside a digital system or processor. It usually has several read
ports and one or more write ports so a datapath can read multiple operands in
one cycle and update a destination word on a clock edge.

This exercise specifies a 16-word x 8-bit register file with two independent
combinational read ports and one synchronous write port. Both read ports can
select any word at the same time. The write port updates one selected word on
the rising edge of clk when write enable is high.

Read and write timing
---------------------

The write is synchronous: `wr_addr` and `wr_data` are sampled on the rising
clock edge when `we` is 1. The reads are asynchronous: each read output follows
the contents selected by its read address without waiting for a clock edge.

If a read address selects the word being written, that read output shows the
old value before the active edge and the new value after the write update
settles. This is the natural behavior of a combinational read from the updated
array. The read outputs are not registered.

This design has no reset or hardwired-zero register. Memory contents are
unknown in simulation until written. A testbench should initialize locations
through the write port before checking their values.

RTL learning points
-------------------

- Separate synchronous write logic from combinational read logic.
- Assign each combinational read output for every address to avoid latch
  inference.
- Use independent read addresses and confirm that the ports can return
  different words simultaneously.
- Understand that additional read ports generally require more read-selection
  logic and can affect area, timing, and memory inference.
- For a processor-style register file, a later exercise can reserve address 0
  as a constant-zero register and ignore writes to it; this version does not.

Verification guidance
---------------------

Write and read back multiple words. Test both read ports selecting different
addresses and the same address. Change each read address without a clock and
confirm the corresponding output follows it. Also test simultaneous reads and
writes, write enable low, overwrites, boundary addresses, and both read ports
pointing at a word while it is written.
