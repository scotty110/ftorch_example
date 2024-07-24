#!/bin/bash

set -eu
#g++ gpu_count.cpp -o gpu_count -I /opt/libtorch/include -I /opt/libtorch/include/torch/csrc/api/include -L /opt/libtorch/lib -ltorch_cpu -lc10 -Wl,-rpath,/opt/libtorch/lib
g++ gpu_count.cpp -o gpu_count -std=c++17 -I /opt/libtorch/include -I /opt/libtorch/include/torch/csrc/api/include -L /opt/libtorch/lib -ltorch -lc10 -Wl,-rpath,/opt/libtorch/lib

./gpu_count
 