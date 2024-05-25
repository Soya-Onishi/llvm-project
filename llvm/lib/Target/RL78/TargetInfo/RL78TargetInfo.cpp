//===-- RL78TargetInfo.cpp - RL78 Target Implementation -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/RL78TargetInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Process.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/ADT/StringRef.h"
#include <unistd.h>

using namespace llvm;

Target &llvm::getTheRL78Target() {
  static Target TheRL78Target;
  return TheRL78Target;
}

void llvm::RL78ReportError(bool condition, StringRef Reason,
                           StringRef MoreDetails) {
  if (!condition) {
    SmallVector<char, 64> Buffer;
    raw_svector_ostream OS(Buffer);
    OS << MoreDetails << Reason << "\n";
    StringRef MessageStr = OS.str();
    ssize_t written = ::write(2, MessageStr.data(), MessageStr.size());
    (void)written;
    exit(1);
  }
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeRL78TargetInfo() {
  RegisterTarget<Triple::RL78, /*HasJIT=*/false> X(getTheRL78Target(), "RL78",
                                                   "RL78", "RL78");
}
