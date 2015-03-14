#-------------------------------------------------
#
# Project created by QtCreator 2013-11-29T08:19:19
#
#-------------------------------------------------

cache()

QT       += core

QT       -= gui

TARGET = SELab8_Test
CONFIG   += console
CONFIG   -= app_bundle

CONFIG += c++11
QMAKE_CXXFLAGS += -std=c++11 -stdlib=libc++ -mmacosx-version-min=10.7
LIBS += -stdlib=libc++ -mmacosx-version-min=10.7

TEMPLATE = app


SOURCES += main.cpp

HEADERS += \
    CMatrix.h
