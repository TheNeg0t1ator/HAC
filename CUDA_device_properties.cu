#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

// Print device properties
void printDevProp(cudaDeviceProp devProp)
{
    printf("Major revision number:         %d\n",  devProp.major);
    printf("Minor revision number:         %d\n",  devProp.minor);
    printf("Name:                          %s\n",  devProp.name);
}
 
int main()
{
    int devCount;
    cudaGetDeviceCount(&devCount);
    printf("There is/are %d CUDA devices on your system\r\n", devCount);
 
    for (int i = 0; i < devCount; ++i)
    {
        // Get device properties
        printf("\nCUDA Device #%d\n", i);
        cudaDeviceProp devProp;
        cudaGetDeviceProperties(&devProp, i);
        printDevProp(devProp);
    }
    return 0;
}
