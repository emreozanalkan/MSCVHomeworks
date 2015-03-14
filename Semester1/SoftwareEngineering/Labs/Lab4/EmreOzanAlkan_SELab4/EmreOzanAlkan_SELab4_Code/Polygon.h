//
//  Polygon.h
//  SELab4
//
//  Created by Emre Ozan Alkan on 1/11/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#ifndef POLYGON_H
#define POLYGON_H

#include "Point2d.h"

// Representing a polygon with 2D points
// Polygon class compose of Point2d classes
// Polygon class keeps root of the chain list
// represented with Point2d pointer: _start
class Polygon
{
private:
    // Representing the first element in the double chained list
    Point2d* _start;
public:
    // Default constructor
    Polygon();
    // Desctructor
    ~Polygon();

    // Displays the indexes, addresses of the elements in chain list
    // and displays Point2d itself
    void display() const;

    // Setter of the _start
    void setStartPoint(Point2d*);
    // Getter of the _start
    Point2d* getStartPoint() const;

    // Returns the first element in chain list: _start
    Point2d* begin() const;
    // Returns the size of the double chain list
    int size() const;
    // Returns the item in the given index
    Point2d* get_item(int) const;
    // Inserts the given item with pointer to the end of the chain list
    void insert(Point2d*);
    // Inserts the given item with pointer to the given index, otherwise end of the chain list
    void insert_at(Point2d*, int = -1);
    // Deletes the item from the given index
    void delete_at(int);

    // [] operator overload returns the item specified with index
    Point2d* operator[](int);

    // Creates new polygon and returns its pointer
    static Polygon* BuildPolygon();
    // Creates new polygon, creates number of Point2d elements specified with parameter
    // Ask user for values of the points and returns the created polygon's pointer
    static Polygon* BuildPolygon(int);
    // Creates number of Point2d elements specified with parameters and asks user their values
    // and assign them to the given polygon by pointer
    static void BuildPolygon(Polygon*, int);
    // Creates number of Point2d elements specified with parameters and asks user their values
    // and assign them to the given polygon by reference
    static void BuildPolygon(Polygon&, int);
};

#endif // POLYGON_H
