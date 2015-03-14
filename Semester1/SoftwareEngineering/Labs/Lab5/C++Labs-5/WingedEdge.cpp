#include "WingedEdge.h"
using namespace std;

//-----------------------------------
//for class point
//-----------------------------------

Point :: Point() { x = y = z = 0;}
Point :: Point(float a, float b, float c) { x = a; y = b; z = c;}
Point :: ~Point(){}

//-----------------------------------
//for class edge
//-----------------------------------

Edge :: Edge(){
    P1 = P2 = 0;
    Nextcw = Prevcw = Nextccw = Prevccw = 0;
    Fcw = Fccw = 0;
}

Edge :: Edge(Point*A, Point*B){
    P1 = A; P2 = B;
    Nextcw = Prevcw = Nextccw = Prevccw = 0;
    Fcw = Fccw = 0;
}

Edge :: Edge(Point*A, Point*B, Edge*Ncw, Edge*Nccw, Edge*Pcw, Edge*Pccw){
    P1 = A; P2 = B;

    Nextcw = Ncw;
    Prevcw = Pcw;
    Nextccw = Nccw;
    Prevccw = Pccw;

    Fcw = Fccw = 0;
}

Edge :: Edge(Point*A, Point*B, Edge*Ncw, Edge*Nccw, Edge*Pcw, Edge*Pccw, Face*Face_cw, Face*Face_ccw){
    P1 = A; P2 = B;

    Nextcw = Ncw;
    Prevcw = Pcw;
    Nextccw = Nccw;
    Prevccw = Pccw;

    Fcw = Face_cw;
    Fccw = Face_ccw;
}

Edge :: ~Edge(){}

//-----------------------------------
// class face
//-----------------------------------

Face :: Face() { Start = 0; }

Face :: Face( Edge*S){ Start= S; }

Face :: ~Face() {}
