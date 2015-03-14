#include <iostream>

#include "Node.h"

using namespace std;

int main(void)
{
    Node* rootNode = new Node();

    char* word = 0;
    int wordCount = 0;

    cout<<"How many words do you want to add to the dictionary?"<<endl;
    cin>>wordCount;

    for(int i = 0; i < wordCount; i++)
    {
        word = new char[256];
        cout<<"enter word to add to the dictionary: ";
        cin>>word;
        rootNode->insertData(word);
    }

    cout<<"----PREORDER DISPLAY------------------"<<endl;
    rootNode->printPreOrder();

    cout<<"----POSTORDER DISPLAY-----------------"<<endl;
    rootNode->printPostOrder();

    cout<<"----IN ORDER DISPLAY------------------"<<endl;
    rootNode->printInOrder();


    delete rootNode;
    rootNode = 0;
    word = 0;

    return 0;
}
