#!/bin/sh

set -e

version=14.0.4

git clone --depth 1 -b llvmorg-$version https://github.com/llvm/llvm-project

cmake -G Ninja .. \
  -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;lld;lldb;mlir;polly' \
  -DLLVM_ENABLE_RUNTIMES='compiler-rt;libcxx;libcxxabi;lib;libunwind' \
  -DLLVM_POLLY_LINK_INTO_TOOLS=ON
