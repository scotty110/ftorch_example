#!/bin/bash

docker run --rm --runtime=nvidia -it -v ./code:/code -v ./weights:/weights cam_cuda /bin/bash
