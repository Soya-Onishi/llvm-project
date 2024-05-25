; RUN: llvm-mc %s -triple=rl78 -show-encoding \
; RUN:     | FileCheck -check-prefixes=CHECK,CHECK-INST %s
; RUN: llvm-mc -filetype=obj -triple rl78 < %s \
; RUN:     | llvm-objdump -d - | FileCheck -check-prefix=CHECK-INST %s

; ================================
; mov a, #i
; ================================
; CHECK-INST: mov a, #42
; CHECK: encoding: [0x51,0x2a]
mov a, #42
; CHECK-INST: mov a, #0
; CHECK: encoding: [0x51,0x00]
mov a, #0
; CHECK-INST: mov a, #127
; CHECK: encoding: [0x51,0x7f]
mov a, #127
; CHECK-INST: mov a, #128
; CHECK: encoding: [0x51,0x80]
mov a, #128
; CHECK-INST: mov a, #128
; CHECK: encoding: [0x51,0x80]
mov a, #-128
; CHECK-INST: mov a, #255
; CHECK: encoding: [0x51,0xff]
mov a, #255
; CHECK-INST: mov a, #255
; CHECK: encoding: [0x51,0xff]
mov a, #-1

; ================================
; mov r, #i
; ================================
; CHECK-INST: mov x, #2
; CHECK: encoding: [0x50,0x02]
mov x, #2
; CHECK-INST: mov c, #2
; CHECK: encoding: [0x52,0x02]
mov c, #2
; CHECK-INST: mov b, #2
; CHECK: encoding: [0x53,0x02]
mov b, #2
; CHECK-INST: mov e, #2
; CHECK: encoding: [0x54,0x02]
mov e, #2
; CHECK-INST: mov d, #2
; CHECK: encoding: [0x55,0x02]
mov d, #2
; CHECK-INST: mov l, #2
; CHECK: encoding: [0x56,0x02]
mov l, #2
; CHECK-INST: mov h, #2
; CHECK: encoding: [0x57,0x02]
mov h, #2

; ================================
; mov r, a
; ================================
; CHECK-INST: mov x, a
; CHECK: encoding: [0x70]
mov x, a
; CHECK-INST: mov c, a
; CHECK: encoding: [0x72]
mov c, a
; CHECK-INST: mov b, a
; CHECK: encoding: [0x73]
mov b, a
; CHECK-INST: mov e, a
; CHECK: encoding: [0x74]
mov e, a
; CHECK-INST: mov d, a
; CHECK: encoding: [0x75]
mov d, a
; CHECK-INST: mov l, a
; CHECK: encoding: [0x76]
mov l, a
; CHECK-INST: mov h, a
; CHECK: encoding: [0x77]
mov h, a

; ================================
; mov a, r
; ================================
; CHECK-INST: mov a, x
; CHECK: encoding: [0x60]
mov a, x
; CHECK-INST: mov a, c
; CHECK: encoding: [0x62]
mov a, c
; CHECK-INST: mov a, b
; CHECK: encoding: [0x63]
mov a, b
; CHECK-INST: mov a, e
; CHECK: encoding: [0x64]
mov a, e
; CHECK-INST: mov a, d
; CHECK: encoding: [0x65]
mov a, d
; CHECK-INST: mov a, l
; CHECK: encoding: [0x66]
mov a, l
; CHECK-INST: mov a, h
; CHECK: encoding: [0x67]
mov a, h

; ================================
; mov !addr16, #byte
; ================================
; CHECK-INST: mov !0xfdead, #42
; CHECK: encoding: [0xcf,0xad,0xde,0x2a]
mov !0xfdead, #42

; ================================
; mov !addr16, a
; ================================
; CHECK-INST: mov !0xfdead, a
; CHECK: encoding: [0x9f,0xad,0xde]
mov !0xfdead, a

; ================================
; mov [rp], a
; ================================
; CHECK-INST: mov [de], a
; CHECK: encoding: [0x99]
mov [de], a
; CHECK-INST: mov [hl], a
; CHECK: encoding: [0x9b]
mov [hl], a

