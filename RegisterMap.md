Register map for 128-bit timing generator
=========================================

The timing generator is configured through register space (PCI BAR 1), and currently
supports 19 32-bit registers over a 32 word address space (0x0000 - 0x007f).

---------------------------------------------------------------
| Index |  Address | Register function (Mnemonic)     | `R/W` |
|-------|----------|----------------------------------|-------|
|   `0` | `0x0000` | Port A reset value (`RESET_A`)   |  `RW` |
|   `1` | `0x0004` | Port B reset value (`RESET_B`)   |  `RW` |
|   `2` | `0x0008` | Port C reset value (`RESET_C`)   |  `RW` |
|   `3` | `0x000c` | Port D reset value (`RESET_D`)   |  `RW` |
|   `4` | `0x0010` | PXI3-0 routing table (`PXI_RT1`) |  `RW` |
|   `5` | `0x0014` | PXI7-4 routing table (`PXI_RT2`) |  `RW` |
|   `6` | `0x0018` | Cycle repeat limit (`N_REPS`)    |  `RW` |
|   `7` | `0x001c` | Config register (`CONFIG`)       |  `RW` |
|   `8` | `0x0020` | Command register (`CMD`)         |  ` W` |
|   `9` | `0x0024` | Status register (`STATUS`)       |  `RW` |
|  `10` | `0x0028` | Current step counter (`STEP`)    |  `R ` |
|  `11` | `0x002c` | Cycle repeat count (`REP_CNT`)   |  `R ` |
|  `12` | `0x0030` | Port A readback (`OUTPUT_A`)     |  `R ` |
|  `13` | `0x0034` | Port B readback (`OUTPUT_B`)     |  `R ` |
|  `14` | `0x0038` | Port C readback (`OUTPUT_C`)     |  `R ` |
|  `15` | `0x003c` | Port D readback (`OUTPUT_D`)     |  `R ` |
|  `16` | `0x0040` | Current time hiword (`TIME_HI`)  |  `R ` |
|  `17` | `0x0044` | Current time loword (`TIME_LO`)  |  `R ` |
|       |          |             ...                  |       |
|  `30` | `0x0078` | Debug information (`DEBUG`)      |  `R ` |
|  `31` | `0x007c` | Board ID & version (`VERSION`)   |  `R ` |
---------------------------------------------------------------

Register descriptions
---------------------

#### `RESET_A` -- `RESET_D`

These registers define the bit pattern output on Ports A-D when the sequence is in the
STOP state.

#### `PXI_RT1` -- `PXI_RT2`

`PXI_RT1` consists of four 8-bit fields

-------------------------------------------------------------
|`E3`|`SOURCE3`|`E2`|`SOURCE2`|`E1`|`SOURCE1`|`E0`|`SOURCE0`|
-------------------------------------------------------------

where `En` enables the card to drive PXI trigger `n` and `SOURCEn` is the 7-bit channel
number which should be connected to the PXI trigger. `PXI_RT2` has the same format
and controls PXI triggers 7-4.

#### `N_REPS`

This register sets the number of times the card should execute a sequence before
returning to the `SETUP` state. If `CONFIG:AUTO_TRIGGER` is set, the card will
re-arm and soft-trigger itself upon completion of the sequence.
If `CONFIG:AUTO_TRIGGER` is cleared, the card will re-arm but *not* trigger upon
completion of each sequence.

If `N_REPS` is 0, the card will continuously re-arm (and re-trigger if
`CONFIG:AUTO_TRIGGER` is set) upon completion of a sequence.

#### `CONFIG`

The configuration register consists of two blocks. Bits 31..16 should be set to the
(unsigned) number of steps in the sequence being programmed.

-----------------------------------------------------------
| number of steps[31..16] |X|X|X|X|X|X|X|X|X|X|X|X|`A`|X|`M`|`T`|
-----------------------------------------------------------

`T`
:   `TRIG_ENABLE` -- set this bit to unmask the external trigger input

`M`
:   `REFCLK_10MHZ` -- if set, the Master Clock is derived from the PXI 10 MHz
    clock. If clear, the Master Clock is derived from the card's own 80 MHz
    onboard oscillator. **This is not currently implemented as a software bit**

`A`
:   `AUTO_TRIGGER` -- if set, the card will automatically soft-trigger itself upon
    completion of the arming sequence. This means that the `ARM` command implicitly
    contains a `TRIGGER` command, and the card will also automatically re-trigger itself
    if it is programmed for multiple repetitions of the sequence.

#### `CMD`

The command register is a write-only register used to change the state of the card.

