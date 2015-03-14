//
//  main.cpp
//  SELab1_2_1
//
//  Created by Emre Ozan Alkan on 10/1/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#define MY_DEBUG 0 // My custom debug definition. 1 is for debugging, 0 is off.

using namespace std;

template<class T1, class T2>
void myMaxFunction(T1, T2);

template<class T1, class T2>
void myMinFunction(T1, T2);

template<class T1, class T2>
void myMeanFunction(T1, T2);

int main(int argc, const char * argv[])
{
    
#if !MY_DEBUG // When debug mode is off, we get input from user
    
    float firstNumber, secondNumber;
    
    cout<<"Please enter first number: "<<endl;
    cin>>firstNumber;
    cout<<"Please enter second number: "<<endl;
    cin>>secondNumber;
    
    myMaxFunction(firstNumber, secondNumber);
    myMinFunction(firstNumber, secondNumber);
    myMeanFunction(firstNumber, secondNumber);
    
#else // When debug mode is on, we test functions with different types
    
    myMaxFunction(3, 5);
    myMinFunction(3, 5);
    myMeanFunction(3, 5);
    
    cout<<"--"<<endl;
    
    myMaxFunction(4, 7.);
    myMinFunction(4, 7.);
    myMeanFunction(4, 7.);
    
    cout<<"--"<<endl;
    
    myMaxFunction(.4, -7);
    myMinFunction(.4, -7);
    myMeanFunction(.4, -7);
    
    cout<<"--"<<endl;
    
    myMaxFunction(1., 2.);
    myMinFunction(1., 2.);
    myMeanFunction(1., 2.);
    
#endif // #if !MY_DEBUG
    
    return EXIT_SUCCESS;
}

/*
 * Function: myMaxFunction
 * -----------------------------
 * Calculating the maximum of the two given numbers
 *
 * T1: Any data type of number as first parameter
 * T2: Any data type of number as second parameter
 *
 * returns: nothing.
 * prints: Prints the maximum of the two numbers to console.
 *
 */
template<class T1, class T2>
void myMaxFunction(T1 firstNumber, T2 secondNumber)
{
    cout<<"The maximum of your inputs is: "<<(firstNumber > secondNumber ? firstNumber : secondNumber)<<endl;
}

/*
 * Function: myMinFunction
 * -----------------------------
 * Calculating the minumum of the two given numbers
 *
 * T1: Any data type of number as first parameter
 * T2: Any data type of number as second parameter
 *
 * returns: nothing.
 * prints: Prints the minimum of the two numbers to console.
 *
 */
template<class T1, class T2>
void myMinFunction(T1 firstNumber, T2 secondNumber)
{
    cout<<"The minumum of your inputs is: "<<(firstNumber < secondNumber ? firstNumber : secondNumber)<<endl;
}

/*
 * Function: myMeanFunction
 * -----------------------------
 * Calculating the mean of the two given numbers
 *
 * T1: Any data type of number as first parameter
 * T2: Any data type of number as second parameter
 *
 * returns: nothing.
 * prints: Prints the mean value of the two numbers to console.
 *
 */
template<class T1, class T2>
void myMeanFunction(T1 firstNumber, T2 secondNumber)
{
    cout<<"The mean of your inputs is: "<<((firstNumber + secondNumber) / 2.)<<endl;
}

