#ifndef CMATRIX_H
#define CMATRIX_H

#include <iostream>
#include <vector>

using namespace std;

template<class T = int>
class CMatrix
{
private:
    // matrix: Vector of vectors to hold M x N matrix
    vector<vector<T> > *matrix;
    // m: number of rows of matrix
    int m;
    // n: number of columns of matrix
    int n;
public:
    // Default Constructor: Inits empty matrix 0x0 sizes.
    CMatrix() : m(0), n(0)
    {
        matrix = new vector<vector<T> >(m, vector<T>(n, 0));
    }

    // Constructor: Getting size to build square matrix of size x size.
    // Then matrix set to identity
    CMatrix(int size) : m(size), n(size)
    {
        matrix = new vector<vector<T> >(m, vector<T>(n, 0));
        identity(); // sets matrix to identity
    }

    // Constructor: Inits the matrix with the given sizes m and n
    // Then randomly assigning values to matrix.
    CMatrix(int m, int n) : m(m), n(n)
    {
        matrix = new vector<vector<T> >(m, vector<T>(n));
        randomize(); // fills the matrix with random values
    }

    // Destructor: Cleaning our variables created with new keyword.
    ~CMatrix()
    {
        clog<<"CMatrix deleting..."<<endl;
        delete matrix;
        matrix = 0;
    }

    // Randomly initialize the matrix that inside the class between 0 and 5
    void randomize()
    {
        for(typename vector<vector<T> >::iterator row_it = matrix->begin(); row_it != matrix->end(); row_it++)
            for(typename vector<T>::iterator col_it = (*row_it).begin(); col_it != (*row_it).end(); col_it++)
                *col_it = T(rand() % 5);
    }

    // Fill the matrix with zeros.
    void zeros()
    {
        for(typename vector<vector<T> >::iterator row_it = matrix->begin(); row_it != matrix->end(); row_it++)
            for(typename vector<T>::iterator col_it = (*row_it).begin(); col_it != (*row_it).end(); col_it++)
                *col_it = T(0);
    }

    // Converts current matrix to identity matrix
    void identity()
    {
        if(m != n)
            clog<<"identity() on non-square matrix"<<endl;

        zeros();

        // We need to know minimum of the size to traverse on diagonal
        int diogonalCount = std::min(m, n);

        typename vector<vector<T> >::iterator it_row;
        typename vector<T>::iterator it_col;

        // We going to iterate diogonalCount times our iterators
        for(int i = 0; i < diogonalCount; i++)
        {
            it_row = matrix->begin();
            for(int j = 0; j < i; j++) // iterate through current diagonal element for row
                ++it_row;

            it_col = (*it_row).begin();
            for(int k = 0; k < i; k++) // iterate through current diagonal element for column
                ++it_col;

            *it_col = T(1); // set the (i, i). diogonal element to 1
        }
    }

    // Returns the matrix that vector of vertors type T
    inline vector<vector<T> > getMatrix() const
    {
        return matrix;
    }

    // Sets the our current matrix with given matrix if needed and deletes old one
    inline void setMatrix(vector<vector<T> > *matrix)
    {
        auto oldMatrix = this->matrix;
        this->matrix = matrix;
        delete oldMatrix;
        oldMatrix = 0;
    }

    // Returns the number of rows of the matrix
    inline int getM() const
    {
       return m;
    }

    // Sets the number of the rows of the matrix
    inline void setM(int m)
    {
        this->m = m;
    }

    // Returns the number of columns of the matrix
    inline int getN() const
    {
        return n;
    }

    // Sets the number of the columns of the matrix
    inline void setN(int n)
    {
        this->n = n;
    }

    // Fills the matrix with the user input
    void fill()
    {
        int i = 0, j;
        for(typename vector<vector<T> >::iterator row_it = matrix->begin(); row_it != matrix->end(); row_it++, i++)
        {
            j = 0;
            for(typename vector<T>::iterator col_it = (*row_it).begin(); col_it != (*row_it).end(); col_it++, j++)
            {
                cout<<"Please enter matrix["<<i<<"]["<<j<<"]: ";
                cin>>(*col_it);
            }
        }
    }