; ================================
; mov a, [rp]
; ================================
; CHECK-INST: mov a, [de]
; CHECK: encoding: [0x89]
mov a, [de]
; CHECK-INST: mov a, [hl]
; CHECK: encoding: [0x8b]
mov a, [hl]

; ================================
; mov [rp+byte], #byte
; ================================
; CHECK-INST: mov [de+42], #3
; CHECK: encoding: [0xca,0x2a,0x03]
mov [de+42], #3
; CHECK-INST: mov [hl+42], #3
; CHECK: encoding: [0xcc,0x2a,0x03]
mov [hl+42], #3
; CHECK-INST: mov [sp+42], #3
; CHECK: encoding: [0xc8,0x2a,0x03]
mov [sp+42], #3

; ================================
; mov [rp+byte], a
; ================================
; CHECK-INST: mov [de+42], a
; CHECK: encoding: [0x9a,0x2a]
mov [de+42], a
; CHECK-INST: mov [hl+42], a
; CHECK: encoding: [0x9c,0x2a]
mov [hl+42], a
; CHECK-INST: mov [sp+42], a
; CHECK: encoding: [0x98,0x2a]
mov [sp+42], a

; ================================
; mov a, [rp+byte]
; ================================
; CHECK-INST: mov a, [de+42]
; CHECK: encoding: [0x8a,0x2a]
mov a, [de+42]
; CHECK-INST: mov a, [hl+42]
; CHECK: encoding: [0x8c,0x2a]
mov a, [hl+42]
; CHECK-INST: mov a, [sp+42]
; CHECK: encoding: [0x88,0x2a]
mov a, [sp+42]

; ================================
; movw rp, #i
; ================================
; CHECK-INST: movw ax, #42
; CHECK: encoding: [0x30,0x2a,0x00]
movw ax, #42
; CHECK-INST: movw ax, #32767
; CHECK: encoding: [0x30,0xff,0x7f]
movw ax, #32767
; CHECK-INST: movw ax, #32768
; CHECK: encoding: [0x30,0x00,0x80]
movw ax, #32768
; CHECK-INST: movw bc, #57005
; CHECK: encoding: [0x32,0xad,0xde]
movw bc, #57005
; CHECK-INST: movw de, #57005
; CHECK: encoding: [0x34,0xad,0xde]
movw de, #57005
; CHECK-INST: movw hl, #57005
; CHECK: encoding: [0x36,0xad,0xde]
movw hl, #57005

; ================================
; movw ax, rp
; ================================
; CHECK-INST: movw ax, bc
; CHECK: encoding: [0x13]
movw ax, bc
; CHECK-INST: movw ax, de
; CHECK: encoding: [0x15]
movw ax, de
; CHECK-INST: movw ax, hl
; CHECK: encoding: [0x17]
movw ax, hl

; ================================
; movw ax, rp
; ================================
; CHECK-INST: movw bc, ax
; CHECK: encoding: [0x12]
movw bc, ax
; CHECK-INST: movw de, ax
; CHECK: encoding: [0x14]
movw de, ax
; CHECK-INST: movw hl, ax
; CHECK: encoding: [0x16]
movw hl, ax

; ================================
; movw rp, !addr16
; ================================
; CHECK-INST: movw ax, !0xfdead
; CHECK: encoding: [0xaf,0xad,0xde]
movw ax, !0xfdead
; CHECK-INST: movw bc, !0xfdead
; CHECK: encoding: [0xdb,0xad,0xde]
movw bc, !0xfdead
; CHECK-INST: movw de, !0xfdead
; CHECK: encoding: [0xeb,0xad,0xde]
movw de, !0xfdead
; CHECK-INST: movw hl, !0xfdead
; CHECK: encoding: [0xfb,0xad,0xde]
movw hl, !0xfdead

; ================================
; movw !addr16, ax
; ================================
; CHECK-INST: movw !0xfdead, ax
; CHECK: encoding: [0xbf,0xad,0xde]
movw !0xfdead, ax

; ================================
; movw ax, [rp]
; ================================
; CHECK-INST: movw ax, [de]
; CHECK: encoding: [0xa9]
movw ax, [de]
; CHECK-INST: movw ax, [hl]
; CHECK: encoding: [0xab]
movw ax, [hl]

