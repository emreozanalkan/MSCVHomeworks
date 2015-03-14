//
//  main.cpp
//  SELab2
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>
#include "Lab2.h"

int main(int argc, const char * argv[])
{
    
    int result = MyFunction1(3, 5);
    
    cout<<"Result of MyFunction1: "<<result<<endl;
    
    MyFunction2(5.8);
    
    return EXIT_SUCCESS;
}

