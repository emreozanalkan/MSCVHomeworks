#include "Labs3.h"
#include <iostream>
#include <iterator>

int* AllocateArray(int n)
{
    return new (std::nothrow) int[n];
}

void DeleteArray(int *array)
{
    delete [] array;
    array = 0;
    return;
}

void InitArray(int *array, int n)
{
    srand (time(NULL));

    for(int i = 0; i < n; i++)
        array[i] = rand() % 100;

    return;
}

void DisplayArray(int *array, int n)
{
    // http://www.cplusplus.com/reference/iterator/ostream_iterator/
//    std::ostream_iterator<int> out_it (std::cout, "\n");
//    std::copy ( array, array + n, out_it );

    for(int i = 0; i < n; i++)
        std::cout<<(i+1)<<"th element: "<<array[i]<<std::endl;

    return;
}

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

void SwapArrays(int *array1, int *array2, int n)
{
    //std::swap_ranges(array1, array1 + 5, array2);

    int temp = 0;

    for(int i = 0; i < n; i++)
    {
        temp = array1[i];
        array1[i] = array2[i];
        array2[i] = temp;
    }

    return;
}

void SpanArray1(int *p, const int& n)
{
    for(int i = 0; i < n; p++, i++);

    return;
}

// http://www.cplusplus.com/forum/beginner/96862/
// http://stackoverflow.com/questions/1257507/what-does-this-mean-const-int-var
// http://stackoverflow.com/questions/4424793/can-someone-help-me-understand-this-int-pr
// http://stackoverflow.com/questions/9340674/does-int-has-any-real-sense
void SpanArray2(int* &p, const int& n) // Reference to a pointer
{
    for(int i = 0; i < n; p++, i++);

    return;
}

/////////////////////////////////

// Matrix nxm, n = rows, m = cols
int** AllocateMatrix(int n, int m)
{
    int **matrix = new int*[n];
    for (int i = 0; i < n; i++)
        matrix[i] = new int[m];

    return matrix;
}

// Matrix nxm, n = rows, m = cols
void InitializeMatrix(int **matrix, int n, int m)
{
    srand (time(NULL));

    for(int i = 0; i < n; i++)
        for(int j = 0; j < m; j++)
            matrix[i][j] = rand() % 100;

    return;
}

void DeleteMatrix(int **matrix, int n, int m)
{
    for (int i = 0; i < n; i++)
        delete [] matrix[i];
    delete [] matrix;
    matrix = 0;
    return;
}

void DisplayMatrix(int **matrix, int n, int m)
{
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            std::cout<<matrix[i][j]<<" ";
        }
        std::cout<<std::endl;
    }
    return;
}

/////////////////////////////////
template<class T>
T DotProduct(T *array1, T *array2, int dimension)
{
    T dotProduct = 0;

    for(int i = 0; i < dimension; i++)
        dotProduct += array1[i] * array2[i];

    return dotProduct;
}

void InnerProduct(int **matrix1, int **matrix2, int n, int m)
{
    return;
}

int** MatrixProduct(int **matrix1, int n, int m, int **matrix2, int a, int b)
{
    if(m != a)
    {
        std::cerr<<"First array's column size should be equal with second array's row size"<<std::endl;
        return 0;
    }

    int **product = AllocateMatrix(n, b);

    // http://msdn.microsoft.com/en-us/library/hh873134.aspx
    for(int i = 0; i < n; i++){
        for(int j = 0; j < b; j++){
            for(int k = 0; k < a; k++){
                product[i][j] += matrix1[i][k] * matrix2[k][j];
            }
        }
    }

    return product;
}


