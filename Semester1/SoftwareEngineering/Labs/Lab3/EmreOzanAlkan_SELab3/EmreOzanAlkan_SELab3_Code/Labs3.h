#ifndef LABS3_H
#define LABS3_H

/*
 * Question 11: Pointers Arithmetic
 * -------------------------------
 * Redo functions with pointer arithmetic without
 * using indexes and offset operator []
 *
 * true: using pointer arithmetic
 * false: using indexes and offset operator:[]
 */
#define _USE_POINTER_ARITHMETIC_ true
//#define _USE_POINTER_ARITHMETIC_ false


int* AllocateArray(int);

void DeleteArray(int*);

void InitArray(int*, int);

void DisplayArray(int*, int);

void ReverseArray(int*, int);

void SwapArrays(int*, int*, int);

void SpanArray1(int*, const int&);

// http://www.cplusplus.com/forum/beginner/96862/
// http://stackoverflow.com/questions/1257507/what-does-this-mean-const-int-var
// http://stackoverflow.com/questions/4424793/can-someone-help-me-understand-this-int-pr
// http://stackoverflow.com/questions/9340674/does-int-has-any-real-sense
void SpanArray2(int*&, const int&); // Reference to a pointer

/////////////////////////////////

int** AllocateMatrix(int, int);
void InitializeMatrix(int**, int, int);
void DeleteMatrix(int**, int);
void DisplayMatrix(int**, int, int);

/////////////////////////////////

/*
 * Function: DotProduct
 * -----------------------------
 * Computing the Dot/Inner product of two nDimension vectors
 *
 * array1: First nDimensional vector with given type T
 * array2: Second nDimensional vector with given type T
 * dimension: integer number representing dimension of the vectors
 *
 * returns: Dot Product of the 2 vectors wtih specified type T
 * prints: nothing
 */
template<class T>
T DotProduct(T *array1, T *array2, int dimension)
{
    T dotProduct = 0;

    for(int i = 0; i < dimension; i++)
    {
#if _USE_POINTER_ARITHMETIC_
        dotProduct += *(array1+i) * *(array2 + i);
#else
        dotProduct += array1[i] * array2[i];
#endif // _USE_POINTER_ARITHMETIC_
    }

    return dotProduct;
}

int** MatrixProduct(int**, int, int, int**, int, int);


#endif // LABS3_H
