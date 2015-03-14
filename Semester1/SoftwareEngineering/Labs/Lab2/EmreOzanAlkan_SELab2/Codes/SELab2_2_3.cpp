//
//  main.cpp
//  SELab2_2_3
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>
#include <cmath>

using namespace std;

void CartesianToPolar(const double*, const double*, double*, double*);

int main(int argc, const char * argv[])
{
    // z = a + bi
    // representing complex number parts
    double a, b;
    
    // components of polar form
    double p, theta;
    
    a = 2.;
    b = 5.;
    p = .0;
    theta = .0;
    
    CartesianToPolar(&a, &b, &p, &theta);
    
    cout<<"After CartesianToPolar for values a: "<<a<<" b: "<<b<<", p: "<<p<<" theta: "<<theta<<endl;
    
    return EXIT_SUCCESS;
}

/*
 * Function: CartesianToPolar
 * -----------------------------
 * Mapping complex number represented by z = a + bi to 
 * polar system with P and theta components.
 *
 * a: Pointer to constant double number, first parameter, representing first part of the complex number
 * b: Pointer to constant double number, second parameter, representing second part of the complex number
 * p: Pointer to double number, Magnitude/Modus of the complex number
 * theta: Pointer to double number, angle of the complex number in polar form
 *
 * returns: nothing.
 * prints: nothing.
 *
 */
void CartesianToPolar(const double *a, const double *b, double *p, double *theta)
{
    *p = sqrt(pow(*a, 2.0) + pow(*b, 2.0));
    
    *theta = atan(*b / *a);
    
    return;
}
