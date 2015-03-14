#ifndef CTABLE_H
#define CTABLE_H

class CTable
{
private:
    int* table;
    unsigned int numberOfElements;
protected:
    // Recursive Quick Sort Implementation
    void quickSortRecursive(int*, unsigned int, unsigned int);
    // Recursive Quick Sort Partititon Implementation
    int quickSortRecursivePartition(int*, unsigned int, unsigned int);
public:
    CTable();
    CTable(unsigned int);

    // Randomly inits the internal table between 10-20 elements
    void builder();
    // Randomly inits the internal table with given size
    void builder(unsigned int);

    // Displays the internal table
    void display() const;

    // Inserts element to given index
    // inser(element, index)
    void insert(int, unsigned int);

    // Returns the element at index
    int read(unsigned int) const;

    // Swapping the two values in table given index numbers
    void swap(unsigned int, unsigned int);

    // Shuffling table after insertions
    void shuffleTable();

    // Sorting Algorithms' Interfaces
    void bubbleSort();
    void quickSort();
    void selectionSort();
    void insertionSort();
};

#endif // CTABLE_H
