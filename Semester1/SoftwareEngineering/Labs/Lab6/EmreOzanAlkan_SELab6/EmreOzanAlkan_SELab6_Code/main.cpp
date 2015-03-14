#include <iostream>
#include <cstdlib>
#include <ctime>

#include "Ctable.h"

using namespace std;

int main(int argc, char *argv[])
{
    CTable myTable;

    myTable.display();

    cout<<endl;

    cout<<"Inserting elements..."<<endl<<endl;
    myTable.insert(0, 0);
    myTable.insert(0, 0);
    myTable.insert(3, 0);
    myTable.insert(6, 0);
    myTable.insert(1, 0);
    myTable.insert(8, 0);
    myTable.insert(4, 0);
    myTable.insert(4, 0);
    myTable.insert(5, 0);
    myTable.insert(2, 0);
    myTable.display();

    cout<<endl;

    myTable.display();
    cout<<"After bubble sort: "<<endl;
    myTable.bubbleSort();
    myTable.display();

    cout<<endl<<"Suffling..."<<endl<<endl;
    myTable.shuffleTable();

    myTable.display();
    cout<<"After quick sort: "<<endl;
    myTable.quickSort();
    myTable.display();

    cout<<endl<<"Suffling..."<<endl<<endl;
    myTable.shuffleTable();

    myTable.display();
    cout<<"After selection sort: "<<endl;
    myTable.selectionSort();
    myTable.display();

    cout<<endl<<"Suffling..."<<endl<<endl;
    myTable.shuffleTable();

    myTable.display();
    cout<<"After insertion sort: "<<endl;
    myTable.insertionSort();
    myTable.display();

    return 0;
}
