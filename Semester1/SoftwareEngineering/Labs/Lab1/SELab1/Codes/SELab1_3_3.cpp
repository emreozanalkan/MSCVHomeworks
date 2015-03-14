//
//  main.cpp
//  SELab1_3_3
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#define MY_DEBUG 0

#define SET_SIZE 5 // Set size for repititive combinations for Yathzee game
#define K_POSSIBILITY 6 // Number of possibility for each case in Yatzee game

using namespace std;

unsigned long long int myFactorialFunction(unsigned int);
unsigned long long int repetitionCombination(unsigned int, unsigned int);

int main(int argc, const char * argv[])
{
    unsigned long long int numberOfCombinationsWithRepetitions = 0;
    numberOfCombinationsWithRepetitions = repetitionCombination(SET_SIZE, K_POSSIBILITY);
    cout<<"The number of possible combinations of the Yathzee game: "<<numberOfCombinationsWithRepetitions<<endl;
    
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
 * Function: repetitionCombination
 * -----------------------------
 * http://en.wikipedia.org/wiki/Combination#Number_of_combinations_with_repetition
 * "K-combination of a set S"
 *
 * n: positive integer for set number
 * k: positive integer for k-combination
 *
 * returns: the result of number of combination with repetitions of type "unsigned long long int"
 */
unsigned long long int repetitionCombination(unsigned int n, unsigned int k)
{
#if MY_DEBUG
    cout<<"repetitionCombination param n: "<<n<<" k: "<<k<<endl;
#endif
    unsigned long long int topResult = myFactorialFunction(n + k -1); // Calculating enumarator part of the formula
    unsigned long long int bottomResult = myFactorialFunction(k) * myFactorialFunction(n -1); // Calculating denominator part of the formula
    
#if MY_DEBUG
    cout<<"repetitionCombination topResult: "<<topResult<<" bottomResult: "<<bottomResult<<endl;
#endif
    
    return topResult / bottomResult;
}
