// megafunction wizard: %ALTPLL_RECONFIG%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altpll_reconfig 

// ============================================================
// File Name: PllReconfigurator.v
// Megafunction Name(s):
// 			altpll_reconfig
//
// Simulation Library Files(s):
// 			altera_mf;cycloneiii;lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.1.0 Build 162 10/23/2013 SJ Web Edition
// ************************************************************

//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.

module PllReconfigurator (
	clock,
	counter_param,
	counter_type,
	data_in,
	pll_areset_in,
	pll_scandataout,
	pll_scandone,
	read_param,
	reconfig,
	reset,
	write_param,
	busy,
	data_out,
	pll_areset,
	pll_configupdate,
	pll_scanclk,
	pll_scanclkena,
	pll_scandata)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	[2:0]  counter_param;
	input	[3:0]  counter_type;
	input	[8:0]  data_in;
	input	  pll_areset_in;
	input	  pll_scandataout;
	input	  pll_scandone;
	input	  read_param;
	input	  reconfig;
	input	  reset;
	input	  write_param;
	output	  busy;
	output	[8:0]  data_out;
	output	  pll_areset;
	output	  pll_configupdate;
	output	  pll_scanclk;
	output	  pll_scanclkena;
	output	  pll_scandata;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  pll_areset_in;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: CHAIN_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_NAME STRING "/afs/cold-atoms.afrl.af.mil/user/bks/current/Documents/gx3500-timing-generator/PLL_80MHz.mif"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: USE_INIT_FILE STRING "1"
// Retrieval info: CONSTANT: INIT_FROM_ROM STRING "NO"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: CONSTANT: SCAN_INIT_FILE STRING "/afs/cold-atoms.afrl.af.mil/user/bks/current/Documents/gx3500-timing-generator/PLL_80MHz.mif"
// Retrieval info: USED_PORT: busy 0 0 0 0 OUTPUT NODEFVAL "busy"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: counter_param 0 0 3 0 INPUT NODEFVAL "counter_param[2..0]"
// Retrieval info: USED_PORT: counter_type 0 0 4 0 INPUT NODEFVAL "counter_type[3..0]"
// Retrieval info: USED_PORT: data_in 0 0 9 0 INPUT NODEFVAL "data_in[8..0]"
// Retrieval info: USED_PORT: data_out 0 0 9 0 OUTPUT NODEFVAL "data_out[8..0]"
// Retrieval info: USED_PORT: pll_areset 0 0 0 0 OUTPUT NODEFVAL "pll_areset"
// Retrieval info: USED_PORT: pll_areset_in 0 0 0 0 INPUT GND "pll_areset_in"
// Retrieval info: USED_PORT: pll_configupdate 0 0 0 0 OUTPUT NODEFVAL "pll_configupdate"
// Retrieval info: USED_PORT: pll_scanclk 0 0 0 0 OUTPUT NODEFVAL "pll_scanclk"
// Retrieval info: USED_PORT: pll_scanclkena 0 0 0 0 OUTPUT NODEFVAL "pll_scanclkena"
// Retrieval info: USED_PORT: pll_scandata 0 0 0 0 OUTPUT NODEFVAL "pll_scandata"
// Retrieval info: USED_PORT: pll_scandataout 0 0 0 0 INPUT NODEFVAL "pll_scandataout"
// Retrieval info: USED_PORT: pll_scandone 0 0 0 0 INPUT NODEFVAL "pll_scandone"
// Retrieval info: USED_PORT: read_param 0 0 0 0 INPUT NODEFVAL "read_param"
// Retrieval info: USED_PORT: reconfig 0 0 0 0 INPUT NODEFVAL "reconfig"
// Retrieval info: USED_PORT: reset 0 0 0 0 INPUT NODEFVAL "reset"
// Retrieval info: USED_PORT: write_param 0 0 0 0 INPUT NODEFVAL "write_param"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @counter_param 0 0 3 0 counter_param 0 0 3 0
// Retrieval info: CONNECT: @counter_type 0 0 4 0 counter_type 0 0 4 0
// Retrieval info: CONNECT: @data_in 0 0 9 0 data_in 0 0 9 0
// Retrieval info: CONNECT: @pll_areset_in 0 0 0 0 pll_areset_in 0 0 0 0
// Retrieval info: CONNECT: @pll_scandataout 0 0 0 0 pll_scandataout 0 0 0 0
// Retrieval info: CONNECT: @pll_scandone 0 0 0 0 pll_scandone 0 0 0 0
// Retrieval info: CONNECT: @read_param 0 0 0 0 read_param 0 0 0 0
// Retrieval info: CONNECT: @reconfig 0 0 0 0 reconfig 0 0 0 0
// Retrieval info: CONNECT: @reset 0 0 0 0 reset 0 0 0 0
// Retrieval info: CONNECT: @write_param 0 0 0 0 write_param 0 0 0 0
// Retrieval info: CONNECT: busy 0 0 0 0 @busy 0 0 0 0
// Retrieval info: CONNECT: data_out 0 0 9 0 @data_out 0 0 9 0
// Retrieval info: CONNECT: pll_areset 0 0 0 0 @pll_areset 0 0 0 0
// Retrieval info: CONNECT: pll_configupdate 0 0 0 0 @pll_configupdate 0 0 0 0
// Retrieval info: CONNECT: pll_scanclk 0 0 0 0 @pll_scanclk 0 0 0 0
// Retrieval info: CONNECT: pll_scanclkena 0 0 0 0 @pll_scanclkena 0 0 0 0
// Retrieval info: CONNECT: pll_scandata 0 0 0 0 @pll_scandata 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL PllReconfigurator_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
// Retrieval info: LIB_FILE: cycloneiii
// Retrieval info: LIB_FILE: lpm