; ================================
; movw [rp], ax
; ================================
; CHECK-INST: movw [de], ax
; CHECK: encoding: [0xb9]
movw [de], ax
; CHECK-INST: movw [hl], ax
; CHECK: encoding: [0xbb]
movw [hl], ax

; ================================
; movw ax, [rp+byte]
; ================================
; CHECK-INST: movw ax, [de+42]
; CHECK: encoding: [0xaa,0x2a]
movw ax, [de+42]
; CHECK-INST: movw ax, [hl+42]
; CHECK: encoding: [0xac,0x2a]
movw ax, [hl+42]
; CHECK-INST: movw ax, [sp+42]
; CHECK: encoding: [0xa8,0x2a]
movw ax, [sp+42]

; ================================
; movw [rp+byte], ax
; ================================
; CHECK-INST: movw [de+42], ax
; CHECK: encoding: [0xba,0x2a]
movw [de+42], ax
; CHECK-INST: movw [hl+42], ax
; CHECK: encoding: [0xbc,0x2a]
movw [hl+42], ax
; CHECK-INST: movw [sp+42], ax
; CHECK: encoding: [0xb8,0x2a]
movw [sp+42], ax

; ================================
; xch a, r
; ================================
; CHECK-INST: xch a, x
; CHECK: encoding: [0x08]
xch a, x
; CHECK-INST: xch a, c
; CHECK: encoding: [0x61,0x8a]
xch a, c
; CHECK-INST: xch a, b
; CHECK: encoding: [0x61,0x8b]
xch a, b
; CHECK-INST: xch a, e
; CHECK: encoding: [0x61,0x8c]
xch a, e
; CHECK-INST: xch a, d
; CHECK: encoding: [0x61,0x8d]
xch a, d
; CHECK-INST: xch a, l
; CHECK: encoding: [0x61,0x8e]
xch a, l
; CHECK-INST: xch a, h
; CHECK: encoding: [0x61,0x8f]
xch a, h

; ================================
; xch a, !addr16
; ================================
; CHECK-INST: xch a, !0xfdead
; CHECK: encoding: [0x61,0xaa,0xad,0xde]
xch a, !0xfdead

; ================================
; xch a, [rp]
; ================================
; CHECK-INST: xch a, [de]
; CHECK: encoding: [0x61,0xae]
xch a, [de]
; CHECK-INST: xch a, [hl]
; CHECK: encoding: [0x61,0xac]
xch a, [hl]

; ================================
; xch a, [rp+byte]
; ================================
; CHECK-INST: xch a, [de+42]
; CHECK: encoding: [0x61,0xaf,0x2a]
xch a, [de+42]
; CHECK-INST: xch a, [hl+42]
; CHECK: encoding: [0x61,0xad,0x2a]
xch a, [hl+42]

; ================================
; xchw ax, rp
; ================================
; CHECK-INST: xchw ax, bc
; CHECK: encoding: [0x33]
xchw ax, bc
; CHECK-INST: xchw ax, de
; CHECK: encoding: [0x35]
xchw ax, de
; CHECK-INST: xchw ax, hl
; CHECK: encoding: [0x37]
xchw ax, hl

; ================================
; add a, #i
; ================================
; CHECK-INST: add a, #2
; CHECK: encoding: [0x0c,0x02]
add a, #2

; ================================
; add a, r
; ================================
; CHECK-INST: add a, x
; CHECK: encoding: [0x61,0x08]
add a, x
; CHECK-INST: add a, c
; CHECK: encoding: [0x61,0x0a]
add a, c
; CHECK-INST: add a, b
; CHECK: encoding: [0x61,0x0b]
add a, b
; CHECK-INST: add a, e
; CHECK: encoding: [0x61,0x0c]
add a, e
; CHECK-INST: add a, d
; CHECK: encoding: [0x61,0x0d]
add a, d
; CHECK-INST: add a, l
; CHECK: encoding: [0x61,0x0e]
add a, l
; CHECK-INST: add a, h
; CHECK: encoding: [0x61,0x0f]
add a, h

