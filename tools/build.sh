#!/bin/sh

set -e

version=14.0.4

git clone --depth 1 -b llvmorg-$version https://github.com/llvm/llvm-project
