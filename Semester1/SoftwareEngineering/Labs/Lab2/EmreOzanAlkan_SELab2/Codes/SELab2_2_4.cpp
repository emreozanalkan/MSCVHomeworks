//
//  main.cpp
//  SELab2_2_4
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

bool IsMultipleOf(int, int = 2);
void checkMultiple(void);

int main(int argc, const char * argv[])
{
    checkMultiple();
    
    return EXIT_SUCCESS;
}

/*
 * Function: IsMultipleOf
 * -----------------------------
 * Checking if number p is a multiple of number q
 *
 * p: Integer number as first input p
 * q: Integer number as second input q | Default value if 2
 *
 * returns: boolean value(true if p is multiple of q, else false)
 * prints: nothing
 *
 */
bool IsMultipleOf(int p, int q)
{
    if(p % q == 0) return true;
    
    return false;
}

/*
 * Function: checkMultiple
 * -----------------------------
 * Testing function for IsMultipleOf(int, int)
 *
 * returns: nothing.
 * prints: Call the "IsMultipleOf" and prints the result of multiplier check
 *
 */
void checkMultiple(void)
{
    if(IsMultipleOf(100))
        cout<<"100 is multiple of 2"<<endl;
    else
        cout<<"100 is NOT multiple of 2"<<endl;
    
    if(IsMultipleOf(55))
        cout<<"55 is multiple of 2"<<endl;
    else
        cout<<"55 is NOT multiple of 2"<<endl;
    
    // == //
    
    if(IsMultipleOf(33, 3))
        cout<<"33 is multiple of 3"<<endl;
    else
        cout<<"33 is NOT multiple of 3"<<endl;
    
    if(IsMultipleOf(98, 3))
        cout<<"98 is multiple of 3"<<endl;
    else
        cout<<"98 is NOT multiple of 3"<<endl;
}