; ================================
; add a, r
; ================================
; CHECK-INST: add x, a
; CHECK: encoding: [0x61,0x00]
add x, a
; CHECK-INST: add a, a
; CHECK: encoding: [0x61,0x01]
add a, a
; CHECK-INST: add c, a
; CHECK: encoding: [0x61,0x02]
add c, a
; CHECK-INST: add b, a
; CHECK: encoding: [0x61,0x03]
add b, a
; CHECK-INST: add e, a
; CHECK: encoding: [0x61,0x04]
add e, a
; CHECK-INST: add d, a
; CHECK: encoding: [0x61,0x05]
add d, a
; CHECK-INST: add l, a
; CHECK: encoding: [0x61,0x06]
add l, a
; CHECK-INST: add h, a
; CHECK: encoding: [0x61,0x07]
add h, a

; ================================
; add a, !addr16
; ================================
; CHECK-INST: add a, !0xfdead
; CHECK: encoding: [0x0f,0xad,0xde]
add a, !0xfdead

; ================================
; add a, [hl]
; ================================
; CHECK-INST: add a, [hl]
; CHECK: encoding: [0x0d]
add a, [hl]

; ================================
; add a, [hl+byte]
; ================================
; CHECK-INST: add a, [hl+42]
; CHECK: encoding: [0x0e,0x2a]
add a, [hl+42]

; ================================
; add a, [hl+r]
; ================================
; CHECK-INST: add a, [hl+b]
; CHECK: encoding: [0x61,0x80]
add a, [hl+b]
; CHECK-INST: add a, [hl+c]
; CHECK: encoding: [0x61,0x82]
add a, [hl+c]

; ================================
; addw ax, #word
; ================================
; CHECK-INST: addw ax, #57005
; CHECK: encoding: [0x04,0xad,0xde]
addw ax, #57005

; ================================
; addw ax, rp
; ================================
; CHECK-INST: addw ax, ax
; CHECK: encoding: [0x01]
addw ax, ax
; CHECK-INST: addw ax, bc
; CHECK: encoding: [0x03]
addw ax, bc
; CHECK-INST: addw ax, de
; CHECK: encoding: [0x05]
addw ax, de
; CHECK-INST: addw ax, hl
; CHECK: encoding: [0x07]
addw ax, hl

; ================================
; addw ax, !addr16
; ================================
; CHECK-INST: addw ax, !0xfdead
; CHECK: encoding: [0x02,0xad,0xde]
addw ax, !0xfdead

; ================================
; addw ax, [hl+byte]
; ================================
; CHECK-INST: addw ax, [hl+42]
; CHECK: encoding: [0x61,0x09,0x2a]
addw ax, [hl+42]

; ================================
; sub a, #i
; ================================
; CHECK-INST: sub a, #2
; CHECK: encoding: [0x2c,0x02]
sub a, #2

; ================================
; sub a, r
; ================================
; CHECK-INST: sub a, x
; CHECK: encoding: [0x61,0x28]
sub a, x
; CHECK-INST: sub a, c
; CHECK: encoding: [0x61,0x2a]
sub a, c
; CHECK-INST: sub a, b
; CHECK: encoding: [0x61,0x2b]
sub a, b
; CHECK-INST: sub a, e
; CHECK: encoding: [0x61,0x2c]
sub a, e
; CHECK-INST: sub a, d
; CHECK: encoding: [0x61,0x2d]
sub a, d
; CHECK-INST: sub a, l
; CHECK: encoding: [0x61,0x2e]
sub a, l
; CHECK-INST: sub a, h
; CHECK: encoding: [0x61,0x2f]
sub a, h

; ================================
; sub a, r
; ================================
; CHECK-INST: sub x, a
; CHECK: encoding: [0x61,0x20]
sub x, a
; CHECK-INST: sub a, a
; CHECK: encoding: [0x61,0x21]
sub a, a
; CHECK-INST: sub c, a
; CHECK: encoding: [0x61,0x22]
sub c, a
; CHECK-INST: sub b, a
; CHECK: encoding: [0x61,0x23]
sub b, a
; CHECK-INST: sub e, a
; CHECK: encoding: [0x61,0x24]
sub e, a
; CHECK-INST: sub d, a
; CHECK: encoding: [0x61,0x25]
sub d, a
; CHECK-INST: sub l, a
; CHECK: encoding: [0x61,0x26]
sub l, a
; CHECK-INST: sub h, a
; CHECK: encoding: [0x61,0x27]
sub h, a

