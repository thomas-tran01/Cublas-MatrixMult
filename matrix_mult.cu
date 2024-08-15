#include <iostream>
#include <cublas_v2.h>



void populateMatrix(float* h_matrix, int row, int col)
{
    for(int i = 0; i < row * col; i++)
    {
        h_matrix[i] = (rand()) % 100;
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


int matrixMult(float* h_matrixA, float* h_matrixB, float *h_matrixC, int m, int n, int k)
{
    return 0;
}


int main()
{
    int row = 3;
    int col = 3;
    float* matrixA = new float[row*col];
    float* matrixB = new float[row*col];
    float* matrixC;


    populateMatrix(matrixA, row, col);
    populateMatrix(matrixB, row, col);
    
    std::cout<< "MATRIX A" << std::endl;
    printMatrix(matrixA, row, col);
    std::cout<< "MATRIX B" << std::endl;
    printMatrix(matrixB, row, col);


}