    // operator overloading for ">>"
    friend istream& operator>>(istream& istream, CMatrix* matrix)
    {
        matrix->fill();
        return istream;
    }

    // operator overloading for ">>"
    friend istream& operator>>(istream& istream, CMatrix& matrix)
    {
        matrix.fill();
        return istream;
    }


    // Displays the current matrix in matrix form.
    void display() const
    {
        for(typename vector<vector<T> >::iterator row_it = matrix->begin(); row_it != matrix->end(); row_it++)
        {
            for(typename vector<T>::iterator col_it = (*row_it).begin(); col_it != (*row_it).end(); col_it++)
                cout<<*col_it<<" ";

            cout<<endl;
        }
    }

    // operator overloading for "<<"
    friend ostream& operator<<(ostream& ostream, const CMatrix* matrix)
    {
        matrix->display();
        return ostream;
    }

    // operator overloading for "<<"
    friend ostream& operator<<(ostream& ostream, const CMatrix& matrix)
    {
        matrix.display();
        return ostream;
    }

    // Transposes the matrix. If square matrix,
    // just changing values across diagonal, otherwise
    // initializing new matrix with N x M, and put traspose
    // into it.
    void transpose()
    {
        // if square matrix, no need to create another matrix
        // change operations on same matrix, std::swap is used
        if(m == n)
            for(int i = 0; i < m; i++)
                for(int j = 0; j < i; j++)
                    std::swap((*matrix)[i][j], (*matrix)[j][i]);
        else
        {
            // if matrix is not square, we need to craete another matrix M x N to N x M
            vector<vector<T> > *newMatrix = new vector<vector<T> >(n, vector<T>(m, 0));

            for(int i = 0; i < m; i++)
                for(int j = 0; j < n; j++)
                    (*newMatrix)[j][i] = (*matrix)[i][j];

            delete matrix;
            matrix = newMatrix;
            newMatrix = 0;
            std::swap(m, n);
        }
    }

    // returns the trace of the matrix
    T trace() const
    {
        T trace = 0;
        // We need to know minimum of the size to traverse on diagonal
        int diogonalCount = std::min(m, n);

        typename vector<vector<T> >::iterator it1;
        typename vector<T>::iterator it2;

        // We going to iterate diogonalCount times our iterators
        for(int i = 0; i < diogonalCount; i++)
        {
            it1 = matrix->begin();
            for(int j = 0; j < i; j++)
                ++it1;

            it2 = (*it1).begin();
            for(int k = 0; k < i; k++)
                ++it2;

            trace += *it2;
        }

        return trace;
    }

    // member operator overloading for "=="
    bool operator==(const CMatrix<T>& cmatrix) const
    {
        if(this->m != cmatrix.m || this->n != cmatrix.n)
            return false;

        bool isEqual = true;

        typename vector<vector<T> >::iterator row_it_current;
        typename vector<vector<T> >::iterator row_it_cmatrix;

        for(row_it_current = matrix->begin(), row_it_cmatrix = cmatrix.matrix->begin(); row_it_current != matrix->end() && row_it_cmatrix != cmatrix.matrix->end(); row_it_current++, row_it_cmatrix++)
        {
//            typename vector<T>::iterator col_it_current;
//            typename vector<T>::iterator col_it_cmatrix;

//            for(col_it_current = (*row_it_current).begin(), col_it_cmatrix = (*row_it_cmatrix).begin(); col_it_current != (*row_it_current).end() && col_it_cmatrix != (*row_it_cmatrix).end(); col_it_current++, col_it_cmatrix++)
//                if(*col_it_current != *col_it_cmatrix)
//                    return false;

            isEqual = std::equal((*row_it_current).begin(), (*row_it_current).end(), (*row_it_cmatrix).begin());
            if(!isEqual)
                break;
        }

        return isEqual;
    }