; ================================
; sub a, !addr16
; ================================
; CHECK-INST: sub a, !0xfdead
; CHECK: encoding: [0x2f,0xad,0xde]
sub a, !0xfdead

; ================================
; sub a, [hl]
; ================================
; CHECK-INST: sub a, [hl]
; CHECK: encoding: [0x2d]
sub a, [hl]

; ================================
; sub a, [hl+byte]
; ================================
; CHECK-INST: sub a, [hl+42]
; CHECK: encoding: [0x2e,0x2a]
sub a, [hl+42]

; ================================
; sub a, [hl+byte]
; ================================
; CHECK-INST: sub a, [hl+b]
; CHECK: encoding: [0x61,0xa0]
sub a, [hl+b]
; CHECK-INST: sub a, [hl+c]
; CHECK: encoding: [0x61,0xa2]
sub a, [hl+c]

; ================================
; subw ax, #word
; ================================
; CHECK-INST: subw ax, #57005
; CHECK: encoding: [0x24,0xad,0xde]
subw ax, #57005

; ================================
; subw ax, rp
; ================================
; CHECK-INST: subw ax, bc
; CHECK: encoding: [0x23]
subw ax, bc
; CHECK-INST: subw ax, de
; CHECK: encoding: [0x25]
subw ax, de
; CHECK-INST: subw ax, hl
; CHECK: encoding: [0x27]
subw ax, hl

; ================================
; subw ax, !addr16
; ================================
; CHECK-INST: subw ax, !0xfdead
; CHECK: encoding: [0x22,0xad,0xde]
subw ax, !0xfdead

; ================================
; subw ax, [hl+byte]
; ================================
; CHECK-INST: subw ax, [hl+42]
; CHECK: encoding: [0x61,0x29,0x2a]
subw ax, [hl+42]

; ================================
; and a, #i
; ================================
; CHECK-INST: and a, #2
; CHECK: encoding: [0x5c,0x02]
and a, #2

; ================================
; and a, r
; ================================
; CHECK-INST: and a, x
; CHECK: encoding: [0x61,0x58]
and a, x
; CHECK-INST: and a, c
; CHECK: encoding: [0x61,0x5a]
and a, c
; CHECK-INST: and a, b
; CHECK: encoding: [0x61,0x5b]
and a, b
; CHECK-INST: and a, e
; CHECK: encoding: [0x61,0x5c]
and a, e
; CHECK-INST: and a, d
; CHECK: encoding: [0x61,0x5d]
and a, d
; CHECK-INST: and a, l
; CHECK: encoding: [0x61,0x5e]
and a, l
; CHECK-INST: and a, h
; CHECK: encoding: [0x61,0x5f]
and a, h

; ================================
; and a, r
; ================================
; CHECK-INST: and x, a
; CHECK: encoding: [0x61,0x50]
and x, a
; CHECK-INST: and a, a
; CHECK: encoding: [0x61,0x51]
and a, a
; CHECK-INST: and c, a
; CHECK: encoding: [0x61,0x52]
and c, a
; CHECK-INST: and b, a
; CHECK: encoding: [0x61,0x53]
and b, a
; CHECK-INST: and e, a
; CHECK: encoding: [0x61,0x54]
and e, a
; CHECK-INST: and d, a
; CHECK: encoding: [0x61,0x55]
and d, a
; CHECK-INST: and l, a
; CHECK: encoding: [0x61,0x56]
and l, a
; CHECK-INST: and h, a
; CHECK: encoding: [0x61,0x57]
and h, a

; ================================
; and a, !addr16
; ================================
; CHECK-INST: and a, !0xfdead
; CHECK: encoding: [0x5f,0xad,0xde]
and a, !0xfdead

; ================================
; and a, [hl]
; ================================
; CHECK-INST: and a, [hl]
; CHECK: encoding: [0x5d]
and a, [hl]

