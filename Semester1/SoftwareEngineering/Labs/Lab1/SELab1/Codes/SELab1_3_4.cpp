//
//  main.cpp
//  SELab1_3_4
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#define MY_DEBUG 0

#define SET_SIZE 54
#define K_PERMUTATION 5

using namespace std;

unsigned long long int myFactorialFunction(unsigned int);
unsigned long long int myPermutationFunction(unsigned int, unsigned int);

int main(int argc, const char * argv[])
{
    unsigned long long int numberOfPermutation = 0;
    numberOfPermutation = myPermutationFunction(SET_SIZE, K_PERMUTATION);
    cout<<"The number of permutation if you choose 5 cards (poker): "<<numberOfPermutation<<endl;
    
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
 * Function: myPermutationFunction
 * -----------------------------
 * http://en.wikipedia.org/wiki/Permutation
 * "The k-permutations, or partial permutations, are the sequences of k distinct elements selected from a set."
 *
 * n: positive integer for set number
 * k: positive integer for k-combination
 *
 * returns: the result of number of combination with repetitions of type "unsigned long long int"
 */
unsigned long long int myPermutationFunction(unsigned int n, unsigned int k)
{
#if MY_DEBUG
    cout<<"myPermutationFunction param n: "<<n<<" k: "<<k<<endl;
#endif
    
    // return myFactorialFunction(n) / myFactorialFunction(n-k);
    
    // storing result of the permutation
    unsigned long long int result = 1;
    
    for(unsigned int i = n; i > n - k; i--) // instead of calculating factorials individually, we multiply from n to n-k( n * (n - 1) * ... (n - k + 1))
        result = result * i;
    
    return result;
}