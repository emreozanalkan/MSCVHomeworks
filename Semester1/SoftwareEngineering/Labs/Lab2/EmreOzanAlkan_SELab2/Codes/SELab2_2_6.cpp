//
//  main.cpp
//  SELab2_2_6
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

void ArraysExample1(void);

int main(int argc, const char * argv[])
{
    ArraysExample1();
    
    return EXIT_SUCCESS;
}

/*
 * Function: ArraysExample1
 * -----------------------------
 * Function for demonstrating monodimensional array example
 * Declearing static and dynamic array with size 10
 * Filling array with 0 to 9
 * Pringting values inside
 *
 * returns: nothing.
 * prints: nothing.
 *
 */
void ArraysExample1(void)
{
    int array1[10];
    int *array2 = new (nothrow) int[10];
    
    for (int i = 0; i < 10; i++) {
        array1[i] = i;
        array2[i] = i;
    }
    
    for (int i = 0; i < 10; i++) {
        cout<<"array1["<<i<<"] value is: "<<array1[i]<<endl;
        cout<<"array2["<<i<<"] value is: "<<array2[i]<<endl;
    }
}