----------------------------------------------------------
| Command value | Action                                 |
|---------------|----------------------------------------|
|      `0x0000` | No operation                           |
|      `0x0001` | `ARM`: move from `SETUP` to `READY`    |
|      `0x0002` | `TRIGGER`: move from `READY` to `RUN`  |
|      `0x0003` | `PAUSE`: move from `RUN` to `PAUSED`   |
|      `0x0004` | `RESUME`: move from `PAUSED` to `RUN`  |
|      `0x0005` | `STOP`: move from any state to `SETUP` |
|  `0xXXXXXXXX` | (Undefined commands)                   |
----------------------------------------------------------

If an undefined command is written, the bit `STATUS:ERR_BAD_CMD` is latched. If
a command is issued in an inappropriate state (e.g. `ARM` when in `PAUSED`),
the bit `STATUS:ERR_INAPPROPRIATE_STATE` is latched.

#### `STATUS`

The status register consists of two parts, a readback of the current state in
`STATUS[2:0]` and a set of latched error bits. The error
bits are set to 1 when an error is detected and may be cleared by writing 1 to the
appropriate bit in the register. Writes to State\[2:0] and `F` are ignored.

-----------------------------------------------------------------------------------------------
|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|`O`|`L`|`F`|`U`|`A`|`I`|`R`|`P`|`D`|`S`|`B`|X| State\[2:0] |
-----------------------------------------------------------------------------------------------

State\[2:0]
:   The current state of the card:
    --------------------
    | Value | State    |
    |-------|----------|
    | 0b000 | SETUP    |
    | 0b001 | READY    |
    | 0b010 | RUN      |
    | 0b011 | PAUSED   |
    | 0b100 | ARMING   |
    | 0b101 | STOPPING |
    | 0b11X |   ---    |
    --------------------

`B`
:   `ERR_BAD_CMD` -- an undefined command number was written to the `CMD` register

`S`
:   `ERR_INAPPROPRIATE_STATE` -- a command was requested in a state not appropriate
    to that command

`D`
:   `ERR_BAD_DURATION` -- a sequence step requested a duration of &lt;50 ns (i.e. the
    duration was specified as 0-4 Master Clock ticks). The step was automatically
    extended to to 50 ns and this status bit was latched.

`P`
:   `ERR_BAD_PCI_ACCESS` -- PCI access to the sequence buffer was detected while the
    card was not in the `SETUP` state.

`R`
:   `WARN_BAD_REFCLK` -- the card cannot lock to the onboard 80 MHz reference clock

`I`
:   `WARN_NO_PXI_CLOCK` -- the card does not detect a valid 10 MHz PXI clock

`A`
:   `BUG_BAD_RAM_ACCESS` -- an internal error resulted in the card attempting to
    access the RAM while it was attached to the PCI interface

`U`
:   `BUG_FIFO_UNDERFLOW` -- an internal error resulted in the card causing a FIFO
    underflow in the instruction fetch block

`F`
:   `BUG_FETCH_NO_LOAD` -- an internal error resulted in the card fetching a word
    from the FIFO but not using it
    
`L`
:   `BUG_LOAD_NO_FETCH` -- an internal error resulted in the card loading a nonsense
    word because no FIFO fetch was requested beforehand

`O`
:   `BUG_FIFO_OVERFLOW` -- an internal error resulted in the card attempting to write
    a word to the FIFO when it was full

#### `STEP`

A 32-bit readback of the current 0-based step index. Reads as 0 when the card is
in `SETUP`.

#### `REP_CNT`

A 32-bit readback of the number of repetitions completed, i.e. the card is currently
executing the `REP_CNT+1`th repetition. Reads as 0 when the card is in `SETUP`.

#### `OUTPUT_A` -- `OUTPUT_D`

Read-back registers of the bit patterns currently outputted on Ports A-D, respectively. The
values may are not guaranteed to be cycle-accurate, since the Master Clock is not synchronous
to the PCI clock.

#### `TIME_HI` and `TIME_LO`

Read-back registers of the current sequence time stamp, in the 10 ns units of the Master Clock.
Since the Master Clock is not synchronous to the PCI clock, `TIME_HI` should be read before
and again after reading `TIME_LO` to detect major roll-overs. If the two values of `TIME_HI`
differ, the reads should be repeated.

#### `DEBUG`

A read-back register of assorted bits of internal state, useful for debugging the hardware.

---------------------------------------------------------------------------------------
| `Core_FState[8..0]` | `System_FState[7..0]` |X|X|X|X|X|X|X|X|X|X|`D`|`L`|`T`|`P`|`B`|
---------------------------------------------------------------------------------------

`B`
:   Buffer_Empty

`P`
:   PCI_Enabled

`T`
:   Run_Timer

`L`
:   Load_Instructions

`D`
:   Dynamic_Output

`System_FState`
:   A mirror of the internal `fstate` register of System\_State.{v,smf}

`Core_FState`
:   A mirror of the internal `fstate` register of Core\_Timing\_Loop.{v,smf}

#### `VERSION`

A constant indicating the card program and revision. It will read as `0xafd0MMNN`, denoting
Air Force Digital Output, major revision MM, minor revision NN.

