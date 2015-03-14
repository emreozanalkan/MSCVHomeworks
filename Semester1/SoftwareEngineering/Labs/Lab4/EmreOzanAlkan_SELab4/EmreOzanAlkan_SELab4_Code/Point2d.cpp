//
//  Point2d.cpp
//  SELab4
//
//  Created by Emre Ozan Alkan on 1/11/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include "Point2d.h"

#include <iostream>

Point2d::Point2d():_x(.0), _y(.0)
{
    std::cout<<"Point2d Constructor"<<std::endl;

    _prev = 0;
    _next = 0;
}

Point2d::Point2d(float x, float y):_x(x), _y(y)
{
    std::cout<<"Point2d Constructor"<<std::endl;

    _prev = 0;
    _next = 0;
}

Point2d::~Point2d()
{
    std::cout<<"Point2d Destructor"<<std::endl;

    if(_prev)
        _prev = 0;
    if(_next)
        _next = 0;
}

void Point2d::display() const
{
    std::cout<<"POINT x:"<<_x<<" y:"<<_y;
    //std::cout<<" P:"<<std::hex<<(_prev ? &_prev : 0);
    std::cout<<" P:"<<std::hex<<_prev;
    //std::cout<<" N:"<<std::hex<<(_next ? &_next : 0);
    std::cout<<" N:"<<std::hex<<_next;
    std::cout<<std::endl;
}

void Point2d::setX(float x)
{
    _x = x;
}

float Point2d::getX() const
{
    return _x;
}

void Point2d::setY(float y)
{
    _y = y;
}

float Point2d::getY() const
{
    return _y;
}

void Point2d::setPrev(Point2d* prev)
{
    _prev = prev;
}

Point2d* Point2d::getPrev() const
{
    return _prev;
}

void Point2d::setNext(Point2d* next)
{
    _next = next;
}

Point2d* Point2d::getNext() const
{
    return _next;
}

void Point2d::set(float x, float y)
{
    _x = x;
    _y = y;
}

void Point2d::set(const Point2d* point)
{
    this->_x = point->getX();
    this->_y = point->getY();
}

void Point2d::set(const Point2d& point)
{
    this->_x = point.getX();
    this->_y = point.getY();
}

void Point2d::askvalue()
{
    std::cout<<"x?";
    std::cin>>_x;
    std::cout<<"y?";
    std::cin>>_y;
}
