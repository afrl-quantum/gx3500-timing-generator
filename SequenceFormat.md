Sequence format for 128-bit timing generator
============================================

Sequences are loaded into the memory bank of the card (PCI BAR2 address space). Each
sequence consists of a set of variable-length time-step instructions, beginning at
address `0x00000000`. The instruction format consists of a 32-bit word containing
a 4-bit port mask and a 28-bit delay (in units of 10 ns) and then is followed by
one 32-bit pattern word for each port specified in the mask:

-------------------------------
|`A`|`B`|`C`|`D`| delay\[27:0] |
-------------------------------

where `A`--`D` are 1 if there is a new pattern for that port, or 0 if the pattern
from the previous step should be held over. (For the initial instruction, the
"previous step" is the reset values specified in registers `RESET_A`--`RESET_D`.)

As an illustrative example, consider the instruction 0x9000'0100 0x8888'8888 0x1111'1111.
The first word contains a port mask of 0x9, indicating `A`=1, `B`=0, `C`=0, `D`=1,
and a delay of 0x100. This instruction therefore states that port A should output
0x8888'8888, ports B and C should retain their previous values, and port D should output
0x1111'1111. The card will hold these values for 2.56 us before executing the next
instruction.

The first instruction's pattern is output immediately upon triggering. The last
instruction's pattern is held for its specified duration, and then the sequence ends.
If there are repetitions remaining and the `CONFIG:AUTO_TRIGGER` bit is set, then
the last instruction's pattern is held for several additional Master Clock cycles
while the card re-arms and triggers itself. Otherwise, the reset values are output
while the card waits in the `ARMED` or `SETUP` states.

