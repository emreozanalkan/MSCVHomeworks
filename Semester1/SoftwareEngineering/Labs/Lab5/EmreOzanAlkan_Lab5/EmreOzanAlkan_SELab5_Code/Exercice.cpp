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

// "7 : Link segment clockwise - prev and next - (student work here)"
void ArrayEdge::linkSegmentsCWCubic(ArrayPoint* pointArray)
{
    if(pointArray->n < 8)
    {
        cerr<<"In Point Array, there is not enough element to represent cube."<<endl;
        return;
    }

    Edge* edge01;
    Edge* edge02;
    Edge* edge03;
    Edge* edge04;
    Edge* edge05;
    Edge* edge06;
    Edge* edge07;
    Edge* edge08;
    Edge* edge09;
    Edge* edge10;
    Edge* edge11;
    Edge* edge12;

    if(this->n < 12)
    {
        edge01 = new Edge(pointArray->GetAt(0), pointArray->GetAt(1));
        edge02 = new Edge(pointArray->GetAt(1), pointArray->GetAt(2));
        edge03 = new Edge(pointArray->GetAt(2), pointArray->GetAt(3));
        edge04 = new Edge(pointArray->GetAt(3), pointArray->GetAt(0));
        edge05 = new Edge(pointArray->GetAt(7), pointArray->GetAt(6));
        edge06 = new Edge(pointArray->GetAt(6), pointArray->GetAt(5));
        edge07 = new Edge(pointArray->GetAt(5), pointArray->GetAt(4));
        edge08 = new Edge(pointArray->GetAt(4), pointArray->GetAt(7));
        edge09 = new Edge(pointArray->GetAt(0), pointArray->GetAt(4));
        edge10 = new Edge(pointArray->GetAt(1), pointArray->GetAt(5));
        edge11 = new Edge(pointArray->GetAt(2), pointArray->GetAt(6));
        edge12 = new Edge(pointArray->GetAt(3), pointArray->GetAt(7));

        this->AddEdge(edge01);
        this->AddEdge(edge02);
        this->AddEdge(edge03);
        this->AddEdge(edge04);
        this->AddEdge(edge05);
        this->AddEdge(edge06);
        this->AddEdge(edge07);
        this->AddEdge(edge08);
        this->AddEdge(edge09);
        this->AddEdge(edge10);
        this->AddEdge(edge11);
        this->AddEdge(edge12);
    }
    else
    {
        edge01 = this->GetAt(0);
        edge02 = this->GetAt(1);
        edge03 = this->GetAt(2);
        edge04 = this->GetAt(3);
        edge05 = this->GetAt(4);
        edge06 = this->GetAt(5);
        edge07 = this->GetAt(6);
        edge08 = this->GetAt(7);
        edge09 = this->GetAt(8);
        edge10 = this->GetAt(9);
        edge11 = this->GetAt(10);
        edge12 = this->GetAt(11);
    }

    edge01->Nextcw  = edge10;
    edge01->Prevcw  = edge09;

    edge02->Nextcw  = edge11;
    edge02->Prevcw  = edge10;

    edge03->Nextcw  = edge12;
    edge03->Prevcw  = edge11;

    edge04->Nextcw  = edge09;
    edge04->Prevcw  = edge12;

    edge05->Nextcw  = edge11;
    edge05->Prevcw  = edge12;

    edge06->Nextcw  = edge10;
    edge06->Prevcw  = edge11;

    edge07->Nextcw  = edge09;
    edge07->Prevcw  = edge10;

    edge08->Nextcw  = edge12;
    edge08->Prevcw  = edge09;

    edge09->Nextcw  = edge08;
    edge09->Prevcw  = edge04;

    edge10->Nextcw  = edge07;
    edge10->Prevcw  = edge01;

    edge11->Nextcw  = edge06;
    edge11->Prevcw  = edge02;

    edge12->Nextcw  = edge05;
    edge12->Prevcw  = edge03;

    return;
}