; ================================
; and a, [hl+byte]
; ================================
; CHECK-INST: and a, [hl+42]
; CHECK: encoding: [0x5e,0x2a]
and a, [hl+42]

; ================================
; and a, [hl+r]
; ================================
; CHECK-INST: and a, [hl+b]
; CHECK: encoding: [0x61,0xd0]
and a, [hl+b]
; CHECK-INST: and a, [hl+c]
; CHECK: encoding: [0x61,0xd2]
and a, [hl+c]

; ================================
; or a, #i
; ================================
; CHECK-INST: or a, #2
; CHECK: encoding: [0x6c,0x02]
or a, #2

; ================================
; or a, r
; ================================
; CHECK-INST: or a, x
; CHECK: encoding: [0x61,0x68]
or a, x
; CHECK-INST: or a, c
; CHECK: encoding: [0x61,0x6a]
or a, c
; CHECK-INST: or a, b
; CHECK: encoding: [0x61,0x6b]
or a, b
; CHECK-INST: or a, e
; CHECK: encoding: [0x61,0x6c]
or a, e
; CHECK-INST: or a, d
; CHECK: encoding: [0x61,0x6d]
or a, d
; CHECK-INST: or a, l
; CHECK: encoding: [0x61,0x6e]
or a, l
; CHECK-INST: or a, h
; CHECK: encoding: [0x61,0x6f]
or a, h

; ================================
; or a, r
; ================================
; CHECK-INST: or x, a
; CHECK: encoding: [0x61,0x60]
or x, a
; CHECK-INST: or a, a
; CHECK: encoding: [0x61,0x61]
or a, a
; CHECK-INST: or c, a
; CHECK: encoding: [0x61,0x62]
or c, a
; CHECK-INST: or b, a
; CHECK: encoding: [0x61,0x63]
or b, a
; CHECK-INST: or e, a
; CHECK: encoding: [0x61,0x64]
or e, a
; CHECK-INST: or d, a
; CHECK: encoding: [0x61,0x65]
or d, a
; CHECK-INST: or l, a
; CHECK: encoding: [0x61,0x66]
or l, a
; CHECK-INST: or h, a
; CHECK: encoding: [0x61,0x67]
or h, a

; ================================
; or a, !addr16
; ================================
; CHECK-INST: or a, !0xfdead
; CHECK: encoding: [0x6f,0xad,0xde]
or a, !0xfdead

; ================================
; or a, [hl]
; ================================
; CHECK-INST: or a, [hl]
; CHECK: encoding: [0x6d]
or a, [hl]

; ================================
; or a, [hl+byte]
; ================================
; CHECK-INST: or a, [hl+42]
; CHECK: encoding: [0x6e,0x2a]
or a, [hl+42]

; ================================
; or a, [hl+r]
; ================================
; CHECK-INST: or a, [hl+b]
; CHECK: encoding: [0x61,0xe0]
or a, [hl+b]
; CHECK-INST: or a, [hl+c]
; CHECK: encoding: [0x61,0xe2]
or a, [hl+c]

; ================================
; xor a, #i
; ================================
; CHECK-INST: xor a, #2
; CHECK: encoding: [0x7c,0x02]
xor a, #2

; ================================
; xor a, r
; ================================
; CHECK-INST: xor a, x
; CHECK: encoding: [0x61,0x78]
xor a, x
; CHECK-INST: xor a, c
; CHECK: encoding: [0x61,0x7a]
xor a, c
; CHECK-INST: xor a, b
; CHECK: encoding: [0x61,0x7b]
xor a, b
; CHECK-INST: xor a, e
; CHECK: encoding: [0x61,0x7c]
xor a, e
; CHECK-INST: xor a, d
; CHECK: encoding: [0x61,0x7d]
xor a, d
; CHECK-INST: xor a, l
; CHECK: encoding: [0x61,0x7e]
xor a, l
; CHECK-INST: xor a, h
; CHECK: encoding: [0x61,0x7f]
xor a, h

