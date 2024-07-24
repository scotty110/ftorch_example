#!/bin/bash

gfortran -o ./main ./main.f90 -I/usr/local/ftorch/include/ftorch -L/usr/local/ftorch/lib -lftorch 
./main
