// megafunction wizard: %ALTCLKCTRL%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altclkctrl 

// ============================================================
// File Name: RAMClock_CTRL.v
// Megafunction Name(s):
// 			altclkctrl
//
// Simulation Library Files(s):
// 			cycloneiii
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

module RAMClock_CTRL (
	clkselect,
	inclk0x,
	inclk1x,
	inclk2x,
	outclk)/* synthesis synthesis_clearbox = 1 */;

	input	[1:0]  clkselect;
	input	  inclk0x;
	input	  inclk1x;
	input	  inclk2x;
	output	  outclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	[1:0]  clkselect;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: clock_inputs NUMERIC "3"
// Retrieval info: CONSTANT: ENA_REGISTER_MODE STRING "falling edge"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: CONSTANT: USE_GLITCH_FREE_SWITCH_OVER_IMPLEMENTATION STRING "OFF"
// Retrieval info: CONSTANT: clock_type STRING "Global Clock"
// Retrieval info: USED_PORT: clkselect 0 0 2 0 INPUT GND "clkselect[1..0]"
// Retrieval info: USED_PORT: inclk0x 0 0 0 0 INPUT NODEFVAL "inclk0x"
// Retrieval info: USED_PORT: inclk1x 0 0 0 0 INPUT NODEFVAL "inclk1x"
// Retrieval info: USED_PORT: inclk2x 0 0 0 0 INPUT NODEFVAL "inclk2x"
// Retrieval info: USED_PORT: outclk 0 0 0 0 OUTPUT NODEFVAL "outclk"
// Retrieval info: CONNECT: @clkselect 0 0 2 0 clkselect 0 0 2 0
// Retrieval info: CONNECT: @ena 0 0 0 0 VCC 0 0 0 0
// Retrieval info: CONNECT: @inclk 0 0 1 3 GND 0 0 1 0
// Retrieval info: CONNECT: @inclk 0 0 1 0 inclk0x 0 0 0 0
// Retrieval info: CONNECT: @inclk 0 0 1 1 inclk1x 0 0 0 0
// Retrieval info: CONNECT: @inclk 0 0 1 2 inclk2x 0 0 0 0
// Retrieval info: CONNECT: outclk 0 0 0 0 @outclk 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RAMClock_CTRL_bb.v TRUE
// Retrieval info: LIB_FILE: cycloneiii
