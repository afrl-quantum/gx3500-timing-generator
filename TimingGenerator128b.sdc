# Clock constraints

# real clocks
create_clock -name "RefClk" -period 12.500ns [get_ports {RefClk}]
create_clock -name "PCIClock" -period 30.303ns [get_ports {PCIClock}]
create_clock -name "10MHz" -period 100.00ns [get_ports {"10MHz"}]

# create_clock -name "ExtClk_10MHz" -period 100.00ns [get_ports {FlexIO34}]

# "clocks" for capture synchronizers
# set these loose, because they aren't actually clocking anything!
#create_clock -name "CS[2]" -period 30.303ns [get_ports {CS[2]}]
#create_clock -name "Addr[2]" -period 30.303ns [get_ports {Addr[2]}]

# virtual clock for the PCI IO
create_clock -name "PCIClock_ext" -period 30.303

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

#create_generated_clock [get_pins {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}] \
#	-name "MasterClk" \
#	-source "RefClk" \
#	-multiply_by 5 \
#	-divide_by 4

# the PCI clock is in a different domain from the PLL outputs
#set_clock_groups -asynchronous -group {PCIClock} \
#    -group {clocks|pll_10MHz|altpll_component|auto_generated|pll1|clk[0], \
#	         clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}

create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_uhi_component|clkctrl1|outclk}] \
	-name "RAM_PCI" \
	-source [get_ports {PCIClock}] \
	-master_clock [get_clocks {PCIClock}]

create_generated_clock [get_pins {sequencebuffer|RAMClock_Mux|RAMClock_CTRL_altclkctrl_uhi_component|clkctrl1|outclk}] \
	-add \
	-name "RAM_Master" \
	-source [get_pins {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}] \
	-master_clock [get_clocks {clocks|pll_80MHz|altpll_component|auto_generated|pll1|clk[0]}]

set_clock_groups -logically_exclusive -group {RAM_PCI PCIClock_ext PCIClock} -group {RAM_Master} -group {Addr[2] CS[2]}

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# multicycle the PCI_Allowed signal, since it is level-triggered and held
# for at least 6 cycles
set_multicycle_path -start -setup \
	-from {SequenceBuffer:sequencebuffer|inst3} \
	-to {SequenceBuffer:sequencebuffer|inst20} \
	3

# FIXME: this seems sketchy that I have to do both a setup and a hold multicycle path?
# (is it better to just put in a set_false_path since it goes through a synchronizer?)
set_multicycle_path -start -hold \
	-from {SequenceBuffer:sequencebuffer|inst3} \
	-to {SequenceBuffer:sequencebuffer|inst20} \
	3
	
# the PCI_Enabled signal is also held for at least 6 cycles
set_multicycle_path -start -hold \
	-from {SequenceBuffer:sequencebuffer|inst1} \
	-to {SequenceBuffer:sequencebuffer|inst22} \
	6

# the PCI_PERMITTED bit is slow
set_multicycle_path -start -setup \
	-from {Registers:registers|pci_sync|a} \
	-to {Registers:registers|pci_sync|b} \
	6

set_multicycle_path -start -hold \
	-from {Registers:registers|pci_sync|a} \
	-to {Registers:registers|pci_sync|b} \
	6

# the State bits in reg_STATUS are slow
set_multicycle_path -start -setup \
	-from {Registers:registers|FFSynchronizer:state_sync|a*} \
	-to {Registers:registers|FFSynchronizer:state_sync|b*} \
	5

set_multicycle_path -start -hold \
	-from {Registers:registers|FFSynchronizer:state_sync|a*} \
	-to {Registers:registers|FFSynchronizer:state_sync|b*} \
	5

# capture synchronizers
set_multicycle_path -start -setup \
  -from {*|CaptureSynchronizer:inst*|cap} \
  -to {*|CaptureSynchronizer:inst*|lock} \
  2

set_multicycle_path -start -hold \
  -from {*|CaptureSynchronizer:inst*|cap} \
  -to {*|CaptureSynchronizer:inst*|lock} \
  2
	
# tsu/th constraints

set_input_delay -clock PCIClock_ext -min 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]
set_input_delay -clock PCIClock_ext -add -max 0ns [get_ports {FDt[*] Addr[*] CS[*] RdEn WrEn}]

set_output_delay -clock PCIClock_ext -min -1ns [get_ports {FDt[*]}]
set_output_delay -clock PCIClock_ext -add -max 2ns [get_ports {FDt[*]}]

# tco constraints

# tpd constraints

# loose constraints for the Ports
set_max_delay 200.0ns -to [get_ports {PxiTrig* FlexIO*}]
set_min_delay -200.0ns -to [get_ports {PxiTrig* FlexIO*}]

# and loose constraints for MClr
set_max_delay 200.0ns -to [get_ports {MClr}]
set_min_delay -200.0ns -to [get_ports {MClr}]
