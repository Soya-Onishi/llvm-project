; RUN: llvm-mc -triple rl78 < %s -show-encoding \
; RUN:     | FileCheck -check-prefix=CHECK-FIXUP %s
; RUN: llvm-mc -filetype=obj -triple rl78 < %s \
; RUN:     | llvm-objdump -d - | FileCheck -check-prefix=CHECK-INSTR %s
; RUN: llvm-mc -filetype=obj -triple=rl78 %s \
; RUN:     | llvm-readobj -r - | FileCheck %s -check-prefix=CHECK-REL

.LBB0:
  .space 64;

BC $.LBB0
; CHECK-FIXUP: fixup A - offset: 1, value: .LBB0, kind: fixup_rl78_rel8
; CHECK-INSTR: BC $-66
BC $.LBB1
; CHECK-FIXUP: fixup A - offset: 1, value: .LBB1, kind: fixup_rl78_rel8
; CHECK-INSTR: BC $64

  .space 64
.LBB1:

MOV A, #foo
; CHECK-FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_set8
; CHECK-INSTR: MOV A, #42

MOV A, !foo
; CHECK-FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_abs16
; CHECK-INSTR: MOV A, !42

MOV [DE + foo], A
; CHECK-FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_set8
; CHECK-INSTR: MOV [DE + 42], A

MOV [DE + foo], #bar
; CHECK-FIXUP: fixup A - offset: 1, value: foo, kind: fixup_rl78_set8
; CHECK-FIXUP: fixup B - offset: 2, value: bar, kind: fixup_rl78_set8
; CHECK-INSTR: MOV [DE + 42], #21

.equ foo, 42
.equ bar, 21

; CHECK-REL-NOT: R_RL78