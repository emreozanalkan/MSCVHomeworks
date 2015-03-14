//--------------------------
// exercice .h
//--------------------------

#ifndef _EXERCICE_              // to avoid multiple inclusion of header files
#define _EXERCICE_              // see lecture on macros (very end of the last lecture)


#include "WingedEdge.h"
#include <iostream>
using namespace std;
class ArrayPoint{

    public:
    //constructor and destructor
    ArrayPoint();
    ~ArrayPoint();

    int n;                  // number of elements
    int nmax;               // max number of elements
    Point **array;          // array of pointers
    Point*GetAt(int pos);   // return the pointer at a given position
    int GetPos( Point*P );  // return the position of a given pointer

    void Info();

    bool AddPoint();        // create then add
    bool AddPoint(Point*);  // only add, supposing the point is already created

};

class ArrayEdge{

    public:
    int n;                  // number of elements
    int nmax;               // max number of elements

    Edge**array;            // array of pointers

    //constructor and destructor
     ArrayEdge();
    ~ArrayEdge();

    //Information display
    void Info();

    // Accessing the data by index or by pointer
    Edge*GetAt(int pos);
    int GetPos(Edge*E);

    //students work starts here
    bool AddEdge(Edge*);
};

class ArrayFace{

    public :

    //constructor and destructor
    ArrayFace();
    ~ArrayFace();

    //information display
    void Info();

    int n;          // number of elements
    int nmax;       // max number of elements
    Face**array;    // array of pointers

    // Accessing the data by index or by pointer
    Face*GetAt(int pos);
    int GetPos(Face*F);

    //students work starts here
    bool AddFace(Face * F);
};




#endif // _EXERCICE_
