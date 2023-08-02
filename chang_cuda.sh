#!/bin/bash
# change_cuda.sh
# Usage: ./change_cuda.sh 11.2
# Author: ChangKun Yang
# Last Modified: 2023-08-01
# This script changes the CUDA version to the one specified in the argument
# It assumes that the CUDA version is installed at /usr/local/cuda-$1
# It also assumes that the CUDA is installed at /usr/local/cuda

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, you need to specify the CUDA version"
    exit 1
fi

CUDA_PATH="/usr/local/cuda-$1"

if [ ! -d "$CUDA_PATH" ]; then
    echo "CUDA version $1 is not installed at $CUDA_PATH"
    exit 1
fi

# Remove existing CUDA in PATH if any
export PATH=$(echo $PATH|sed -e 's?:/usr/local/cuda[^:]*??')

# Add CUDA to PATH
export PATH=$CUDA_PATH/bin:$PATH

# Add CUDA to LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH

# Create a symbolic link
sudo rm -rf /usr/local/cuda
sudo ln -s $CUDA_PATH /usr/local/cuda

echo "Switched to:"
nvcc --version