// "8 : Link segment counterclockwise - prev and next - (student work here)"
void ArrayEdge::linkSegmentsCCWCubic(ArrayPoint* pointArray)
{
    if(pointArray->n < 8)
    {
        cerr<<"In Point Array, there is not enough element to represent cube."<<endl;
        return;
    }

    Edge* edge01;
    Edge* edge02;
    Edge* edge03;
    Edge* edge04;
    Edge* edge05;
    Edge* edge06;
    Edge* edge07;
    Edge* edge08;
    Edge* edge09;
    Edge* edge10;
    Edge* edge11;
    Edge* edge12;

    if(this->n < 12)
    {
        edge01 = new Edge(pointArray->GetAt(0), pointArray->GetAt(1));
        edge02 = new Edge(pointArray->GetAt(1), pointArray->GetAt(2));
        edge03 = new Edge(pointArray->GetAt(2), pointArray->GetAt(3));
        edge04 = new Edge(pointArray->GetAt(3), pointArray->GetAt(0));
        edge05 = new Edge(pointArray->GetAt(7), pointArray->GetAt(6));
        edge06 = new Edge(pointArray->GetAt(6), pointArray->GetAt(5));
        edge07 = new Edge(pointArray->GetAt(5), pointArray->GetAt(4));
        edge08 = new Edge(pointArray->GetAt(4), pointArray->GetAt(7));
        edge09 = new Edge(pointArray->GetAt(0), pointArray->GetAt(4));
        edge10 = new Edge(pointArray->GetAt(1), pointArray->GetAt(5));
        edge11 = new Edge(pointArray->GetAt(2), pointArray->GetAt(6));
        edge12 = new Edge(pointArray->GetAt(3), pointArray->GetAt(7));

        this->AddEdge(edge01);
        this->AddEdge(edge02);
        this->AddEdge(edge03);
        this->AddEdge(edge04);
        this->AddEdge(edge05);
        this->AddEdge(edge06);
        this->AddEdge(edge07);
        this->AddEdge(edge08);
        this->AddEdge(edge09);
        this->AddEdge(edge10);
        this->AddEdge(edge11);
        this->AddEdge(edge12);
    }
    else
    {
        edge01 = this->GetAt(0);
        edge02 = this->GetAt(1);
        edge03 = this->GetAt(2);
        edge04 = this->GetAt(3);
        edge05 = this->GetAt(4);
        edge06 = this->GetAt(5);
        edge07 = this->GetAt(6);
        edge08 = this->GetAt(7);
        edge09 = this->GetAt(8);
        edge10 = this->GetAt(9);
        edge11 = this->GetAt(10);
        edge12 = this->GetAt(11);
    }

    edge01->Nextccw  = edge02;
    edge01->Prevccw  = edge04;

    edge02->Nextccw  = edge03;
    edge02->Prevccw  = edge01;

    edge03->Nextccw  = edge04;
    edge03->Prevccw  = edge02;

    edge04->Nextccw  = edge01;
    edge04->Prevccw  = edge03;

    edge05->Nextccw  = edge06;
    edge05->Prevccw  = edge08;

    edge06->Nextccw  = edge07;
    edge06->Prevccw  = edge05;

    edge07->Nextccw  = edge08;
    edge07->Prevccw  = edge06;

    edge08->Nextccw  = edge05;
    edge08->Prevccw  = edge07;

    edge09->Nextccw  = edge07;
    edge09->Prevccw  = edge01;

    edge10->Nextccw  = edge06;
    edge10->Prevccw  = edge02;

    edge11->Nextccw  = edge05;
    edge11->Prevccw  = edge03;

    edge12->Nextccw  = edge08;
    edge12->Prevccw  = edge04;

    return;
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

Face * ArrayFace :: GetAt( int pos) const{
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


// "9 : Link segment to faces (student work here)"
void ArrayFace::linkSegmentsToFacesCubic(ArrayEdge* edgeArray)
{
    if(edgeArray->n < 12)
    {
        cerr<<"In Edge Array, there is not enough edge to represent cube."<<endl;
        return;
    }

    Face *F1;
    Face *F2;
    Face *F3;
    Face *F4;
    Face *F5;
    Face *F6;

    if(this->n < 6)
    {
        F1 = new Face;
        F2 = new Face;
        F3 = new Face;
        F4 = new Face;
        F5 = new Face;
        F6 = new Face;

        this->AddFace(F1);
        this->AddFace(F2);
        this->AddFace(F3);
        this->AddFace(F4);
        this->AddFace(F5);
        this->AddFace(F6);
    }
    else
    {
        F1 = this->GetAt(0);
        F2 = this->GetAt(1);
        F3 = this->GetAt(2);
        F4 = this->GetAt(3);
        F5 = this->GetAt(4);
        F6 = this->GetAt(5);
    }

    Edge* edge01 = edgeArray->GetAt(0);
    Edge* edge02 = edgeArray->GetAt(1);
    Edge* edge03 = edgeArray->GetAt(2);
    Edge* edge04 = edgeArray->GetAt(3);
    Edge* edge05 = edgeArray->GetAt(4);
    Edge* edge06 = edgeArray->GetAt(5);
    Edge* edge07 = edgeArray->GetAt(6);
    Edge* edge08 = edgeArray->GetAt(7);
    Edge* edge09 = edgeArray->GetAt(8);
    Edge* edge10 = edgeArray->GetAt(9);
    Edge* edge11 = edgeArray->GetAt(10);
    Edge* edge12 = edgeArray->GetAt(11);

    edge01->Fccw = F1;
    edge01->Fcw =  F3;

    edge02->Fccw = F1;
    edge02->Fcw =  F4;

    edge03->Fccw = F1;
    edge03->Fcw =  F5;

    edge04->Fccw = F1;
    edge04->Fcw =  F6;

    edge05->Fccw = F2;
    edge05->Fcw =  F5;

    edge06->Fccw = F2;
    edge06->Fcw =  F4;

    edge07->Fccw = F2;
    edge07->Fcw =  F3;

    edge08->Fccw = F2;
    edge08->Fcw =  F6;

    edge09->Fccw = F3;
    edge09->Fcw =  F6;

    edge10->Fccw = F4;
    edge10->Fcw =  F3;

    edge11->Fccw = F5;
    edge11->Fcw =  F4;

    edge12->Fccw = F6;
    edge12->Fcw =  F5;

    F1->Start = edge01;
    F2->Start = edge05;
    F3->Start = edge09;
    F4->Start = edge10;
    F5->Start = edge11;
    F6->Start = edge12;

    return;
}

// 13 : Check if face is closed (student work here)"
bool ArrayFace::isCubicFaceClosed() const
{
    bool isCubicFaceClosed = true;

    for(int i = 0; i < this->n; i++)
    {
        Face* face = this->GetAt(i);

        bool traversal = this->isCubicFaceClosedTraversal(face, 4);

        if(!traversal)
        {
            isCubicFaceClosed = false;
            break;
        }
    }

    return isCubicFaceClosed;
}

bool ArrayFace::isCubicFaceClosedTraversal(Face* face, int numberOfEdges) const
{
    Edge* temp = face->Start;

    for(int i = 0; i < numberOfEdges; i++)
    {
        if(temp->Fccw == face)
            temp = temp->Nextccw;
        else
            temp = temp->Prevcw;
    }

    if(temp == face->Start)
        return true;
    return false;
}

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
