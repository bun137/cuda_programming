
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

// Device Code
__global__ void print_thread() {
  printf("x: %d  y: %d  z: %d \n", threadIdx.x, threadIdx.y, threadIdx.z);
  int t = threadIdx.x;
  int off = blockIdx.x * blockDim.x;
  int gid = t + off;
  printf("gid: %d \n", gid);
}

// Host code
int main() {
  // kernel launch parameters
  int a[10];
  int d[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  int d1[] = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20};

  int size = sizeof(a) / sizeof(int);
  for (int i = 0; i < size; i++) {
    a[i] = d[i] + d1[i];
  }

  dim3 block(4, 1);
  dim3 grid(2, 1);

  print_thread<<<grid, block>>>(); // async call
  printf("Hello from CPU \n");
  cudaDeviceSynchronize(); // will make the prgram stall till all the launched
                           // kernels have finished execution

  cudaDeviceReset();
  return 0;
}
