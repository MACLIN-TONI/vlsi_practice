MODULE    : cla_4bit
FUNCTION  : 4-bit addition using carry lookahead
INPUTS    : [3:0] a, b
            cin
OUTPUTS   : [3:0] sum
            carry_out
METHOD    : Pre-compute G[i] and P[i] for all bits
            Derive all carries in parallel
            Compute sum from P[i] and carries
KEY POINT : No carry ripple — all carries computed simultaneously
COMPARE   : Same interface as rca_4bit — same TB works