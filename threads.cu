#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

// Device Code
__global__ void print_thread() {
  printf("x: %d  y: %d  z: %d \n", threadIdx.x, threadIdx.y, threadIdx.z);
}

// Host code
int main() {
  // kernel launch parameters

  dim3 block(2, 1);
  dim3 grid(2, 2);

  print_thread<<<grid, block>>>(); // async call
  printf("Hello from CPU \n");
  cudaDeviceSynchronize(); // will make the prgram stall till all the launched
                           // kernels have finished execution

  cudaDeviceReset();
  return 0;
}
