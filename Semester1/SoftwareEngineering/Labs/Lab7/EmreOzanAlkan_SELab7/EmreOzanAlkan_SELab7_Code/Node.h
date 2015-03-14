#ifndef NODE_H
#define NODE_H

class Node
{
private:
    char* _data;        // The data in this node
    Node* _leftNode;    // Pointer to the left node
    Node* _rightNode;   // Pointer to the right node
public:
    Node();
    Node(char*);
    ~Node();

    void setData(char*);        // _data setter
    void setLeftNode(Node*);    // _left setter
    void setRightNode(Node*);   // _right setter

    char* getData() const;          // _data getter
    Node* getLeftNode() const;      // _left getter
    Node* getRightNode() const;     // _right getter

    void insertData(char* data);    // Inserts data to the tree

    void printPreOrder() const;   // Prints the tree Pre-Order
    void printPostOrder() const;  // Prints the tree Post-Order
    void printInOrder() const;    // Prints the tree In-Order
};

#endif // NODE_H
