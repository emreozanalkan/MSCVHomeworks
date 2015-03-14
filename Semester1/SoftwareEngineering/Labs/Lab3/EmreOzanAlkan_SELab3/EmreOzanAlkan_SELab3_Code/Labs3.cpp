#include "Labs3.h"
#include <iostream>
#include <iterator>

/*
 * Function: AllocateArray
 * -----------------------------
 * Dynamically allocates and array of n integers
 * and returning pointer to the first element of array
 *
 * n: Interger number as size of array
 *
 * returns: integer array pointer pointing to first element
 * prints: nothing
 */
int* AllocateArray(int n)
{
    return new (std::nothrow) int[n];
}

/*
 * Function: DeleteArray
 * -----------------------------
 * Deleting the integer array given by user with pointer
 *
 * array: Interger pointer to array pointing first element
 *
 * returns: nothing
 * prints: nothing
 */
void DeleteArray(int *array)
{
    delete [] array;
    array = 0;
    return;
}

/*
 * Function: InitArray
 * -----------------------------
 * Initialising an integer array with size n
 * with random values between 0 and 99
 *
 * array: Interger pointer to array pointing first element
 * n: Integer number size of the array
 *
 * returns: nothing
 * prints: nothing
 */
void InitArray(int *array, int n)
{
    for(int i = 0; i < n; i++)
    {
        int rndNumber = rand() % 100;
#if _USE_POINTER_ARITHMETIC_
        *(array + i) = rndNumber;
#else
        array[i] = rndNumber;
#endif // _USE_POINTER_ARITHMETIC_
    }

    return;
}

/*
 * Function: DisplayArray
 * -----------------------------
 * Displays the n values of an array using the pointer
 * to its first element
 *
 * array: Interger pointer to array pointing first element
 * n: Integer number size of the array
 *
 * returns: nothing
 * prints: values of array size n
 */
void DisplayArray(int *array, int n)
{
    // http://www.cplusplus.com/reference/iterator/ostream_iterator/
    // std::ostream_iterator<int> out_it (std::cout, "\n");
    // std::copy ( array, array + n, out_it );

    for(int i = 0; i < n; i++)
    {
#if _USE_POINTER_ARITHMETIC_
        std::cout<<(i+1)<<"th element: "<<*(array+i)<<std::endl;
#else
        std::cout<<(i+1)<<"th element: "<<array[i]<<std::endl;
#endif // _USE_POINTER_ARITHMETIC_

    }

    return;
}

/*
 * Function: ReverseArray
 * -----------------------------
 * Reverses the order of the given array by size n
 *
 * array: Interger pointer to array pointing first element
 * n: Integer number size of the array
 *
 * returns: nothing
 * prints: nothing
 */
void ReverseArray(int *array, int n)
{
    // http://www.cplusplus.com/reference/algorithm/reverse/
    //std::reverse(array, array + n);

    int temp = 0;

    for(int* start = array, *end = array + (n - 1); start < end; start++, end--)
    {
        temp = *start;
        *start = *end;
        *end = temp;
    }

    return;
}

/*
 * Function: SwapArrays
 * -----------------------------
 * Swaps all the values of two arrays represented by pointers
 *
 * array1: Interger pointer to first array pointing to first element
 * array2: Interger pointer to second array pointing to first element
 * n: Integer number size of the both arrays
 *
 * returns: nothing
 * prints: nothing
 */
void SwapArrays(int *array1, int *array2, int n)
{
    //std::swap_ranges(array1, array1 + n, array2);

    int temp = 0;

    for(int i = 0; i < n; i++)
    {
#if _USE_POINTER_ARITHMETIC_
        temp = *(array1 + i);
        *(array1 + i) = *(array2 + i);
        *(array2 + i) = temp;
#else
        temp = array1[i];
        array1[i] = array2[i];
        array2[i] = temp;
#endif // _USE_POINTER_ARITHMETIC_
    }

    return;
}

/*
 * Function: SpanArray1
 * -----------------------------
 * Spans the array p with size n
 *
 * p: Interger pointer to array pointing to first element
 * n: Integer number size of the array p
 *
 * returns: nothing
 * prints: nothing
 */
void SpanArray1(int *p, const int& n)
{
    for(int i = 0; i < n; p++, i++);

    return;
}

/*
 * Function: SpanArray2
 * -----------------------------
 * Spans the array p with size n
 * Function getting pointer p as reference where
 * function is modifying the original pointer to
 * point end of the array even after function returns
 *
 * p: Interger reference to pointer to array pointing to first element
 * n: Integer number size of the array p
 *
 * returns: nothing
 * prints: nothing.
 *
 * References:
 * http://www.cplusplus.com/forum/beginner/96862/
 * http://stackoverflow.com/questions/1257507/what-does-this-mean-const-int-var
 * http://stackoverflow.com/questions/4424793/can-someone-help-me-understand-this-int-pr
 * http://stackoverflow.com/questions/9340674/does-int-has-any-real-sense
 */
