ROM: Concept and Learning Notes
===============================

What is a ROM?
--------------

A read-only memory (ROM) maps an address to a value stored in a fixed lookup
table. The address selects one entry; the selected entry appears at the output.
Unlike RAM, this design has no write input and does not change its contents
while operating.

This project is a 16-entry x 8-bit combinational ROM. It maps a 4-bit
hexadecimal digit to the segment pattern for a seven-segment display. The
lookup contents are constants described by the RTL.

How this differs from the single-port RAM
-----------------------------------------

- The ROM has no clock, write enable, or write data input.
- Its output is combinational: when the address changes, the output changes
  after combinational propagation; it does not wait for a clock edge.
- The ROM contents are fixed. The RAM stores values written during operation.

Output encoding
---------------

The 8-bit output uses active-high segments:

- data[6:0] = {g, f, e, d, c, b, a}
- A bit value of 1 turns that segment on.
- data[7] is the decimal point and is always 0 (off).

For example, hexadecimal 0 turns on segments a through f and turns off g, so
the output is 8'h3F. Hexadecimal 1 turns on only segments b and c, so the
output is 8'h06.

RTL design guidance
-------------------

Use a combinational process such as `always @(*)` with a `case` statement.
Assign the output for every possible 4-bit address so no latch is inferred.
Use explicit 8-bit constants. Include a default assignment as a defensive
fallback for unknown or unexpected simulation values; all 16 binary addresses
are covered by the table.

Verification guidance
---------------------

Check all 16 address-to-pattern mappings. Also change the address between
clock edges (there is no clock in this design) and confirm the output follows
it without a clock. Check that every binary address produces a defined value
and that the decimal-point bit remains off.
