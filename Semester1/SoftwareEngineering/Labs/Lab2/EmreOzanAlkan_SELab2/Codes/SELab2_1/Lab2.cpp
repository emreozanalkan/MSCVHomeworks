//
//  Lab2.cpp
//  SELab2_1
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include "Lab2.h"

using namespace std;

// Our dumpvar initization
int dumvar = 3;

/*
 * Function: MyFunction1
 * -----------------------------
 * Adding two number and dumpvalue and returns it
 *
 * a: Integer as first input
 * b: Integer as second input
 *
 * returns: a + b and also adding global dumvar
 *
 */
int MyFunction1(int a, int b)
{
    return (a + b + dumvar);
}

/*
 * Function: MyFunction2
 * -----------------------------
 * Checking if input is 0 or not and print result
 *
 * x: Integer as first input
 *
 * prints: print if x is null or not
 *
 */
void MyFunction2(float x)
{
    if(x == 0) cout<<"x is null"<<endl;
    else cout<<"x is not null"<<endl;
}
