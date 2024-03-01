#include <stdio.h>
#include <stdlib.h>
#include "cuda.h"
#include "cuda_runtime.h" 
﻿
#define ARRAY_SIZE 256
#define NUM_BLOCKS  1
#define THREADS_PER_BLOCK 256
 
__global__ void negate(int *d_a)
{
 // CODE_1
}
 
__global__ void negate_multiblock(int *d_a)
{
 // CODE_2
}
 
int main(int argc, char *argv[])
{
    int *h_a, *h_out;
    int *d_a;
 
    int i;
    size_t siz_b = ARRAY_SIZE * sizeof(int);
    h_a = (int *) malloc(siz_b);
    h_out = (int *) malloc(siz_b);
 
    cudaMalloc( );
 
    for (i = 0; i < ARRAY_SIZE; i++) {
        h_a[i] = i;
        h_out[i] = 0;
    }
 
    cudaMemcpy( );
 
    //dim3 blocksPerGrid( ); 
    //dim3 threadsPerBlock( );
    negate<<< , >>>( );
    //negate_multiblock<<<,>>>();
    cudaDeviceSynchronize();
 
    cudaMemcpy( );
 
    printf("Results: ");
    for (i = 0; i < ARRAY_SIZE; i++) {
      printf("%d, ", h_out[i]);
    }
    printf("\n\n");
 
    cudaFree( );
 
    free(h_a);
    free(h_out);
 
    return 0;
}