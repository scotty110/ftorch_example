#include <torch/torch.h>
#include <iostream>

int main(void) {
  std::cout << "CUDA DEVICE COUNT: " << torch::cuda::device_count() << std::endl;
  if (torch::cuda::is_available()) {
    std::cout << "CUDA is available! Training on GPU." << std::endl;
  }
  return 0;
}
