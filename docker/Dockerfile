FROM nvidia/cuda:12.4.0-devel-ubuntu22.04
# https://hub.docker.com/r/nvidia/cuda

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade the base image
# Install the packages that shouldn't affect the build process as all
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    ca-certificates \
    git \
    cmake \
    build-essential \
    gfortran \
    wget \
    curl \
    unzip && \ 
    apt-get clean

# Install Miniconda
WORKDIR /opt

#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh && \
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/miniconda && \
    rm miniconda.sh

# Set up the conda environment
ENV PATH="/opt/miniconda/bin:$PATH"
RUN conda init && \
    conda config --set auto_activate_base false

# Ensure conda is available in non-interactive shells
RUN echo "source /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc

# Install Pytorch
RUN conda install -y pytorch pytorch-cuda=12.1 -c pytorch -c nvidia

#########################
# Install Torch, FTorch #
#########################

# Need to build LibTorch from Source (https://github.com/pytorch/pytorch/blob/main/docs/libtorch.rst#building-libtorch-using-cmake)

# Need pytorch version 2.1.2 after requiers modern version of gcc
# https://github.com/pytorch/pytorch/archive/refs/tags/v2.1.2.tar.gz
WORKDIR /opt 
RUN git clone -b main --recurse-submodule https://github.com/pytorch/pytorch.git

WORKDIR /opt/pytorch_build
RUN conda install -y pyyaml typing_extensions numpy 

# Set environment variables for CUDA
ENV CUDA_HOME=/usr/local/cuda
ENV CUDNN_INCLUDE_DIR=/usr/local/cuda/include
ENV CUDNN_LIB_DIR=/usr/local/cuda/lib64

# Build PyTorch with CUDA support
RUN cmake -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DPYTHON_EXECUTABLE:PATH=`which python3` \
    -DUSE_CUDA=ON \
    -DCUDA_TOOLKIT_ROOT_DIR=$CUDA_HOME \
    -DCMAKE_INSTALL_PREFIX:PATH=../libtorch \
    ../pytorch

#RUN cmake --build . --target install 
RUN cmake --build . --target install 

# Install FTorch
WORKDIR /opt
RUN git clone https://github.com/Cambridge-ICCS/FTorch.git /opt/FTorch

WORKDIR /opt/FTorch/src/build
RUN cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_Fortran_COMPILER=gfortran \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DUSE_CUDA=ON \
    -DCUDA_BIN_PATH=/usr/local/cuda/bin \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -DCUDA_LIB_DIR=/usr/local/cuda/lib64 \
    -DCMAKE_PREFIX_PATH=/opt/libtorch \
    -DCMAKE_INSTALL_PREFIX=/usr/local/ftorch

RUN make && make install

# Add To LD_PATH
ENV LD_LIBRARY_PATH=/usr/local/ftorch/lib:$LD_LIBRARY_PATH 
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/"

WORKDIR /code
