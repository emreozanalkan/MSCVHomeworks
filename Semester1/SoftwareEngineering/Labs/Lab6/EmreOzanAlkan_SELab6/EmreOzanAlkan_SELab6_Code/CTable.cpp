#include "Ctable.h"
#include <iostream>
#include <cstdlib>

using namespace std;

// Default constructor
CTable::CTable()
{
    this->builder();
}

// Parameterized constructor
CTable::CTable(unsigned int numberOfElements)
{
    this->builder(numberOfElements);
}

// Initing the internal table with one element
// and randamly assign vlaue
void CTable::builder()
{
    this->numberOfElements = 1;//(rand() % 20) + 10;
    this->table = new int[this->numberOfElements];

    for(unsigned int i = 0; i < this->numberOfElements; i++)
    {
        this->table[i] = rand() % 10;
    }
}

// Initing the internal table with given size by user
// and initing its values between 0 and 9
void CTable::builder(unsigned int numberOfElements)
{
    this->numberOfElements = numberOfElements;
    this->table = new int[numberOfElements];

    for(unsigned int i = 0; i < this->numberOfElements; i++)
    {
        this->table[i] = rand() % 10;
    }
}

// Displaying the values of the table
void CTable::display() const
{
    cout<<"Table Elements:"<<endl;

    for(unsigned int i = 0; i < this->numberOfElements; i++)
    {
        cout<<this->table[i]<<" ";
    }

    cout<<endl;
}

// Inserting the element into given position
void CTable::insert(int element, unsigned int position)
{
    if(position > this->numberOfElements)
        std::cerr<<"insert(int, int): Index out of range at index:"<<position<<" size was:"<<this->numberOfElements<<std::endl;

    unsigned int newSize = this->numberOfElements + 1;

    int* newTable = new int[newSize];

    for(unsigned int i = 0; i < newSize; i++)
    {
        if(i > position)
            newTable[i] = table[i - 1];
        else
            newTable[i] = table[i];
    }

    newTable[position] = element;

    delete [] table;
    table = 0;

    table = newTable;
    this->numberOfElements = newSize;
}

// Returns the value at given index
int CTable::read(unsigned int index) const
{
    return this->table[index];
}

// Swaps the values of the table with given indexes
void CTable::swap(unsigned int firstIndex, unsigned int secondIndex)
{
    int temp = 0;
    temp = this->table[firstIndex];
    this->table[firstIndex] = this->table[secondIndex];
    this->table[secondIndex] = temp;
}

// Shuffles the table to use after sorts
void CTable::shuffleTable()
{
    //std::random_shuffle(std::begin(this->table), std::end(this->table));
    std::random_shuffle(&this->table[0], &this->table[this->numberOfElements]);
}

// http://en.wikipedia.org/wiki/Bubble_sort
// Worst case performance   O(n^2)
// Best case performance    O(n)
// Average case performance O(n^2)
void CTable::bubbleSort()
{
    for(unsigned int i = 0; i < this->numberOfElements; i++)
    {
        for(unsigned int j = i + 1; j < this->numberOfElements; j++)
        {
            if(this->table[i] > this->table[j])
                this->swap(i, j);
        }
    }
}

// http://en.wikipedia.org/wiki/Quicksort
// Worst case performance	O(n2) (extremely rare)
// Best case performance	O(n log n)
// Average case performance	O(n log n)
// Worst case space complexity	O(n) auxiliary (naive)
// O(log n) auxiliary (Sedgewick 1978)
void CTable::quickSort()
{
    this->quickSortRecursive(this->table, 0, this->numberOfElements - 1);

    return;
}

// http://en.wikipedia.org/wiki/Quicksort
// Worst case performance	O(n2) (extremely rare)
// Best case performance	O(n log n)
// Average case performance	O(n log n)
// Worst case space complexity	O(n) auxiliary (naive)
// O(log n) auxiliary (Sedgewick 1978)
//function quicksort(array, left, right)
//    // If the list has 2 or more items
//    if left < right
//        // See "#Choice of pivot" section below for possible choices
//        choose any pivotIndex such that left ≤ pivotIndex ≤ right
//        // Get lists of bigger and smaller items and final position of pivot
//        pivotNewIndex := partition(array, left, right, pivotIndex)
//        // Recursively sort elements smaller than the pivot
//        quicksort(array, left, pivotNewIndex - 1)
//        // Recursively sort elements at least as big as the pivot
//        quicksort(array, pivotNewIndex + 1, right)
void CTable::quickSortRecursive(int* array, unsigned int left, unsigned int right)
{
    if(left < right)
    {
        int pivotNewIndex = this->quickSortRecursivePartition(array, left, right);

        if(pivotNewIndex != 0)
            this->quickSortRecursive(array, left, pivotNewIndex - 1);

        this->quickSortRecursive(array, pivotNewIndex + 1, right);
    }

    return;
}