; ================================
; xor a, r
; ================================
; CHECK-INST: xor x, a
; CHECK: encoding: [0x61,0x70]
xor x, a
; CHECK-INST: xor a, a
; CHECK: encoding: [0x61,0x71]
xor a, a
; CHECK-INST: xor c, a
; CHECK: encoding: [0x61,0x72]
xor c, a
; CHECK-INST: xor b, a
; CHECK: encoding: [0x61,0x73]
xor b, a
; CHECK-INST: xor e, a
; CHECK: encoding: [0x61,0x74]
xor e, a
; CHECK-INST: xor d, a
; CHECK: encoding: [0x61,0x75]
xor d, a
; CHECK-INST: xor l, a
; CHECK: encoding: [0x61,0x76]
xor l, a
; CHECK-INST: xor h, a
; CHECK: encoding: [0x61,0x77]
xor h, a

; ================================
; xor a, !addr16
; ================================
; CHECK-INST: xor a, !0xfdead
; CHECK: encoding: [0x7f,0xad,0xde]
xor a, !0xfdead

; ================================
; xor a, [hl]
; ================================
; CHECK-INST: xor a, [hl]
; CHECK: encoding: [0x7d]
xor a, [hl]

; ================================
; xor a, [hl+byte]
; ================================
; CHECK-INST: xor a, [hl+42]
; CHECK: encoding: [0x7e,0x2a]
xor a, [hl+42]

; ================================
; xor a, [hl+r]
; ================================
; CHECK-INST: xor a, [hl+b]
; CHECK: encoding: [0x61,0xf0]
xor a, [hl+b]
; CHECK-INST: xor a, [hl+c]
; CHECK: encoding: [0x61,0xf2]
xor a, [hl+c]

; ================================
; cmp a, #byte
; ================================
; CHECK-INST: cmp a, #42
; CHECK: encoding: [0x4c,0x2a]
cmp a, #42

; ================================
; cmp a, r
; ================================
; CHECK-INST: cmp a, x
; CHECK: encoding: [0x61,0x48]
cmp a, x
; CHECK-INST: cmp a, c
; CHECK: encoding: [0x61,0x4a]
cmp a, c
; CHECK-INST: cmp a, b
; CHECK: encoding: [0x61,0x4b]
cmp a, b
; CHECK-INST: cmp a, e
; CHECK: encoding: [0x61,0x4c]
cmp a, e
; CHECK-INST: cmp a, d
; CHECK: encoding: [0x61,0x4d]
cmp a, d
; CHECK-INST: cmp a, l
; CHECK: encoding: [0x61,0x4e]
cmp a, l
; CHECK-INST: cmp a, h
; CHECK: encoding: [0x61,0x4f]
cmp a, h

; ================================
; cmp r, a
; ================================
; CHECK-INST: cmp x, a
; CHECK: encoding: [0x61,0x40]
cmp x, a
; CHECK-INST: cmp a, a
; CHECK: encoding: [0x61,0x41]
cmp a, a
; CHECK-INST: cmp c, a
; CHECK: encoding: [0x61,0x42]
cmp c, a
; CHECK-INST: cmp b, a
; CHECK: encoding: [0x61,0x43]
cmp b, a
; CHECK-INST: cmp e, a
; CHECK: encoding: [0x61,0x44]
cmp e, a
; CHECK-INST: cmp d, a
; CHECK: encoding: [0x61,0x45]
cmp d, a
; CHECK-INST: cmp l, a
; CHECK: encoding: [0x61,0x46]
cmp l, a
; CHECK-INST: cmp h, a
; CHECK: encoding: [0x61,0x47]
cmp h, a

; ================================
; cmp a, !addr16
; ================================
; CHECK-INST: cmp a, !0xfdead
; CHECK: encoding: [0x4f,0xad,0xde]
cmp a, !0xfdead

; ================================
; cmp a, [hl]
; ================================
; CHECK-INST: cmp a, [hl]
; CHECK: encoding: [0x4d]
cmp a, [hl]

; ================================
; cmp a, [hl+byte]
; ================================
; CHECK-INST: cmp a, [hl+42]
; CHECK: encoding: [0x4e,0x2a]
cmp a, [hl+42]

