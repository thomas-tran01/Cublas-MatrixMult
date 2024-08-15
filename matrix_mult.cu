#include <iostream>
#include <cublas_v2.h>



void populateMatrix(float* h_matrix, int row, int col)
{
    for(int i = 0; i < row * col; i++)
    {
        h_matrix[i] = (rand()) % 10;
    }
}


void printMatrix(const float* matrix, int row, int col) {
    for (int i = 0; i < row; ++i) {
        for (int j = 0; j < col; ++j) {
            std::cout << matrix[i * col + j] << " ";
        }
        std::cout << std::endl;
    }
}


void matrixMult(float* h_matrixA, float* h_matrixB, float *h_matrixC, int m, int n, int k)
{
    float* d_matrixA;
    float* d_matrixB;
    float* d_matrixC;
    cublasHandle_t cublasHandle;
    float alpha = 1.0f;
    float beta = 0.0f;

    cublasCreate(&cublasHandle);
    int matrixASize = m * k * sizeof(float);
    int matrixBSize = n * k * sizeof(float);
    int matrixCSize = m * n * sizeof(float);
    cudaMalloc(&d_matrixA, matrixASize);
    cudaMalloc(&d_matrixB, matrixBSize);
    cudaMalloc(&d_matrixC, matrixCSize);

    cudaMemcpy(d_matrixA, h_matrixA, matrixASize, cudaMemcpyHostToDevice);
    cudaMemcpy(d_matrixB, h_matrixB, matrixBSize, cudaMemcpyHostToDevice);

    cublasSgemm(cublasHandle, CUBLAS_OP_N, CUBLAS_OP_N, n, m, k, &alpha, d_matrixB, n, d_matrixA, k, &beta, d_matrixC, n);
    
    cudaMemcpy(h_matrixC, d_matrixC, matrixCSize, cudaMemcpyDeviceToHost);

    cudaFree(d_matrixA);
    cudaFree(d_matrixB);
    cudaFree(d_matrixC);
    cublasDestroy(cublasHandle);
}


int main()
{
    int row = 3;
    int col = 3;
    float* matrixA = new float[row*col];
    float* matrixB = new float[row*col];
    float* matrixC = new float[row*col];


    populateMatrix(matrixA, row, col);
    populateMatrix(matrixB, row, col);
    
    std::cout<< "MATRIX A" << std::endl;
    printMatrix(matrixA, row, col);
    std::cout<< "MATRIX B" << std::endl;
    printMatrix(matrixB, row, col);

    matrixMult(matrixA, matrixB, matrixC, row, col, col);
    std::cout<< "MATRIX C" << std::endl;
    printMatrix(matrixC, row, col);
}