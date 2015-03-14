//
//  main.cpp
//  SELab1_4_1
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

unsigned long long int fibonacci(unsigned int);

int main(int argc, const char * argv[])
{
    int input = 0;  // user enters the Nth fibonacci number s/he wants
    unsigned long long int result = 0; // result of the fibonacci algorithm stored
    
    cout<<"Please enter number for calculating fibonacci number"<<endl;
    cin>>input;
    
    result = fibonacci(input);
    
    cout<<input<<"th fibonacci number is: "<<result<<endl;
    
    return EXIT_SUCCESS;
}

/*
 * Function: fibonacci
 * -----------------------------
 * http://en.wikipedia.org/wiki/Fibonacci_number
 * "By definition, the first two numbers in the Fibonacci sequence are 0 and 1, and each subsequent number is the sum of the previous two."
 * 
 * Calculating the Nth fibonacci number
 *
 * n: positive integer for fibonacci sequence
 *
 * returns: the result of Nth fibonacci number of type "unsigned long long int"
 */
unsigned long long int fibonacci(unsigned int n)
{
    if(n == 0) return 0; // base case for fib(2-2)
    if(n == 1) return 1; // base case for fib(2-1)
    return fibonacci(n - 1) + fibonacci(n - 2); // recursive call with fibonacci definition
}