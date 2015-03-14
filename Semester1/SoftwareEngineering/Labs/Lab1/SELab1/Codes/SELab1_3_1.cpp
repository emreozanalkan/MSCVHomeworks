//
//  main.cpp
//  SELab1_3_1
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#define MY_DEBUG 0  // My own debug define. 1 is for debugging and showing dubug outputs, 0 is debug off.

using namespace std;

unsigned long long int myFactorialFunction(unsigned int);

int main(int argc, const char * argv[])
{
    // Integer number for user input to calculate factorial.
    int factorialNumber = -1;
    
    do
    {
        cout<<"Please enter positive number for factorial"<<endl;
        cin>>factorialNumber;
    }
    while(factorialNumber < 0);  // while getting positive number we keep asking user for valid input
    
    cout<<"Factorial result is: "<<myFactorialFunction(factorialNumber)<<endl;
    
    return EXIT_SUCCESS;
}

/*
 * Function: myFactorialFunction
 * -----------------------------
 * http://en.wikipedia.org/wiki/Factorial
 * "Factorial of a non-negative integer n, denoted by n!"
 *
 * n: positive integer for factorial degree
 *
 * returns: the result of factorial calculation of type "unsigned long long int"
 */
unsigned long long int myFactorialFunction(unsigned int n)
{
#if MY_DEBUG
    cout<<"myFactorialFunction param n: "<<n<<endl;
#endif
    if(n <= 0) return 1;
    
    // stores the factorial calculation
    unsigned long long int factorial = 1;
    
    while(n > 1)
    {
        factorial *= n;
#if MY_DEBUG
        cout<<"myFactorialFunction current factorial is "<<factorial<<endl;
#endif
        --n;
    }
    
    return factorial;
}
