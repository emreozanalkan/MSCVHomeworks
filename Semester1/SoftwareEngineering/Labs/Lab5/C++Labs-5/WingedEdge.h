//--------------------------
// Wingededge .h
//--------------------------

#ifndef _WINGEDEDGE_              // to avoid multiple inclusion of header files
#define _WINGEDEDGE_              // see lecture on macros (very end of the last lecture)

#include <iostream>
using namespace std;
class Point; // declaration only
class Edge;  // declaration only
class Face;  // declaration only

class Point{

    public:
    Point();
    Point(float, float, float);
    ~Point();
    void Info( ) {cout<<"address="<<this<< ": "<<x<<" "<<y<<" "<<z<<endl;};
    float x,y,z;
};

class Edge{

    // constructors and destructor
    public: // everything public, bad strategy, but sufficient for our purpose

    // Members
    // to represent pointers to extremities P1 and P2
    Point*P1,*P2;

    // to represent pointers to faces sharing this edge
    Face*Fcw, *Fccw;

    // to represent pointers to edges in the face and the adjacent face
    // clockwise and counterclokwise
    Edge*Nextcw, *Prevcw, *Nextccw, *Prevccw;

    // Constructors
    Edge();
    Edge(Point*, Point*);
    Edge(Point*, Point*, Edge*, Edge*, Edge*, Edge*);
    Edge(Point*, Point*, Edge*, Edge*, Edge*, Edge*, Face*, Face*);

    // Destructor
    ~Edge();

    // Function for display information related to the various pointers
    void Info( ) {
            cout<<"Adresses of"<<endl;
            cout<<"Current segment:"<<this<<endl;
            cout<<"P1:"<<P1<<"\t P2:"<<P2<<endl;
            cout<<"Fcw:"<<Fcw<<"\t Fccw:"<<Fccw<<endl;
            cout<<"Nextcw:"<<Nextcw<<"\t Prevcw:"<< Prevcw <<endl;
            cout<<"Nextccw:"<<Nextccw<<"\t Prevccw:"<< Prevccw <<endl;

    };
}; // end class Edge

class Face{

    public:

    // Pointer to the first edge
    Edge* Start;

    // Constructors
    Face();
    Face(Edge*);

    // Destructor
    ~Face();

    //Function for information display
    void Info()    {
        cout <<"Face address:"<<this<<endl;
        cout <<"starting Edge address"<<Start<<endl;
        if(Start) Start->Info();
    };
}; // end class Face

#endif // _WINGEDEDGE_
