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
// Created on Tue Aug 18 13:06:26 2015

// synthesis message_off 10175

`timescale 1ns/1ns

module System_State (
    MClr,MasterClk,Do_Arm,Do_Stop,trigger,PCI_Enabled,Buffer_Empty,Do_Pause,Do_Resume,is_finished,
    PCI_Allowed,Internal_State[2:0],Load_Instructions,Run_Timer,inc_repeat_count,clear_repeat_count);

    input MClr;
    input MasterClk;
    input Do_Arm;
    input Do_Stop;
    input trigger;
    input PCI_Enabled;
    input Buffer_Empty;
    input Do_Pause;
    input Do_Resume;
    input is_finished;
    tri0 MClr;
    tri0 Do_Arm;
    tri0 Do_Stop;
    tri0 trigger;
    tri0 PCI_Enabled;
    tri0 Buffer_Empty;
    tri0 Do_Pause;
    tri0 Do_Resume;
    tri0 is_finished;
    output PCI_Allowed;
    output [2:0] Internal_State;
    output Load_Instructions;
    output Run_Timer;
    output inc_repeat_count;
    output clear_repeat_count;
    reg PCI_Allowed;
    reg [2:0] Internal_State;
    reg Load_Instructions;
    reg Run_Timer;
    reg inc_repeat_count;
    reg clear_repeat_count;
    reg [7:0] fstate;
    reg [7:0] reg_fstate;
    parameter STOPPING=0,ARMING1=1,READY=2,SETUP=3,ARMING2=4,RUN=5,PAUSED=6,DONE=7;

    always @(posedge MasterClk)
    begin
        if (MasterClk) begin
            fstate <= reg_fstate;
        end
    end

    always @(fstate or MClr or Do_Arm or Do_Stop or trigger or PCI_Enabled or Buffer_Empty or Do_Pause or Do_Resume or is_finished)
    begin
        if (~MClr) begin
            reg_fstate <= STOPPING;
            PCI_Allowed <= 1'b0;
            Internal_State <= 3'b000;
            Load_Instructions <= 1'b0;
            Run_Timer <= 1'b0;
            inc_repeat_count <= 1'b0;
            clear_repeat_count <= 1'b0;
        end
        else begin
            PCI_Allowed <= 1'b0;
            Internal_State <= 3'b000;
            Load_Instructions <= 1'b0;
            Run_Timer <= 1'b0;
            inc_repeat_count <= 1'b0;
            clear_repeat_count <= 1'b0;
            case (fstate)
                STOPPING: begin
                    if (PCI_Enabled)
                        reg_fstate <= SETUP;
                    else if (~(PCI_Enabled))
                        reg_fstate <= STOPPING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= STOPPING;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b1;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b101;

                    Load_Instructions <= 1'b0;
                end
                ARMING1: begin
                    if (~(PCI_Enabled))
                        reg_fstate <= ARMING2;
                    else if (PCI_Enabled)
                        reg_fstate <= ARMING1;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= ARMING1;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b100;

                    Load_Instructions <= 1'b0;
                end
                READY: begin
                    if ((trigger & ~(Do_Stop)))
                        reg_fstate <= RUN;
                    else if (Do_Stop)
                        reg_fstate <= STOPPING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= READY;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b001;

                    Load_Instructions <= 1'b1;
                end
                SETUP: begin
                    if (Do_Arm)
                        reg_fstate <= ARMING1;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= SETUP;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b1;

                    clear_repeat_count <= 1'b1;

                    Internal_State <= 3'b000;

                    Load_Instructions <= 1'b0;
                end
                ARMING2: begin
                    if (~(Buffer_Empty))
                        reg_fstate <= READY;
                    else if (Buffer_Empty)
                        reg_fstate <= ARMING2;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= ARMING2;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b100;

                    Load_Instructions <= 1'b1;
                end
                RUN: begin
                    if ((~(Do_Stop) & Buffer_Empty))
                        reg_fstate <= DONE;
                    else if ((Do_Pause & ~((Do_Stop | Buffer_Empty))))
                        reg_fstate <= PAUSED;
                    else if (Do_Stop)
                        reg_fstate <= STOPPING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= RUN;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b1;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b010;

                    Load_Instructions <= 1'b1;
                end
                PAUSED: begin
                    if ((Do_Resume & ~(Do_Stop)))
                        reg_fstate <= RUN;
                    else if (Do_Stop)
                        reg_fstate <= STOPPING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= PAUSED;

                    inc_repeat_count <= 1'b0;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b011;

                    Load_Instructions <= 1'b1;
                end
                DONE: begin
                    if (~((Do_Stop | is_finished)))
                        reg_fstate <= ARMING1;
                    else if ((Do_Stop | is_finished))
                        reg_fstate <= STOPPING;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= DONE;

                    inc_repeat_count <= 1'b1;

                    Run_Timer <= 1'b0;

                    PCI_Allowed <= 1'b0;

                    clear_repeat_count <= 1'b0;

                    Internal_State <= 3'b010;

                    Load_Instructions <= 1'b0;
                end
                default: begin
                    PCI_Allowed <= 1'bx;
                    Internal_State <= 3'bxxx;
                    Load_Instructions <= 1'bx;
                    Run_Timer <= 1'bx;
                    inc_repeat_count <= 1'bx;
                    clear_repeat_count <= 1'bx;
                    $display ("Reach undefined state");
                end
            endcase
        end
    end
endmodule // System_State
