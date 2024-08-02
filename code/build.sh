#!/bin/bash

set -eu

mkdir build
cd build
cmake .. -DCMAKE_PREFIX_PATH=./ -DCMAKE_BUILD_TYPE=Release
cmake --build .

./ftorch_gpu /weights/simple_net.pt