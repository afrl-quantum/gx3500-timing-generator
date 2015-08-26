// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// Generated by Quartus II Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
// Created on Tue Aug 25 13:02:16 2015

// synthesis message_off 10175

`timescale 1ns/1ns

module Core_Timing_Loop (
    MClr,MasterClk,Load_Instructions,Run_Timer,timer_is_zero,mask_A,mask_B,mask_C,mask_D,reached_end,mask_A_fast,Decode_Ready,
    clear_timers,load_reset,dec_timer,inc_counter,fetch_next,load_timeout,load_A,load_B,load_C,load_D,set_Buffer_Empty,clear_Buffer_Empty,latch_outputABC,latch_outputD,latch_outputDq,inc_step, core_state[3:0]);

    input MClr;
    input MasterClk;
    input Load_Instructions;
    input Run_Timer;
    input timer_is_zero;
    input mask_A;
    input mask_B;
    input mask_C;
    input mask_D;
    input reached_end;
    input mask_A_fast;
    input Decode_Ready;
    tri0 MClr;
    tri0 Load_Instructions;
    tri0 Run_Timer;
    tri0 timer_is_zero;
    tri0 mask_A;
    tri0 mask_B;
    tri0 mask_C;
    tri0 mask_D;
    tri0 reached_end;
    tri0 mask_A_fast;
    tri0 Decode_Ready;
    output clear_timers;
    output load_reset;
    output dec_timer;
    output inc_counter;
    output fetch_next;
    output load_timeout;
    output load_A;
    output load_B;
    output load_C;
    output load_D;
    output set_Buffer_Empty;
    output clear_Buffer_Empty;
    output latch_outputABC;
    output latch_outputD;
    output latch_outputDq;
    output inc_step;
	 output [3:0] core_state;
    reg clear_timers;
    reg load_reset;
    reg dec_timer;
    reg inc_counter;
    reg fetch_next;
    reg load_timeout;
    reg load_A;
    reg load_B;
    reg load_C;
    reg load_D;
    reg set_Buffer_Empty;
    reg clear_Buffer_Empty;
    reg latch_outputABC;
    reg latch_outputD;
    reg latch_outputDq;
    reg inc_step;
    reg [3:0] fstate;
    reg [3:0] reg_fstate;
	 reg [3:0] core_state;
    parameter LD_B=0,PREPARE=1,HOLD=2,LD_A=3,LDTIME=4,LD_C=5,LD_D=6,DELAY=7,FINISHING=8,PREFILL=9;

    always @(posedge MasterClk)
    begin
        if (MasterClk) begin
            fstate <= reg_fstate;
				core_state <= reg_fstate;
        end
    end

    always @(fstate or MClr or Load_Instructions or Run_Timer or timer_is_zero or mask_A or mask_B or mask_C or mask_D or reached_end or mask_A_fast or Decode_Ready)
    begin
        if (~MClr) begin
            reg_fstate <= HOLD;
            clear_timers <= 1'b0;
            load_reset <= 1'b0;
            dec_timer <= 1'b0;
            inc_counter <= 1'b0;
            fetch_next <= 1'b0;
            load_timeout <= 1'b0;
            load_A <= 1'b0;
            load_B <= 1'b0;
            load_C <= 1'b0;
            load_D <= 1'b0;
            set_Buffer_Empty <= 1'b0;
            clear_Buffer_Empty <= 1'b0;
            latch_outputABC <= 1'b0;
            latch_outputD <= 1'b0;
            latch_outputDq <= 1'b0;
            inc_step <= 1'b0;
        end
        else begin
            clear_timers <= 1'b0;
            load_reset <= 1'b0;
            dec_timer <= 1'b0;
            inc_counter <= 1'b0;
            fetch_next <= 1'b0;
            load_timeout <= 1'b0;
            load_A <= 1'b0;
            load_B <= 1'b0;
            load_C <= 1'b0;
            load_D <= 1'b0;
            set_Buffer_Empty <= 1'b0;
            clear_Buffer_Empty <= 1'b0;
            latch_outputABC <= 1'b0;
            latch_outputD <= 1'b0;
            latch_outputDq <= 1'b0;
            inc_step <= 1'b0;
            case (fstate)
                LD_B: begin
                    if (Load_Instructions)
                        reg_fstate <= LD_C;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= LD_B;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= mask_C;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= mask_B;
                end
                PREPARE: begin
                    if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    else if (Load_Instructions)
                        reg_fstate <= LDTIME;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= PREPARE;

                    load_reset <= 1'b1;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b1;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= 1'b1;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= 1'b0;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                HOLD: begin
                    if (Load_Instructions)
                        reg_fstate <= PREFILL;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= HOLD;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b1;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= 1'b0;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= 1'b0;

                    set_Buffer_Empty <= 1'b1;

                    load_B <= 1'b0;
                end
                LD_A: begin
                    if (Load_Instructions)
                        reg_fstate <= LD_B;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= LD_A;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= mask_B;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= mask_A;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                LDTIME: begin
                    if (Load_Instructions)
                        reg_fstate <= LD_A;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= LDTIME;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= mask_A_fast;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b1;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                LD_C: begin
                    if (Load_Instructions)
                        reg_fstate <= LD_D;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= LD_C;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;
                    latch_outputABC <= 1'b0;

                    fetch_next <= mask_D;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= mask_C;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                LD_D: begin
                    if (((~(Run_Timer) | ~(timer_is_zero)) & Load_Instructions))
                        reg_fstate <= DELAY;
                    else if ((((Run_Timer & timer_is_zero) & ~(reached_end)) & Load_Instructions))
                        reg_fstate <= LDTIME;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    else if ((((reached_end & Run_Timer) & timer_is_zero) & Load_Instructions))
                        reg_fstate <= FINISHING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= LD_D;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= mask_D;

                    latch_outputABC <= (Run_Timer & timer_is_zero);

                    fetch_next <= (Run_Timer & timer_is_zero);

                    latch_outputDq <= ((Run_Timer & timer_is_zero) & mask_D);

                    load_timeout <= 1'b0;

                    inc_step <= (Run_Timer & timer_is_zero);

                    clear_Buffer_Empty <= ~(reached_end);

                    load_C <= 1'b0;

                    latch_outputD <= ((Run_Timer & timer_is_zero) & ~(mask_D));

                    load_A <= 1'b0;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                DELAY: begin
                    if ((((Run_Timer & timer_is_zero) & reached_end) & Load_Instructions))
                        reg_fstate <= FINISHING;
                    else if ((((Run_Timer & timer_is_zero) & ~(reached_end)) & Load_Instructions))
                        reg_fstate <= LDTIME;
                    else if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    else if (((~(Run_Timer) | ~(timer_is_zero)) & Load_Instructions))
                        reg_fstate <= DELAY;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= DELAY;

                    load_reset <= 1'b0;

                    dec_timer <= (Run_Timer & ~(timer_is_zero));

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= (Run_Timer & timer_is_zero);

                    fetch_next <= (Run_Timer & timer_is_zero);

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= (Run_Timer & timer_is_zero);

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= (Run_Timer & timer_is_zero);

                    load_A <= 1'b0;

                    inc_counter <= Run_Timer;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                FINISHING: begin
                    if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    else if (Load_Instructions)
                        reg_fstate <= FINISHING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= FINISHING;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b0;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= 1'b0;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= 1'b0;

                    set_Buffer_Empty <= 1'b1;

                    load_B <= 1'b0;
                end
                PREFILL: begin
                    if (~(Load_Instructions))
                        reg_fstate <= HOLD;
                    else if ((Load_Instructions & Decode_Ready))
                        reg_fstate <= PREPARE;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= PREFILL;

                    load_reset <= 1'b0;

                    dec_timer <= 1'b0;

                    clear_timers <= 1'b1;

                    load_D <= 1'b0;

                    latch_outputABC <= 1'b0;

                    fetch_next <= 1'b0;

                    latch_outputDq <= 1'b0;

                    load_timeout <= 1'b0;

                    inc_step <= 1'b0;

                    clear_Buffer_Empty <= 1'b0;

                    load_C <= 1'b0;

                    latch_outputD <= 1'b0;

                    load_A <= 1'b0;

                    inc_counter <= 1'b0;

                    set_Buffer_Empty <= 1'b0;

                    load_B <= 1'b0;
                end
                default: begin
                    clear_timers <= 1'bx;
                    load_reset <= 1'bx;
                    dec_timer <= 1'bx;
                    inc_counter <= 1'bx;
                    fetch_next <= 1'bx;
                    load_timeout <= 1'bx;
                    load_A <= 1'bx;
                    load_B <= 1'bx;
                    load_C <= 1'bx;
                    load_D <= 1'bx;
                    set_Buffer_Empty <= 1'bx;
                    clear_Buffer_Empty <= 1'bx;
                    latch_outputABC <= 1'bx;
                    latch_outputD <= 1'bx;
                    latch_outputDq <= 1'bx;
                    inc_step <= 1'bx;
                    $display ("Reach undefined state");
                end
            endcase
        end
    end
endmodule // Core_Timing_Loop
