#include <iostream>

#include "Labs3.h"

// Used in Q1/3/4/5/6/7 representing 1D array size n (10)
#define USER_1D_ARRAY_SIZE_INPUT 10

// Used in Q8 representing matrix sizes n x m (3 x 5)
#define USER_MATRIX_SIZE_N 3
#define USER_MATRIX_SIZE_M 5

using namespace std;

int main(int argc, char *argv[])
{
    srand (time(NULL));

    //////////////////////
    /// Question 1 - Dynamic Allocation
    //////////////////////
    cout<<"Allocation 1D Array with size: "<<USER_1D_ARRAY_SIZE_INPUT<<endl;
    int* dynamic1DArray = AllocateArray(USER_1D_ARRAY_SIZE_INPUT);
    cout<<endl;


    //////////////////////
    /// Question 3 - Array Initialisation Using Pointers
    //////////////////////
    cout<<"Initialisation 1D Array with random numbers 0-99"<<endl;
    InitArray(dynamic1DArray, USER_1D_ARRAY_SIZE_INPUT);
    cout<<endl;


    //////////////////////
    /// Question 4 - On Displaying An Array Using its Pointer
    //////////////////////
    cout<<"Displaying 1D Array with size: "<<USER_1D_ARRAY_SIZE_INPUT<<endl;
    cout<<"---------"<<endl;
    DisplayArray(dynamic1DArray, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<endl;


    //////////////////////
    /// Question 5 - Reverse
    //////////////////////
    cout<<"Reversing the array"<<endl;
    ReverseArray(dynamic1DArray, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"Displaying 1D Array Reversed with size: "<<USER_1D_ARRAY_SIZE_INPUT<<endl;
    cout<<"---------"<<endl;
    DisplayArray(dynamic1DArray, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<endl;


    //////////////////////
    /// Question 2 - Array Deletion
    //////////////////////
    cout<<"Deleting the 1D array"<<endl;
    DeleteArray(dynamic1DArray);
    dynamic1DArray = 0;
    cout<<endl;


    //////////////////////
    /// Question 6 - Swapping Values of Arrays Represented By Pointers
    //////////////////////
    int* swapArray1 = AllocateArray(USER_1D_ARRAY_SIZE_INPUT);
    InitArray(swapArray1, USER_1D_ARRAY_SIZE_INPUT);
    int* swapArray2 = AllocateArray(USER_1D_ARRAY_SIZE_INPUT);
    InitArray(swapArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"Displaying Swap Array 1:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(swapArray1, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Displaying Swap Array 2:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(swapArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Swapping 2 array"<<endl;
    SwapArrays(swapArray1, swapArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"Displaying Array 1 after swap:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(swapArray1, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Displaying Array 2 after swap:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(swapArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;

    DeleteArray(swapArray2);
    swapArray2 = 0;
    DeleteArray(swapArray1);
    swapArray1 = 0;

    cout<<endl;

    //////////////////////
    /// Question 7 - On pointers used as function parameters
    //////////////////////
    int* spanArray1 = AllocateArray(USER_1D_ARRAY_SIZE_INPUT);
    InitArray(spanArray1, USER_1D_ARRAY_SIZE_INPUT);
    int* spanArray2 = AllocateArray(USER_1D_ARRAY_SIZE_INPUT);
    InitArray(spanArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"Displaying Span Array 1:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(spanArray1, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Displaying Span Array 2:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(spanArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Spanning 2 array"<<endl<<endl;
    SpanArray1(spanArray1, USER_1D_ARRAY_SIZE_INPUT);
    SpanArray2(spanArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"Displaying Array 1 after span:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(spanArray1, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;
    cout<<"Displaying Array 2 after span:"<<endl;
    cout<<"---------"<<endl;
    DisplayArray(spanArray2, USER_1D_ARRAY_SIZE_INPUT);
    cout<<"---------"<<endl;

    /*
     * Pointer spanArray2 itself is changed in function SpanArray2()
     * so it is pointing to another memory location and bad to use it in deletion.
     * looks like we going to leak
    */
//    DeleteArray(spanArray2);
    spanArray2 = 0;
    DeleteArray(spanArray1);
    spanArray1 = 0;

    cout<<endl;

    //////////////////////
    /// Question 8 - Allocation and Deallocation of monodimensional
    /// and bidimensional arrays represented by pointers
    //////////////////////
    cout<<"Allocating Matrix with size: "<<USER_MATRIX_SIZE_N<<"x"<<USER_MATRIX_SIZE_M<<endl;
    int **matrix = AllocateMatrix(USER_MATRIX_SIZE_N, USER_MATRIX_SIZE_M);

    /*
     * Displaying allocated matrix without initializing values
     * shows the old values of the memory where pointer is on
     */
    cout<<"Displaying Matrix WITHOUT INITING with size: "<<USER_MATRIX_SIZE_N<<"x"<<USER_MATRIX_SIZE_M<<endl;
    DisplayMatrix(matrix, USER_MATRIX_SIZE_N, USER_MATRIX_SIZE_M);

    cout<<"Initializing Matrix with size: "<<USER_MATRIX_SIZE_N<<"x"<<USER_MATRIX_SIZE_M<<endl;
    InitializeMatrix(matrix, USER_MATRIX_SIZE_N, USER_MATRIX_SIZE_M);

    cout<<"Displaying Matrix with size: "<<USER_MATRIX_SIZE_N<<"x"<<USER_MATRIX_SIZE_M<<endl;
    DisplayMatrix(matrix, USER_MATRIX_SIZE_N, USER_MATRIX_SIZE_M);

    cout<<"Deleting Matrix with size: "<<USER_MATRIX_SIZE_N<<"x"<<USER_MATRIX_SIZE_M<<endl;
    DeleteMatrix(matrix, USER_MATRIX_SIZE_N);

    matrix = 0;

    cout<<endl;


    //////////////////////
    /// Question 9 - A little bit of geometry
    //////////////////////
    float vector1[] = {.5, .3, .9};
    float vector2[] = {.98, .1, .42};
    float dotResultf = DotProduct<float>(vector1, vector2, 3);
    cout<<"Float 3D Dot Product Result: "<<dotResultf<<endl;

    int vector3[] = {4, 1, 8};
    int vector4[] = {0, 9, 3};
    int dotResulti = DotProduct<int>(vector3, vector4, 3);
    cout<<"Int 3D Dot Product Result: "<<dotResulti<<endl;
    cout<<endl;

    //////////////////////
    /// Question 10 - Matrix multiplication in the general case
    //////////////////////
    int **A = AllocateMatrix(2, 3);
    int **B = AllocateMatrix(3, 3);
    /*
     *
     *   A
     * 2 1 4
     * 6 3 5
     *
     *   B
     * 1 2 0
     * 3 6 5
     * 9 7 4
     *
     * C = A x B
     *
     *    C
     * 41 38 21
     * 60 65 35
     *
     */

    A[0][0] = 2;
    A[0][1] = 1;
    A[0][2] = 4;
    A[1][0] = 6;
    A[1][1] = 3;
    A[1][2] = 5;


    B[0][0] = 1;
    B[0][1] = 2;
    B[0][2] = 0;
    B[1][0] = 3;
    B[1][1] = 6;
    B[1][2] = 5;
    B[2][0] = 9;
    B[2][1] = 7;
    B[2][2] = 4;

//    cout<<"Multiplying matrix A:"<<endl;
//    DisplayMatrix(A, 2, 3);
//    cout<<"with matrix B:"<<endl;
//    DisplayMatrix(B, 3, 3);
//    cout<<"Result matrix C is: "<<endl;

    int **C = MatrixProduct(A, 2, 3, B, 3, 3);

    cout<<"Result matrix C is: "<<endl;
    DisplayMatrix(C, 2, 3);

    DeleteMatrix(C, 2);
    C = 0;
    DeleteMatrix(B, 3);
    B = 0;
    DeleteMatrix(A, 2);
    A = 0;

    return EXIT_SUCCESS;
}

