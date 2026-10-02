Simple Dual-Port RAM: Concept and Learning Notes
================================================

What is a simple dual-port RAM?
-------------------------------

A simple dual-port RAM has two access ports with different roles: one port
writes data, and the other port reads data. The read and write can happen on
the same rising clock edge. This differs from a single-port RAM, where one port
must choose between reading and writing, and from a true dual-port RAM, where
both ports can typically read or write.

This exercise uses one shared clock, a synchronous read, and a synchronous
write. It has 16 words, each 8 bits wide. The write port has its own address,
data, and enable. The read port has its own address and enable.

Same-address read and write
---------------------------

If the read and write are both enabled on the same rising edge and their
addresses are equal, this design uses read-first behavior: the read output
gets the old stored value, while the memory is updated with the new write data.
If the addresses differ, the read returns the value at the read address while
the write updates the write address.

The read output is registered. When read enable is low, the output holds its
previous value. The memory array and output are not reset; unwritten locations
are unknown in simulation until written.

RTL learning points
-------------------

- Keep read and write controls and addresses independent.
- Use a clocked process for synchronous access.
- Use nonblocking assignments for clocked memory and output updates.
- Make read-enable behavior and same-address collision behavior explicit.
- Do not reset every memory word unless the target memory technology supports
  it and the specification requires it.

Verification guidance
---------------------

Test writes and reads at multiple addresses, independent simultaneous
read/write to different addresses, and same-address simultaneous access. Also
check output hold when reading is disabled, overwrite behavior, address
independence, and the first read after writing an address. Compare the
same-address result against the selected read-first rule.
