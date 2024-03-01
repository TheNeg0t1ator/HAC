#include <stdio.h>
#include <stdlib.h>
#include "cuda.h"
#include "cuda_runtime.h"

#define ARRAY_SIZE 256
#define NUM_BLOCKS  4
#define THREADS_PER_BLOCK 64

__global__ void negate(int *d_a)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    d_a[idx] = -1 * d_a[idx];
}

__global__ void negate_multiblock(int *d_a)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    d_a[idx] = -1 * d_a[idx];
}

int main(int argc, char *argv[])
{
    int *h_a, *h_out;
    int *d_a;

    int i;
    size_t siz_b = ARRAY_SIZE * sizeof(int);
    h_a = (int *) malloc(siz_b);
    h_out = (int *) malloc(siz_b);

    cudaMalloc((void **)&d_a, siz_b);

    for (i = 0; i < ARRAY_SIZE; i++) {
        h_a[i] = i;
        h_out[i] = 0;
    }

    cudaMemcpy(d_a, h_a, siz_b, cudaMemcpyHostToDevice);

    dim3 blocksPerGrid(NUM_BLOCKS);
    dim3 threadsPerBlock(THREADS_PER_BLOCK);

    cudaEvent_t start, stop;
    float elapsedTime;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Start measuring time
    cudaEventRecord(start, 0);

    // Call the kerneln
    //negate<<<blocksPerGrid, threadsPerBlock>>>(d_a); // 0.173952 ms
    negate_multiblock<<<blocksPerGrid, threadsPerBlock>>>(d_a); // 0.176128 ms

    // Stop measuring time
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);

    // Calculate elapsed time
    cudaEventElapsedTime(&elapsedTime, start, stop);
    printf("Elapsed Time for negate kernel: %.6f ms\n", elapsedTime);

    cudaMemcpy(h_out, d_a, siz_b, cudaMemcpyDeviceToHost);

    printf("Results: ");
    for (i = 0; i < ARRAY_SIZE; i++) {
        printf("%d, ", h_out[i]);
    }
    printf("\n\n");

    cudaFree(d_a);

    free(h_a);
    free(h_out);

    return 0;
}