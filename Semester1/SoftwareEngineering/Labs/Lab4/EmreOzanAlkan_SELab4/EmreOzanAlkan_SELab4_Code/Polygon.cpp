//
//  Polygon.cpp
//  SELab4
//
//  Created by Emre Ozan Alkan on 1/11/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include "Polygon.h"

#include <iostream>

Polygon::Polygon()
{
    std::cout<<"Polygon Constructor"<<std::endl;

    _start = 0;
}

Polygon::~Polygon()
{
    std::cout<<"Polygon Destructor"<<std::endl;

    // If _start is not null, we need to clean up our double chained list
    if(_start)
    {
        // start representing the current elements and moving with deletions
        Point2d* start = this->_start;
        do
        {
            // temp representing the previos element before moving the start pointer
            Point2d* temp = start;
            start = start->getNext();
            delete temp;
            temp = 0;
        }while(start != this->_start); // chain list never end up with null, we need to check till the _start

        _start = 0;
    }
}

void Polygon::display() const
{
    std::cout<<"Polygon:"<<std::endl;

    for(int i = 0; i < this->size(); i++)
    {
        Point2d *point = this->get_item(i);
        std::cout<<"index:"<<i<<" addr:"<<std::hex<<point<<std::endl;
        point->display();
        point = 0;
    }
}

void Polygon::setStartPoint(Point2d* start)
{
    _start = start;
}

Point2d* Polygon::getStartPoint() const
{
    return _start;
}

Point2d* Polygon::begin() const
{
    return _start;
}

int Polygon::size() const
{
    int size = 0;

    Point2d* temp = this->begin();

    if(!temp) return 0; // Added for chain

    do // Added for chain
    {
        size++;
        temp = temp->getNext();
    }while(temp != this->begin());

//    while(temp)
//    {
//        size++;
//        temp = temp->getNext();
//    }

    return size;
}

Point2d* Polygon::get_item(int index) const
{
    if(index >= this->size())
    {
        std::cerr<<"get_item(): Index out of range at index:"<<index<<" size was:"<<this->size()<<std::endl;
        return 0;
    }

    Point2d* temp = this->begin();

    for(int i = 0; i < index; i++)
        temp = temp->getNext();

    return temp;
}

void Polygon::insert(Point2d* point)
{
    Point2d* temp = this->begin();

    if(!temp)
    {
        this->setStartPoint(point);
        point->setNext(point); // Added for chain
        point->setPrev(point); // Added for chain
        return;
    }

//    while(temp->getNext())
//        temp = temp->getNext();

    while(temp->getNext() != this->begin()) // Added for chain
        temp = temp->getNext();

    point->setPrev(temp); // Added for chain
    point->setNext(this->begin()); // Added for chain
    temp->setNext(point); // Added for chain
    this->begin()->setPrev(point); // Added for chain

//    temp->setNext(point);
//    point->setPrev(temp);
//    point->setNext(0);
}

void Polygon::insert_at(Point2d* point, int index)
{
    if(index == -1)
        this->insert(point);

    int size = this->size();

    if(index > size || index < 0)
    {
        std::cerr<<"insert_at(): Index out of range at index:"<<index<<" size was:"<<this->size()<<" to "<<point<<std::endl;
        return;
    }
    if(index == size)
        this->insert(point);


    Point2d* temp = this->get_item(index);

//    Point2d* temp = this->begin();

//    for(int i = 0; i < index; i++)
//        temp = temp->getNext();

    point->setPrev(temp->getPrev());
    point->setNext(temp);
    temp->getPrev()->setNext(point);
    temp->setPrev(point);
}

void Polygon::delete_at(int index)
{
    if(index >= this->size())
    {
        std::cerr<<"delete_at(): Index out of range at index:"<<index<<" size was:"<<this->size()<<std::endl;
        return;
    }

    Point2d* temp = this->get_item(index);

//    Point2d* temp = this->begin();

//    for(int i = 0; i < index; i++)
//        temp = temp->getNext();

    temp->getPrev()->setNext(temp->getNext());
    temp->getNext()->setPrev(temp->getPrev());

    delete temp;
}

Point2d* Polygon::operator[](int index)
{
    if(index >= this->size())
    {
        std::cerr<<"operator[](): Index out of range at index:"<<index<<" size was:"<<this->size()<<std::endl;
        return 0;
    }

    Point2d* temp = this->get_item(index);

//    Point2d* temp = this->begin();

//    for(int i = 0; i < index; i++)
//        temp = temp->getNext();

    return temp;
}



Polygon* Polygon::BuildPolygon()
{
    return new Polygon();
}

Polygon* Polygon::BuildPolygon(int nPoints)
{
    Polygon* polygon = new Polygon();

    for(int i = 0; i < nPoints; i++)
    {
        Point2d* point = new Point2d();

        point->askvalue();

        polygon->insert(point);
    }

    return polygon;
}

void Polygon::BuildPolygon(Polygon* polygon, int nPoints)
{
    if(!polygon)
        polygon = Polygon::BuildPolygon();

    for(int i = 0; i < nPoints; i++)
    {
        Point2d* point = new Point2d();

        point->askvalue();

        polygon->insert(point);
    }
}

void Polygon::BuildPolygon(Polygon& polygon, int nPoints)
{
    for(int i = 0; i < nPoints; i++)
    {
        Point2d* point = new Point2d();

        point->askvalue();

        polygon.insert(point);
    }
}
