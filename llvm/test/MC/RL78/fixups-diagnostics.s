; RUN: not llvm-mc -triple rl78 -filetype obj < %s -o /dev/null 2>&1 | FileCheck %s

bc $rel8_distant ; CHECK: :[[@LINE]]:1: error: fixup value out of range

  .space 1<<7
rel8_distant: