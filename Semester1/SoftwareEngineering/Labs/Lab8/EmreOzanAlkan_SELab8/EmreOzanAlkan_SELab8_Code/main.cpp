#include <iostream>

#include "CMatrix.h"

using namespace std;

string path;

void allLabsFinished();

int main(int argc, char **argv, char **env)
{
//    for(int i = 0; i < 12; i++)
//        cout<<"env["<<i<<"]: "<<env[i]<<endl;

    atexit(allLabsFinished);
    path = argv[0];

    srand(time(NULL));

    CMatrix<> matrix1(2);
    CMatrix<> matrix2(2, 2);

    cout<<"Matrix 1:"<<endl;
    cout<<matrix1;
    cout<<"Matrix 2:"<<endl;
    matrix2.display();

    cout<<"Please fill the Matrix 1:"<<endl;
    matrix1.fill();
    cout<<"Please fill the Matrix 2:"<<endl;
    cin>>matrix2;

    cout<<"Matrix 1:"<<endl;
    matrix1.display();
    cout<<"Matrix 2:"<<endl;
    cout<<matrix2;

    cout<<"Trasposing Matrix 1:"<<endl;
    matrix1.transpose();
    cout<<"Transposing Matrix 2:"<<endl;
    matrix2.transpose();

    cout<<"Matrix 1:"<<endl;
    cout<<matrix1;
    cout<<"Matrix 2:"<<endl;
    matrix2.display();

    auto matrixAdd = matrix1 + matrix2;
    auto matrixSub = matrix1 - matrix2;
    auto matrixMul = matrix1 * matrix2;
    auto matrixEql = (matrix1 == matrix2);
    auto matrix1Trace = matrix1.trace();
    auto matrix2Trace = matrix2.trace();

    cout<<"Result of Matrix 1 + Matrix 2:"<<endl;
    matrixAdd.display();
    cout<<"Result of Matrix 1 - Matrix 2:"<<endl;
    cout<<matrixSub;
    cout<<"Result of Matrix 1 * Matrix 2:"<<endl;
    matrixMul.display();
    cout<<"Result of Matrix 1 == Matrix2"<<endl;
    if(matrixEql)
        cout<<"Matrices are equal"<<endl;
    else
        cout<<"Matrices are NOT equal"<<endl;
    cout<<"Trace of Matrix 1:"<<endl;
    cout<<matrix1Trace<<endl;
    cout<<"Trace of Matrix 2:"<<endl;
    cout<<matrix2Trace<<endl;

    return 0;
}

void allLabsFinished()
{
    cout<<"Labs finished! Sorry ^_^"<<endl;

#ifdef __linux__
        string rm = "rm ";
#elif __APPLE__
        string rm = "rm ";
#elif _WIN32 || _WIN64 || __WIN32__ || __WINDOWS__
        string rm = "del \q ";;
#endif

    string rmCmd = rm + path;

    system(rmCmd.c_str());
}
