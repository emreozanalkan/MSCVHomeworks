#ifndef TREENODE_H
#define TREENODE_H

class TreeNode
{
private:
    char* _data;          // The data in this node
    TreeNode* _left;    // Pointer to the left subtree
    TreeNode* _right;   // Pointer to the right subtree
public:
    TreeNode();
    TreeNode(char*);

    void setData(char*);
    void setLeft(TreeNode*);
    void setRight(TreeNode*);

    char* getData();
    TreeNode* getLeft();
    TreeNode* getRight();

    //void addDataToTree(char*);
};

#endif // TREENODE_H
