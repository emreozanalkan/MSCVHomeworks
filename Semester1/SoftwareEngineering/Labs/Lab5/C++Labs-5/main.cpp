#include <iostream>
#include "WingedEdge.h"
#include "Exercice.h"

using namespace std;



int main()
{
    ArrayPoint ArrayP;
    ArrayEdge  ArrayE;
    ArrayFace  ArrayF;

    int answer = 0;
    int end = -1;
    while(answer != end)
    {
        system("cls"); // kind of bad, but is enough to clear the console screen

        cout << "1 : Create point(s)" << endl;
        cout << "2 : Get Point info using index"<<endl;
        cout << "3 : Get Array Points info"<<endl<<endl;

        cout << "4 : Create segment(s)" << endl;
        cout << "5 : Get Segment info"<<endl;
        cout << "6 : Get Array Segments info"<<endl<<endl;

        cout << "7 : Link segment clockwise - prev and next - (student work here)"<<endl;
        cout << "8 : Link segment counterclockwise - prev and next - (student work here)"<<endl;
        cout << "9 : Link segment to faces (student work here)"<<endl<<endl;

        cout << "10 : Create face(s) by setting a start Edge" << endl;
        cout << "11 : Get Face info"<<endl;
        cout << "12 : Get Array Faces info"<<endl;
        cout << "13 : Check if face is closed (student work here)"<<endl<<endl;

        cout << "14 : automatic point generation"<<endl;
        cout << "15 : automatic edge generation"<<endl;
        cout << "16 : automatic first edge init for faces"<<endl;





        cout << endl<< end <<" : exit"<<endl<<endl;

        cout<<"entry: ";cin >>answer;
        system("cls"); // kind of bad, but is enough to clear the console screen

        switch (answer) {
            case 1 : {
                ArrayP.AddPoint();
            }break;

            case 2 : {

                cout <<"Enter point index:";
                int pindex; cin >> pindex;
                Point * P = ArrayP.GetAt(pindex);
                if (P) P->Info();
                else cout<<"Point not found"<<endl;

            }break;

            case 3 : {
                ArrayP.Info();
            }break;

            case 4 : {
                cout <<"Edge creation"<<endl;
                cout <<"Enter indexes of extremities"<<endl;
                int a, b;
                cin>> a>>b;

                Point*P1 = ArrayP.GetAt(a);
                Point*P2 = ArrayP.GetAt(b);

                if(P1 && P2) {
                    Edge * E = new Edge(P1,P2);
                    ArrayE.AddEdge(E);
                    }
                else{
                    cout <<"indexes invalid or points not created"<<endl;
                    }
            }break;

            case 5 : {

                cout <<"Enter Edge index:";
                int eindex; cin >> eindex;
                Edge * E = ArrayE.GetAt(eindex);
                if (E) E->Info();
                else cout<<"Edge not found"<<endl;

            }break;

            case 6 : {
                ArrayE.Info();
            }break;

//-------------------------
//student work here
//-------------------------

            case 7 : {
                //add your code here


                }break;

//-------------------------
//student work here
//-------------------------

            case 8 : {
                //add your code here
                }break;

//-------------------------
//student work here
//-------------------------

            case 9 : {
                //add your code here
                }break;

            case 10 : {

                Face*F = new Face;
                cout <<"enter index of starting edge for the face"<<endl;
                int eindex;
                cin >>eindex;
                F->Start = ArrayE.GetAt(eindex);
                F->Start->Fccw = F;
                ArrayF.AddFace(F);

            }break;

            case 11 : {

                cout <<"Enter Face index:";
                int findex; cin >> findex;
                Face * F = ArrayF.GetAt(findex);
                if (F) F->Info();
                else cout<<"Edge not found"<<endl;

            }break;

            case 12 : {
                ArrayF.Info();
                }break;

            case 13 : {
                //student work here
                }break;

            case 14 : {

                ArrayP.AddPoint(new Point( 0,0,0) );
                ArrayP.AddPoint(new Point( 0,1,0) );
                ArrayP.AddPoint(new Point( 1,1,0) );
                ArrayP.AddPoint(new Point( 1,0,0) );
                ArrayP.AddPoint(new Point( 0,0,-1) );
                ArrayP.AddPoint(new Point( 0,1,-1) );
                ArrayP.AddPoint(new Point( 1,1,-1) );
                ArrayP.AddPoint(new Point( 1,0,-1) );

            }break;

            case 15 :{
                //edges of the front face
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(0),ArrayP.GetAt(1))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(1),ArrayP.GetAt(2))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(2),ArrayP.GetAt(3))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(3),ArrayP.GetAt(4))) ;

                //edges of the back face
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(7),ArrayP.GetAt(6))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(6),ArrayP.GetAt(5))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(5),ArrayP.GetAt(4))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(4),ArrayP.GetAt(7))) ;

                //edges to "link" front face and back face
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(0),ArrayP.GetAt(4))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(1),ArrayP.GetAt(5))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(2),ArrayP.GetAt(6))) ;
                ArrayE.AddEdge(new Edge(ArrayP.GetAt(3),ArrayP.GetAt(7))) ;

            }break;

            case 16 :{

                Face *F1 = new Face;
                F1->Start = ArrayE.GetAt(0);
                F1->Start->Fccw = F1;
                ArrayF.AddFace(F1);

                Face *F2 = new Face;
                F2->Start = ArrayE.GetAt(4);
                F2->Start->Fccw = F2;
                ArrayF.AddFace(F2);

                Face *F3 = new Face;
                F3->Start = ArrayE.GetAt(8);
                F3->Start->Fccw = F3;
                ArrayF.AddFace(F3);

                Face *F4 = new Face;
                F4->Start = ArrayE.GetAt(9);
                F4->Start->Fccw = F4;
                ArrayF.AddFace(F4);

                Face *F5 = new Face;
                F5->Start = ArrayE.GetAt(10);
                F5->Start->Fccw = F5;
                ArrayF.AddFace(F5);

                Face *F6 = new Face;
                F6->Start = ArrayE.GetAt(11);
                F6->Start->Fccw = F6;
                ArrayF.AddFace(F6);
            }break;

        }//end switch

        system("pause"); //kind of bad too, but sufficient to pause until key pressed

    }//end while

    return 0;
}
