// megafunction wizard: %LPM_DECODE%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_DECODE 

// ============================================================
// File Name: StateDecoder.v
// Megafunction Name(s):
// 			LPM_DECODE
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
module StateDecoder (
	data,
	eq0,
	eq1,
	eq2,
	eq3);

	input	[2:0]  data;
	output	  eq0;
	output	  eq1;
	output	  eq2;
	output	  eq3;

	wire [7:0] sub_wire0;
	wire [3:3] sub_wire4 = sub_wire0[3:3];
	wire [1:1] sub_wire3 = sub_wire0[1:1];
	wire [2:2] sub_wire2 = sub_wire0[2:2];
	wire [0:0] sub_wire1 = sub_wire0[0:0];
	wire  eq0 = sub_wire1;
	wire  eq2 = sub_wire2;
	wire  eq1 = sub_wire3;
	wire  eq3 = sub_wire4;

	lpm_decode	LPM_DECODE_component (
				.data (data),
				.eq (sub_wire0)
				// synopsys translate_off
				,
				.aclr (),
				.clken (),
				.clock (),
				.enable ()
				// synopsys translate_on
				);
	defparam
		LPM_DECODE_component.lpm_decodes = 8,
		LPM_DECODE_component.lpm_type = "LPM_DECODE",
		LPM_DECODE_component.lpm_width = 3;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: BaseDec NUMERIC "1"
// Retrieval info: PRIVATE: EnableInput NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: eq0 NUMERIC "1"
// Retrieval info: PRIVATE: eq1 NUMERIC "1"
// Retrieval info: PRIVATE: eq2 NUMERIC "1"
// Retrieval info: PRIVATE: eq3 NUMERIC "1"
// Retrieval info: PRIVATE: eq4 NUMERIC "0"
// Retrieval info: PRIVATE: eq5 NUMERIC "0"
// Retrieval info: PRIVATE: eq6 NUMERIC "0"
// Retrieval info: PRIVATE: eq7 NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "3"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_DECODES NUMERIC "8"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_DECODE"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "3"
// Retrieval info: USED_PORT: @eq 0 0 8 0 OUTPUT NODEFVAL "@eq[7..0]"
// Retrieval info: USED_PORT: data 0 0 3 0 INPUT NODEFVAL "data[2..0]"
// Retrieval info: USED_PORT: eq0 0 0 0 0 OUTPUT NODEFVAL "eq0"
// Retrieval info: USED_PORT: eq1 0 0 0 0 OUTPUT NODEFVAL "eq1"
// Retrieval info: USED_PORT: eq2 0 0 0 0 OUTPUT NODEFVAL "eq2"
// Retrieval info: USED_PORT: eq3 0 0 0 0 OUTPUT NODEFVAL "eq3"
// Retrieval info: CONNECT: @data 0 0 3 0 data 0 0 3 0
// Retrieval info: CONNECT: eq0 0 0 0 0 @eq 0 0 1 0
// Retrieval info: CONNECT: eq1 0 0 0 0 @eq 0 0 1 1
// Retrieval info: CONNECT: eq2 0 0 0 0 @eq 0 0 1 2
// Retrieval info: CONNECT: eq3 0 0 0 0 @eq 0 0 1 3
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL StateDecoder_bb.v TRUE
// Retrieval info: LIB_FILE: lpm