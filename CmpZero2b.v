// megafunction wizard: %LPM_COMPARE%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_COMPARE 

// ============================================================
// File Name: CmpZero2b.v
// Megafunction Name(s):
// 			LPM_COMPARE
//
// Simulation Library Files(s):
// 			lpm
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


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module CmpZero2b (
	dataa,
	aeb,
	aneb);

	input	[1:0]  dataa;
	output	  aeb;
	output	  aneb;

	wire  sub_wire0;
	wire  sub_wire1;
	wire [1:0] sub_wire2 = 2'h0;
	wire  aeb = sub_wire0;
	wire  aneb = sub_wire1;

	lpm_compare	LPM_COMPARE_component (
				.dataa (dataa),
				.datab (sub_wire2),
				.aeb (sub_wire0),
				.aneb (sub_wire1),
				.aclr (1'b0),
				.agb (),
				.ageb (),
				.alb (),
				.aleb (),
				.clken (1'b1),
				.clock (1'b0));
	defparam
		LPM_COMPARE_component.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES",
		LPM_COMPARE_component.lpm_representation = "UNSIGNED",
		LPM_COMPARE_component.lpm_type = "LPM_COMPARE",
		LPM_COMPARE_component.lpm_width = 2;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: AeqB NUMERIC "1"
// Retrieval info: PRIVATE: AgeB NUMERIC "0"
// Retrieval info: PRIVATE: AgtB NUMERIC "0"
// Retrieval info: PRIVATE: AleB NUMERIC "0"
// Retrieval info: PRIVATE: AltB NUMERIC "0"
// Retrieval info: PRIVATE: AneB NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: PortBValue NUMERIC "0"
// Retrieval info: PRIVATE: Radix NUMERIC "10"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SignedCompare NUMERIC "0"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: isPortBConstant NUMERIC "1"
// Retrieval info: PRIVATE: nBit NUMERIC "2"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_HINT STRING "ONE_INPUT_IS_CONSTANT=YES"
// Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "UNSIGNED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_COMPARE"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "2"
// Retrieval info: USED_PORT: aeb 0 0 0 0 OUTPUT NODEFVAL "aeb"
// Retrieval info: USED_PORT: aneb 0 0 0 0 OUTPUT NODEFVAL "aneb"
// Retrieval info: USED_PORT: dataa 0 0 2 0 INPUT NODEFVAL "dataa[1..0]"
// Retrieval info: CONNECT: @dataa 0 0 2 0 dataa 0 0 2 0
// Retrieval info: CONNECT: @datab 0 0 2 0 0 0 0 2 0
// Retrieval info: CONNECT: aeb 0 0 0 0 @aeb 0 0 0 0
// Retrieval info: CONNECT: aneb 0 0 0 0 @aneb 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL CmpZero2b_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
