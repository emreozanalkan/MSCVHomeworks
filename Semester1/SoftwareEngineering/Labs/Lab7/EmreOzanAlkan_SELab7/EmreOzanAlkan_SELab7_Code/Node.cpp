#include "Node.h"

#include <iostream>

using namespace std;

Node::Node()
{
    this->_data = 0;
    this->_leftNode = 0;
    this->_rightNode = 0;
}

Node::Node(char* data)
{
    this->_data = data;
    this->_leftNode = 0;
    this->_rightNode = 0;
}

Node::~Node()
{
    cout<<"Destructor with word= "<<this->_data<<" is called."<<endl;

    delete [] this->_data;
    delete this->_leftNode;
    delete this->_rightNode;

    this->_data = 0;
    this->_leftNode = 0;
    this->_rightNode = 0;
}

// Setter method for data
void Node::setData(char* data)
{
    this->_data = data;
}

// Setter method for Left Node in our dictionary binary tree
void Node::setLeftNode(Node* leftNode)
{
    this->_leftNode = leftNode;
}

// Setter method for Right Node in our dictionary binary tree
void Node::setRightNode(Node* rightNode)
{
    this->_rightNode = rightNode;
}

// Getter method for data
char* Node::getData() const
{
    return this->_data;
}

// Getter method for Left Node in our dictionary binary tree
Node* Node::getLeftNode() const
{
    return this->_leftNode;
}

// Getter method for Right Node in our dictionary binary tree
Node* Node::getRightNode() const
{
    return this->_rightNode;
}

// Getting word as char array, and inserting it to correct poisition in tree.
// If it's data is empty, stores in it self, otherwise compare with its data
// to check lexical order, leaxically smaller word tend to go left, others
// inserted to right in binary data structure context.
void Node::insertData(char* data)
{
    if(this->_data == 0)
    {
        this->_data = data;
        return;
    }

    int compareResult = strcmp(this->_data, data);

    if(compareResult == 0)
        return;
    else if(compareResult > 0)
    {
        if(this->_leftNode == 0)
        {
            Node* leftNode = new Node(data);
            this->setLeftNode(leftNode);
        }
        else
            this->_leftNode->insertData(data);

    }
    else
    {
        if(this->_rightNode == 0)
        {
            Node* rightNode = new Node(data);
            this->setRightNode(rightNode);
        }
        else
            this->_rightNode->insertData(data);
    }
}

// The Pre-Order traversal: at each node the root is evaluated first
// then the left sub tree, the the right subtree.
void Node::printPreOrder() const
{
    if(this->_data != 0)
        cout<<"word="<<this->_data<<endl;

    if(this->_leftNode != 0)
        this->_leftNode->printPreOrder();

    if(this->_rightNode != 0)
        this->_rightNode->printPreOrder();
}

// The Post-Order traversal: the left subtree first
// then the right subtree, then the root
void Node::printPostOrder() const
{
    if(this->_leftNode != 0)
        this->_leftNode->printPostOrder();

    if(this->_rightNode != 0)
        this->_rightNode->printPostOrder();

    if(this->_data != 0)
        cout<<"word="<<this->_data<<endl;
}

// The In Order traversal: left, root, then right nodes evaluated.
void Node::printInOrder() const
{
    if(this->_leftNode != 0)
        this->_leftNode->printInOrder();

    if(this->_data != 0)
        cout<<"word="<<this->_data<<endl;

    if(this->_rightNode != 0)
        this->_rightNode->printInOrder();
}
