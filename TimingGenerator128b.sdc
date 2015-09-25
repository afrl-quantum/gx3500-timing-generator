# Clock constraints

# real clocks
create_clock -name "RefClk" -period 12.500ns [get_ports {RefClk}]
create_clock -name "PCIClock" -period 30.303ns [get_ports {PCIClock}]
create_clock -name "10MHz" -period 100.00ns [get_ports {"10MHz"}]

# virtual clock for the digital out pins
create_clock -name "OutputClk_virt" -period 10.0ns

# TimeQuest can't automatically derive clocks from a PLL with multiple possible inputs,
# so manually generate the PLL clocks.
create_generated_clock -name PLL_Ref \
	-source [get_pins {clocks|refclk_mux|PllSourceSwitch_altclkctrl_uhi_component|clkctrl1|inclk[0]}] \
	-divide_by 4 \
	-multiply_by 5 \
	[get_pins {clocks|pll|altpll_component|auto_generated|pll1|clk[0]}]

create_generated_clock -name PLL_PXI -add \
	-source [get_pins {clocks|refclk_mux|PllSourceSwitch_altclkctrl_uhi_component|clkctrl1|inclk[1]}] \
	-multiply_by 10 \
	[get_pins {clocks|pll|altpll_component|auto_generated|pll1|clk[0]}]

# Also manually create derived clocks to model the switchable RAM clock	
create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|outclk}] \
	-name "RAM_PCI" \
	-source [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|inclk[0]}]
#	-master_clock [get_clocks {PCIClock}]

create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|outclk}] \
	-add \
	-name "RAM_Master_PXI" \
	-source [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|inclk[2]}] \
	-master_clock [get_clocks {PLL_PXI}]

create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|outclk}] \
	-add \
	-name "RAM_Master_Ref" \
	-source [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|inclk[2]}] \
	-master_clock [get_clocks {PLL_Ref}]

set_clock_groups -logically_exclusive -group {RAM_PCI PCIClock} -group {PLL_PXI RAM_Master_PXI} -group {PLL_Ref RAM_Master_Ref}

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# Set multicycle paths for the UsePCIClock signal
set_multicycle_path -start -setup \
	-to {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|ena_reg} \
	2
set_multicycle_path -start -setup \
	-to {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|select_reg*} \
	2
set_multicycle_path -start -hold \
	-to {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|ena_reg} \
	1
set_multicycle_path -start -hold \
	-to {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|select_reg*} \
	1

# Set multicycle paths for the synchronizers we use
# capture synchronizers
set_multicycle_path -start -setup \
	-from {*|CaptureSynchronizer:*|captureff*} \
	-to {*|CaptureSynchronizer:*|lock*} \
	2

set_multicycle_path -start -hold \
	-from {*|CaptureSynchronizer:*|captureff*} \
	-to {*|CaptureSynchronizer:*|lock*} \
	1

# flip-flop synchronizers
set_multicycle_path -start -setup \
	-from {*|FFSynchronizer:*|a*} \
	-to {*|FFSynchronizer:*|b*} \
	2

set_multicycle_path -start -hold \
	-from {*|FFSynchronizer:*|a*} \
	-to {*|FFSynchronizer:*|b*} \
	1

# Tell TimeQuest that the timing core doesn't try to access the RAM when it is using RAM_PCI
# as its clock
set_false_path -from [get_clocks {PLL_Ref PLL_PXI}] \
	-through [get_pins -compatibility_mode fetcher\|addrff*] \
	-to [get_clocks {RAM_PCI}]

#set_false_path -from [get_clocks {RAM_PCI}] \
#	-through [get_pins -compatibility_mode sequencebuffer\|RAM\|*] \
#	-to [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}]

set_false_path -to [get_clocks {PLL_Ref PLL_PXI}] \
	-through [get_pins -compatibility_mode sequencebuffer\|RAM_Qreg*] \
	-from [get_clocks {RAM_PCI}]

set_false_path -from [get_clocks {PLL_Ref PLL_PXI}] \
	-through [get_pins -compatibility_mode sequencebuffer\|RAMGate*] \
	-to [get_clocks {RAM_PCI}]

# faddrffa|ena is gated on RAMClock == RAM_Master
set_false_path -to [get_clocks {PLL_Ref PLL_PXI}] \
	-through [get_pins -compatibility_mode sequencebuffer\|faddrffa*] \
	-from [get_clocks {RAM_PCI}]

# faddrffb doesn't change at all on RAM_PCI
set_multicycle_path -start -setup \
	-from [get_clocks {RAM_PCI}] \
	-through [get_pins -compatibility_mode sequencebuffer\|faddrffb*] \
	2

set_multicycle_path -start -hold \
	-from [get_clocks {RAM_PCI}] \
	-through [get_pins -compatibility_mode sequencebuffer\|faddrffb*] \
	2

# don't try to constrain the HW_Trigger line (FlexIO[33]): it is completely asynchronous
# to the system
set_false_path -from [get_ports {FlexIO33}] -to {IOLines:inst|cap}

# tsu/th constraints

set_input_delay -clock PCIClock -min 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]
set_input_delay -clock PCIClock -add -max 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]

set_output_delay -clock PCIClock -min -1ns [get_ports {FDt[*]}]
set_output_delay -clock PCIClock -add -max 2ns [get_ports {FDt[*]}]

# tco constraints

# tpd constraints

# loose constraints for the Ports
set_output_delay -clock OutputClk_virt -min -1ns [get_ports {PxiTrig* FlexIO*}]
set_output_delay -clock OutputClk_virt -add -max 2ns [get_ports {PxiTrig* FlexIO*}]

set_max_delay 200.0ns -to [get_ports {PxiTrig* FlexIO*}]
set_min_delay -200.0ns -to [get_ports {PxiTrig* FlexIO*}]

# and loose constraints for MClr
set_input_delay -clock PCIClock -min -1ns [get_ports {MClr}]
set_input_delay -clock PCIClock -add -max 2ns [get_ports {MClr}]

set_multicycle_path -setup -start -from [get_ports {MClr}] 10
set_multicycle_path -hold -start -from [get_ports {MClr}] 9

set_max_delay 200.0ns -to [get_ports {MClr}]
set_min_delay -200.0ns -to [get_ports {MClr}]
