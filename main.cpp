#include <iostream>
#include <cstdio>
#include "tree_node.h"
#include "parse_tree.h"

extern "C" int yyparse();
extern "C" FILE* yyin;

int main() {
    yyin = fopen("Examples/ex1.tb", "r");
    if (!yyin) {
        std::cerr << "Error opening input file.\n";
        return 1;
    }

    ParseTree parse_tree;

    yyparse(); // This will parse the input file and trigger the parsing logic defined in Yacc

    parse_tree.buildTree();
    parse_tree.printTree(); // Print the tree in the desired format

    fclose(yyin);

    return 0;
}