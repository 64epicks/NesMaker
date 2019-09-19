; Assembly header for the nes65 library
; READ THIS BEFORE USING THE LIBRARY!
; The variables below should be changed based on your needs. If any of these values are set incorrectly, something can go terribly wrong.
; You should always recompile the library after you change this file

.define NES65_VERSION 0.1

; Used by some functions to temporarily store data. The values should be set to a read-write memory area (and also in zero page for faster performance)
; You should not put anything of value at these addresses, as long as you use the subroutines
.define SR0 $0400
.define SR1 $0401
.define SR2 $0402
.define SR3 $0403
.define SA  $0404 ; Spans 16 bytes so if the value is $0300

; Define functions
; These are the functions that can be used from this library

; Math
; These functions include things as multiply, divide, pow, and square root

; Multiply
; Input: A = Value 0, X = Value 1
; Ouput: A = Multiplied value, X = same as before
.macro Mul
    jsr nes65_mul
.endmacro

; Divide
; Input: A = Dividend, X = Divisor
; Ouput: A = Divided value, X = Remainder
.macro Div
    jsr nes65_div
.endmacro

; Power of
; Input: A = Value, X = Exponent
; Ouput: A = Multiplied value, X = same as before
.macro Pow
.endmacro