//
//  Point2d.h
//  SELab4
//
//  Created by Emre Ozan Alkan on 1/11/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#ifndef POINT2D_H
#define POINT2D_H

#include <iostream>

// Representing 2D point
// 2 points represented by float values x and y
// Has pointers to previous and next elements
// to be used in chain list data structure
class Point2d
{
private:
    // Represents the value of x coordinate of 2D point
    float _x;
    // Represents the value of y coordinate of 2D point
    float _y;

    // Keeps track of the previous element in chain list
    Point2d* _prev;
    // Keeps track of the next element in chain list
    Point2d* _next;
public:
    // Default Constructor
    Point2d();
    // Overloaded Constructor for initializing values _x and _y
    Point2d(float, float);
    // Deconstructor
    ~Point2d();

    // Displays the values of _x, _y
    // and addresses of the _prev and _next pointers
    void display() const;

    // Setter of _x
    void setX(float);
    // Getter of _x
    float getX() const;

    // Setter of _y
    void setY(float);
    // Getter of _y
    float getY() const;

    // Setter of _prev
    void setPrev(Point2d*);
    // Getter of _prev
    Point2d* getPrev() const;

    // Setter of _next
    void setNext(Point2d*);
    // Getter of _next
    Point2d* getNext() const;

    // Sets the value of _x and _y
    void set(float, float);
    // Sets the value of _x and _y with given another point by pointer
    void set(const Point2d*);
    // Sets the value of _x and _y with given another point by reference
    void set(const Point2d&);

    // Asks user to get _x and _y values
    void askvalue();
};

#endif // POINT2D_H
