# Example for FTorch

## Setup Docker
1. Follow the instructions [Here](https://docs.docker.com/engine/install/ubuntu/)
2. Follow Linux post setup so can call docker without sudo

## Setup Nvidia Container
1. Follow the instructions [Here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## Container
Here is where the different nvidia containers can be [found](https://hub.docker.com/u/nvidia) 
Build the container using the given `build_container.sh` script

## Run
1. Start the container with the `run.sh` script provided
2. Make the Libtorch model by running `python example.py`
3. Make and run the Fortran code `./build.sh`

## Links
[Libtorch](https://pytorch.org/) 
[FTorch](https://github.com/Cambridge-ICCS/FTorch)

