#!/bin/sh

set -e

tag=llvmorg-14.0.4
repository=llvm-project

if ! [ -d $repository ]; then
  git clone --depth 1 -b $tag https://github.com/llvm/$repository
else
  (
    cd $repository
    git checkout $tag
  )
fi

mkdir -p build
cd build

cmake ../$repository/llvm \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/tmp/llvm \
  -DLLVM_ENABLE_PROJECTS='bolt;clang;clang-tools-extra;flang;lld;lldb;mlir;polly' \
  -DLLVM_ENABLE_RUNTIMES='compiler-rt;libc;libcxx;libcxxabi;libunwind' \
  -DLLVM_PARALLEL_LINK_JOBS=1 \
  -DLLVM_POLLY_LINK_INTO_TOOLS=ON \
  -DLLVM_TARGETS_TO_BUILD=all

cmake --build . --target install
