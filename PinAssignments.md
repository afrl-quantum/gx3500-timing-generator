Pin assignments for 128-bit timing generator
============================================

The 4 ports are spread out over the 4 connectors with one port per
connector, since that will make it easier to use multiple boxes for
the breakouts if needed. The special channels are all on the first
FlexIO connector. Note that due to VCCIO requirements, the ports
use 2.5V signaling, not 3.3V LVTTL.

Port A\[31..0]: `FlexIO[31..0]`
Port B\[31..0]: `FlexIO[71..40]`
Port C\[31..0]: `FlexIO[111..80]`
Port D\[31..0]: `FlexIO[151..120]`

External trigger input: `FlexIO[32]`
Trigger indicator: `FlexIO[33]` (goes HIGH when the card enters the `RUN` state)
External clock input: `FlexIO[34]` (*is this the best choice for noise immunity?*)
Sequence transition indicator: `FlexIO[35]` (pulses HIGH for 20 ns when a new pattern is output)

