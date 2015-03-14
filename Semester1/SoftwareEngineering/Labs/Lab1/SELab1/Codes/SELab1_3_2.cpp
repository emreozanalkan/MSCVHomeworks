//
//  main.cpp
//  SELab1_3_2
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#define MY_DEBUG 0

#define SET_SIZE 49 // Set size for combination calculation
#define K_COMBINATION 6 // k-combination for combination calculation

using namespace std;

unsigned long long int myFactorialFunction(unsigned int);
unsigned long long int setCombination(unsigned int, unsigned int);


int main(int argc, const char * argv[])
{
    // stores the result of total amount of combinations of set S
    unsigned long long int numberOfCombinations = 0;
    
    numberOfCombinations = setCombination(SET_SIZE, K_COMBINATION);
    
    cout<<"Number of combination of a lottery game: "<<numberOfCombinations<<endl;
    
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

/*
 * Function: setCombination
 * -----------------------------
 * http://en.wikipedia.org/wiki/Combination
 * "K-combination of a set S"
 *
 * n: positive integer for set number
 * k: positive integer for k-combination
 *
 * returns: the result of combination of type "unsigned long long int"
 */
unsigned long long int setCombination(unsigned int n, unsigned int k)
{
#if MY_DEBUG
    cout<<"setCombination param n: "<<n<<" k: "<<k<<endl;
#endif
    
    // Calculation the denominator part with only k.
    // Instead of calculating all the factorials, below we go n to (n-k) to avoid n! and (n-k)!
    unsigned long long int kFactorial = myFactorialFunction(k);
    unsigned long long int setFactorial = 1; // Storing the result of numerator part, but just n to (n-k)
    
    
    // Instead of calculating n! / (n-k)!, we calculate n * (n - 1) * ... * (n - k + 1)
    for(unsigned int i = n; i > (n - k); i--)
        setFactorial *= i;
    
#if MY_DEBUG
    cout<<"setCombination setFactorial: "<<setFactorial<<" kFactorial: "<<kFactorial<<endl;
#endif
    
    return setFactorial / kFactorial;
}
