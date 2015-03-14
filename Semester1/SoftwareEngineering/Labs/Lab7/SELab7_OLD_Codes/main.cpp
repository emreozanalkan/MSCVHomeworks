#include <iostream>

#include "TreeNode.h"

using namespace std;

void addDataToTree(TreeNode*, char*);
void printPreOrder(TreeNode*);
void printInOrder(TreeNode*);
void printPostOrder(TreeNode*);

TreeNode *root;

int main(int argc, char *argv[])
{
    char *word = 0;
    int wordCount = 0;

    cout<<"How many words do you want to add to the dictionary?"<<endl;
    cin>>wordCount;

    for(int i = 0; i < wordCount; i++)
    {
        word = new char[256];
        cout<<"enter word to add to the dictionary: ";
        cin>>word;
        if(!root)
            root = new TreeNode(word);
        else
            addDataToTree(root, word);
    }


    cout<<"----PREORDER DISPLAY------------------"<<endl;
    printPreOrder(root);
    cout<<"----POSTORDER DISPLAY-----------------"<<endl;
    printPostOrder(root);
    cout<<"----IN ORDER DISPLAY------------------"<<endl;
    printInOrder(root);

    return 0;
}

void addDataToTree(TreeNode* treeNode, char* data)
{
//    cout<<"coming data: "<<data<<endl;
//    if(treeNode != 0)
//        if(treeNode->getData() == 0)
//            cout<<"gelenin datasi BOS :("<<endl;
//        else
//            cout<<"gelenin DATASI: "<<treeNode->getData()<<endl;
//    else
//        cout<<"treeNode BOS GELDi"<<endl;



    if(treeNode == 0)
    {
        treeNode = new TreeNode();
        treeNode->setData(data);
        return;
    }


    int cmpResult = strcmp(treeNode->getData(), data);

    if(cmpResult == 0)
        return;
    else if(strcmp(treeNode->getData(), data) > 0)
    {
        if(treeNode->getLeft() != 0)
            addDataToTree(treeNode->getLeft(), data);
        else
        {
            TreeNode* node = new TreeNode(data);
            treeNode->setLeft(node);
        }
    }
    else
    {
        if(treeNode->getRight() != 0)
            addDataToTree(treeNode->getRight(), data);
        else
        {
            TreeNode* node = new TreeNode(data);
            treeNode->setRight(node);
        }
    }
}

void printPreOrder(TreeNode* treeNode)
{
    if(treeNode == 0)
        return;
    cout<<"word="<<treeNode->getData()<<endl;
    printPreOrder(treeNode->getLeft());
    printPreOrder(treeNode->getRight());
}

void printInOrder(TreeNode* treeNode)
{
    if(treeNode == 0)
        return;
    printInOrder(treeNode->getLeft());
    cout<<"word="<<treeNode->getData()<<endl;
    printInOrder(treeNode->getRight());
}

void printPostOrder(TreeNode* treeNode)
{
    if(treeNode == 0)
        return;
    printPostOrder(treeNode->getLeft());
    printPostOrder(treeNode->getRight());
    cout<<"word="<<treeNode->getData()<<endl;
}
