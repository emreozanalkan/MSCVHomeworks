//
//  main.cpp
//  SELab2_2_8
//
//  Created by Emre Ozan Alkan on 10/10/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

/*
 * Function: MultMatrix
 * -----------------------------
 * Given matrix A and B, calculates multiplication of them and assigns result to C
 *
 * A: 2 dimensional integer array with 3*3 size, representing matrix A
 * B: 2 dimensional integer array with 3*3 size, representing matrix B
 * C: 2 dimensional integer array with 3*3 size, representing result matrix C
 *
 * returns: nothing
 * prints: nothing.
 *
 * Method Used:
 * http://en.wikipedia.org/wiki/Loop_tiling
 * Original matrix multiplication:
 *   DO I = 1, M
 *     DO K = 1, M
 *       DO J = 1, M
 *         Z(J, I) = Z(J, I) + X(K, I) * Y(J, K)
 *
 */
void MultMatrix(int A[][3], int B[][3], int C[][3])
{
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = 0; k < 3; k++) {
                C[j][i] = C[j][i] + A[j][k] * B[k][i];
            }
        }
    }
}

int main(int argc, const char * argv[])
{
    /*
     *     A     x     B     =     C
     *
     * | 1 0 0 |   | 1 2 3 |   | 1 2 3 |
     * | 0 1 0 | X | 4 5 6 | = | 4 5 6 |
     * | 0 0 1 |   | 7 8 9 |   | 7 8 9 |
     *
     */
    // Matrix A
    int A[3][3] = {
                    {1, 0, 0},
                    {0, 1, 0},
                    {0, 0, 1}};
    
    // Matrix B
    int B[3][3] = {
                    {1, 2, 3},
                    {4, 5, 6},
                    {7, 8, 9}};
    
    // Matrix C
    int C[3][3] = {0};
    
    
    MultMatrix(A, B, C);
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            cout<<C[i][j]<<" ";
        }
        cout<<endl;
    }
    
    return EXIT_SUCCESS;
}

