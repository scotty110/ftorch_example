#!/bin/bash

#docker build -t ftorch .
#docker build --no-cache -t ftorch .
docker build --runtime=nvidia -t ftorch .
