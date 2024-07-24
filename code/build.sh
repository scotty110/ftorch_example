#!/bin/bash

set -eu
gfortran -o ./ftorch_example ./main.f90 -I/usr/local/ftorch/include/ftorch -L/usr/local/ftorch/lib -lftorch 

./ftorch_example /weights/simpleNN.pt
exit