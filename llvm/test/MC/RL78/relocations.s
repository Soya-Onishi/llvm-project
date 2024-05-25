; RUN: llvm-mc -triple rl78 < %s -show-encoding \
; RUN:     | FileCheck -check-prefix=INSTR -check-prefix=FIXUP %s
; RUN: llvm-mc -filetype=obj -triple rl78 < %s \
; RUN:     | llvm-readobj -r - | FileCheck -check-prefix=RELOC %s

; Check prefixes:
; RELOC - Check the relocation in the object.
; FIXUP - Check the fixup on the instruction.
; INSTR - Check the instruction is handled properly by the ASMPrinter

.short foo
; RELOC: R_RL78_16 foo
.long bar
; RELOC: R_RL78_32 bar

MOV A, !foo
; RELOC: R_RL78_ABS16 foo 0x0
; INSTR: MOV A, !foo
; FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_abs16

CALL !foo
; RELOC: R_RL78_ABS16 foo 0x0
; INSTR: CALL !foo
; FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_abs16

BC $foo
; RELOC: R_RL78_REL8 foo 0x0
; INSTR: BC $foo
; FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_rel8
