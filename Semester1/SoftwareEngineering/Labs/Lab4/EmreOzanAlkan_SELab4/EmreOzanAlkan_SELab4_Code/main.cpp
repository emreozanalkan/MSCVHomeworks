//
//  main.cpp
//  SELab4
//
//  Created by Emre Ozan Alkan on 1/11/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

#include "Polygon.h"

using namespace std;

// [] overloading for Point2d references
std::ostream& operator<<(std::ostream&, const Point2d&);

// [] overloading for Point2d pointers
std::ostream& operator<<(std::ostream&, const Point2d*);

// [] overloading for Polygon references
std::ostream& operator<<(std::ostream&, const Polygon&);

// [] overloading for Polygon pointers
std::ostream& operator<<(std::ostream&, const Polygon*);

int main(int argc, char *argv[])
{
    cout<<"Point2d Dummy Test"<<endl;
    cout<<"------------------"<<endl;
    Point2d *dummy = new Point2d();

    dummy->display();
    dummy->set(.4, 5.);
    dummy->display();
    dummy->setX(3.8);
    dummy->setY(1.2);
    dummy->display();
    dummy->askvalue();
    cout<<dummy;

    delete dummy;
    dummy = 0;

    cout<<endl<<endl;


    cout<<"Polygon Test"<<endl;
    cout<<"------------------"<<endl;

    Polygon* polygon = Polygon::BuildPolygon(4);

    polygon->display();

    cout<<"Current Size: "<<polygon->size()<<endl;

    Point2d* testPoint1 = new Point2d();
    testPoint1->askvalue();

    polygon->insert(testPoint1);

    cout<<"Current Size: "<<polygon->size()<<endl;

    polygon->display();

    Point2d* testPoint2 = new Point2d();
    testPoint2->askvalue();

    polygon->insert_at(testPoint2, 2);

    cout<<"Current Size: "<<polygon->size()<<endl;

    polygon->display();

    polygon->delete_at(2);

    cout<<"Current Size: "<<polygon->size()<<endl;

    cout<<polygon; //polygon->display();

    delete polygon;

    return EXIT_SUCCESS;
}

std::ostream& operator<<(std::ostream& os, const Point2d& point)
{
  point.display();
  return os;
}

std::ostream& operator<<(std::ostream& os, const Point2d* point)
{
  point->display();
  return os;
}

std::ostream& operator<<(std::ostream& os, const Polygon& polygon)
{
  polygon.display();
  return os;
}

std::ostream& operator<<(std::ostream& os, const Polygon* polygon)
{
  polygon->display();
  return os;
}
