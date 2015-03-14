//
//  main.cpp
//  SELab2_2_2_1
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

void swap_1(int, int);
void swap_2(int&, int&);

int main(int argc, const char * argv[])
{
    int a = 8, b = 7;
    
    swap_1(a, b);
    
    cout<<"In main after swap_1, a: "<<a<<" b: "<<b<<endl;
    
    swap_2(a, b);
    
    cout<<"In main after swap_2, a: "<<a<<" b: "<<b<<endl;
    
    return EXIT_SUCCESS;
}

/*
 * Function: swap_1
 * -----------------------------
 * Swapping the two integer inputs passed by value
 *
 * a: Interger number as first input
 * b: Integer number as second input
 *
 * returns: nothing.
 * prints: Prints the value of a and b before and after the swap
 *
 */
void swap_1(int a, int b)
{
    if(a == b) return;
    cout<<"Inside swap_1, a: "<<a<<" b: "<<b<<endl;
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    cout<<"Finishing swap_1, a: "<<a<<" b: "<<b<<endl;
}

/*
 * Function: swap_2
 * -----------------------------
 * Swapping the two integer inputs passed by reference
 *
 * a: Interger number as first input
 * b: Integer number as second input
 *
 * returns: nothing.
 * prints: Prints the value of a and b before and after the swap
 *
 */
void swap_2(int& a, int& b)
{
    if(a == b) return;
    cout<<"Inside swap_2, a: "<<a<<" b: "<<b<<endl;
    a = a ^ b;
    b = b ^ a;
    a = a ^ b;
    cout<<"Finishing swap_2, a: "<<a<<" b: "<<b<<endl;
}
