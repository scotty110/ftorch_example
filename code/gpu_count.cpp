#include <torch/torch.h>
#include <iostream>

int main() {
    // Check if CUDA is available
    if (torch::cuda::is_available()) {
        int device_count = torch::cuda::device_count();
        std::cout << "Number of GPUs found: " << device_count << std::endl;
    } else {
        std::cout << "CUDA is not available." << std::endl;
    }

    return 0;
}