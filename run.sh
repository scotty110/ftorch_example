#!/bin/bash

#docker run -it ftorch /bin/bash
#docker run -it -v ./code:/code -v ./saved_weights:/weights ftorch /bin/bash
docker run --rm --runtime=nvidia -it -v ./code:/code -v ./weights:/weights ftorch /bin/bash
