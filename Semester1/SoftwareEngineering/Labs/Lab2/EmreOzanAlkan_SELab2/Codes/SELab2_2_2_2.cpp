//
//  main.cpp
//  SELab2_2_2_2
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

void swap_1(int*, int*);

int main(int argc, const char * argv[])
{
    int a = 8, b = 7;
    
    swap_1(&a, &b);
    
    cout<<"In main after swap_1, a: "<<a<<" b: "<<b<<endl;
    
    return EXIT_SUCCESS;
}

/*
 * Function: swap_1
 * -----------------------------
 * Swapping the two integer inputs passed by pointer
 *
 * a: Pointer to integer number as first input
 * b: Pointer to integer number as second input
 *
 * returns: nothing.
 * prints: Prints the value of a and b before and after the swap
 *
 */
void swap_1(int *a, int *b)
{
    // If they equals we should/have to return, otherwise XOR method fails and makes both 0
    if(*a == *b) return;
    cout<<"Inside swap_1, a: "<<*a<<" b: "<<*b<<endl;
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;
    cout<<"Finishing swap_1, a: "<<*a<<" b: "<<*b<<endl;
}

