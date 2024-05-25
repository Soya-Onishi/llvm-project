# RUN: not llvm-mc -triple rl78 < %s 2>&1 | FileCheck %s

; =================================
; Out of range immediates
; =================================
MOV A, !0x10000         ; CHECK: :[[@LINE]]:9: error: immediate must be an integer in the range [0, 65535]
MOV [DE+0x100], A       ; CHECK: :[[@LINE]]:9: error: immediate must be an integer in the range [0, 255]
MOV A, #-129            ; CHECK: :[[@LINE]]:9: error: immediate must be an integer in the range [-128, 127]
MOV A, #128             ; CHECK: :[[@LINE]]:9: error: immediate must be an integer in the range [-128, 127]
MOVW AX, #-32769        ; CHECK: :[[@LINE]]:11: error: immediate must be an integer in the range [-32768, 32767]
MOVW AX, #32768         ; CHECK: :[[@LINE]]:11: error: immediate must be an integer in the range [-32768, 32767]
SHL A, 0                ; CHECK: :[[@LINE]]:8: error: shift amount must be an integer in the range [1, 7]
SHL A, 8                ; CHECK: :[[@LINE]]:8: error: shift amount must be an integer in the range [1, 7]
ROR A, 0                ; CHECK: :[[@LINE]]:8: error: rotate amount must be '1'
ROR A, 2                ; CHECK: :[[@LINE]]:8: error: rotate amount must be '1'
BC $-129                ; CHECK: :[[@LINE]]:5: error: immediate must be an integer in the range [-128, 127]
BC $128                 ; CHECK: :[[@LINE]]:5: error: immediate must be an integer in the range [-128, 127]

; =============================
; Invalid mnemonics
; =============================
ADDI A, #2              ; CHECK: :[[@LINE]]:1: error: unrecognized instruction mnemonic

; =============================
; Invalid register name
; =============================
ADD G, #2               ; CHECK: :[[@LINE]]:5: error: invalid operand for instruction

; =============================
; Unavailable register name
; =============================
MOV AX, #2              ; CHECK: :[[@LINE]]:5: error: invalid operand for instruction
MOV A, A                ; CHECK: :[[@LINE]]:8: error: invalid operand for instruction
MOV [A], A              ; CHECK: :[[@LINE]]:6: error: invalid operand for instruction
MOV [AX], A             ; CHECK: :[[@LINE]]:6: error: invalid operand for instruction
; FIXME: more appropriate message, like '+' expected, but actual ']'
MOV [SP], A             ; CHECK: :[[@LINE]]:8: error: invalid operand for instruction
MOV [AX+255], #2        ; CHECK: :[[@LINE]]:6: error: invalid operand for instruction
; FIXME: buggy error message generated. not immediate value range error, use invalid operand
;ADD A, [HL + E]         ; CHEC: :[[@LINE]]:14: error: invalid operand for instruction
SUBW AX, [BC + 42]      ; CHECK: :[[@LINE]]:11: error: invalid operand for instruction
SUBW AX, AX             ; CHECK: :[[@LINE]]:10: error: invalid operand for instruction

; =============================
; Too many operands
; =============================
ADD A, B, C             ; CHECK: :[[@LINE]]:11: error: invalid operand for instruction

; =============================
; Too few operands
; =============================
ADD A                   ; CHECK: :[[@LINE]]:1: error: too few operands for instruction
