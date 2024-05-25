; RUN: llvm-mc %s -filetype=obj -triple=rl78 | llvm-readobj -h - \
; RUN:     | FileCheck -check-prefix=CHECK %s

; CHECK: Format: elf32-rl78
; CHECK: Arch: rl78
; CHECK: AddressSize: 32bit
; CHECK: ElfHeader {
; CHECK:   Ident {
; CHECK:     Magic: (7F 45 4C 46)
; CHECK:     Class: 32-bit (0x1)
; CHECK:     DataEncoding: LittleEndian (0x1)
; CHECK:     FileVersion: 1
; CHECK:     OS/ABI: SystemV (0x0)
; CHECK:     ABIVersion: 0
; CHECK:   }
; CHECK:   Type: Relocatable (0x1)
; CHECK:   Machine: EM_RL78 (0xC5)
; CHECK:   Version: 1
; CHECK:   Flags [ (0x0)
; CHECK:   ]
; CHECK: }