.include "nes65.inc"

; Multiply
; Input: A = Value 0, X = Value 1
; Ouput: A = Multiplied value, X = same as before
nes65_mul:  
    STX SR0
    LDX #0
    STA SR1
    LDA #0
    PHP
    nm_addLoop:
        CPX SR0
        BEQ nm_done
        PLP
        ADC SR1
        PHP
        INX
        JMP nm_addLoop
    nm_done:
        LDX SR0
        PLP
        RTS
; Divide
; Input: A = Dividend, X = Divisor
; Ouput: A = Divided value, X = Remainder
nes65_div:
    STX SR0
    LDX #0
    PHP
    nd_subLoop:
        CMP SR0 ; Compare A to divisor
        BCC nd_done ; If A < divisor
        PLP
        SBC SR0
        PHP
        INX
        JMP nd_subLoop
    nd_done:
        STA SR0
        TXA
        LDX SR0
        PLP
        RTS
; Power of
; Input: A = Value, Y = Exponent
; Ouput: A = Multiplied value, X = modified, Y = same as before
nes65_pow:
    STY SR0
    LDY #0
    TAX
    PHP
    np_mulLoop:
        CPY SR0
        BEQ np_done
        PLP
        JSR nes65_mul
        PHP
        INY
        JMP np_mulLoop
    np_done:
        LDY SR0
        PLP
        RTS