#ifndef LABS3_H
#define LABS3_H

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
void DeleteMatrix(int**, int, int);
void DisplayMatrix(int**, int, int);

/////////////////////////////////

template<class T>
T DotProduct(T*, T*, int);
void InnerProduct(int**, int**, int, int);
int** MatrixProduct(int**, int, int, int**, int, int);


#endif // LABS3_H
