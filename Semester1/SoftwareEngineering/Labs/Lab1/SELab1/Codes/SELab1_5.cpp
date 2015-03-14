//
//  main.cpp
//  SELab1_5
//
//  Created by Emre Ozan Alkan on 10/5/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

#define MY_DEBUG 0

unsigned long long int myFactorialFunction(unsigned int);
unsigned long long int setCombination(unsigned int, unsigned int);
void printPascalTriangle(unsigned int nPascal);

int main(int argc, const char * argv[])
{
    int pascalNumber = -1;
    
    do
    {
        cout<<"Please enter positive number for Pascal's Triangle"<<endl;
        cin>>pascalNumber;
    }
    while(pascalNumber < 0);
    
    printPascalTriangle(pascalNumber);
    
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
    if(n <= 0) return 1;
    
    unsigned long long int factorial = 1;
    
    while(n > 1)
    {
        factorial *= n;
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
    unsigned long long int kFactorial = myFactorialFunction(k);
    unsigned long long int setFactorial = 1;
    
    for(unsigned int i = n; i > (n - k); i--)
        setFactorial *= i;
    
    return setFactorial / kFactorial;
}

/*
 * Function: printPascalTriangle
 * -----------------------------
 * http://en.wikipedia.org/wiki/Pascal's_triangle
 * "Pascal's triangle is a triangular array of the binomial coefficients"
 *
 * Inspired by: http://www.cplusplus.com/forum/general/56615/#msg304724
 *
 * nPascal: positive integer for Nth first row of pascal
 *
 * returns: nothing
 * prints: pascal triangle of nPascal th first row
 */
void printPascalTriangle(unsigned int nPascal)
{
    unsigned long long int pascalNumber = 1; // storing first number of pascal triangle
    
    cout<<"==Pascal Triangle=="<<endl;
    
    for(unsigned int i = 0; i < nPascal; i++) // looping to print pascal lines
    {
        for(unsigned int j = 0; j <= i; j++) // looping to print pascal numbers in line i
        {
            pascalNumber = setCombination(i, j); // Calculation pascal numbers for ith row ex : (5 0) (5 1) (5 2) (5 3) (5 4) (5 5)
            cout<<pascalNumber<<" ";
        }
        cout<<endl;
    }
    
    return;
}
