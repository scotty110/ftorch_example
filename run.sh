#!/bin/bash

#docker run -it ftorch /bin/bash
docker run -it -v ./code:/code -v ./saved_weights:/weights ftorch /bin/bash

