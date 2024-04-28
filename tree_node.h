#ifndef TREE_NODE_H
#define TREE_NODE_H

#include <iostream>
#include <string>
#include <vector>

class TreeNode {
private:
    std::string name;
    int weight;
    std::string isachildof;
    std::vector<TreeNode*> children;

public:
    TreeNode(const std::string& n, const std::string& ia, int w) : name(n), isachildof(ia), weight(w) {}

    const std::string& getName() const { return name; }
    int getWeight() const { return weight; }
    const std::string& getIsAChildOf() const { return isachildof; }
    const std::vector<TreeNode*>& getChildren() const { return children; }

    void addChild(TreeNode* child) { children.push_back(child); }

    void print(std::ostream& os, int depth = 0) const {
        os << std::string(depth, ' ') << "<" << name << "," << weight << ">";
        if (!children.empty()) {
            os << ",";
            for (const auto& child : children) {
                os << "(";
                child->print(os, depth + 1);
                os << ")";
            }
        }
    }
};

#endif // TREE_NODE_H