// http://en.wikipedia.org/wiki/Quicksort
// Worst case performance	O(n2) (extremely rare)
// Best case performance	O(n log n)
// Average case performance	O(n log n)
// Worst case space complexity	O(n) auxiliary (naive)
// O(log n) auxiliary (Sedgewick 1978)
//// left is the index of the leftmost element of the subarray
//// right is the index of the rightmost element of the subarray (inclusive)
//// number of elements in subarray = right-left+1
//function partition(array, left, right, pivotIndex)
//   pivotValue := array[pivotIndex]
//   swap array[pivotIndex] and array[right]  // Move pivot to end
//   storeIndex := left
//   for i from left to right - 1  // left ≤ i < right
//       if array[i] <= pivotValue
//           swap array[i] and array[storeIndex]
//           storeIndex := storeIndex + 1  // only increment storeIndex if swapped
//   swap array[storeIndex] and array[right]  // Move pivot to its final place
//   return storeIndex
int CTable::quickSortRecursivePartition(int* array, unsigned int left, unsigned int right)
{
    int pivotValue = array[right];

    unsigned int storeIndex = left;

    for(unsigned int i = left; i < right; i++)
    {
        if(array[i] <= pivotValue)
        {
            this->swap(i, storeIndex);
            storeIndex++;
        }
    }

    this->swap(storeIndex, right);

    return storeIndex;
}

// http://en.wikipedia.org/wiki/Selection_sort
// Worst case performance	О(n2)
// Best case performance	О(n2)
// Average case performance	О(n2)
// Worst case space complexity	О(n) total, O(1) auxiliary
void CTable::selectionSort()
{
    unsigned int minimumElementIndex = 0;

    for(unsigned int i = 0; i < this->numberOfElements; i++)
    {
        minimumElementIndex = i;

        for(unsigned int j = i + 1; j < this->numberOfElements; j++)
            if(this->table[j] < this->table[minimumElementIndex])
                minimumElementIndex = j;

        this->swap(i, minimumElementIndex);
    }
}

// http://en.wikipedia.org/wiki/Insertion_sort
// Worst case performance	О(n2) comparisons, swaps
// Best case performance	O(n) comparisons, O(1) swaps
// Average case performance	О(n2) comparisons, swaps
// Worst case space complexity	О(n) total, O(1) auxiliary
//// The values in A[i] are checked in-order, starting at the second one
//for i ← 1 to i ← length(A)
//  {
//    // at the start of the iteration, A[0..i-1] are in sorted order
//    // this iteration will insert A[i] into that sorted order
//    // save A[i], the value that will be inserted into the array on this iteration
//    valueToInsert ← A[i]
//    // now mark position i as the hole; A[i]=A[holePos] is now empty
//    holePos ← i
//    // keep moving the hole down until the valueToInsert is larger than
//    // what's just below the hole or the hole has reached the beginning of the array
//    while holePos > 0 and valueToInsert < A[holePos - 1]
//      { //value to insert doesn't belong where the hole currently is, so shift
//        A[holePos] ← A[holePos - 1] //shift the larger value up
//        holePos ← holePos - 1       //move the hole position down
//      }
//    // hole is in the right position, so put valueToInsert into the hole
//    A[holePos] ← valueToInsert
//    // A[0..i] are now in sorted order
//  }
void CTable::insertionSort()
{
    int valueToInsert = 0;
    unsigned int holePos = 0;

    for(unsigned int i = 1; i < this->numberOfElements; i++)
    {
        valueToInsert = this->table[i];
        holePos = i;

        while(holePos > 0 && valueToInsert < this->table[holePos -1])
        {
            this->table[holePos] = this->table[holePos - 1];
            holePos--;
        }

        this->table[holePos] = valueToInsert;
    }
}
