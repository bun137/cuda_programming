#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void helloi() { printf("hello cuda\n"); }

int main() {
  helloi<<<1, 10>>>();
  cudaDeviceSynchronize();
  cudaDeviceReset();
  return 0;
}
