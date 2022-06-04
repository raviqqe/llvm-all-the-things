#!/bin/sh

set -e

cd $(dirname $0)/..

hash() {
  for file in $(find tools -type f); do
    cat $file
  done | shasum | head -c 8
}

echo $(tools/version.sh)-$(hash)
