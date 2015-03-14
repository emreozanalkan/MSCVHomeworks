#include <iostream>

#include "Labs3.h"

using namespace std;

int main(int argc, char *argv[])
{

    int array1[] = {0, 1, 2, 3, 4};
    int array2[] = {5, 6, 7, 8, 9};

    int *arr = new int[3];
    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 3;


//    //ReverseArray(array, sizeof(array) / sizeof(int));
//    SwapArrays(array1, array2, 5);
//    DisplayArray(array1, sizeof(array1) / sizeof(int));
//    cout<<"-----------"<<endl;
//    DisplayArray(array2, sizeof(array2) / sizeof(int));


    // SpanArray2
//    DisplayArray(arr, 3);
//    SpanArray2(arr, 5);
//    cout<<"-- After Span Array --"<<endl;
//    DisplayArray(arr, 3);


//    int n = 3, m = 5;
//    int **matrix = AllocateMatrix(n, m);
//    InitializeMatrix(matrix, n, m);
//    DisplayMatrix(matrix, n, m);
//    DeleteMatrix(matrix, n, m);
//    cout<<"After matrix deletion:"<<endl;
//    DisplayMatrix(matrix, n, m);

//    // Remark
//    cout<<"====Remark===="<<endl;
//    int **matrix2 = AllocateMatrix(n, m);
//    DisplayMatrix(matrix2, 3, 5);


    int **A = AllocateMatrix(2, 3);
    int **B = AllocateMatrix(3, 3);

    /*
     *
     *   A
     * 1 2 3
     * 4 5 6
     *
     *   B
     * 1 2 0
     * 3 1 2
     * 1 1 1
     *
     */

    A[0][0] = 1;
    A[0][1] = 2;
    A[0][2] = 3;
    A[1][0] = 4;
    A[1][1] = 5;
    A[1][2] = 6;


    B[0][0] = 1;
    B[0][1] = 2;
    B[0][2] = 0;
    B[1][0] = 3;
    B[1][1] = 1;
    B[1][2] = 2;
    B[2][0] = 1;
    B[2][1] = 1;
    B[2][2] = 1;

    int **C = MatrixProduct(A, 2, 3, B, 3, 3);

    DisplayMatrix(C, 2, 3);



    return EXIT_SUCCESS;
}

