//
//  main.cpp
//  SELab1_4_2
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>
#include <cmath>

#define MY_DEBUG 0
#define FIB_APPROX_POW -6. // -6. -9. -12.

using namespace std;

const long double goldenRatio = 1.6180339887498948482L;

unsigned long long int fibonacci(unsigned int);
void fibonacciApproximation(void);

int main(int argc, const char * argv[])
{
    fibonacciApproximation();
    
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

unsigned long long int fibonacci2(unsigned int n)
{
    unsigned long long int a = 1, b = 1;
    for (unsigned int i = 3; i <= n; i++) {
        unsigned long long int c = a + b;
        a = b;
        b = c;
    }
    return b;
}


/*
 * Function: fibonacciApproximation
 * -----------------------------
 *
 * Getting ratio of 2 consecutive fibonacci number and substract from golden ratio
 * We try to approximate 10^ -6 to -12 with getting absolute of this difference
 *
 * returns: nothing
 */
void fibonacciApproximation(void)
{
    // register keywords probably will not work,
    // but if it forces program somehow to use CPU registers, it may become faster.
    
    // stores min difference between ratio and fibonacci
    register long double diff = pow(10.0L, FIB_APPROX_POW);
    // ratio of 2 consecutive fibonacci number
    register long double myFibonacciRatio = .0L;
    // keep track of the index of fibonacci numbers
    register unsigned int i = 1;
    // stores the fibonacci(i + 1) number
    register unsigned long long int fibonacciN1 = 0;
    // stores the fibonacci(i)
    register unsigned long long int fibonacciN = 0;
    // stores absolute value of difference between fibonacci ratio and golden ratio
    register long double approx = .0L;
    
    do
    {
        fibonacciN = fibonacci2(i); //fibonacci(i)
        fibonacciN1 = fibonacci2(i + 1); //fibonacci(i + 1)
        
        myFibonacciRatio = double(fibonacciN1) / double(fibonacciN);
        
        approx = abs(myFibonacciRatio - goldenRatio);
        
        i++;
        
    }while(approx > diff);
    
    cout<<"Latest fibonacciN: "<<fibonacciN<<endl;
    cout<<"Latest fibonacciN1: "<<fibonacciN1<<endl;
    cout<<"Fibonacci index: "<<i<<endl;
    cout<<"Result with 10^("<<FIB_APPROX_POW<<") approximation is: myFibonacciRatio: "<<myFibonacciRatio<<" myDifference: "<<approx<<endl;
}
