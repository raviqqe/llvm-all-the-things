#!/bin/sh

set -ex

tag=llvmorg-$($(dirname $0)/version.sh)
repository=llvm-project
directory=/tmp/llvm

if ! [ -d $repository ]; then
  git clone --depth 1 -b $tag https://github.com/llvm/$repository
else
  (
    cd $repository
    git checkout $tag
  )
fi

mkdir -p build

(
  cd build

  cmake ../$repository/llvm \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$directory \
    -DLLVM_ENABLE_PROJECTS='lld;lldb;mlir' \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DLLVM_TARGETS_TO_BUILD=all

  cmake --build . --target install
)

tar cf \
  llvm-bin-$(clang --print-target-triple).tar.xz \
  -C $directory \
  $(ls $directory | grep bin)

tar cf \
  llvm-lib-$(clang --print-target-triple).tar.xz \
  -C $directory \
  $(ls $directory | grep -v bin)