; ================================
; cmpw ax, #word
; ================================
; CHECK-INST: cmpw ax, #57005
; CHECK: encoding: [0x44,0xad,0xde]
cmpw ax, #57005

; ================================
; cmpw ax, rp
; ================================
; CHECK-INST: cmpw ax, bc
; CHECK: encoding: [0x43]
cmpw ax, bc
; CHECK-INST: cmpw ax, de
; CHECK: encoding: [0x45]
cmpw ax, de
; CHECK-INST: cmpw ax, hl
; CHECK: encoding: [0x47]
cmpw ax, hl

; ================================
; cmpw ax, !addr16
; ================================
; CHECK-INST: cmpw ax, !0xfdead
; CHECK: encoding: [0x42,0xad,0xde]
cmpw ax, !0xfdead

; ================================
; cmpw ax, [hl+byte]
; ================================
; CHECK-INST: cmpw ax, [hl+42]
; CHECK: encoding: [0x61,0x49,0x2a]
cmpw ax, [hl+42]

; ================================
; shr a, shamt
; ================================
; CHECK-INST: shr a, 3
; CHECK: encoding: [0x31,0x3a]
shr a, 3

; ================================
; shl r, shamt
; ================================
; CHECK-INST: shl a, 3
; CHECK: encoding: [0x31,0x39]
shl a, 3
; CHECK-INST: shl b, 3
; CHECK: encoding: [0x31,0x38]
shl b, 3
; CHECK-INST: shl c, 3
; CHECK: encoding: [0x31,0x37]
shl c, 3

; ================================
; sar a, shamt
; ================================
; CHECK-INST: sar a, 3
; CHECK: encoding: [0x31,0x3b]
sar a, 3

; ================================
; ror a, 1
; ================================
; CHECK-INST: ror a, 1
; CHECK: encoding: [0x61,0xdb]
ror a, 1

; ================================
; rol a, 1
; ================================
; CHECK-INST: rol a, 1
; CHECK: encoding: [0x61,0xeb]
rol a, 1

; ================================
; rorc a, 1
; ================================
; CHECK-INST: rorc a, 1
; CHECK: encoding: [0x61,0xfb]
rorc a, 1

; ================================
; rolc a, 1
; ================================
; CHECK-INST: rolc a, 1
; CHECK: encoding: [0x61,0xdc]
rolc a, 1

; ================================
; call rp
; ================================
; CHECK-INST: call ax
; CHECK: encoding: [0x61,0xca]
call ax
; CHECK-INST: call bc
; CHECK: encoding: [0x61,0xda]
call bc
; CHECK-INST: call de
; CHECK: encoding: [0x61,0xea]
call de
; CHECK-INST: call hl
; CHECK: encoding: [0x61,0xfa]
call hl

; ================================
; call !addr16
; ================================
; CHECK-INST: call !0xdead
; CHECK: encoding: [0xfd,0xad,0xde]
call !0xdead

; ================================
; bc $addr20
; ================================
; CHECK-INST: bc $0x2a
; CHECK: encoding: [0xdc,0x2a]
bc $0x2a
; CHECK-INST: bc $0x7f
; CHECK: encoding: [0xdc,0x7f]
bc $0x7F
; CHECK-INST: bc $0xffffffffffffff80
; CHECK: encoding: [0xdc,0x80]
bc $0xffffffffffffff80

; ================================
; bnc $addr20
; ================================
; CHECK-INST: bnc $0x2a
; CHECK: encoding: [0xde,0x2a]
bnc $0x2a

; ================================
; bz $addr20
; ================================
; CHECK-INST: bz $0x2a
; CHECK: encoding: [0xdd,0x2a]
bz $0x2a

; ================================
; bnz $addr20
; ================================
; CHECK-INST: bnz $0x2a
; CHECK: encoding: [0xdf,0x2a]
bnz $0x2a

; ================================
; bh $addr20
; ================================
; CHECK-INST: bh $0x2a
; CHECK: encoding: [0x61,0xc3,0x2a]
bh $0x2a

; ================================
; bnh $addr20
; ================================
; CHECK-INST: bnh $0x2a
; CHECK: encoding: [0x61,0xd3,0x2a]
bnh $0x2a