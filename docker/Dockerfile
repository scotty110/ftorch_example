FROM ubuntu:latest
#FROM ubuntu:noble

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
    wget \
    curl \
    unzip && \ 
    apt-get clean

# Install Miniconda
WORKDIR /opt
#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/miniconda && \
    rm miniconda.sh

# Set up the conda environment
ENV PATH="/opt/miniconda/bin:$PATH"
RUN conda init && \
    conda config --set auto_activate_base false

# Ensure conda is available in non-interactive shells
RUN echo "source /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc

# Install Pytorch
RUN conda install pytorch cpuonly -c pytorch

########################
# Install GCC, Fortran #
########################
# Install GCC-9
RUN apt remove -y gcc && apt update && apt install -y gcc-9 g++-9
RUN ln -s /usr/bin/gcc-9 /usr/bin/gcc
RUN ln -s /usr/bin/g++-9 /usr/bin/g++

# Install Fortran
# Build for source maybe if becomes outdated: https://gcc.gnu.org/wiki/GFortranBinaries#FromSource
RUN apt install -y gfortran-9 
RUN ln -s /usr/bin/gfortran-9 /usr/bin/gfortran

#########################
# Install Torch, FTorch #
#########################

# Install LibTorch
WORKDIR /opt
RUN wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.3.1%2Bcpu.zip -O libtorch.zip && \
    unzip libtorch.zip && \
    rm libtorch.zip

# Install FTorch
WORKDIR /opt
RUN git clone https://github.com/Cambridge-ICCS/FTorch.git /opt/FTorch

WORKDIR /opt/FTorch/src/build
RUN cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_Fortran_COMPILER=gfortran \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_PREFIX_PATH=/opt/libtorch \
    -DCMAKE_INSTALL_PREFIX=/usr/local/ftorch

RUN make && make install

WORKDIR /