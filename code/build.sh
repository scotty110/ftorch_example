#!/bin/bash
rm -rf build

set -eu

mkdir build
cd build
cmake .. -DCMAKE_PREFIX_PATH=./ -DCMAKE_BUILD_TYPE=Release
cmake --build .

./ftorch_gpu /weights/simple_net_0.pt