Timing schedule for 128-bit timing generator
============================================

This file describes the cycle-by-cycle timing of the core timing loop. The preload
sequence works by the fact that the timer is reset to zero, so the state machine will
reach cycle 6 and then hold until Run_Timer goes high, at which point the first pattern
will be latched and the delay loaded into Timer. Timer is not decremented during the
load cycle, so the minimum delay is 50 ns for BufferedTimeout == 0, which will short-
circuit through cycle 5; any longer delay loops through cycle 6 decrementing the
Timer until it reaches 0.

Cycle -2 (finishing):
  - Addr -> DecodeAddr, 0 -> RE
  - 1 -> Set(Buffer_Empty)
  - If Load_Instructions:
    * goto -2
  - Else:
    * goto -1

Cycle -1 (hold):
  - Addr -> DecodeAddr, 0 -> RE
  - 0 -> Addr
  - 1 -> Set(Buffer_Empty)
  - If ~Load_Instructions:
    * goto -1

Cycle 0 (preload):
  - Addr -> DecodeAddr, 1 -> RE
  - Addr + 1 -> Addr
  - 0 -> Steps
  - 0 -> Timer
  - 0 -> TimeCounter
  - Reset\[A-D] -> Pattern\[A-D]
  - If ~Load_Instructions:
    * goto -1

Cycle 1:
  - q -> { Mask\[A-D], BufferedTimeout }
  - Addr -> DecodeAddr, 1 -> RE
  - If MaskA:
    * Addr + 1 -> Addr
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If ~Load_Instructions:
    * goto -1

Cycle 2:
  - Addr -> DecodeAddr, 1 -> RE
  - If MaskA:
  	* q -> PatternA
  - If MaskB:
    * Addr + 1 -> Addr
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If ~Load_Instructions:
    * goto -1

Cycle 3:
  - Addr -> DecodeAddr, 1 -> RE
  - If MaskB:
  	* q -> PatternB
  - If MaskC:
    * Addr + 1 -> Addr
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If ~Load_Instructions:
    * goto -1

Cycle 4:
  - Addr -> DecodeAddr, 1 -> RE
  - If MaskC:
  	* q -> PatternC
  - If MaskD:
    * Addr + 1 -> Addr
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If ~Load_Instructions:
    * goto -1

Cycle 5:
  - Addr -> DecodeAddr, 1 -> RE
  - Step + 1 -> Step
  - If Step != Number_Of_Steps:
    * 1 -> Clear(Buffer\_Empty)
  - If MaskD:
  	* q -> PatternD
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If Run_Timer && Timer == 0:
    * Pattern\[A-C] -> Output\[A-C]
    * If MaskD:
	  + q -> OutputD
	* Else:
	  + PatternD -> OutputD
    * BufferedTimeout -> Timer
    * Addr + 1 -> Addr
    * If Step == Number\_Of\_Steps:
      + 1 -> Set(Buffer\_Empty)
      + goto -2
    * Else:
      + goto 1
  - If ~Load_Instructions:
    * goto -1

Cycle 6:
  - Addr -> DecodeAddr, 1 -> RE
  - If Run_Timer:
    * TimeCounter + 1 -> TimeCounter
  - If Run_Timer && Timer == 0:
    * Pattern\[A-D] -> Output\[A-D]
	* BufferedTimeout -> Timer
	* If Step == Number\_Of\_Steps:
	  + 1 -> Set(Buffer\_Empty)
	  + goto -2
	* Else:
      + goto 1
  - If Run_Timer && Timer != 0:
    * Timer - 1 -> Timer
  - If ~Load_Instructions:
    * goto -1
  - goto 6

