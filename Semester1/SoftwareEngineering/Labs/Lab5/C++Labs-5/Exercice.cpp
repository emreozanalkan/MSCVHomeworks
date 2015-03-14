#include "Exercice.h"
#include <iostream>
using namespace std;

ArrayPoint :: ArrayPoint(){
    n=0;
    nmax = 100;
    array = new Point*[nmax];
    for( int i=0; i<nmax; i++) array[i] = 0;
}

ArrayPoint :: ~ArrayPoint(){

    for( int i=0; i<n; i++) delete array[i];
    delete [] array;
}

Point * ArrayPoint ::GetAt( int pos){
    if ( pos<0 || pos>=n)  return 0;
    return array[pos];
}

int ArrayPoint :: GetPos(Point*P){
    int i=0;
    while (i<n)
    {
        if (GetAt(i) == P ) return i;
        i++;
    }

    return -1;
}

//-----------------------------------
//class ArrayEdge
//-----------------------------------

ArrayEdge :: ArrayEdge(){
    n=0;
    nmax = 100;
    array = new Edge*[nmax];
    for( int i=0; i<nmax; i++) array[i] = 0;
}

ArrayEdge :: ~ArrayEdge(){

    for( int i=0; i<n; i++) delete array[i];
    delete [] array;
}

Edge * ArrayEdge :: GetAt( int pos){
    if (pos<0 || pos>=n)  return 0;
    return array[pos];
}

int ArrayEdge :: GetPos(Edge*E){
    int i=0;
    while (i<n)
    {
        if (GetAt(i) == E ) return i;
        i++;
    }

    return -1;
}

//-----------------------------------
// class ArrayFace
//-----------------------------------

ArrayFace :: ArrayFace(){
    n=0;
    nmax = 100;
    array = new Face*[nmax];
    for( int i=0; i<nmax; i++) array[i] = 0;
}

ArrayFace :: ~ArrayFace(){

    for( int i=0; i<n; i++) delete array[i];
    delete [] array;
}

Face * ArrayFace :: GetAt( int pos){
    if (pos<0 || pos>=n)  return 0;
    return array[pos];
}

int ArrayFace :: GetPos(Face*F){
    int i=0;
    while (i<n)
    {
        if (GetAt(i) == F ) return i;
        i++;
    }

    return -1;
}

// student work start here

void ArrayPoint :: Info(){
    cout << "Array of Points info:"<<n<<" elements"<<endl;

    for(int i=0; i<n; i++) {
        cout <<i<<" ";array[i]->Info();
    }
}

void ArrayEdge :: Info(){
    cout << "Array of Edges info :"<<n<<" elements"<<endl;

    for(int i=0; i<n; i++) {
        cout <<endl<<i<<" ";array[i]->Info();
    }
}

void ArrayFace :: Info(){
    cout << "Array of Edges info :"<<n<<" elements"<<endl;

    for(int i=0; i<n; i++) {
        cout <<endl<<i<<" ";array[i]->Info();
    }
}



bool ArrayPoint :: AddPoint(){

    if ( n == nmax) {cout<<"max size reached, creation impossible"<<endl; return false;}

    cout <<" enter coordinates"<<endl;
    float x, y, z;
    cin >> x >> y >> z;

    array[n] = new Point(x, y, z);
    n++;
    return true;
}

bool ArrayPoint :: AddPoint(Point *P){

    if ( P == 0) {cout<<"pointer null, adding impossible"<<endl; return false;}
    if ( n == nmax) {cout<<"max size reached, creation impossible"<<endl; return false;}

    array[n] = P;
    n++;
    return true;
}

bool ArrayEdge :: AddEdge(Edge*E)
{
    if ( E == 0) {cout<<"pointer null, adding impossible"<<endl; return false;}
    if ( n == nmax) {cout<<"max size reached, creation impossible"<<endl; return false;}

    array[n] = E;
    n++;
    return true;
}

bool ArrayFace :: AddFace(Face * F)
{
    if ( F == 0) {cout<<"pointer null, adding impossible"<<endl; return false;}
    if ( n == nmax) {cout<<"max size reached, creation impossible"<<endl; return false;}

    array[n] = F;
    n++;
    return true;
}
