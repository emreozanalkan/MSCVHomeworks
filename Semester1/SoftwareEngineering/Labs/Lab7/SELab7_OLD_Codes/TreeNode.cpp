#include <iostream>

#include "TreeNode.h"

using namespace std;

TreeNode::TreeNode()
{
    this->_data = 0;
    this->_left = 0;
    this->_right = 0;
}

TreeNode::TreeNode(char* data)
{
    this->_data = data;
    this->_left = 0;
    this->_right = 0;
}

void TreeNode::setData(char* data)
{
    this->_data = data;
}

void TreeNode::setLeft(TreeNode* left)
{
    this->_left = left;
}

void TreeNode::setRight(TreeNode* right)
{
    this->_right = right;
}

char* TreeNode::getData()
{
    return this->_data;
}

TreeNode* TreeNode::getLeft()
{
    return this->_left;
}

TreeNode* TreeNode::getRight()
{
    return this->_right;
}

//void TreeNode::addDataToTree(char* data)
//{
//    if(this->_data == 0)
//        this->_data = data;
//    else
//    {
//        if(strcmp(this->_data, data) > 0)
//            this->getLeft()->addDataToTree(data);
//        else
//            this->getRight()->addDataToTree(data);
//    }
//}
