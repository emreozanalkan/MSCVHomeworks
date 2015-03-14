//
//  main.cpp
//  SELab2_2_5
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

bool Prime(int, int = 2);

int main(int argc, const char * argv[])
{
    int primeNumber = 2;
    bool result = false;
    
    cout<<"Please enter number for prime check:"<<endl;
    cin>>primeNumber;
    
    result = Prime(primeNumber);
    
    if(result)
        cout<<primeNumber<<" is prime"<<endl;
    else
        cout<<primeNumber<<" is NOT prime"<<endl;
    
    return EXIT_SUCCESS;
}


/*
 * Function: Prime
 * -----------------------------
 * Recursively finding if given number is prime
 *
 * prime: Integer number as first input for checking primeness
 * divider: Integer number as second input for recursively increasing to divide number
 *
 * returns: Boolean value, true if number is prime, otherwise false.
 * prints: nothing.
 *
 */
bool Prime(int prime, int divider)
{
    if(divider > prime) return false;
    if(prime % divider == 0 && prime > divider) return false;
    
    Prime(prime, divider + 1);
    
    return true;
}

