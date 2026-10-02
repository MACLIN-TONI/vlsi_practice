Single-Port RAM
===============

A single-port RAM is a memory block with one address port. On each clock edge,
that port can perform a write or a read. Control signals select the operation.

Basic signals
-------------

- clk: synchronizes memory operations.
- we: write enable. When high at a rising clock edge, din is written to the
  selected address.
- addr: selects the memory word to access.
- din: data to write.
- dout: data returned by a read.

For a RAM with depth D and word width W, the storage contains D x W bits. The
address width is ceil(log2(D)) bits. For example, a 16-word RAM with 8-bit
words has 128 storage bits and a 4-bit address.

Typical synchronous behavior
----------------------------

At each rising edge:

- If we is high, write din to mem[addr].
- If we is low, read mem[addr] into dout.

This gives a registered, one-cycle read: the address is sampled on a clock
edge, and dout updates after that edge. Between clock edges, dout holds its
previous value.

Read/write collision behavior
-----------------------------

If a read and write target the same address on the same edge, define what the
output should do. Common choices are:

- Read-first: dout gets the old stored value.
- Write-first: dout gets the new input value.
- No-change: dout keeps its previous value.

For an initial learning design, read-first is a useful choice to document.
With typical nonblocking assignment behavior, the read sees the old memory
value while the write updates storage at the same edge.

Reset and uninitialized contents
--------------------------------

RAM storage is usually not reset in RTL, since resetting every bit can prevent
the hardware tool from inferring a memory block. The output register can be
reset if desired. Until a location has been written, its value is unknown in
simulation, so the testbench should write locations before checking them.

Design decisions
----------------

Before coding, decide the depth, word width, whether reads are enabled, whether
dout holds when no read occurs, reset behavior, and read/write collision
behavior.
