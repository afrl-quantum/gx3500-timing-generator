# Clock constraints

# real clocks
create_clock -name "RefClk" -period 12.500ns [get_ports {RefClk}]
create_clock -name "PCIClock" -period 30.303ns [get_ports {PCIClock}]
create_clock -name "10MHz" -period 100.00ns [get_ports {"10MHz"}]

# "clocks" for capture synchronizers
# set these loose, because they aren't actually clocking anything!
#create_clock -name "CS[2]" -period 30.303ns [get_ports {CS[2]}]
#create_clock -name "Addr[2]" -period 30.303ns [get_ports {Addr[2]}]

# virtual clock for the PCI IO
#create_clock -name "PCIClock_ext" -period 30.303ns

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks
 
create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|outclk}] \
	-name "RAM_PCI" \
	-source [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|inclk[0]}]
#	-master_clock [get_clocks {PCIClock}]

create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|outclk}] \
	-add \
	-name "RAM_Master" \
	-source [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_0fi_component|clkctrl1|inclk[2]}]
#	-master_clock [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}]

set_clock_groups -logically_exclusive -group {RAM_PCI PCIClock} -group {RAM_Master}

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
set_false_path -from [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}] \
	-through [get_pins -compatibility_mode fetcher\|addrff*] \
	-to [get_clocks {RAM_PCI}]

#set_false_path -from [get_clocks {RAM_PCI}] \
#	-through [get_pins -compatibility_mode sequencebuffer\|RAM\|*] \
#	-to [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}]

set_false_path -to [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}] \
	-through [get_pins -compatibility_mode sequencebuffer\|RAM_Qreg*] \
	-from [get_clocks {RAM_PCI}]

set_false_path -from [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}] \
	-through [get_pins -compatibility_mode sequencebuffer\|RAMGate*] \
	-to [get_clocks {RAM_PCI}]
	
# tsu/th constraints

set_input_delay -clock PCIClock -min 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]
set_input_delay -clock PCIClock -add -max 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]

set_output_delay -clock PCIClock -min -1ns [get_ports {FDt[*]}]
set_output_delay -clock PCIClock -add -max 2ns [get_ports {FDt[*]}]

# tco constraints

# tpd constraints

# loose constraints for the Ports
set_output_delay -clock clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0] -min -1ns [get_ports {PxiTrig* FlexIO*}]
set_output_delay -clock clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0] -add -max 2ns [get_ports {PxiTrig* FlexIO*}]

set_max_delay 200.0ns -to [get_ports {PxiTrig* FlexIO*}]
set_min_delay -200.0ns -to [get_ports {PxiTrig* FlexIO*}]

# and loose constraints for MClr
set_input_delay -clock PCIClock -min -1ns [get_ports {MClr}]
set_input_delay -clock PCIClock -add -max 2ns [get_ports {MClr}]

set_multicycle_path -setup -start -from [get_ports {MClr}] 10
set_multicycle_path -hold -start -from [get_ports {MClr}] 9

set_max_delay 200.0ns -to [get_ports {MClr}]
set_min_delay -200.0ns -to [get_ports {MClr}]