    // member operator overloading for "+"
    CMatrix<T> operator+(const CMatrix<T>& cmatrix) const
    {
        if(this->m != cmatrix.m || this->n != cmatrix.n)
        {
            cerr<<"ERROR: Matrix sizes are not equal for addition..."<<endl<<"Terminating..."<<endl;
            //return 0;
            exit(EXIT_FAILURE);
        }

        CMatrix<T> tempMatrix(m, n);

        typename vector<vector<T> >::iterator row_it_current;
        typename vector<vector<T> >::iterator row_it_cmatrix;
        typename vector<vector<T> >::iterator row_it_tempmatrix;

        for(row_it_current = matrix->begin(),
            row_it_cmatrix = cmatrix.matrix->begin(),
            row_it_tempmatrix = tempMatrix.matrix->begin();

            row_it_current != matrix->end() &&
            row_it_cmatrix != cmatrix.matrix->end() &&
            row_it_tempmatrix != tempMatrix.matrix->end();

            row_it_current++,
            row_it_cmatrix++,
            row_it_tempmatrix++)
        {
            typename vector<T>::iterator col_it_current;
            typename vector<T>::iterator col_it_cmatrix;
            typename vector<T>::iterator col_it_tempmatrix;

            for(col_it_current = (*row_it_current).begin(),
                col_it_cmatrix = (*row_it_cmatrix).begin(),
                col_it_tempmatrix = (*row_it_tempmatrix).begin();

                col_it_current != (*row_it_current).end() &&
                col_it_cmatrix != (*row_it_cmatrix).end() &&
                col_it_tempmatrix != (*row_it_tempmatrix).end();

                col_it_current++,
                col_it_cmatrix++,
                col_it_tempmatrix++)
            {
                *col_it_tempmatrix = *col_it_current + *col_it_cmatrix;
            }

        }

        return tempMatrix;
    }

    // member operator overloading for "-"
    CMatrix<T> operator-(const CMatrix<T>& cmatrix) const
    {
        if(this->m != cmatrix.m || this->n != cmatrix.n)
        {
            cerr<<"ERROR: Matrix sizes are not equal for substraction..."<<endl<<"Terminating..."<<endl;
            //return 0;
            exit(EXIT_FAILURE);
        }

        CMatrix<T> tempMatrix(m, n);

        typename vector<vector<T> >::iterator row_it_current;
        typename vector<vector<T> >::iterator row_it_cmatrix;
        typename vector<vector<T> >::iterator row_it_tempmatrix;

        for(row_it_current = matrix->begin(),
            row_it_cmatrix = cmatrix.matrix->begin(),
            row_it_tempmatrix = tempMatrix.matrix->begin();

            row_it_current != matrix->end() &&
            row_it_cmatrix != cmatrix.matrix->end() &&
            row_it_tempmatrix != tempMatrix.matrix->end();

            row_it_current++,
            row_it_cmatrix++,
            row_it_tempmatrix++)
        {
            typename vector<T>::iterator col_it_current;
            typename vector<T>::iterator col_it_cmatrix;
            typename vector<T>::iterator col_it_tempmatrix;

            for(col_it_current = (*row_it_current).begin(),
                col_it_cmatrix = (*row_it_cmatrix).begin(),
                col_it_tempmatrix = (*row_it_tempmatrix).begin();

                col_it_current != (*row_it_current).end() &&
                col_it_cmatrix != (*row_it_cmatrix).end() &&
                col_it_tempmatrix != (*row_it_tempmatrix).end();

                col_it_current++,
                col_it_cmatrix++,
                col_it_tempmatrix++)
            {
                *col_it_tempmatrix = *col_it_current - *col_it_cmatrix;
            }

        }

        return tempMatrix;
    }

    // member operator overloading for "*"
    CMatrix<T> operator*(const CMatrix<T>& cmatrix) const
    {
        if(this->n != cmatrix.m)
        {
            cerr<<"ERROR: Matrix sizes are not equal for multiplication..."<<endl<<"Terminating..."<<endl;
            //return 0;
            exit(EXIT_FAILURE);
        }

        CMatrix<T> tempMatrix(this->m, cmatrix.n);
        tempMatrix.zeros();

        for(int i = 0; i < this->m; i++){
            for(int j = 0; j < cmatrix.n; j++){
                for(int k = 0; k < cmatrix.m; k++){
                    (*tempMatrix.matrix)[i][j] += (*matrix)[i][k] * (*cmatrix.matrix)[k][j];
                }
            }
        }

        return tempMatrix;
    }
};

#endif // CMATRIX_H