void SpanArray2(int* &p, const int& n) // Reference to a pointer
{
    for(int i = 0; i < n; p++, i++);

    return;
}

/////////////////////////////////

/*
 * Function: AllocateMatrix
 * -----------------------------
 * Allocating nxm size matrix and returning pointer of it
 *
 * Matrix n x m, n = row, m = cols
 *
 * n: Interger number representing size n of a matrix
 * m: Integer number representing size m of a matrix
 *
 * returns: 2D integer pointer array of matrix
 * prints: nothing
 */
int** AllocateMatrix(int n, int m)
{
    int **matrix = new int*[n];
    for (int i = 0; i < n; i++)
    {
#if _USE_POINTER_ARITHMETIC_
        *(matrix + i) = new int[m];
#else
        matrix[i] = new int[m];
#endif // _USE_POINTER_ARITHMETIC_

    }

    return matrix;
}

/*
 * Function: InitializeMatrix
 * -----------------------------
 * Initializing given matrix with size nxm with random values between 0-99
 *
 * Matrix n x m, n = row, m = cols
 *
 * matrix: 2D integer pointer to matrix
 * n: Interger number representing size n of a matrix
 * m: Integer number representing size m of a matrix
 *
 * returns: nothing
 * prints: nothing
 */
void InitializeMatrix(int **matrix, int n, int m)
{
    for(int i = 0; i < n; i++)
        for(int j = 0; j < m; j++)
        {
#if _USE_POINTER_ARITHMETIC_
            *(*(matrix + i) + j) = rand() % 100;
#else
            matrix[i][j] = rand() % 100;
#endif // _USE_POINTER_ARITHMETIC_

        }

    return;
}

/*
 * Function: DeleteMatrix
 * -----------------------------
 * Deleting the given matrix
 *
 * Matrix n x m, n = row, m = cols
 *
 * matrix: 2D integer pointer to matrix
 * n: Interger number representing size n of a matrix
 *
 * returns: nothing
 * prints: nothing
 */
void DeleteMatrix(int **matrix, int n)
{
    for (int i = 0; i < n; i++)
    {
#if _USE_POINTER_ARITHMETIC_
        delete [] *(matrix + i);
#else
        delete [] matrix[i];
#endif // _USE_POINTER_ARITHMETIC_

    }

    delete [] matrix;
    matrix = 0;
    return;
}

/*
 * Function: DisplayMatrix
 * -----------------------------
 * Displaying the given matrix with sizes n x m
 *
 * Matrix n x m, n = row, m = cols
 *
 * matrix: 2D integer pointer to matrix
 * n: Interger number representing size n of a matrix
 * m: Integer number representing size m of a matrix
 *
 * returns: nothing
 * prints: the values of the matrix
 */
void DisplayMatrix(int **matrix, int n, int m)
{
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
#if _USE_POINTER_ARITHMETIC_
            std::cout<<*(*(matrix + i) + j)<<" ";
#else
            std::cout<<matrix[i][j]<<" ";
#endif // _USE_POINTER_ARITHMETIC_

        }
        std::cout<<std::endl;
    }
    return;
}

/////////////////////////////////

/*
 * Function: MatrixProduct
 * -----------------------------
 * Given matrix A and B, calculates multiplication of them and assigns result to C
 *
 * Matrix n x m, n = row, m = cols
 *
 * matrix1: 2 dimensional integer array representing matrix A
 * n: integer row size of matrix1
 * m: integer col size of matrix1
 * matrix2: 2 dimensional integer array representing matrix B
 * a: integer row size of matrix2
 * b: integer col size of matrix2
 *
 * returns: 2D integer pointer of matrix of result of the matrix multiplication
 * prints: Prints error message if matrix sizes are not compatible
 *
 * Method Used:
 * http://en.wikipedia.org/wiki/Loop_tiling
 * http://msdn.microsoft.com/en-us/library/hh873134.aspx
 * Original matrix multiplication:
 *   DO I = 1, M
 *     DO K = 1, M
 *       DO J = 1, M
 *         Z(J, I) = Z(J, I) + X(K, I) * Y(J, K)
 *
 */
int** MatrixProduct(int **matrix1, int n, int m, int **matrix2, int a, int b)
{
    if(m != a)
    {
        std::cerr<<"First array's column size should be equal with second array's row size"<<std::endl;
        return 0;
    }

    int **product = AllocateMatrix(n, b);

    for(int i = 0; i < n; i++){
        for(int j = 0; j < b; j++){
            for(int k = 0; k < a; k++){
#if _USE_POINTER_ARITHMETIC_
                *(*(product + i) + j) += *(*(matrix1 + i) + k) * *(*(matrix2 + k) + j);
#else
                product[i][j] += matrix1[i][k] * matrix2[k][j];
#endif // _USE_POINTER_ARITHMETIC_

            }
        }
    }

    return product;
}


