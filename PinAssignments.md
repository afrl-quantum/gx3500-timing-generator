Pin assignments for 128-bit timing generator
============================================

The 4 ports are spread out over the 4 connectors with one port per
connector, since that will make it easier to use multiple boxes for
the breakouts if needed. The special channels are all on the first
FlexIO connector.

Port A: `FlexIO[31..0]`
Port B: `FlexIO[71..40]`
Port C: `FlexIO[111..80]`
Port D: `FlexIO[151..120]`

External trigger input: `FlexIO[32]`
Trigger indicator: `FlexIO[33]` (goes HIGH when the card enters the `RUN` state)
External clock input: `FlexIO[34]` (*is this the best choice for noise immunity?*)
Sequence transition indicator: `FlexIO[35]` (pulses HIGH for 20 ns when a new pattern is output)

