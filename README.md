README.md -- High-level overview of the 128-bit timing generator
================================================================

# Architechtural description

Conceptually, the operation of the timing device is simple: it has a memory programmed
with a sequence of (pattern, delay-to-next-step) tuples, and when triggered it
steps through the sequence outputting each pattern and then waiting until the delay
expires. However, this simple vision of operation is somewhat complicated by the
required access speed: in order to process 5 32-bit words (4 words of pattern + 1 word
of delay) every 50 ns, the memory must be clocked at 100 MHz. This is achieved by using a
simple single-port memory, which is connected to the PCI bus and clock when the device
is in SETUP mode, but is then disconnected from the PCI bus and switched to a 100 MHz
clock as part of the arming sequence.

With the memory running at 100 MHz, there is very little setup slack time to use the
word fetched on the cycle it is available, so a buffer register is used to improve
pipelining and then a FIFO (in the FetchEngine) is kept full to hide the 2-cycle
latency between requesting a memory fetch and that data being available. The TimingCore
pulls words from the FIFO as it needs them to parse and prepare the next instruction.

# Major blocks

The top-level diagram in `TimingGenerator128b.bdf` consists purely of large blocks
and I/O pins, connected by conduit wires: there is no explicit logic at the top level.

## Clocks

The `Clocks.bdf` block encapsulates the logic and megafunctions which produce the various
clock signals for the device. In particular, it contains the (reprogrammable) PLL which
generates the 100 MHz `MasterClk` frequency from either the 80 MHz `RefClk` on-board
oscillator or the `10MHz` PXI 10 MHz reference. It also buffers the `PCIClock` input
pin onto the global timing net of the FPGA.

## Registers

The `Registers.bdf` block contains the register interface for the board. The registers
themselves are always on the PCI clock; signals from the `MasterClk` domain must be
synchronized down and control bits from the registers are synchronized up.

## SystemController

The `SystemController.bdf` block maintains the large scale state of the device, e.g.
`SETUP`, `ARMING`, `RUN`, `PAUSED`, etc. Changes in the user-visible state are triggered
by signals from the `CommandDecoder`, but the `SystemController` implements the invisible
sequencing required to move between the states.

### System_State state machine

This state machine sequences the transitions between user-visible states. It uses
request/acknowledge protocols to properly switch the clock for the `SequenceBuffer`,
to pre-fill the `TimingCore` during the arming sequence, and to wait for the `TimingCore`
to complete the run through an entire sequence.

## CommandDecoder

The `CommandDecoder.bdf` block implements the parsing of the `CMD` register. The parsing
and validation logic runs in the PCI clock domain and then the command pulses are
synchronized up to the `MasterClk` domain before they exit the block (and are ultimately
fed to the `SystemController`).

## SequenceBuffer

The `SequenceBuffer.bdf` block contains the main RAM block which holds the sequence instructions,
and its switchable interface between the PCI bus and clock domain versus the internal
`MasterClk` domain.

### RAM_Clock_Switch state machine

The transfer between clock domains is sequenced by the state machine in `RAM_Clock_Switch.smf`,
which acts as a request/acknowledge controller: changes to `PCI_Allowed` request a switch
of to which clock domain the RAM is connected, and the change is complete when `PCI_Enabled`
changes to follow the former's value. Both of these signals have synchronizers so that
their I/O pins from the block are in the `MasterClk` clock domain.

## FetchEngine

The `FetchEngine.bdf` block exists to hide the address-to-data pipeline latency of the RAM.
It contains a FIFO fed on one side by a read engine which simply serially reads through
all of RAM (subject to enable and reset signals) and the read side of the FIFO is then
provided to the `TimingCore` block for the latter to pull instruction words as needed with
single-cycle latency.

## TimingCore

The `TimingCore.bdf` block implements the execution of a sequence: the instruction decoding,
the time delay, and the latching of the port values out to the `Output_Driver` block.

### Core_Timing_Loop state machine

The instruction decoding cycle is implemented by the state machine in `Core_Timing_Loop.smf`.
The minimum possible delay is 50 ns, limited by the 5 cycles needed to
  1. fetch and decode the delay instruction
  2. calculate (either fetch or retain) the new port A value
  3. calculate (either fetch or retain) the new port B value
  4. calculate (either fetch or retain) the new port C value
  5. calculate (either fetch or retain) the new port D value

If the specified delay is non-zero, the state machine then holds in `DELAY` state until the
timer expires; if the delay is zero, the state machine short-circuits after calculating
the port D value to immediately begin a new decode cycle.

### Core_Timing_Loop.v hand edits

In order to export the Core\_FState bits from the `Core_Timing_Loop.smf` state machine,
it is necessary to hand edit the `Core_Timing_Loop.v` Verilog file every time it is
recreated from the `.smf` file. The edits consist of adding `core_state[3:0]` to the
end of the parameter list, adding `output [3:0] core_state;` and `reg [3:0] core_state;`
to the appropriate declaration lists, and adding `core_state <= reg_fstate;` to the
first `always @(posedge MasterClk)`..`if (MasterClk) begin` block.

## Output_Drive

The `Output_Drive.bdf` module defines the output drivers for both the ports and
the port bits which are echoed out through the PXI trigger lines.

## Utility blocks

### FFSynchronizer

`FFSynchronizer.bdf` implements a basic flip-flop synchronizer. Note that if
the input clock is faster than the output clock it requires multi-cycle setup times.

### CaptureSynchronizer

`CaptureSynchronizer.bdf` implements a synchronous approximation of a "capture synchronizer".
Rather than aynchronously trap a rising edge by using the input signal as the clock on a
flip-flop (which Quartus intensely dislikes!), it synchronously detects the rising edge
and uses it to trigger a 4-cycle pulse which is then transferred to the second clock
domain and edge-detected down to a single-cycle pulse.

The pulse duration is chosen as 4 cycles because 4 cycles at 100 MHz ensures greater than
1 cycle at 33 MHz.

### SamplingSynchronizer

`SamplingSynchronizer.bdf` implements a bus-sampling synchronizer: it uses a capture
synchronizer to synchronously capture a sample from a multi-wire bus, and then
synchronizes the sampled values down to the lower-frequency output clock.

_Note_: the SamplingSynchronizer does not actually guarantee bus integrity! It will
get it right _most_ of the time, which is enough for the debug registers, but _not_
all of the time.

### Various `*.qip` files

These are the various Altera Megafunction blocks used in the `.bdf` files; their names
and symbols are reasonably self-explanatory.

# Other documentation

CoreTiming.md
:  A textual description of the core decode, delay, and output loop

RegisterMap.md
:  Documentation of the register interface for the device

SequenceFormat.md
:  Documentatoin of the memory format for uploaded sequences

