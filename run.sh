#!/bin/bash
#mkdir ./weights

docker run --rm --runtime=nvidia -it -v ./code:/code -v ./weights:/weights ftorch_cuda /bin/bash
