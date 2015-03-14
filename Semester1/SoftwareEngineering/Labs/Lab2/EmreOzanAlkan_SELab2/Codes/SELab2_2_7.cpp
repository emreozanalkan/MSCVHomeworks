//
//  main.cpp
//  SELab2_2_7
//
//  Created by Emre Ozan Alkan on 10/10/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

#define BI_ARRAY_SIZE 5

void initArrays(int, int**);

void fillArrays(int, int**);

void showBidimensionalArray(void);

int main(int argc, const char * argv[])
{
    showBidimensionalArray();
    
    return EXIT_SUCCESS;
}

/*
 * Function: initArrays
 * -----------------------------
 * Initializing 2 array.
 * First assigns them to 0 then makes their first element 0
 *
 * arr1: 2 dimensional static integer array with size BI_ARRAY_SIZE * BI_ARRAY_SIZE
 * arr2: Pointer to 2 dimensional integer array with size BI_ARRAY_SIZE * BI_ARRAY_SIZE
 *
 * returns: nothing
 * prints: nothing.
 *
 */
void initArrays(int (*arr1)[BI_ARRAY_SIZE], int **arr2)
{
    // filling arr1 with 0 values according to its size
    memset(arr1, 0, sizeof(arr1[0][0]) * BI_ARRAY_SIZE * BI_ARRAY_SIZE);
    // As stated in the lab paper, we init first element with 1
    arr1[0][0] = 1;
    
    // initting the 2nd size of the arr2
    for (int i = 0; i < BI_ARRAY_SIZE; i++)
        *(arr2 + i) = new (nothrow) int[BI_ARRAY_SIZE];
    
    // As stated in lab paper, we init first element with 1
    *(*(arr2)) = 1;
    
    return;
}

/*
 * Function: fillArrays
 * -----------------------------
 * Fills 2 arrays with Pascal's triangle
 * Tab[i][0] = 1
 * Tab[i][j] = Tab[i - 1][j] + Tab[i - 1][j - 1] if i > 0, j > 0
 * Filling second array with pointer aritmetic.
 *
 * arr1: 2 dimensional static integer array with size BI_ARRAY_SIZE * BI_ARRAY_SIZE
 * arr2: Pointer to 2 dimensional interger array with size BI_ARRAY_SIZE * BI_ARRAY_SIZE
 *
 * returns: nothing
 * prints: nothing.
 *
 */
void fillArrays(int arr1[][BI_ARRAY_SIZE], int** arr2)
{
    // filling the arr1
    for (int i = 0; i < BI_ARRAY_SIZE; i++) {
        // As stated in formula in lab paper, we init [i][0] indexes to 1
        arr1[i][0] = 1;
        
        for (int j = 0; j < BI_ARRAY_SIZE; j++) {
            // If i or j equals to 0, we skip the formula
            if(!i || !j) continue;
            arr1[i][j] = arr1[i - 1][j] + arr1[i - 1][j - 1];
        }
    }
    
    // filling the arr2
    for (int i = 0; i < BI_ARRAY_SIZE; i++) {
        // As stated in formula in lab paper, we init [i][0] indexes to 1
        *(*(arr2 + i)) = 1;
        
        for (int j = 0; j < BI_ARRAY_SIZE; j++) {
            // If i or j equals to 0, we skip the formula
            if(!i || !j) continue;
            *(*(arr2 + i) + j) = *(*(arr2 + (i - 1)) + j) + *(*(arr2 + (i - 1)) + (j -1));
        }
    }
    
    
    return;
}

/*
 * Function: showBidimensionalArray
 * -----------------------------
 * Initializing, filling, and showing 2 dimensional 2 arrays.
 * Second array-Tab2Dynamic- is only used with pointer aritmetics no []
 *
 * returns: nothing
 * prints: nothing.
 *
 */
void showBidimensionalArray(void)
{
    // Our static array  decleration with given sizes
    int Tab2Static[BI_ARRAY_SIZE][BI_ARRAY_SIZE];
    // Our dynamic array decleration with given sizes
    int **Tab2Dynamic = new (nothrow) int*[BI_ARRAY_SIZE];;
    
    // Call for initing arrays
    initArrays(Tab2Static, Tab2Dynamic);
    // Call for filling the arrays and calculating the forumula
    fillArrays(Tab2Static, Tab2Dynamic);
    
    // Pringting the static array with index usage
    cout<<"Static array with index usage:"<<endl;
    for (int i = 0; i < BI_ARRAY_SIZE; i++) {
        for (int j = 0; j < BI_ARRAY_SIZE; j++) {
            cout<<Tab2Static[i][j]<<" ";
        }
        cout<<endl;
    }
    
    // Pringting the dynamic array with pointer aritmethic usage
    cout<<endl<<"---------------"<<endl<<endl;
    cout<<"Dynamic array with pointer aritmethic usage:"<<endl;
    for (int i = 0; i < BI_ARRAY_SIZE; i++) {
        for (int j = 0; j < BI_ARRAY_SIZE; j++) {
            cout<<*(*(Tab2Dynamic + i) + j)<<" ";
        }
        cout<<endl;
    }
}
