#ifndef PARSE_TREE_H
#define PARSE_TREE_H

#include "tree_node.h"
#include <unordered_map>

class ParseTree {
private:
    TreeNode* root;
    std::unordered_map<std::string, TreeNode*> nodeMap;

public:
    ParseTree() : root(nullptr) {}

    void addNode(TreeNode* node) {
        if (!root) {
            root = node; // Set root if it's the first node
        }
        nodeMap[node->getName()] = node; // Store node in the map
    }

    TreeNode* findNodeByIdentifier(const std::string& identifier) const {
        auto it = nodeMap.find(identifier);
        if (it != nodeMap.end()) {
            return it->second;
        }
        return nullptr; // Node not found
    }

    void ParseTree::buildTree() {
    // Iterate through each node in the map
    for (const auto& entry : nodeMap) {
        TreeNode* node = entry.second;

        // Check if the node has an isachildof attribute
        if (!node->getIsAChildOf().empty()) {
            std::string parentIdentifier = node->getIsAChildOf();

            // Find the parent node in the map
            TreeNode* parent = findNodeByIdentifier(parentIdentifier);

            // If parent node is found, add the current node as its child
            if (parent) {
                parent->addChild(node);
            } else {
                std::cerr << "Error: Parent node '" << parentIdentifier << "' not found for node '" << node->getName() << "'.\n";
            }
        }
    }
}

    void printTree() const {
        if (root) {
            root->print(std::cout);
            std::cout << std::endl;
        }
    }
};

#endif 